Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:52436 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754639AbcI2TQW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Sep 2016 15:16:22 -0400
Date: Thu, 29 Sep 2016 21:15:50 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-input@vger.kernel.org, pmeerw@pmeerw.net, jic23@kernel.org,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        dmitry.torokhov@gmail.com, harald@ccbib.org,
        fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
        marex@denx.de, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Message-ID: <1269746175.25077.ef1d8693-0ff3-4b50-a424-49eebba23da1.open-xchange@email.1und1.de>
In-Reply-To: <20160929171540.GB2844@dell>
References: <cover.1474108510.git.ksenija.stanojevic@gmail.com>
 <b50209289b241995c6fd5e23c7343448857fc301.1474108510.git.ksenija.stanojevic@gmail.com>
 <20160928010533.GQ21388@dell>
 <1882238802.204734.75f5f595-10ac-4107-8738-e75dfde001f1.open-xchange@email.1und1.de>
 <20160929171540.GB2844@dell>
Subject: Re: [PATCH v6 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lee,

[add Rob and Mark]

> Lee Jones <lee.jones@linaro.org> hat am 29. September 2016 um 19:15
> geschrieben:
> 
> 
> On Thu, 29 Sep 2016, Stefan Wahren wrote:
> > > Lee Jones <lee.jones@linaro.org> hat am 28. September 2016 um 03:05
> > > geschrieben:
> > > 
> > > 
> > > On Sat, 17 Sep 2016, Ksenija Stanojevic wrote:
> > > 
> > > > +
> > > > +static int mxs_lradc_probe(struct platform_device *pdev)
> > > > +{
> > > > +	const struct of_device_id *of_id;
> > > > +	struct device *dev = &pdev->dev;
> > > > +	struct device_node *node = dev->of_node;
> > > > +	struct mxs_lradc *lradc;
> > > > +	struct mfd_cell *cells = NULL;
> > > > +	int ret = 0;
> > > > +	u32 ts_wires = 0;
> > > > +
> > > > +	lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
> > > > +	if (!lradc)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	of_id = of_match_device(mxs_lradc_dt_ids, &pdev->dev);
> > > > +	lradc->soc = (enum mxs_lradc_id)of_id->data;
> > > > +
> > > > +	lradc->clk = devm_clk_get(&pdev->dev, NULL);
> > > > +	if (IS_ERR(lradc->clk)) {
> > > > +		dev_err(dev, "Failed to get the delay unit clock\n");
> > > > +		return PTR_ERR(lradc->clk);
> > > > +	}
> > > > +
> > > > +	ret = clk_prepare_enable(lradc->clk);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Failed to enable the delay unit clock\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
> > > 
> > > Have you moved the documentation into devicetree/bindings/mfd?
> > > 
> > 
> > i hope it's okay if i answer. The binding has moved to
> > devicetree/binding/iio/adc/ [1]
> > 
> > Should it move completely to mfd or split too?
> > 
> > I'm asking myself how we keep DT ABI in the latter case.
> > 
> > [1] -
> > http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
> 
> I haven't read into the documentation too to deeply, but it stands to
> reason that the bindings which are now being used in MFD should be
> documented in the MFD binding document, and the ones which are no longer
> used in the IIO driver should be removed.

sure, that isn't a problem.

The more interesting question would be: do we need a new compatible string for
the mfd driver?

In that case the ADC won't probe for the combination of old devicetree blobs and
new kernel.

Regards
Stefan

> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
