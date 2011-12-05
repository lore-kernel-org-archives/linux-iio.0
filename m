Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/5] staging:iio:adc:max1363 add datasheet_name entries.
Date: Mon,  5 Dec 2011 21:56:01 +0000
Message-Id: <1323122164-32314-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1323122164-32314-1-git-send-email-jic23@kernel.org>
References: <1323122164-32314-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

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
1.7.7.4
