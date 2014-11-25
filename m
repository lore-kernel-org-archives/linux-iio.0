Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36295 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaKYR3m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Nov 2014 12:29:42 -0500
In-Reply-To: <5474B59B.8000101@metafoo.de>
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com> <5474B01D.8020701@metafoo.de> <CAEnQRZC_ax0n2b+pTiTVLk=0m+AzX7JkRHdB=8a70d8hQ3eD-Q@mail.gmail.com> <5474B59B.8000101@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 0/4] Add valid sample channel
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 25 Nov 2014 17:29:33 +0000
To: Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>
CC: Vlad Dogaru <vlad.dogaru@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <5D8E0479-F926-424A-B931-8A33BD99EC31@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On November 25, 2014 5:00:11 PM GMT+00:00, Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 11/25/2014 05:55 PM, Daniel Baluta wrote:
>> On Tue, Nov 25, 2014 at 6:36 PM, Lars-Peter Clausen <lars@metafoo.de>
>wrote:
>>> On 11/25/2014 01:48 PM, Vlad Dogaru wrote:
>>>>
>>>> This is an attempt to address the problem of buffering in devices
>which
>>>> have
>>>> different scan frequencies for different channels.
>>>
>>>
>>> Will these frequencies still be related or completely arbitrary?
>>
>> For Kionix KMX61 we have the same set of frequencies for
>> accelerometer and magnetometer (12.5, 25, 50, 100 Hz, etc)
>> but for example at some point accel can be configured with 100 Hz
>> and magnetometer with 12.5Hz.
>>
>> Does this matter?
>
>I'm wondering if it makes more sense to register multiple buffers or
>devices 
>if the frequencies are completely unrelated. E.g. in the KMX61 case it
>looks 
>as if its simply two logical devices in the same physical package.
>
>- Lars
That is how we have handled this so far.
Sometimes we have separate iio_devices for
the logical functions e.g. hid-sensors and sometimes just multiple buffers.. I am
 struggling to find it now but one of the ADC drivers had a insanely complex nest
 sampling arrangement requiring 8 buffers. Final driver might have been simplified though...  We might still need a few tweaks
 for multiple buffers not to having naming clashes....  Moving house so only have phone to hand!

Jonathan
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
