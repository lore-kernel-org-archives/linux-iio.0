Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:51286 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbbJOJfB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 15 Oct 2015 05:35:01 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id CC5B620A87
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2015 11:34:48 +0200 (CEST)
Message-ID: <561F72CB.1050606@posteo.de>
Date: Thu, 15 Oct 2015 11:32:59 +0200
From: Martin Kepplinger <martink@posteo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	mfuzzey@parkeon.com
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH v3] iio: mma8452: support either of the available interrupt
 pins
References: <1444828542-28861-1-git-send-email-martink@posteo.de> <561E70E0.1010508@metafoo.de>
In-Reply-To: <561E70E0.1010508@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 2015-10-14 um 17:12 schrieb Lars-Peter Clausen:
> On 10/14/2015 03:15 PM, Martin Kepplinger wrote:
> [...]
>> +			if (irq1 > 0)
>> +				client->irq = irq1;
> 
> You must not overwrite client->irq, that field is manged by the I2C core and
> is supposed to be read only for device drivers.
>

I thought about it again and before I implement it, let me show you:

since interrupt-names would be "invented" anyways ("INT1", "INT2"),
here's an idea for the bindings doc that would be a more long-term
solution to implement:

  - interrupts: interrupt mapping for GPIO IRQ

        These devices have two interrupt pins called INT1 and INT2 they
        can route their different interrupt sources to:

        IRQ Name        Interrupt Source        Wired Pin
        --------        ----------------        ---------
        DATA_READY_1    data ready              INT1
        DATA_READY_2                            INT2
        MOTION_1        motion events           INT1
        MOTION_2                                INT2
        INT1            all                     INT1
        INT2                                    INT2

  - interrupt-names: should contain IRQ Names in the order in which they
                     were supplied in the interrupts property.

                     Depending on how your chip is wired and what
                     interrupt sources should be handled by the driver,
                     choose one IRQ Name per Interrupt source, or
                     INT1/INT2 for all sources to one pin here.

Example 1:

        mma8453fc@1d {
                compatible = "fsl,mma8453";
                reg = <0x1d>;
                interrupt-parent = <&gpio1>;
                interrupts = <5 0>;
                interrupt-names = "INT2"; // interrupt pin wired to INT2
        };

Example 2:

        mma8453fc@1d {
                compatible = "fsl,mma8453";
                reg = <0x1d>;
                interrupt-parent = <&gpio1>;
                interrupts = <4 0>, <5 0>;
                /* data ready comes from INT2, motion events from INT1 */
                interrupt-names = "DATA_READY_2", "MOTION_1";
        };

What do you think?

thanks
                           martin

