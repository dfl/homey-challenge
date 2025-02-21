require "rails_helper"

RSpec.describe ProjectsController, type: :request do
  let(:user) { create(:user) }
  let(:session) { create(:session, user: user) }
  let!(:project) { create(:project) }

  context "when user is not authenticated" do
    it "redirects to sign in" do
      get projects_url
      expect(response).to redirect_to("/sign_in")
    end
  end


  context "when user is authenticated" do
    before do
      sign_in_as(user)
    end

    describe "GET /index" do
      let(:action) { -> { get projects_url } }

      it "returns a successful response" do
        action.call
        expect(response).to have_http_status(:success)
      end

      it "lists all projects" do
        create_list(:project, 3)
        action.call
        expect(response.body).to include(project.name)
      end
    end

    describe "GET /new" do
      it "returns a successful response" do
        get new_project_url
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST /create" do
      let(:action) { -> { post projects_url, params: { project: attributes } } }

      context "with valid parameters" do
        let(:attributes) { attributes_for(:project) }

        it "creates a new project" do
          expect { action.call }.to change(Project, :count).by(1)

          expect(response).to redirect_to(project_url(Project.last))
          follow_redirect!
          expect(response.body).to include(attributes[:name])
        end
      end

      context "with invalid parameters" do
        let(:attributes) { { name: "" } }

        it "does not create a new project" do
          expect { action.call }.not_to change(Project, :count)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "GET /show" do
      let(:action) { -> { get project_url(project) } }
      before { action.call }

      it "returns a successful response" do
        expect(response).to have_http_status(:success)
      end

      it "displays project details" do
        expect(response.body).to include(CGI.escapeHTML(project.name))
        expect(response.body).to include(project.status.titleize)
      end
    end

    describe "GET /edit" do
      it "returns a successful response" do
        get edit_project_url(project)
        expect(response).to have_http_status(:success)
      end
    end

    describe "PATCH /update" do
      let(:action) { -> { patch project_url(project), params: { project: attributes } } }

      context "with valid parameters" do
        let(:attributes) { { name: "Updated Project", status: "active" } }

        it "updates the project" do
          action.call
          project.reload

          expect(project.name).to eq("Updated Project")
          expect(project.status).to eq("active")
          expect(response).to redirect_to(project_url(project))
        end

        it "creates a status change record" do
          expect {
            action.call
          }.to change(ProjectStatusChange, :count).by(1)

          status_change = ProjectStatusChange.last
          expect(status_change.from_status).to eq("pending")
          expect(status_change.to_status).to eq("active")
          expect(status_change.user).to eq(user)
        end
      end

      context "with invalid parameters" do
        let(:attributes) { { name: "" } }

        it "does not update the project" do
          original_name = project.name
          action.call
          project.reload

          expect(project.name).to eq(original_name)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe "DELETE /destroy" do
      let(:action) { -> { delete project_url(project) } }
      it "destroys the project" do
        expect { action.call }.to change(Project, :count).by(-1)

        expect(response).to redirect_to(projects_url)
      end

      it "destroys associated status changes" do
        create(:project_status_change, project: project)

        expect { action.call }.to change(ProjectStatusChange, :count).by(-1)
      end
    end
  end
end
