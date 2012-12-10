Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:58707 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab2LJVId (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Dec 2012 16:08:33 -0500
Message-ID: <50C64F29.9030200@ahsoftware.de>
Date: Mon, 10 Dec 2012 22:07:53 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	srinivas.pandruvada@intel.com, matteo.dameno@st.com
Subject: hid-sensor-hub and autoloading of HID sensor modules
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

as I've just posted a patch to get rid of the vendor and device IDs for
USB HID sensor hubs, there is still one problem left: hid-sensor-hub
doesn't automatically load the necessary drivers (if they are modules).

Here is a suggestion about how to solve that:

Create HID groups HID_GROUP_SENSOR_ACCEL, HID_GROUP_SENSOR_TIME, ...)
for every type of (supported) sensor (instead of the one
HID_GROUP_SENSOR_HUB), scan for their usage pages (e.g.
HID_USAGE_SENSOR_ACCEL, HID_USAGE_SENSOR_TIME, ...) set the group and so
load the final module and not hid-sensor-hub. hid-sensor-hub will then
get loaded automatically.

As I don't have any real sensor hubs (and no business with them), I
think others should implement such, if that idea got approved to make
sense. ;)
That just would be some few lines, but I couldn't test them with
real-world stuff.

Regards,

Alexander
