Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-066.synserver.de ([212.40.185.66]:1043 "EHLO
	smtp-out-066.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755937AbaIWSEN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Sep 2014 14:04:13 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] staging:iio:ad5933: Drop "raw" from channel names
Date: Tue, 23 Sep 2014 20:04:06 +0200
Message-Id: <1411495448-17941-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1411495448-17941-1-git-send-email-lars@metafoo.de>
References: <1411495448-17941-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

"raw" is the name of a channel property, but should not be part of the
channel name itself.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 9a6665d..b6bd609 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -125,7 +125,7 @@ static const struct iio_chan_spec ad5933_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 0,
-		.extend_name = "real_raw",
+		.extend_name = "real",
 		.address = AD5933_REG_REAL_DATA,
 		.scan_index = 0,
 		.scan_type = {
@@ -137,7 +137,7 @@ static const struct iio_chan_spec ad5933_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 0,
-		.extend_name = "imag_raw",
+		.extend_name = "imag",
 		.address = AD5933_REG_IMAG_DATA,
 		.scan_index = 1,
 		.scan_type = {
-- 
1.8.0

