Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:43723 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab2DYOzH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Apr 2012 10:55:07 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 5/5] IIO: Move the core abi documentation from staging
Date: Wed, 25 Apr 2012 15:55:00 +0100
Message-Id: <1335365700-1138-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1335365700-1138-1-git-send-email-jic23@kernel.org>
References: <1335365700-1138-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This file contains only the most generic elements. Other
class specific and device specific ABI documents will follow
over time.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 .../ABI/testing}/sysfs-bus-iio                     |    0
 1 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
similarity index 100%
rename from drivers/staging/iio/Documentation/sysfs-bus-iio
rename to Documentation/ABI/testing/sysfs-bus-iio
-- 
1.7.0.4

