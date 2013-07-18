Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33454 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab3GRMCX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2013 08:02:23 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so6734592iec.41
        for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2013 05:02:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51E78230.8070602@metafoo.de>
References: <CAP9ODKq7TkBnpQSvwMRT0Cdy5wwfDGZ3E0ddP5vHkEgmskbcyg@mail.gmail.com>
	<201307180531.02207.marex@denx.de>
	<CAP9ODKqXg4DwXs3eXPrNR1j3fw4_H5bt+xwfuYMHuYgM+QrKPg@mail.gmail.com>
	<201307180608.09345.marex@denx.de>
	<51E78230.8070602@metafoo.de>
Date: Thu, 18 Jul 2013 09:02:22 -0300
Message-ID: <CAP9ODKrUcrsOVgbfm4sqv=x_Cq_Jj0aD6DwwcWHXcvVfADZAHg@mail.gmail.com>
Subject: Re: ADC setting for differential and single-ended channels
From: Otavio Salvador <otavio@ossystems.com.br>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org, Mario Goulart <mario@ossystems.com.br>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jul 18, 2013 at 2:50 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/18/2013 06:08 AM, Marek Vasut wrote:
>> Dear Otavio Salvador,
>>
>>> On Thu, Jul 18, 2013 at 12:31 AM, Marek Vasut <marex@denx.de> wrote:
>>>> Dear Otavio Salvador,
>>>>
>>>>> On Wed, Jul 17, 2013 at 4:12 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>>>> Otavio Salvador <otavio@ossystems.com.br> wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> Mario and I are working at TI ADS124x driver and this chip can be used
>>>>>>> in two ways:
>>>>>>>
>>>>>>> In case of ADS1247:
>>>>>>> - 2 differential channels
>>>>>>> - 3 single-ended channels
>>>>>>>
>>>>>>> In the first case it take two inputs and the chip returns the
>>>>>>> difference between them; in the second case it does the same but you
>>>>>>> must choose one channel to be the negative reference for all the other
>>>>>>> inputs. This is how we understood the datasheet however the
>>>>>>> single-ended use is quite confusing on it so we might be wrong.
>>>>>>>
>>>>>>> So we'd like to know the best way to handle those cases in the driver.
>>>>>>>
>>>>>>> One alternative we discussed is to use two attributes in the dts as:
>>>>>>> ...
>>>>>>> #channels = <2>;
>>>>>>> channels = <0 3
>>>>>>>
>>>>>>>                    1 2>;
>>>>>>>
>>>>>>> So it'd take two channels. One composed by input 0 and input 3 and
>>>>>>> another composed by input 1 and input 2.
>>>>>>>
>>>>>>> On the another case, we'd use:
>>>>>>>  ...
>>>>>>>  #channels = <3>
>>>>>>>  channels = <0 3
>>>>>>>
>>>>>>>                     1 3
>>>>>>>                     2 3>;
>>>>>>>
>>>>>>> So it'd take three channels and all them comparing to input 3.
>>>>>>>
>>>>>>> Are we in the right route? Any hints how to better solve this?
>>>>>>>
>>>>>> Another option is to leave it entirely up to user space.  See max1363
>>>>>> driver where both single ended and differential channels are supported
>>>>>> at the same time with care taken in buffered mode.
>>>>>>
>>>>>> Not sure if that works for your case?
>>>>>
>>>>> I think it is nicer to have it set in the dt; we need the dt anyway so
>>>>> it seems logical to get it setting  the right channel.
>>>>
>>>> Can you please elaborate why is it logical?
>>>>
>>>> I took a brief look over the datasheet [1], here are the facts I see
>>>> (correct me if I'm wrong). I first looked at Figure 51. :
>>>>
>>>> - ADS1246 has two input channels
>>>> - ADS1247 has four input channels
>>>> - ADS1428 has eight input channels
>>>>
>>>> - Each one of the 2/4/8 input channels can be connected to either P(+) or
>>>> N(-) of the amplifier (figure 53) for the ADC.
>>>>
>>>> - Apparently, according to Figure 51. , it is possible to have only one P
>>>> and one N channel enabled at time (and therefore sample only one pair of
>>>> channels with the ADC) since the P and N rails are shared by all the
>>>> inputs and there's only one ADC block.
>>>>
>>>> Therefore, the userland would have to export sysfs file for each of the
>>>> channels where one would write if the channel is possitive(+) /
>>>> negative(-) / not_connected(NC) and then trigger the start of sampling.
>>>>
>>>> What do you think?
>>>
>>> This does not make them act as differential  against each other.
>>>
>>> We can have several combinations as:
>>>
>>> 0 - P / 1 - N (differential)
>>> 0 - P / 1 - P / 2 - P / 3 - N (all differential to 3)
>>> and so on.
>>>
>>> So how userland would tell which would be the differential to use?
>>>
>>> Our board has:
>>>
>>> 0 against 1
>>> 2 against 3
>>>
>>> but it is a design choice.
>>>
>>> Am I missing something?
>>
>> echo 'P' > /sys/.../chan_mux_0
>> echo 'P' > /sys/.../chan_mux_2
>> echo 'N' > /sys/.../chan_mux_1
>> echo 'N' > /sys/.../chan_mux_3
>>
>> Like this for example ;-) And this could be nicely implemented via IIO, but I
>> believe there might even already be an IIO API for this stuff.
>
> Well the standard API as Jonathan said is to expose all possible pin
> combinations. In this case that might be up to 8x8=64 channels. In my
> opinion that's fine, but on a specific board maybe not all combinations are
> valid. So you might want to specify in your platform data or devicetree that
> only a subset of these 64 channels is valid and should be exposed to
> userspace. In my opinion it makes the most sense to handle this in the IIO
> core since this is a generic requirement, nothing specific to this chip.
> E.g. even for 'simple' converters you'll find situations where some pins
> might not be connected.

Right and how should we do this?

Because it would not be 8x8 but it has also the single-ended
combinations (using different N inputs).

So in the end, it'd have a huge number of channels in sysfs where only
few would be used. This seems confusing for user from my POV.

You said about handle this pins to be exposed in IIO core, does IIO
already provide support for it?

Please advice,

--
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://projetos.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
