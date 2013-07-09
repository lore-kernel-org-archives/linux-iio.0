Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43585 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722Ab3GISMv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jul 2013 14:12:51 -0400
Message-ID: <51DC52A1.7080104@kernel.org>
Date: Tue, 09 Jul 2013 19:12:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org,
	Jon Brenner - TAOS <jbrenner@taosinc.com>
Subject: Re: RFC: integration time, tsl45315
References: <alpine.DEB.2.01.1307072226180.23797@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1307072226180.23797@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/2013 10:25 PM, Peter Meerwald wrote:
> Hello,
> 
> I'm trying to address the review comment regarding the proposed tsl45315 
> driver, http://permalink.gmane.org/gmane.linux.kernel.iio/7535
> 
> the following drivers make use of integration time: tsl2x7x, tsl2583 
> (staging) and adjd_s311 (mainline), tsl45315 (proposed)
> 
> integration time is documented in staging/iio/Documentation/sysfs-bus-iio-light: 
> What:		/sys/bus/iio/devices/device[n]/in_illuminance0_integration_time
> KernelVersion:	2.6.37
> Contact:	linux-iio@vger.kernel.org
> Description:
> 		This property gets/sets the sensors ADC analog integration time.
> 
> this doesn't reveal much information
> 
> 
> tsl2x7x says possible values are ".00272 - .696" -- I suppose seconds
> tsl2583 wants values in "50 100 150 200 250 300 350 400 450 500 550 600 
> 650" -- I suppose milliseconds
> adjd_s311's datasheet talks about integration time slots -- whatever that 
> is
> tsl45315 allows "400, 200, 100" milliseconds integration time by
> setting a register to 0, 1, 2
> 
> 
> so use of integration time is not consistent and the documentation is 
> about as precise as it can get
> 
> I think integration_time should specify that the value is milliseconds 
> (what to do with fractions of milliseconds?)

Ideally this would be in seconds and use the relevant return type to do
the decimal parts (in using as I'm about to suggest we add this to the
info_mask set of channel 'attributes'.)  Otherwise, 'floating point'
outputs are fine throughout IIO so lets use the base unit.  The only
time we don't do this (more or less) is when we are trying (perhaps foolishly)
to match hwmon units.

This is common enough that I'm beginning to think we want this in info_mask
rather than as an 'added bonus' to the abi.  What do others think?

> I think integration_time is better than just a scale factor since the 
> time gives a hint how often the sensor can be polled in a meaningful way
Agreed. That is the only reason I can see for explicitly exposing these.

> so what to do?
> for the tsl45315 I'd just go with _integration_time with milliseconds...
Fix them all up ;)  The adjd_s311 is the only one out of staging so we'll need
some input from you on that...  Jon, do you mind this change to the TAOS parts?
