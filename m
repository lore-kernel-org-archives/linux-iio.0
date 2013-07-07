Return-Path: <pmeerw@pmeerw.net>
Date: Sun, 7 Jul 2013 23:25:32 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
cc: Jonathan Cameron <jic23@kernel.org>
Subject: RFC: integration time, tsl45315
Message-ID: <alpine.DEB.2.01.1307072226180.23797@pmeerw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

I'm trying to address the review comment regarding the proposed tsl45315 
driver, http://permalink.gmane.org/gmane.linux.kernel.iio/7535

the following drivers make use of integration time: tsl2x7x, tsl2583 
(staging) and adjd_s311 (mainline), tsl45315 (proposed)

integration time is documented in staging/iio/Documentation/sysfs-bus-iio-light: 
What:		/sys/bus/iio/devices/device[n]/in_illuminance0_integration_time
KernelVersion:	2.6.37
Contact:	linux-iio@vger.kernel.org
Description:
		This property gets/sets the sensors ADC analog integration time.

this doesn't reveal much information


tsl2x7x says possible values are ".00272 - .696" -- I suppose seconds
tsl2583 wants values in "50 100 150 200 250 300 350 400 450 500 550 600 
650" -- I suppose milliseconds
adjd_s311's datasheet talks about integration time slots -- whatever that 
is
tsl45315 allows "400, 200, 100" milliseconds integration time by
setting a register to 0, 1, 2


so use of integration time is not consistent and the documentation is 
about as precise as it can get

I think integration_time should specify that the value is milliseconds 
(what to do with fractions of milliseconds?)
I think integration_time is better than just a scale factor since the 
time gives a hint how often the sensor can be polled in a meaningful way

so what to do?
for the tsl45315 I'd just go with _integration_time with milliseconds...

thanks, regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
