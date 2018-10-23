Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:44330 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWSIi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Oct 2018 14:08:38 -0400
Date: Tue, 23 Oct 2018 10:45:54 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc: linux-iio@vger.kernel.org, kernel-usp@googlegroups.com,
        Victor Colombo <victorcolombo@gmail.com>
Subject: Re: Work plan on ad2s90
Message-ID: <20181023104554.155dcdcf@archlinux>
In-Reply-To: <CAHd-oW7fA_1H3jnUTOhs7VXJ3Zciq6j2WthAytE39NedYpTibg@mail.gmail.com>
References: <CAHd-oW7fA_1H3jnUTOhs7VXJ3Zciq6j2WthAytE39NedYpTibg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 19 Oct 2018 23:49:06 -0300
Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:

> Hello everyone.
Hi Matheus.
> 
> I'm looking at the code and datasheet of ad2s90, trying to understand
> what is needed to move it to the main tree. I and my study group
> intend to work on it.

Great,

> 
> I do not understand all the necessary steps yet, but I will present
> here some brief items for discussion. I'd like to ask if I'm on the
> right track. All feedback will be much appreciated.
> 
> Some of the things that I think need to be done:
> - The IIO_CHAN_INFO_SCALE information mask is not set yet
Good point, that should be possible to establish for a resolver.

> - The read_raw function does not return the error code returned by
> spi_read on failure
Good spot (I missed that one at first glance ;)

> - There is no channel for velocity yet

I'm fairly sure that's because the device doesn't allow you to read that
via the serial bus.  There is an analog velocity outlook so you could
read it via an ADC and do the appropriate chaining of IIO devices
to provide that in this driver, but I wouldn't necessarily suggest doing
that without some hardware to test it.

> - There are two minor codestyle corrections to be made
> - Maybe it's possible to change the bit operations at the read_raw for
> a bitops.h function call
Not really.  It is a weird form of shifted endian conversion, so you
'could' do it that way and in theory make it a single shift in once case
and swap and shift in the other.  Probably not worth it though.

a few additions.
* Devicetree support with standard devicetree id table.

* The spi setup at the end of probe occurs 'after' the device is ready
for use.  A definite race condition that needs fixing.

* Some pointless variable initial assignments that are always overwritten.

> 
> Best regards,
> Matheus

Thanks,

Jonathan
