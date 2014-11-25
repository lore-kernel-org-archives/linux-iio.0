Return-Path: <lars@metafoo.de>
Message-ID: <5474D047.4040501@metafoo.de>
Date: Tue, 25 Nov 2014 19:53:59 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: Daniel Baluta <daniel.baluta@intel.com>,
 Vlad Dogaru <vlad.dogaru@intel.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/4] Add valid sample channel
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>	<5474B01D.8020701@metafoo.de>	<CAEnQRZC_ax0n2b+pTiTVLk=0m+AzX7JkRHdB=8a70d8hQ3eD-Q@mail.gmail.com>	<5474B59B.8000101@metafoo.de>	<5D8E0479-F926-424A-B931-8A33BD99EC31@kernel.org> <CAE1zotLW8NwvorYajRbuVhwps+wJ7c1ezvDNm-X1LkgECKbAcw@mail.gmail.com>
In-Reply-To: <CAE1zotLW8NwvorYajRbuVhwps+wJ7c1ezvDNm-X1LkgECKbAcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 11/25/2014 07:27 PM, Octavian Purdila wrote:
> On Tue, Nov 25, 2014 at 7:29 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>
>>
>> On November 25, 2014 5:00:11 PM GMT+00:00, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> On 11/25/2014 05:55 PM, Daniel Baluta wrote:
>>>> On Tue, Nov 25, 2014 at 6:36 PM, Lars-Peter Clausen <lars@metafoo.de>
>>> wrote:
>>>>> On 11/25/2014 01:48 PM, Vlad Dogaru wrote:
>>>>>>
>>>>>> This is an attempt to address the problem of buffering in devices
>>> which
>>>>>> have
>>>>>> different scan frequencies for different channels.
>>>>>
>>>>>
>>>>> Will these frequencies still be related or completely arbitrary?
>>>>
>>>> For Kionix KMX61 we have the same set of frequencies for
>>>> accelerometer and magnetometer (12.5, 25, 50, 100 Hz, etc)
>>>> but for example at some point accel can be configured with 100 Hz
>>>> and magnetometer with 12.5Hz.
>>>>
>>>> Does this matter?
>>>
>>> I'm wondering if it makes more sense to register multiple buffers or
>>> devices
>>> if the frequencies are completely unrelated. E.g. in the KMX61 case it
>>> looks
>>> as if its simply two logical devices in the same physical package.
>>>
>>> - Lars
>> That is how we have handled this so far.
>> Sometimes we have separate iio_devices for
>> the logical functions e.g. hid-sensors and sometimes just multiple buffers.. I am
>>   struggling to find it now but one of the ADC drivers had a insanely complex nest
>>   sampling arrangement requiring 8 buffers. Final driver might have been simplified though...  We might still need a few tweaks
>>   for multiple buffers not to having naming clashes....  Moving house so only have phone to hand!
>>
>
> The main usage I see for a single device / buffer and multiple
> channels is to reduce the user/kernel context switch overhead in a
> sensor hub environment with lots of sensors (i.e. do a single read
> instead of one for each sensor). The improvements are going to be even
> bigger if the sensor hub supports a hardware buffer.

If those sensors run asynchronously to each other you'll end up with a lot 
of padding data which is quite likely going to negate any context switch 
overhead reduction.

>
> Some people are quite vocal about that, although I didn't see data
> that can be used to draw a relevant conclusion yet. Time to do some
> experiments, I guess :)

Yes...
