Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:46384 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbbBRMIw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Feb 2015 07:08:52 -0500
Received: by wevm14 with SMTP id m14so676388wev.13
        for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2015 04:08:51 -0800 (PST)
Date: Wed, 18 Feb 2015 12:08:44 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Markus Pargmann <mpa@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Denis Carikli <denis@eukrea.com>,
	Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v5 1/6] mfd: fsl imx25 Touchscreen ADC driver
Message-ID: <20150218120844.GC22296@x1>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
 <20150216133829.GG14545@x1>
 <CAOMZO5AwbNeEhVgUuLUi-_QT0DesPBBCTvvebuA91y-P2_CNzg@mail.gmail.com>
 <20150218080156.GA5781@x1>
 <CAOMZO5BjVrcb3t1=kQQYf=-PztzDpGk8S5ApsTThGekT1yTTnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAOMZO5BjVrcb3t1=kQQYf=-PztzDpGk8S5ApsTThGekT1yTTnA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 18 Feb 2015, Fabio Estevam wrote:

> On Wed, Feb 18, 2015 at 6:01 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 17 Feb 2015, Fabio Estevam wrote:
> >
> >> On Mon, Feb 16, 2015 at 11:38 AM, Lee Jones <lee.jones@linaro.org> wrote:
> >>
> >> >> +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
> >> >> +                             struct mx25_tsadc *tsadc)
> >> >> +{
> >> >> +     struct device *dev = &pdev->dev;
> >> >> +     struct device_node *np = dev->of_node;
> >> >> +     int irq;
> >> >> +
> >> >> +     irq = platform_get_irq(pdev, 0);
> >> >> +     if (irq < 0) {
> >> >
> >> > What if 0 is returned?
> >>
> >> Then  imx25.dtsi would be passing irq=0 for the ADC, which would be
> >> totally wrong.
> >
> > Exactly, so it should be <=.
> 
> imx25.dtsi passes interrupts = <46>; for the touch screen controller,
> so the irq number will never be zero.

It doesn't matter what happens to be passed at the moment.  The
correct thing to do is enforce correct/full error checking.  Yes <0 is
an error, but so is =0, so encompass it in the checks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
