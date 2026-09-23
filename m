Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E8480DE9;
	Wed, 23 Sep 2026 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181681; cv=none; b=kV08E2SrDEWZm3exdJ9fQljLTmougDZjOKLA44I+B6JZ7wl/ZBl3spNIQsysq8IUMYiv8Knm3OSfrHuqYzlepkn29kRoAWo0lJvxgLqiMbkUjWnA06OKbebbQw1bHt1PkWW5KqkU955ocTM5d4fJmD837dMlf123Ii7RvTFawJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181681; c=relaxed/simple;
	bh=WHgnuK9rgeZzY8yzqoq6i4/0s52v/3eHSevKXdJ9koo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZNXLeZMx/clDMvfCG5lE9u2mnJnDqslCWkcq62BaJn7OXbvEbM4U1NxfqyCJ9wX3zTF88TMjynjTfXImLQux44I67We2n5CDKBvVTvQIYEr46DhlnMPFq4utP1rrD3IJ3auN9S3lZFq9W13eqe4PSSvKDlvyXx4sdsnzFAGMevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrfeKaez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrfeKaez"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB9D4C2BCB8;
	Wed, 23 Sep 2026 16:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790181679;
	bh=WHgnuK9rgeZzY8yzqoq6i4/0s52v/3eHSevKXdJ9koo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BrfeKaezsNtcbAGDWSi7RLms599ua23Xf4LKlOxGKXBGej9nLEV53ByxIrXyQzRKV
	 7odewBFgoVZYqqTxCBjEZ1xL9VxDf26w1keFu9LBVV+DuFSomdgy5/2GequKKOLRl/
	 KAHigsz4XPzl0DEksUxCwhB6I+L5wQtuCreBbYixFfocN23EzRZS2T/ObadrVJqGsT
	 J2EEmmmfHIvgkZxIc3EQRv1iD5axcvKIFoMtBPOqc4Wm5YvWrKe/+7+62yjmPaxxXN
	 r58RxxzJnQeCevcn8cP4+z53w/sQl777+aBOrPsISKYvQrSFVZRaNj7XgsPHxNEYPX
	 hOj9pi/ERXThw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D87C98302;
	Wed, 23 Sep 2026 16:41:19 +0000 (UTC)
From: Carlos Casadiego via B4 Relay <devnull+cdcp206.gmail.com@kernel.org>
Date: Wed, 23 Sep 2026 11:41:09 -0500
Subject: [PATCH] iio: accel: bmc150: check reset write error
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-iio-bmc150-check-reset-error-v1-1-b8c1ebc4c947@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAwAwK+Qnm1SFiSuXzEe2FKlGlnTojEh/
 J1Vj3OZBVxMxeFYLWDyVtc8FdS7Cnjsp6ugDsUQKHQUQ4OqGdOD6z0hj8J3NHGZUcyyYXOIiWK
 XqB9aKMXT5KKfX386/+2vdBOevyes6wbj/wpQgAAAAA==
X-Change-ID: 20260923-iio-bmc150-check-reset-error-389b096b0ad4
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Olof Johansson <olof@lixom.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Carlos Casadiego <cdcp206@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790181679; l=1470;
 i=cdcp206@gmail.com; s=20260921; h=from:subject:message-id;
 bh=/m+IAGs3XggeHKu/8l8GGOqvK7/NA+SldvDa51UHcTk=;
 b=PV+jE0pGryQUCC8m92s6Apv9hpHrmcfYBH0ZPTF51ofV9egs8H2Kp63iaB7Zh4H6RfXb6VZXJ
 Wz7oJk1a85GCNR9yqUP1X5WpTpE5s6cHPB8pILCuzt8IPRdHAbHxfnq
X-Developer-Key: i=cdcp206@gmail.com; a=ed25519;
 pk=Vr3c2AUi1oYbgVkQtRSsWin33frZn0vGGq5g04VWmH8=
X-Endpoint-Received: by B4 Relay for cdcp206@gmail.com/20260921 with
 auth_id=1041
X-Original-From: Carlos Casadiego <cdcp206@gmail.com>
Reply-To: cdcp206@gmail.com

From: Carlos Casadiego <cdcp206@gmail.com>

The software reset is required to bring the device into a known
state before reading the chip ID.

Check the return value of regmap_write() and abort initialization if
the reset command cannot be written.

Fixes: 1c500840934a ("iio: accel: bmc150: reset chip at init time")

Signed-off-by: Carlos Casadiego <cdcp206@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 46bb36d9366e..43a39e1ccce5 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1561,8 +1561,12 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 	 * Reset chip to get it in a known good state. A delay of 1.8ms after
 	 * reset is required according to the data sheets of supported chips.
 	 */
-	regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
-		     BMC150_ACCEL_RESET_VAL);
+	ret = regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
+			   BMC150_ACCEL_RESET_VAL);
+	if (ret < 0) {
+		dev_err(dev, "Error writing reset register\n");
+		return ret;
+	}
 	usleep_range(1800, 2500);
 
 	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID, &val);

---
base-commit: d8c0f48f0b1583308a98401c0c7b1a65d1d43a6c
change-id: 20260923-iio-bmc150-check-reset-error-389b096b0ad4

Best regards,
--  
Carlos Casadiego <cdcp206@gmail.com>


