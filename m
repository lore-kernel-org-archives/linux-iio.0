Return-Path: <SRS0=PJWa=NZ=linaro.org=andy.gross@kernel.org>
Date: Wed, 14 Nov 2018 10:20:37 -0800
From: Andy Gross <andy.gross@linaro.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 0/2] arm64: dts: qcom: pm8998: Add die temperature
 channel node to the ADC
Message-ID: <20181114182037.GF14703@hector>
References: <20181112221126.27142-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181112221126.27142-1-mka@chromium.org>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Nov 12, 2018 at 02:11:24PM -0800, Matthias Kaehlcke wrote:
> This series adds a channel for the die temperature to the QCOM SPMI
> PMIC5 ADC. It also fixes an example in the DT documentation.
> 
> Matthias Kaehlcke (2):
>   dt-bindings: iio: vadc: Add unit address to ADC channel node in
>     example
>   arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC
> 

I queued both of these.  Thanks for updating these.

Andy
