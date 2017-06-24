Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbdFXUx2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jun 2017 16:53:28 -0400
Date: Sat, 24 Jun 2017 21:53:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: pmeerw@pmeerw.net, robh+dt@kernel.org,
        william.markezana@meas-spec.com,
        ludovic.tancerel@maplehightech.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, nicolas.dechesne@linaro.org,
        amit.kucheria@linaro.org
Subject: Re: [PATCH 4/4] dt-bindings: iio: pressure: Add bindings for
 MS5637, MS5805, MS5837 and MS8607 sensors
Message-ID: <20170624215323.2062b2fa@kernel.org>
In-Reply-To: <1497374492-21040-1-git-send-email-manivannan.sadhasivam@linaro.org>
References: <1497374492-21040-1-git-send-email-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 13 Jun 2017 22:51:32 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> Add device tree bindings for Measurement-Specialties MS5637, MS5805, MS5837 and MS8607 pressure & temperature sensor
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Applied to the togreg branch of iio.git with some white space cleanup at the end
of the file.

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/pressure/ms5637.txt        | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5637.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/ms5637.txt b/Documentation/devicetree/bindings/iio/pressure/ms5637.txt
> new file mode 100644
> index 0000000..c0f3f8b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/ms5637.txt
> @@ -0,0 +1,18 @@
> +* MS5637 - Measurement-Specialties MS5637, MS5805, MS5837 and MS8607 pressure & temperature sensor
> +
> +Required properties:
> +
> +	-compatible: should be one of the following
> +		meas,ms5637
> +		meas,ms5805
> +		meas,ms5837
> +		meas,ms8607-temppressure
> +	-reg: I2C address of the sensor
> +
> +Example:
> +
> +ms5637@76 {
> +	compatible = "meas,ms5637";
> +	reg = <0x76>;
> +};
> +	

