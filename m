Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039442EEAA
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380414; cv=none; b=rJ64I+6vIu5H8+p0cLWTxe20bAdt4gHPnJchcP+ZZObc6YdEngcUP0PMvrtiNA0+2OedI4Q2gD+ncmbS2behRx5yfDDtWC9jeWBSC7MhZQuUapQK66PrhLwoRPOwcQcHkYHduf1KH8kOpjGf5Gy4E+CcJSUjhzpRRMIyFl85Ioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380414; c=relaxed/simple;
	bh=UT7NuKLuGgTuNr0/CKw4l6W01tIu5MsYrZD6lyp191Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWHTsDGNJRhwRFTOB4AHXwQrNPIwCi6Rds9cd5DgyQhuqmjP1h2heu9NvY3jseF9uQ5hkVbC8pHhe291QJeO7zKE9aJJS6c9uT3f1ODDAJPZ3JeoDxSzdl0KhFVXS/Gwa/pn3Xu+EQXTFowbohQ/G29Ejewo0DGEwdK/qc6r+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYxHQOEM; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYxHQOEM"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dea1272943so136412a34.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777380408; x=1777985208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTvUm+2cv5BhSMHJjRfViFpgjyg9nQ2nh0Gttr9wDyg=;
        b=BYxHQOEMEnD9f2zuoGGrUJ2POjCMir6Vnla4pMLI0fsXeN4EBKi8GF/aqZbBIa2hKD
         u1GrbNiXK5L8QQrjc7lMZzQf0873hsCusNBGWJnWOuazLt4Z4pfRLbj/JH6d0TMlb903
         LoS3F9RFcRyqeIG4bQJ1QXvHmtKDjm8/pz2J+Bcwpe9XPQUYMc72FHinLhtlElh2B+Oh
         OCv3wmSmIj637YC4FrUn8BPwS066HeM7bB92oSypgD9JqwHRA5iFbvWjEeWCQCDWy4ql
         oR2G4z+nE+MqmaNLAyx1kXPxqsOoAjEkpvkpae20JW/l2KUVRuJsK5R28afEGJqsRdzB
         k8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380408; x=1777985208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XTvUm+2cv5BhSMHJjRfViFpgjyg9nQ2nh0Gttr9wDyg=;
        b=ahIzEIkDqSBNZuhJCGPE71/LPfir48ODjKyOu/GsxO7S65X1j4ioiWTwBTOSnXGDx/
         WQknGVGghHbXxOe9OPsafsw9Wgmm5fxRGYXjuy9h9vWEcH0mtKP/9S9q8XOnmxE8PvQu
         7+imI6PVMTp+jub2kQcpwL0J8lXwmR8uF5tTMlZO7NORFC/ogaqRJP0GnQqgJb+amob9
         giiuqY3VS3DIue3t2eW8REWi76jbDdAj9pAl34QMHwtCxCsqBtIl3KU5P1oaAuZ6y+ue
         ooQzHIUobxKVzP6rI6FUQ2z0Y0fmHAjg7RXySDv5RfFsqnYH/sfY6FtUOdHLijxGwLdg
         o0zA==
X-Forwarded-Encrypted: i=1; AFNElJ+0m/aUg505mQoNKszeL37wJDzwZZGPQrColyKeiQVJxhlalqufvIaGiBJ8z7/+5N4B5Gvc4SLvQKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl5ADOu4eH8XVEkaYCmIKtM13/aR2SyXZDaUJCon4BCLAITUEi
	hZk3j8U3A3FHY4IKvA+J1oQoKRDfNK48cg6PkgHUnTLUqyxy2ZVMT4a4
X-Gm-Gg: AeBDietLCEQoy0Er/suD/jtnIEgcYEmlr5qnH7Q7IAMSPhiAflFR4ORyPhNbqyvD3zI
	qUtErmf6vXGAcEBgtJfC7UfOjPKNdfQeYL/i37RKU7oZxdaYWSp9Siywx75P8TZjBcRcJlmxx0t
	nFDn9U6Yc9dLJC4TUqUiG11ob+QXUdw72YQ8S4aIhUDhKDxzhiKYfc6zLN2k5km+V/wpWb/DJlH
	aiCm5d7O0vhodGSEGBiZc26E+RKgXb25+VIt+VKDTWAHwHneCNKQugx0QGzlSuPhEn9QpyBMEad
	NEC+yCICIi5eQ1Hgqdxe1JKDTAu2FLdZZYKoy0aYohz4cQLBymMGU4ASNbADcCFNdYHvhCIDIAx
	P6m+luzpHdz0cvbFlbi7Rih0kP9AP4BHIyFZ8WQiJ7OUY1cvZhl7PeVR+Xtk5blabzh9kJQSpQl
	+Y+OKmHXRTZm+ZcmfqEsRZ+LQu6NgHhEl+CpPSDWwM96+kr6SmP0e9HF7dZF2hO/Y3Sp+Y
X-Received: by 2002:a05:6830:378a:b0:7d7:ea9f:c0f9 with SMTP id 46e09a7af769-7de99bfbf76mr1602031a34.0.1777380408371;
        Tue, 28 Apr 2026 05:46:48 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7de986a5601sm1683041a34.19.2026.04.28.05.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:46:47 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: songqiang1304521@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] iio: magnetometer: rm3100: Use scoped_guard() in rm3100_get_samp_freq()
Date: Tue, 28 Apr 2026 07:46:42 -0500
Message-ID: <20260428124644.49707-3-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428124644.49707-1-m32285159@gmail.com>
References: <20260428124644.49707-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock() and mutex_unlock() calls in rm3100_get_samp_freq()
with the more modern scoped_guard(). This will help modernize the
driver and bring it up-to-date with modern available macros/functions.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 v2:
 - Move if statement into scoped_guard body per Andy.

 drivers/iio/magnetometer/rm3100-core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 426963935d60..9f25efb2d02d 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -280,11 +280,12 @@ static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
 	unsigned int tmp;
 	int ret;
 
-	mutex_lock(&data->lock);
-	ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
-	mutex_unlock(&data->lock);
-	if (ret < 0)
-		return ret;
+	scoped_guard(mutex, &data->lock) {
+		ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
+
+		if (ret < 0)
+			return ret;
+	}
 	*val = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
 	*val2 = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][1];
 
-- 
2.53.0

