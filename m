Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58363 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbcGCOGw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 10:06:52 -0400
Subject: Re: [RFC] iio: accel: st_accel: Add lis3l02dq support
To: Linus Walleij <linus.walleij@linaro.org>
References: <1463945969-18866-1-git-send-email-jic23@kernel.org>
 <CACRpkdYBueNxSa60EfTWsX7Surmvee8V0Qbgn+CrsA_joMmxQg@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b584316d-2ac9-cb30-b7ab-6157d0dc9197@kernel.org>
Date: Sun, 3 Jul 2016 15:06:48 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdYBueNxSa60EfTWsX7Surmvee8V0Qbgn+CrsA_joMmxQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/05/16 08:43, Linus Walleij wrote:
> On Sun, May 22, 2016 at 9:39 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> Time to finally kill off the venerable (it was one of my first drivers)
>> lis3l02dq driver in favour of adding support in the st sensors framework.
>>
>> This does loose us the event support that driver always had, but I think
>> that will reappear at some point and in the meantime the maintenance
>> advantages of dropping the 'special' driver for this one part outweigh
>> the issues.
> 
> Which events? Free-fall?
> 
>> It's worth noting this part is ancient and I may well be the only person
>> who still has any on hardware running recent kernels.
> 
> What I learnt from my years in the kernel is that there is always
> a bunch of silent users, also it has this nice feeling of completing
> the ST sensor suite.
> 
>> It has a few 'quirks'.
>>  - No WAI register so that just became optional.
> 
> Makes sense.
> 
>>  - It's too quick.  Even at slowest rate (280Hz) I can't read out fast
>>    enough on my board (stargate 2) to beat new data coming in. Linus'
>>    repeat read patch doesn't help in this case. It just means I get 10
>>    readings before dying... So in reality this will get used with
>>    software triggers only unless someone has this long out of production
>>    device on a quick board.
> 
> What is the speed of the I2C bus on this system?
> If it's running on the lowest speed 100kHz that may very
> well be the cause of the problem, so check if it supports
> high speed (400kHz) I2C.
> 
> The patch as such looks good.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
I've decided I'm not that fussed about getting the threshold events
and calibration register access stuff in place before killing off
the staging driver.

As such applied and also applied is a patch dropping the old lis3l02dq
driver.  Funny how one gets mixed feelings when retiring ones own
old code.

Anyhow, lots more stuff in staging that needs dealing with!!!
Unfortunately my next target of the sca3000 is going to be a lot
harder to bring into the modern world.

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

