Return-Path: <SRS0=74xU=CL=atomide.com=tony@kernel.org>
Date: Mon, 13 Nov 2017 10:49:03 -0800
From: Tony Lindgren <tony@atomide.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Pan Bian <bianpan2016@163.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: cpcap: fix incorrect validation
Message-ID: <20171113184903.GX28152@atomide.com>
References: <1510502480-27117-1-git-send-email-bianpan2016@163.com>
 <20171112182848.li5chdcsrhjv3du6@earth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171112182848.li5chdcsrhjv3du6@earth>
List-ID: <linux-iio@vger.kernel.org>

* Sebastian Reichel <sre@kernel.org> [171112 18:30]:
> Hi,
>=20
> On Mon, Nov 13, 2017 at 12:01:20AM +0800, Pan Bian wrote:
> > Function platform_get_irq_byname() returns a negative error code on
> > failure, and a zero or positive number on success. However, in function
> > cpcap_adc_probe(), positive IRQ numbers are also taken as error cases.
> > Use "if (ddata->irq < 0)" instead of "if (!ddata->irq)" to validate the
> > return value of platform_get_irq_byname().
> >=20
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> > ---
>=20
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
