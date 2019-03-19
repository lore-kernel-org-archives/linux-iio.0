Return-Path: <SRS0=6njX=RW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2F0C43381
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 19:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D8C20693
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 19:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZfY45IE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfCSTCo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:02:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44392 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfCSTCo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Mar 2019 15:02:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id n18so22147ljg.11
        for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2019 12:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TZXaABhZTRIt1ZdusZ7IxhlMMxq2gh9lVuOr2jw4NpM=;
        b=eZfY45IEKF1WeTRM9rLdNYbEA6jXTN6CUs+mD8Ds2RGmPr9qsFvQgkiY29eNMp21pK
         MBdGSPX0uqU/ztUAop6WEFTM/q8bjA8coBLVbZbtI09A/MO4cJ9/oAKoWHqkGmNi5mlM
         2IXAopZC0L80LniQNsjHOsBXuhngqwlZrJXi8e3VGWbjRBcYAwTofJm2WweH2huaXmIm
         6qGdObC00tUR/dBuqD/2poank08mfUCcOz76DzB2ni4g+oXeL+Edfk9NJLV6T23mDvb9
         blE2563FW/xNy9fuCYEGDUAxnHd+2EQdR8SUvWO+u3ZZA2AprpnyrgRI5tmojGLI0K7C
         pxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TZXaABhZTRIt1ZdusZ7IxhlMMxq2gh9lVuOr2jw4NpM=;
        b=NOsDn+UWj6ipUgZCb5ty7RGqnBP7lyV+cKKWRHCWO54rmU7cOmcOl8V/QAdcF8QNVH
         FanM3OEcc6qU0ek9UPv8mziHuLr9ibGrqPdPLGpTnDxZTuBiqqsMgQpxsAIcyj9Ox1Ub
         9mjRVhIOyzClmWS2cIgxpBm4HG2hIlmpe9eBSVCcndT5TySHH4OuoERtXKuKb4TiT215
         0niUKv1qqPuDYg5w+6tj5H6QnSTmlAdzGxA7+M1uzDlmKb0uILI4Xz+/F9L8WyPj9CYF
         qsxycGjSF3KZ09PrYdMbo6fUMOx+3rgH82J6h/sV9mi9imu1Tf6aO0ybSrx+MPzJ38ZV
         cYyg==
X-Gm-Message-State: APjAAAUvqa9T/gTWcpk5EI9G39Te/lR8+c7z/S8M3di8DbTjtljS3ytU
        uJhHUNSr36sMj752+ORRdfE=
X-Google-Smtp-Source: APXvYqwb12SIYdMgs9XmZM4+U/45DtvIOL/JdW19q9+i36zdFyp+1lzMD77E1uqStSk29DMc+7LFxw==
X-Received: by 2002:a2e:9bc7:: with SMTP id w7mr7095642ljj.58.1553022161862;
        Tue, 19 Mar 2019 12:02:41 -0700 (PDT)
Received: from localhost (89-64-61-77.dynamic.chello.pl. [89.64.61.77])
        by smtp.gmail.com with ESMTPSA id x10sm3058000lff.45.2019.03.19.12.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 12:02:41 -0700 (PDT)
Date:   Tue, 19 Mar 2019 20:02:15 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH v1] iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver
Message-ID: <20190319190213.GB11257@arch>
References: <20190318095103.69122-1-andriy.shevchenko@linux.intel.com>
 <20190318205242.GA11257@arch>
 <20190318223728.GA9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190318223728.GA9224@smile.fi.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 19, 2019 at 12:37:28AM +0200, Andy Shevchenko wrote:
> On Mon, Mar 18, 2019 at 09:52:42PM +0100, Tomasz Duszynski wrote:
> > A few comments inline.
>
> Thanks for review, my answers below.
>
> > On Mon, Mar 18, 2019 at 12:51:03PM +0300, Andy Shevchenko wrote:
>
> > > +config INTEL_MRFLD_ADC
> > > +	tristate "Intel Merrifield Basin Cove ADC driver"
> > > +	depends on INTEL_SOC_PMIC_MRFLD
> > > +	select IIO_BUFFER
> > > +	select IIO_TRIGGERED_BUFFER
> >
> > Looks you're not using iio buffering hence these should be dropped.
>
> Or implemented? Is there any good example which could be used?
>

Have a look at other ADCs. Most of them support what you're looking
for (specifically have a look at iio_triggered_buffer_setup()).

> > Instead you should select regmap here.
>
> No need, the depends part does this for us.
>
> > > +#include <linux/bitops.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/driver.h>
> > > +#include <linux/iio/machine.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/mfd/intel_soc_pmic.h>
> > > +#include <linux/mfd/intel_soc_pmic_mrfld.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> >
> > Alphabetical order is preferred.
>
> Ah, you meant iio.h vs. driver.h?
>

Yes.

> > Generally it's also good idea to include
> > all headers which export functionality used by the driver. At least a few
> > seems to be missing from the list.
>
> Hmm... Perhaps you meant completion and regmap APIs. Anything else I missed?
>

I guess that would be it unless you plan to add other functionality.

> > > +static int mrfld_adc_single_conv(struct iio_dev *indio_dev,
> > > +				 struct iio_chan_spec const *chan,
> > > +				 int *result)
> > > +{
> > > +	struct mrfld_adc *adc = iio_priv(indio_dev);
> > > +	struct regmap *regmap = adc->regmap;
> > > +	unsigned int req;
> > > +	long timeout;
> > > +	u8 buf[2];
> > > +	int ret;
>
> > > +	ret = regmap_bulk_read(regmap, chan->address, buf, 2);
> > > +	if (ret)
> > > +		goto done;
> > > +
> > > +	*result = (buf[0] << 8) | buf[1];
> >
> > be/le16_to_cpu() will do it for you.
>
> I think get_unaligned_le16() will be better here. Otherwise we need to define
> __le16 variable and cast around it.
>

I was thinking about be16_to_cpu(*(__be16 *)buf).
Given this is local array and you do not do any pointer arithmetic
before casting I would be surprised if that caused unaligned access.

>
> And actually it should be __be16.
>
> > > +	ret = IIO_VAL_INT;
> > > +
> > > +done:
> > > +	regmap_update_bits(regmap, BCOVE_MIRQLVL1, BCOVE_LVL1_ADC, 0xff);
> > > +	regmap_update_bits(regmap, BCOVE_MADCIRQ, BCOVE_ADCIRQ_ALL, 0xff);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int mrfld_adc_read_raw(struct iio_dev *indio_dev,
> > > +			      struct iio_chan_spec const *chan,
> > > +			      int *val, int *val2, long mask)
> > > +{
> > > +	int ret;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		ret = iio_device_claim_direct_mode(indio_dev);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		ret = mrfld_adc_single_conv(indio_dev, chan, val);
> > > +
> > > +		iio_device_release_direct_mode(indio_dev);
> >
> > claim/release api is slightly abused here. Legitimate usecase is when
> > you want protect against transitions between driver modes and not
> > concurrent reads. Mutex will work here just fine.
>
> I see, I will fix this.
>
> >
> > > +		return ret;
> > > +
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
