Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36142 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964896AbbEMBLk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2015 21:11:40 -0400
Received: by igbpi8 with SMTP id pi8so125468213igb.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2015 18:11:39 -0700 (PDT)
Date: Tue, 12 May 2015 20:11:37 -0500
From: Michael Welling <mwelling@ieee.org>
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: BBB touch screen and ADC interactions
Message-ID: <20150513011137.GA23255@deathray>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87CFA4@sfamail.SAKURAUS.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87CFA4@sfamail.SAKURAUS.LOCAL>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, May 12, 2015 at 04:23:43PM -0700, Greg Wilson-Lindberg wrote:
> Hello all,
> I've got a problem with the BeagleBone Black ti_am335x_tsc, ti_am335x_adc & ti_am335x_tsadc drivers, and Jonathan Cameron suggested that I reach out to this list to see if any one here has any insight to my problem.
>  
> I'm using a BBB running a Debian Jessie build with the 3.14.40 ti kernel by Robert C. Nelson. I've got it hooked up to a touch screen and I would like to also be able to use some of the remaining adc channels.
>  
> As soon as I try to read any of the remaining channels the touch screen locks up. I've tried catting them from /sys/bus/iio/devices/iio:device0/in_voltageX_raw, using the generic_buffer program provided by the kernel, and using the Analog Devices libiio library. In all cases, I get the same results, adc values that look reasonable, but the touch screen stops responding.
>

Does the touchscreen freeze indefinitely or does it come back after ADC sampling
is stopped?
  
> I've asked on the TI support forum if they could help with this problem, but their response was that they only supported the TI SDK.
>  
> Can any of you tell me if the current iio subsystem will work correctly with the ti touch screen and adc drivers? 
>

I have been working on porting Linux to a device that uses the AM335x and have
noticed that the drivers has undergone many changes recently. I am now using 
a 4.0 kernel and am able to sample the ADC and use the touchscreen
simultaneously.

When sampling the ADC you will notice that the touchscreen is less responsive
but it does not freeze. The responsiveness comes back when ADC sampling stops.

One thing that I have noticed recently is that when using ts_calibrate or
ts_test the screen will register touch releases repeatedly without touching
the screen.

I have a workaround patch but have not attempted to push it upstream yet.

So it won't freeze the touchscreen completely after sampling ADCs but you
still may notice some quirks.

The best way to find out is building the new kernel and trying it out.

> Greg Wilson-Lindberg
> Sakura Finetek
> 310-783-5075
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
