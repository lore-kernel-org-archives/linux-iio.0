Return-Path: <SRS0=s1Yq=YK=linaro.org=bjorn.andersson@kernel.org>
Date: Mon, 26 Dec 2016 21:58:29 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	"Ivan T . Ivanov" <iivanov.xz@gmail.com>,
	Andy Gross <andy.gross@linaro.org>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/3 v2] iio: adc: add device tree bindings for Qualcomm
 PM8xxx ADCs
Message-ID: <20161227055829.GB10531@minitux>
References: <1481842089-13999-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481842089-13999-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

On Thu 15 Dec 14:48 PST 2016, Linus Walleij wrote:

Sorry for taking so long time to give this a test.

> ---
>  .../bindings/iio/adc/qcom,pm8xxx-xoadc.txt         | 160 +++++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
[..]
> +
> +- reg: should contain the ADC base address in the PMIC, typically
> +  0x197.

xoadc-ref is "required" by the code (setting 2.2V on the dummy regulator
returned in its absence will fail), so it should be mentioned here.

On 8064 pm8921_l14 seems to be our reference, which is 1.8V.

[..]
> +
> +- qcom,ratiometric:
> +  Value type: <empty>
> +  Definition: Channel calibration type. If this property is specified
> +          VADC will use the VDD reference (1.8V) and GND for channel
> +          calibration. If the property is not found, the channel will be
> +          calibrated with the 0.625V and 1.25V reference channels, also
> +          known as an absolute calibration.

So if I specify this property the reference should be 1.8V and if I
specify qcom,ratiometric-ref I will override this? Also, the
implementation requires that qcom,ratiometric-ref is specified if the
boolean property is used.

Am I missing something or should we just squash them?

> +
> +- qcom,ratiometric-ref:
> +  Value type: <u32>
> +  Definition: The reference voltage pair when using ratiometric
> +          calibration:
> +	  0 = XO_IN/XOADC_GND
> +	  1 = PMIC_IN/XOADC_GND
> +	  2 = PMIC_IN/BMS_CSP
> +	  3 (invalid)
> +	  4 = XOADC_GND/XOADC_GND
> +	  5 = XOADC_VREF/XOADC_GND
> +
> +Example:
> +
> +xoadc: xoadc@197 {
> +	compatible = "qcom,pm8058-adc";
> +	reg = <0x197>;
> +	interrupt-parent = <&pm8058>;
> +	interrupts = <76 1>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	#io-channel-cells = <1>;

xoadc-ref-supply = <>;

> +
> +	vcoin {

As the node has a "reg" you need to add @0 on these.

> +		reg = <0x00>;
> +	};

Regards,
Bjorn
