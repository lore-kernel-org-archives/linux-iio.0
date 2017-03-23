Return-Path: <SRS0=EWyR=3A=gmail.com=geert.uytterhoeven@kernel.org>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1490272873-2532-5-git-send-email-jacopo+renesas@jmondi.org>
References: <1490272873-2532-1-git-send-email-jacopo+renesas@jmondi.org> <1490272873-2532-5-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Mar 2017 13:50:39 +0100
Message-ID: <CAMuHMdWtHd7LwP_ChGj4BR6Hmq20hik+yrkhAJfRh0G-auiDQg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: salvator-x: Add current sense amplifiers
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jacopo,

On Thu, Mar 23, 2017 at 1:41 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add device nodes for two Maxim max961x current sense amplifiers
> sensing VDD_08 and DVFS_08 lines.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> index fd05c2b..ef8b723 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> @@ -261,6 +261,24 @@
>         status = "okay";
>  };
>
> +&i2c4 {
> +       status = "okay";
> +
> +       csa_vdd: max9611_vdd@7c {

csa_vdd: adc@7c {

Node names should be generic, i.e. "adc" instead of "max9611_vdd"
(also in the DT binding example).

> +               compatible = "maxim,max9611";
> +               reg = <0x7c>;
> +
> +               maxim,shunt-resistor-uohm = <5000>;
> +       };
> +
> +       csa_dvfs: max9611_dvfs@7f {

csa_dvfs: adc@7f {

> +               compatible = "maxim,max9611";
> +               reg = <0x7f>;
> +
> +               maxim,shunt-resistor-uohm = <5000>;
> +       };
> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
