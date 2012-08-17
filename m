Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron
	<jic23@cam.ac.uk>
Subject: RE: [RFC 2/4] iio:inkern: Add function to read the processed value
Date: Fri, 17 Aug 2012 01:34:28 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EEFEE1@DQHE02.ent.ti.com>
References: <1345108725-22120-1-git-send-email-lars@metafoo.de>
 <1345108725-22120-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1345108725-22120-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> Add a function to read a processed value from a channel. The function
> will first
> attempt to read the IIO_CHAN_INFO_PROCESSED attribute. If that fails it
> will
> read the IIO_CHAN_INFO_RAW attribute and convert the result from a raw
> value to
> a processed value.

Point of view of the iio consumer driver, this patch is quite useful.
I added some comments below.

> +static int iio_read_channel_offset_unlocked(struct iio_channel *chan,
> int *val)
> +{
> +	int val2;
	Int unused;
> +
> +	return chan->indio_dev->info->read_raw(chan->indio_dev,
> +					      chan->channel,
> +					      val, &val2,
						Val, &unused,
> +					      IIO_CHAN_INFO_OFFSET);
> +}

I'd replace 'val2' with 'unused' because val2 is meaningless variable
in this function.

> +int iio_read_channel_processed(struct iio_channel *chan, int *val)
> +{
> +	int val2, ret;
> +
> +	mutex_lock(&chan->indio_dev->info_exist_lock);
> +	if (chan->indio_dev->info =3D=3D NULL) {
> +		ret =3D -ENODEV;
> +		goto err_unlock;
> +	}
> +
> +	ret =3D chan->indio_dev->info->read_raw(chan->indio_dev, chan-
> >channel,
> +					      val, &val2,
> IIO_CHAN_INFO_PROCESSED);
> +	if (ret < 0) {
> +		ret =3D chan->indio_dev->info->read_raw(chan->indio_dev,
> chan->channel,
> +					      val, &val2, IIO_CHAN_INFO_RAW);
> +		if (ret < 0)
> +			goto err_unlock;
> +		ret =3D iio_convert_raw_to_processed_unlocked(chan, *val,
> val);
> +	}

What about checking info_mask rather than return value from
read_raw() with IIO_CHAN_INFO_PROCESSED?
This way is more understandable for me.
(if PROCESSED is not set, then try to get raw value and convert)

#define IS_IIO_CHAN_INFO_PROCESSED_SET(chan)		\
	chan->channel->info_mask & IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT

int iio_read_channel_processed(struct iio_channel *chan, int *val)
{

...

	if (IS_IIO_CHAN_INFO_PROCESSED_SET(chan)) {
		ret =3D chan->indio_dev->info->read_raw(chan->indio_dev,
						chan->channel,
						val, &val2,
						IIO_CHAN_INFO_PROCESSED);
	} else {
		ret =3D chan->indio_dev->info->read_raw(chan->indio_dev,
						chan->channel,
						val, &val2,
						IIO_CHAN_INFO_RAW);
		if (ret < 0)
			goto err_unlock;

		ret =3D iio_convert_raw_to_processed_unlocked(chan, *val, val);
	}
...

Here also, it's better to replace 'val2' with 'unused'.

Thank you.

Best Regards,
Milo
