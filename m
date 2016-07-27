Return-Path: <dianders@google.com>
MIME-Version: 1.0
Sender: dianders@google.com
In-Reply-To: <1469535195-5227-2-git-send-email-wxt@rock-chips.com>
References: <1469535195-5227-1-git-send-email-wxt@rock-chips.com> <1469535195-5227-2-git-send-email-wxt@rock-chips.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 26 Jul 2016 21:07:59 -0700
Message-ID: <CAD=FV=W=rNP2h_8Z1TGK0A_KEhL19TKtWz-u0-_ZGH8jF5Zn9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: rockchip: add the saradc for rk3399
To: Caesar Wang <wxt@rock-chips.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
	linux-iio <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, john@metanate.com,
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi,


On Tue, Jul 26, 2016 at 5:13 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> This patch adds saradc needed information on rk3399 SoCs.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
>
> Changes in v2: None
>
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 4c84229..b81f84b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -299,6 +299,18 @@
>                 };
>         };
>
> +       saradc: saradc@ff100000 {
> +               compatible = "rockchip,rk3399-saradc";
> +               reg = <0x0 0xff100000 0x0 0x100>;
> +               interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +               #io-channel-cells = <1>;
> +               clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
> +               clock-names = "saradc", "apb_pclk";
> +               resets = <&cru SRST_P_SARADC>;
> +               reset-names = "saradc-apb";
> +               status = "disabled";
> +       };
> +

Seems reasonable to me.  I'll let Heiko comment if he cares about the
sort ordering.  I can never quite figure out what it should be so I've
sorta given up on it...  ;)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
