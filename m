Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44392 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbaFUL7X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 21 Jun 2014 07:59:23 -0400
Message-ID: <53A57414.8000104@kernel.org>
Date: Sat, 21 Jun 2014 13:01:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: Reyad Attiyat <reyad.attiyat@gmail.com>, linux-iio@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: User-space API for accelerometer(s)?
References: <1403100542.30918.29.camel@nuvo>	 <CA+BWVUSqrJhFwKXHL5q=mwcxmasfkpNB6EqEXC6jPfg0ytOVzA@mail.gmail.com>	 <53A224AB.9090305@linux.intel.com> <1403176834.30918.32.camel@nuvo>
In-Reply-To: <1403176834.30918.32.camel@nuvo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/06/14 12:20, Bastien Nocera wrote:
> On Wed, 2014-06-18 at 16:45 -0700, Srinivas Pandruvada wrote:
>> On 06/18/2014 04:31 PM, Reyad Attiyat wrote:
>>> Hello Bastien Nocera,
>>>
>>> I'm not the best person to answer your questions but I will try and
>>> help. The best people to talk to would be Jonathan Cameron, the IIO
>>> maintainer, and Srinivas Pandruvada, the author of the hid-sensor-hub
>>> device drivers. I have CC'ed them for you to hopefully get a better
>>> response than what I can offer.
>>>
>>> Your device uses the same sensor hub, over usb, as my device does. I
>>> have a Microsoft Surface and it also uses many of the sensors found on
>>> the Lenovo Yoga.
>>>
>>>> So, my question regarding the IIO user-space API is:
>>>> is it possible to make the IIO accelerometer send out a kevent when the
>>>> orientation changes in a major way (using triggers?) or does user-space
>>>> need to poll the device instead?
>>
>> You can check a program called generic_buffer.c in
>> "drivers/staging/iio/Documentation". I have used this as a reference to
>> port to Android.
>> You don't need to poll, you can also check
>> "https://github.com/pfps/yoga-laptop/sensors " developed by Peter F.
>> Patel-Schneider.
>
> I've read this code, and in fact, I mentioned it in my original mail. I
> fail to see how this code isn't polling. It's also much more complicated
> than doing the same thing for a evdev accelerometer.
>
Just to throw it in there.  There is an out of tree bridge driver from
IIO to input.  It's only out of tree because I haven't had a chance to
tidy it up (anyone else is welcome to take this on if they like!)
Google for iio_input.c to find it.

The intent of that was to allow general accelerometer drivers and similar
in IIO to work in conjunction with iio-input to provide input style interfaces.
This came about after previous debates on where the 'right' place for
accelerometers was in the kernel. I believe that at least in principle,
Dmitry was happy with this concept.

Jonathan


