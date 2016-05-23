Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56346 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbcEWONw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 May 2016 10:13:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 23 May 2016 15:13:49 +0100
From: jic23@jic23.retrosnub.co.uk
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio-owner@vger.kernel.org
Subject: Re: [RFC] iio: accel: st_accel: Add lis3l02dq support
In-Reply-To: <CACRpkdYBueNxSa60EfTWsX7Surmvee8V0Qbgn+CrsA_joMmxQg@mail.gmail.com>
References: <1463945969-18866-1-git-send-email-jic23@kernel.org>
 <CACRpkdYBueNxSa60EfTWsX7Surmvee8V0Qbgn+CrsA_joMmxQg@mail.gmail.com>
Message-ID: <5c264bf8b6206f0ce4f581607336d6de@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23.05.2016 08:43, Linus Walleij wrote:
> On Sun, May 22, 2016 at 9:39 PM, Jonathan Cameron <jic23@kernel.org> 
> wrote:
> 
>> Time to finally kill off the venerable (it was one of my first 
>> drivers)
>> lis3l02dq driver in favour of adding support in the st sensors 
>> framework.
>> 
>> This does loose us the event support that driver always had, but I 
>> think
>> that will reappear at some point and in the meantime the maintenance
>> advantages of dropping the 'special' driver for this one part outweigh
>> the issues.
> 
> Which events? Free-fall?
Both high and low acceleration limits - I never got into the full 
complexity
it supports in the hardware (and and or boolean logic of the various 
signals).
> 
>> It's worth noting this part is ancient and I may well be the only 
>> person
>> who still has any on hardware running recent kernels.
> 
> What I learnt from my years in the kernel is that there is always
> a bunch of silent users, also it has this nice feeling of completing
> the ST sensor suite.
It's possible but I've never seen any users who didn't have imote 2 or
stargate 2 boards.  The parts were generally available - however the 
driver
was borked for at least a few kernel cycles with no complaints...

Fairly safe on the stargate 2's as whilst (rumour had it) the design
was given away to a university group when the relevant bit of Intel
research ceased to be no one ever to my knowledge made any more.
A few went out to various univeristies (which is where the few I
have on loan come from).

Imote2s were a bit easier to get hold of as they sold that design to 
Crossbow
who distributed them with tinyos for a while before killing them off as 
well.
They were reasonably popular back in the days when your only small 
platforms
were them or Gumstix (also pxa270 based at the time).

They were great boards for their time - in someways under credited with
starting the whole idea of small headless linux boards for wireless 
sensing.
(they predate the gumstix) though there was a stargate 1 and I think an
original imote before them.

Btw I think there are a few new parts from ST we aren't supporting yet 
;)
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
>>    software triggers only unless someone has this long out of 
>> production
>>    device on a quick board.
> 
> What is the speed of the I2C bus on this system?
> If it's running on the lowest speed 100kHz that may very
> well be the cause of the problem, so check if it supports
> high speed (400kHz) I2C.

Running on SPI at full rated speed of the chip.  Never done much work to
look at timing on these (not had a scope on them since the original 
driver
writing a long time back).

Getting that board to handle more than 100Hz of anything was interesting
IIRC.
> 
> The patch as such looks good.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Thanks,

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
