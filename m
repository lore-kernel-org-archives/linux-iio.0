Return-Path: <SRS0=HVuF=MI=gmail.com=songqiang1304521@kernel.org>
Date: Wed, 26 Sep 2018 09:49:51 +0800
From: Song Qiang <songqiang1304521@gmail.com>
To: Phil Reid <preid@electromag.com.au>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	robh+dt@kernel.org, mark.rutland@arm.com,
	rtresidd@electromag.com.au, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: Add driver support for PNI RM3100
Message-ID: <20180926014951.GA7094@Eros>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
 <20180925031724.21399-2-songqiang1304521@gmail.com>
 <20180925143054.00007fcb@huawei.com>
 <57d8a9d6-c402-068e-0a21-bbd6c20a7816@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57d8a9d6-c402-068e-0a21-bbd6c20a7816@electromag.com.au>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 25, 2018 at 10:36:54PM +0800, Phil Reid wrote:
> On 25/09/2018 9:30 PM, Jonathan Cameron wrote:
> > > +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
> > > +{
> > > +	struct iio_poll_func *pf = p;
> > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > +	struct rm3100_data *data = iio_priv(indio_dev);
> > > +	struct regmap *regmap = data->regmap;
> > > +	u8 buffer[9];
> > > +	int ret;
> > > +	int i;
> > > +
> > > +	mutex_lock(&data->lock);
> > > +	ret = rm3100_wait_measurement(data);
> > > +	if (ret < 0) {
> > > +		mutex_unlock(&data->lock);
> > > +		goto done;
> > > +	}
> > > +
> > > +	ret = regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, sizeof(buffer));
> > > +	mutex_unlock(&data->lock);
> > > +	if (ret < 0)
> > > +		goto done;
> > > +
> > > +	/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for padding. */
> > > +	for (i = 0; i < 3; i++)
> > > +		memcpy(data->buffer + i * 4, buffer + i * 3, 3);
> > Firstly X doesn't need copying.
> > Secondly the copy of Y actually overwrites the value of Z
> > XXXYYYZZZxxx
> > XXXxYYYZZxxx
> > XXXxYYYxYZZx
> > 
> > I think...
> > 
> > > +
> > > +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> > > +			iio_get_time_ns(indio_dev));
> 
> memcpy target is a different buffer so should be ok.
> 
> But that raises the question of does it need to be?
> 'buffer' could be 12 bytes long and just shuffle Z then Y.
> Do the unused bytes need to be zeroed? or does libiio mask them anyway?
> 
> 
> 
> -- 
> Regards
> Phil Reid

Hi Phil,

This is interesting, last patch I submitted uses three transactions and
shuffles X, Y and Z respectively. You said it should be better to use one
transactions, I thought it makes point, and one transaction may reduce
IO pressure of the i2c bus. :)
And that's not necessary for unused bytes to be zero. I'm not familiar
with libiio, actually just been studying it, can't say anything about
it.

yours,
Song Qiang
