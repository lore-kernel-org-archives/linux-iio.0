Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753421AbcILPZt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Sep 2016 11:25:49 -0400
To: Bastien Nocera <hadess@hadess.net>, linux-iio@vger.kernel.org
From: Hans de Goede <hdegoede@redhat.com>
Subject: accelerometer orientation
Message-ID: <0b744f22-55c0-da22-b27f-6092aab18365@redhat.com>
Date: Mon, 12 Sep 2016 17:25:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Bastien,

So as I guess you sorta know in my spare time I work on Linux
(mainline) support for Allwinner SoC based ARM devices, including
a whole lot of cheap Chinese tablets.

Recently I've begun looking into supporting the accelerometers
on these devices and I'm making good progress on getting the
kernel bits working using iio drivers (including a few new
ones I've written recently).

Yesterday I realized there is a bit of a catch though, all
these iio drivers report results assuming that the accelerometer
is mounted on the top side of the PCB and with its X/Y
coordination properly taken info account.

Unfortunately neither is necessarily true. Almost all
tablet PCBS are mounted upside down (with an empty PCB
backside against the lcd-panel. Meaning that the Z axis
reads -1G when the tablet is lying on its back instead
of the expected +1G and some need X/Y axis swapping and/or
inversion too.

So there are 3 problems here:

1) Where do we store the orientation of the chip

For the allwinner tablets I'm working on the answer is
easy: In devicetree

2) Where do we correct the readings for the orientation

AFAIK the iio framework does not offer a way to fix the readings
up in the kernel (please correct me if I'm wrong), I'm seeing
something called an mount_matrix in iio which seems to be
able to convey the necessary info from the kernel to userspace.

So Bastien, would you be open to a (future) patch to
iio-sensor-proxy for reading and using this info,
or even better yet be willing to write one ?

In device tree it looks like this:

                 mount-matrix = "-0.984807753012208",  /* x0 */
                                "0",                   /* y0 */
                                "-0.173648177666930",  /* z0 */
                                "0",                   /* x1 */
                                "-1",                  /* y1 */
                                "0",                   /* z1 */
                                "-0.173648177666930",  /* x2 */
                                "0",                   /* y2 */
                                "0.984807753012208";   /* z2 */

And if I'm reading the iio-core code correctly the mount_matrix
sysfs attribute will contain a string with these 9 values
in text-format seperated by ","

3) Currently implementing orientation support in an iio driver
requires copy and pasting quite a bit of boiler plate, so
a question to the linux-iio list, has anyone though of an
easier way to do this. I really just want to be able to
pass say a single flag to iio_device_register and then
have the iio-core automatically call of_iio_read_mount_matrix()
and add mount_matrix ext_info.

Regards,

Hans

