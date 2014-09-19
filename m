Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12228 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756232AbaISQn6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 19 Sep 2014 12:43:58 -0400
Date: Fri, 19 Sep 2014 09:43:10 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: IIO <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Subject: Re: [PATCH v2 4/4] iio/adc/axp288: add support for axp288 gpadc
Message-ID: <20140919094310.6f045021@ultegra>
In-Reply-To: <alpine.DEB.2.01.1409091509110.26919@pmeerw.net>
References: <1410267775-4683-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1410267775-4683-5-git-send-email-jacob.jun.pan@linux.intel.com>
	<alpine.DEB.2.01.1409091509110.26919@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 9 Sep 2014 15:46:31 +0200 (CEST)
Peter Meerwald <pmeerw@pmeerw.net> wrote:

> > +static int axp288_gpadc_remove(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +	iio_map_array_unregister(indio_dev);  
> 
> axp288_gpadc_enable(axp2xx->regmap, false);
on a second thought, we should not disable the adc even on driver
removal. otherwise, internal fuel gauge will be affected.
