Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533B41C305
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091481; cv=none; b=qJ7T2SQgY5sZKF3pwBbRWOJdhdjZvZTswOZnh4Q9E2G2Gtfg624DPYNwmGYiNuidEbGIdn3WxUwr17NgaXIpvr8pDGyuDI9gS15qCvx3GVGV9M6LzYS1VWxZ/H4PMNF5LiN2c0mltjoUiV2FQuQgf2wIgAOnFqdtQ2VKjF5ibo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091481; c=relaxed/simple;
	bh=1cEUccuIaYN5bQrCXhGfhVUn9cocPw1qLI2hboutuxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMs+FDRi2qXo0dWHS/iFw64iWwDQLZsliNt6BmnDU0GXKl/rrj8iqzDumfQdeEBKIZm87OmHLaOcRmX/Cyp8ROQ0crh0Qq0Jiap2gPjoQAPe5YsMQ8+z1j1e2zk86e0O4dBew2Ah4bPS87PMJdYutqrbeCZdWBZHOPHMx0qEgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDfwLcSI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDfwLcSI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ac04e13dso6815165e9.1
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778091478; x=1778696278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=alBQD4+zkyoo/zjzqI3KZ1CunxpU4aeh/ZN+l8FJZo0=;
        b=JDfwLcSILSlZ1TMvMDmIUMxaGA+SaxD4829uBAJd8a0+RguOHpvK9xV4nBRdVw/kW7
         62HRab8bdMbnL7OpbuCKt7WHyKaUq2KVRupAjp+07NwQC2eVuJA0ZFtCliAfCk8CtPHL
         3Qv5H4d5nLgw09yNVNuA7JsJJ7Q1lcjZNBahwzlYG1kwUbQqh+fS4LZa6Op/8IYlrGIO
         /7t+4rAy/HY+cNoUjLttFfmK/mCa4pOoAj/q8ZMFkM3B74lrNikavvkc9nXqaVUb724M
         dvoyLXykSxeAvuWkwf+xWckx0VrcVQSQpqVW/mmCDuMKIGDI4QORzvy0p5Qk3f1hRK1j
         brcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091478; x=1778696278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alBQD4+zkyoo/zjzqI3KZ1CunxpU4aeh/ZN+l8FJZo0=;
        b=he/kNnw7A1IunzQE2V5DWDhxliS9VOSUvUBjzafxgQJR6KR/nAc5BVv8HiLYRDJEls
         4hCWdza3vmWqMcSMOk/+nukHkeyBDBFyxGC+xYTerYKeViX5L4D2shLIUaNgpPWtV2d1
         ms0WaDlLWpFL5SudjnfutgSnrnDy63RgJW9PzvyItqLPLnfFgQwrwSQaaVL0YwNMB46w
         7YXc9m+vCtWtHeRN2/35Zu7L5Rt83l+InmpFbjHUhtXni+UM0i4aqVgkr3fnh3b5nOUZ
         HyUPEP12tOBjnHvPk03U01yFKK4cn2fzKJ1ycKxdOBDvT+r92PPDCOFWbFYolmNZQs+P
         7q5w==
X-Forwarded-Encrypted: i=1; AFNElJ9zuXZRM+jCkwFvbui+bo4UvX5GtEO7oF+q6JR9NHHkkXQtg3bExBt+1/oI0hwzRbSLx5aEdTqLcRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2Kl+Btque3Ujwui8hT9CQ6rb4WsEa+Zo+NBuaWr68BgjfIf/
	YhK57JzpY4vIILKFLu5QRqv2OXTvy6DplKbGxl2XyvyD6JLDTjpNNWqz
X-Gm-Gg: AeBDies7M+7xRM1twpWXLkMPzZtFUl/OvMU0e6YxXnqJqeEK1qlAGcJEnSQUyN8jg10
	fM0q0L5Z2BuE9UW68fslK8p77FvyFQvLjWBs4bGmKHqyT834MGRSGLMUjO8WpX0yn6yCro6JNC5
	zGQx2Zz7BS+n41UBOsKhsWhQKqDe/Al0tS1S7vsPuTW0boElNL18vNtP0G7Vf2fqTfhr6B4ThLu
	PMjmpbrcaZOHOAPiU51f0vaG5JId8yTdSiSnrCqbehk07d3tdi9bYBIG26G1I6fTuuspQb7J4aJ
	VqJiVGeUYYJb6wOo93V68NZqzXucLG7FlmyVGLyIax1uuc+5WntYWCf5kbbdqCBxEKb3pXkmCWn
	e+jdliUaICSymDi7YKpMuBfwJ7vbv1GzFM2QzocA9WvCfFBlSbFyLQFYTPFkj/WV9IZG3heQSjJ
	u/o9yQ8OO9c8XuT0U5OlEu/+Tq9zeh1Wik1hgNvZxTqZyz61lBarkB
X-Received: by 2002:a05:600c:4588:b0:48a:5302:8ed9 with SMTP id 5b1f17b1804b1-48e52f1574emr35108735e9.0.1778091477633;
        Wed, 06 May 2026 11:17:57 -0700 (PDT)
Received: from LAPTOP-9UC0RPH4.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530b213asm22201595e9.2.2026.05.06.11.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:17:57 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: tomasz.duszynski@octakon.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: [PATCH] iio: chemical: scd30: avoid potential NULL deref in scd30_i2c_command()
Date: Wed,  6 May 2026 23:15:33 +0500
Message-ID: <20260506181533.409-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scd30_i2c_command() takes an opaque "response" buffer plus its size.
At the start of the function the code already checks if response is
NULL (via the rsp local), but the response-decoding loop after the
i2c transfer always dereferences rsp without re-checking.

With the current callers in scd30_core.c this is harmless, since
write commands pass response=NULL together with size=0 (so the loop
body is never entered). However, the inconsistency is an accident
waiting to happen if a future caller passes response=NULL together
with size > 0 -- the loop would then write through a NULL pointer.

smatch flags this:

  drivers/iio/chemical/scd30_i2c.c:104 scd30_i2c_command() error: we
    previously assumed rsp could be null (see line 77)

Bail out early when rsp is NULL so the function is robust regardless
of the (cmd, size) combination chosen by the caller.

No functional change for the existing callers.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/chemical/scd30_i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
index 436df9c61..fb06bec75 100644
--- a/drivers/iio/chemical/scd30_i2c.c
+++ b/drivers/iio/chemical/scd30_i2c.c
@@ -93,6 +93,9 @@ static int scd30_i2c_command(struct scd30_state *state, enum scd30_cmd cmd, u16
 	if (ret)
 		return ret;
 
+	if (!rsp)
+		return 0;
+
 	/* validate received data and strip off crc bytes */
 	for (i = 0; i < size; i += 3) {
 		crc = crc8(scd30_i2c_crc8_tbl, buf + i, 2, CRC8_INIT_VALUE);
-- 
2.43.0

