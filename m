Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59023 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbcGXMOs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 08:14:48 -0400
Subject: Re: [PATCH] iio: temperature: mcp9808: add Microchip MCP9808
 temperature sensor
To: Alison Schofield <amsfield22@gmail.com>
References: <20160703210448.GA14874@d830.WORKGROUP>
 <96a21d2e-3728-7f45-f562-ff07c6e2a599@kernel.org>
 <20160711210121.GA3773@d830.WORKGROUP>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <27a6c1d5-5493-3f3d-b2ca-8f221d9477b0@kernel.org>
Date: Sun, 24 Jul 2016 13:14:45 +0100
MIME-Version: 1.0
In-Reply-To: <20160711210121.GA3773@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


...
>>> +static int mcp9808_read_raw(struct iio_dev *indio_dev,
>>> +			    struct iio_chan_spec const *channel,
>>> +			    int *val, int *val2, long mask)
>>> +
>>> +{
>>> +	struct mcp9808_data *data = iio_priv(indio_dev);
>>> +	int ret;
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_RAW:
>>> +		ret = i2c_smbus_read_word_swapped(data->client,
>>> +						  MCP9808_REG_TAMBIENT);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +		*val = sign_extend32(ret, 12);
>> I just laughed when I saw the pile of BS they have in the datasheet to
>> describe exactly what you have here...
>>
> Well, then you'd find it hilarious the lengths I took to prove that the
> simple sign-extend & scale was correct in response to the data sheets
> bountiful calculations!
:)
> 
>>> +		return IIO_VAL_INT;
>>> +
>>> +	case IIO_CHAN_INFO_SCALE:
>>> +		*val = 0;
>>> +		*val2 = 62500;
>>> +		return IIO_VAL_INT_PLUS_MICRO;
>>> +
>>> +	case IIO_CHAN_INFO_INT_TIME:
>>> +		*val = 0;
>>> +		*val2 = mcp9808_res[data->res_index][0];
>>> +		return IIO_VAL_INT_PLUS_MICRO;
>>> +
>>> +	default:
>>> +		break;
>>> +	}
>>> +
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static int mcp9808_write_raw(struct iio_dev *indio_dev,
>>> +			     struct iio_chan_spec const *channel,
>>> +			     int val, int val2, long mask)
>>> +{
>>> +	struct mcp9808_data *data = iio_priv(indio_dev);
>>> +	int ret = -EINVAL;
>>> +
>>> +	if (mask == IIO_CHAN_INFO_INT_TIME) {
>>> +		if (!val)
>>> +			ret = mcp9808_set_resolution(data, val2);
>>
>> Hmm.  Is this integration time?  I think it is more likely to be either:
>> 1) The number of stages of the ADC. (normally gives a very minor time
>> difference in a SAR ADC or similar as going from say 8 to 10 bits is only
>> a 20% increase).
>> 2) Number of averages samples (oversampling). (almost certainly true here).
>>
>> Integration time doesn't make much sense for a temperature sensor.  These
>> tend to be analog parts with a track and hold type ADC that just gets what
>> ever is on the wire when a reading is requested.  Integration time is more
>> for things like light sensors where you are looking at counting number
>> of photons (very badly) in a fixed time period.
>>
>> Hmm. So how should it be supported..
>> Could use sampling_frequency as that also reflects sampling period.
>> It's not ideal though.  Often we've just not bothered to support anything
>> other than the highest resolution (particularly on fast devices), but here
>> it really does lead to very low speeds...  Basis for not supporting it in
>> the past was that mostly the cost was minor to increase the resolution and
>>
>> If we knew it really was just oversampling this would be easy. I suppose it
>> doesn't actually matter what the hardware is doing.  That's what the software
>> is effectively seeing .
>>
>> Unfortunately, for oversampling to be used you'd probably also want an
>> indication of the sampling frequency so you'd need that one as well.
>>
>> So I think the best option is oversampling_ratio and sampling_frequency.
>> Control via oversampling_ratio.
>>
> 
> I'm wondering if I simply implemented it backwards.
> 
> Now I offer a selection resolutions (which I label integration times).
> 
> Should I simply flip it to offer a selection of integration times which
> then indicate which resolution driver will set?
I'll admit I've forgotten all about this now and don't have time to
dig back into it...  Sorry!
>>> +	}
>>> +	return ret;
>>> +}
>>> +
....

