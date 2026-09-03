Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0531381EBB;
	Thu,  3 Sep 2026 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426462; cv=none; b=h6hwwfBA+DwVfFWpIw1pQCJyrapJsrCWCN/9ZjIgJ0z+IsR3l39piGYa3JlA+OwUepovX3bMGpFuCrTNcOzi0fJL8qQUtIzmaxrqNgE0/yb3fxaKCQq2PoJGWjgjAoxAzJgApgaAns+oFGsgmm8HexKIDA6XqohHOQof0sSdBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426462; c=relaxed/simple;
	bh=nlucgREeAENtyGU0oZvaQgvRuDzVTM8wKimiyUC/+go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hdmdRdkGS8zneHvsjbQpbqSREaDxqtWVDdpyQXhm2avSzCrwytYp8idA/3dx2UoGRicZwzoP9qtKq3G8svCd84Pf7mhXXHl4oOX/mHLtfe+UdbScgI8+znnN5YrZ0QE+S2vN5dujOsv8OsS0ay8Un1XIUkwIDu17ADUdwPeayqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jLPTCXb7; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jLPTCXb7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=h/
	FMXzjsulwfzyUOUHyVlvD8UYYAMuG1lgRIvrjLEgs=; b=jLPTCXb7ll5FNf/u7u
	akuTySHPcrK7ZpZ8BmbE7RAw8HpMprjcgRJqobzuTAVHHBDs6zoFIU3VVovRqcRd
	fntNW2yvxVVh38Gcz0MbhlD0uipQWNtV9IYgIzCutdM0hpHqW6KrGslaBY1u2ISY
	ZhRFMANWVjhEifExZvyMGaGY8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCH097JOJlqWQVtAQ--.56878S3;
	Thu, 03 Sep 2026 17:07:23 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: biju.das.jz@bp.renesas.com,
	wbg@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH v3 1/3] counter: rz-mtu3-cnt: check clk_prepare_enable() and pm_runtime_set_active()
Date: Thu,  3 Sep 2026 17:07:17 +0800
Message-Id: <20260903090719.3498955-2-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260903090719.3498955-1-dayou5941@163.com>
References: <20260903090719.3498955-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH097JOJlqWQVtAQ--.56878S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW7Ar17uF4UXrykWFyrXrb_yoW8JFyxpa
	yIqa1FyrW8XrW8KF4vyrW0qryYga13KFW3J34UKa4UZ3ZxAr18tw1kKFn2va1ktr9Yy3WY
	gw4UW3WDCF1jvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKg4DUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+gtB72qZOMsZpgAA3g

From: Li Youhong <liyouhong@kylinos.cn>

The driver ignored clk_prepare_enable() failures during probe and
runtime resume, and ignored pm_runtime_set_active() failures during
probe. Propagate the errors so probe does not continue with the clock
disabled or an inconsistent runtime PM state, and resume does not
report success falsely.

Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -817,9 +817,7 @@
 {
 	struct clk *const clk = dev_get_drvdata(dev);
 
-	clk_prepare_enable(clk);
-
-	return 0;
+	return clk_prepare_enable(clk);
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_cnt_pm_ops,
@@ -861,8 +859,14 @@
 
 	mutex_init(&priv->lock);
 	platform_set_drvdata(pdev, priv->clk);
-	clk_prepare_enable(priv->clk);
-	pm_runtime_set_active(&pdev->dev);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_set_active(&pdev->dev);
+	if (ret)
+		goto disable_clock;
+
 	pm_runtime_enable(&pdev->dev);
 	ret = devm_add_action_or_reset(&pdev->dev, rz_mtu3_cnt_pm_disable, dev);
 	if (ret < 0)

