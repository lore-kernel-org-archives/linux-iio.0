Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54656 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932245AbcILPjU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Sep 2016 11:39:20 -0400
Message-ID: <1473694755.6389.2.camel@hadess.net>
Subject: Re: accelerometer orientation
From: Bastien Nocera <hadess@hadess.net>
To: Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org
Date: Mon, 12 Sep 2016 17:39:15 +0200
In-Reply-To: <0b744f22-55c0-da22-b27f-6092aab18365@redhat.com>
References: <0b744f22-55c0-da22-b27f-6092aab18365@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey,

On Mon, 2016-09-12 at 17:25 +0200, Hans de Goede wrote:
> Hi Bastien,
> 
> So as I guess you sorta know in my spare time I work on Linux
> (mainline) support for Allwinner SoC based ARM devices, including
> a whole lot of cheap Chinese tablets.
> 
> Recently I've begun looking into supporting the accelerometers
> on these devices and I'm making good progress on getting the
> kernel bits working using iio drivers (including a few new
> ones I've written recently).
> 
> Yesterday I realized there is a bit of a catch though, all
> these iio drivers report results assuming that the accelerometer
> is mounted on the top side of the PCB and with its X/Y
> coordination properly taken info account.
> 
> Unfortunately neither is necessarily true. Almost all
> tablet PCBS are mounted upside down (with an empty PCB
> backside against the lcd-panel. Meaning that the Z axis
> reads -1G when the tablet is lying on its back instead
> of the expected +1G and some need X/Y axis swapping and/or
> inversion too.
> 
> So there are 3 problems here:
> 
> 1) Where do we store the orientation of the chip
> 
<snip>
> 2) Where do we correct the readings for the orientation
<snip>
> 3) Currently implementing orientation support in an iio driver
> requires copy and pasting quite a bit of boiler plate, so
> a question to the linux-iio list, has anyone though of an
> easier way to do this. I really just want to be able to
> pass say a single flag to iio_device_register and then
> have the iio-core automatically call of_iio_read_mount_matrix()
> and add mount_matrix ext_info.

All good ideas, but we need a way to do this for devices without DT
(meaning all of the x86 tablets).

Perhaps iio-sensor-proxy could read from udev instead, and udev either
pull from DT when available, or apply from its own rules?

Cheers
