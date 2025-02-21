require "rails_helper"

RSpec.describe ProjectsController, type: :request do
  let!(:project) { create(:project) }

  describe "GET /index" do
    it "returns a successful response" do
      get projects_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns a successful response" do
      get new_project_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new project" do
      expect {
        post projects_url, params: { project: attributes_for(:project) }
      }.to change(Project, :count).by(1)

      expect(response).to redirect_to(project_url(Project.last))
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
    it "updates the project and redirects" do
      patch project_url(project), params: { project: attributes_for(:project) }
      expect(response).to redirect_to(project_url(project))
    end
  end

  describe "DELETE /destroy" do
    it "destroys the project and redirects" do
      expect {
        delete project_url(project)
      }.to change(Project, :count).by(-1)

      expect(response).to redirect_to(projects_url)
    end
  end
end
