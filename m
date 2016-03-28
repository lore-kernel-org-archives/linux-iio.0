Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46144 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbcC1QKV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 12:10:21 -0400
Subject: Re: [PATCH 4/6] iio: accel: bmg160: optimize transfers in trigger
 handler
To: "Tirdea, Irina" <irina.tirdea@intel.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1458811771-25217-1-git-send-email-irina.tirdea@intel.com>
 <1458811771-25217-5-git-send-email-irina.tirdea@intel.com>
 <56F8FFED.2090703@kernel.org> <alpine.DEB.2.02.1603281158290.4312@pmeerw.net>
 <56F93C53.6070606@kernel.org>
 <1F3AC3675D538145B1661F571FE1805F2F215588@irsmsx105.ger.corp.intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Purdila, Octavian" <octavian.purdila@intel.com>,
	Markus Pargmann <mpa@pengutronix.de>,
	"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F9576A.8050007@kernel.org>
Date: Mon, 28 Mar 2016 17:10:18 +0100
MIME-Version: 1.0
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F215588@irsmsx105.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/16 17:03, Tirdea, Irina wrote:
> 
> 
>> -----Original Message-----
>> From: Jonathan Cameron [mailto:jic23@kernel.org]
>> Sent: 28 March, 2016 17:15
>> To: Peter Meerwald-Stadler
>> Cc: Tirdea, Irina; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Hartmut Knaack; Lars-Peter Clausen; Purdila, Octavian;
>> Markus Pargmann; Pandruvada, Srinivas
>> Subject: Re: [PATCH 4/6] iio: accel: bmg160: optimize transfers in trigger handler
>>
>> On 28/03/16 11:09, Peter Meerwald-Stadler wrote:
>>>
>>>>> Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
>>>>> enable/disable the bus at each i2c transfer and must wait for
>>>>> the enable/disable to happen before sending the data.
>>>>>
>>>>> When reading data in the trigger handler, the bmc150 accel driver does
>>>
>>> should refer to bmg160
>> Good spot.  It's also a gyroscope, not an accelerometer... I just fixed this
>> up and repushed out testing.
>>>
> Oops... too much copy-paste :)
> 
>>>>> one bus transfer for each axis. This has an impact on the frequency
>>>>> of the accelerometer at high sample rates due to additional delays
>>>>> introduced by the bus at each transfer.
>>>>>
>>>>> Reading all axis values in one bus transfer reduces the delays
>>>>> introduced by the bus.
>>>>>
>>>>> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
>>>> I forgot to highlight on the earlier driver that there is also 'technically'
>>>> a bit of an ABI change here because we are now exporting as LE rather than CPU
>>>> order.  However, I 'hope' anyone actually accessing the buffered data is either
>>>> doing it through a nice library or hasn't hacked the endian unwinding out of
>>>> the generic_buffer example!
>>>
>>> the patch takes away the possibility to do buffered reads on individual
>>> channels (not sure if this is useful per se)
>>>
>>> this optimizes for the common case, ok;
>>>
>>> wondering if adding
>>> .endianness = IIO_LE
>>> is actually an unrelated fix
>> Good point, when I first read the code I assumed we were moving from an i2c_word
>> read to a bulk read, thus necessitating this addition.  However, we aren't as it
>> was previously as an i2c_bulk read of 2 bytes...
>>
>> Irina, could you confirm if this was broken before your patches?
>>
> 
> Peter is right. I also had in mind the change from i2c_word to bulk read, but
> the regmap API has changed this in the meantime.
> 
> Since the driver uses regmap_bulk_read to read 2 bytes for each
> axis, the data read will have the endianness of the device (little endian)
> and we should do endianness conversion or else it will not work on big
> endian platforms.
> 
>> I'll leave this as is, perhaps we need an additional fix patch specifying LE to
>> put out as a fix.
> 
> There is one more place in both bmc150 and bmg160 drivers where 
> regmap_bulk_read is used without endianness conversion (when reading raw axes).
> I will send a separate patch to fix all endianness issues.
> 
> While looking at the existent code, I also found another bug in the bmg160 driver 
> that this patch fixes as a side effect: the error code returned by regmap_bulk_read
> is saved in the data->buffer instead of the value read. Not sure how to handle this,
> since it is fixed now by this patch. Jonathan, should I send a fix patch for this? 
Send a patch against, fixes-togreg, or given timing fixes-togreg-post-rc1 as appropriate
but put a comment in there saying it was also fixed in "adfasfaf" so that the merge
is obvious when the two hit each other - hopefully in Greg's tree...

Jonathan
> 
> Thanks,
> Irina
> 
>>>
>>>> Again, fingers crossed this doesn't break anything significant.
>>>>
>>>> Applied,
>>>>
>>>> Thanks,
>>>>
>>>> Jonathan
>>>>> ---
>>>>>  drivers/iio/gyro/bmg160_core.c | 17 ++++++-----------
>>>>>  1 file changed, 6 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
>>>>> index 8d6e5b1..43570b8 100644
>>>>> --- a/drivers/iio/gyro/bmg160_core.c
>>>>> +++ b/drivers/iio/gyro/bmg160_core.c
>>>>> @@ -734,6 +734,7 @@ static const struct iio_event_spec bmg160_event = {
>>>>>  		.sign = 's',						\
>>>>>  		.realbits = 16,					\
>>>>>  		.storagebits = 16,					\
>>>>> +		.endianness = IIO_LE,					\
>>>>>  	},								\
>>>>>  	.event_spec = &bmg160_event,					\
>>>>>  	.num_event_specs = 1						\
>>>>> @@ -773,20 +774,14 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
>>>>>  	struct iio_poll_func *pf = p;
>>>>>  	struct iio_dev *indio_dev = pf->indio_dev;
>>>>>  	struct bmg160_data *data = iio_priv(indio_dev);
>>>>> -	int bit, ret, i = 0;
>>>>> -	unsigned int val;
>>>>> +	int ret;
>>>>>
>>>>>  	mutex_lock(&data->mutex);
>>>>> -	for (bit = 0; bit < AXIS_MAX; bit++) {
>>>>> -		ret = regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(bit),
>>>>> -				       &val, 2);
>>>>> -		if (ret < 0) {
>>>>> -			mutex_unlock(&data->mutex);
>>>>> -			goto err;
>>>>> -		}
>>>>> -		data->buffer[i++] = ret;
>>>>> -	}
>>>>> +	ret = regmap_bulk_read(data->regmap, BMG160_REG_XOUT_L,
>>>>> +			       data->buffer, AXIS_MAX * 2);
>>>>>  	mutex_unlock(&data->mutex);
>>>>> +	if (ret < 0)
>>>>> +		goto err;
>>>>>
>>>>>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>>>>>  					   pf->timestamp);
>>>>>
>>>>
>>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

