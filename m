Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:5417 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750840AbaBLHkD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Feb 2014 02:40:03 -0500
Message-ID: <52FB2477.9080108@flatmax.org>
Date: Wed, 12 Feb 2014 18:36:23 +1100
From: Matt Flax <flatmax@flatmax.org>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: iio and jack -  1MHz sample rate success
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


I have implemented the jack2 iio driver and have done a couple of tests.

In a preliminary finding, waiting for more time to test and re-test, I 
have had success.
I don't see any overruns reported (when setup properly), and I haven't 
put a signal through the system to highlight any un-reported overruns. 
Next week I will look into this more.

Firstly I would like to say that writing a driver for jack2 is a little 
difficult because there is not much documentation ... at least I 
couldn't find simple information. Some inline src doc would be good ... 
mind you, I could have put more into my driver as well :)

On the system with IIO devices I ran :
jackd -iio

I then setup and ran netjack on both computers.

On the other computer I used :
jack_capture -c 2 -p system:capture*

... wahlah ... it worked ! with an MTU of 1500. Thats 2 channels @ 1 MHz

Everything reporting 1MHz sample rates and so on a so forth, no xruns 
and the wav file looked like what I expected ...

When I tried to record 4 channels @ 1 MHz, I had to increase the MTU to 
6000 to get rid of xruns on the ARM core. But still ... 4 channels @ 
1MHz over a network ... pretty good start !

I would like to integrate my both of my iio branchs into the jack1 and 
jack2 repos, but for now I have forked the jack2 repo here :
https://github.com/flatmax/jack2/tree/iio

I have some questions for other developers of jack2.
is it necessary to use :
     JackDriver::CycleTakeBeginTime();
and
     JackDriver::CycleTakeEndTime();

?

thanks
Matt
p.s. Don't forget that these findings are very preliminary and things 
need to be neatened up, debugged more and so on and so forth.

