Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DD0481FA9
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831669; cv=none; b=bNW5H0lywOAmvri9AAVLjRBvJUOYMshHUlkHY9R67Gm0mwFdnEhwtLBU9iJyyWtuamFCKXZccbG8VFX/PritdWbAOF+mO5JKRa+RRzy8lPVlCMzrJsXDbNPRDNT+ftqpbEMTkurWbQyZCMI3/MAtYUt1dlSy9bGXf3AxElxJhgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831669; c=relaxed/simple;
	bh=XeFYWHXImwbeauL7M9wBr1T//jmGoP+u75/X641mrBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYeIzV17LMMfd+3EID9Qt7nTjNTjms8nhwlgpbPUM8FeegO7wqI2bnnAnP1NjPcEQVqFXKFqsUixTeXuQQNgTjwEPCxHGCxu964j6VsQKqcc/Yd3yWVtjAmFUSWGZnocnULE7GP3i7KfLTgJjJk8GE95umbr84MLDPwU/ZnDqTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvK/4Cpk; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvK/4Cpk"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3598cab697eso3757724a91.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 13:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772831665; x=1773436465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=025oIKgek8EezuT+3u5KMy+cjhj8h3tC0QPbIDyeQpE=;
        b=YvK/4CpkO+RGLwv1h1/BcTdRWqSocIW37OgfH4YeZenm5TykQ03jlgeu6b4bIVzTLB
         plA/Mgpg3OVDEYViqvb6hFPmCGwemOsriH5CVpGx9rlSpGZechbptaTd65tXMIypAn5D
         XZjPRj/pbUVr+RkwcWbGSmnvgN/iNdf42z7vLJ4iwTYHVhxYzszqDUGw1Fc5vqjYxZFc
         deWczp4x1ru6SOax3oexgBsu2x+8udWHKzft44R7mm7/GJSgMPQ5C0Mm2r6XFvTfdgbj
         Z/LkEKQhZsHtcBfrJw5Ide57E48Q44EBO/5xdj3ScxwqY1hOWOnk5xLWYe5Bdl38drY+
         3Dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831665; x=1773436465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=025oIKgek8EezuT+3u5KMy+cjhj8h3tC0QPbIDyeQpE=;
        b=qOPqvS/Ct+mp+icHPMMKvH7wgFtGeme4tOc8F7hZ1CJH7UHMBtpkpGYMdwrCsE7OX+
         fbPgHkODdF/GrjMDzrTv/qifNmZqnk7BeSP/vXOb8G2UgB18o3B8HMV/9ainjQy4Hy1A
         P0j7PHAsbBu1pkjnDVBr+lacxLfzbtmMZuseH3wfyZ6UnS33XtEJDhbsbA9k3ZTItwDc
         23dQ3y+N+JyjoVNVrejfI56xsgkVRrnV5HV9+t9bvv6WTd93RptsE5LAWQGGzLZh6qO2
         ndueWC9MfAzAs8ybwF/8EqymgukGfvle/UVHrVpYSGw0ivtjpML/KzDVRvOvrwVC/G18
         vaxA==
X-Gm-Message-State: AOJu0Yy1/raSUxQYNv5rAJk2PGlRfuYmfmjZ5cQ4T02yzZApbyFgUQ94
	/w+/ntbBM4llwu+olKxIJcw3tBlwdM5jKHJcVJ7+PaN39+1VXndMxIcp
X-Gm-Gg: ATEYQzx43flcwx/qF/UZy0m/F0tZsusPZxRU56E92zbZPRgv+L6i+i1VVaxBXWH7cpf
	ME1XtiWKkYPY0VtXr8AVmGN6IyhueAWtwnwHeLhJICf6GGtc2D5Eqpp2GdkYH9pEXverHgTPh9H
	+ysrSppsF2uci/U35z5HROaDxRmCmZ7stWYBfMjYeftLJn7Y/gSUHRsuiucMBcIbL1bBDdpGj8P
	J8lCv+ASL1pnQTvRD/V//kdHnaau0FjZPFi0FzT+B+/QcpgVdQ/ub74H3dfYk+ODYoAnM8VnO0X
	s8h/zmoz6Tzr0KRod+PwvMRjdNsHTdXxCmt0B6ASJf7tG4vAojLvoIBAtRoZliLpW0+jmvPhM6e
	J04kgsqonMibj3mRPuuAy25+a1pnKYm0zuc3iyzSySu2pafQIylWOTyGd1GXrFv3InQrtSMGFYE
	3N1hu0+xu1oTkX8zSFgvUb7oXV4oy+G/rE/tjqNJaDI/CDDeWjkBMd1Cy6T5g+Ki9WpppdufRTH
	lrxehqCP2KEC/lU45vGFEH2
X-Received: by 2002:a17:90b:2ecb:b0:356:26c5:aaa9 with SMTP id 98e67ed59e1d1-359b1b8c921mr6803472a91.2.1772831665471;
        Fri, 06 Mar 2026 13:14:25 -0800 (PST)
Received: from fedora ([103.215.156.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e170c87sm2661331a12.18.2026.03.06.13.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:14:25 -0800 (PST)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	puranjay@kernel.org,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v2 1/3] iio: accel: adxl313: convert to guard(mutex)
Date: Sat,  7 Mar 2026 02:41:50 +0530
Message-ID: <20260306211152.65109-2-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
References: <d587dd07-ce23-49f1-9a38-ea741e4ef14c@baylibre.com>
 <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/iio/accel/adxl313_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 9f5d4d2cb325..94c6023af487 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
@@ -356,18 +357,16 @@ static int adxl313_read_axis(struct adxl313_data *data,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ret = regmap_bulk_read(data->regmap,
 			       ADXL313_REG_DATA_AXIS(chan->address),
 			       &data->transf_buf, sizeof(data->transf_buf));
 	if (ret)
-		goto unlock_ret;
+		return ret;
 
 	ret = le16_to_cpu(data->transf_buf);
 
-unlock_ret:
-	mutex_unlock(&data->lock);
 	return ret;
 }
 
-- 
2.53.0

