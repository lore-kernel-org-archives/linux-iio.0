Return-Path: <SRS0=sqo5=3G=analog.com=Michael.Hennerich@kernel.org>
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH] iio/adc/ltc2497: Driver for Linear Technology LTC2497 ADC
References: <1490265310-6162-1-git-send-email-michael.hennerich@analog.com>
 <6774c073-7fe4-e259-306e-3cf4621f7c69@metafoo.de>
To: Lars-Peter Clausen <lars@metafoo.de>, <jic23@kernel.org>,
	<knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <025f8461-c823-1f07-5742-e488c3e34f9f@analog.com>
Date: Wed, 29 Mar 2017 10:51:57 +0200
MIME-Version: 1.0
In-Reply-To: <6774c073-7fe4-e259-306e-3cf4621f7c69@metafoo.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 23.03.2017 12:05, Lars-Peter Clausen wrote:

Sorry - I missed some of this review feedback ...

>> +
>> +static int ltc2497_wait_conv(struct ltc2497_st *st)
>> +{
>> +	s64 time_elapsed;
>> +
>> +	time_elapsed = ktime_ms_delta(ktime_get(), st->time_prev);
>> +
>> +	if (time_elapsed < LTC2497_CONVERSION_TIME_MS) {
>> +		/* delay if conversion time not passed
>> +		 * since last read or write
>> +		 */
>> +		msleep(LTC2497_CONVERSION_TIME_MS - time_elapsed);
>
> Considering how long this sleeps msleep_interruptible() might be the better
> choice.

Wondering what should be the outcome of this?
We can't simply replace it. Actually I've seen cases here in drivers/iio 
where the delay is essential, but the return value of 
msleep_interruptible() is not being checked.
Thus causing a malicious access, in case a signal is received.

We must delay here. If we switch to msleep_interruptible() the only 
reason for this would be to cancel the read and return -EINTR to the user.

Also there is another msleep below which would also need this kind of 
handling.

>
>> +		return 0;
>> +	}
>> +
>> +	if (time_elapsed - LTC2497_CONVERSION_TIME_MS <= 0) {
>> +		/* We're in automatic mode -
>> +		 * so the last reading is stil not outdated
>> +		 */
>> +		return 0;
>> +	}
>> +
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +static int ltc2497_read(struct ltc2497_st *st, u8 address, int *val)
>> +{
>> +	struct i2c_client *client = st->client;
>> +	__be32 buf = 0;
>
> transfer buffers must not be on the stack to avoid issues if the controller
> should use DMA.
>
>> +	int ret;
>> +
>> +	ret = ltc2497_wait_conv(st);
>> +	if (ret < 0 || st->addr_prev != address) {
>> +		ret = i2c_smbus_write_byte(st->client, 0xA0 | address);
>> +		if (ret < 0)
>> +			return ret;
>> +		st->addr_prev = address;
>> +		msleep(LTC2497_CONVERSION_TIME_MS);
>> +	}
>> +	ret = i2c_master_recv(client, (char *)&buf, 3);
>> +	if (ret < 0)  {
>> +		dev_err(&client->dev, "i2c_master_recv failed\n");
>> +		return ret;
>> +	}
>> +	st->time_prev = ktime_get();
>> +	*val = (be32_to_cpu(buf) >> 14) - (1 << 17);
>> +
>> +	return ret;
>> +}
> [...]
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
