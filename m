Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:6652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750826AbeCPNDq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Mar 2018 09:03:46 -0400
Date: Fri, 16 Mar 2018 13:03:18 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Julian Veenstra <davidjulianveenstra@gmail.com>
CC: <linux-iio@vger.kernel.org>, Tom Lebreux <tomlebreux@cock.li>,
        "Rodrigo Siqueira" <rodrigosiqueiramelo@gmail.com>
Subject: Re: Removal of blackfin architecture
Message-ID: <20180316140318.000014f6@huawei.com>
In-Reply-To: <5871ecb8-d726-0f6c-3e7a-da58896a97e2@gmail.com>
References: <5871ecb8-d726-0f6c-3e7a-da58896a97e2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 16 Mar 2018 13:50:44 +0100
David Julian Veenstra <davidjulianveenstra@gmail.com> wrote:

> Dear IIO Community,
Hi David,
> 
> Currently, there are 3 people working on moving resolver driver out of
> staging.
> Rodrigo Siqueira is working on ad2s1210, Tom Lebreux is working on ad2s90,
> and I'm working on ad2s1200.
> 
> There is only a single blackfin board ([1]) that sets the proper spi
> driver mod
> alias and platform data for the ad2s1200 and the ad2s1210, and the proper
> mod alias for ads90.

These are still active products and actually have no connection to the
blackfin architecture other than one random board every used them.
(at a guess because that board was the one used to test them in the
first place).

Note that these days you won't even have visibility on whether a board
has one of these connected as it will be handled via devicetree.

Another thing to note is that these types of devices tend to end up
used in boards which no one tends to upstream as they are part of
custom industrial motor controllers.  That doesn't reduce the value
in having the driver upstreamed however.

> 
> However, it seems that general support for blackfin architecture is
> slated to be
> removed, see [2] and [3]. The relevant spi master driver is also being
> removed.
> 
> What is the best course of action? Continue working on the drivers, or
> remove
> the drivers altogether?
> 
> [1] See arch/blackfin/mach-bf537/boards/stamp.c
> [2] https://marc.info/?l=linux-kernel&m=152112517630790&w=2
> [3] https://marc.info/?w=4&r=1&s=%5BBlackfin+removal%5D&q=t

In my view this just highlights the fact we should bring these into the modern
world with proper documented device tree bindings and correct
gpio assignments where needed.

The ad2s90 has no platform data so will work just fine with
a devicetree binding relying on the automatic probing of spi drivers.
The other two need their platform data sorting out and will indeed
not work without support in a board file.  There is no reason why
that board file needs to upstream however (nice though that would be!)

Jonathan

> 
> Best regards,
> David Veenstra
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

