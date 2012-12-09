Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:50174 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933977Ab2LIMW0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 9 Dec 2012 07:22:26 -0500
From: Alexander Holler <holler@ahsoftware.de>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>,
	rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 0/3] iio: HID sensor time (as RTC)
Date: Sun,  9 Dec 2012 13:21:36 +0100
Message-Id: <1355055699-2965-1-git-send-email-holler@ahsoftware.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

the following 3 patches are neccessary to add a driver for
(USB) HID sensors of type time (using hid-sensor-hub).

The driver implements a RTC, so the time will be available like from
any other RTC.

Regards,

Alexander

