Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497D2D3EF2
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720497; cv=none; b=l8YKdQdhQqxHe/De+EdfeYg/yMpmJSP9rVwGPfHO7Doc7dEWyZzkXxTAAXSj5MvoZdxU6FI5tdhqC9vt0VxA8QactItaWfcPS9xyhCX/KM3HECsvfmJ8cmx7FWslX6LrSTuJa9S8Z5zjlcFjbpKf0AxsjvrMSgATKr6uq1/7idc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720497; c=relaxed/simple;
	bh=MTc1QEwh/xTD1zWNj97mO+9s/9gbkXSTbhQYw4RZcus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oGzk1aMg6tF1dF5i5grTlR0oQANyUvjvJahrddtN9gL6D2MXsFHoXN5B4CxytsKXdFcTnjSlXzZ43+MnknhYliK+TqtKqtkNvzpbsB2o4W2gILRJzr3TFAB3O5yQ7zoR3MgNDE0OsoTgqNpF/aSCREDGmkQs5I1uYOD5ZqMGaGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cD5bacM5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD5bacM5"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bab82d75fdso41444975ad.2
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 18:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778720495; x=1779325295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlC9GlamOv3YoRng/MxFIGV+3xi+5mYX5rfTEUzWfFo=;
        b=cD5bacM5tW7T7FKCFBkauPAdwAObB4nIXPXbaXnEnzP2WnBjdj+WYjl3BTrK7rGNRq
         nUbemdyT/Aprn+gnV+UfPZESRDOe2zs309N5uzmIMYWk4SvrKQAdIn7egEM+cYiF4E6E
         xs52CWdtrmGdzULDvcYtDZIR4qAysOQqJBgkpWTLhZ7QsrIu3HxmaJgno8UUeoWQuTvy
         yxdPPpy/SrV2MTmoeAeD29iH4zymwtw005drdjYnU8uWKzkKvLIn/QV3c6pd9zmaqG6M
         +Uol4w/yc9IPLRAMfH/iHurhFBDR4pqIGicti64D3I6hFeLS2rezmH0NRVFo+WqL/onA
         wjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778720495; x=1779325295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NlC9GlamOv3YoRng/MxFIGV+3xi+5mYX5rfTEUzWfFo=;
        b=kOHbfzZL4Hd8wqk8EVH7Fay3C5H6b/pZHzcadebIo+L4tobAHs7WxYocAgt2fwb/lQ
         vcmmELlITcfjQmFoHbMqs+AS5KW5aLk7LGWqPHKd7H6heJmONxycjqiQl9NwKXObFaY7
         pQZ0HjY9q/n3SsqY5d6xO1XUE5EC2+jrNggKQQ9++o4uz1NUixszqtaLAQF/IfkDbvrR
         TIh7tbMaHzvg7zz9bBEBDUDTIF8cTApK/M+jVRFouq3cfQ7TCAXpupd/zdk2QthyLKX+
         TJi+7Dz9W3EElcvLQSF4Eb3OJ+BVBxSxoUejqbma6+dBvZkAADGjDOMXdIJviGoRG5MS
         cvvg==
X-Forwarded-Encrypted: i=1; AFNElJ99KY0ARglBDhtJSIWUlqBKn5MoqGtm91STS/VHsXf07g6WdivuzpJWlDIR0V7uGGNtjWVwDzXea88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rlsKdfmzOcVjbfFKtPf/99kZJE27oR3Gw9dCuPKcZP6cryVQ
	u7JJH76hr3cpBZjJJfVvr2zIWpbK+D799D54MNQuA0b9ABQ8eZbEJcuD
X-Gm-Gg: Acq92OFL0uV548PofBHU6Cxb67mzpQVk+rkZz3GoKMSKjrbvKxHfY9NkA/K6b+zMVnZ
	h+Ihg+5mFOnODP/wf1iIouOVomt0HdfAPiAd4IXcFEkNzwcwWQLKo9LH1Z0fX/d7pvbehyrb52M
	WvCNvBvZkxmG3khOcZPm2GmrTIKXvvnCK410sbDV8cvh9+whs8BdSHvjRVwgBLlEygedRmggY7I
	7JhwibavUlPLw93O4Y8Jb2hpAPZO7zF+pxvS2WDxSuNmZ8axXRmfzfdcGhrihfTFuSeAKIuLI3B
	kq3w8G+vYM1i4aUzUWZoX/Gr/SybF3aSEfMMjGf0VPn+OCiJxd3xaTPrWfLYuDX9wT6fsQHKegH
	5HBBUzGhwuAYVmTF/yQXF/c+VWhEkM6NridvBVYlRGZ/I6PunmWmNwFnPD9t2SCiIGwkTpSbZj/
	Nb4eDjvtGrjaer7ADozJWx1AgksS5szIvawTlQ
X-Received: by 2002:a17:903:1aa6:b0:2bd:5ddd:17ab with SMTP id d9443c01a7336-2bd5ddd1884mr9244315ad.32.1778720494999;
        Wed, 13 May 2026 18:01:34 -0700 (PDT)
Received: from [127.0.1.1] ([203.99.159.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fbc05sm4645895ad.57.2026.05.13.18.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 18:01:34 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 14 May 2026 14:01:12 +1300
Subject: [PATCH v2 2/2] iio: light: veml6030: remove unnecessary read of IT
 index
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-veml6030-fixes-v2-2-abdd5837be50@gmail.com>
References: <20260514-veml6030-fixes-v2-0-abdd5837be50@gmail.com>
In-Reply-To: <20260514-veml6030-fixes-v2-0-abdd5837be50@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778720474; l=1020;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=MTc1QEwh/xTD1zWNj97mO+9s/9gbkXSTbhQYw4RZcus=;
 b=cIgSR38tOtTcNIE+Jq3s0rdZDzNSnVzCuek0LDdqvAs5JWE4OQpf+OajBwHN5S5dWMyQcpbfP
 TWJYH8Up7+AD/FSsvig96KJy8ZH36K8vASsbrR5F3Myv4wzYEHmbUqX
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

This is dead code as the IT index is not used by gts to set the new scale.
In its current form, the value is read but not used afterward. Remove
the dead code.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index da8c32cabfd6..2f9a25d59b71 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -521,13 +521,9 @@ static int veml6030_write_persistence(struct iio_dev *indio_dev,
 
 static int veml6030_set_scale(struct iio_dev *indio_dev, int val, int val2)
 {
-	int ret, gain_sel, it_idx, it_sel;
+	int ret, gain_sel, it_sel;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = regmap_field_read(data->rf.it, &it_idx);
-	if (ret)
-		return ret;
-
 	ret = iio_gts_find_gain_time_sel_for_scale(&data->gts, val, val2,
 						   &gain_sel, &it_sel);
 	if (ret)

-- 
2.43.0

