Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665934C77BD;
	Sun, 18 Oct 2026 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792330909; cv=none; b=A2OzptxBCC1rTjyDuBIrJ761+mRS2xIPQYQyKhimQIEOLE8B1MAGs9STPdrTAOFDa8BQKY87E81BVG5YaIxXdQrMabGme99L+KcPqsKtozabi0wzJ+MFH2GP2EX2gMygFdmte9V36h3GOaPoCZXOIlmCu0ARiYCI5BMl8i/k2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792330909; c=relaxed/simple;
	bh=jewUbBuu7DkomHGB/l7F87K0o66qKAjGNy52UaR59fs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PymtCyr+HxTfCO19YXL9dhFNIFv+BTkNmNa3xU1vkQN7FzBsXdHbHepajWuXmekC2ED6R+v2ltaYGEEX8/IWolypofAHKcrkRQMBNwMJBAPbHoe/XIaszHB4plupXMWJHS0mKqldBimdrX2oeKndMAPqpFwpIZ3sT/nlzZF36Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCIamBvl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCIamBvl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2403BC2BCC7;
	Sun, 18 Oct 2026 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792330909;
	bh=jewUbBuu7DkomHGB/l7F87K0o66qKAjGNy52UaR59fs=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=NCIamBvlRV8JNJ73oUeEx9h9M5qBjvkAfLaomBeUFp/Y1coewi15yKEeu2o5Lf9eW
	 oB+A1st8n6oRMgcwifZx9iF6m+CH0Xw10Tw9Atz3MMc1zPr9NnhC+QLIxoQhi0nnFm
	 Mjp3UlBEroKyq1Mu9lcEmOZTppEhuwDKOlWukTl/F3kDk8eaS5ulQViV1hNyFuO/+p
	 ubmyvsFdbXmtyFxudQxKHvlbTkHt6arJJg6UoH3bD+7Oi5XGKJic6p/HuJt5wEy6VW
	 DRrE+yNXLF7mnVhhlX7DENclUaW90f9zmWDVEn6EW3SdTeYkQYf59zvVaEzrBpAMd1
	 bawtijch6bGkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129CFCCF2C4;
	Sun, 18 Oct 2026 13:41:49 +0000 (UTC)
From: Wenqiang Zhao via B4 Relay <devnull+berringtoni36.gmail.com@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Lothar Rubusch <l.rubusch@gmail.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: accel: adxl345: separate event state from query
 errors
Date: Sun, 18 Oct 2026 21:42:00 +0800
Message-ID: <20261018-adxl345-event-state-v3-1@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792330908; l=7577;
 i=berringtoni36@gmail.com; s=review-20261018; h=from:subject:message-id;
 bh=TeZ8xpWHy5fDJf8bSND3EmgpNE1AN8KsOt8raqa5NgE=;
 b=ljX+SgEXS8ukZSO6TyTB/XT6YgoSJaMhQaZyvK1wrqaNubbPN9IgM+dwANzY3CHMrnULVMHdf
 kZtn/9FEQuaB8Wt3jP3dCF/EBF5OTyiYTBoEHv+3K5/+N8CYQ3AHmoi
X-Developer-Key: i=berringtoni36@gmail.com; a=ed25519;
 pk=rRiAvRvS4MMqogNnloZgVnqWliVWNDq+PcP6vMYXOvs=
X-Endpoint-Received: by B4 Relay for
 berringtoni36@gmail.com/review-20261018 with auth_id=1226
X-Original-From: Wenqiang Zhao <berringtoni36@gmail.com>
Reply-To: berringtoni36@gmail.com

From: Wenqiang Zhao <berringtoni36@gmail.com>

The activity/inactivity query helpers return either a boolean result or a
negative regmap error. adxl345_read_mag_config() converts the latter to 1
with !!, reporting a failed read as an enabled event. The disable path
also turns a coupling query error into a successful write.

Return query status separately from the boolean result by passing bool
output parameters to both helpers. Rename them from is_* to get_* and
update the event read, disable and link-bit callers to check the status
before using the result. Preserve the successful coupling-mismatch
no-op when disabling an event.

Fixes: 66a1af6d8a63 ("iio: accel: adxl345: add activity event feature")
Fixes: 31f7679bb69a ("iio: accel: adxl345: add coupling detection for activity/inactivity")
Assisted-by: LLM
Signed-off-by: Wenqiang Zhao <berringtoni36@gmail.com>
---
v3:
- Use bool output parameters for query results, as Jonathan suggested.
- Apply the same convention to the coupling helper and all callers.
- Combine the two previous patches because both paths share these helpers.
- Submitted via b4 web submission to avoid delivery-time wrapping.

Validation: 534 host function-chain cases pass with UBSan, including
register-read fault injection, link-bit updates and free-fall queries.
No full kernel build or sensor hardware test was performed. ASan could
not start on this macOS host; it hung during runtime initialization.

 drivers/iio/accel/adxl345_core.c | 94 ++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 6c9080d88..51fbcc218 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -463,27 +463,25 @@ static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_int,
 }
 
 /**
- * adxl345_is_act_inact_ac() - Verify if AC or DC coupling is currently enabled.
- *
+ * adxl345_get_act_inact_ac() - Check the configured coupling.
  * @st: The device data.
  * @type: The activity or inactivity type.
+ * @matches: Whether the configured coupling matches the provided type.
  *
- * Given a type of activity / inactivity combined with either AC coupling set or
- * default to DC, this function verifies if the combination is currently
- * configured, hence enabled or not.
- *
- * Return: true if configured coupling matches the provided type, else a negative
- *         error value.
+ * Return: 0 on success, or a negative error value.
  */
-static int adxl345_is_act_inact_ac(struct adxl345_state *st,
-				   enum adxl345_activity_type type)
+static int adxl345_get_act_inact_ac(struct adxl345_state *st,
+				    enum adxl345_activity_type type,
+				    bool *matches)
 {
 	unsigned int regval;
 	bool coupling;
 	int ret;
 
-	if (type == ADXL345_INACTIVITY_FF)
-		return true;
+	if (type == ADXL345_INACTIVITY_FF) {
+		*matches = true;
+		return 0;
+	}
 
 	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regval);
 	if (ret)
@@ -494,13 +492,17 @@ static int adxl345_is_act_inact_ac(struct adxl345_state *st,
 	switch (type) {
 	case ADXL345_ACTIVITY:
 	case ADXL345_INACTIVITY:
-		return coupling == ADXL345_COUPLING_DC;
+		*matches = coupling == ADXL345_COUPLING_DC;
+		break;
 	case ADXL345_ACTIVITY_AC:
 	case ADXL345_INACTIVITY_AC:
-		return coupling == ADXL345_COUPLING_AC;
+		*matches = coupling == ADXL345_COUPLING_AC;
+		break;
 	default:
 		return -EINVAL;
 	}
+
+	return 0;
 }
 
 /**
@@ -567,14 +569,17 @@ static int adxl345_set_act_inact_ac(struct adxl345_state *st,
 				  adxl345_act_acdc_msk[type], act_inact_ac);
 }
 
-static int adxl345_is_act_inact_en(struct adxl345_state *st,
-				   enum adxl345_activity_type type)
+static int adxl345_get_act_inact_en(struct adxl345_state *st,
+				    enum adxl345_activity_type type,
+				    bool *enabled)
 {
 	unsigned int axis_ctrl;
 	unsigned int regval;
 	bool int_en, en;
 	int ret;
 
+	*enabled = false;
+
 	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis_ctrl);
 	if (ret)
 		return ret;
@@ -585,13 +590,13 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 	case ADXL345_ACTIVITY_AC:
 		en = FIELD_GET(ADXL345_ACT_XYZ_EN, axis_ctrl);
 		if (!en)
-			return false;
+			return 0;
 		break;
 	case ADXL345_INACTIVITY:
 	case ADXL345_INACTIVITY_AC:
 		en = FIELD_GET(ADXL345_INACT_XYZ_EN, axis_ctrl);
 		if (!en)
-			return false;
+			return 0;
 		break;
 	case ADXL345_INACTIVITY_FF:
 		en = true;
@@ -607,37 +612,39 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 
 	int_en = adxl345_act_int_reg[type] & regval;
 	if (!int_en)
-		return false;
+		return 0;
 
 	/* Check if configured coupling matches provided type */
-	return adxl345_is_act_inact_ac(st, type);
+	return adxl345_get_act_inact_ac(st, type, enabled);
 }
 
 static int adxl345_set_act_inact_linkbit(struct adxl345_state *st,
 					 enum adxl345_activity_type type,
 					 bool en)
 {
-	int act_ac_en, inact_ac_en;
-	int act_en, inact_en;
+	bool act_ac_en, inact_ac_en;
+	bool act_en, inact_en;
+	int ret;
 
-	act_en = adxl345_is_act_inact_en(st, ADXL345_ACTIVITY);
-	if (act_en < 0)
-		return act_en;
+	ret = adxl345_get_act_inact_en(st, ADXL345_ACTIVITY, &act_en);
+	if (ret)
+		return ret;
 
-	act_ac_en = adxl345_is_act_inact_en(st, ADXL345_ACTIVITY_AC);
-	if (act_ac_en < 0)
-		return act_ac_en;
+	ret = adxl345_get_act_inact_en(st, ADXL345_ACTIVITY_AC, &act_ac_en);
+	if (ret)
+		return ret;
 
 	if (type == ADXL345_INACTIVITY_FF) {
 		inact_en = false;
 	} else {
-		inact_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY);
-		if (inact_en < 0)
-			return inact_en;
+		ret = adxl345_get_act_inact_en(st, ADXL345_INACTIVITY, &inact_en);
+		if (ret)
+			return ret;
 
-		inact_ac_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY_AC);
-		if (inact_ac_en < 0)
-			return inact_ac_en;
+		ret = adxl345_get_act_inact_en(st, ADXL345_INACTIVITY_AC,
+					       &inact_ac_en);
+		if (ret)
+			return ret;
 
 		inact_en = inact_en || inact_ac_en;
 	}
@@ -656,6 +663,7 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	unsigned int axis_ctrl;
 	unsigned int threshold;
 	unsigned int period;
+	bool matches;
 	int ret;
 
 	if (cmd_en) {
@@ -692,7 +700,10 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 		 * current call attempts to turn off a DC-coupled activity, this
 		 * inconsistency should be detected here.
 		 */
-		ret = adxl345_get_act_inact_ac(st, type, &matches);
+		ret = adxl345_get_act_inact_ac(st, type, &matches);
 		if (ret)
 			return ret;
 		if (!matches)
 			return 0;
 	}
 
@@ -1174,14 +1185,23 @@ static int adxl345_read_mag_config(struct adxl345_state *st,
 				   enum adxl345_activity_type type_act,
 				   enum adxl345_activity_type type_inact)
 {
+	bool enabled;
+	int ret;
+
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
-		ret = adxl345_get_act_inact_en(st, type_act, &enabled);
+		ret = adxl345_get_act_inact_en(st, type_act, &enabled);
 		break;
 	case IIO_EV_DIR_FALLING:
-		ret = adxl345_get_act_inact_en(st, type_inact, &enabled);
+		ret = adxl345_get_act_inact_en(st, type_inact, &enabled);
 		break;
 	default:
 		return -EINVAL;
 	}
+	if (ret)
+		return ret;
+
 	return enabled;
 }
 
 static int adxl345_write_mag_config(struct adxl345_state *st,

base-commit: 28691515f54f03f23636cbf1ee2cd60fc31e2353
-- 
2.50.1 (Apple Git-155)

