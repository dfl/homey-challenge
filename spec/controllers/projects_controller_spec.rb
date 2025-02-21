require "rails_helper"

RSpec.describe ProjectsController, type: :request do
  let(:user) { create(:user) }
  let(:session) { create(:session, user: user) }
  let!(:project) { create(:project) }

  before do
    sign_in_as(user)
  end

  describe "GET /index" do
    it "returns a successful response" do
      get projects_url
      expect(response).to have_http_status(:success)
    end

    it "lists all projects" do
      create_list(:project, 3)
      get projects_url
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
    context "with valid parameters" do
      let(:valid_attributes) { attributes_for(:project) }

      it "creates a new project" do
        expect {
          post projects_url, params: { project: valid_attributes }
        }.to change(Project, :count).by(1)

        expect(response).to redirect_to(project_url(Project.last))
        follow_redirect!
        expect(response.body).to include(valid_attributes[:name])
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { name: "" } }

      it "does not create a new project" do
        expect {
          post projects_url, params: { project: invalid_attributes }
        }.not_to change(Project, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /show" do
    it "returns a successful response" do
      get project_url(project)
      expect(response).to have_http_status(:success)
    end

    it "displays project details" do
      get project_url(project)
      expect(response.body).to include(project.name)
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
    context "with valid parameters" do
      let(:new_attributes) { { name: "Updated Project", status: "active" } }

      it "updates the project" do
        patch project_url(project), params: { project: new_attributes }
        project.reload

        expect(project.name).to eq("Updated Project")
        expect(project.status).to eq("active")
        expect(response).to redirect_to(project_url(project))
      end

      it "creates a status change record" do
        expect {
          patch project_url(project), params: { project: new_attributes }
        }.to change(ProjectStatusChange, :count).by(1)

        status_change = ProjectStatusChange.last
        expect(status_change.from_status).to eq("pending")
        expect(status_change.to_status).to eq("active")
        expect(status_change.user).to eq(user)
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { name: "" } }

      it "does not update the project" do
        original_name = project.name
        patch project_url(project), params: { project: invalid_attributes }
        project.reload

        expect(project.name).to eq(original_name)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the project" do
      expect {
        delete project_url(project)
      }.to change(Project, :count).by(-1)

      expect(response).to redirect_to(projects_url)
    end

    it "destroys associated status changes" do
      create(:project_status_change, project: project)
      
      expect {
        delete project_url(project)
      }.to change(ProjectStatusChange, :count).by(-1)
    end
  end
end
