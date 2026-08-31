Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A893A9D84;
	Mon, 31 Aug 2026 05:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155075; cv=none; b=OCHqLyumJNtkqbu4WDMLsxdEkkrov+0X9G5WP4PsIzXtKH3r/xzMhKPV8Wrxm6uK4Dlv8sI0DoER50jZIS0Amo3YcgT7Na4iROfKjH0OK3guwAqZryHXqLHlNkyEhHa1u4wEz2NbfC5r6surqF1QCOKtc4mU+mQ4D2g6f5EN3JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155075; c=relaxed/simple;
	bh=NoXGZ9s6+PRN86COgJiy154aS/VbRH7HRMmG8Jli/Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bBpxYjLqhajSbvRattMdMywjR/YOn1F6R+FIl2c2iW0e/XiIoudJ/U5cZFZXH8TYpKhr70tyVuKcMU1XwoJlKEtk54cyy+9iZQ+mCWPg963EJcFu9HK/3vJv8nT6FijuGi2z3G8KAtLNPwtPBYodAY/Z1x5FthHjka4Xg9ItiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GCQKtTKe; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GCQKtTKe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4b
	YZlQIVMwpKFQG/mLPp0EW7RyRv4dcvBtoRQu3hx0w=; b=GCQKtTKe2ZA51qESsq
	ugpUC9U+byTFRU+gF519XGCSqG1wMi5drSH3gr8VDPNIXQ2OA0L1enzfALv3I6sG
	LvtDzy218/A8m4bKTztRG1kD7AzMW+rB36+l6gwOL6n87l3Foq/uQaIzMmdhLglY
	/HdQA70BZdKLfX2/eKWpnsF+o=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3nxWrFJVqhT4sQA--.61087S3;
	Mon, 31 Aug 2026 13:44:14 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: biju.das.jz@bp.renesas.com,
	wbg@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH v2 1/3] counter: rz-mtu3-cnt: check clk_prepare_enable() and pm_runtime_set_active()
Date: Mon, 31 Aug 2026 13:44:05 +0800
Message-Id: <20260831054407.1695146-2-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260831054407.1695146-1-dayou5941@163.com>
References: <20260831054407.1695146-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3nxWrFJVqhT4sQA--.61087S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW7Ar17uF4UXrykWFyrXrb_yoW8WFWDpa
	18ta1FyrW8JrZ2gFW7ArWvvFyYqaySkFW3G34xKa4ku3WayF1vqa4kKF12va1kJr9YyF1a
	gw4UKFyUCFyjvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMuWJUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3g4w3mqVFK4LhwAA33

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
 drivers/counter/rz-mtu3-cnt.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 7bfb6979193c..3654e0fdab20 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -817,9 +817,7 @@ static int rz_mtu3_cnt_pm_runtime_resume(struct device *dev)
 {
 	struct clk *const clk = dev_get_drvdata(dev);
 
-	clk_prepare_enable(clk);
-
-	return 0;
+	return clk_prepare_enable(clk);
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_cnt_pm_ops,
@@ -861,8 +859,14 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 
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
-- 
2.25.1

