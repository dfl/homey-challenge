require "rails_helper"

RSpec.describe Project::CommentsController, type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:session) { create(:session, user: user) }

  context "when user is not authenticated" do
    it "redirects to sign in" do
      post project_comments_url(project), params: { project_comment: { body: "Test" } }
      expect(response).to redirect_to("/sign_in")
    end
  end

  context "when user is authenticated" do
    before do
      sign_in_as(user)
    end

    describe "POST /create" do
      let(:action) { -> { post project_comments_url(project), params: { project_comment: attributes } } }

      context "with valid parameters" do
        let(:attributes) { { body: "Test comment" } }

        it "creates a new comment" do
          expect { action.call }.to change(Project::Comment, :count).by(1)

          expect(response).to redirect_to(project_url(project))
          follow_redirect!
          expect(flash[:notice]).to eq("Comment was successfully added.")
        end

        it "assigns the current user to the comment" do
          action.call
          expect(Project::Comment.last.user).to eq(user)
        end
      end

      context "with invalid parameters" do
        let(:attributes) { { body: "" } }

        it "does not create a new comment" do
          expect { action.call }.not_to change(Project::Comment, :count)

          expect(response).to redirect_to(project_url(project))
          expect(flash[:alert]).to eq("Error adding comment.")
        end
      end
    end

    describe "DELETE /destroy" do
      let!(:comment) { create(:comment, project: project, user: user) }
      let(:action) { -> { delete project_comment_url(project, comment) } }

      it "destroys the comment" do
        expect { action.call }.to change(Project::Comment, :count).by(-1)

        expect(response).to redirect_to(project_url(project))
        expect(flash[:notice]).to eq("Comment was successfully removed.")
      end
    end
  end
end
