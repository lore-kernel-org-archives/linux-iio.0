Return-Path: <SRS0=OHPJ=EE=gmail.com=julian.calaby@kernel.org>
MIME-Version: 1.0
In-Reply-To: <a1c061eb50edfd3519ece6c8177085b55d7aefc6.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
 <a1c061eb50edfd3519ece6c8177085b55d7aefc6.1515486346.git-series.quentin.schulz@free-electrons.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 9 Jan 2018 23:53:55 +1100
Message-ID: <CAGRGNgVfok-UrKFNtkq1QteJqUphFBRH_U+nJcy=dPkzN6W08g@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 13/16] power: supply: axp20x_battery: add
 support for AXP813
To: quentin.schulz@free-electrons.com
Cc: jic23@kernel.org, knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>, pmeerw@pmeerw.net,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
	sre@kernel.org, Russell King <linux@armlinux.org.uk>,
	Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>,
	linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>, thomas.petazzoni@free-electrons.com,
	linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Quentin,

On Tue, Jan 9, 2018 at 8:33 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The X-Powers AXP813 PMIC has got some slight differences from
> AXP20X/AXP22X PMICs:
>  - the maximum voltage supplied by the PMIC is 4.35 instead of 4.36/4.24
>  for AXP20X/AXP22X,
>  - the constant charge current formula is different,
>
> It also has a bit to tell whether the battery percentage returned by the
> PMIC is valid.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/power/supply/axp20x_battery.c | 42 ++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+)
>
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> index d73c78f..dad72a5 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -46,6 +46,8 @@
>  #define AXP20X_CHRG_CTRL1_TGT_4_2V     (2 << 5)
>  #define AXP20X_CHRG_CTRL1_TGT_4_36V    (3 << 5)
>
> +#define AXP813_CHRG_CTRL1_TGT_4_35V    (3 << 5)
> +
>  #define AXP22X_CHRG_CTRL1_TGT_4_22V    (1 << 5)
>  #define AXP22X_CHRG_CTRL1_TGT_4_24V    (3 << 5)

Should these be "alphabetical", i.e. AXP20X, AXP22X, AXP813?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
