Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD93D308F0A
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524320; cv=none; b=sf3aR5qgWvLXQTLrP90wY0zbHdjnyVZIJAlccBdtYZ14hlSKO3v/KSGlU5ZxP+Rz8tyNt6JWescqfBqsiIz2UR2OzDwfeRE8PgCzX9ZGnCiXQTvZV+tw8FDcenqlPOdUj0oLSIgnUveUm1feCIUrlLeoLlJ6eSs6bstxhRlo0TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524320; c=relaxed/simple;
	bh=2BX7rWQrsEXRzxA/4MK8HptuXQGfO+O840znjERKL2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RSdOL7jH4vC6lbh0s54AhDs4OWBveJ4h9HHpwSIO6eRt5R18Dk4HODvlwTcjlRyNJqi765MhcRqw/czQZUf83fVlch0jQaOoXx2Pvnuo9tM6EX9VQk0RigPKsbi/Rm2OnDS4LWrzhtLIBfVHREJBCjknfwucF89oYAWDNFVL0L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eGWd5ssy; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eGWd5ssy"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d7412cfb9eso3179816a34.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 14:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773524317; x=1774129117; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i1d07rh0mOzNQzU0saBk3TkTXoE/Opl6M/NzAk80LlM=;
        b=eGWd5ssyQUqUxmRP0ZUr5mTHE016wiEA9sbnVQ0gK6qkC/G4l/tvxhoBZDDk2GHsL9
         iDrCQtJij//x2SXuE6UOjjYFoykPYAe7pV+cfmwFOrcBwWrcCgFGiIDccRBg5eP/S6ej
         sYHSgWMeEQfSmhFiSfnEwIbaWk2ET/NoTQOpCMSN5KukeH9Zedty9QxQBc9E9qifrXXJ
         O0m3HHk1hp6oPxPG0WiNtgzlObCMr2kzsEVcWFcoIvEVF5Un439IQVC4y1n2soy39pDJ
         J+kEwx7Bop1PnNj4SgV7tzR8wbzptAvjksi+2mPeS9XT6KThTtr1XswxPtwmfKjw4fFo
         39Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773524317; x=1774129117;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1d07rh0mOzNQzU0saBk3TkTXoE/Opl6M/NzAk80LlM=;
        b=bF7X2kFnAz2sym0JQFdENXPaubFL9cP1HKjRDwDscYF+tyduU75LITSJltKjKqgYEv
         bFy1oTxHMbnN/KbdOHRzcqFc9LAZuDcPybA3UHLJa58K4VcvoGkJ3RjUq7CnlkWpcOC1
         jk1Zdjo33SrcQyL9Gjjbr0gVrZLYkut9qwAT6Hkh21pc3iZ+iEG5wNvMoiXsr2l4Hkf2
         4fuARIThyRgdI7rzClNzRkX9YHyfewSMFrjk3yWu+SaX7hbpbq1jFqUy4QKitv1rmbC0
         CxsZh5pMeXFTFnqohGJJDamn9mELtOY/shzGZgInG09LxYP1g08eEJKQeQTewv9++/uN
         PaVQ==
X-Gm-Message-State: AOJu0YxDTP7mGmlSKMFQASm1K9rwmc7k3zAQvIgwxrR213oPSK7vZlVE
	khakvf9nVbolm74aI7tY5Khhnuan6F6o5yI0kuwATBibj731rXx24kusQpmlKiGqEFU=
X-Gm-Gg: ATEYQzxaT+eom4SsL1qRLcezDfOd3ToUSEHowdX+VlNMJKrfpASSjwZRm49ujUtCj7q
	Uy81RWwMKzVMbLtCIkGrIXH9VsJVQA1yahejGS1mbzy171InMFt3hOKpvZSsWb8SbUNvq/Q71P1
	05QtG7QRqLAKZQSRwpPBvyrmsn9kZopAW690vfyYNe/lXz0c2jdeWzns7Bt0GquzXst8ppLoPUP
	cl+CJ4PLfqQAHBK6fJ5lDXTvofh0Vn4nYlF2HW10sg496IUh/LD0a8gxYwrp/L/usm/aSOjfM16
	G4tysxTa6EVV3ZKSMeQpF+RJHf+uq1JeFmZzymC/izvlrSwxjB+3qEsBH5MAs6UOX9QM8KcMDgu
	kbL3EhMKQu/vdDvaJ19Bc/UAPh13lScyrUHrfT9cCT1HWcJzFB3nVaFnaEmNWWtg4WjTpuf6mn2
	7WNpDMqXqq37BrsGf/Qw8ZlMuFPKNG
X-Received: by 2002:a05:6830:82d3:b0:7d7:5dd8:765c with SMTP id 46e09a7af769-7d7825cf2a0mr5227603a34.24.1773524316763;
        Sat, 14 Mar 2026 14:38:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e69c79dsm10890932fac.15.2026.03.14.14.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 14:38:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Mar 2026 16:38:25 -0500
Subject: [PATCH v3] iio: imu: bno055: add explicit scan buf layout
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-iio-imu-bno055-repeated-element-v3-1-2baca42290de@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OTW7DIBAF4KtYrDs1UINRVr1H1QXYE2ekYNKBW
 I0i372UbKpu2uXj53vvLjIyYRaH7i4YN8qU1hpenjoxnfy6INBcs9BSW6nVAEQJKF4hrEkaA4w
 X9AVnwDNGXAuoSRmj0Y9DQFGVC+ORPlvD2/sjM35ca1F5HIrgM8KUYqRy6Orr3DPGVG/72tW3z
 1DSwriIb+BEuSS+tcWbasK/x20KFAQzBunwOBtrX4O/nSkwPtcBjd/0D1K7v0ldSeecHa0yzsn
 hF7nv+xecFRkTZQEAAA==
X-Change-ID: 20260214-iio-imu-bno055-repeated-element-1c1552ea74be
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=2BX7rWQrsEXRzxA/4MK8HptuXQGfO+O840znjERKL2I=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBptdVUwenwRUH8ug1iZBhIs3oNOETYsmV3uzWFl
 KG3BH+/SR2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabXVVAAKCRDCzCAB/wGP
 wGMvB/44i7bH2c2tDfJ6OOUMHR0GEePBym//pQOKaS1wLoYtXTC/xakXg5sIwTHpUsJxy94A3J7
 xMGAlec9FV6frhZdZogozM16Uew4p+bx2UNmeREHfLUpIcyunaAkRPOx5ViBc0ytzHXkXafAoQR
 fkZ4PDirsMqS0dmjjRpbfzAKLUBYv+hxv+9dN/gVqjiyjf2bknDB4vg+NyX2YvUzxwiLJgL0zCe
 xKh0SeyjpHuGAo2Q1w5rqqA7T7ntKc1WWKFBHSHgrxfYZQz0TAN7XgC21E52YaOC81ny2nm9pjE
 skE7Io8c96qQ+55XZ1ckCL0VKerXyQvlTiiGrLDsZ+1gQc4b
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
This depends on [1] that introduces the IIO_DECLARE_QUATERNION() macro
(which is currently in fixes-togreg).

[1]: https://lore.kernel.org/linux-iio/20260214-iio-fix-repeat-alignment-v1-1-47f01288c803@baylibre.com/
---
Changes in v3:
- Use IIO_DECLARE_BUFFER_WITH_TS()
- Move timestamp into new struct.
- Make comment more verbose.
- Link to v2: https://lore.kernel.org/r/20260228-iio-imu-bno055-repeated-element-v2-1-888676158804@baylibre.com

Changes in v2:
- Rename IIO_DECLARE_REPEATED_ELEMENT() to IIO_DECLARE_QUATERNION().
- Link to v1: https://lore.kernel.org/r/20260214-iio-imu-bno055-repeated-element-v1-1-b57b08efd566@baylibre.com
---
 drivers/iio/imu/bno055/bno055.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index c96fec2ebb3e..d0101607a9b3 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -210,9 +210,30 @@ struct bno055_priv {
 	u8 uid[BNO055_UID_LEN];
 	struct gpio_desc *reset_gpio;
 	bool sw_reset;
-	struct {
-		__le16 chans[BNO055_SCAN_CH_COUNT];
-		aligned_s64 timestamp;
+	union {
+		IIO_DECLARE_BUFFER_WITH_TS(__le16, chans, BNO055_SCAN_CH_COUNT);
+		/*
+		 * This struct is not used, but it is here to ensure proper size
+		 * and alignment of the scan buffer above (because of the extra
+		 * requirements of the quaternion field). Technically it is not
+		 * needed in this case, because other fields just happen to make
+		 * things correctly aligned already. But it is better to be
+		 * explicit about the requirements anyway. The actual contents
+		 * of the scan buffer will vary depending on which channels are
+		 * enabled.
+		 */
+		struct {
+			__le16 acc[3];
+			__le16 magn[3];
+			__le16 gyr[3];
+			__le16 yaw;
+			__le16 pitch;
+			__le16 roll;
+			IIO_DECLARE_QUATERNION(__le16, quaternion);
+			__le16 lia[3];
+			__le16 gravity[3];
+			aligned_s64 timestamp;
+		};
 	} buf;
 	struct dentry *debugfs;
 };

---
base-commit: 79a86a6cc3669416a21fef32d0767d39ba84b3aa
change-id: 20260214-iio-imu-bno055-repeated-element-1c1552ea74be

Best regards,
--  
David Lechner <dlechner@baylibre.com>

