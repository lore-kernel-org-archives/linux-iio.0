Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAED3F39FA
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779721949; cv=none; b=effIoz4NQRAWLMlgWNC2XFTBeomzI3yG3F2QuL+iq6PkIk+9blXF5jdPRvE8TBUUM/CtyZwimMCPpxJk5+y9L8iE01qvWXxOl7bR6hCpzzCvqrHdqrW2jw990W6oOmQmdsyM4pbFE19UJZegWTzJ+eIcYofGxq1bNT1SzenO2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779721949; c=relaxed/simple;
	bh=pO4iPLthvwVVCs/LNnJQDxDexEOiWW2Bi3DdBaUpWsY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SEWRWKzoLLDmC9PWea5QqDsYqzjzgXXA6rIODM81mJv/VwJEZbIumoM0WVaM291UUC90EjtLnZCTGmxgmDDxKoj8VEQP/FaTcmW3oHgP/93SW5FtYUxHXpaflM/HeAAGrl0iLGr7oEJ/7C9syvFhVnWewFe75EpWSndcjHQykYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yms+GLCX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yms+GLCX"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a41a9a97d3so663611e87.1
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779721945; x=1780326745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YVQ6aFlL0VJIn4hbLuPi82/xQjX/foF5fGQImUXGhy4=;
        b=Yms+GLCX69p2vBPBIcgqdmARh0xC1DxvD4pZPYYfwwzlsXGwX4so3zHsRjhn3fS/b9
         Uqn6C7uzIMcvFhCpYd+h6r/d4Pltai8om3W6eLnGFWesjFRY6cbrG0q65pjudzxL0ZO2
         cPSgn+sbClS9d5NdyjCkQD6CMjQr/XzvTq34NB/0ex4P7ePsw77jmSH1S7igUtEn4wcQ
         kAl2R49gto+Yqg06sBm+0EE5H+LjBrMONt4TpcHKkj7V7N7pNbv4j3jf9IenBk4mzeYi
         8yfTil8nVSO2iUYZEppNdNvJgzOsorSDoxtnB+nUGe6IZN6cQcGDbXgXItG1CM5V61ws
         EDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779721945; x=1780326745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVQ6aFlL0VJIn4hbLuPi82/xQjX/foF5fGQImUXGhy4=;
        b=XOeo6j/DsplneA6WVDBfTUUgfJRD7Ti7WF5bCADTgcvVcWuxpOTO5f1YZWyXvjVwSw
         TzzOsdnKUwcvh3kdmSJIZPIKoOW1eWFobDYemucXedh9FKw3mSb+/b8uKtnHk3d4q93Q
         bQwsrfB01JUILuwzDAIdMJGqjFmSMi6+hi1ZKN/BQO3M+Aw2p9U3N/KoZtObW2lYSE79
         bNkDtQevVFwk4ZYMCoVjdRd5TfvsAMRtXhCF6H1O5GsGGbcC4+e6g+LMDH+qjGzmaoJu
         qeN7NnlY9TlHiuelnnMzbQv1Rzt4McFJXZeLpAIwtiLp8otdCXR5FlOJ4cQN1er78X80
         q/qw==
X-Forwarded-Encrypted: i=1; AFNElJ+JWA0ANN7hXtKGgy8ZlDGks7wF5wYZ/JN/j0T0Uq+Lu9N3JkDY4Ve6xHHd8qB0q8X7ht7bbyQ8Hy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylKpt1iQ55PbGIuhMGvyhrIXTaCYPm4Uwxx1HSLhmmdNaDT+yj
	hEVM+hFA7DNJ5qzVn8+6go2dU5CCIusVkVFLbnGrgQ4k+yWvAixkv0F7
X-Gm-Gg: Acq92OEjxYfSuOVpKWLqFgKd7aODq3+ABICCbrlW1fWy4lttTr/xgXix7IJI9/hsXhX
	PxOIel/EQMLvhMXcxIJaRPgobvTdrgt/eu1lROsoYP4cht3LK+HZ6y0zhyXd6o5P04H3x+Pnbhd
	Mp2N5OF/HBTOXNogNv2mAtWWF+AXF2LgvtjYFE3f1JDbh3G5qoLKd2ZRDKE7Ff8giHd08ApgJph
	Qem0D+xttUqHqE6BSLTKEsfehn2Uv9/exTGCtFCvjUrpJfO95LcXkhK3DpF3mR1pkCcubEDFbNf
	pcSa/TmAyOZTQ1PSj0ROeKEwjMHzQPO9L9JC/basKSwaN+MqJnjyUPZ174oIqArPWOhtdqZW6Y3
	WtyDwJ1KWjhRhKRl1ROhWgMV7S9ya5C/ZlYVhgS5TNpXLxzcwerCIBGAd5CbBGy+ZYrk+tB2n9p
	Xc/g2P8PYSpPvKg1+Vx9Tsiuv5WwL2mpoY9FtU+dCMbMgk
X-Received: by 2002:a05:6512:6091:b0:5a8:6f8c:24b1 with SMTP id 2adb3069b0e04-5aa3a34a49dmr843592e87.1.1779721944651;
        Mon, 25 May 2026 08:12:24 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32ceb5a2sm2734384e87.38.2026.05.25.08.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:12:24 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: wbg@kernel.org
Cc: o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] counter: interrupt-cnt: use devm_mutex_init()
Date: Mon, 25 May 2026 20:11:52 +0500
Message-Id: <20260525151152.7238-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

interrupt_cnt_probe() calls mutex_init() but neither this driver
nor the counter core issues a matching mutex_destroy() on unbind,
which leaks the lock debug state when CONFIG_DEBUG_MUTEXES is
enabled.

Switch to devm_mutex_init() so the mutex is torn down in the same
devm scope it was set up in.

Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Add Fixes tag and clarify the leak is only visible under
  CONFIG_DEBUG_MUTEXES (William, Joshua)
- Add Reviewed-by from Joshua

v1: https://lore.kernel.org/all/20260523184418.7586-1-sozdayvek@gmail.com/

 drivers/counter/interrupt-cnt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index e6100b5fb..cd475382a 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -233,7 +233,9 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	mutex_init(&priv->lock);
+	ret = devm_mutex_init(dev, &priv->lock);
+	if (ret)
+		return ret;
 
 	ret = devm_counter_add(dev, counter);
 	if (ret < 0)
-- 
2.43.0

