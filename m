Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56191 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbbLNMZY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Dec 2015 07:25:24 -0500
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH v2 1/3] iio: light: us5182d: Fix enable status inconcistency
Date: Mon, 14 Dec 2015 14:24:45 +0200
Message-Id: <1450095887-13122-2-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1450095887-13122-1-git-send-email-adriana.reus@intel.com>
References: <1450095887-13122-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When setting als only or proximity only modes make sure that we mark the
other component as disabled. This fix is in preparation of adding event
support because that will make it possible to switch between one-shot and
continuous modes and not tracking these correctly may cause faulty
behaviour (e.g wrongfully considering px enabled and not setting an
appropriate mode in the chip).

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 Chattier commit message, no other changes

 drivers/iio/light/us5182d.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 256c4bc..f24b687 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -238,8 +238,12 @@ static int us5182d_als_enable(struct us5182d_data *data)
 	int ret;
 	u8 mode;
 
-	if (data->power_mode == US5182D_ONESHOT)
-		return us5182d_set_opmode(data, US5182D_ALS_ONLY);
+	if (data->power_mode == US5182D_ONESHOT) {
+		ret = us5182d_set_opmode(data, US5182D_ALS_ONLY);
+		if (ret < 0)
+			return ret;
+		data->px_enabled = false;
+	}
 
 	if (data->als_enabled)
 		return 0;
@@ -260,8 +264,12 @@ static int us5182d_px_enable(struct us5182d_data *data)
 	int ret;
 	u8 mode;
 
-	if (data->power_mode == US5182D_ONESHOT)
-		return us5182d_set_opmode(data, US5182D_PX_ONLY);
+	if (data->power_mode == US5182D_ONESHOT) {
+		ret = us5182d_set_opmode(data, US5182D_PX_ONLY);
+		if (ret < 0)
+			return ret;
+		data->als_enabled = false;
+	}
 
 	if (data->px_enabled)
 		return 0;
-- 
1.9.1

