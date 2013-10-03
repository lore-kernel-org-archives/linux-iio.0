Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-164.synserver.de ([212.40.185.164]:1053 "EHLO
	smtp-out-164.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab3JCIei (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Oct 2013 04:34:38 -0400
Message-ID: <524D2C8C.3010502@metafoo.de>
Date: Thu, 03 Oct 2013 10:36:28 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Beomho Seo <beomho.seo@samsung.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	pawel.moll@arm.com, Mark Rutland <mark.rutland@arm.com>,
	"ian.campbell@citrix.com" <ian.campbell@citrix.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	myungjoo.ham@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>,
	Peter Meerwald l <pmeerw@pmeerw.net>
Subject: Re: [PATCH v5 1/2] iio: cm36651: Add CM36651 proximity/light sensor
References: <524AC65C.20400@samsung.com> <524B3E0D.3040803@kernel.org>
In-Reply-To: <524B3E0D.3040803@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/2013 11:26 PM, Jonathan Cameron wrote:
> On 10/01/13 13:55, Beomho Seo wrote:
>>
>> This patch adds a new driver for Capella CM36651 proximity and RGB sensor.
>>
>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> A couple of little points inline. In short, some unnecessary
> variable initializations (bad idea as they may hide real bugs)
> and you should use IRQF_DISABLED if you really do need to have
> the interrupt disabled.

IRQF_DISABLED actually does something else (or well did something else,
these days it's a no-op and shouldn't be used). But yea, a flag that keeps
the interrupt disabled would be nice.

> 
> Also, sorry if I missed an explanation, but I can't see why you need
> the enable and disable on the interrupt.  As you explicitly turn the
> interrupt on by writing to a device register why would an interrupt
> occur at any other time?  Convention is normally to not do the disabling
> of the irq unless it is actually necessary.  It complicates
> the code for no gain.

Yep, I don't see any reason why the code actually has to use
enable_irq/disable_irq. Unless there is a problem with the chip that it
tends to generate lots of spurious interrupts. In that case this should be
documented in the code though.

- Lars

