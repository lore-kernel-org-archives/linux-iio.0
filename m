Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-194.synserver.de ([212.40.185.194]:1104 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752867AbbKXJpf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Nov 2015 04:45:35 -0500
Message-ID: <565431BB.2020904@metafoo.de>
Date: Tue, 24 Nov 2015 10:45:31 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Martin Kepplinger <martink@posteo.de>,
	Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
	pmeerw@pmeerw.net, christoph.muellner@theobroma-systems.com,
	mfuzzey@parkeon.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH 1/3] iio: mma8452: add freefall detection for Freescale's
 accelerometers
References: <1447267094-2248-1-git-send-email-martink@posteo.de> <5647778E.3090106@kernel.org> <56478136.3040200@posteo.de> <5647857D.5050902@kernel.org> <564B7F02.4020709@posteo.de> <5653F3A1.6010905@posteo.de>
In-Reply-To: <5653F3A1.6010905@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/24/2015 06:20 AM, Martin Kepplinger wrote:
> Am 2015-11-17 um 20:24 schrieb Martin Kepplinger:
>> Am 2015-11-14 um 20:03 schrieb Jonathan Cameron:
>>> On 14/11/15 18:45, Martin Kepplinger wrote:
>>>> Am 2015-11-14 um 19:03 schrieb Jonathan Cameron:
>>>>> On 11/11/15 18:38, Martin Kepplinger wrote:
>>>>>> This adds freefall event detection to the supported devices. It adds
>>>>>> the in_accel_x&y&z_mag_falling_en iio event attribute, which activates
>>>>>> freefall mode.
>>>>>>
>>>>>> In freefall mode, the current acceleration values of all activated axis
>>>>>> are added and if the *sum* falls *under* the threshold specified
>>>>>> (in_accel_mag_falling_value), the appropriate IIO event code
>>>>>> is generated.
>>>>>>
>>>>>> By enabling freefall mode (in_accel_x&y&z_mag_falling_en)
>>>>>> all 3 axis are enabled too as this describes a classic freefall
>>>>>> detection. Of course the user is free to disable one or more directions.
>>>>>>
>>>>>> The values of rising and falling versions of various sysfs files are
>>>>>> shared, which is compliant to the IIO specification.
>>>>>>
>>>>>> This is what the sysfs "events" directory for these devices looks
>>>>>> like after this change:
>>>>>>
>>>>>> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_falling_period
>>>>>> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_falling_value
>>>>>> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_rising_period
>>>>>> -rw-r--r--    4096 Oct 23 08:45 in_accel_mag_rising_value
>>>>>> -r--r--r--    4096 Oct 23 08:45 in_accel_scale
>>>>>> -rw-r--r--    4096 Oct 23 08:45 in_accel_x&y&z_mag_falling_en
>>>>>> -rw-r--r--    4096 Oct 23 08:45 in_accel_x_mag_falling_en
>>>>>> -rw-r--r--    4096 Oct 23 08:45 in_accel_x_mag_rising_en
>>>>>> -rw-r--r--    4096 Oct 23 08:45 in_accel_y_mag_falling_en
>>>>>> -rw-r--r--    4096 Oct 23 08:45 in_accel_y_mag_rising_en
>>>>>> -rw-r--r--    4096 Oct 23 08:45 in_accel_z_mag_falling_en
>>>>>> -rw-r--r--    4096 Oct 23 08:45 in_accel_z_mag_rising_en
>>>>>>
>>>>>> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
>>>>>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
>>>>> Looks pretty good to me (other than obviously the bits Lars already
>>>>> picked up on!)
>>>>>
>>>>> My only real comment was that you could do the rest of the combined
>>>>> possibilities whilst you are here (if you want to!)  You've
>>>>> picked the mostly obviously useful one though so maybe leave it
>>>>> at that.
>>>>
>>>> I'm not sure what you mean. There is only in_accel_x&y&z_mag_falling_en
>>>> documented. So my guess was to have this to enable freefall mode, taking
>>>> into account the currently enabled falling axis
>>>> (in_accel_x_mag_falling_en, ...).
>>> Sure, but the set of modifiers allows for
>>> in_accel_x&y_mag_falling_* etc and they aren't documented in this particular
>>> form simply because no driver has used them yet ;)
>>>
>>
>>
>>
>> I don't see how to do it in iio_event_spec only. Could you point me in
>> the right direction, could well be I overlook something...
>>
>> I *can* add a channel for freefall purposes, something like:
>>
>> static const struct iio_chan_spec mma8653_channels[] = {
>>         MMA8652_CHANNEL(IIO_MOD_X, idx_axis_x, 10),
>>         MMA8652_CHANNEL(IIO_MOD_Y, idx_axis_y, 10),
>>         MMA8652_CHANNEL(IIO_MOD_Z, idx_axis_z, 10),
>>         MMA8652_CHANNEL(IIO_MOD_X_AND_Y_AND_Z, idx_axis_xyz, 10),
>>         IIO_CHAN_SOFT_TIMESTAMP(idx_timestamp),
>> };
>>
>>
>> just as an example, but then of course I get more than just events: In
>> the device-directory:
>>
>> in_accel_x&y&z_calibbias
>> in_accel_x&y&z_raw
>> in_accel_x_calibbias
>> in_accel_x_raw
>> in_accel_y_calibbias
>> in_accel_y_raw
>> in_accel_z_calibbias
>> in_accel_z_raw
>>
>>
>> calibbias and raw are not (really) available for x&y&z. I could
>> calculate a "raw" value, but calibbias doesn't make sense here. ...But
>> again, maybe I'm on the wrong path!!
>>
>> thanks a lot!
>>
>>                               martin
>>
> 
> Would this be the way to go? And just not support the generated file
> that don't apply?

The calibbias and raw properties are added because the MMA8652_CHANNEL()
macro defines them. If you don't use that macro and don't set any of the
info masks for your x&y&z channel, but instead set the the event spec you
get a channel that only has events.

- Lars

