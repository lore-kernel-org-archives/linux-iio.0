Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6943A3E63
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438425; cv=none; b=pawwu/B1RLw7bmOlqYqtDGeNTX4MldJGDGDSoQXjTwDxu8Leq6ti0Y6DRJDPdYtTgBWD9m7f23CVKJjLCxDhIYqoR9KBzo7KMlrzFRl5o75bCJs2YgiFvWPJerQX0exm2CwmdBjKl0Sm5FKAFQoUKIeShijVfyTSYPyFwjSkLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438425; c=relaxed/simple;
	bh=+MwV8AsdZ/5jaRACYsk23cIdHiV4nVvviraIMeQqn2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qR17zu88nQEnp0aIkvh5iL2xwV/oRSLLjuWdrsU3UCzypOO4LX7wy8QvsfSibys5do4c6HHkYq1ZfQvKepaqb99HlTy3XnbA/EmLs9l58gDbFueIQPp94Hl+RUQAuHyo7AiMOL3zKpcQiDuXqsikaSIEio+vHmB53s1gdPy1j34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcTLMg9s; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcTLMg9s"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c79506f3c40so315985a12.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776438423; x=1777043223; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6tFApCIoJhXtGwkpF7Y8a0eo4V5rb44+8Jp9WUbXyI=;
        b=LcTLMg9smZaE58HBpc5ehd2a0Oqb9HGxtGtwB/2hHI/1ieWRQya/wDp4mJF3KxmItm
         oPSa5ieVdLvUulCXCgE45wLIJSrz7+xzKJkwsObwBWJ/7ub7WTugoAxUMqyC4QPfRegx
         E0E9u1TVbYDhSwvV7JRgHSLldhg2PQwudmfbAslk9OLewP2LQb4hZ6Tr/FXmTFSdB+ya
         F0SKb7eb2VorD0xPzPzPoaOhMjKF+57M6tgqpAabUTXZuCLFuk75LRkv156eg7UbBOr8
         ucSXAQkypK6PKjjTwXlXXlYY3VHLBwFRCRDt11SBTB41SkrEja9P3P7FXTY4ZfEGEpQf
         RE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438423; x=1777043223;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6tFApCIoJhXtGwkpF7Y8a0eo4V5rb44+8Jp9WUbXyI=;
        b=fClWrESJ2ZtaUQ+XIp+sGVuhQjLXHQGTcqV77EZCGpJ9E4YmLpcMQRwHlxTF8IZGzr
         UVOKd1eZG2tlAabxSdDsn0Q9yWfujisjsRHujuZ27d6lTQ3rE65iy1rc/+n6nQ9aCgEr
         KOKgURKjhg39FbIkloo/jAXehIzYAvohMRe43mVrUcbGc8TgdVvKavpzNt0D/X5Otm8X
         ieVBjqGNZ7gYOX19sqos4OwJAmoVN+iYLb838Ol7wV582gAtwJy1KWaqkV8QK3fwgxFm
         5q5F1tcGA2ODILm1ytJpoWXjF6XF/eShIPLwuez4rOO1aT6LtVa0GNEhI17r6w//jQ2L
         w9OA==
X-Gm-Message-State: AOJu0YwJfz0t6Bnv+/SWir5dKLRfo+xIXxpKNWw2qeeDZLHY5X221FRa
	p7eE/mW7TG1gp2RRTp/1HXJgSX4PcEE9Wq/3ruaqsITvodL5OiIJ5PT6M/yKw88AaGw=
X-Gm-Gg: AeBDievrKha2SCC9YpNx1qgE1eiThZeUuHMZu1OWRLMh/N2XXyVlTQIer4Aaf99t7h2
	kJmxMFVirLdyK9pQaiTciz9maydKFKcyhND+fsX7t1jkvNulcpqUAFV3sGWx78l/5EeF559/elP
	usBbs2QXeLbhY56jJ1auVmADLXlU6Ce6+b0OgN1CqM47OYl9ZW+e+ZcSqh9rCrkeBH/hm3oUYzk
	wDJLXCHrsbJ/K3ej4qrndNK459FyjW/v3mDB/URP3YrCfBaIiZP615ke/XZriyi7cfEumiYIG9j
	IiIBtrbChMdMBEztUKvG7ySvbcffjdQYejcHkiWUmH3Wc3rIc7mw/Tz540LHk0U7zNL57VXX9RR
	Fn7BwznS0vOlutMMIbRCIjMvjRnXpdcwpWu8ZdLOw/f/cCAUt4HWkMRgK/3uOJl2erv5HiSZVYK
	+5Bg4BIyf52WgGGzH//4d0BDrOti8tCtsbLp8j307S7lO1X5e34A6uSiYLoHfdsA94QiUbtztks
	Ub+c8H6cLFkz8IBRv3If1nRkszBAxl1v6P7EHy5nQ==
X-Received: by 2002:a17:90b:3b4a:b0:35d:a4c0:a0ac with SMTP id 98e67ed59e1d1-361403d61camr3484516a91.3.1776438422821;
        Fri, 17 Apr 2026 08:07:02 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410bafa9sm2357455a91.15.2026.04.17.08.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:07:02 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 17 Apr 2026 23:06:58 +0800
Subject: [PATCH] counter: ti-eqep: fix runtime PM leak in probe error path
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-ti-eqep-v1-1-a7db4642d9d0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJFM4mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Nz3ZJM3dTC1AJdi9S0JMvkZHND49REJaDqgqLUtMwKsEnRsbW1ALX
 +8WdZAAAA
X-Change-ID: 20260417-ti-eqep-8efb9cc713ea
To: David Lechner <david@lechnology.com>, 
 William Breathitt Gray <wbg@kernel.org>, Judith Mendez <jm@ti.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776438421; l=1380;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=+MwV8AsdZ/5jaRACYsk23cIdHiV4nVvviraIMeQqn2s=;
 b=FH3I5fCP44NThJLQdd8aUkxpSVUc74TpVyl8aINWG0pd96WSIjuN3BbMNMKiAxwlAbtqQ5oIw
 cuiufgeii8DAfmF0yvaXTnDVo5woXl+Vz9UGTiDDRyIPcZ5U4ygZpUH
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In ti_eqep_probe(), if devm_clk_get_enabled() fails, the function
returns without cleaning up the runtime PM state.

Fixes: 0cf81c73e4c6 ("counter: ti-eqep: enable clock at probe")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/counter/ti-eqep.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index d21c157e531a..dfa945b3eec6 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -548,17 +548,22 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 
 	clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
+	if (IS_ERR(clk)) {
+		err = dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
+		goto disable_pm;
+	}
 
 	err = counter_add(counter);
-	if (err < 0) {
-		pm_runtime_put_sync(dev);
-		pm_runtime_disable(dev);
-		return err;
-	}
+	if (err < 0)
+		goto disable_pm;
 
 	return 0;
+
+disable_pm:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
+	return err;
 }
 
 static void ti_eqep_remove(struct platform_device *pdev)

---
base-commit: 452c3b1ea875276105ac90ba474f72b4cd9b77a2
change-id: 20260417-ti-eqep-8efb9cc713ea

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

