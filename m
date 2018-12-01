Return-Path: <SRS0=yvj8=OK=usp.br=matheus.bernardino@kernel.org>
MIME-Version: 1.0
References: <20181128175312.9634-1-matheus.bernardino@usp.br> <CAJKOXPeY7BENW=LdotGQtL25-7BZABZw=awnY5h2h52q+nN8+g@mail.gmail.com>
In-Reply-To: <CAJKOXPeY7BENW=LdotGQtL25-7BZABZw=awnY5h2h52q+nN8+g@mail.gmail.com>
From: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date: Sat, 1 Dec 2018 13:57:51 -0200
Message-ID: <CAHd-oW5wqfo8Nszp54X=ndxBQ6Kmbe+fk6Hk6GX6==Huerdwtw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Replace license text w/ SPDX identifier
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Eugen Hristev <eugen.hristev@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Support Opensource <support.opensource@diasemi.com>, Kukjin Kim <kgene@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, Milo Kim <milo.kim@ti.com>, Vladimir Zapolskiy <vz@mleia.com>,
	Sylvain Lemieux <slemieux.tyco@gmail.com>, Carlo Caione <carlo@caione.org>,
	Kevin Hilman <khilman@baylibre.com>, Heiko Stuebner <heiko@sntech.de>,
	William Breathitt Gray <vilhelm.gray@gmail.com>, Maxime Ripard <maxime.ripard@bootlin.com>,
	Michal Simek <michal.simek@xilinx.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
	kernel-usp@googlegroups.com, Lucas Santos <ilucas.ms@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Thu, Nov 29, 2018 at 5:37 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, 28 Nov 2018 at 18:53, Matheus Tavares <matheus.bernardino@usp.br> wrote:
> >
> > From: Lucas Santos <ilucas.ms@gmail.com>
> >
> > This patch removes all license boilerplate texts from the .c and .h
> > files at drivers/iio/adc/ and, instead, adds the proper SPDX license
> > identifiers.
> >
> > Signed-off-by: Lucas Santos <ilucas.ms@gmail.com>
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  drivers/iio/adc/ad7266.c             |  3 +--
> >  drivers/iio/adc/ad7291.c             |  3 +--
> >  drivers/iio/adc/ad7298.c             |  3 +--
> >  drivers/iio/adc/ad7766.c             |  3 +--
> >  drivers/iio/adc/ad7791.c             |  3 +--
> >  drivers/iio/adc/ad7793.c             |  3 +--
> >  drivers/iio/adc/ad7887.c             |  3 +--
> >  drivers/iio/adc/ad7923.c             |  3 +--
> >  drivers/iio/adc/ad799x.c             |  5 +----
> >  drivers/iio/adc/ad_sigma_delta.c     |  3 +--
> >  drivers/iio/adc/aspeed_adc.c         |  6 +-----
> >  drivers/iio/adc/at91-sama5d2_adc.c   | 10 +---------
> >  drivers/iio/adc/at91_adc.c           |  3 +--
> >  drivers/iio/adc/axp20x_adc.c         |  5 +----
> >  drivers/iio/adc/axp288_adc.c         | 13 +------------
> >  drivers/iio/adc/bcm_iproc_adc.c      | 13 +------------
> >  drivers/iio/adc/berlin2-adc.c        |  5 +----
> >  drivers/iio/adc/cc10001_adc.c        |  6 +-----
> >  drivers/iio/adc/cpcap-adc.c          | 10 +---------
> >  drivers/iio/adc/da9150-gpadc.c       |  6 +-----
> >  drivers/iio/adc/dln2-adc.c           |  5 +----
> >  drivers/iio/adc/ep93xx_adc.c         |  5 +----
> >  drivers/iio/adc/exynos_adc.c         | 11 +----------
> >  drivers/iio/adc/fsl-imx25-gcq.c      |  5 +----
> >  drivers/iio/adc/hi8435.c             |  6 +-----
> >  drivers/iio/adc/hx711.c              |  6 +-----
> >  drivers/iio/adc/imx7d_adc.c          |  6 +-----
> >  drivers/iio/adc/ina2xx-adc.c         |  7 +------
> >  drivers/iio/adc/lp8788_adc.c         |  5 +----
> >  drivers/iio/adc/lpc18xx_adc.c        |  5 +----
> >  drivers/iio/adc/lpc32xx_adc.c        | 15 +--------------
> >  drivers/iio/adc/ltc2471.c            |  3 +--
> >  drivers/iio/adc/ltc2485.c            |  5 +----
> >  drivers/iio/adc/ltc2497.c            |  3 +--
> >  drivers/iio/adc/max1027.c            |  5 +----
> >  drivers/iio/adc/max1118.c            |  5 +----
> >  drivers/iio/adc/max1363.c            |  5 +----
> >  drivers/iio/adc/mcp320x.c            |  5 +----
> >  drivers/iio/adc/mcp3422.c            |  6 +-----
> >  drivers/iio/adc/men_z188_adc.c       |  5 +----
> >  drivers/iio/adc/meson_saradc.c       |  5 +----
> >  drivers/iio/adc/mt6577_auxadc.c      | 10 +---------
> >  drivers/iio/adc/mxs-lradc-adc.c      | 11 +----------
> >  drivers/iio/adc/nau7802.c            |  3 +--
> >  drivers/iio/adc/palmas_gpadc.c       |  5 +----
> >  drivers/iio/adc/qcom-pm8xxx-xoadc.c  |  1 +
> >  drivers/iio/adc/qcom-spmi-iadc.c     | 10 +---------
> >  drivers/iio/adc/qcom-spmi-vadc.c     | 10 +---------
> >  drivers/iio/adc/rockchip_saradc.c    | 11 +----------
> >  drivers/iio/adc/spear_adc.c          |  3 +--
> >  drivers/iio/adc/stx104.c             | 10 +---------
> >  drivers/iio/adc/sun4i-gpadc-iio.c    |  5 +----
> >  drivers/iio/adc/ti-adc081c.c         |  5 +----
> >  drivers/iio/adc/ti-adc0832.c         |  5 +----
> >  drivers/iio/adc/ti-adc084s021.c      |  5 +----
> >  drivers/iio/adc/ti-adc108s102.c      | 10 +---------
> >  drivers/iio/adc/ti-adc12138.c        |  5 +----
> >  drivers/iio/adc/ti-ads1015.c         |  5 +----
> >  drivers/iio/adc/ti-ads8688.c         |  5 +----
> >  drivers/iio/adc/ti-tlc4541.c         |  5 +----
> >  drivers/iio/adc/ti_am335x_adc.c      | 10 +---------
> >  drivers/iio/adc/twl4030-madc.c       | 16 +---------------
> >  drivers/iio/adc/twl6030-gpadc.c      | 16 +---------------
> >  drivers/iio/adc/vf610_adc.c          | 15 +--------------
> >  drivers/iio/adc/viperboard_adc.c     |  7 +------
> >  drivers/iio/adc/xilinx-xadc-core.c   |  3 +--
> >  drivers/iio/adc/xilinx-xadc-events.c |  3 +--
> >  drivers/iio/adc/xilinx-xadc.h        |  3 +--
> >  68 files changed, 68 insertions(+), 361 deletions(-)
> >
>
> (...)
>
> > diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
> > index 5036c392cb20..8f614c84b643 100644
> > --- a/drivers/iio/adc/ep93xx_adc.c
> > +++ b/drivers/iio/adc/ep93xx_adc.c
> > @@ -1,12 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * Driver for ADC module on the Cirrus Logic EP93xx series of SoCs
> >   *
> >   * Copyright (C) 2015 Alexander Sverdlin
> >   *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> > - *
> >   * The driver uses polling to get the conversion status. According to EP93xx
> >   * datasheets, reading ADCResult register starts the conversion, but user is also
> >   * responsible for ensuring that delay between adjacent conversion triggers is
> > diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> > index f10443f92e4c..9f9c186e2135 100644
> > --- a/drivers/iio/adc/exynos_adc.c
> > +++ b/drivers/iio/adc/exynos_adc.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> >  /*
> >   *  exynos_adc.c - Support for ADC in EXYNOS SoCs
> >   *
> > @@ -5,16 +6,6 @@
> >   *
> >   *  Copyright (C) 2013 Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> >   *
> > - *  This program is free software; you can redistribute it and/or modify
> > - *  it under the terms of the GNU General Public License as published by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> >   *  You should have received a copy of the GNU General Public License
> >   *  along with this program; if not, write to the Free Software
> >   *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>
> The paragraph about writing to FSF should also go away, especially it
> is discouraged at first place (see checkpatch).
>

Nice catch! Thanks,
Matheus

> Best regards,
> Krzysztof
