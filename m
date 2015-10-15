Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34638 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbbJOKOy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 15 Oct 2015 06:14:54 -0400
Date: Thu, 15 Oct 2015 11:14:45 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Martin Kepplinger <martink@posteo.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, robh+dt@kernel.org,
	pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, mfuzzey@parkeon.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH v3] iio: mma8452: support either of the available
 interrupt pins
Message-ID: <20151015101347.GA8825@leverpostej>
References: <1444828542-28861-1-git-send-email-martink@posteo.de>
 <561E70E0.1010508@metafoo.de>
 <561F72CB.1050606@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <561F72CB.1050606@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Oct 15, 2015 at 11:32:59AM +0200, Martin Kepplinger wrote:
> Am 2015-10-14 um 17:12 schrieb Lars-Peter Clausen:
> > On 10/14/2015 03:15 PM, Martin Kepplinger wrote:
> > [...]
> >> +			if (irq1 > 0)
> >> +				client->irq = irq1;
> > 
> > You must not overwrite client->irq, that field is manged by the I2C core and
> > is supposed to be read only for device drivers.
> >
> 
> I thought about it again and before I implement it, let me show you:
> 
> since interrupt-names would be "invented" anyways ("INT1", "INT2"),
> here's an idea for the bindings doc that would be a more long-term
> solution to implement:
> 
>   - interrupts: interrupt mapping for GPIO IRQ
> 
>         These devices have two interrupt pins called INT1 and INT2 they
>         can route their different interrupt sources to:

This being the case, the binding should only talk about INT1 and INT2.
The names might be "invented", but they describe the physical pins on
the device, and thus describe a physical property of the device.

>         IRQ Name        Interrupt Source        Wired Pin
>         --------        ----------------        ---------
>         DATA_READY_1    data ready              INT1
>         DATA_READY_2                            INT2
>         MOTION_1        motion events           INT1
>         MOTION_2                                INT2
>         INT1            all                     INT1
>         INT2                                    INT2
> 
>   - interrupt-names: should contain IRQ Names in the order in which they
>                      were supplied in the interrupts property.
> 
>                      Depending on how your chip is wired and what
>                      interrupt sources should be handled by the driver,
>                      choose one IRQ Name per Interrupt source, or
>                      INT1/INT2 for all sources to one pin here.

The configuration of logical interrupts to those physical pins is a
choice that can be made at runtime, and should not live in the DT. It is
not a property of the hardware.

Thanks,
Mark.
