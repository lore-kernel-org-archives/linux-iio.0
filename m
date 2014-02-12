Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from server201.webhostingpad.com ([50.31.162.83]:43828 "EHLO
	server201.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751312AbaBLIjR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 12 Feb 2014 03:39:17 -0500
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [Jack-Devel] iio and jack -  1MHz sample rate success
From: =?iso-8859-1?Q?St=E9phane_Letz?= <letz@grame.fr>
In-Reply-To: <52FB1F50.2020707@flatmax.org>
Date: Wed, 12 Feb 2014 08:57:10 +0100
Cc: JACK <jack-devel@lists.jackaudio.org>, linux-iio@vger.kernel.org
Message-Id: <97EA9EB4-7C3F-4E18-AFF7-C54564823DF6@grame.fr>
References: <52FB1F50.2020707@flatmax.org>
To: Matt Flax <flatmax@flatmax.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Le 12 févr. 2014 à 08:14, Matt Flax <flatmax@flatmax.org> a écrit :

> I have implemented the jack2 iio driver and have done a couple of tests.
> 
> In a preliminary finding, waiting for more time to test and re-test, I have had success.
> I don't see any overruns reported (when setup properly), and I haven't put a signal through the system to highlight any un-reported overruns. Next week I will look into this more.
> 
> Firstly I would like to say that writing a driver for jack2 is a little difficult because there is not much documentation ... at least I couldn't find simple information. Some inline src doc would be good ... mind you, I could have put more into my driver as well :)
> 
> On the system with IIO devices I ran :
> jackd -iio
> 
> I then setup and ran netjack on both computers.
> 
> On the other computer I used :
> jack_capture -c 2 -p system:capture*
> 
> ... wahlah ... it worked ! with an MTU of 1500. Thats 2 channels @ 1 MHz
> 
> Everything reporting 1MHz sample rates and so on a so forth, no xruns and the wav file looked like what I expected ...
> 
> When I tried to record 4 channels @ 1 MHz, I had to increase the MTU to 6000 to get rid of xruns on the ARM core. But still ... 4 channels @ 1MHz over a network ... pretty good start !
> 
> I would like to integrate my both of my iio branchs into the jack1 and jack2 repos, but for now I have forked the jack2 repo here :
> https://github.com/flatmax/jack2/tree/iio

When ready, do a "merge request".
> 
> I have some questions for other developers of jack2.
> is it necessary to use :
>     JackDriver::CycleTakeBeginTime();
> and
>     JackDriver::CycleTakeEndTime();

Sure: this code is used to take "timestamps" at the beginning and end of driver cycle, so that DSP CPU consumption can be computed later on.

Stéphane 