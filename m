Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:38494 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbbHEXIw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 19:08:52 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Wed, 5 Aug 2015 16:07:32 -0700
Subject: RE: BBB IIO ADC access not working
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB090F6@sfamail.SAKURAUS.LOCAL>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB08DDB@sfamail.SAKURAUS.LOCAL>
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB08DDB@sfamail.SAKURAUS.LOCAL>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

 
Hi Jonathan,
I modified my code to only read the ADC channels once a second, and it is still
locking up the touch screen, although if takes longer now.

Again, any insight on what might be happening would be appreciated.

Regards,
Greg

> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org 
> [mailto:linux-iio-owner@vger.kernel.org] On Behalf Of Greg 
> Wilson-Lindberg
> Sent: Friday, July 31, 2015 2:16 PM
> To: linux-iio@vger.kernel.org
> Subject: BBB IIO ADC access not working
> 
> Hi Jonathan,
> To recap my current problems, we are using all 3 of the ADC 
> channels that are unused by the BBB for our system. One 
> channel has an analog mux on it to allow selecting between 2 
> input pots. The other two channels are hooked up to pressure 
> transducers.
>  
> I'm processing the channels in a routine that gets called 
> from a timer every 100ms. I enable the IIO buffer to collect 
> data and 100ms later read the samples and turn the buffer off 
> again. I leave the buffer off for 400 ms and then go through 
> the process again.  I do this enable, read, disable cycle to 
> allow the touch screen enough time to gather data to properly 
> handle touch screen events.
>  
> With this setup the system will work properly for a few 
> seconds, and then the buffer/adc read process slows down so 
> that it takes more than 2 seconds to process the two enable, 
> read, disable cycles in my read state machine. When the slow 
> down happens, the touch screen stops responding, and even 
> mouse presses stop working, although the mouse pointer did 
> continue to follow mouse movements and the screen continued 
> to update properly.
> 
> Because of the size of the code I've posted it on pastebin: 
> http://pastebin.com/TDRS1nu7 instead of including it here.
> 
> This is running on a Jessie debian system build from Robert 
> C. Nelson, based on the 3.18 kernel.
> 
> I hope that you or someone else on the list can help me 
> understand what is going on.
>  
> Greg Wilson-Lindberg
> Sakura Finetek
> 310-783-5075
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-iio" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 