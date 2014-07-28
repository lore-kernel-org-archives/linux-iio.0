Return-Path: <mfuzzey@parkeon.com>
Message-ID: <53D65214.2090201@parkeon.com>
Date: Mon, 28 Jul 2014 15:37:24 +0200
From: Martin Fuzzey <mfuzzey@parkeon.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/8] iio: mma8452: Basic support for transient events.
References: <20140723171719.22067.79447.stgit@localhost> <20140723171725.22067.95943.stgit@localhost> <alpine.DEB.2.01.1407232006000.21518@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1407232006000.21518@pmeerw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Peter and thank you for the review.

On 23/07/14 20:12, Peter Meerwald wrote:
> +#define MMA8452_TRANSIENT_CFG_CHAN_MASK(chan)	(BIT(1) << chan)
> could use GENMASK() macro

That would be

#define MMA8452_TRANSIENT_CFG_CHAN_MASK(chan)	(GENMASK(chan + 1, chan + 1))

I don't really see that being better in the single bit case here.

> +
> +static irqreturn_t mma8452_interrupt(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int ret = IRQ_NONE;
> +	int src;
> save either ret or src
Ok, done for V2
>> +
>> +	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
>> +	if (src < 0)
>> +		goto out;
> return directly with IRQ_NONE
Ok, done for V2
>> +
>> +	if (src & MMA8452_INT_TRANS) {
>> +		mma8452_transient_interrupt(indio_dev);
>> +		ret = IRQ_HANDLED;
> return directly with IRQ_HANDLED
Ok, done for V2
>> +	}
>> +
>> +out:
> no need for goto/label
Ok, done for V2
> +	/* By default set transient threshold to max to avoid events if
> +	 * enabling without configuring threshold */
> not a proper multiline comment
Ok, fixed for V2
>> +	ret = i2c_smbus_write_byte_data(client, MMA8452_TRANSIENT_THS, 0x7f);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (client->irq) {
> I am always confused if 0 is a valid irq or not; I think it is, so
> client->irq >= 0

On my DT platform when I remove the interrupt definition from the device 
tree
I get 0 for client->irq so I think it is not.
