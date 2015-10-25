Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([37.139.156.2]:17678 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751705AbbJYSJx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2015 14:09:53 -0400
From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Johan Hovold <jhovold@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] iio: light: lm3533-als: Print error message on invalid resistance
Date: Sun, 25 Oct 2015 11:09:45 -0700
Message-ID: <1445796586-28683-2-git-send-email-bjorn.andersson@sonymobile.com>
In-Reply-To: <1445796586-28683-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1445796586-28683-1-git-send-email-bjorn.andersson@sonymobile.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Print an error message to indicate that invalid configuration data was
provided in the platform_data, rather than just aborting initialization.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---

This patch can be picked independently of the other 2, but included in the
series for "completeness".

 drivers/iio/light/lm3533-als.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 076bc46fad03..e56937c40a18 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -743,8 +743,10 @@ static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
 {
 	int ret;
 
-	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX)
+	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX) {
+		dev_err(&als->pdev->dev, "invalid resistor value\n");
 		return -EINVAL;
+	};
 
 	ret = lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR_SELECT, val);
 	if (ret) {
-- 
2.4.2

