Return-Path: <Josh.wu@atmel.com>
Message-ID: <521B27F3.1050203@atmel.com>
Date: Mon, 26 Aug 2013 18:03:31 +0800
From: Josh Wu <josh.wu@atmel.com>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>, <jic23@cam.ac.uk>,
	<linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<plagnioj@jcrosoft.com>, <nicolas.ferre@atmel.com>,
	<thomas.petazzoni@free-electrons.com>, <mark.rutland@arm.com>,
	<b.brezillon@overkiz.com>
Subject: Re: [PATCH v2 2/4] iio: at91: Use different prescal, startup mask
 in MR for different IP
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com> <1376219071-29946-3-git-send-email-josh.wu@atmel.com> <20130815192044.GD12162@lukather> <5215DF2C.3050502@atmel.com> <5215DF7C.2020909@atmel.com> <20130823154603.GA7468@ludovic.desroches@atmel.com> <20130823165936.GC1230@lukather> <20130826083207.GB7468@ludovic.desroches@atmel.com>
In-Reply-To: <20130826083207.GB7468@ludovic.desroches@atmel.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi, Ludovic and Maxime

On 8/26/2013 4:32 PM, Ludovic Desroches wrote:
> On Fri, Aug 23, 2013 at 06:59:36PM +0200, Maxime Ripard wrote:
>> Hi Ludovic, Josh,
>>
>> On Fri, Aug 23, 2013 at 05:46:03PM +0200, Desroches, Ludovic wrote:
>>> On Thu, Aug 22, 2013 at 05:53:00PM +0800, Josh Wu wrote:
>>>> On 8/22/2013 5:51 PM, Josh Wu wrote:
>>>>> Hi, Maxime
>>>>>
>>>>> On 8/16/2013 3:20 AM, Maxime Ripard wrote:
>>>>>> Hi Josh,
>>>>>>
>>>>>> On Sun, Aug 11, 2013 at 07:04:29PM +0800, Josh Wu wrote:
>>>>>>> For at91 boards, there are different IPs for adc. Different IPs has
>>>>>>> different STARTUP & PRESCAL mask in ADC_MR.
>>>>>>>
>>>>>>> This patch introduce the multiple compatible string for those
>>>>>>> different IPs.
>>>>>>>
>>>>>>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>>>>>> Overall it looks like the right ways, but I think we can take it a step
>>>>>> further.
>>>>>>
>>>>>> I'd drop at least the atmel,adc-drdy-mask, atmel,adc-num-channels,
>>>>>> atmel,adc-status-register, atmel,adc-trigger-register properties (and
>>>>>> probably the triggers as well description as well).
>>>>> yeah, right. Currently I want to drop following:
>>>>>
>>>>> atmel,adc-drdy-mask, atmel,adc-status-register,
>>>>> atmel,adc-trigger-register, atmel,adc-channel-base
>>>>>
>>>>> For the adc-num-channels, I'd like to leave it in dt parameters.
>>>>> It is a description for an adc capablity.
>>> About this parameter, I'll remove it too from the dt bindings. To set it you
>>> need to have a look to the datasheet and to copy a constant value into the
>>> dt. From my point of view, it means than this parameter should be managed by
>>> the driver and by the dt.
>>>
>>> On the other side since there are some dynamic allocation depending on this
>>> parameter maybe it makes sense to keep it in the dt. If the user wants to use
>>> only 2 channels why doing allocation for max channel number. By the way, this
>>> case is only valid if he uses the two first channels.
>> I don't recall it very well, is there any reason to not have it in the
>> DT? Can the ADC channels be used for something else? Or is it just some
>> IP-specific number of channels?
>>
> It is IP-specific. I don't see what benefit we could have to keep it in the DT?
> But Josh seems to have arguments to keep it.

I'm ok to remove the channel number. What I worried is there also has a 
channel-used mask in DT.
This mask should be removed too if channel number is removed.
So maybe we can also use the sysfs to set the mask.

>
>>>>> For the triggers, I am not decided. An obvious benifit to remove
>>>>> trigger in dt will save many lines of code.
>>>>>
>>>>>> Maxime
>>>>>>
>>>>> Best Regards,
>>>>> Josh Wu
>>> Since we are talking about reworking this binding I was thinking about
>>> resolution stuff. Filling atmel,adc-res is also copying constant value from
>>> the device datasheet, so if I was consistent I would say it has to be removed
>>> too. But I am not consistent! I mean by doing this the only thing the user
>>> will have to fill is the resolution value. He can't set the value he wants,
>>> there are only two choices. By keeping it into the dt then he will immediately
>>> see the choices he has.
>> But the resolution should probably be somehow user-defined, probably not
>> really related to the DT has well. I think some other IIO ADC drivers
>> are using sysfs files for this purpose, maybe that would be a better
>> fit?
> It sounds to be a good solution.

ok, I will check the other IIO ADC driver about this point.
Maybe this sysfs replacement need a bit more time. I prefer to send out 
the patches first without the sysfs implement in v3.
And the sysfs replacement patch will be send out serperately. What do 
you think? Maxime.

>
>
> Ludovic

Best Regards,
Josh Wu
