Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de,
	linux-iio@vger.kernel.org
Cc: drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 19/22] staging:iio:max1363 add _index attribute registration
Date: Mon, 20 Sep 2010 15:13:04 +0100
Message-Id: <1284991987-12407-20-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Also fixes a missing NULL to terminate one of the attribute arrays.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363_core.c |   49 ++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index d59a8d2..06c6024 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -385,13 +385,21 @@ static struct attribute_group max1363_dev_attr_group = {
 
 static struct attribute *max1363_scan_el_attrs[] = {
 	&iio_scan_el_in0.dev_attr.attr,	&dev_attr_in0_type.attr,
+	&iio_const_attr_in0_index.dev_attr.attr,
 	&iio_scan_el_in1.dev_attr.attr,	&dev_attr_in1_type.attr,
+	&iio_const_attr_in1_index.dev_attr.attr,
 	&iio_scan_el_in2.dev_attr.attr,	&dev_attr_in2_type.attr,
+	&iio_const_attr_in2_index.dev_attr.attr,
 	&iio_scan_el_in3.dev_attr.attr,	&dev_attr_in3_type.attr,
+	&iio_const_attr_in3_index.dev_attr.attr,
 	&iio_scan_el_in0min1.dev_attr.attr,	&dev_attr_in0min1_type.attr,
+	&iio_const_attr_in0min1_index.dev_attr.attr,
 	&iio_scan_el_in2min3.dev_attr.attr,	&dev_attr_in2min3_type.attr,
+	&iio_const_attr_in2min3_index.dev_attr.attr,
 	&iio_scan_el_in1min0.dev_attr.attr,	&dev_attr_in1min0_type.attr,
+	&iio_const_attr_in1min0_index.dev_attr.attr,
 	&iio_scan_el_in3min2.dev_attr.attr,	&dev_attr_in3min2_type.attr,
+	&iio_const_attr_in3min2_index.dev_attr.attr,
 	NULL,
 };
 
@@ -458,29 +466,53 @@ static struct attribute_group max1238_dev_attr_group = {
 
 static struct attribute *max1238_scan_el_attrs[] = {
 	&iio_scan_el_in0.dev_attr.attr,	&dev_attr_in0_type.attr,
+	&iio_const_attr_in0_index.dev_attr.attr,
 	&iio_scan_el_in1.dev_attr.attr,	&dev_attr_in1_type.attr,
+	&iio_const_attr_in1_index.dev_attr.attr,
 	&iio_scan_el_in2.dev_attr.attr,	&dev_attr_in2_type.attr,
+	&iio_const_attr_in2_index.dev_attr.attr,
 	&iio_scan_el_in3.dev_attr.attr,	&dev_attr_in3_type.attr,
+	&iio_const_attr_in3_index.dev_attr.attr,
 	&iio_scan_el_in4.dev_attr.attr,	&dev_attr_in4_type.attr,
+	&iio_const_attr_in4_index.dev_attr.attr,
 	&iio_scan_el_in5.dev_attr.attr,	&dev_attr_in5_type.attr,
+	&iio_const_attr_in5_index.dev_attr.attr,
 	&iio_scan_el_in6.dev_attr.attr,	&dev_attr_in6_type.attr,
+	&iio_const_attr_in6_index.dev_attr.attr,
 	&iio_scan_el_in7.dev_attr.attr,	&dev_attr_in7_type.attr,
+	&iio_const_attr_in7_index.dev_attr.attr,
 	&iio_scan_el_in8.dev_attr.attr,	&dev_attr_in8_type.attr,
+	&iio_const_attr_in8_index.dev_attr.attr,
 	&iio_scan_el_in9.dev_attr.attr,	&dev_attr_in9_type.attr,
+	&iio_const_attr_in9_index.dev_attr.attr,
 	&iio_scan_el_in10.dev_attr.attr,	&dev_attr_in10_type.attr,
+	&iio_const_attr_in10_index.dev_attr.attr,
 	&iio_scan_el_in11.dev_attr.attr,	&dev_attr_in11_type.attr,
+	&iio_const_attr_in11_index.dev_attr.attr,
 	&iio_scan_el_in0min1.dev_attr.attr,	&dev_attr_in0min1_type.attr,
+	&iio_const_attr_in0min1_index.dev_attr.attr,
 	&iio_scan_el_in2min3.dev_attr.attr,	&dev_attr_in2min3_type.attr,
+	&iio_const_attr_in2min3_index.dev_attr.attr,
 	&iio_scan_el_in4min5.dev_attr.attr,	&dev_attr_in4min5_type.attr,
+	&iio_const_attr_in4min5_index.dev_attr.attr,
 	&iio_scan_el_in6min7.dev_attr.attr,	&dev_attr_in6min7_type.attr,
+	&iio_const_attr_in6min7_index.dev_attr.attr,
 	&iio_scan_el_in8min9.dev_attr.attr,	&dev_attr_in8min9_type.attr,
+	&iio_const_attr_in8min9_index.dev_attr.attr,
 	&iio_scan_el_in10min11.dev_attr.attr,	&dev_attr_in10min11_type.attr,
+	&iio_const_attr_in10min11_index.dev_attr.attr,
 	&iio_scan_el_in1min0.dev_attr.attr,	&dev_attr_in1min0_type.attr,
+	&iio_const_attr_in1min0_index.dev_attr.attr,
 	&iio_scan_el_in3min2.dev_attr.attr,	&dev_attr_in3min2_type.attr,
+	&iio_const_attr_in3min2_index.dev_attr.attr,
 	&iio_scan_el_in5min4.dev_attr.attr,	&dev_attr_in5min4_type.attr,
+	&iio_const_attr_in5min4_index.dev_attr.attr,
 	&iio_scan_el_in7min6.dev_attr.attr,	&dev_attr_in7min6_type.attr,
+	&iio_const_attr_in7min6_index.dev_attr.attr,
 	&iio_scan_el_in9min8.dev_attr.attr,	&dev_attr_in9min8_type.attr,
+	&iio_const_attr_in9min8_index.dev_attr.attr,
 	&iio_scan_el_in11min10.dev_attr.attr,	&dev_attr_in11min10_type.attr,
+	&iio_const_attr_in11min10_index.dev_attr.attr,
 	NULL,
 };
 
@@ -536,21 +568,38 @@ static struct attribute_group max11608_dev_attr_group = {
 
 static struct attribute *max11608_scan_el_attrs[] = {
 	&iio_scan_el_in0.dev_attr.attr,	&dev_attr_in0_type.attr,
+	&iio_const_attr_in0_index.dev_attr.attr,
 	&iio_scan_el_in1.dev_attr.attr,	&dev_attr_in1_type.attr,
+	&iio_const_attr_in1_index.dev_attr.attr,
 	&iio_scan_el_in2.dev_attr.attr,	&dev_attr_in2_type.attr,
+	&iio_const_attr_in2_index.dev_attr.attr,
 	&iio_scan_el_in3.dev_attr.attr,	&dev_attr_in3_type.attr,
+	&iio_const_attr_in3_index.dev_attr.attr,
 	&iio_scan_el_in4.dev_attr.attr,	&dev_attr_in4_type.attr,
+	&iio_const_attr_in4_index.dev_attr.attr,
 	&iio_scan_el_in5.dev_attr.attr,	&dev_attr_in5_type.attr,
+	&iio_const_attr_in5_index.dev_attr.attr,
 	&iio_scan_el_in6.dev_attr.attr,	&dev_attr_in6_type.attr,
+	&iio_const_attr_in6_index.dev_attr.attr,
 	&iio_scan_el_in7.dev_attr.attr,	&dev_attr_in7_type.attr,
+	&iio_const_attr_in7_index.dev_attr.attr,
 	&iio_scan_el_in0min1.dev_attr.attr,	&dev_attr_in0min1_type.attr,
+	&iio_const_attr_in0min1_index.dev_attr.attr,
 	&iio_scan_el_in2min3.dev_attr.attr,	&dev_attr_in2min3_type.attr,
+	&iio_const_attr_in2min3_index.dev_attr.attr,
 	&iio_scan_el_in4min5.dev_attr.attr,	&dev_attr_in4min5_type.attr,
+	&iio_const_attr_in4min5_index.dev_attr.attr,
 	&iio_scan_el_in6min7.dev_attr.attr,	&dev_attr_in6min7_type.attr,
+	&iio_const_attr_in6min7_index.dev_attr.attr,
 	&iio_scan_el_in1min0.dev_attr.attr,	&dev_attr_in1min0_type.attr,
+	&iio_const_attr_in1min0_index.dev_attr.attr,
 	&iio_scan_el_in3min2.dev_attr.attr,	&dev_attr_in3min2_type.attr,
+	&iio_const_attr_in3min2_index.dev_attr.attr,
 	&iio_scan_el_in5min4.dev_attr.attr,	&dev_attr_in5min4_type.attr,
+	&iio_const_attr_in5min4_index.dev_attr.attr,
 	&iio_scan_el_in7min6.dev_attr.attr,	&dev_attr_in7min6_type.attr,
+	&iio_const_attr_in7min6_index.dev_attr.attr,
+	NULL
 };
 
 static struct attribute_group max11608_scan_el_group = {
-- 
1.7.2.2
