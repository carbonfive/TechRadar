defmodule TechRadar.SurveysTest do
  use TechRadar.DataCase

  alias TechRadar.Surveys

  describe "survey_responses" do
    alias TechRadar.Surveys.SurveyResponse

    @valid_attrs %{
      answers: %{"some answers" => 2},
      radar_guid: "7488a646-e31f-11e4-aace-600308960662"
    }
    @update_attrs %{
      answers: %{"some answers" => 3},
      radar_guid: "7488a646-e31f-11e4-aace-600308960668"
    }
    @invalid_attrs %{answers: nil, radar_guid: nil}

    def survey_response_fixture(attrs \\ %{}) do
      {:ok, survey_response} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Surveys.create_survey_response()

      survey_response
    end

    test "get_survey_response!/1 returns the survey_response with given id" do
      survey_response = survey_response_fixture()
      assert Surveys.get_survey_response!(survey_response.id) == survey_response
    end

    test "create_survey_response/1 with valid data creates a survey_response" do
      assert {:ok, %SurveyResponse{} = survey_response} =
               Surveys.create_survey_response(@valid_attrs)

      assert survey_response.answers == %{"some answers" => 2}
      assert survey_response.radar_guid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_survey_response/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Surveys.create_survey_response(@invalid_attrs)
    end

    test "update_survey_response/2 with valid data updates the survey_response" do
      survey_response = survey_response_fixture()

      assert {:ok, survey_response} =
               Surveys.update_survey_response(survey_response, @update_attrs)

      assert %SurveyResponse{} = survey_response
      assert survey_response.answers == %{"some answers" => 3}
      assert survey_response.radar_guid == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_survey_response/2 with invalid data returns error changeset" do
      survey_response = survey_response_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Surveys.update_survey_response(survey_response, @invalid_attrs)

      assert survey_response == Surveys.get_survey_response!(survey_response.id)
    end

    test "delete_survey_response/1 deletes the survey_response" do
      survey_response = survey_response_fixture()
      assert {:ok, %SurveyResponse{}} = Surveys.delete_survey_response(survey_response)
      assert_raise Ecto.NoResultsError, fn -> Surveys.get_survey_response!(survey_response.id) end
    end

    test "change_survey_response/1 returns a survey_response changeset" do
      survey_response = survey_response_fixture()
      assert %Ecto.Changeset{} = Surveys.change_survey_response(survey_response)
    end
  end
end
