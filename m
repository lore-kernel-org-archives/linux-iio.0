Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35882 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbbFKJTR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 11 Jun 2015 05:19:17 -0400
MIME-Version: 1.0
In-Reply-To: <5573615A.7010901@kernel.org>
References: <1432810354-24745-1-git-send-email-daniel.baluta@intel.com>
	<alpine.DEB.2.02.1505281300180.30008@pmeerw.net>
	<CAEnQRZDioRjc0nLLncYitkjW7QyC4z+Ha6VE82h2RUScyXFx-Q@mail.gmail.com>
	<alpine.DEB.2.02.1505281507511.30008@pmeerw.net>
	<CAEnQRZD1FNdW_3XZ13uane-VeHN9fVQue6z_j-3=3eYvgHNL9w@mail.gmail.com>
	<CAEnQRZAcXQUp4Y0PZQaoQBa_G-HvbnKg6J_HxAfwa_F51vqsxg@mail.gmail.com>
	<5573615A.7010901@kernel.org>
Date: Thu, 11 Jun 2015 12:19:15 +0300
Message-ID: <CAEnQRZDYesY2k=mciBM_i9yVx3TpaszUeONuf7WU24stO0Kj9g@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: Add support for ROHM RPR0521 sensor
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, mranostay@gmail.com
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jun 7, 2015 at 12:08 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>
>
> On 06/03/2015 09:56 AM, Daniel Baluta wrote:
>>
>> On Thu, May 28, 2015 at 5:17 PM, Daniel Baluta <daniel.baluta@intel.com>
>> wrote:
>>>
>>> <snip>
>>>
>>>>>>> +static const struct iio_chan_spec rpr0521_channels[] = {
>>>>>>> +     {
>>>>>>> +             .type = IIO_INTENSITY,
>>>>>>> +             .modified = 1,
>>>>>>> +             .address = RPR0521_CHAN_ALS_DATA0,
>>>>>>> +             .channel2 = IIO_MOD_LIGHT_BOTH,
>>>>>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>>>>> +                     BIT(IIO_CHAN_INFO_CALIBSCALE),
>>>>>>
>>>>>>
>>>>>> why CALIBSCALE and not SCALE?
>>>>>
>>>>>
>>>>> Because this is used to set/get gain, which is used by the hardware
>>>>> to do proper scaling.
>>>>>
>>>>> AFAIK this should be calibscale.
>>>>
>>>>
>>>> in sysfs-bus-iiof on CALIBSCALE: Hardware applied calibration scale
>>>> factor
>>>> (assumed to fix production inaccuracies).
>>>>
>>>> this doesn't seem applicable here, it is a gain factor controlling
>>>> measurement resolution
>>>
>>>
>>> Ok, I see now and it makes sense :).
>>>
>>> # echo 1 > in_intensity_ir_calibscale
>>> # cat in_intensity_ir_raw
>>> 79
>>> # echo 64 > in_intensity_ir_calibscale
>>> # cat in_intensity_ir_raw
>>> 5084
>>>
>>> The user should get the same value regardless of the gain :), and in the
>>> above example for x64 gain it should have a 1/64 scale.
>>>
>>>
>>> <snip>
>>>
>>>>> Or we can consider that the chan->type is always valid?
>>>>
>>>>
>>>> I'd think so; you also assume that chan->address is valid
>>>>
>>>> I suggest to use chan->address to point to a table containing the
>>>> address and the mask
>>>
>>>
>>> <snip>
>>>
>>>>> Which sensors? It means they do not agree with the ABI:
>>>>>
>>>>>
>>>>> http://lxr.free-electrons.com/source/Documentation/ABI/testing/sysfs-bus-iio#L1131
>>>>
>>>>
>>>> that 'clarification' was added recently,
>>>> 614e8842ddf5502f0e781f91695bfbc1e1e1d9b6 (with 3.18)
>>>> "Proximity measurement .. by observing reflectivity"
>>>>
>>>> high proximity <-> high reflectivity -- this is the reality of what most
>>>> sensors output (including yours)
>>>>
>>>> proximity and distance are opposite concepts;
>>>> high proximity <-> low distance, and vice versa
>>>>
>>>> the distance part doesn't make sense in the ABI description
>>>
>>>
>>> At least sx9500 uses this convention and userspace applications rely on
>>> this.
>>
>>
>> OK, so wee need to agree on this part and to add a proper descriptor to
>> the ABI.
>>
>> Jonathan, what do you say?
>>
> I agree that we need to agree one way or the other.  Proximity being higher
> as you get closer seems slightly more logical to me
> (I wish now that I'd argued in favour of just doing distance, but such
> is hindsight).  Still I'm happy with whatever consensus forms.

+ Matt.

Ok, now I see where the ambiguity comes from. The ABI for proximity also
covers AS3935 Franklin Lightning Sensor IC, where sensor's output provides
an estimation on the distance to the head of a storm :).

But, I don't think this is the type of proximity most of people think of :).

I am not sure how to modify the ABI without breaking the AS3935, but I will
think of a solution and send a RFC as soon as possible.

thanks,
Daniel.
