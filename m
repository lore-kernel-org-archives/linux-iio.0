Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:44090 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754485AbcJTOI5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Oct 2016 10:08:57 -0400
Date: Thu, 20 Oct 2016 16:08:55 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Peter Rosin <peda@axentia.se>
cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: dpot-dac: DAC driver based on a digital
 potentiometer
In-Reply-To: <22d07498-860d-29f8-07ef-ae2f5df6ab25@axentia.se>
Message-ID: <alpine.DEB.2.02.1610201604280.22512@pmeerw.net>
References: <1476955562-13673-1-git-send-email-peda@axentia.se> <1476955562-13673-3-git-send-email-peda@axentia.se> <alpine.DEB.2.02.1610201254370.19919@pmeerw.net> <22d07498-860d-29f8-07ef-ae2f5df6ab25@axentia.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> >> +struct dpot_dac {
> >> +	struct regulator *vref;
> >> +	struct iio_channel *dpot;
> > 
> > const
> 
> const? devm_iio_channel_get doesn't return a const iio_channel. What
> am I missing?

ah, I mixed this up with iio_chan_spec
 
> >> +	u32 max_ohms;
> >> +};
> >> +
> >> +static const struct iio_chan_spec dpot_dac_iio_channel = {
> >> +	.type = IIO_VOLTAGE,
> >> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> >> +			    | BIT(IIO_CHAN_INFO_SCALE),
> >> +	.output = 1,
> >> +};
> >> +
> >> +static int dpot_dac_read_raw(struct iio_dev *indio_dev,
> >> +			     struct iio_chan_spec const *chan,
> >> +			     int *val, int *val2, long mask)
> >> +{
> >> +	struct dpot_dac *dac = iio_priv(indio_dev);
> >> +	int ret;
> >> +	unsigned long long tmp;
> > 
> > s64 (which is used to cast below)
> 
> I assume that what you really want is to get rid of the cast, and
> that you aren't really bothered if tmp is ull or s32, right? Given
> that assumption, I'm just dropping the cast instead. The LL specifier
> on the constant should promote *val anyway.

what I meant to pick upon was mixing
s64 with unsigned long long with LL in the code that follows

anything simpler and more consistent would be good

thanks, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
