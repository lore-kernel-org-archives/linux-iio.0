Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:51568 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629AbbG0Wtn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 18:49:43 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH 5/7] iio:accel:stk8312: use appropriate variable types
Date: Tue, 28 Jul 2015 00:49:25 +0200
Message-Id: <84ecb786252220464167b49924c99067d15b3ada.1437955135.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437955135.git.knaack.h@gmx.de>
References: <cover.1437955135.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437955135.git.knaack.h@gmx.de>
References: <cover.1437955135.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adapt some variable types to reduce unnecessary casting.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/stk8312.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 8783f0bf7c53..e3624e2b3ec4 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -69,8 +69,8 @@ static const int stk8312_scale_table[][2] = {
 };
 
 static const struct {
-	u16 val;
-	u32 val2;
+	int val;
+	int val2;
 } stk8312_samp_freq_table[] = {
 	{400, 0}, {200, 0}, {100, 0}, {50, 0}, {25, 0},
 	{12, 500000}, {6, 250000}, {3, 125000}
@@ -103,7 +103,7 @@ static const struct iio_chan_spec stk8312_channels[] = {
 struct stk8312_data {
 	struct i2c_client *client;
 	struct mutex lock;
-	int range;
+	u8 range;
 	u8 sample_rate_idx;
 	u8 mode;
 	struct iio_trigger *dready_trig;
@@ -242,7 +242,7 @@ static const struct iio_trigger_ops stk8312_trigger_ops = {
 	.owner = THIS_MODULE,
 };
 
-static int stk8312_set_sample_rate(struct stk8312_data *data, int rate)
+static int stk8312_set_sample_rate(struct stk8312_data *data, u8 rate)
 {
 	int ret;
 	u8 masked_reg;
-- 
2.4.6

