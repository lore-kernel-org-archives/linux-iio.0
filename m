Return-Path: <adriana.reus@intel.com>
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH 1/3] iio: light: us5182d: Fix enable status inconcistency
Date: Wed,  9 Dec 2015 13:40:42 +0200
Message-Id: <1449661244-18692-2-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1449661244-18692-1-git-send-email-adriana.reus@intel.com>
References: <1449661244-18692-1-git-send-email-adriana.reus@intel.com>
List-ID: <linux-iio@vger.kernel.org>

When setting als only or proximity only modes make sure that we mark the other
component as disabled.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
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
