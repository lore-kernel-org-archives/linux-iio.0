Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.208]:54667 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbcDILMf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Apr 2016 07:12:35 -0400
Date: Sat, 9 Apr 2016 13:12:24 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: potentiometer: add driver for Maxim Integrated
 DS1803
Message-ID: <20160409111224.GA1789@x220>
References: <20160408212725.GA10249@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160408212725.GA10249@x220>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Apr 08, 2016 23:27, Slawomir Stepien wrote:
> +static int ds1803_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ds1803_data *data = iio_priv(indio_dev);
> +	int pot = chan->channel;
> +	int ret;
> +	u16 result;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = i2c_master_recv(data->client, (char *)&result,
> +				indio_dev->num_channels);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Get bits for given pot */
> +		*val = (pot == 0 ? result & 0xff : result >> 8);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1000 * data->cfg->kohms;
> +		*val2 = DS1803_MAX_POS;
> +		return IIO_VAL_FRACTIONAL;
> +	}
> +
> +	return -EINVAL;
> +}

Or maybe this is more clean?

static int ds1803_read_raw(struct iio_dev *indio_dev,
			    struct iio_chan_spec const *chan,
			    int *val, int *val2, long mask)
{
	struct ds1803_data *data = iio_priv(indio_dev);
	int pot = chan->channel;
	int ret;
	unsigned char result[indio_dev->num_channels];

	switch (mask) {
	case IIO_CHAN_INFO_RAW:
		ret = i2c_master_recv(data->client, result,
				indio_dev->num_channels);
		if (ret < 0)
			return ret;

		*val = result[pot];
		return IIO_VAL_INT;

	case IIO_CHAN_INFO_SCALE:
		*val = 1000 * data->cfg->kohms;
		*val2 = DS1803_MAX_POS;
		return IIO_VAL_FRACTIONAL;
	}

	return -EINVAL;
}

What do you think?

-- 
Slawomir Stepien
