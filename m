Return-Path: <dmitry.torokhov@gmail.com>
Date: Mon, 2 Feb 2015 09:51:34 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Varka Bhadram <varkabhadram@gmail.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>, Denis Carikli <denis@eukrea.com>,
	Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v6 6/8] input: touchscreen: imx25 tcq driver
Message-ID: <20150202175134.GB23909@dtor-ws>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
 <1422540556-14828-7-git-send-email-mpa@pengutronix.de>
 <54CA4320.4030607@gmail.com>
 <20150130185721.GA11695@dtor-ws>
 <20150202160539.GS16879@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150202160539.GS16879@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 02, 2015 at 05:05:39PM +0100, Markus Pargmann wrote:
> Hi,
> 
> On Fri, Jan 30, 2015 at 10:57:21AM -0800, Dmitry Torokhov wrote:
> > On Thu, Jan 29, 2015 at 07:56:40PM +0530, Varka Bhadram wrote:
> > > Hi,
> > > 
> > > On Thursday 29 January 2015 07:39 PM, Markus Pargmann wrote:
> > > >This is a driver for the imx25 ADC/TSC module. It controls the
> > > >touchscreen conversion queue and creates a touchscreen input device.
> > > >The driver currently only supports 4 wire touchscreens. The driver uses
> > > >a simple conversion queue of precharge, touch detection, X measurement,
> > > >Y measurement, precharge and another touch detection.
> > > >
> > > >This driver uses the regmap from the parent to setup some touch specific
> > > >settings in the core driver and setup a idle configuration with touch
> > > >detection.
> > > >
> > > >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > >Signed-off-by: Denis Carikli <denis@eukrea.com>
> > > >Acked-by: Dmitry Torokhov <dtor@vmware.com>
> > > >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > >---
> > > >  drivers/input/touchscreen/Kconfig         |   6 +
> > > >  drivers/input/touchscreen/Makefile        |   1 +
> > > >  drivers/input/touchscreen/fsl-imx25-tcq.c | 587 ++++++++++++++++++++++++++++++
> > > >  3 files changed, 594 insertions(+)
> > > >  create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
> > > >
> > > (...)
> > > 
> > > >+	ret = request_threaded_irq(priv->irq, mx25_tcq_irq, mx25_tcq_irq_thread,
> > > >+				   IRQF_ONESHOT, pdev->name, priv);
> > > 
> > > We can use devres API for request_thread_irq()...
> > > 
> > > >+	if (ret) {
> > > >+		dev_err(dev, "Failed requesting IRQ\n");
> > > >+		goto err_clk_unprepare;
> > > >+	}
> > > >+
> > > >+	ret = mx25_tcq_init(priv);
> > > >+	if (ret) {
> > > >+		dev_err(dev, "Failed to init tcq\n");
> > > >+		goto error_free_irq;
> > > >+	}
> > > >+
> > > >+	platform_set_drvdata(pdev, priv);
> > > >+
> > > >+	return 0;
> > > >+
> > > >+error_free_irq:
> > > >+	free_irq(priv->irq, priv);
> > > 
> > > This is not required if we use devres API
> > 
> > Yes it does - you do not really want to stop clocks in the middle of
> > servicing interrupt.
> 
> Thanks, I missed the clocks. I will not use devm here then.

Actually, you still can if you move clock enabling/disabling and
mx25_tcq_init() into input_dev->open() and ->close() callbacks. Close
will be called during input device un-registration which happens (given
your current sequence) after freeing irq by devm.

By the way, I used my old @vmware address by accident. Can you please
replace the original acked by with:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
