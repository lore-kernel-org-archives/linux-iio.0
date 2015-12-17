Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35149 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbbLQXiX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Dec 2015 18:38:23 -0500
MIME-Version: 1.0
Date: Thu, 17 Dec 2015 15:38:22 -0800
Message-ID: <CAOhV88ODTazDA2jmn9DP5idMmXXQa9jKB9Ur_aWTD_3WYZM1fw@mail.gmail.com>
Subject: iio/hid-sensor-accel-3d: no output from /dev/iio:device*?
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Crt Mori <cmo@melexis.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

[Starting a new thread from https://lkml.org/lkml/2015/12/15/663, as
now my laptop is displaying values in the sysfs *raw* files.]

So I'm trying to understand exactly how the hid-sensor-accel-3d driver works.

If I turn up debugging, when I `cat
/sys/bus/iio/devices/device*/*raw*`, I see "iio iio:device3:
accel_3d_proc_event" and I think that means that
hid_sensor_push_data() is getting called.

But read()'s on /dev/iio:device3 never produces anything, which is
what iio-sensor-proxy uses to translate events to dbus.

Is it expected that the dev-node is "silent"? Just trying to
understand if an extension to the driver to support a chardev based
output is appropriate, or if iio-sensor-proxy needs to be changed to
handle this device.

-Nish
