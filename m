Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:4624 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbcH3Tpp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 30 Aug 2016 15:45:45 -0400
Message-ID: <1472586343.5025.1.camel@linux.intel.com>
Subject: Re: [PATCH] iio: accel: bmc150: reset chip at init time
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mpa@pengutronix.de, irina.tirdea@intel.com,
        linux-iio@vger.kernel.org
Date: Tue, 30 Aug 2016 12:45:43 -0700
In-Reply-To: <16ba4f3e-50fa-cadf-da57-39522b6ce386@kernel.org>
References: <1472143533-31869-1-git-send-email-olof@lixom.net>
         <16ba4f3e-50fa-cadf-da57-39522b6ce386@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2016-08-29 at 18:23 +0100, Jonathan Cameron wrote:
> On 25/08/16 17:45, Olof Johansson wrote:
> > 
> > In at least one known setup, the chip comes up in a state where
> > reading
> > the chip ID returns garbage unless it's been reset, due to noise on
> > the
> > wires during system boot.
> > 
> > All supported chips have the same reset method, and based on the
> > datasheets they all need 1.3 or 1.8ms to recover after reset. So,
> > do
> > the conservative thing here and always reset the chip.
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> Looks good to me.
> 
> Srinivas, it's your driver. Can you take a quick look at this?
> 
> Thanks,
> 
> Jonathan
> > 
> > ---
> >  drivers/iio/accel/bmc150-accel-core.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c
> > b/drivers/iio/accel/bmc150-accel-core.c
> > index bf17aae..59b380d 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -67,6 +67,9 @@
> >  #define BMC150_ACCEL_REG_PMU_BW		0x10
> >  #define BMC150_ACCEL_DEF_BW			125
> >  
> > +#define BMC150_ACCEL_REG_RESET			0x14
> > +#define BMC150_ACCEL_RESET_VAL			0xB6
> > +
> >  #define BMC150_ACCEL_REG_INT_MAP_0		0x19
> >  #define BMC150_ACCEL_INT_MAP_0_BIT_SLOPE	BIT(2)
> >  
> > @@ -1497,6 +1500,14 @@ static int bmc150_accel_chip_init(struct
> > bmc150_accel_data *data)
> >  	int ret, i;
> >  	unsigned int val;
> >  
> > +	/*
> > +	 * Reset chip to get it in a known good state. A delay of
> > 1.8ms after
> > +	 * reset is required according to the data sheets of
> > supported chips.
> > +	 */
> > +	regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
> > +		     BMC150_ACCEL_RESET_VAL);
> > +	usleep_range(1800, 2500);
> > +
> >  	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID,
> > &val);
> >  	if (ret < 0) {
> >  		dev_err(dev, "Error: Reading chip id\n");
> > 
