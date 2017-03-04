Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0059.outbound.protection.outlook.com ([104.47.33.59]:38112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751733AbdCDBJA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 Mar 2017 20:09:00 -0500
From: "Schaefer, Brandon" <brandon.schaefer@flukenetworks.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: mma8425 driver: scan_elements name error
 in_accel_(null)_mag_falling_en
Date: Sat, 4 Mar 2017 01:08:52 +0000
Message-ID: <BN6PR12MB144204BCF6906BC9B3D6C7AD902A0@BN6PR12MB1442.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Kernel version: 4.1.15
Part: mma8652

The sysfs node for what I think should be in_accel_x&y&z_mag_falling_en is =
output incorrectly and displayed as in_accel_(null)_mag_falling_en. Any sug=
gestions on a fix for this?

Also, in an unrelated question for a novice with the iio subsystem. I've ve=
rified that I can read x/y/z raw values, setup thresholds, and interrupts a=
re generated. What's the proper way for userspace to poll for these interru=
pts? I can't seem to find documentation on the sysfs node to poll. There is=
 no character device node /dev/iio:deviceX which I've seen documentation on=
.

One last question that someone may be able to answer (activity on this driv=
er dates back to a year?). A commit removed "TODO: autosleep" and opted for=
 runtime pm, but this runtime PM will disable interrupts that can be genera=
ted by the accelerometer that the system can use to wake from a suspended s=
tate. The datasheet for the mma8652 clearly specifies that the acceleromete=
r sleep state is intended to be used to wake up a suspended system. Was thi=
s not considered when opting for runtime pm of the accelerometer?

Thanks for any and all help!

Brandon
________________________________
________________________________


Please be advised that this email may contain confidential information. If =
you are not the intended recipient, please notify us by email by replying t=
o the sender and delete this message. The sender disclaims that the content=
 of this email constitutes an offer to enter into, or the acceptance of, an=
y agreement; provided that the foregoing does not invalidate the binding ef=
fect of any digital or other electronic reproduction of a manual signature =
that is included in any attachment.
