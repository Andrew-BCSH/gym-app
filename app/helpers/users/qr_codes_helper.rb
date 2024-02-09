module Users::QrCodesHelper

  def generate_qr(params)

    qrcode = RQRCode::QRCode.new(
      "https://mejirogymbali.abcsh.me/admins/qr_code_information?user_id=#{params[:user_id]}",
      size: 10
    )

    svg = qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 11,
      standalone: true,
      use_path: true
    )
    svg
  end
end
