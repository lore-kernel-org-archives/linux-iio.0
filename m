Return-Path: <lars@metafoo.de>
Message-ID: <5117BBDA.4010901@metafoo.de>
Date: Sun, 10 Feb 2013 16:25:14 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] iio:magnetometer:ak8975 move out of staging
References: <1360428941-5130-1-git-send-email-jic23@kernel.org> <51178F13.7000104@kernel.org>
In-Reply-To: <51178F13.7000104@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 02/10/2013 01:14 PM, Jonathan Cameron wrote:
> On 02/09/2013 04:55 PM, Jonathan Cameron wrote:
>> This driver has been clean and correct for quite some time.
>> It is simple and uses only straight forward standard
>> interfaces.
>>
> I'm starting this branch of the thread to ask about the weird
> manging of i2c in the read function.
> ...
> 
>> +/*
>> + * Helper function to write to the I2C device's registers.
>> + */
>> +static int ak8975_write_data(struct i2c_client *client,
>> +			     u8 reg, u8 val, u8 mask, u8 shift)
>> +{
>> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> +	struct ak8975_data *data = iio_priv(indio_dev);
>> +	u8 regval;
>> +	int ret;
>> +
>> +	regval = (data->reg_cache[reg] & ~mask) | (val << shift);
>> +	ret = i2c_smbus_write_byte_data(client, reg, regval);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "Write to device fails status %x\n", ret);
>> +		return ret;
>> +	}
>> +	data->reg_cache[reg] = regval;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Helper function to read a contiguous set of the I2C device's registers.
>> + */
>> +static int ak8975_read_data(struct i2c_client *client,
>> +			    u8 reg, u8 length, u8 *buffer)
>> +{
>> +	int ret;
>> +	struct i2c_msg msg[2] = {
>> +		{
>> +			.addr = client->addr,
>> +			.flags = I2C_M_NOSTART,
> This is 'unusual'.  The result as I read it is that we get
> something like
> 
> START REG  [ACK] START ADDR [DATA] STOP
> (where [] denotes from device)
> 
> The i2c docs specifically tell you that having this flag in the
> first msg is a bad idea.
> 
>>   Flag I2C_M_NOSTART: 
>>     In a combined transaction, no 'S Addr Wr/Rd [A]' is generated at some
>>     point. For example, setting I2C_M_NOSTART on the second partial message
>>     generates something like:
>>       S Addr Rd [A] [Data] NA Data [A] P
>>     If you set the I2C_M_NOSTART variable for the first partial message,
>>     we do not generate Addr, but we do generate the startbit S. This will
>>     probably confuse all other clients on your bus, so don't try this.
>>
>>     This is often used to gather transmits from multiple data buffers in
>>     system memory into something that appears as a single transfer to the
>>     I2C device but may also be used between direction changes by some
>>     rare devices.
> 
> A far as I can tell this function as it stands doesn't make sense for either
> of the AK8975 read protocols.

Yea, this doesn't make much sense. I suppose this got added by accident and
only was tested with a I2C host driver that does not support I2C_M_NOSTART
and simply ignored the flag and did a normal transfer.

- Lars

> 
>> +			.len = 1,
>> +			.buf = &reg,
>> +		}, {
>> +			.addr = client->addr,
>> +			.flags = I2C_M_RD,
>> +			.len = length,
>> +			.buf = buffer,
>> +		}
>> +	};
>> +
>> +	ret = i2c_transfer(client->adapter, msg, 2);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "Read from device fails\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> [...]
