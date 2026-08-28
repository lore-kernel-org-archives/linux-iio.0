Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DF53D75A1;
	Fri, 28 Aug 2026 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787901118; cv=none; b=BPjWhVr8hlSgNkRWrgAEuUHj4AKjq918erasfNAipmlKxfFLuJjY9rYbJC4NAIg/JxWvck3xHdH/N+vyQyWg7RympxgZaGwoNmD+2LMgaiEQKiHoxabD/RWzDS/kI78SIhWf5yfCzFesOAlnjz0p92hn6v6uMkDKOPRDzlnh4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787901118; c=relaxed/simple;
	bh=WH6HUKOJyc/1kdlg30NyFlCwLK93F6ellUzmS+nTvYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dQ/48cEOtOJ0GHKimUlj6fDwylTdzwaG9lLZX3VixpXvhIIaWaeNDRDFR/+4lbdCNqTQUdLEEMMklzhc9K2OsKNeDtKOfsHmFgLOBSrKhjv0khZzDDbEdF11NArupHDGKDV+hEYx+ebRIpo/h16ZB9WxRv/ZXCPTAffkIM5ieQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CPz9pgei; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CPz9pgei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+X
	P+8l8cvCc8tLH+FwndoPU8YAhmQXz8pIkvMr6QsuM=; b=CPz9pgeiXqz4nsuhJ7
	pO5WhLB+zqyAV99Q51BVEYQmzupOgFDXVFzmjBoKj7wJpKAZrtTGKn5wvTr8EjMT
	jD/Z+cy0Aq4y2IMIvGkIq9iQMZCgNMVy+TS3ftqHO24/5gW3DHxIgWHPGlrCRs9x
	xMyRSTtOENhN5UVCQeR7OnTT8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCXP9qcNJFqzBfuSQ--.13812S2;
	Fri, 28 Aug 2026 15:11:25 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: biju.das.jz@bp.renesas.com,
	wbg@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH] counter: rz-mtu3-cnt: check clk_prepare_enable() return value
Date: Fri, 28 Aug 2026 15:11:23 +0800
Message-Id: <20260828071123.179670-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXP9qcNJFqzBfuSQ--.13812S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWxGF4UKr18Aw4xGr13CFg_yoW8Jw4DpF
	48ta1FyrW8XrZ7Ka17JrWqqFyYqa1SkFW3J340gayDZ3Z8Aryvqa4ktFyIva1ktryvkF43
	Kw17XFy8CF1UZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPHUkUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3h4z4WqRNJ4lVwAA3x

From: Li Youhong <liyouhong@kylinos.cn>

The driver ignored clk_prepare_enable() failures during probe and
runtime resume.  Propagate the error so probe does not continue with
the clock disabled and resume does not report success falsely.

Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
 drivers/counter/rz-mtu3-cnt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 7bfb6979193c..6f746cf598c0 100644
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
@@ -861,7 +859,10 @@ static int rz_mtu3_cnt_probe(struct platform_device *pdev)
 
 	mutex_init(&priv->lock);
 	platform_set_drvdata(pdev, priv->clk);
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	ret = devm_add_action_or_reset(&pdev->dev, rz_mtu3_cnt_pm_disable, dev);
-- 
2.25.1

