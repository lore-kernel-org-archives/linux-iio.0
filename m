Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:57669 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab1K0NNy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2011 08:13:54 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/5] staging:iio:adc:max1363 add datasheet_name entries.
Date: Sun, 27 Nov 2011 13:13:59 +0000
Message-Id: <1322399642-22924-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1322399642-22924-1-git-send-email-jic23@kernel.org>
References: <1322399642-22924-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@cam.ac.uk>

Kind of obvious for this device but useful
for testing purposes.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363_core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 9febd1b..0b97123 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -298,6 +298,7 @@ static const enum max1363_modes max1363_mode_list[] = {
 		.channel = num,						\
 		.address = addr,					\
 		.info_mask = MAX1363_INFO_MASK,				\
+		.datasheet_name = "AIN"#num,				\
 		.scan_type = {						\
 			.sign = 'u',					\
 			.realbits = bits,				\
@@ -318,6 +319,7 @@ static const enum max1363_modes max1363_mode_list[] = {
 		.channel2 = num2,					\
 		.address = addr,					\
 		.info_mask = MAX1363_INFO_MASK,				\
+		.datasheet_name = "AIN"#num"-AIN"#num2,			\
 		.scan_type = {						\
 			.sign = 's',					\
 			.realbits = bits,				\
-- 
1.7.7.3

