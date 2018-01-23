Return-Path: <SRS0=nZls=ES=gmail.com=wens213@kernel.org>
MIME-Version: 1.0
In-Reply-To: <ea299dca30bb3d0413d35717522643b5a00e731c.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
 <ea299dca30bb3d0413d35717522643b5a00e731c.1516012352.git-series.quentin.schulz@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 23 Jan 2018 23:33:07 +0800
Message-ID: <CAGb2v65pjtL+2fu5XQG+hs65=0p05WRJ62gF74O07SsZuVuaSg@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] ARM: dtsi: axp209: add node for ADC
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
> This adds a DT node for the ADC of the PMIC so that there can be
> consumers of its IIO channels declaring their consumptions via DT.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
