Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37059 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbbG2M5p (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2015 08:57:45 -0400
Received: by wibud3 with SMTP id ud3so25013852wib.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2015 05:57:44 -0700 (PDT)
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, cory.tusar@pid1solutions.com
Subject: [PATCH v3 7/7] iio: Fix typos in ABI documentation
Date: Wed, 29 Jul 2015 15:57:41 +0300
Message-Id: <1438174661-19371-1-git-send-email-vladimir.barinov@cogentembedded.com>
In-Reply-To: <1438174469-19054-1-git-send-email-vladimir.barinov@cogentembedded.com>
References: <1438174469-19054-1-git-send-email-vladimir.barinov@cogentembedded.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix typos in ABI documentation

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
---
Changes in version 3:
- initially added

 Documentation/ABI/testing/sysfs-bus-iio | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 65bf49e..71a48b7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -488,7 +488,7 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Specifies the output powerdown mode.
 		DAC output stage is disconnected from the amplifier and
-		1kohm_to_gnd: connected	to ground via an 1kOhm resistor,
+		1kohm_to_gnd: connected to ground via an 1kOhm resistor,
 		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
 		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
 		100kohm_to_gnd: connected to ground via an 100kOhm resistor,
@@ -498,9 +498,9 @@ Description:
 		outX_powerdown_mode_available. If Y is not present the
 		mode is shared across all outputs.
 
-What:		/sys/.../iio:deviceX/out_votlageY_powerdown_mode_available
+What:		/sys/.../iio:deviceX/out_voltageY_powerdown_mode_available
 What:		/sys/.../iio:deviceX/out_voltage_powerdown_mode_available
-What:		/sys/.../iio:deviceX/out_altvotlageY_powerdown_mode_available
+What:		/sys/.../iio:deviceX/out_altvoltageY_powerdown_mode_available
 What:		/sys/.../iio:deviceX/out_altvoltage_powerdown_mode_available
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
-- 
1.9.1

