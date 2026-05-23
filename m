Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3356E175A8B
	for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779561899; cv=none; b=fGZ6THInWk/p80SORMrtKnzS+3zzhQnccJHgTwyZ15cR9sI97/ocFwZWAKDz6S545nedgKkQ7mQhWzdrMD2OA6qYnCHNC13IFFE0g0z7ypbkH/wBECWd37qTkMCZJDjlYcpOFrDBuoEBIssB1aoebkq7ab8M7JlKOpDHqIOipkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779561899; c=relaxed/simple;
	bh=aZX97VakabAxsxLccILXtqkt7HHyEK+J2G5b3K8x48E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gRlns0kmM8pAfr4comIDWU86GXnuJo7bLB9LDaG9baXN4VntNS2N4KwbjO1q4A5b7InPihzmnwzbBv/5f0N2R4uhfVly0Tb+wQts7PfcHvMh1XPQh8vbUupXtCgymCnoWLrChx8leKZ2aUVVSI12BCaidDM09c/KAB8+QGy7tfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duoe1KNJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duoe1KNJ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48fde653997so7452345e9.2
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779561897; x=1780166697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S1c7FctDRupy5mSh8TGaJMMBl/TrHx/xxuC9OcBfoes=;
        b=duoe1KNJofrdaIS6kaxqT0X5E2VRUHlW2/G2xwCiF9lzEZEw0A4sCywjMZaechOlpj
         WRpcOX8IWUDdxhkVW3uBY0sIJQNYCIJHe1zgRFHkITVWGy3JUMUx8MwUgf0eP7fAGA9S
         olFl4iKYhCP6a03fpL4a1qcM8ejazRdY036wvWml/23D072wkkMTSr9KvA7hjhUjPoia
         +8petBPGfi91YBXHQtP6XVlpg0SvMnDJJ81yyu/TdUx5g8u0EkVf8ainjF1BJfKcGACd
         9Al1sbPsg0p1VUXBPTrjk6eIUGG3g6IS+GGEyvkY+13mLmHc2uqwiJHoYuLYKAsIWFr2
         SFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779561897; x=1780166697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1c7FctDRupy5mSh8TGaJMMBl/TrHx/xxuC9OcBfoes=;
        b=ILvZOya3+9ydjEtlrXxVJKB/gOJ4fIxB3hFPdHbhN5CC9cm54hifan1jMUmxvngsYL
         3VTUacxreX94n9/76D3i0cQmA4n6gl5Lkf+UzR1n84WF5tWD/y0TX8y5McsyHQ4psr0m
         NNQ5ObmCGbRyVI4KVTPFWL+6s3GL/6vnf4r0w0DR8D2ls7tlpxGuhD0ch+9tHm0ijHQJ
         o3owPocSTXyFehRuFq/vurvGrzrxTIir2P2KowRZI/PhpFY9KpvkR5p6YqL7J/Gn3M5/
         irxAGI5A0MOlnQ9GZaDv8XO6eS9fN7p+eKUjov4iVNH6DTEBPb2PbjJuFlyhz0K+z1Oq
         KezQ==
X-Forwarded-Encrypted: i=1; AFNElJ88SeOc58IEHy7Uz6Fj4McLpQoDvWNFewHiJvG41Xy3DRzlTOEpcIS1JVNIgVa4vhkmI8/kmAw5vpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynXG3jxSnwj9rD0Ui/BBXZuy2t+J+lXiKrIXfGwp1yKu9Y5FAN
	buDPmmtYRQFDDzs+nUTYzAkIiv2MIIHFb0Pozkm8YWRQRu8C/HQdkq7H
X-Gm-Gg: Acq92OH6yNYccVy7zw0OO7g+++Ba5Q7M2EWJpbxXleLxNz6fiSBDCz4ZKQsVYswXm37
	1uajrU32BxPlZd5NWXjkZkI7LAT3VbUjvXx/19rjc4cRRjyJ8yzsCUkI5HNGeaYevqSnWclNRS3
	qcCyjR0dtfFtQa94/jUe6MaQoY4BA03zdo4yHlLOm4ysCHAoqk0jmm9WAaTtKFeYYzrRRhPWT8T
	DeprjWEP3IBfxT7moUd0Hhegwo/V8ILWFM/XNc5jCtv8VNmuxsSG8xWqQhY3iUPjR6yzXSls+F9
	wp9gJP2ifaUYVFk6MgGRD2c4R6xe0092WIuYqJHY7Rc+Uw2hFGBqGYnIYJp1CTbV5lYvj7z8G1G
	lUDts9x04hNLOOiI93JES4wZV0GqsZ4oMjR5AWpyANR/zYuhRuZY9QlrDNRM4m1653QMnQkd3HF
	iAmWJgVzLSX4+tSsD4siOqmdQE0HJPeJX62cjvxJrKbHr8gXsQOckryxQ=
X-Received: by 2002:a05:600c:4fc9:b0:48e:6db5:76e6 with SMTP id 5b1f17b1804b1-490424884aamr49788885e9.2.1779561896396;
        Sat, 23 May 2026 11:44:56 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527dbf3sm120966255e9.6.2026.05.23.11.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 11:44:56 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: wbg@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] counter: ti-eqep: balance pm_runtime on devm_clk_get_enabled() failure
Date: Sat, 23 May 2026 23:44:48 +0500
Message-Id: <20260523184448.7609-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ti_eqep_probe() calls pm_runtime_enable() and pm_runtime_get_sync()
before devm_clk_get_enabled(). If the clk call fails, the function
returns directly via dev_err_probe(), leaving runtime PM enabled
and the usage counter incremented.

Route the clk error through the same err_pm cleanup as counter_add()
so the runtime PM state is unwound on every failure path.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/counter/ti-eqep.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index d21c157e5..6b79a50fd 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -548,17 +548,22 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 
 	clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
+	if (IS_ERR(clk)) {
+		err = PTR_ERR(clk);
+		dev_err_probe(dev, err, "failed to enable clock\n");
+		goto err_pm;
+	}
 
 	err = counter_add(counter);
-	if (err < 0) {
-		pm_runtime_put_sync(dev);
-		pm_runtime_disable(dev);
-		return err;
-	}
+	if (err < 0)
+		goto err_pm;
 
 	return 0;
+
+err_pm:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	return err;
 }
 
 static void ti_eqep_remove(struct platform_device *pdev)
-- 
2.43.0

