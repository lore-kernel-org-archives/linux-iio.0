Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20150216133829.GG14545@x1>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
	<1422108103-15052-2-git-send-email-mpa@pengutronix.de>
	<20150216133829.GG14545@x1>
Date: Tue, 17 Feb 2015 16:54:54 -0200
Message-ID: <CAOMZO5AwbNeEhVgUuLUi-_QT0DesPBBCTvvebuA91y-P2_CNzg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] mfd: fsl imx25 Touchscreen ADC driver
From: Fabio Estevam <festevam@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
	Denis Carikli <denis@eukrea.com>, =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 16, 2015 at 11:38 AM, Lee Jones <lee.jones@linaro.org> wrote:

>> +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
>> +                             struct mx25_tsadc *tsadc)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct device_node *np = dev->of_node;
>> +     int irq;
>> +
>> +     irq = platform_get_irq(pdev, 0);
>> +     if (irq < 0) {
>
> What if 0 is returned?

Then  imx25.dtsi would be passing irq=0 for the ADC, which would be
totally wrong.
