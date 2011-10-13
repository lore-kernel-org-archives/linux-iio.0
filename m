Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64834 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755835Ab1JMOTt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Oct 2011 10:19:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
Date: Thu, 13 Oct 2011 16:19:39 +0200
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-iio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Zoltan Devai <zdevai@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Cameron <jic23@cam.ac.uk>
References: <1318178172-7965-1-git-send-email-zoss@devai.org> <20111013113506.GJ1098@sirena.org.uk> <20111013121745.GU21648@n2100.arm.linux.org.uk>
In-Reply-To: <20111013121745.GU21648@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201110131619.39303.arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thursday 13 October 2011, Russell King - ARM Linux wrote:
> On Thu, Oct 13, 2011 at 12:35:06PM +0100, Mark Brown wrote:
> > On Thu, Oct 13, 2011 at 10:47:17AM +0100, Russell King - ARM Linux wrote:
> > > On Mon, Oct 10, 2011 at 12:44:08PM +0100, Mark Brown wrote:
> > 
> > > > At the minute it seems to me that arch/arm is as good a place as any
> > > > really - currently this code is getting dumped wherever the main device
> > > > is.
> > 
> > > No it isn't - we want drivers out of arch/arm (it's already been a topic
> > > of flame for Linus, so it's something that we should try really hard
> > > to avoid.)
> > 
> > I said it was as good a place as any, I didn't say it was a good place.
> 
> I'm saying it is a BAD place.  I'm saying that we've been flamed over
> this several times before.  We need to change our behaviour RIGHT NOW,
> not continue on ignoring the problem, and demonstrating to Linus that
> we don't take his concerns seriously.
> 
> If we can't find a place for it that's outside of arch/arm, then it
> doesn't go in.

How about deferring the decision for now and putting it into
drivers/staging/adc, with a single TODO item listing "Work out proper
API"? After all, the reason this driver doesn't fit anywhere is that
there is no established subsystem for it, at least not outside of
staging.

AFAICT, the driver is not essential for spmp8000 systems, but you
would want to have it there in practice. It makes little sense to
put the driver into drivers/adc and then later change the interface
fundamentally again if we decide to go with drivers/iio/adc providing
the common abstraction lation.

Of course, if the spmp8000 adc driver gets put into staging, all its
dependencies (input, battery) also have to go there because no
regular driver must link against interfaces provided by a staging
driver.

	Arnd
