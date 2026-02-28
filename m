Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FEB175A6A
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772309766; cv=none; b=XH5nyQsuWlaCuYsfHKEy23ABGAWa5oFunb8fm4Phbf5Ip1WM2unCx//e0zXl2e+qH4Xh1/8fvaF0DePj8wmqaSTGPKQc+j9JQ4i90OLzyCtqujBcFP4cc+Ne0BmZxx0+LNPGZjD9NUp/JHGzd6eUAt06zF27A+91f0TatSdX+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772309766; c=relaxed/simple;
	bh=88AvoyJ6FUzTtHbeoNdIaDkG4TBWEdRB6cUTHhILOuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fYqrstt/eQjCs2Z4Ue0jHpA+9IA/nrA6rPlWOSnSkhZt0FWHu/Ly/qc119Huy+wfR+sVv6AZIHyzFldqXH7r4oTd/XRbtZe1n3Zmsqm7Qxh1z4v3QdVb/3hiJeyHtaCo42RGS88VOAkyXbaRC2ilND5uG5R9bj4XUZqah27pls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ic/cKFbx; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ic/cKFbx"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4b9c839b1so1613150a34.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 12:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772309764; x=1772914564; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppLvags4HZOEZEO5eBxyHJk/TaUoHJpEFyovu7IX1b4=;
        b=Ic/cKFbxAXP1x0RC6WH9SlbVpYJ1aDnlhV6BMSXBKHbRP58qcm05EGPGSBBRsfyc+l
         3DJXR19ZSj52KfJBhK64eupaVkFi7BZEe+AihuDXij/Tew6LE7F6B/Wn8rcu3hxprykr
         vY63JTr88csmmXJVX6U1Q9dUFFnvxPmlaVQ2vXhPmhxHl52CwVY9IO4luhhX3OuVhQHU
         /4uflds65HQ/ZNnpCa0ERTG7GRkzcXw1SnhQH93YU8Ez1g8N6TJdgWYgc1O627+8mzkw
         1XSOYP0B3/sFWODaIH08WYP2mnZ1AKvEMOawMxjdiRuIeiXVK82EdXYO/w4JXD+IEmmG
         6/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772309764; x=1772914564;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppLvags4HZOEZEO5eBxyHJk/TaUoHJpEFyovu7IX1b4=;
        b=NV3k9HXSFAIRsSBi9CTgpoecCpg+SX3DZsfd4Z5RG32wKJB1ewuGVnuT4pznPpVURC
         Gch7t0XVost3nfG23hTIGEUPZ1gF827KnpoWiV3CtAVxovrSlN6Ig7Yedkc77CYUeXpK
         4g1O/DhX4KZVt/ml77pUo6jsX1uWZkZeA+6G/uCbhcvD5FgnO2vm1Xlhgw7zDbkTbWW+
         yDsV3r6JiIPKdRC6SpX2foJPXLa/yGXEW4SbXwQmpFl17zwoG4Zb91WWGV00xg45GTJt
         N0T74KYWe89C7jD5cu+sxh7i1FeUt/hNhQbqQF/GQvA8550Ng1H6eU3ehk/OUeWv7Ybz
         gYHg==
X-Gm-Message-State: AOJu0YyHeMTqr+ZhbrFFGxEVssgRAtIAGqTfM+J3lVT5PXCmTDAqL983
	jbV/dfbU0ZLNyPEijk/JA2zLsR3BccfCnGVegj2Mv6M7HYb4sFKg2uiwSfK47Us/JKw=
X-Gm-Gg: ATEYQzzFboKgmjx7bh86z9oMcvozCv4DjsygTthhi9MORsoRPKSo4WNJdQytilf4UXB
	cN49e3snNu7Kyfjbc3iADTc40awsYBJrLG9H01B8bzDz99r/YwzV2hZ/c8sBfObwrtoNu4UDA9/
	tCJ+axzN6wbqS1nzuxFiZcgMOhSeQeiUxw72BsOP5LALhdOiJP23tH2j6hNjyy5tfY2OcSoiwj9
	M5bArfcS05AB+nvVgQtVfcFh1qWzfTx45WJN1g1nycBrpDY02RTNCfiJPTUdP3EcaWZSKITl2/r
	kyWVVDdeWDPwizHaNEDHVV6a7J/g4O9dTABXQUmo38Ou4otTyAJnQateKhTWQgvlTCrrMYpdrsU
	SL1rdYsiiXSNVeU2fbJ21all2wR9hj5B5hcazaUUd8pbBBuo4l1AsyrdovC2iyn58JbgA9dNu5H
	WUmqL+Wa9UepoutvOKc7n/6werCnhQc4EHda7BcTo=
X-Received: by 2002:a05:6830:6999:b0:7c7:62bd:7fac with SMTP id 46e09a7af769-7d591b25a88mr5242031a34.9.1772309763787;
        Sat, 28 Feb 2026 12:16:03 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1031:c44e:9f1f:17c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586626abfsm7000054a34.14.2026.02.28.12.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 12:16:03 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Feb 2026 14:15:51 -0600
Subject: [PATCH v2] iio: imu: bno055: add explicit scan buf layout
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-iio-imu-bno055-repeated-element-v2-1-888676158804@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43PQY7CMAwF0KtUWY9pEpF2pqu5x4hF0ppiqUkgC
 RUI9e6YggTLWVnfkv+TbyJjIsyiq24i4UyZYuCgvyrRH2wYEWjgLLTUjdRqC0QRyJ/BhSiNgYR
 HtAUHwAk9hgKqV8ZotO3WoeCWY8I9XVbhb/fMCU9nhspz+XaY/VT47FUPdqIxrPWmNU73Uv6gN
 t2sH4KzGaGP3lPpKtZyndBHbq+5peZZKIziYR8ol5iu67OzWvF//zUrUOBM6+Q37gfTNL/OXid
 yCTdsi92yLHcnyroDTQEAAA==
X-Change-ID: 20260214-iio-imu-bno055-repeated-element-1c1552ea74be
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=88AvoyJ6FUzTtHbeoNdIaDkG4TBWEdRB6cUTHhILOuk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpo0z8wKN5f9S5qZFHEdtqR/RSbkpMpQyaZYqow
 gjYGqYAIeCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaNM/AAKCRDCzCAB/wGP
 wFw7CACTkdFV/ZU2H1AUPViQ5xuUT1IOh66Qn9IU0k3KoallF39SLFWny11WsAleQ5Y1C0Va4Dt
 nkaZu3JYUh7IFHf0HdPuhzTmjalnfNDOySyGt5spRnvF1z1NwzszRwu/8B7WuPp9v5ihq4INARW
 pWWTO7wplWJP+iqIcIivWx9eghgcrg/m6bhs9pGBk34JVBfOQlfezmbyn18MC9kHcAf4zMxbgIR
 81rOK2EKEgjg4Jcyzs/LpOBNev0EFOQ85TuWSx8U6+3x/YFVhROgbAgxH6Lee+9eCn6RKYzSqKG
 V721bammdKIcwaVIMj9Bja7819CS+eQ5ddjiI9LbIsJF5T+W
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Move the scan buf.chans array into a union along with a struct that
gives the layout of the buffer with all channels enabled.

Although not technically required in this case, if there had been a
different number of items before the quaternion, there could have been
a subtle bug with the special alignment needed for the quaternion
channel data and the array would have been too small.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This depends on [1] that introduces the IIO_DECLARE_QUATERNION()
macro. I didn't include it in the same series because the other series
contains a fix and should be backported while this one ins't a fix.

[1]: https://lore.kernel.org/linux-iio/20260214-iio-fix-repeat-alignment-v1-1-47f01288c803@baylibre.com/
---
Changes in v2:
- Rename IIO_DECLARE_REPEATED_ELEMENT() to IIO_DECLARE_QUATERNION().
- Link to v1: https://lore.kernel.org/r/20260214-iio-imu-bno055-repeated-element-v1-1-b57b08efd566@baylibre.com
---
 drivers/iio/imu/bno055/bno055.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 303bc308f80a..d91558e100cc 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -211,7 +211,25 @@ struct bno055_priv {
 	struct gpio_desc *reset_gpio;
 	bool sw_reset;
 	struct {
-		__le16 chans[BNO055_SCAN_CH_COUNT];
+		union {
+			__le16 chans[BNO055_SCAN_CH_COUNT];
+			/*
+			 * Struct is to ensure proper size in case any padding
+			 * is needed. Technically not needed in this case, but
+			 * better to be explicit about the requirements.
+			 */
+			struct {
+				__le16 acc[3];
+				__le16 magn[3];
+				__le16 gyr[3];
+				__le16 yaw;
+				__le16 pitch;
+				__le16 roll;
+				IIO_DECLARE_QUATERNION(__le16, quaternion);
+				__le16 lia[3];
+				__le16 gravity[3];
+			};
+		};
 		aligned_s64 timestamp;
 	} buf;
 	struct dentry *debugfs;

---
base-commit: 0b9f2af96d9dc898af3aa58bd55bf62768229b92
change-id: 20260214-iio-imu-bno055-repeated-element-1c1552ea74be
prerequisite-change-id: 20260214-iio-fix-repeat-alignment-575b2c009e25:v2
prerequisite-patch-id: e155a526d57c5759a2fcfbfca7f544cb419addfd
prerequisite-patch-id: 6c69eaad0dd2ae69bd2745e7d387f739fc1a9ba0

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

