Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49799 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932274AbcKVKuZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Nov 2016 05:50:25 -0500
Message-ID: <1479811817.13456.18.camel@hadess.net>
Subject: ACPI DSDT support for mount-matrix?
From: Bastien Nocera <hadess@hadess.net>
To: linux-iio@vger.kernel.org
Cc: Gregor Boirie <gregor.boirie@parrot.com>,
        faouaz.tenoutit@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Tue, 22 Nov 2016 11:50:17 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey,

Gregor added support for exporting the mount matrix from the Device
Tree to the IIO accelerometer:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=dfc57732ad38f93ae6232a3b4e64fd077383a0f1

And Faouaz wanted to add support for exporting the mount matrix from
the ACPI DSDT to sysfs as well:
http://www.spinics.net/lists/linux-acpi/msg51540.html

Would it be possible to rework that ACPI patch to export the mount
matrix through IIO as is done for DeviceTree-based machines?

I'm adding mount-matrix support to iio-sensor-proxy, which currently
means getting that information from the firmware through the IIO
device, using udev as a way to override that, if the firmware doesn't
contain that information. I'd like to avoid having 3 different sources
for the value.

Cheers

PS: I'd also be interested in that _PLD information to export the
information to webcams.
