Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58417 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754312AbaHFW0B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 6 Aug 2014 18:26:01 -0400
Date: Thu, 7 Aug 2014 00:25:59 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Felipe Balbi <balbi@ti.com>
cc: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth
 sensor
In-Reply-To: <20140806221823.GE3556@saruman.home>
Message-ID: <alpine.DEB.2.01.1408070021420.7595@pmeerw.net>
References: <1407341409-30284-1-git-send-email-balbi@ti.com> <alpine.DEB.2.01.1408061815140.29646@pmeerw.net> <20140806214222.GB3556@saruman.home> <alpine.DEB.2.01.1408062347350.7595@pmeerw.net> <20140806221823.GE3556@saruman.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> > > > > +		.scan_type = {
> > > > > +			.sign = 'u',
> > > > 
> > > > .realbits / .storagebits missing?
> > > 
> > > yeah, couldn't figure this out. The HW gives me a 16-bit value where
> > > 12-bits are the mantissa and 4-bits are for the exponent. Should I call
> > > realbits 16 and storagebits 32 ?
> > 
> > so .realbits = 16 and .storagebits = 16, but there is no way to describe 
> > the mantissa/exponent thing to userspace
> > 
> > you are not using iio_triggered_buffer_setup() yet, so no need for 
> > .scan_type (yet)
> 
> ok... but then that brings up a doubt. What would I use triggered buffer
> for ? I already setup High/Low limits (thresholds) through
> .write_event_value(). Isn't that, pretty much, a triggered buffer ?

a triggered buffer reads data from the device and stores it into a buffer 
whenever the trigger goes off (you are interested to capture all samples)

events are created on certain conditions (you are not interested in all 
samples)

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
