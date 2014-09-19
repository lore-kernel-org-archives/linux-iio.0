Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52181 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757190AbaISRbt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 19 Sep 2014 13:31:49 -0400
Message-ID: <1411147870.3829.31.camel@spandruv-hsb-test>
Subject: Re: [PATCH v2 4/4] iio/adc/axp288: add support for axp288 gpadc
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	IIO <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Date: Fri, 19 Sep 2014 10:31:10 -0700
In-Reply-To: <20140919094310.6f045021@ultegra>
References: <1410267775-4683-1-git-send-email-jacob.jun.pan@linux.intel.com>
	 <1410267775-4683-5-git-send-email-jacob.jun.pan@linux.intel.com>
	 <alpine.DEB.2.01.1409091509110.26919@pmeerw.net>
	 <20140919094310.6f045021@ultegra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2014-09-19 at 09:43 -0700, Jacob Pan wrote:
> On Tue, 9 Sep 2014 15:46:31 +0200 (CEST)
> Peter Meerwald <pmeerw@pmeerw.net> wrote:
> 
> > > +static int axp288_gpadc_remove(struct platform_device *pdev)
> > > +{
> > > +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > > +
> > > +	iio_device_unregister(indio_dev);
> > > +	iio_map_array_unregister(indio_dev);  
> > 
> > axp288_gpadc_enable(axp2xx->regmap, false);
> on a second thought, we should not disable the adc even on driver
> removal. otherwise, internal fuel gauge will be affected.
As an independent driver it should disable when driver is removed and
bring back to state before init. You can check the state at init and
restore to that state on exit.
If the FG or other driver has dependency then either it should use the
driver model to take reference by not allowing removal of this driver.
Or use built in module so that it can never be removed.
 
Isn't it a platform specific dependency not universal?

Thanks,
Srinivas
 

