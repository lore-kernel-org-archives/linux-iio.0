Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:50060 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbaH2Osr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Aug 2014 10:48:47 -0400
Received: by mail-vc0-f174.google.com with SMTP id hy4so2507384vcb.5
        for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2014 07:48:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1409323160.2839.8.camel@spandruv-hsb-test>
References: <CAN0s7yTK1_1u65nodysfiGxYbgKTeDS0Vf_+14KQJS92_Di1vg@mail.gmail.com>
	<CAN0s7yRwXGgPLhyucnR+=EybQFjunt66MKYvQuZnR_PSdgjS1Q@mail.gmail.com>
	<CA+BWVUSSO0kA1mW6BJ9F5VrZErK1D7YDOrA-gtuW5ZF3wNNZXA@mail.gmail.com>
	<CAN0s7yTYwEsu2uJ3kUjW-SsvoyqSXebNT3=1D1oNfdJwi=Q5Qw@mail.gmail.com>
	<CA+BWVUSZDb_+gtLY5JeryMMfYRrQCkdYBUfG9m3rzL1P9wawYg@mail.gmail.com>
	<CA+BWVUSvm54_xLeXGf0d5oo1-1DH_z=K1TFsrFLQHMBV_gA7gA@mail.gmail.com>
	<CAN0s7yT017sCS9K4q5avRBz5JM+Oj4RM-M8oYVStbWEDx1yWXg@mail.gmail.com>
	<CA+BWVUSXXhFFTUg_NUu6KochOnpg7LF9L3Q8pZHe4Lt7JJrEXw@mail.gmail.com>
	<CAN0s7ySG9rbDXZ6XDtQmPWD5QGRdnHf7SwGxjh0er39EZFGO6w@mail.gmail.com>
	<CA+BWVUTraeqgTJqJndzpY6+_c+600q=MKChtA7OdG3uBG7+f6w@mail.gmail.com>
	<CAN0s7yQJfekw_iWhS5o6xArY91fwN6=o7mqyanmk_UCQL=y1HQ@mail.gmail.com>
	<1408985781.21294.149.camel@spandruv-desktop.jf.intel.com>
	<CAN0s7yQAP9ZkPd+E3StKutM4YLE-xyOz8QRFBsh=vo3KfHNG6A@mail.gmail.com>
	<1409323160.2839.8.camel@spandruv-hsb-test>
Date: Fri, 29 Aug 2014 17:48:46 +0300
Message-ID: <CAN0s7yQc-DdJHhsoUaePrGtEqq5EnUajwNbh0h4ho9LsRFrxCg@mail.gmail.com>
Subject: Re: Resource Temporarily Unavailable error when trying to read from
 the accelerator on a ThinkPad twist
From: Elad Alfassa <elad@fedoraproject.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Reyad Attiyat <reyad.attiyat@gmail.com>,
	linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 29, 2014 at 5:39 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> I want to make sure that this hub doesn't require some GPIO magic to
> wake up. So when you cat raw values, are they sane? Do they change when
> you move?
>
> Thanks,
> Srinivas
>

They are not quite sane, but they do change when I move the device -
so the sensor is awake.
Maybe some offset / multiplier is also needed here too.
[root@rincewind iio:device3]# cat in_accel_*raw
-27
56
-974

If you have any more idea for ways to debug this, let me know,

Thanks,
-- 
-Elad Alfassa.
