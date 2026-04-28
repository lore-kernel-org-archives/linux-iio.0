Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF50D393DF3
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 02:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344227; cv=none; b=XMp4TuBABvFUpwAcrApw1GRqAoreYQquTPbCk5aTu0swUrrv2HdeP+pwt1rbgJf3Fl/v5SQiee1Egqyfw6Wr2WHqgsftcirx0eOnyDcnDXfCFNn02V8KvWQnc5vLVDZQbcAwXyq7/xfjMnfv8oZRu4Gcav12WuA9MNWsfsR9hIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344227; c=relaxed/simple;
	bh=TaVFYZLlssNFU084D6ysgvWO8YI3C+aLLGlnjajoOlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPfBib9jIxSDN/ZKs/ymA77civnjYW2rNahm0PM5ttUbKLjzLwXfkRJcyEHFk7bvwnvd9g2HhzvSC+6fnJ60CD2PSMODsM44xWSgT5tdIFC3swCAIf/qb4PBHukimN7RR4+ibqtUoOODScdvMDQ2qr6J8vfklG4ZrNpktDe3A8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7dl7rn5; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7dl7rn5"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4645dde00a7so8380421b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 19:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777344225; x=1777949025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gPkdpcG/AXzV2r8EJiMuqB5F6EPNovyteOK2fWIr2E=;
        b=I7dl7rn5IulQ8PgqkaXUTQIIQM9+M0C/AZ5WRALn8xw+4SXmhk94U3CXFyg07WMPbr
         e3JNppGBrzVdaulq/Y3bw2CaEI6t9IlkhShXz2br2iI8QsEXSMzpOmVwfIo/VaLHU5SE
         LTgJWCoMNiL7CsKmf41WYW3kTcgb71gEt7PR4DieKT2wtoaGfRh7abBDQ3VQFBePp8eJ
         XWT6tEC5R40ZAwl4WQsXyoIRwrOF7BxsovPWNky7Ll/O7UOx/GbLr8gomGjrcZYVhGxw
         /PUvWpm2cV6PSQ4S318Y+z1/8FNwT1fJzGSVVqJzMefim5UpM5jgBxVqIYANLT9V8Zj0
         FMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777344225; x=1777949025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8gPkdpcG/AXzV2r8EJiMuqB5F6EPNovyteOK2fWIr2E=;
        b=CfN3P9whxtJM/Kp3drznoXvC4osvAaezy8b63ay/wzfHAAyuaLPtzC1fKQf6n3gfgI
         7he41QL8BWKHvQDfu8crX389Os4b0duIGk3tWKd1fsY94eFDiDJuHta6DQjRzkS5fN2S
         ftpEOHdslg+5+IiN+VESCfcy6gSMjHFlFimqP+LDO8RhzRyOTy0280X/rE1Hi6BfUv+a
         rbnVOQ4v1PdyNzxYtOAMyb3+76ayL9+FlCYQpZFjp34M9T5rtkbl9vQllGWjcwG+jX+X
         nh8qwS62aNhDTXc1jj2mU6mMAfSqTGDCdlYPwHVCa5BR2nOzQV8bkfTZSCPHnlDRBUBN
         7HJw==
X-Forwarded-Encrypted: i=1; AFNElJ/3Qn09q9kYozmuFY93Wwvv0yytcecRAHy5A7A/gagc+BfePiDcLQYjbLFv3JgdSnKMbJ9lWV5ad1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYvfc+KGDcFtk4f+EHblH5nMUQOEwsyYM//dm3rrw2d1G7yB5
	JEMjR4RwVD0yt/3kgSu+ZYz2b8/BZbjqoZUVWvGLIgROoevlitLJtbdO
X-Gm-Gg: AeBDiev9DlSQlLvgdR1aXGkTICFpu/OCwRfeAYcltbhqnwoLNs0uC7pZuCjnhTkoi30
	rQ4BbC73GQPHuPyBknfTCTOVRY73AnjjWiBrDUNBJoCnagCRxlzzGAxJ6tJDMBJTqZw2qyhZew2
	FtH6pVA+cs1ti1ih4UnaibtmUuMFuxpJoN3NfrAEuyXzhGLLrp+2qiYEC8mGtDx7rG7z+smgWFx
	7D4gpUf7HGxUj6xbjtYpbDp5Cg3twv/u1d3L87D1FJHySRTQn/suvnW1NtRilhrfgoD64F+2Ieh
	IBwLHJ+FCqd7H5CXz6jhV5qd1/rmaj04rKevF1nORv9vELQH7JvjTRnyZoBYTQJtg4K41UE22I7
	bwnxQ5YyKuBokAimOOw1g2XOI2l4mNTlpJvJgtCIHeYBb93vvyuDiKdKUQhx3+URzCBOjDVh7+D
	bvL8SExOTukhwyKxuLZLuLfnGbOVqL0FjG0dFXGRePVQn7H+Ue0sNOJ4QUPMlsGieoMtaV
X-Received: by 2002:a05:6870:568f:b0:42f:f390:d9 with SMTP id 586e51a60fabf-433f175a3a3mr718084fac.15.1777344224752;
        Mon, 27 Apr 2026 19:43:44 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-433efb816e4sm958392fac.1.2026.04.27.19.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 19:43:44 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: songqiang1304521@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iio: magnetometer: rm3100: Use guard(mutex)() in rm3100_set_samp_freq()
Date: Mon, 27 Apr 2026 21:43:38 -0500
Message-ID: <20260428024339.45109-4-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428024339.45109-1-m32285159@gmail.com>
References: <20260428024339.45109-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock() and mutex_unlock() calls in rm3100_set_samp_freq
with the more modern guard(mutex)(). This will help modernize the
driver and bring it up-to-date with modern available macros/functions.

While at it, remove unlock_return goto and use direct returns instead.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/magnetometer/rm3100-core.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 76824dcb1b73..a2c3448e296c 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -334,56 +334,49 @@ static int rm3100_set_samp_freq(struct iio_dev *indio_dev, int val, int val2)
 	int ret;
 	int i;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	/* All cycle count registers use the same value. */
 	ret = regmap_read(regmap, RM3100_REG_CC_X, &cycle_count);
 	if (ret < 0)
-		goto unlock_return;
+		return ret;
 
 	for (i = 0; i < RM3100_SAMP_NUM; i++) {
 		if (val == rm3100_samp_rates[i][0] &&
 		    val2 == rm3100_samp_rates[i][1])
 			break;
 	}
-	if (i == RM3100_SAMP_NUM) {
-		ret = -EINVAL;
-		goto unlock_return;
-	}
+	if (i == RM3100_SAMP_NUM)
+		return -EINVAL;
 
 	ret = regmap_write(regmap, RM3100_REG_TMRC, i + RM3100_TMRC_OFFSET);
 	if (ret < 0)
-		goto unlock_return;
+		return ret;
 
 	/* Checking if cycle count registers need changing. */
 	if (val == 600 && cycle_count == 200) {
 		ret = rm3100_set_cycle_count(data, 100);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 	} else if (val != 600 && cycle_count == 100) {
 		ret = rm3100_set_cycle_count(data, 200);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 	}
 
 	if (iio_buffer_enabled(indio_dev)) {
 		/* Writing TMRC registers requires CMM reset. */
 		ret = regmap_write(regmap, RM3100_REG_CMM, 0);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 		ret = regmap_write(data->regmap, RM3100_REG_CMM,
 			(*indio_dev->active_scan_mask & 0x7) <<
 			RM3100_CMM_AXIS_SHIFT | RM3100_CMM_START);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 	}
-	mutex_unlock(&data->lock);
 
 	data->conversion_time = rm3100_samp_rates[i][2] * 2;
 	return 0;
-
-unlock_return:
-	mutex_unlock(&data->lock);
-	return ret;
 }
 
 static int rm3100_read_raw(struct iio_dev *indio_dev,
-- 
2.53.0

