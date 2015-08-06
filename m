Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:33001 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048AbbHFHfr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Aug 2015 03:35:47 -0400
Received: by labjt7 with SMTP id jt7so26001904lab.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2015 00:35:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB08DDB@sfamail.SAKURAUS.LOCAL>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB08DDB@sfamail.SAKURAUS.LOCAL>
Date: Thu, 6 Aug 2015 10:35:45 +0300
Message-ID: <CAEnQRZAwD+s0C4et9OTeWrwaq3ZDy3+g0YT_KKMUst_PM31DyA@mail.gmail.com>
Subject: Re: BBB IIO ADC access not working
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

On Sat, Aug 1, 2015 at 12:15 AM, Greg Wilson-Lindberg
<GWilson@sakuraus.com> wrote:
> Hi Jonathan,
> To recap my current problems, we are using all 3 of the ADC channels that are unused by the BBB for our system. One channel has an analog mux on it to allow selecting between 2 input pots. The other two channels are hooked up to pressure transducers.

What devices and drivers are you exactly using?

>
> I'm processing the channels in a routine that gets called from a timer every 100ms. I enable the IIO buffer to collect data and 100ms later read the samples and turn the buffer off again. I leave the buffer off for 400 ms and then go through the process again.  I do this enable, read, disable cycle to allow the touch screen enough time to gather data to properly handle touch screen events.
>
> With this setup the system will work properly for a few seconds, and then the buffer/adc read process slows down so that it takes more than 2 seconds to process the two enable, read, disable cycles in my read state machine. When the slow down happens, the touch screen stops responding, and even mouse presses stop working, although the mouse pointer did continue to follow mouse movements and the screen continued to update properly.
>
> Because of the size of the code I've posted it on pastebin: http://pastebin.com/TDRS1nu7
> instead of including it here.
>
> This is running on a Jessie debian system build from Robert C. Nelson, based on the 3.18 kernel.
>
> I hope that you or someone else on the list can help me understand what is going on.

Could you provide your dmesg output and also cat /proc/interrupts.

thanks,
Daniel.
