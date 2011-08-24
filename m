Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:44523 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab1HXQ0H (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2011 12:26:07 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/8] ioctl region for IIO.
Date: Wed, 24 Aug 2011 17:34:10 +0100
Message-Id: <1314203654-22377-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314203654-22377-1-git-send-email-jic23@cam.ac.uk>
References: <1314203654-22377-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 Documentation/ioctl/ioctl-number.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 845a191..9991b22 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -220,6 +220,7 @@ Code  Seq#(hex)	Include File		Comments
 'i'	00-3F	linux/i2o-dev.h		conflict!
 'i'	0B-1F	linux/ipmi.h		conflict!
 'i'	80-8F	linux/i8k.h
+'i'	90-AF	drivers/staging/iio/chrdev.h
 'j'	00-3F	linux/joystick.h
 'k'	00-0F	linux/spi/spidev.h	conflict!
 'k'	00-05	video/kyro.h		conflict!
-- 
1.7.3.4

