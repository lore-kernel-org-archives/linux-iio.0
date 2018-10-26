Return-Path: <SRS0=WEiQ=NG=poczta.fm=sst@kernel.org>
From: Slawomir Stepien <sst@poczta.fm>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 1/1] staging: iio: adc: ad7280a: don't cast type inside switch expression
Date: Fri, 26 Oct 2018 18:53:10 +0200
Message-Id: <20181026165310.16545-1-sst@poczta.fm>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

The type promotion will kick in, so the comparison will work.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/staging/iio/adc/ad7280a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index b736275c10f5..7de6be4f0c27 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -610,7 +610,7 @@ static ssize_t ad7280_read_channel_config(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	unsigned int val;
 
-	switch ((u32)this_attr->address) {
+	switch (this_attr->address) {
 	case AD7280A_CELL_OVERVOLTAGE:
 		val = 1000 + (st->cell_threshhigh * 1568) / 100;
 		break;
@@ -646,7 +646,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
 	if (ret)
 		return ret;
 
-	switch ((u32)this_attr->address) {
+	switch (this_attr->address) {
 	case AD7280A_CELL_OVERVOLTAGE:
 	case AD7280A_CELL_UNDERVOLTAGE:
 		val = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
@@ -662,7 +662,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
 	val = clamp(val, 0L, 0xFFL);
 
 	mutex_lock(&st->lock);
-	switch ((u32)this_attr->address) {
+	switch (this_attr->address) {
 	case AD7280A_CELL_OVERVOLTAGE:
 		st->cell_threshhigh = val;
 		break;
-- 
2.19.1
