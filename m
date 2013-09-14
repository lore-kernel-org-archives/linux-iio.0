Return-Path: <pmeerw@pmeerw.net>
Date: Sat, 14 Sep 2013 21:13:58 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, Jon Brenner <jon.brenner@ams.com>
Subject: Re: [PATCH 3/4] iio: Add tsl4531 ambient light sensor driver
In-Reply-To: <523446C4.7030808@kernel.org>
Message-ID: <alpine.DEB.2.01.1309142106520.22469@pmeerw.net>
References: <1378653659-15665-1-git-send-email-pmeerw@pmeerw.net> <1378653659-15665-4-git-send-email-pmeerw@pmeerw.net> <523446C4.7030808@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> > driver for the TSL4531 family of 16-bit I2C ambient light
> > sensors; information is here:
> > http://www.ams.com/eng/Products/Light-Sensors/Ambient-Light-Sensor-ALS/TSL45315

> Applied to the togreg branch of iio.git.

there may be your Signed-off-by: missing

> One little question, what is 'single cycle measurement' referring to in the TODO note?

the chip can run in continuous measurement mode and one-shot measurement 
mode; the driver implements continuous measurement mode (aka normal mode) 
thus wasting energy

it is not clear how to know when the measurement is complete in one-shot 
mode, hence I'm sticking with continuous mode

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
