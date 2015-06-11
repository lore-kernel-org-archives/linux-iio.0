Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vegas.theobroma-systems.com ([144.76.126.164]:35209 "EHLO
	mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752391AbbFKRfN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 11 Jun 2015 13:35:13 -0400
Message-ID: <5579C694.5030701@theobroma-systems.com>
Date: Thu, 11 Jun 2015 19:34:12 +0200
From: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, irina.tirdea@intel.com,
	daniel.baluta@intel.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: iio: what does in_accel_x_thresh_rising_en ?
References: <55770E56.5070701@theobroma-systems.com> <5578A2EC.4030300@kernel.org>
In-Reply-To: <5578A2EC.4030300@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 2015-06-10 um 22:49 schrieb Jonathan Cameron:
> On 09/06/15 17:03, Martin Kepplinger wrote:
>> hi
>>
>> Is the in_accel_thresh_rising_value (or falling) threshold value signed
>> or unsigned?
>>
>> In other words: Is a RISING event fired on an absolute growing value in
>> the positive range, and a FALLING event on an absolute growing value in
>> the negative acceleration range (< 0g)?
>>
>> Or is a RISING event fired on a signed rising value, no matter if the
>> threshold is positive or negative, and a FALLING event on a decreasing
>> signed value, also when the threshold is positive?
>>
>> thanks
>>
>>                                 martin
>>
> Hi Martin,
> 
> The two relevant abi elements are:
> in_accel_thresh_rising_value and
> in_accel_mag_rising_value
> Once you know the second one exists then you can probably work out the
> meaning of thresh ;)
> 
> Thresh is the value, mag(nitude) is the absolute value, so if you get one
> that is thresh, then if the channel can go negative, negative values are
> definitely possible.  On an accelerometer, you can get either implemented.
> mag_rising is typically to allow motion detection, thresh_rising might
> be used to detect a change of orientation (put bounds around each axis
> at a particular point in time.
> 
> There are also roc (rate of change) type event detectors on some accelerometers.
> 
> Hope that clear the mud up ;)
> 
> Jonathan
> 

Hi Jonathan,

Oh I overlooked, this is clear now. So
events/in_accel_x&y&z_mag_falling_en for example is
a classic freefall detection. Would an implementation here just use
in_accel_mag_falling_value ? I'm not yet sure how an iio_event_spec
would look like in that case. Freefall is what I could do in my driver.

But this was very helpful, thanks for your time!

                               martin
