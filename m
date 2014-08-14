Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40032 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbaHNUco (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Aug 2014 16:32:44 -0400
Message-ID: <53ED1CE7.3070606@kernel.org>
Date: Thu, 14 Aug 2014 21:32:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: balbi@ti.com
CC: linux-iio@vger.kernel.org, pmeerw@pmeerw.net
Subject: Re: [PATCH v3] iio: ligth: add support for TI's opt3001 ligth sensor
References: <1407940605-12270-1-git-send-email-balbi@ti.com> <53ECE90A.8010609@kernel.org> <20140814170530.GB1445@saruman.home> <53ECF070.5040304@kernel.org> <20140814201744.GA4929@saruman.home>
In-Reply-To: <20140814201744.GA4929@saruman.home>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/08/14 21:17, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Aug 14, 2014 at 06:22:56PM +0100, Jonathan Cameron wrote:
>> On 14/08/14 18:05, Felipe Balbi wrote:
>>> hi,
>>>
>>> On Thu, Aug 14, 2014 at 05:51:22PM +0100, Jonathan Cameron wrote:
>>>> On 13/08/14 15:36, Felipe Balbi wrote:
>>>>> TI's opt3001 light sensor is a simple and yet powerful
>>>>> little device. The device provides 99% IR rejection,
>>>>> Automatic full-scale, very low power consumption and
>>>>> measurements from 0.01 to 83k lux.
>>>>>
>>>>> This patch adds support for that device using the IIO
>>>>> framework.
>>>>>
>>>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>>> Please fix your patch title spelling of light!
>>>
>>> alright done and sent another version too.
>>>
>>>> I'm not keen on the ordering during remove and
>>>> your use of hysteresis does not conform to the ABI so please
>>>> take a look at that and the other drivers that make use of it.
>>>
>>> see below
>>>
>>>> Hystersis is documented in Documentation/ABI/testing/sysfs-bus-iio
>>>>
>>>> Specifies the hysteresis of threshold that the device is comparing
>>>> 	against for the events enabled by
>>>> 	<type>Y[_name]_thresh[_(rising|falling)]_hysteresis.
>>>
>>> this is exactly what the driver is doing, read again
>> This is really hard without access to the datasheet.  It appeared you were
>> simply enabling hystersis on an event if the threshold was written to that.
>>
>> The threshold would be the one written by using the value attribute.
>>
>> So right now if you set hystersis to 10 then value will also be set to 10.
>>
>> Hence, if the value reaches 10 once.  An event is triggered.  After that
>> for another event the value will have to hit 10 - 10 = 0 before again
>> passing 10.
>>
>> Is this really what is happening?
> 
> yes it is. It's confusing because the same value register is used for
> hysteresis and non-hysteresis modes.
Seems decidely odd given that will mean that the hysterisis effectively means you
always have to return to 0 before you get another event...
> 
>>>>> +static int opt3001_read_id(struct opt3001 *opt)
>>>>> +{
>>>>> +	char manufacturer[2];
>>>>> +	u16 device_id;
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_MANUFACTURER_ID);
>>>>> +	if (ret < 0) {
>>>>> +		dev_err(opt->dev, "failed to read register %02x\n",
>>>>> +				OPT3001_MANUFACTURER_ID);
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	manufacturer[0] = ret >> 8;
>>>>> +	manufacturer[1] = ret & 0xff;
>>>> I would be a little 'unusual' but you could use an endian conversion here :)
>>>> Perhaps better to have the clarity of the way you have done it!
>>>
>>> byte ordering is already handled by read_word_swapped, though.
>> Fair point.  Not an endian conversion, but rather an evil bit of type
>> casting that isn't worth bothering with.
> 
> right, so what you wanna do with this ?
nope.  Realised I was being silly ;)
> 
>>>>> +static int opt3001_remove(struct i2c_client *client)
>>>>> +{
>>>>> +	struct opt3001 *opt = i2c_get_clientdata(client);
>>>>> +	int ret;
>>>>> +	u16 reg;
>>>>> +
>>>>
>>>> So here you are shutting down the part before removing the userspace interfaces
>>>> (due to using the devm_iio_unregister).  I'm guessing this might create some
>>>> interesting race conditions.  Would prefer to see non devm versions of the
>>>> register and irq request to ensure the ordering is exactly what we would
>>>> expect.
>>>
>>> this will cause no problems whatsoever. The device is *always* shutdown
>>> unless I left a continuous transfer running. This is coping with that
>>> only situation.
>> Hmm. So shutdown in this case is fairly minor and doesn't effect register
>> reads for example.  Fair enough.
> 
> no, it doesn't.
> 
>>> It's also unnecessary to check if we have a continuous
>>> transfer running because shutting down something which is already
>>> shutdown won't cause any problems with this device.
>>>
>>> Dropping devm_* would just add pointless complexity to the remove
>>> function.
>>
>> But make it obviously correct, which it isn't right now.  For the
>> cost of about 4 lines of code...
> 
> it's more than that since we'll have to add more lines of code to handle
> error inside the probe() function. Frankly, it's pretty pointless to go
> down that route; if that's really what you want, I'll do it. Coudln't
> care less, really.
> 
I would prefer it or else I'll be wondering why it is like this when
I next look at the driver a few years down the line!  Extensive commenting
would work as well, but that's probably more complex that just making the
code 'simple' from an is it right point of view!

Thanks and sorry for being a bit of a pain on this!

J
