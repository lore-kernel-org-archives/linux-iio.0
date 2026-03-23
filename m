Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB38337B032
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302986; cv=none; b=AzffFhdX7CoMP3QPSK78ChwliJ/DrmKiy8GyB9HsGQFvIPby54LHUwJ5qIfFCamN23qDtW4htPzAF6LbiIbBv3mPnmjGzdf9wID/Cn8+XCRp3tEzMn2036wmS25vUoNN0o0pHrubFf/U0T5Yt6DDLQey7eirakGe58QO4XgaNbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302986; c=relaxed/simple;
	bh=jgyhte73+OqMNxeuEJTSwLMwfkm1INW0A5bkb+bZnPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dvtdHumYIWBQaFqh3HmDlTl2RYo2N+ep19XxjB8DToGEykw3jDXYnQhBO6iD1ueMjKcxUEG4fXAUJsD9qA+VENQgqmzIFD9r+yln5UrxYo2yA4NxxAWVsXh2UWU8a+5oW9juOjHlVPOFsneaCubZv/b4kDCDUYM3qyJNtOwl05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swxGeFa6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swxGeFa6"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-487035181a7so17454545e9.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774302983; x=1774907783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uKalQ1AQ7S7LwrFQCyrJc5lBf1msFKCNdw779RrkXK8=;
        b=swxGeFa6zJQdaz4pY4MRR/zdBtkwg4FVva0YpWT6dNYfSQ53fySeiFvzBvPcgUMvXj
         z0aqmjCYwgn3NEVAS8Z9mzrGv871wsbPyQfUTuqWE/1gikiqDznUnaxWjneWeGx+Dn4L
         uCukxl6M9kOTCvCkuzUWWu/FNbcDs8pxEYLd97Q76HRWhD/iXXhaz5qho3aeNbduKtdp
         WYTI10WE+y9+B12M3Kz2ReYSfoq3wOVYWsYAb/gcaKqRauDRjmNx0bW6opm4Na8k81ji
         PUsjm/zOKMbO3BJxsdRkg87Dc1TFIwp9kUw35ZWGXFS78hFTwCVRLx86P9aNYa5FpLOJ
         5slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774302983; x=1774907783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKalQ1AQ7S7LwrFQCyrJc5lBf1msFKCNdw779RrkXK8=;
        b=sNckKKj+LZS/AXEiaqQ9DBZreed5jdlxIivDoW+Dv4LSauVPsrEILMjXzr2mX7eat4
         EdkFoGLfBlxvIUXVS0E/M/Tu+oVCimCJQzWpasB3IGAQvar8or8A3PP524mEAWfl6reH
         ojJS8uw0mPJ98eOqHfuT2QjTW+b8hMUH1MTvqYn9jbFEYJWZfn30HPUDcQq+xQX5y4Jf
         8Xjp5m+jIgoTYhBPcQKHckIER4H3DxDT4NGNaWngLIjJi4MvJeJ+gykGBPuNHFIUQZ+C
         GqLKvux3Oyl7GRo6gr+IqEtfkaLes1wkNY5xeQ7jpM3LfCSATFIPlgsqrNIu+vWHsgaA
         Uv6g==
X-Forwarded-Encrypted: i=1; AJvYcCVFVYhhuNKsvuakl7g6ELaXc5tm9cjiWvsmZrLiYVpk8NOtjUlOe6T1oLzouM7MXrSPuBK3zDhEF8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQCwB44zTUlIlG10X6H8MCfGUmXspO0z5ePZkbPl+jit8E0U4
	gDTpn+AjrDFD6CWhQcHTgyy6ETknw0btaXZBCrH1FSe81z7QLj6eqtEL
X-Gm-Gg: ATEYQzzaGsO/OoEYtTcxvkbD4tieupK1tXYmJRZDPsxMUaWt3q2ZdEVK+Ajv5xdRiil
	1TgUOkr8MmoRITXYVo+s7eGUk0fJBtO7qn9iEW1EE7+tz5p541u/eCM8ft1NvesyfknRl6YkI44
	JHcX8KEHC7UsmCGDmcVjrZfdBAeP2U7olL1kQmW6TTDY9aCa22eTsulfivi38J9YPsrbE1wpNVt
	gl9cxt14ZItjFTzfNQdwDFGXq5raAqO9m345Q3rmTZG/rayI/Qt9OVVQbM20R6SsZUK7FppIy00
	scgtyo4LmzizPe8ouxfguiqwQRnHSv/sN1Zqa+7Ef+6h+mTZJXowrT38VCEZaw4oXniNuogPdcH
	0eKG/w5r34y+9lS6pyUSj43wJCaHHNSVwe+zrLP/6etMlWRkx9wfr7apf0sV1DwgmnubGanqBg9
	tbqJQIsDBMyIM16SDvHvpaSQfmsZdu29VOfQqEdxwqc/0nzs/nW1A=
X-Received: by 2002:a05:600c:3b07:b0:486:af22:4a2a with SMTP id 5b1f17b1804b1-486febbc445mr191504725e9.7.1774302983089;
        Mon, 23 Mar 2026 14:56:23 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c9b:a000:e561:a158:b78:a92e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711701804sm2323965e9.4.2026.03.23.14.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:56:22 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: bmc150-accel-core: use sysfs_emit() in show functions
Date: Mon, 23 Mar 2026 21:56:19 +0000
Message-Id: <20260323215619.6883-1-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() with sysfs_emit() in sysfs attribute show
callbacks. sysfs_emit() is the preferred API as it is aware of the
sysfs buffer page size limit.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 42ccf0316..2398eb7e1 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -851,7 +851,7 @@ static ssize_t bmc150_accel_get_fifo_watermark(struct device *dev,
 	wm = data->watermark;
 	mutex_unlock(&data->mutex);
 
-	return sprintf(buf, "%d\n", wm);
+	return sysfs_emit(buf, "%d\n", wm);
 }
 
 static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
@@ -866,7 +866,7 @@ static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
 	state = data->fifo_mode;
 	mutex_unlock(&data->mutex);
 
-	return sprintf(buf, "%d\n", state);
+	return sysfs_emit(buf, "%d\n", state);
 }
 
 static const struct iio_mount_matrix *
-- 
2.33.0

