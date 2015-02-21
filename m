Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34797 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbbBUS3d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Feb 2015 13:29:33 -0500
Message-ID: <54E8CE8B.7060909@kernel.org>
Date: Sat, 21 Feb 2015 18:29:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Tirdea, Irina" <irina.tirdea@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
	"Reus, Adriana" <adriana.reus@intel.com>
Subject: Re: [PATCH 2/2] iio: accel: kxcjk-1013: optimize i2c transfers in
 trigger handler
References: <1424110909-16878-1-git-send-email-irina.tirdea@intel.com> <1424110909-16878-3-git-send-email-irina.tirdea@intel.com> <alpine.DEB.2.02.1502162014280.26763@pmeerw.net> <1F3AC3675D538145B1661F571FE1805F19A20D9C@irsmsx105.ger.corp.intel.com>
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F19A20D9C@irsmsx105.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/02/15 12:02, Tirdea, Irina wrote:
> 
> 
>> -----Original Message-----
>> From: Peter Meerwald [mailto:pmeerw@pmeerw.net]
>> Sent: 16 February, 2015 21:26
>> To: Tirdea, Irina
>> Cc: Jonathan Cameron; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Pandruvada, Srinivas; Reus, Adriana
>> Subject: Re: [PATCH 2/2] iio: accel: kxcjk-1013: optimize i2c transfers in trigger handler
>>
>>
>>> Reading all axis values in one i2c transfer reduces the delays
>>> introduced by the i2c bus. In case i2c block read is not supported,
>>> fallback to reading each axis as a separate word.
>>
>> see comments inline below
>>
> Thanks for the review, Peter!
> 
>>> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
>>> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
>>> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>> ---
>>>  drivers/iio/accel/kxcjk-1013.c | 44 +++++++++++++++++++++++++++++++++---------
>>>  1 file changed, 35 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
>>> index 5f27787..bfa2899 100644
>>> --- a/drivers/iio/accel/kxcjk-1013.c
>>> +++ b/drivers/iio/accel/kxcjk-1013.c
>>> @@ -109,6 +109,8 @@ struct kxcjk1013_data {
>>>  	int64_t timestamp;
>>>  	enum kx_chipset chipset;
>>>  	bool is_smo8500_device;
>>> +	s32 (*read_block_data)(const struct i2c_client *client, u8 command,
>>> +			       u8 length, u8 *values);
>>
>> probably this could/should be done in the i2c layer or we end up adding a
>> similar function in every driver?
>>
> Actually this is exactly what I did: adding this code in a couple of drivers :)
> You are right, this belongs to the i2c core. Will move it there.
A good idea.  Might be possible to make this a transparent fallback so no
special handling is needed in drivers at all (e.g. emulate the block read using
the biggest read that is available) - taking care about the endian fun and
games that results.

Propose it to Wolfram and the i2c list and see what people think of it.

Jonathan
> 
>>>  };
>>>
>>>  enum kxcjk1013_axis {
>>> @@ -216,6 +218,23 @@ static const struct {
>>>  				 {800, 0, 0x06},
>>>  				 {1600, 0, 0x06} };
>>>
>>> +static s32 kxcjk1013_read_block_data(const struct i2c_client *client,
>>> +				     u8 command, u8 length, u8 *values)
>>> +{
>>> +	s32 data;
>>> +	u8 i;
>>> +
>>> +	for (i = 0; i < length; i += 2) {
>>> +		data = i2c_smbus_read_word_data(client, command + i);
>>> +		if (data < 0)
>>> +			return data;
>>> +
>>> +		values[i] = data & 0xFF;
>>> +		values[i+1] = data >> 8;
>>
>> this is incorrect; it forces the data to be little endian, however, the
>> endianness (as specified in the driver's .scan_type) is IIO_CPU -- the
>> code breaks for big-endian CPUs
>>
>> since _read_i2c_block_data() can't do endianness conversion (and the chip
>> does i2c endianness, i.e. little-endian), the .scan_type should become
>> IIO_LE and above code is correct again but still ugly :)
>>
>> bottom line: change .scan_type to IIO_LE
>>
> Good point. Changing the endianess to IIO_LE is correct for either kxcjk1013_read_block_data or i2c_smbus_read_i2c_block_data.
> Will fix this in the next version. Thanks for catching this!
> 
>>> +	}
>>> +	return i;
>>> +}
>>> +
>>>  static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
>>>  			      enum kxcjk1013_mode mode)
>>>  {
>>> @@ -955,18 +974,14 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
>>>  	struct iio_poll_func *pf = p;
>>>  	struct iio_dev *indio_dev = pf->indio_dev;
>>>  	struct kxcjk1013_data *data = iio_priv(indio_dev);
>>> -	int bit, ret, i = 0;
>>> +	int ret;
>>>
>>>  	mutex_lock(&data->mutex);
>>> -	for (bit = 0; bit < AXIS_MAX; bit++) {
>>> -		ret = kxcjk1013_get_acc_reg(data, bit);
>>> -		if (ret < 0) {
>>> -			mutex_unlock(&data->mutex);
>>> -			goto err;
>>> -		}
>>> -		data->buffer[i++] = ret;
>>> -	}
>>> +	ret = data->read_block_data(data->client, KXCJK1013_REG_XOUT_L,
>>> +				    AXIS_MAX * 2, (u8 *) data->buffer);
>>>  	mutex_unlock(&data->mutex);
>>> +	if (ret < 0)
>>> +		goto err;
>>>
>>>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>>>  					   data->timestamp);
>>> @@ -1196,6 +1211,11 @@ static int kxcjk1013_probe(struct i2c_client *client,
>>>  	const char *name;
>>>  	int ret;
>>>
>>> +	if (!i2c_check_functionality(client->adapter,
>>> +				     I2C_FUNC_SMBUS_BYTE_DATA |
>>> +				     I2C_FUNC_SMBUS_READ_WORD_DATA))
>>> +		return -ENODEV;
>>> +
>>>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>>>  	if (!indio_dev)
>>>  		return -ENOMEM;
>>> @@ -1204,6 +1224,12 @@ static int kxcjk1013_probe(struct i2c_client *client,
>>>  	i2c_set_clientdata(client, indio_dev);
>>>  	data->client = client;
>>>
>>> +	if (i2c_check_functionality(client->adapter,
>>> +				    I2C_FUNC_SMBUS_READ_I2C_BLOCK))
>>> +		data->read_block_data = i2c_smbus_read_i2c_block_data;
>>> +	else
>>> +		data->read_block_data = kxcjk1013_read_block_data;
>>> +
>>>  	pdata = dev_get_platdata(&client->dev);
>>>  	if (pdata)
>>>  		data->active_high_intr = pdata->active_high_intr;
>>>
>>
>> --
>>
>> Peter Meerwald
>> +43-664-2444418 (mobile)

