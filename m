Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33943 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbdKVPZy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Nov 2017 10:25:54 -0500
Message-ID: <1511364352.16347.59.camel@hadess.net>
Subject: hid-sensor-hub stopped working *again*
From: Bastien Nocera <hadess@hadess.net>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: linux-input@vger.kernel.org
Date: Wed, 22 Nov 2017 16:25:52 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey,

Some time between:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1664eaacec31035450132c46ed2915fd2b2049a
and the current linus kernels (commit 37cb8e1f8e10), the hid-sensor-hub 
driver broke again.

This time, all the values available in sysfs are "0".

I tried reverting:
iio: hid-sensor-trigger: Don't touch sensors unless user space requests
but to no avail.

Using a ColorHugALS with the above "hid-sensor-trigger" patch reverted
I get:
$ cat /sys/devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9:1.0/0003:273F:1008.0029/HID-SENSOR-200041.2.auto/iio:device0/in_illuminance_raw
0
$ cat /sys/devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9:1.0/0003:273F:1008.0029/HID-SENSOR-200041.2.auto/iio:device0/in_intensity_both_raw
0

Ideas, before I start hooking up a test rig to git bisect this?

Cheers
