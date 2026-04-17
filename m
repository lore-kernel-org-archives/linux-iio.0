Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DB33DED1
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442128; cv=none; b=XnHlMVTPkYbL0/qKUTHTCF0K0uv1Zg1E3E7MDsOV+ElM2V2JSNBMHDFcuyvycjwimWIGgsY6h9sNcQ/I6X/V3vkFU8Q+1Jc078F02yv6obB2Hif5HEfnMfbHY18JqtwFK9PXF03tEfUSSVDOeeZDGO2TIVE82Wu3EZ24lNfg0mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442128; c=relaxed/simple;
	bh=elMH0A5dNUucHdQlYYF5w5q0pFGSO2M0Cmf8V51xFME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=coPFEvJ3niUztdz5hL8nxLf3Rwy1j1yz/zMb8EUiU5h1ypDJiP8oUrNA9N5LNrmqr8jIFnOlbbLzFDI1EODD56TXcxXlnhArwApX2GE2kWVBs9wmDBaG1s4HtYvLRtR1q9nfaBAg0pBoBF3xjZJQ2Z69gWai4O+CSVwnfAXuyZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J860zpSR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J860zpSR"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b0afa0210bso4172405ad.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776442126; x=1777046926; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q8LPcx1HdbjW6CgkoN9QPSPuGiSccz6Lmi6jP/IIhHw=;
        b=J860zpSR4hMDRcd3HwPRq73iwF7DlKDpVsTHBVIrgFUzQdbAg2q5McbnwK+rxkneS5
         rFPHrcfJhwcvKr+hQpo3THyfwWy7gsL9nyUNT/gvBPGGnhWGsNxuFTopNgP4Yxzk7HfA
         D52aIZzPpPm15bPgaR1HuL8cbAdBPzBBEsGuC29WGhPYQnBa6zTjr6/HVWpzAijlcDHm
         R/VV0jsR4E6giShMZpyd0sb/PO0VyGEH7BV2dBjekpxWP8EfZAx/PaR28KbUZw66LbFx
         FUbe9Iktf7eOYKc88ISpSVPLWrCTZppF14wJTt0WyqOsPrZiocedoGJqvXXzzwzurg7P
         bSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776442126; x=1777046926;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8LPcx1HdbjW6CgkoN9QPSPuGiSccz6Lmi6jP/IIhHw=;
        b=MRvMMWkKndw9QLo5XmN3NFARc/iH50HhqTR07Epj8S8kLbqZ9evM+fLlnYTwR07Hn6
         9FABa0LYgqcoNwM/7TJ3xfDKJqXIKafSPdO5WIa1d6WFXHac+KTYKURAQcTYgTjFmfh5
         r+b833mna9Jva30xaZAz2UDKyQKCGPi7gyWjE7hZdC9krSHMaVypnP36EUwwoxoc9QqC
         tfhnAuiojM9cJQZQ1cEQOdCzDTHy258yyzh1mj3nt1ZoffrAbbLrgbZUBFOZoKvEhG7N
         TqhRSxWVfCJIZ8BzGqArZlQqdTVgGN5hQRXoiussFNsszGIYDlMvzXFNfM1Qc39C6oXe
         faFQ==
X-Gm-Message-State: AOJu0YyIOr7qyZv4ER6k/dg9WPxcvY/mFJ6MYYuIexd2QQlSq0kdolTT
	Xi/pj/14w37qxDRhknh3zh7NS5+6hbwwEdvDmdI7BTNZP7LTWQFFY1s4
X-Gm-Gg: AeBDiesN0fUsAfMZNL2hTS15WiSfQ52STQnhSdJnQt6jUWVoD1qHhhZo2EdBPnzz4AY
	L0642Sqr8a/VI8tbYOwKxSHvWfN8+qnZ8gk7pmCGRB1Ic1S88fhTu8B7HK2mx1LEW0uMLmPK9+W
	SsQrFvHqZfRo81ZHCUyvAdJ7bq/GmOTyA6URZxLkuzwhxdAyVRshqTdNHCd+SLNmILzZkMx1Fjr
	gvUXTDcUhsJi5sgS+0/HYY3ourDMIxhGO0LqtEOhjOc13iHympTmftoI615KW+y2Z6jJ+JelA06
	i5e+RDlmq6vJdr4RLRov2GsfPZuYQXzQrFWRu/klh4pB88F4mGfMcCer9uzSN23e5PYzLr2NZKB
	qWvcw+gi7umlAxPfqzn4QNNp7NrUgpb36cnVuVzxFivjv9unWLesTeBv2EHXkiE7YIgYKcYj8yh
	gy/KF0WuL/YWdYu/jY7MZ2NbkkSiK+r5RNkpwgheKNuxFZUdPAVeSlPgVz+m3Ol0u8luZUCS0rP
	KkrXPOIncoY6kUj8JqXyVUPnnDkdXE=
X-Received: by 2002:a17:902:868f:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2b5f9f3ca68mr27500095ad.25.1776442125959;
        Fri, 17 Apr 2026 09:08:45 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20c6asm21888895ad.58.2026.04.17.09.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:08:45 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 18 Apr 2026 00:08:35 +0800
Subject: [PATCH v2] counter: ti-eqep: fix runtime PM leak in probe error
 path
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-ti-eqep-v2-1-2f803963c4fc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAJb4mkC/2XMyw7CIBCF4VdpZu0YQFKsK9/DdEFh2k5iL0JDN
 A3vLnbr8j85+XaIFJgi3KodAiWOvMwl1KkCN9p5IGRfGpRQtdDS4MZIL1rxSn3XOGfkhSyU9xq
 o5/chPdrSI8dtCZ8DTvK3/htJokRrfKdrrXzjxX2YLD/PbpmgzTl/AfOrWH+eAAAA
X-Change-ID: 20260417-ti-eqep-8efb9cc713ea
To: David Lechner <david@lechnology.com>, 
 William Breathitt Gray <wbg@kernel.org>, Judith Mendez <jm@ti.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776442123; l=2523;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=elMH0A5dNUucHdQlYYF5w5q0pFGSO2M0Cmf8V51xFME=;
 b=oUGFcAwz3nd3GDmkIHkmSvfFICnd4JUj+rR75bIVqclE1X1Gqq5nB5OXMfcDPl6koLOTggdFy
 QnACpv9RK7YDlLoUtnh0TxJQTwPD3q55jvWglaX7ujHyypVRrS7y0v2
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In ti_eqep_probe(), if devm_clk_get_enabled() fails, the function
returns without cleaning up the runtime PM state.

Switch to devm functions to fix the problem and remove unneeded
remove() callback.

Fixes: 0cf81c73e4c6 ("counter: ti-eqep: enable clock at probe")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Switch to devm functions to fix David's comment.
- Link to v1: https://lore.kernel.org/r/20260417-ti-eqep-v1-1-a7db4642d9d0@gmail.com
---
 drivers/counter/ti-eqep.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index d21c157e531a..08dc6d0ad5e4 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -492,6 +492,11 @@ static const struct regmap_config ti_eqep_regmap16_config = {
 	.max_register = QCPRDLAT,
 };
 
+static void pm_put_sync(void *data)
+{
+	pm_runtime_put_sync(data);
+}
+
 static int ti_eqep_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -544,31 +549,20 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	 * parent PWMSS bus driver. On AM17xx, this comes from the PSC power
 	 * domain.
 	 */
-	pm_runtime_enable(dev);
+	err = devm_pm_runtime_enable(dev);
+	if (err)
+		return err;
+
 	pm_runtime_get_sync(dev);
+	err = devm_add_action_or_reset(dev, pm_put_sync, dev);
+	if (err)
+		return err;
 
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
 
-	err = counter_add(counter);
-	if (err < 0) {
-		pm_runtime_put_sync(dev);
-		pm_runtime_disable(dev);
-		return err;
-	}
-
-	return 0;
-}
-
-static void ti_eqep_remove(struct platform_device *pdev)
-{
-	struct counter_device *counter = platform_get_drvdata(pdev);
-	struct device *dev = &pdev->dev;
-
-	counter_unregister(counter);
-	pm_runtime_put_sync(dev);
-	pm_runtime_disable(dev);
+	return devm_counter_add(dev, counter);
 }
 
 static const struct of_device_id ti_eqep_of_match[] = {
@@ -580,7 +574,6 @@ MODULE_DEVICE_TABLE(of, ti_eqep_of_match);
 
 static struct platform_driver ti_eqep_driver = {
 	.probe = ti_eqep_probe,
-	.remove = ti_eqep_remove,
 	.driver = {
 		.name = "ti-eqep-cnt",
 		.of_match_table = ti_eqep_of_match,

---
base-commit: 452c3b1ea875276105ac90ba474f72b4cd9b77a2
change-id: 20260417-ti-eqep-8efb9cc713ea

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

