Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55322 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbaG1TfQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jul 2014 15:35:16 -0400
In-Reply-To: <53D65214.2090201@parkeon.com>
References: <20140723171719.22067.79447.stgit@localhost> <20140723171725.22067.95943.stgit@localhost> <alpine.DEB.2.01.1407232006000.21518@pmeerw.net> <53D65214.2090201@parkeon.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 3/8] iio: mma8452: Basic support for transient events.
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 28 Jul 2014 20:34:42 +0100
To: Martin Fuzzey <mfuzzey@parkeon.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Message-ID: <ffaf1d33-5fa6-4da3-b2b4-b35f325c7b4b@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On July 28, 2014 2:37:24 PM GMT+01:00, Martin Fuzzey <mfuzzey@parkeon.com> wrote:
>Hi Peter and thank you for the review.
>
>On 23/07/14 20:12, Peter Meerwald wrote:
>> +#define MMA8452_TRANSIENT_CFG_CHAN_MASK(chan)	(BIT(1) << chan)
>> could use GENMASK() macro
>
>That would be
>
>#define MMA8452_TRANSIENT_CFG_CHAN_MASK(chan)	(GENMASK(chan + 1, chan +
>1))
>
>I don't really see that being better in the single bit case here.
>
>> +
>> +static irqreturn_t mma8452_interrupt(int irq, void *p)
>> +{
>> +	struct iio_dev *indio_dev = p;
>> +	struct mma8452_data *data = iio_priv(indio_dev);
>> +	int ret = IRQ_NONE;
>> +	int src;
>> save either ret or src
>Ok, done for V2
>>> +
>>> +	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
>>> +	if (src < 0)
>>> +		goto out;
>> return directly with IRQ_NONE
>Ok, done for V2
>>> +
>>> +	if (src & MMA8452_INT_TRANS) {
>>> +		mma8452_transient_interrupt(indio_dev);
>>> +		ret = IRQ_HANDLED;
>> return directly with IRQ_HANDLED
>Ok, done for V2
>>> +	}
>>> +
>>> +out:
>> no need for goto/label
>Ok, done for V2
>> +	/* By default set transient threshold to max to avoid events if
>> +	 * enabling without configuring threshold */
>> not a proper multiline comment
>Ok, fixed for V2
>>> +	ret = i2c_smbus_write_byte_data(client, MMA8452_TRANSIENT_THS,
>0x7f);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	if (client->irq) {
>> I am always confused if 0 is a valid irq or not; I think it is, so
>> client->irq >= 0
>
>On my DT platform when I remove the interrupt definition from the
>device 
>tree
>I get 0 for client->irq so I think it is not.
Used to be on Arm. A lot of effort went into clearing that up a while back.

J
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
