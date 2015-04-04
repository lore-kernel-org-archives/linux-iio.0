Return-Path: <sebastian.hesselbarth@gmail.com>
Message-ID: <551FBC34.4070501@gmail.com>
Date: Sat, 04 Apr 2015 12:25:56 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Antoine Tenart <antoine.tenart@free-electrons.com>, jic23@kernel.org,
 knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
CC: zmxu@marvell.com, jszhang@marvell.com, yrliao@marvell.com,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ARM: berlin: add an ADC node for the BG2Q
References: <1428066409-30392-1-git-send-email-antoine.tenart@free-electrons.com> <1428066409-30392-4-git-send-email-antoine.tenart@free-electrons.com>
In-Reply-To: <1428066409-30392-4-git-send-email-antoine.tenart@free-electrons.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 03.04.2015 15:06, Antoine Tenart wrote:
> This patch adds the ADC node for the Berlin BG2Q, using the newly added
> Berlin IIO ADC driver.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 187d056f7ad2..72b1c969a99d 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -565,6 +565,14 @@
>   						function = "twsi3";
>   					};
>   				};
> +
> +				adc: adc {
> +					compatible = "marvell,berlin2-adc";
> +					interrupt-parent = <&sic>;
> +					interrupts = <12>, <14>;
> +					interrupt-names = "adc", "tsen";
> +					status = "disabled";
> +				};

Antoine,

nit: there is no gated clock for the ADC, I guess we can just always
enable it. That will save you the last patch of the series.

BTW, I have the strong feeling that moving berlin's clk drivers to
regmap will block any subsequent patches you are preparing. How about
we target the next merge window for moving the clk node but not the
drivers (except of_iomap of the _parent's_ reg property) and push the
less controversal patches (pinctrl, reset) with regmap/syscon forward?

Sebastian

>   			};
>
>   			sic: interrupt-controller@e000 {
>
