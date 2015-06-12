Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <5579C694.5030701@theobroma-systems.com>
References: <55770E56.5070701@theobroma-systems.com> <5578A2EC.4030300@kernel.org> <5579C694.5030701@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: iio: what does in_accel_x_thresh_rising_en ?
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Fri, 12 Jun 2015 06:56:19 +0100
To: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,Jonathan Cameron <jic23@kernel.org>,irina.tirdea@intel.com,daniel.baluta@intel.com
CC: linux-iio@vger.kernel.org,linux-kernel@vger.kernel.org
Message-ID: <5681CA97-FB2B-4D7C-A163-3B75324DD0BE@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 11 June 2015 18:34:12 BST, Martin Kepplinger <martin.kepplinger@theobroma-systems.com> wrote:
>Am 2015-06-10 um 22:49 schrieb Jonathan Cameron:
>> On 09/06/15 17:03, Martin Kepplinger wrote:
>>> hi
>>>
>>> Is the in_accel_thresh_rising_value (or falling) threshold value
>signed
>>> or unsigned?
>>>
>>> In other words: Is a RISING event fired on an absolute growing value
>in
>>> the positive range, and a FALLING event on an absolute growing value
>in
>>> the negative acceleration range (< 0g)?
>>>
>>> Or is a RISING event fired on a signed rising value, no matter if
>the
>>> threshold is positive or negative, and a FALLING event on a
>decreasing
>>> signed value, also when the threshold is positive?
>>>
>>> thanks
>>>
>>>                                 martin
>>>
>> Hi Martin,
>> 
>> The two relevant abi elements are:
>> in_accel_thresh_rising_value and
>> in_accel_mag_rising_value
>> Once you know the second one exists then you can probably work out
>the
>> meaning of thresh ;)
>> 
>> Thresh is the value, mag(nitude) is the absolute value, so if you get
>one
>> that is thresh, then if the channel can go negative, negative values
>are
>> definitely possible.  On an accelerometer, you can get either
>implemented.
>> mag_rising is typically to allow motion detection, thresh_rising
>might
>> be used to detect a change of orientation (put bounds around each
>axis
>> at a particular point in time.
>> 
>> There are also roc (rate of change) type event detectors on some
>accelerometers.
>> 
>> Hope that clear the mud up ;)
>> 
>> Jonathan
>> 
>
>Hi Jonathan,
>
>Oh I overlooked, this is clear now. So
>events/in_accel_x&y&z_mag_falling_en for example is
>a classic freefall detection. Would an implementation here just use
>in_accel_mag_falling_value ?
Either that or the one for the particular event (with the x&y&z )both are valid and
 user space should check for them.
Note some accelerometers use the sum of squares for free fall detection though I
 guess your one doesn't!

 I'm not yet sure how an iio_event_specbit)ould look like in that case. Freefall is what I could do in my driver.
Err can't remember exact syntax but you have two entries. One with
 the enable and one with the value part.
Should be other drivers doing this though normally because a single value is used
 for multiple separate threshold detectors.
>
>But this was very helpful, thanks for your time!
>
>                               martin

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
