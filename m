Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42549 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbaKENfn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 08:35:43 -0500
Message-ID: <545A27AB.3060606@kernel.org>
Date: Wed, 05 Nov 2014 13:35:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Lars-Peter Clausen <lars@metafoo.de>, pmeerw@pmeerw.net,
	knaack.h@gmx.de
CC: linux-iio@vger.kernel.org, james.hartley@imgtec.com,
	abrestic@chromium.org, Phani Movva <Phani.Movva@imgtec.com>
Subject: Re: [PATCH 1/2] iio: adc: Cosmic Circuits 10001 ADC driver
References: <1414615531-26172-1-git-send-email-ezequiel.garcia@imgtec.com> <1414615531-26172-2-git-send-email-ezequiel.garcia@imgtec.com> <5453C494.4030906@metafoo.de> <54596172.9090908@imgtec.com>
In-Reply-To: <54596172.9090908@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/11/14 23:29, Ezequiel Garcia wrote:
> Hi everyone,
> 
> Thanks for the review. I've fixed most of the comments except for the
> invalid sample representation issue.
> 
> On 10/31/2014 02:19 PM, Lars-Peter Clausen wrote:
>> On 10/29/2014 09:45 PM, Ezequiel Garcia wrote:
>>> From: Phani Movva <Phani.Movva@imgtec.com>
>>>
>>> This commit adds support for Cosmic Circuits 10001 10-bit ADC device.
>>>
>>> Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
>>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>>> [Ezequiel: code style cleaning]
>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>
>> Looks very good. Just a few very minor issues.
>>
>> [...]
>>> +static int cc_adc_poll_done(struct iio_dev *dev, int channel,
>>> +                unsigned int delay)
>>> +{
>>> +    struct cc_10001_adc_device *adc_dev = iio_priv(dev);
>>> +    int val = INVALID_SAMPLED_OUTPUT;
>>
>> I'm not so sure that returning a fake sample is such a good idea. When
>> reading from sysfs we should definitely return an error if there is one.
> 
> Right.
> 
>> For buffer reading dropping the sample is probably not such a good idea,
>> but we should agree on and document a standard representation of invalid
>> samples.
>>
> 
> Hm, sure. What do you suggest? I can't see other drivers doing anything
> like this.
> 
It's ancient, but I vaguely recall one driver (can't find it right now
- may no longer exist) in which the try to reenable on the trigger
could detect that it had missed a sample (as the interrupt had
not fallen) and so would fire off the trigger again...
In that particular case we set the timestamp to 0 to indicate that we
new there was a sample but didn't know when it was captured.

Not really the same, but there are nasty to handle corner cases we ought
to include in any discussion of invalid data...

Is this a real issue - or are we talking, in event of hardware failure or
bug?  If so I'd spit a warning out to the logs and probably push nothing
at all into the buffer.

A magic flag on the buffer would be nice, but in general there is nowhere
to put it without in some cases greatly increasing the buffer element size.
I suppose we could have an error flag for the buffer to say, 'something
missed' though...

Alternatively we 'could' have drivers expose their own 'INVALID' flag via
a sysfs attribute...
