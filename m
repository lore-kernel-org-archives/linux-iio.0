Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7CD45D5E7;
	Thu,  8 Oct 2026 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494882; cv=none; b=HwHTHM58MlPxp7pMGYQ7iA1ohTwDeVtsHcTTnyS6XClUCOsnVwf6uuvnLJbBx3VF0FlJFDcwtpCx6xhi1BwWZR6cF+5N3mh6Ulg4REuysFCiQnpZDGFYd8Snifyv2AM/9jpq3sWToeB0FFZuv1e60np7oGP87VF7+t70ADtfR/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494882; c=relaxed/simple;
	bh=TeR7Q+fqs/UcoTH+pEMoFwsQlixEwVVHjBq8FefJ8i4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CBMhVf2PAgLuStx5XnrZGinQL5ckROUMeXiNWLnk7/iHrc9P8xZ0H2D2I1R6woO0Jkv9Q2KyD430/N4s6lb76+eK+gOXqR5fM8eusVY4Vs3+suEWBAlOArJNf+mUreNZZ5ah2q7AzK40jgV19aUbek+E6sM9sbhHUmnGPfxV2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAU1bZMD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAU1bZMD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD327C2BCC7;
	Thu,  8 Oct 2026 21:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791494881;
	bh=TeR7Q+fqs/UcoTH+pEMoFwsQlixEwVVHjBq8FefJ8i4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=sAU1bZMDSb/MNRI+JwkoIjBscFAoLgRInepZf5t8PUStnOV4o6DLEzfq26tJPga0K
	 0fKoqXQne8TZjd9bc2JLwLTvVpO1SZfqqTTrYxljtqR/+LNteer0rruejNSkmHqMpy
	 Pt4rk+uYZbDJvD2kzjGD1a09dVHA8pH7sKoIeFjhRX5Z+spB/mkVpeDI04Ud5FknAN
	 E9hddErQ/2Q7xvSmbj+pgwk5uQ7143oKWKXZ78wH7fugk4u8f4Ta/k6SEn0lBZbBh9
	 ASWmJUGJsgDaIrzGyFJjSY3frcF85knUHQwi7QJUOr0yKoPvFOqWPd4q8o3aiGSBin
	 P+JwxCqaSzTdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85919CA6015;
	Thu,  8 Oct 2026 21:28:01 +0000 (UTC)
From: Fabio Forni via B4 Relay <devnull+development.redaril.me@kernel.org>
Date: Thu, 08 Oct 2026 23:27:59 +0200
Subject: [PATCH] iio: afe: iio-rescale: Add platform IDs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-iio_rescale_platform_ids-v1-1-019f1c144022@redaril.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBA0avIrBuIoRjbq5QShmSiA9bIjEghe
 HeDy7f4v4KSMCm8uwpCByuXtaF/dBBnXCcynJrBWTf01o6GuQQhjbhQ2Bbcc5Ff4KTGJoc+YXz
 5J0LLN6HM/3v9+Z7nBX4+cQZqAAAA
X-Change-ID: 20261008-iio_rescale_platform_ids-0d2a7dac974a
To: Peter Rosin <peda@lysator.liu.se>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Fabio Forni <development@redaril.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2514;
 i=development@redaril.me; h=from:subject:message-id;
 bh=lvuR+QebAMjMI31UmklRwBBfWEf2jwig4BQ8unLKdow=;
 b=kA0DAAoWgcJymq2hamcByyZiAGrICuChWTkRFreAg1lxyLYmsekEsNX+aIaBAxwp0zBFHYtBd
 4h1BAAWCgAdFiEE/0Iysos2NDLajxh9gcJymq2hamcFAmrICuAACgkQgcJymq2hamfjFQEAirpA
 ncsel/jCwPi3z1NCt4yT74lqYoQmcO1Z6l3mv9oBALiHrP0yg++SvBU4Rkdfvavd34K0penzEYU
 FhkxjwlAO
X-Developer-Key: i=development@redaril.me; a=openpgp;
 fpr=FF4232B28B363432DA8F187D81C2729AADA16A67
X-Endpoint-Received: by B4 Relay for development@redaril.me/default with
 auth_id=1033
X-Original-From: Fabio Forni <development@redaril.me>
Reply-To: development@redaril.me

From: Fabio Forni <development@redaril.me>

When a rescaler is probed starting from a `struct swnode`,
device_get_match_data() will always set rescale->cfg to NULL,
because device_get_match_data() is unimplemented for software nodes.

This commit makes the probe function fall back to platform IDs when
it couldn't fetch the rescaler configuration from the match table.

Signed-off-by: Fabio Forni <development@redaril.me>
---
 drivers/iio/afe/iio-rescale.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 3a6a09ffa526..fcdeeacedbe8 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -517,12 +517,28 @@ static const struct of_device_id rescale_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
 
+static const struct platform_device_id rescale_platform_ids[] = {
+	{ .name = "current-sense-amplifier",
+	  .driver_data = CURRENT_SENSE_AMPLIFIER, },
+	{ .name = "current-sense-shunt",
+	  .driver_data = CURRENT_SENSE_SHUNT, },
+	{ .name = "voltage-divider",
+	  .driver_data = VOLTAGE_DIVIDER, },
+	{ .name = "temperature-sense-rtd",
+	  .driver_data = TEMP_SENSE_RTD, },
+	{ .name = "temperature-transducer",
+	  .driver_data = TEMP_TRANSDUCER, },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, rescale_platform_ids);
+
 static int rescale_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct iio_dev *indio_dev;
 	struct iio_channel *source;
 	struct rescale *rescale;
+	const struct platform_device_id *id;
 	int sizeof_ext_info;
 	int sizeof_priv;
 	int i;
@@ -548,6 +564,15 @@ static int rescale_probe(struct platform_device *pdev)
 	rescale = iio_priv(indio_dev);
 
 	rescale->cfg = device_get_match_data(dev);
+	if (!rescale->cfg) {
+		id = platform_get_device_id(pdev);
+		if (!id)
+			return dev_err_probe(dev,
+					     -EINVAL,
+					     "missing or invalid device configuration");
+
+		rescale->cfg = &rescale_cfg[id->driver_data];
+	}
 	rescale->numerator = 1;
 	rescale->denominator = 1;
 	rescale->offset = 0;
@@ -602,6 +627,7 @@ static struct platform_driver rescale_driver = {
 		.name = "iio-rescale",
 		.of_match_table = rescale_match,
 	},
+	.id_table = rescale_platform_ids,
 };
 module_platform_driver(rescale_driver);
 

---
base-commit: 6c377d19d4a5116d9bec5203aa3c6c11523e7898
change-id: 20261008-iio_rescale_platform_ids-0d2a7dac974a

Best regards,
-- 
Fabio Forni <development@redaril.me>


