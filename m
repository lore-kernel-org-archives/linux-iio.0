Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42285 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964876AbbDVQcQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 22 Apr 2015 12:32:16 -0400
From: Dan Murphy <dmurphy@ti.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>
Subject: Adding Heart Monitors to IIO take 2
Date: Wed, 22 Apr 2015 11:32:08 -0500
Message-ID: <1429720331-1900-1-git-send-email-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



 All

I am introducing a new sensor category for IIO (again).  This is for
heart rate monitors.

I have another sensor to follow up on this series but I do not want to
share that driver until the datasheet is closer to being final.

The first patch introduces the heart rate monitoring into the IIO
sub-systems

The second patch introduces the DT documentation heart_monitors directory
along with the documentation for the TI AFE4403 part.

The final patch introduces the heart_monitors directory along with the source
for the TI AFE4403 device

I know I have introduced this as a RFC before but now I am submitting for
inclusion once reviewed.

Dan
