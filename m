Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751729AbdLLUI6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 12 Dec 2017 15:08:58 -0500
Date: Tue, 12 Dec 2017 20:08:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v1 0/7] iio: adc: ina2xx: Rework CNVR alignment, fix
 busy loops
Message-ID: <20171212200853.6ea2bf00@archlinux>
In-Reply-To: <3257961.18rt8HF3Lz@pebbles>
References: <8e8ef11e-37df-44f3-b4a4-06e995924ca8@rwthex-w2-a.rwth-ad.de>
        <20171210173654.0d6cb19a@archlinux>
        <3257961.18rt8HF3Lz@pebbles>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 10 Dec 2017 21:22:13 +0100
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> On Sunday, December 10, 2017 6:36:54 PM CET Jonathan Cameron wrote:
> > On Fri, 8 Dec 2017 18:41:45 +0100
> > 
> > Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:  
> > > Currently, the INA2xx driver may end up causing 100% load on a single core
> > > and fully loading the I2C bus, which is caused by two different issues:
> > > 
> > > The code uses a udelay to bridge the gab between two subsequent samples.
> > > As the sampling interval may be up to 16 seconds, the CPU is busy
> > > waiting most of the time.
> > > 
> > > The second issue manifests when using the (default) "synchronous" mode.
> > > The code polls for a set conversion ready flag, but fails to align the
> > > sampling interval to the raising flag. The polling interval is
> > > (rightfully) slighly shorter than the sampling interval, so after some
> > > samples the sampling thread is continously polling.  
> > 
> > I'm confused.  Would you mind doing an asci art example perhaps?  
> 
> Lets assume the conversion interval is set to 2 ms. If the polling is done at 
> the sampling frequency, it might be slightly to long due to differences 
> between the host and device clocks, so the polling has to run somewhat faster. 
> Somewhat faster means 200 us, this is kept unchanged.
> 
> In case the CNVR flag is not set, the status register is read again until the 
> flag raises. The time instant the flag raises is the reference for later 
> reads.
> 
> The following shows the timing for the fixed code. Each character corresponds 
> to 200us, first row: real time (ms), second row: conversion finished by 
> device, third row: register read
> s: status, CNVR not set
> S: status, CNVR set
> S: value register, e.g. shunt voltage
> _: bus busy (each reads needs 400 us @ 100 kBit/s)
> 
> __0____1____2____3____4____5____6____7____8____9
> ...C.........C.........C.........C.........C....
> ..s_S_V_.....S_V_......S_V_....s_S_V_......S_V_.
> 
> At 0 ms, the conversion has not yet finished, but a 0.4 it has. Further reads 
> are done at 0.4 + n * (2 - 0.2) ms. The next read happens at 2.2 ms, the third 
> should at 4.0, but happens slightly late at 4.2. The read at 5.8 gets an unset 
> CNVR flag, so the sampling is readjusted to happen at 6.2 + n' (2 - 0.2) ms.
> 
> The old code does the following:
> __0____1____2____3____4____5____6____7____8____9
> ...C.........C.........C.........C.........C....
> ..s_S_V_...s_S_V_...s_s_S_V_.s_s_S_V_.s_s_s_S_V_
> 
> The first read happens at 0 ms, it measures the time for the reading (1.2 ms), 
> sleeps for the remainder (0.6 ms) and reads again. The third read takes 1.6, 
> so sleep for 0.2 ms.
> 
> The old code does not differentiate between time spent in the status poll and 
> time spent for reading. Time spent in the status poll should not be subtracted 
> from the delay until the next read (well, halfway, only the time spent with 
> the poll returning !CNVR).

Thanks - got it now.  Makes complete sense.  There are probably other
drivers where we can do something similar but certainly good to
improve this one.

Jonathan
> 
> Kind regards,
> 
> Stefan
> 

