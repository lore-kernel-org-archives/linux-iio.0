Return-Path: <SRS0=GcUj=DB=linaro.org=lee.jones@kernel.org>
Date: Tue, 5 Dec 2017 08:24:14 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
	linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
	jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	icenowy@aosc.io, linux-sunxi@googlegroups.com,
	thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH 6/8] mfd: axp20x: add battery power supply cell for AXP813
Message-ID: <20171205082414.ayv5s4ehafwy5xfa@dell>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
 <9b5e9ed623165d0586f086343a7c67bc5c18bbb5.1512396054.git-series.quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9b5e9ed623165d0586f086343a7c67bc5c18bbb5.1512396054.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, 04 Dec 2017, Quentin Schulz wrote:

> As axp20x-battery-power-supply now supports AXP813, add a cell for it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 3 +++
>  1 file changed, 3 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
