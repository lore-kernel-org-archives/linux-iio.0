Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:50177 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab2LESpO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Dec 2012 13:45:14 -0500
Message-ID: <50BF961D.5080101@ahsoftware.de>
Date: Wed, 05 Dec 2012 19:44:45 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: HID-sensor(-hub.c) and device IDs
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

is there any special reason why vendor and devices IDs for HID-sensors 
must be listed in drivers/hid/hid-sensor-hub.c and drivers/hid/hid-core.c?

Maybe I'm missing something, but I don't think this is how HID is 
supposed to work.

Regards,

Alexander
