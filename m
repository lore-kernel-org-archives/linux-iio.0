Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33760 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbcANI3Y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jan 2016 03:29:24 -0500
Received: by mail-wm0-f42.google.com with SMTP id f206so332151875wmf.0
        for <linux-iio@vger.kernel.org>; Thu, 14 Jan 2016 00:29:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAn_ec90RULN=X=uoV4CrztyiQ0dsBOjYcSqgmbxqOheQR56ZA@mail.gmail.com>
References: <CAAn_ec90RULN=X=uoV4CrztyiQ0dsBOjYcSqgmbxqOheQR56ZA@mail.gmail.com>
Date: Thu, 14 Jan 2016 16:29:22 +0800
Message-ID: <CAAn_ec9QoS3iW8jAO2eRG9M73X56s23+fWWFk9meO6B0pANayA@mail.gmail.com>
Subject: Re: How to address a latency issue in a data acquisition system (IIO based)?
From: Julio Cruz <jcsistemas2001@gmail.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi again,

After digging on this issue, the SPI data loss was due to:

1. The latency of some kernel drivers/modules. After disable some
modules as suggested by Mat and tglx [1] the SPI handler latency was
better, however still have some missing.
2. The SPI thread priority was too low. After setting the
policy/priority as suggested by Daniel [2], the SPI response was as
expected.

The interrupt latency depends on different factors, and those are very
interesting once you research it (interrupt controller implementation,
device priority of the interrupt, others drivers, etc...). Sorry for
the noise about this issue.

Maybe this experience could be of interest for others SPI based drivers.

Julio

----
[1] Long max latencies on Wandbaord / Freescale i.MX6
http://marc.info/?l=linux-rt-users&m=144368690819933&w=2
----
[2] cyclictest versus custom SPI based system
http://marc.info/?l=linux-rt-users&m=145271122200825&w=2

On Tue, Jan 12, 2016 at 11:50 PM, Julio Cruz <jcsistemas2001@gmail.com> wrote:
> Hi,
>
> I'm running an acquisition system @1KHz sampling frequency (27
> bytes/sample) with libiio as interface between the application and the
> IIO driver (SPI based). The network and local context are working as
> expected.
>
> However, the system have some data loss at SPI level (confirmed by
> scope) even if the data is not pushed to the buffer
> (iio_push_to_buffers). The scope show that every 1.4 sec (aprox), the
> handler is not called. It seem other process is taking priority over
> this.
>
> I'm trying to find the process that is taking over the SPI/IRQ handlers.
>
> - My system is running in ext4 (on SD) and maybe this could be the
> problem (journal)?
> - Implement a RT and review interrupt context as suggested by Xander
> (http://marc.info/?l=linux-iio&m=143933412720586&w=2)?
> - I would like to implement a DMA buffer as suggested by Lars (two
> month ago) but I'm not sure this will help in this case
> (http://marc.info/?l=linux-iio&m=144475305426138&w=2), for now.
>
> In any case, any advice to address this problem is welcome.
>
> Thanks
