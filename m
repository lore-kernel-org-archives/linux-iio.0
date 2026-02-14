Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820C312834
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 22:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771108449; cv=none; b=O40KbQrod5CAD4bXBVt/ipfIOV8/CWTEwLrHcd578Cw0jtg93cCDH0uaFFPJ1rOZyQqDvImmg0KLOH5a7oIpPFbn8+TGPWTCL6omonUfQkFLo3UVRWEfZY6MWojPCzH980ei7O+GiTXMJZoecw7VkaIg9Qk3973vYwjVgVVGH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771108449; c=relaxed/simple;
	bh=WGScMliSOm+HBRQgFlMK7HiiBd5jpw6PLF0UpUN2oBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H8JKR+gL7dmQSGwVZuGxLldj62G0Yf1CIMDRsWTBVVYzaEaJvxMWwg5ehN6gsNIepEcxrS5TjVp2R/VagV5NjXcQqMXv8LQvsxYqpy/yrNHs3xTZoLqjpEpmMjsVUjWyz+Gr+WxzoiFsPN6HROxLd5YNLxnLFfY70SN+AZOynvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EZiIcItk; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EZiIcItk"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40f095f1036so789639fac.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 14:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771108445; x=1771713245; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6zVL87XHeJuhFhgTER+NBlHbKqABjNGMW5w6WI0sdpM=;
        b=EZiIcItkYPdw8TOnlxZsQrLsROIOFzZtrtx3vr4ip+Ztz2gD4tvjLmJj0Up5Niq4Id
         It6CELQ/t3N9kaG5uzIXlVhGAbMZoJMoSpXfMK5mTegon/fiCMYzVnvic5txF481Whnh
         EP0XFDfXODFZEQuBEIWFAdB4D5A/jWZrAhENMU1vg5OssVk5c75Oa5JXp7y5kfEtJxL4
         ifWnWIZlpAgjdYNF+mSx+q7AouS39Jqthsaumaw0gu+7MTk9g/snxg/ZUxvvaxhxCFtR
         eICmznleUYlx7+A2DV0eHMMSfuf/vYAUY/koBycCZYYVgLs3gYuyhIrsOoIE9xToAPrJ
         WhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771108445; x=1771713245;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zVL87XHeJuhFhgTER+NBlHbKqABjNGMW5w6WI0sdpM=;
        b=DTJ0OwL3qIcUf9kotrWradpyYTPhXhWEo2bcBD/S1ZliJ0bSjLvw24nJ1jIDrfxP99
         2g+imbyrCdgcFo69jQgkByy5WFcKmAtSltFq/JbJvHgb19LC4kTG8xnNuJF81R368scy
         +AvWLV9gQECAGfwMVVqCEYSULIhHH3/c+1PGpHPNSjyDBVFAVFRAY6WdHP6HuitHulcE
         eQpzvXdBdgaR+V28Y4GjiinicKrFHeusRdsh/RyN8eSuxHIcPimYyR3e9riGXDbDh235
         HqR3O5COVdC2vfjahTSuhq55b4o0iRekfl2Sf/vrc1uGXWv3+XArEGytOYIuaPtp1Qud
         RtuQ==
X-Gm-Message-State: AOJu0YwCvb1Hi5EIbpSwq8wM8iFN064GKlOrSAZtGkLqlyaJNYc/InZE
	gjQR9ubH25ZyxwHQVDs5Gb+wq7fQhrlIZjXg4WBTfWZD889z3+c4atvysg8ArGDeoKNjcQz9Q14
	oEYKQ
X-Gm-Gg: AZuq6aJknNqGWJHHfswnaBeWPrRixugisfiao7RJXtLKTWxxbTkZlr95J1HqFWURss7
	xgpNZwoTcfuGMSjFY9mmvBnFnecIqwMr0H/FFvzsHi/dtSXxBRpC6/XAjUpMEs5ZrJLRvFwPnaJ
	ZrjtPw8RD5UJyv/z3FPxu9iDLdsBqSiiG0Wc7kI6pcvRPMBntIfe+eCuc6OZmjDm3YKUfYfmJG8
	aayZ75/smV7vOqCqbCuFDsfxAoNKSmuqvJkgXO4E8moEALSnWna9Y2abr0acXE+tZC4hRJXUxef
	Q8WmY6C6syFOPuOEmOzCsNGvfFOg2UJPH1sb04r4d83aKXoEvuNVT6PMdL9A8TcAgEXSds+0jky
	VjrV0Sv0T28p/TO5r5aLgCoIgo0LwhS3qNTsmQ6mOGuE9nuOV/0rOzZzlBBvQFsLZMwm4UAw9KC
	O9ntYCn4QnbS6WV1xgIxKu4WYyvg==
X-Received: by 2002:a05:6820:4688:b0:663:5fa:c2b8 with SMTP id 006d021491bc7-6771ff7c098mr2638343eaf.16.1771108445455;
        Sat, 14 Feb 2026 14:34:05 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:109:393c:254e:962e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67475fbc91bsm7143293eaf.15.2026.02.14.14.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 14:34:04 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Feb 2026 16:33:54 -0600
Subject: [PATCH] iio: imu: bno055: fix BNO055_SCAN_CH_COUNT off by one
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-iio-imu-bno055-count-off-by-one-v1-1-42b2675edc6a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NwQ6CMAyA4VchPdtkDBmJr2I8dKPTHmjNJkZCe
 HcWj9/l/3eoXIQr3LodCn+limlDf+kgvUifjDI3g3c+ON9fUcRQlhWjmhtHTLbqBy1njBuaMg4
 xTOQSEeUArfIunOX3P9wfx3ECwHM74nEAAAA=
X-Change-ID: 20260214-iio-imu-bno055-count-off-by-one-3b67a0caaaf6
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=WGScMliSOm+HBRQgFlMK7HiiBd5jpw6PLF0UpUN2oBI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpkPhTHOb7lXqCg50YWINYtW9PNdMs7JAreit9i
 t2SmwkVIemJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZD4UwAKCRDCzCAB/wGP
 wAN5CACYVk7lKiAkOa47myjBFKIwbqICOwfRYSxLcJE7bHFK55AAan6tZGG03E0pnl8UgQ9HMBk
 SFHlwUDx2OqhNX5f3ZlylG++pc6IJmaDnuXG9wxPZ/x44l7La2MN/MDJesBj3l/hNTkA7MVxizz
 ahH7uRcM2I7aWJ0YBDwnfakPyws/LOHiRLAc4Bpd2chgX9SVgE465c4u/+vn9FE4OrdOAo2K8EI
 cEjSzWZkKs4Njz4W2kFaeq5Q+1ekdun3HcjyUVz5P8xqVqyz4mmSF9mreGXi2f96qsJhVhxYtNM
 s055udSG77lk/tgT2z/Uh+cKZNeGI++fLI+k3plrOXQqkqJJ
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix an off-by-one error in the BNO055_SCAN_CH_COUNT macro. The count
is derived by taking the difference of the last and first register
addresses, dividing by the size of each channel (2 bytes). It needs to
also add 1 to account for the fact that the count is inclusive of both
the first and last channels.

Thanks to the aligned_s64 timestamp field, there was already extra
padding in the buffer, so there were no runtime issues caused by this
bug.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
I didn't put a Fixes: tag since this there were no runtime bugs. Didn't
know if this was worth backporting or not.
---
 drivers/iio/imu/bno055/bno055.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 303bc308f80a..c96fec2ebb3e 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -64,7 +64,7 @@
 #define BNO055_GRAVITY_DATA_X_LSB_REG	0x2E
 #define BNO055_GRAVITY_DATA_Y_LSB_REG	0x30
 #define BNO055_GRAVITY_DATA_Z_LSB_REG	0x32
-#define BNO055_SCAN_CH_COUNT ((BNO055_GRAVITY_DATA_Z_LSB_REG - BNO055_ACC_DATA_X_LSB_REG) / 2)
+#define BNO055_SCAN_CH_COUNT ((BNO055_GRAVITY_DATA_Z_LSB_REG - BNO055_ACC_DATA_X_LSB_REG) / 2 + 1)
 #define BNO055_TEMP_REG			0x34
 #define BNO055_CALIB_STAT_REG		0x35
 #define BNO055_CALIB_STAT_MAGN_SHIFT 0

---
base-commit: 0713b26190addfa3a774b386c8658952ef9f7faf
change-id: 20260214-iio-imu-bno055-count-off-by-one-3b67a0caaaf6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

