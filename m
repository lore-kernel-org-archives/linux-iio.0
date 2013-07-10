Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:39817 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab3GJPW6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jul 2013 11:22:58 -0400
From: Marek Vasut <marex@denx.de>
To: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH 1/4] iio: mxs-lradc: change the realbits to 12
Date: Wed, 10 Jul 2013 17:22:46 +0200
Cc: "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"jic23@kernel.org" <jic23@kernel.org>
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <201307101349.26318.marex@denx.de> <51DD7392.70908@digi.com>
In-Reply-To: <51DD7392.70908@digi.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307101722.46258.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Hector,

> Dear Marek,
> 
> On 07/10/2013 01:49 PM, Marek Vasut wrote:
> > Hi Hector,
> > 
> >> Hello,
> >> 
> >> On 07/05/2013 03:10 PM, Marek Vasut wrote:
> >>> Dear Hector Palacios,
> >>> 
> >>>> Dear Marek,
> >>>> 
> >>>> On 07/05/2013 01:37 PM, Marek Vasut wrote:
> >>>>> Dear Hector Palacios,
> >>>>> 
> >>>>>> The LRADC virtual channels have an 18 bit field to store the sum of
> >>>>>> up to 2^5 accumulated samples. The read_raw function however only
> >>>>>> operates over a single sample (12 bit resolution).
> >>>>>> In order to use this field for scaling operations, we need it to be
> >>>>>> the exact resolution value of the LRADC.
> >>>>> 
> >>>>> How would this work once the accumulation is supported?
> >>>> 
> >>>> As I see it, when you read a channel the driver should give you the
> >>>> 12-bit value either of one single sample or of N samples.
> >>> 
> >>> The hardware will always give you 18 bit value, let's call it A of N
> >>> accumulated samples, each 12 bit long. N is in range of 1 to 32 .
> >>> 
> >>> The driver currently supports N = 1.
> >>> 
> >>> Do I understand it correctly that if we want to support N > 1, we have
> >>> to do the division of A / N in the driver and therefore we will again
> >>> report only a 12-bit value to the userland ?
> >>> 
> >>> If so,
> >>> 
> >>> Acked-by: Marek Vasut <marex@denx.de>
> >> 
> >> Coming back to this patch, I just noticed that it is not enough to just
> >> change the realbits from 18 to 12. When using this driver as touchscreen
> >> for Yocto's SATO graphic rootfs I noticed that the driver is using
> >> LRADC_CH_VALUE_MASK for reporting the coordinates.
> >> 
> >> 	input_set_abs_params(input, ABS_X, 0, LRADC_CH_VALUE_MASK, 0, 0);
> >> 	input_set_abs_params(input, ABS_Y, 0, LRADC_CH_VALUE_MASK, 0, 0);
> >> 	input_set_abs_params(input, ABS_PRESSURE, 0, LRADC_CH_VALUE_MASK, 0,
> >> 	0);
> >> 
> >> which is defined as an 18bit mask:
> >> 	#define	LRADC_CH_VALUE_MASK			0x3ffff
> >> 
> >> The result is that the touch calibration range in Xorg is expecting
> >> values between 0 and 262143 (0x3ffff), which causes trouble (at least I
> >> had problems to calibrate it).
> > 
> > What kind of trouble does it cause?
> 
> Sorry, I should have said.
> First of all, I'm using a resistive touch that needs calibration.
> 
> There something I definitely don't understand about calibrating the touch
> in Sato. Initially I don't have any file /etc/pointercal.xinput. When Sato
> launches the touch is not calibrated so I run the xinput_calibrator. When
> I run this, the console displays:
> 
> Calibrating EVDEV driver for "mxs-lradc" id=6
>          current calibration values (from XInput): min_x=0, max_x=262143
> and min_y=0, max_y=262143
> 
> Notice the max_x and max_y are showing 0x3ffff which is the value sent by
> the driver.
> 
> This calibration program shows a target at each corner. At this point, it
> will only accept me clicking on the first target (upper left corner). When
> I click the second it doesn't get it. It eventually gets it if I click
> several times somewhere else in the screen, but yet it won't get the third
> target (lower left corner), no matter where I press. So I can't calibrate
> the touch. I believe the reason might be the calibration tool is expecting
> much higher values (around the max value) and maybe discarding values that
> are too close (in relation to the range) to the min coordinate (it's just
> my guess).
> 
> After doing the above patch, when launching the vcalibration tool, I get
> this on the console:
> 
> Calibrating EVDEV driver for "mxs-lradc" id=6
>          current calibration values (from XInput): min_x=0, max_x=4095 and
> min_y=0, max_y=4095
> 
> and the application lets me click on every target. The application showed
> the following output:
> 
> Doing dynamic recalibration:
>          Swapping X and Y axis...
>          Setting calibration data: 1405, 1367, 3693, 3733
>          --> Making the calibration permanent <--
>    copy the snippet below into '/etc/X11/xorg.conf.d/99-calibration.conf'
> Section "InputClass"
>          Identifier      "calibration"
>          MatchProduct    "mxs-lradc"
>          Option  "Calibration"   "1405 1367 3693 3733"
>          Option  "SwapAxes"      "1"
> EndSection
> 
> I created the file /etc/X11/xorg.conf.d/99-calibration.conf and wrote that
> information, but the touch still didn't work correctly. :o(
> 
> I manually removed the "Calibration" line from this file and launched the
> calibration tool again. This time I was given the following data:
> 
> Section "InputClass"
>          Identifier      "calibration"
>          MatchProduct    "mxs-lradc"
>          Option  "Calibration"   "4207 320 4063 326"
>          Option  "SwapAxes"      "1"
> EndSection
> 
> and finally the touch works correctly calibrated.
> 
> So, ok, maybe the driver is not responsible for all these problems, but
> reporting a max value of 0x3ffff seems definitely incorrect, and it was
> preventing me from completing the calibration.

Can you try with the ts_calibrate tool in qte image? The X11 calibrator is 
horrible piece of ... you know. The tslib ts_calibrate one always worked much 
better for me. So maybe you should also peek into the X11 calibrator and fix it.

On the other hand, the patch is correct, it should report only 12-bit values.

These are my X11 calibration values:

Section "InputClass"
        Identifier      "calibration"
        MatchProduct    "mxs-lradc"
        Option          "Calibration"   "98 4035 4007 198"
EndSection

> > [...]
> > 
> >> Notice that I leave the existing LRADC_CH_VALUE_MASK 18bit mask in the
> >> rest of the driver, to support accumulated samples.
> >> Curiously, ts_lib works fine without this (maybe the calibration fixes
> >> this?), but nevertheless the information passed by the driver is
> >> incorrect, I guess. Is anybody out there working with the touch? Under
> >> which graphic system?
> > 
> > Both QtE and Sato work for me, that's why I'm curious about your issues.
> 
> ts_lib application also worked for me without the patch, but I thought
> maybe the ts_calibrate was doing his job regardless the ranges reported by
> the driver and the Sato worked differently.
> Are you also using a resistive touch? How did you do the calibration?

Yes, I'm using resistive touch. Maybe it's due to a different brand.

Best regards,
Marek Vasut
