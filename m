Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <547CCA2E.8010705@metafoo.de>
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
	<5474B01D.8020701@metafoo.de>
	<CAEnQRZC_ax0n2b+pTiTVLk=0m+AzX7JkRHdB=8a70d8hQ3eD-Q@mail.gmail.com>
	<5474B59B.8000101@metafoo.de>
	<5D8E0479-F926-424A-B931-8A33BD99EC31@kernel.org>
	<CAEnQRZBURtX3=d9-sy1AvgipgqcYTiiL5TCjaSwMkeJd-XYh0w@mail.gmail.com>
	<547CCA2E.8010705@metafoo.de>
Date: Mon, 1 Dec 2014 22:46:05 +0200
Message-ID: <CAEnQRZAghZOXdut4vZr-HzRqhMSF3Dv+XccWAhY_NS65BxhUVg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add valid sample channel
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Dec 1, 2014 at 10:06 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 11/26/2014 01:58 PM, Daniel Baluta wrote:
>>
>> On Tue, Nov 25, 2014 at 7:29 PM, Jonathan Cameron <jic23@kernel.org>
>> wrote:
>>>
>>>
>>>
>>> On November 25, 2014 5:00:11 PM GMT+00:00, Lars-Peter Clausen
>>> <lars@metafoo.de> wrote:
>>>>
>>>> On 11/25/2014 05:55 PM, Daniel Baluta wrote:
>>>>>
>>>>> On Tue, Nov 25, 2014 at 6:36 PM, Lars-Peter Clausen <lars@metafoo.de>
>>>>
>>>> wrote:
>>>>>>
>>>>>> On 11/25/2014 01:48 PM, Vlad Dogaru wrote:
>>>>>>>
>>>>>>>
>>>>>>> This is an attempt to address the problem of buffering in devices
>>>>
>>>> which
>>>>>>>
>>>>>>> have
>>>>>>> different scan frequencies for different channels.
>>>>>>
>>>>>>
>>>>>>
>>>>>> Will these frequencies still be related or completely arbitrary?
>>>>>
>>>>>
>>>>> For Kionix KMX61 we have the same set of frequencies for
>>>>> accelerometer and magnetometer (12.5, 25, 50, 100 Hz, etc)
>>>>> but for example at some point accel can be configured with 100 Hz
>>>>> and magnetometer with 12.5Hz.
>>>>>
>>>>> Does this matter?
>>>>
>>>>
>>>> I'm wondering if it makes more sense to register multiple buffers or
>>>> devices
>>>> if the frequencies are completely unrelated. E.g. in the KMX61 case it
>>>> looks
>>>> as if its simply two logical devices in the same physical package.
>>
>>
>> I think this makes a lot of sense for kmx61 and offers a cleaner
>> interface to user space.
>>
>>>>
>>>> - Lars
>>>
>>> That is how we have handled this so far.
>>> Sometimes we have separate iio_devices for
>>> the logical functions e.g. hid-sensors and sometimes just multiple
>>> buffers.. I am
>>>   struggling to find it now but one of the ADC drivers had a insanely
>>> complex nest
>>>   sampling arrangement requiring 8 buffers. Final driver might have been
>>> simplified though...  We might still need a few tweaks
>>>   for multiple buffers not to having naming clashes....  Moving house so
>>> only have phone to hand!
>>
>>
>> I looked into iio/adc/ and iio/imu/ but couldn't find any driver which
>> has one IIO device  and multiple buffers. I don't see how this can
>> work :).
>>
>> User space application will read /dev/iio:deviceX to get data
>> samples. How would they know the source of the data samples?
>
>
> What exactly do you mean by source?

By source I mean accelerometer or magnetometer in the case of KMX61 sensor.

>
>>
>> Let me know where is the source code for the 8 buffers ADC driver,
>> I am very curious about the implementation :).
>
>
> I think that one never made it into upstream or got reworked before.

Ok :)
