Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B1175A8B
	for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779561847; cv=none; b=aLkOZsyS4kyEgHSEpZqNji1cdXySwI11YZCjfHN6vmGiCEtL25Mx/JQ7zWtL/emV2jlKLad79NUmoE8+0fBR1EB89yGc31KPxL/67FtLRwW5csnxzeAD36NmvCxCfKRUzDWEFUrZrU5W6vFsPzQcA3cLys8QIon5cEv9/8pEVHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779561847; c=relaxed/simple;
	bh=7LsEZYNGgOe1Q4X1EE4ZnzsUXJ80dV6yeDICGSZbyj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mmpvGcb0aSqIz3PanxqQt5fLyzE/TbyN6Co8sOJnJm3LiyuoXisSXtGcs02jlsuFTfNs5CxnS8OFpq9pHuqbfnHWJH+78kOCZu+Tgb87eSgoWoQlEVuvd1L5rl208iJIoiQEYZHj6E2KScw68WddLBPxc59fIgr/FF1YLrOImCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O92a/u6m; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O92a/u6m"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891cd5927dso7748945e9.0
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779561844; x=1780166644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSuQa2nd5VG5JapfnomsVNZL6XHvS+LuM4kzoF93Kc0=;
        b=O92a/u6m8PbVmptEjsY+MdbrGdSro88ByXkDUhevRdsnvRY8WtbWfzJM7gGGz08c3A
         hK3HjECn2J/7LIXTAw1prC5hpo8piTdoMloJyd1KNnWryU4ruI9OHCZy5gDjq3nAjiln
         NS4lwLubXnPDf35jbJ39WIRtmdlJn83/peS40xwANF1IYElgkDyKjToPLODZSnwv8Tq4
         86PABcuvhHlMgkAJmVQ4lsiNVe+mcbRaLWbGP3uMbmf/XidRUpNgs/fNMLgQ/aYJkIVk
         cYA2ALf+/eM38yCH7/SfcIzoZmfvBVOBnjzmGqZpR6TfUWNJtTha/nl+CJHpO4sgoAG/
         VCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779561844; x=1780166644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSuQa2nd5VG5JapfnomsVNZL6XHvS+LuM4kzoF93Kc0=;
        b=FCZAIbhDE+6DzOGEC0yAVpxSWn5PtuIxy4fxkrW+yRRCpyA1TKjlqZrcPDUs9BPHWa
         0uvl41pxgDtQZJR3Hep2kOYNWV2jBiQDLcpGbPuReKgsHRn5f3DwUgiJ22JS6FRl9CEL
         BGtm65RwC4CZLQF/VzEj7KGe5bapb64d7yiPwLgzcS9QuPe+HBOxEAMoiUIkxkWsWpuU
         SWZmlqjTtj8APusimiwppR5qeAhquGTAieRKDQmRbe+HWTgbEYAVOfQANyCY1XQn/+3T
         +gS5Gz6u3g0femShpSAcXlWaVrryKgf+fFCI49bGPeP5pYx5Vq4LXicmVDKoV7irm7Nv
         BwNg==
X-Forwarded-Encrypted: i=1; AFNElJ/gN00liB9c5k4hi4unxu6NPRRq9MV05VCamHvT4kGDw5CKi+0yExt5pF2rylu/UJJZ1e41VrwFyU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCHXTT9HY+tQt+0tS97BPsWeiYiNW5MBxZAn3D8rezF23L6/B
	whlCYERsvIemPBlnSr/HNBIZznFCylpyG8rty/8xvQK8Z+1Sk8MKqlGc
X-Gm-Gg: Acq92OEoAEBmcf8BzEkJo71r6S1hXtmFrts2CeIRcls9HfBB3eroUzPiPlXMlnZJjtl
	agVd83DKG5hst2S0+pcum058KzAQ4c0UP16zGlXSKs7SNAKZ/WcfO7aqqfaUw7FxleZEUgHXeRf
	S6E/v7tP1gptK5KR/Va021lc2cOsuKci2skXz6mjyBdXU0NJNn5eXClrUJ3EWT5ifz2SmYW/pwY
	zFWJjK3CNK0OMH7GVZvpuX5I6yOVp04NYxKn1uiJBozyqnFxfs1LrYLIUy4fORyaKw+rt6SI9Oj
	JV8m26+DVhv6i2dr3zQX4sx/ad4zQMl9igUzPfOsgBSOVLOUyHWI0OYNYNOVOrT7Uah7c3nFN0X
	ndur7/5unWxjdBs9BFMa5epUQmETe+GXAF+CloWRspXad2slnMKyuY4AlaNZP45NyABJCT2+J5d
	cK7bm6XZtAe5SeNnXzXnrPg4m2gkgCxmpLTjc53AtZaalD
X-Received: by 2002:a05:600c:c4a3:b0:485:c456:5e4f with SMTP id 5b1f17b1804b1-490422529aemr61984845e9.0.1779561843764;
        Sat, 23 May 2026 11:44:03 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454dedd9sm115166885e9.6.2026.05.23.11.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 11:44:03 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: wbg@kernel.org
Cc: patrick.havelange@essensium.com,
	peng.fan@nxp.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] counter: ftm-quaddec: use devm_mutex_init()
Date: Sat, 23 May 2026 23:43:51 +0500
Message-Id: <20260523184351.7567-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ftm_quaddec_probe() calls mutex_init() but neither the cleanup
action nor a remove callback issues a matching mutex_destroy(),
so the lock debug state is leaked on driver unbind.

Switch to devm_mutex_init() so the mutex is torn down in the same
devm scope it was set up in.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/counter/ftm-quaddec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index c47741292..8455f16d6 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -292,7 +292,9 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 	counter->signals = ftm_quaddec_signals;
 	counter->num_signals = ARRAY_SIZE(ftm_quaddec_signals);
 
-	mutex_init(&ftm->ftm_quaddec_mutex);
+	ret = devm_mutex_init(&pdev->dev, &ftm->ftm_quaddec_mutex);
+	if (ret)
+		return ret;
 
 	ftm_quaddec_init(ftm);
 
-- 
2.43.0

