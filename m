Return-Path: <SRS0=nZls=ES=gmail.com=wens213@kernel.org>
MIME-Version: 1.0
In-Reply-To: <9c045de8dcee9a71803978855762e272efdc41d3.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
 <9c045de8dcee9a71803978855762e272efdc41d3.1516012352.git-series.quentin.schulz@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 23 Jan 2018 23:50:58 +0800
Message-ID: <CAGb2v64UCOWccggsVyHSfngYYcMjSUUEP-7s5qkSRZie-hGBAA@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] ARM: dtsi: axp81x: add battery power supply subnode
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
> The X-Powers AXP81X PMIC exposes battery supply various data such as
> the battery status (charging, discharging, full, dead), current max
> limit, current current, battery capacity (in percentage), voltage max
> and min limits, current voltage, and battery capacity (in Ah).
>
> This adds the battery power supply subnode for AXP81X PMIC.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
