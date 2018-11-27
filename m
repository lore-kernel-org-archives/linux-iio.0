Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt1-f178.google.com ([209.85.160.178]:39463 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeK0RvU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Nov 2018 12:51:20 -0500
Received: by mail-qt1-f178.google.com with SMTP id n21so20606534qtl.6
        for <linux-iio@vger.kernel.org>; Mon, 26 Nov 2018 22:54:27 -0800 (PST)
MIME-Version: 1.0
From: Daniel Drake <drake@endlessm.com>
Date: Tue, 27 Nov 2018 14:54:15 +0800
Message-ID: <CAD8Lp45Ds3VU70kQ7fAUAegbzL-asxmF_iBacWpu7DMKp65sGA@mail.gmail.com>
Subject: Inconsistent SMO8840 accelerometer data between Windows and Linux
To: linux-iio@vger.kernel.org, denis.ciocca@st.com
Cc: Bastien Nocera <hadess@hadess.net>, linux@endlessm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

We are working with SMO8840 sensors integrated into several Acer
all-in-one consumer PCs and we would like to make the accelerometer
work with iio-sensor-proxy so that the display is auto-rotated based
on the physical orientation of the device.

One option is to inspect each device and then apply a mount matrix
override in systemd, but we are looking for a generic solution. On
Windows 10 the same functionality "just works" with the standard
drivers from ST.

Looking at the Windows 10 situation, I can see that the ACPI DSDT
includes orientation data for the accelerometer device, in a package
named _ONT. Using an in-memory DSDT override I was able to remove this
package in order to examine the "raw" uncorrected data from Windows.

I could then deduce the meanings of the 6 values in _ONT: the first 3
are axis ordering, so the values "1 0 2" imply that the data arrives
in order of axis Y, X, Z, or in other words X and Y are swapped. The
final 3 values are inversion flags, values "0 0 1" mean that the Z
values must have their sign flipped.

On this product the values are as above, 1 0 2 0 0 1 (swap X and Y,
negate Z). acpidump:
https://gist.github.com/dsd/588762aaa3b5601ff7fc6a8692755877

However, looking to implement the same _ONT logic on Linux, I was met
with the surprise that the values read by st-accel-i2c do not match
the Windows values taken even when _ONT is removed.

This is a "landscape-first" device like the one illustrated here:
https://blogs.windows.com/buildingapps/2015/09/03/new-sensor-features-in-windows-10/

Here is the data. I took Windows measurements using the "Sensors" app
in the app store, and Linux measurements from sysfs in_accel_[xyz]_raw
and manually normalized into the range -1 to +1.

1. Placed flat on the desk, face up "looking up at the sky"
Windows (with _ONT): (0, 0, -1)
Windows (no _ONT): (0, 0, 1)
Linux: (0, 0, -1)

2. Normal landscape orientation (i.e. picture the device positioned
the right way up and stuck to the wall)
Windows (with _ONT): (0, -1, 0)
Windows (no _ONT): (-1, 0, 0)
Linux: (0, 1, 0)

3. Rotated 90 degrees right from normal landscape orientation
Windows (with _ONT): (1, 0, 0)
Windows (no _ONT): (0, 1, 0)
Linux: (1, 0, 0)

4. Rotated 90 degrees left from normal landscape orientation
Windows (with _ONT): (-1, 0, 0)
Windows (no _ONT): (0, -1, 0)
Linux: (-1, 0, 0)

5. Rotated 180 degrees from normal landscape orientation (i.e. upside down)
Windows (with _ONT): (0, 1, 0)
Windows (no _ONT): (1, 0, 0)
Linux: (0, -1, 0)

Why is the data read by Linux inconsistent with the data from Windows
even after I remove the _ONT orientation adjustment?

Thanks
Daniel
