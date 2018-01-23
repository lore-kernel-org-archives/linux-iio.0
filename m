Return-Path: <SRS0=nZls=ES=gmail.com=wens213@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180123095305.lgxpq5gyzlo5cked@dell>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
 <d5792ed6e1e989dde3c9ecdd018286109dfc101d.1516012352.git-series.quentin.schulz@free-electrons.com>
 <20180123095305.lgxpq5gyzlo5cked@dell>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 23 Jan 2018 23:32:46 +0800
Message-ID: <CAGb2v67gba1i=g3t7sTscOp690xLMceiGNed_60f6FRORk9MQw@mail.gmail.com>
Subject: Re: [PATCH v3 09/16] mfd: axp20x: probe axp20x_adc driver for AXP813
To: Lee Jones <lee.jones@linaro.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-iio@vger.kernel.org, "open list:THERMAL" <linux-pm@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-sunxi <linux-sunxi@googlegroups.com>, Julian Calaby <julian.calaby@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jan 23, 2018 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 15 Jan 2018, Quentin Schulz wrote:
>
>> This makes the axp20x_adc driver probe with platform device id
>> "axp813-adc".
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>  drivers/mfd/axp20x.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
