Return-Path: <SRS0=nZls=ES=gmail.com=wens213@kernel.org>
MIME-Version: 1.0
In-Reply-To: <42b2e555083abbab43e48362175dc9c2eeeedf3c.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
 <42b2e555083abbab43e48362175dc9c2eeeedf3c.1516012352.git-series.quentin.schulz@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 23 Jan 2018 23:47:44 +0800
Message-ID: <CAGb2v6419bjp2PX4Mn+ZNoy=1iOx+Z30672Jqs=geXVuihQkzQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 12/16] power: supply: axp20x_battery: add
 support for AXP813
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Maxime Ripard <maxime.ripard@free-electrons.com>,
	Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
	"open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-sunxi <linux-sunxi@googlegroups.com>, Julian Calaby <julian.calaby@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jan 15, 2018 at 6:33 PM, Quentin Schulz
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

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
