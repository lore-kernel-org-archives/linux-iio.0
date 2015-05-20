Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36813 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbbETANr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2015 20:13:47 -0400
Received: by ykep21 with SMTP id p21so10763574yke.3
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2015 17:13:46 -0700 (PDT)
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D46F@sfamail.SAKURAUS.LOCAL>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87CFA4@sfamail.SAKURAUS.LOCAL> <20150513011137.GA23255@deathray> <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D113@sfamail.SAKURAUS.LOCAL> <20150519230932.GA15718@deathray> <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D46F@sfamail.SAKURAUS.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: RE: BBB touch screen and ADC interactions
From: mwelling@ieee.org
Date: Tue, 19 May 2015 19:13:42 -0500
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <F4A1ABDE-E030-405D-A0BB-A4CD80E9F84F@ieee.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On May 19, 2015 6:56:37 PM CDT, Greg Wilson-Lindberg <GWilson@sakuraus.com> wrote:
>Hi Michael,
>
>> -----Original Message-----
>> From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
>> Of Michael Welling
>> Sent: Tuesday, May 19, 2015 4:30 PM
>> To: Greg Wilson-Lindberg
>> Cc: linux-iio@vger.kernel.org
>> Subject: Re: BBB touch screen and ADC interactions
>> 
>> On Thu, May 14, 2015 at 10:00:14AM -0700, Greg Wilson-Lindberg wrote:
>> > 
>> > I'll try out a new (4.0 - 4.1) kernel, but we are using QT 
>> to generate a GUI and I don't know if the graphics that we 
>> need have been ported to the mainline yet.  I guess I'll find 
>> out the hard way.
>> >
>> 
>> Have you had any luck getting the new kernel to work?
>> 
>> I would like to know if you are experiencing the unexpected 
>> release events that I experienced with the touchscreen.
>> 
>
>I just got  the 4.1 kernel working today. Our application is running
>just fine, so all of the QT stuff is working.
>
>I found that when running my IIO ADC read program on the 4.1 kernel,
>not only do I lose the touch screen, but mouse clicks stop working, and
>the cursor periodically jumps.

This seems to be the same issue that I was experiencing.

I can forward the workaround patch when I get back to my PC.

>
>I also figured out that I wasn't disabling the channels when my ADC
>program exited. When I got it to properly exit and disable the IIO ADC
>channels, the mouse started working again.
>
>I then booted back to a 3.14 kernel and while the touch screen stops
>working while I am reading the ADC channels, the mouse still works
>normally, and the touch screen starts working again when the IIO
>program exits.
>
>It appears, for me at least, that the 4.1 kernel is not an improvement.
>
>I don't need fast reads on the ADC, I may be able to get away with
>enabling the ADC channels, reading some values, and disabling them
>again every once in a while.  I guess I'll have to try that.

I have been working on a qt demo that reads the adc and displays a graph while the touchscreen is enabled. The workaround patch must be necessary. 

Would you like to the workaround patch?

We can make a formal patch if it works for you.

>
>- Greg
>
>> -Michael
>>  
>> > Thanks for the information,
>> > 
>> > Greg
>> 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
