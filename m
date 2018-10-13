Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:45018 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJMUwv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Oct 2018 16:52:51 -0400
Date: Sat, 13 Oct 2018 14:15:42 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: =?UTF-8?B?7LWc6rSR7Zi4?= <cgh9046@gmail.com>
Cc: linux-iio@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: Declaring a SPI slave device
Message-ID: <20181013141542.1b0831b3@archlinux>
In-Reply-To: <CABqjdMW+PNniq1PxZ+qW8YJDeVK43BnNcC2gCuU1s=Df1Xuzfg@mail.gmail.com>
References: <CABqjdMW+PNniq1PxZ+qW8YJDeVK43BnNcC2gCuU1s=Df1Xuzfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 10 Oct 2018 02:55:05 -0700
최광호 <cgh9046@gmail.com> wrote:

> Hi I am Gwangho Choi,
> 
> I am trying to connect my EVAL-AD5791 board with a raspberry pi 3 b+
> using iio. I enabled SPI from raspi-config. And I made an ad5791
> module from a kernel and loaded. Now, I can see ad5791 and industialio
> module running from "lsmod" command. And I can also see the
> /sys/bus/iio/ directory.So, I connected my board with my raspberry pi,
> but in the /sys/bus/iio/devices there is nothing. I suspect that I did
> not declare a slave device, but I do not know how I can do it. I do
> not know where I should put the spi_board_info code. I cannot find
> arch/.../mach-*/board-*.c files.
> 
> Thanks

Hi Gwangho and welcome to the IIO list.

So, this particular driver supports several ways of being probed.
The platform data option you have been looking at is very much the
old way and is unlikely to be supported on a modern board like the
raspberry pi.  This board will be devicetree based.

This particular DAC doesn't have documented devicetree bindings but
it is using standard interfaces so should still work with that approach.

Taking a similar simple dac device:
Documentation/devicetree/bindings/iio/ad7303.txt

In this device there are two regulators that need specifying if you want
all the scaling to be correct, vdd and vss.  Do those via fixed regulators.
Documentation/devicetree/bindings/iio/ad5592r.txt has a good example
of regulators, but is a much more complex device.

Michael, I don't suppose you have a specific example DT blob for this
device you could share (or want to add devicetree docs?)

Thanks,

Jonathan
