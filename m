Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43251 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbcDJLHa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 07:07:30 -0400
Subject: Re: [PATCH v2] iio: potentiometer: add driver for Maxim Integrated
 DS1803
To: Slawomir Stepien <sst@poczta.fm>, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
References: <20160408212725.GA10249@x220> <20160409111224.GA1789@x220>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <570A33EC.1060602@kernel.org>
Date: Sun, 10 Apr 2016 12:07:24 +0100
MIME-Version: 1.0
In-Reply-To: <20160409111224.GA1789@x220>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/04/16 12:12, Slawomir Stepien wrote:
> On Apr 08, 2016 23:27, Slawomir Stepien wrote:
>> +static int ds1803_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int *val, int *val2, long mask)
>> +{
>> +	struct ds1803_data *data = iio_priv(indio_dev);
>> +	int pot = chan->channel;
>> +	int ret;
>> +	u16 result;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = i2c_master_recv(data->client, (char *)&result,
>> +				indio_dev->num_channels);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		/* Get bits for given pot */
>> +		*val = (pot == 0 ? result & 0xff : result >> 8);
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = 1000 * data->cfg->kohms;
>> +		*val2 = DS1803_MAX_POS;
>> +		return IIO_VAL_FRACTIONAL;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
> 
> Or maybe this is more clean?
> 
> static int ds1803_read_raw(struct iio_dev *indio_dev,
> 			    struct iio_chan_spec const *chan,
> 			    int *val, int *val2, long mask)
> {
> 	struct ds1803_data *data = iio_priv(indio_dev);
> 	int pot = chan->channel;
> 	int ret;
> 	unsigned char result[indio_dev->num_channels];
I'd use  u8 to make it of an explicit size but otherwise this is indeed
a little bit cleaner.

> 
> 	switch (mask) {
> 	case IIO_CHAN_INFO_RAW:
> 		ret = i2c_master_recv(data->client, result,
> 				indio_dev->num_channels);
> 		if (ret < 0)
> 			return ret;
> 
> 		*val = result[pot];
> 		return IIO_VAL_INT;
> 
> 	case IIO_CHAN_INFO_SCALE:
> 		*val = 1000 * data->cfg->kohms;
> 		*val2 = DS1803_MAX_POS;
> 		return IIO_VAL_FRACTIONAL;
> 	}
> 
> 	return -EINVAL;
> }
> 
> What do you think?
> 

