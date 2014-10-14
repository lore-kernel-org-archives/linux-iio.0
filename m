Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40556 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbaJNTN4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 14 Oct 2014 15:13:56 -0400
From: Dan Murphy <dmurphy@ti.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>
Subject: RFC Introducing Heart Monitors for IIO 
Date: Tue, 14 Oct 2014 14:13:49 -0500
Message-ID: <1413314032-923-1-git-send-email-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

All

I am introducing a new sensor category for IIO.  This is for
heart rate monitors.

Putting this out as a RFC to see if anyone else is developing the
same and we can build upon each others patches.

I have another sensor to follow up on this series but don't want
to start that driver until I understand if there is anyone else
doing the same.

The first patch introduces the heart rate monitoring into the IIO
sub-systems

The second patch introduces the DT documentation heart_monitors directory
along with the documentation for the TI AFE4403 part.

The final patch introduces the heart_monitors directory along with the source
for the TI AFE4403 device

Looking for feedback.

Thanks in advance
Dan

