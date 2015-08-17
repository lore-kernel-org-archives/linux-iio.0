Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52375 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbbHQJeo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 05:34:44 -0400
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: RE: [PATCH v5 6/8] iio: gyro: bmg160: optimize i2c transfers in
 trigger handler
Date: Mon, 17 Aug 2015 09:34:39 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0B1F5D@irsmsx105.ger.corp.intel.com>
References: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
 <1439389900-10108-7-git-send-email-irina.tirdea@intel.com>
 <55D056DF.5020201@kernel.org>
In-Reply-To: <55D056DF.5020201@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 16 August, 2015 12:25
> To: Tirdea, Irina; Wolfram Sang; linux-iio@vger.kernel.org; linux-i2c@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Pandruvada, Srinivas; Peter Meerwald
> Subject: Re: [PATCH v5 6/8] iio: gyro: bmg160: optimize i2c transfers in trigger handler
> 
> On 12/08/15 15:31, Irina Tirdea wrote:
> > Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
> > enable/disable the bus at each i2c transfer and must wait for
> > the enable/disable to happen before sending the data.
> >
> > When reading data in the trigger handler, the bmg160 driver does
> > one i2c transfer for each axis. This has an impact on the frequency
> > of the gyroscope at high sample rates due to additional delays
> > introduced by the i2c bus at each transfer.
> >
> > Reading all axis values in one i2c transfer reduces the delays
> > introduced by the i2c bus. Uses i2c_smbus_read_i2c_block_data_or_emulated
> > that will fallback to reading each axis as a separate word in case i2c
> > block read is not supported.
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Note, that in the meantime the bmg160 driver just went all regmap
> on us (as part of adding SPI support - though that step hasn't
> happened yet).  Hence we'll need a means of telling regmap about this
> possibility.

I think regmap_bulk_read might be enough in my case, but I'll have to
test this. I have also seen there are similar changes for the bmc150 driver,
so I will rebase my changes on top of the regmap ones. That leaves only the
kxcjk-1013 changes to be applied from this patchset.

Thanks,
Irina

> 
> > ---
> >  drivers/iio/gyro/bmg160.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
> > index b2a6ccb..1ff306d 100644
> > --- a/drivers/iio/gyro/bmg160.c
> > +++ b/drivers/iio/gyro/bmg160.c
> > @@ -772,6 +772,7 @@ static const struct iio_event_spec bmg160_event = {
> >  		.sign = 's',						\
> >  		.realbits = 16,					\
> >  		.storagebits = 16,					\
> > +		.endianness = IIO_LE,					\
> >  	},								\
> >  	.event_spec = &bmg160_event,					\
> >  	.num_event_specs = 1						\
> > @@ -809,19 +810,16 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
> >  	struct iio_poll_func *pf = p;
> >  	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct bmg160_data *data = iio_priv(indio_dev);
> > -	int bit, ret, i = 0;
> > +	int ret = 0;
> >
> >  	mutex_lock(&data->mutex);
> > -	for (bit = 0; bit < AXIS_MAX; bit++) {
> > -		ret = i2c_smbus_read_word_data(data->client,
> > -					       BMG160_AXIS_TO_REG(bit));
> > -		if (ret < 0) {
> > -			mutex_unlock(&data->mutex);
> > -			goto err;
> > -		}
> > -		data->buffer[i++] = ret;
> > -	}
> > +	ret = i2c_smbus_read_i2c_block_data_or_emulated(data->client,
> > +							BMG160_REG_XOUT_L,
> > +							AXIS_MAX * 2,
> > +							(u8 *)data->buffer);
> >  	mutex_unlock(&data->mutex);
> > +	if (ret < 0)
> > +		goto err;
> >
> >  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> >  					   pf->timestamp);
> >

