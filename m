Return-Path: <SRS0=+b3V=ES=linaro.org=lee.jones@kernel.org>
Date: Tue, 23 Jan 2018 09:53:05 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
	sre@kernel.org, linux@armlinux.org.uk,
	maxime.ripard@free-electrons.com, linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com, linux-sunxi@googlegroups.com,
	julian.calaby@gmail.com
Subject: Re: [PATCH v3 09/16] mfd: axp20x: probe axp20x_adc driver for AXP813
Message-ID: <20180123095305.lgxpq5gyzlo5cked@dell>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
 <d5792ed6e1e989dde3c9ecdd018286109dfc101d.1516012352.git-series.quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <d5792ed6e1e989dde3c9ecdd018286109dfc101d.1516012352.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, 15 Jan 2018, Quentin Schulz wrote:

> This makes the axp20x_adc driver probe with platform device id
> "axp813-adc".
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
