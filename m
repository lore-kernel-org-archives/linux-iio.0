Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE83B7B7A
	for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790047322; cv=none; b=kraP8coB6kY0XMR9PKMX1FDzVqVrWFPgqrM/U+3OUnZDIjah+nji2TDbIvJhMLKUsbvBbCoiutvImW8EM3wDnILyW1tx0m+eEpIwqKP5evlSkcQbPx/t/xXg9w2iBH67VDU7yT+I/w+vSqeOc+fa30gnFSMn85F3uRIBEjcZj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790047322; c=relaxed/simple;
	bh=1css2TggderLnr3nSib+94+QiMSM1LbQyk3BTFFTt3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVE5RWYExK5kr32l0woBYA36B4d5aFOo5wW6m7IcA4ZpRfDRWnE2gKnm9M05vnIeQUPrXCmNQkbD0f7PBF3e/sE9HG0/xF3x3ycNdFlBYTCe67aO5hlS3luWh43sdbpEQ4bvlurrnfKMFiH2tsuQDyMbDNF7phfMyExRdj1s6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eF9Yjrg1; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF9Yjrg1"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469f20513so3037697b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 20:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790047320; x=1790652120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I/RFZdO52rZMsPV/i/QcAurCdGJW0p4qsya4Rr0KHOI=;
        b=eF9Yjrg1MKhjlVjw/Th3+fEis0E2mvtSus9vR2+F6u/aCHW3M8w+ovASOF2m4j1Xpa
         p5AkcbGpp0VGU8Qbof8vPnK5K0qMKDnFK8P3KfvUl1j9IjiOoNoR9sYjr1v5wtwJ/jZV
         sIOuTxQIyP+CNN4S1ajMLH4yqLzoYsCThVjHHYVs3Z23wuXXoV4GxFckFYC0bev6zv8g
         Wfk/bbhnr614TtDCNfGIPt3JA/wpuPdyessJVZ8OOK9/rj4SrVaTJebCZCan6qQ1qY+X
         RhWudBBeb6z2yO1z4Fg+4iC7ScrTrWByGNGize6Pasd5oJCcTBF4Gyc56VJHYB72y4c8
         WK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790047320; x=1790652120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I/RFZdO52rZMsPV/i/QcAurCdGJW0p4qsya4Rr0KHOI=;
        b=P2aMn0PZ4XJWL0vYiISF/lf40gNuivQNwDRWYTYv/MI7nMS5uk2HBjjrFOJihilYwx
         qb72bLP5/0RNm7JxBns5395EEwJ4yemnDROCUOErG2Ar4zTf7dJ4m5nQQ1srsDhP2Dx+
         Z1762JXjmx1MqkKWPoNzU4rf+dGPpxQtTDAF/C1eyPXfL/q6X+wcaLo8uR7jbBI0qSG4
         9z1+NnAKJ5v7ap8Vbt73a8K6SVuL1ezQ9lbeQ4kniJrFtWk4PqW9NXyYBzOHrrvqusxl
         hMWcFhJnR1OPMkjxZ7GrTjVnAEIkEL/BacP+PTe1V2W1dPq8doKqbeQbS1cVQ2YV+0nb
         sabw==
X-Gm-Message-State: AFuF++n/eKRxxl9rJldtFue6DJbaBq+50cbAw38/XU0AsGr+Xe7egFDs
	LGkurrwbDPOh6zEooQ1Lf6IMJL1Y8PPgcE+kLUyXjj+8CMXMULcGH64H
X-Gm-Gg: AYBFou298pMp4ixZPkH2cr09wgUuX7KrgzwL8RoEHG5R9/8Q1IQR0PqYkBvJVecQrjT
	10LCMX3QuOagoPBRs2OaGI8Gv65fS1rOgw0N05sE66DVdFLZ5fWNeN0RzWSAtMTZT1lJjhmwf/9
	AY58LXFXD6KSFOQ6BLT7vmsb3pQbIvHA+lVavbBjfw39AU8d/zEmVeFZFThPDOqEKqDrxoEFXBq
	lwBxI5u+0NdLZqupj1BSRKi+4qpt9pDKz72+58R+nagP4Z0zbQ8P3NKJpPI2wb1ujg2g5wq1A2V
	B+rmkA20jkaxAhBS2ittLEK1bX8TCoWqd65KgA7H/kkK3eJRjViTKgioqtAeymyNA7m91j+k3H4
	KGGYpd8By3w67qkvNA/SoGmBEBrem9QO5PGgbRctzn84o7EU0f3cmao3zVeHNLdDHuMphIYhNgU
	8YviVGDucjKhgTsBhbcoc+sdmByZfOoD09YAlxi7VNssEht1/CwKAenwYDkmu/FpvQeqkyV351G
	NmHFLFoQejRQ0/HUwsXVBu4gPloFbo9Cba7LWVb64nDGajnsTccmDEZ3H/n6Ck82rHx6sgkdf5l
	MvPWikHpYUEYKQ==
X-Received: by 2002:a05:6a00:a201:b0:878:3773:81fb with SMTP id d2e1a72fcca58-87837738767mr9824520b3a.55.1790047320226;
        Mon, 21 Sep 2026 20:22:00 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87c2fb538fbsm145472b3a.3.2026.09.21.20.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 20:21:59 -0700 (PDT)
From: phucduc.bui@gmail.com
To: David Lechner <david@lechnology.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] counter: ti-eqep: Fix runtime PM error handling in probe
Date: Tue, 22 Sep 2026 10:21:46 +0700
Message-ID: <20260922032146.321006-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

pm_runtime_get_sync() errors were not checked, and if
devm_clk_get_enabled() failed afterwards, the function returned without
calling pm_runtime_put_sync()/pm_runtime_disable(), leaking the runtime PM
usage count.

Switch to pm_runtime_resume_and_get() and add proper error unwinding via
goto labels so every failure path after pm_runtime_enable() is cleaned up
correctly.

Fixes: f213729f6796 ("counter: new TI eQEP driver")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/counter/ti-eqep.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 0dda3f2b14c7..698a9920f20d 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -544,20 +544,31 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	 * domain.
 	 */
 	pm_runtime_enable(dev);
-	pm_runtime_get_sync(dev);
+	err = pm_runtime_resume_and_get(dev);
+	if (err < 0) {
+		dev_err_probe(dev, err, "failed to enable runtime PM\n");
+		goto err_runtime_disable;
+	}
 
 	clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
+	if (IS_ERR(clk)) {
+		err = PTR_ERR(clk);
+		dev_err_probe(dev, err, "failed to enable clock\n");
+		goto err_runtime_put;
+	}
 
 	err = counter_add(counter);
-	if (err < 0) {
-		pm_runtime_put_sync(dev);
-		pm_runtime_disable(dev);
-		return err;
-	}
+	if (err < 0)
+		goto err_runtime_put;
 
 	return 0;
+
+err_runtime_put:
+	pm_runtime_put_sync(dev);
+err_runtime_disable:
+	pm_runtime_disable(dev);
+
+	return err;
 }
 
 static void ti_eqep_remove(struct platform_device *pdev)
-- 
2.43.0

