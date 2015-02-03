Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33345 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756150AbbBCTuC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Feb 2015 14:50:02 -0500
Date: Tue, 3 Feb 2015 11:49:56 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Vignesh R <vigneshr@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lee Jones <lee.jones@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Benoit Cousson <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@arm.linux.org.uk>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Brad Griffis <bgriffis@ti.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Sanjeev Sharma <sanjeev_sharma@mentor.com>,
	Jan Kardell <jan.kardell@telliq.com>,
	Felipe Balbi <balbi@ti.com>, Wolfram Sang <wsa@the-dreams.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v6 2/6] input: touchscreen: ti_am335x_tsc: Remove udelay
 in interrupt handler
Message-ID: <20150203194956.GD20256@dtor-ws>
References: <1420609779-11156-1-git-send-email-vigneshr@ti.com>
 <1420609779-11156-3-git-send-email-vigneshr@ti.com>
 <54CB1604.9030709@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54CB1604.9030709@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jan 30, 2015 at 10:56:28AM +0530, Vignesh R wrote:
> 
> 
> On Wednesday 07 January 2015 11:19 AM, Vignesh R wrote:
> > From: Brad Griffis <bgriffis@ti.com>
> > 
> > TSC interrupt handler had udelay to avoid reporting of false pen-up
> > interrupt to user space. This patch implements workaround suggesting in
> > Advisory 1.0.31 of silicon errata for am335x, thus eliminating udelay
> > and touchscreen lag. This also improves performance of touchscreen and
> > eliminates sudden jump of cursor at touch release.
> > 
> > IDLECONFIG and CHARGECONFIG registers are to be configured
> > with same values in order to eliminate false pen-up events. This
> > workaround may result in false pen-down to be detected, hence considerable
> > charge step delay needs to be added. The charge delay is set to 0xB000
> > (in terms of ADC clock cycles) by default.
> > 
> > TSC steps are disabled at the end of every sampling cycle and EOS bit is
> > set. Once the EOS bit is set, the TSC steps need to be re-enabled to begin
> > next sampling cycle.
> > 
> > Signed-off-by: Brad Griffis <bgriffis@ti.com>
> > [vigneshr@ti.com: Ported the patch from v3.12 to v3.19rc1]
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > ---
> 
> Ping... Can somebody pick this patch series if there are no more comments??

Yes, I picked up everything but patch #3 as I assume Lee will merge it
through MFD tree.

Thanks.

-- 
Dmitry
