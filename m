Return-Path: <SRS0=KlWK=5X=gmail.com=robherring2@kernel.org>
Date: Sun, 18 Jun 2017 09:05:11 -0500
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: jic23@kernel.org, pmeerw@pmeerw.net, william.markezana@meas-spec.com,
	ludovic.tancerel@maplehightech.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, nicolas.dechesne@linaro.org,
	amit.kucheria@linaro.org
Subject: Re: [PATCH 2/4] dt-bindings: iio: humidity: Add bindings for HTU21
 and MS8607 sensors
Message-ID: <20170618140511.kz6nvttypockcrfm@rob-hp-laptop>
References: <1497374443-20935-1-git-send-email-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497374443-20935-1-git-send-email-manivannan.sadhasivam@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jun 13, 2017 at 10:50:43PM +0530, Manivannan Sadhasivam wrote:
> Add device tree bindings for Measurement-Specialties HTU21 temperature & humidity sensor and humidity part of MS8607 sensor
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/humidity/htu21.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/htu21.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/humidity/htu21.txt b/Documentation/devicetree/bindings/iio/humidity/htu21.txt
> new file mode 100644
> index 0000000..97d7963
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/humidity/htu21.txt
> @@ -0,0 +1,13 @@
> +*HTU21 - Measurement-Specialties htu21 temperature & humidity sensor and humidity part of MS8607 sensor

The binding should be for the device, not part of it. You should bind 
to a driver for MS8607 and then create 2 child devices for the humidity 
and temp sensors.

Rob
