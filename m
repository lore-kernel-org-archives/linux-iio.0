Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50023 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaJYTh6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 25 Oct 2014 15:37:58 -0400
Message-ID: <544BFC14.2030800@kernel.org>
Date: Sat, 25 Oct 2014 20:37:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, IIO <linux-iio@vger.kernel.org>
CC: David Barksdale <dbarksdale@uplogix.com>
Subject: Re: [PATCH]iio:humidity:si7020: cleanup read_raw and probe
References: <5442C3A0.7080501@gmx.de> <544B753B.40207@kernel.org> <544BDF26.2020607@gmx.de> <544BFB5B.3070301@kernel.org>
In-Reply-To: <544BFB5B.3070301@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/10/14 20:34, Jonathan Cameron wrote:
> On 25/10/14 18:34, Hartmut Knaack wrote:
>> Jonathan Cameron schrieb am 25.10.2014 12:02:
>>> On 18/10/14 20:46, Hartmut Knaack wrote:
>>>> In si7020_read_raw() the pointer to the i2c client was obtained as second level pointer, although a simple pointer would be sufficient. Cleaned this.
>>>> When reading temperature or humidity values, a right-shift of two bits needs to be applied, and only for the humidity channel a mask of the lower 12 bits needs to be applied. This reduces code repetition.
>>>> During probe, i2c_set_clientdata() was used, although its counterpart was not, so drop it.
>>>>
>>>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>>> I think the incorrect pointer is a bug (rather than simply unnecessary).
>> Could you give me some infos, why you assess this issue as a bug?
> Fair point.  It's a bug with no effect whatsoever.
> I didn't really follow that through other than going
> "Gah it has the wrong type, we'll dereference it once too many and it will
> eat babies!"
> 
> Clearly it just gets passed on wards thus two bugs cancel each other out.

I take it back. Just taken a look at your updated patch. The dereference will
mean that instead of passing a pointer into the read, we will be passing whatever
is the start of an actual i2c_client structure.


> 
>>> The other stuff is a cleanup (sensible but not stable material).
>>>
>>> Please split the patch into two.
>> No problem at all.
> I'll probably just take them both through togreg anyway so would have
> been fine in the first place.  Sorry about that.
> 
> J
>>>
>>> Thanks,
>>>
>>> Jonathan
>>>> ---
>>>> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
>>>> index e336af7..b541646 100644
>>>> --- a/drivers/iio/humidity/si7020.c
>>>> +++ b/drivers/iio/humidity/si7020.c
>>>> @@ -45,21 +45,20 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
>>>>  			   struct iio_chan_spec const *chan, int *val,
>>>>  			   int *val2, long mask)
>>>>  {
>>>> -	struct i2c_client **client = iio_priv(indio_dev);
>>>> +	struct i2c_client *client = iio_priv(indio_dev);
>>>>  	int ret;
>>>>
>>>>  	switch (mask) {
>>>>  	case IIO_CHAN_INFO_RAW:
>>>> -		ret = i2c_smbus_read_word_data(*client,
>>>> +		ret = i2c_smbus_read_word_data(client,
>>>>  					       chan->type == IIO_TEMP ?
>>>>  					       SI7020CMD_TEMP_HOLD :
>>>>  					       SI7020CMD_RH_HOLD);
>>>>  		if (ret < 0)
>>>>  			return ret;
>>>> -		if (chan->type == IIO_TEMP)
>>>> -			*val = ret >> 2;
>>>> -		else
>>>> -			*val = (ret & 0x3FFF) >> 2;
>>>> +		*val = ret >> 2;
>>>> +		if (chan->type == IIO_HUMIDITYRELATIVE)
>>>> +			*val &= GENMASK(11, 0);
>>>>  		return IIO_VAL_INT;
>>>>  	case IIO_CHAN_INFO_SCALE:
>>>>  		if (chan->type == IIO_TEMP)
>>>> @@ -133,7 +132,6 @@ static int si7020_probe(struct i2c_client *client,
>>>>
>>>>  	data = iio_priv(indio_dev);
>>>>  	*data = client;
>>>> -	i2c_set_clientdata(client, indio_dev);
>>>>
>>>>  	indio_dev->dev.parent = &client->dev;
>>>>  	indio_dev->name = dev_name(&client->dev);
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
