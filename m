Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:37662 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933253Ab3GPTRK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 15:17:10 -0400
Date: Tue, 16 Jul 2013 21:17:06 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Josh Wu <josh.wu@atmel.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	plagnioj@jcrosoft.com, linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 2/5] iio: at91: Use different prescal, startup mask in
 MR for different IP
Message-ID: <20130716211706.39665234@skate>
In-Reply-To: <51E5990A.4050709@kernel.org>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
	<1373789069-11604-3-git-send-email-josh.wu@atmel.com>
	<20130715125815.GC2962@lukather>
	<51E505EA.4060502@atmel.com>
	<51E50864.6020904@atmel.com>
	<20130716133003.7c208cdf@skate>
	<51E5990A.4050709@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Jonathan Cameron,

On Tue, 16 Jul 2013 20:03:38 +0100, Jonathan Cameron wrote:

> On 07/16/2013 12:30 PM, Thomas Petazzoni wrote:
> > I've asked exactly this question last week at Linaro Connect during the
> > ARM SoC consolidation panel/discussion, where Grant Likely, Arnd
> > Bergmann, Olof and others were answering Device Tree related questions.
> > 
> > My question, which precisely had the at91-adc DT binding in mind was
> > precisely whether we should use different compatible properties to
> > identify different revisions of an IP block and let the driver handle
> > those differences, or whether the DT binding should provide sufficient
> > properties (register offsets, bit numbers, etc.) to make the driver
> > independent of the IP revisions. And clearly, the answer was that
> > different compatible properties should be used to identify the
> > different versions of the IP block, and the driver should abstract out
> > the differences. I.e, was has been done for at91-adc is completely the
> > opposite of the best practices for Device Tree on ARM.
> > 
> > See
> > http://www.youtube.com/watch?v=zF_AXLgkFy4&feature=player_detailpage#t=1581s
> > where I ask exactly this question, and get answers from Olof Johansson
> > and Grant Likely. They clearly say that the solution of having separate
> > compatible properties and a driver that handles the differences is the
> > way to go. So the way at91-adc (and possibly other at91 drivers) is
> > using the Device Tree is wrong, there should have been multiple
> > compatible properties. It's a shame because this is something we did say
> > when we submitted at91-adc and during the reviews, but the maintainer
> > wasn't listening to our comments...
> > 
> 
> Thanks for getting some clarity on this Thomas.  So I'll ask the somewhat obvious
> question - how do we unwind from where we are to where we want to be wrt to the
> bindings?

During Linaro Connect last week, there was some discussion about
marking DT bindings as unstable for a little while, once they get
reviewed by a group of DT "experts" that mark them as stable. Until
they are stable, the kernel does not offer any ABI guarantees, and we
are free to change the DT bindings as needed.

Now, since this unstable/stable thing is not in place at the moment,
deciding whether to break or not existing bindings is something to be
decided by the maintainer of this platform, judging what is the best
option depending on whether there are already many users of the DT for
this platform or not, for example.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
