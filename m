Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:55251 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933666AbbELXYA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2015 19:24:00 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Tue, 12 May 2015 16:23:43 -0700
Subject: BBB touch screen and ADC interactions
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87CFA4@sfamail.SAKURAUS.LOCAL>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello all,
I've got a problem with the BeagleBone Black ti_am335x_tsc, ti_am335x_adc & ti_am335x_tsadc drivers, and Jonathan Cameron suggested that I reach out to this list to see if any one here has any insight to my problem.
 
I'm using a BBB running a Debian Jessie build with the 3.14.40 ti kernel by Robert C. Nelson. I've got it hooked up to a touch screen and I would like to also be able to use some of the remaining adc channels.
 
As soon as I try to read any of the remaining channels the touch screen locks up. I've tried catting them from /sys/bus/iio/devices/iio:device0/in_voltageX_raw, using the generic_buffer program provided by the kernel, and using the Analog Devices libiio library. In all cases, I get the same results, adc values that look reasonable, but the touch screen stops responding.
 
I've asked on the TI support forum if they could help with this problem, but their response was that they only supported the TI SDK.
 
Can any of you tell me if the current iio subsystem will work correctly with the ti touch screen and adc drivers? 

Greg Wilson-Lindberg
Sakura Finetek
310-783-5075
