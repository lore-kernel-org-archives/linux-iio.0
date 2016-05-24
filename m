Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60562 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbcEXI5w (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 May 2016 04:57:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 24 May 2016 09:57:46 +0100
From: jic23@jic23.retrosnub.co.uk
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio-owner@vger.kernel.org
Subject: Re: [RFC] iio: accel: st_accel: Add lis3l02dq support
In-Reply-To: <CACRpkdZsqKcrQKUhY7U-VkZodUbNo8BoaesFMHvLcYTAGGDLcw@mail.gmail.com>
References: <1463945969-18866-1-git-send-email-jic23@kernel.org>
 <CACRpkdYBueNxSa60EfTWsX7Surmvee8V0Qbgn+CrsA_joMmxQg@mail.gmail.com>
 <5c264bf8b6206f0ce4f581607336d6de@jic23.retrosnub.co.uk>
 <71875CD9-27C6-4DC5-9F78-F9486DF12612@jic23.retrosnub.co.uk>
 <CACRpkdZsqKcrQKUhY7U-VkZodUbNo8BoaesFMHvLcYTAGGDLcw@mail.gmail.com>
Message-ID: <e87f23b2a743dd174bf19f62255b929f@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24.05.2016 09:45, Linus Walleij wrote:
> On Mon, May 23, 2016 at 6:29 PM, Jonathan Cameron
> <jic23@jic23.retrosnub.co.uk> wrote:
> 
>> I forgot this part also has gain and offset trim registers.  Will add 
>> them before
>>  applying as that is easy enough and reduces the differences further.
>> 
>> These exist on some other parts but we can add them any time.
> 
> LIS3LV02DL also has x,y,z offset and gain trim registers, but when
> I read up on it, I understood that these are just factory-programmed
> registers. I.e. they are undocumented in the register list, but a table
> states them as "calibration" and "loaded at boot".
> 
> So I always understood them as something the sensor loads at
> boot to calibrate itself, so you can ignore the contents, and they
> probably exist on the other sensors too, albeit undocumented as
> they have no use.
> 
> I toyed with the idea of reading them and pusing the values to the
> entropy pool with add_device_randomness() as they are device-unique
> data.
> 
> But if you have proper docs on them I guess maybe they are used
> differently on your sensor...
> 
> Yours,
> Linus Walleij
As I understand it you can actually apply corrections to them (was 
certainly
how I read that years ago).  Take into account that these early sensors 
were
incredibly noisy and perhaps more prone to shock damage than newer ones.
(my test sensor will vary by 10% or more whilst sat on a steady concrete
floor - even with huge levels of oversampling...)

Back then we were using some sensors where if you dropped them on the 
floor
you had to send them back to the manufacturer for recalibration before 
they
were remotely useful again.

Funnily enough, given we had them attached to people that happened all 
the
time :(

ST certainly aren't believers in 'detailed' documentation. Always feels
like somewhat of a guessing game when implementing drivers for their
parts.

J
