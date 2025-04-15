class SchedulesController < ApplicationController
  def create
    schedule_params = params.require(:schedule).permit(:child_id, :activity_name, :starting_date, :ending_date, :photo, :route)

    # Gestion de l'upload de la photo via Cloudinary
    if schedule_params[:photo].present?
      uploaded_photo = Cloudinary::Uploader.upload(schedule_params[:photo].path)
      cloudinary_id = uploaded_photo["public_id"]
    end

    # Logique pour sauvegarder l'emploi du temps
    @schedule = Schedule.new(
      child_id: schedule_params[:child_id],
      activity_name: schedule_params[:activity_name],
      starting_date: schedule_params[:starting_date],
      ending_date: schedule_params[:ending_date],
      photo: cloudinary_id,
      route: schedule_params[:route]
    )

    if @schedule.save
      redirect_to relative_dashboard_path, notice: "Emploi du temps créé avec succès !"
    else
      redirect_to relative_dashboard_path, alert: "Erreur lors de la création de l'emploi du temps."
    end
  end
end
