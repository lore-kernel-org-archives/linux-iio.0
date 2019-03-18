Return-Path: <SRS0=+BiV=RV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8E5C43381
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 22:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A669E204EC
	for <linux-iio@archiver.kernel.org>; Mon, 18 Mar 2019 22:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfCRWhc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:37:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:45386 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfCRWhc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Mar 2019 18:37:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 15:37:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,495,1544515200"; 
   d="scan'208";a="135151425"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 18 Mar 2019 15:37:29 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h60sq-0006sX-KE; Tue, 19 Mar 2019 00:37:28 +0200
Date:   Tue, 19 Mar 2019 00:37:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH v1] iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver
Message-ID: <20190318223728.GA9224@smile.fi.intel.com>
References: <20190318095103.69122-1-andriy.shevchenko@linux.intel.com>
 <20190318205242.GA11257@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318205242.GA11257@arch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 18, 2019 at 09:52:42PM +0100, Tomasz Duszynski wrote:
> A few comments inline.

Thanks for review, my answers below.

> On Mon, Mar 18, 2019 at 12:51:03PM +0300, Andy Shevchenko wrote:

> > +config INTEL_MRFLD_ADC
> > +	tristate "Intel Merrifield Basin Cove ADC driver"
> > +	depends on INTEL_SOC_PMIC_MRFLD
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> 
> Looks you're not using iio buffering hence these should be dropped.

Or implemented? Is there any good example which could be used?

> Instead you should select regmap here.

No need, the depends part does this for us.

> > +#include <linux/bitops.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/driver.h>
> > +#include <linux/iio/machine.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/intel_soc_pmic.h>
> > +#include <linux/mfd/intel_soc_pmic_mrfld.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> 
> Alphabetical order is preferred. 

Ah, you meant iio.h vs. driver.h?

> Generally it's also good idea to include
> all headers which export functionality used by the driver. At least a few
> seems to be missing from the list.

Hmm... Perhaps you meant completion and regmap APIs. Anything else I missed?

> > +static int mrfld_adc_single_conv(struct iio_dev *indio_dev,
> > +				 struct iio_chan_spec const *chan,
> > +				 int *result)
> > +{
> > +	struct mrfld_adc *adc = iio_priv(indio_dev);
> > +	struct regmap *regmap = adc->regmap;
> > +	unsigned int req;
> > +	long timeout;
> > +	u8 buf[2];
> > +	int ret;

> > +	ret = regmap_bulk_read(regmap, chan->address, buf, 2);
> > +	if (ret)
> > +		goto done;
> > +
> > +	*result = (buf[0] << 8) | buf[1];
> 
> be/le16_to_cpu() will do it for you.

I think get_unaligned_le16() will be better here. Otherwise we need to define
__le16 variable and cast around it.


And actually it should be __be16.

> > +	ret = IIO_VAL_INT;
> > +
> > +done:
> > +	regmap_update_bits(regmap, BCOVE_MIRQLVL1, BCOVE_LVL1_ADC, 0xff);
> > +	regmap_update_bits(regmap, BCOVE_MADCIRQ, BCOVE_ADCIRQ_ALL, 0xff);
> > +
> > +	return ret;
> > +}
> > +
> > +static int mrfld_adc_read_raw(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      int *val, int *val2, long mask)
> > +{
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = iio_device_claim_direct_mode(indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = mrfld_adc_single_conv(indio_dev, chan, val);
> > +
> > +		iio_device_release_direct_mode(indio_dev);
> 
> claim/release api is slightly abused here. Legitimate usecase is when
> you want protect against transitions between driver modes and not
> concurrent reads. Mutex will work here just fine.

I see, I will fix this.

> 
> > +		return ret;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}

-- 
With Best Regards,
Andy Shevchenko


