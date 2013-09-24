Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201309240950.54789.jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
	<1379946998-23041-2-git-send-email-jbe@pengutronix.de>
	<52405A7F.1050801@freescale.com>
	<201309240950.54789.jbe@pengutronix.de>
Date: Tue, 24 Sep 2013 10:50:00 -0300
Message-ID: <CAOMZO5A9LY-oUpjJxWssUCo7w4oPqVxGwX0=VAUzoEu4RhJ37g@mail.gmail.com>
Subject: Re: [PATCH 1/9] Staging/iio/adc/touchscreen/MXS: add proper clock handling
From: Fabio Estevam <festevam@gmail.com>
To: =?UTF-8?Q?J=C3=BCrgen_Beisert?= <jbe@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Fabio Estevam <fabio.estevam@freescale.com>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>, linux-input@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 24, 2013 at 4:50 AM, J=C3=BCrgen Beisert <jbe@pengutronix.de> w=
rote:
> Hi Fabio,
>
> On Monday 23 September 2013 17:13:03 Fabio Estevam wrote:
>> On 09/23/2013 11:36 AM, Juergen Beisert wrote:
>> > +   lradc->clk =3D devm_clk_get(&pdev->dev, NULL);
>> > +   clk_prepare_enable(lradc->clk);
>>
>> clk_prepare_enable() may fail, so better check its return value.
>
> Thanks for the comment. Better this way?

Yes, looks better.

Thanks,

Fabio Estevam
