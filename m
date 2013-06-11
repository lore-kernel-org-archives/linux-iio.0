Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-121.synserver.de ([212.40.185.121]:1074 "EHLO
	smtp-out-120.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754753Ab3FKVI2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2013 17:08:28 -0400
Message-ID: <51B791D1.9020105@metafoo.de>
Date: Tue, 11 Jun 2013 23:08:33 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: Jonathan Cameron <jic23@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio/kern: consider the case where channel number > number
 of channels
References: <1370878955-31880-1-git-send-email-bigeasy@linutronix.de> <51B7809A.1030804@kernel.org> <20130611204416.GA13883@roeck-us.net>
In-Reply-To: <20130611204416.GA13883@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/2013 10:44 PM, Guenter Roeck wrote:
> On Tue, Jun 11, 2013 at 08:55:06PM +0100, Jonathan Cameron wrote:
>> On 06/10/2013 04:42 PM, Sebastian Andrzej Siewior wrote:
>>> On the am335x I export ADC channels indexed by their number as specified
>>> in the datasheet. The channels are shared between the TSC & ADC and be
>>> used either by TSC or the ADC. So it is possible that the TSC uses
>>> chanels 0 & 1 and the ADC is using channels 2 & 3. The total number of
>>> channles of the ADC is 2 but the individual numbers are 2 and 3.
>>> This patch changes the check for the the requesting channel by walking
>>> over the list and comparing the channel number.
>>>
>> This doesn't work in general.  The index is not the same as channel
>> (or any other form of index present). Note that modified channels may
>> all have channel set to 0  (accel_x, accel_y etc for instance).
>>
>> The index refers directly into those channels registered.
>> Is it possible for channels to move at runtime between the two units?
>> I would imagine not as this is very much a case of wiring.
>>
>> Thus we have a fairly messy bit if interdependence in the device
>> tree but it should work.
>>
>> I don't actually have much / any real experience of device tree configurations
>> and this is Guenter's code, hence I have cc'd him.
>>
>> Note that it is acceptable and relatively common to have missing
>> values in scan_index but that isn't really relevant here.
>>
>> Jonathan
>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>> ---
>>>  drivers/iio/inkern.c |   13 ++++++-------
>>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>>> index dca4eed..1a40077 100644
>>> --- a/drivers/iio/inkern.c
>>> +++ b/drivers/iio/inkern.c
>>> @@ -107,6 +107,7 @@ static int __of_iio_channel_get(struct iio_channel *channel,
>>>  	struct iio_dev *indio_dev;
>>>  	int err;
>>>  	struct of_phandle_args iiospec;
>>> +	int i;
>>>  
>>>  	err = of_parse_phandle_with_args(np, "io-channels",
>>>  					 "#io-channel-cells",
>>> @@ -123,15 +124,13 @@ static int __of_iio_channel_get(struct iio_channel *channel,
>>>  	indio_dev = dev_to_iio_dev(idev);
>>>  	channel->indio_dev = indio_dev;
>>>  	index = iiospec.args_count ? iiospec.args[0] : 0;
>>> -	if (index >= indio_dev->num_channels) {
>>> -		err = -EINVAL;
>>> -		goto err_put;
>>> +	for (i = 0; i < indio_dev->num_channels; i++) {
>>> +		if (indio_dev->channels[i].channel == index) {
>>> +			channel->channel = &indio_dev->channels[i];
>>> +			return 0;
>>> +		}
>>>  	}
> 
> Too long ago since I looked into that, but this code changes the API
> from "get nth channel" to "channel with channel index n".
> Not really sure I understand why that should be necessary.
> 

yea, this will definitively not work channels of different types will
usually have the same channel numbers.
