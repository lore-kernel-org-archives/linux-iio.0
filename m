Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:38668 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbbBRL6B (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Feb 2015 06:58:01 -0500
MIME-Version: 1.0
In-Reply-To: <20150218080156.GA5781@x1>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
	<1422108103-15052-2-git-send-email-mpa@pengutronix.de>
	<20150216133829.GG14545@x1>
	<CAOMZO5AwbNeEhVgUuLUi-_QT0DesPBBCTvvebuA91y-P2_CNzg@mail.gmail.com>
	<20150218080156.GA5781@x1>
Date: Wed, 18 Feb 2015 09:57:59 -0200
Message-ID: <CAOMZO5BjVrcb3t1=kQQYf=-PztzDpGk8S5ApsTThGekT1yTTnA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] mfd: fsl imx25 Touchscreen ADC driver
From: Fabio Estevam <festevam@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Markus Pargmann <mpa@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Denis Carikli <denis@eukrea.com>,
	=?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>,
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 18, 2015 at 6:01 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 17 Feb 2015, Fabio Estevam wrote:
>
>> On Mon, Feb 16, 2015 at 11:38 AM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> >> +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
>> >> +                             struct mx25_tsadc *tsadc)
>> >> +{
>> >> +     struct device *dev = &pdev->dev;
>> >> +     struct device_node *np = dev->of_node;
>> >> +     int irq;
>> >> +
>> >> +     irq = platform_get_irq(pdev, 0);
>> >> +     if (irq < 0) {
>> >
>> > What if 0 is returned?
>>
>> Then  imx25.dtsi would be passing irq=0 for the ADC, which would be
>> totally wrong.
>
> Exactly, so it should be <=.

imx25.dtsi passes interrupts = <46>; for the touch screen controller,
so the irq number will never be zero.
