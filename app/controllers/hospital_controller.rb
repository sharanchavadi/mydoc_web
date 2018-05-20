class HospitalController < ApplicationController


    def home
        @doctors = get_data("doctors")
        @patients = get_data("patients")
        @appointments = get_data("appointments")
    end

    def create_patient
        post_data("patients", patient_params)
        redirect_to '/hospital/home'
    end

    def create_doctor
        post_data("doctors", doctor_params)
        redirect_to '/hospital/home'
    end

    def create_appointment
        post_data("appointments", appointment_params)
        redirect_to '/hospital/home'
    end

    private

    def get_data(path)
        url = API_URL + path
        response = HTTParty.get(url)
        JSON.parse(response.body)
    end

    def post_data(path, params)
        url = API_URL + path
        HTTParty.post(url, body: params)
    end

    def patient_params
        params.permit(:name, :phone_number)
    end

    def doctor_params
        params.permit(:name, :phone_number, :specialization)
    end

    def appointment_params
        params.permit(:doctor_id, :patient_id, :diseases)
    end

end