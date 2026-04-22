Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F772D3EF2
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776891980; cv=none; b=MR9K7YH1T/u9J5RscZgIytvdR7Dlac3i2xtBpkNjugki9ztSpveOMat0b55xKAHmY4g/xeF//+QCTyeqgP59A3Qu4Uzcns7pzTppNHj95l9mTcXNzHqVNnT40NyQbrMXrM0IsKBtVG7sncGpGfzojTUGV5cAUS4+06Zd8juYSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776891980; c=relaxed/simple;
	bh=/CSekN1zYPe2NdQLVZ/FR7/OfxhQn229eTGbrz9rXb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dywnMfQMxWizcInAjrbXEEPt3qUcY7G0mWWtmFguFSqJowcKuZw2n/CrTH8ykCAKpkeZwiHizP8meSmN+PZG5MvCzEo09v3xnNJTlxG8C0D5OclhOFTYQ/dsWTCMhFpplnmcdmKrqLX8xV84zHVEHAnDVBOiipxU3dc4HjcGuH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=oSxXTsZr; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="oSxXTsZr"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2dee127b3c5so7752694eec.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 14:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776891976; x=1777496776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pudKEV+xOP3hs/5+HMikr1MXRiTumODEI/eME8g3ldM=;
        b=oSxXTsZrUYF4jjpRK2Hv96s8+jZ51g1QV4zP1dZYD8dhzi6IYeAs48DxyO8TodX2FL
         vApRwe9oZLT5Cj7G5/qL0A2CMKddDEDngct9wKL7RewZJXP14kwHU4zzz49TYc0FluhM
         TbIcNtCV9REugh0ErJ8TbWvUqayrBp5+tN8Lu9lLG6Gz3/Ga0fKQmQA5GIe4MFvHgWJV
         NtgxcAAHlb6Tja8qJBbj73JNfwqVKe+u6RG7W417fNm5YBrK0G9Ogpl5+QCiussLPXgc
         qjpwqRfTuYwSpylj40zQs7w4VGFBq9gipOqvFirwSlFIP0ltKkTbSnG7PwOMnMcZWhkO
         bE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776891976; x=1777496776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pudKEV+xOP3hs/5+HMikr1MXRiTumODEI/eME8g3ldM=;
        b=OMAYBTXLN6vOLfYrz3+tBo+8I9tf9ZvTJ9i3J59lc0QOjTmh/si7EwWca/ObvgEwRz
         cMl/iPoIw9u/o0tc5Ze94MEyQcpObMAZFgHn+6Kua/Wz0UQPWLKdGIZ8pWLiQmcMkCr6
         dSGs7xvkCsBK6l4WkFvZMWm4YSOJnF7wGDacOoLj8eOpvG2FxXFIXJ/OfFjnlvdG/PZh
         PubzWjydgS5u1IjLI2wGtMZseuAEfHhJTz0rr9K0TYCxSa6EUFsJ7Cr7W4kfBCt5ZeFS
         q32kfd4A8JMJhRM22tFz/s8YkbChwN/amYUCYMx1Uc7Vk56LZr60TKePVr9Xd0X8HZ4X
         fmvw==
X-Forwarded-Encrypted: i=1; AFNElJ/6OommWZYXMkfu96tPc+Pp6scL4UQ29svTxriYGHsnzHpWVCl+4QVKWywQ4nMZwFb/Q5OneVDVSIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+u8/pqFD3u5f0RAreMHZt2lSF7ZpIrGalhy/To6Usg7qzKdFh
	4bfsuuEKZWXVY38yM/1k5mph6KgV7EMtlHsNjfxqzLTBewSH6Is98FnRe/NXL2SJu74=
X-Gm-Gg: AeBDiesyGFd9i30X9nB5caRj9K801urBevJ2Z+a8ckJk2dYOSvx9YWK/WMt6TDJTLsF
	62P6yq8IMBtoEnxSij31kKhmsCZETn/hyqgYc2Cp7p7XRkU12q81n/vrzC7KSvyPsNVbYIlMiYb
	NwXehGRT9hB00zqzKDf7favzc3s5vlIpcig6VgB3cvdXynUciGHLfpDBP08rQh0wJn320vrDnjt
	hPft1cUCsiSh+V8atNm3vWFFHJv/9SWcPXRxy5ItkgClzkvqVwaO+ZQvDsGMlnXuFliwtuhVoBw
	+iw7FytR8EfqoTb1VtZP885GTu4zMPACzIYnJOl8nluyt7XrD9WwYcL+VsiOOiGvBgmswANHtiI
	RzbFiKh2fGN20hign69InI3EbVQGhj0w/lIUR9stH8y/fyfEZMIAAOJTg4CenE/bN/ix+c0LAID
	0fhAkKhDhLb9OheE5rKuN5uirt46lQ/xcApnJnBLFyMcS0Ic8i/KQsKiBfnEhkHQ==
X-Received: by 2002:a05:7301:4185:b0:2d9:fa9c:87a9 with SMTP id 5a478bee46e88-2e464ea79b5mr13855071eec.5.1776891976066;
        Wed, 22 Apr 2026 14:06:16 -0700 (PDT)
Received: from monstruoso.. ([177.141.56.164])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa3ce1sm23704336eec.4.2026.04.22.14.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:06:15 -0700 (PDT)
From: Joao Paulo Menezes Linaris <jplinaris@usp.br>
To: ilpo.jarvinen@linux.intel.com,
	wbg@kernel.org
Cc: Joao Paulo Menezes Linaris <jplinaris@usp.br>,
	Guilherme Dias <guilhermeabreu200105@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] counter: intel-qep: Replace manual mutex logic with lock guards
Date: Wed, 22 Apr 2026 18:05:37 -0300
Message-Id: <20260422210537.12127-1-jplinaris@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped_guard() for handling mutex lock instead of locking and unlocking mutex explicitly. This improves readability by eliminating the need for gotos and by clearly indicating mutex will be locked only when execution is in scoped_guard() scope.

Signed-off-by: Joao Paulo Menezes Linaris <jplinaris@usp.br>
Co-developed-by: Guilherme Dias <guilhermeabreu200105@usp.br>
Signed-off-by: Guilherme Dias <guilhermeabreu200105@usp.br>
---
 drivers/counter/intel-qep.c | 126 +++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 68 deletions(-)

diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index c49c17805..199a8d562 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -188,25 +188,22 @@ static int intel_qep_ceiling_write(struct counter_device *counter,
 				   struct counter_count *count, u64 max)
 {
 	struct intel_qep *qep = counter_priv(counter);
-	int ret = 0;
 
 	/* Intel QEP ceiling configuration only supports 32-bit values */
 	if (max != (u32)max)
 		return -ERANGE;
 
-	mutex_lock(&qep->lock);
-	if (qep->enabled) {
-		ret = -EBUSY;
-		goto out;
-	}
+	/* Lock mutex while execution in scoped_guard() scope */
+	scoped_guard(mutex, &qep->lock){
+		if (qep->enabled) 
+			return -EBUSY;
 
-	pm_runtime_get_sync(qep->dev);
-	intel_qep_writel(qep, INTEL_QEPMAX, max);
-	pm_runtime_put(qep->dev);
+		pm_runtime_get_sync(qep->dev);
+		intel_qep_writel(qep, INTEL_QEPMAX, max);
+		pm_runtime_put(qep->dev);
+	}
 
-out:
-	mutex_unlock(&qep->lock);
-	return ret;
+	return 0;
 }
 
 static int intel_qep_enable_read(struct counter_device *counter,
@@ -226,28 +223,28 @@ static int intel_qep_enable_write(struct counter_device *counter,
 	u32 reg;
 	bool changed;
 
-	mutex_lock(&qep->lock);
-	changed = val ^ qep->enabled;
-	if (!changed)
-		goto out;
-
-	pm_runtime_get_sync(qep->dev);
-	reg = intel_qep_readl(qep, INTEL_QEPCON);
-	if (val) {
-		/* Enable peripheral and keep runtime PM always on */
-		reg |= INTEL_QEPCON_EN;
-		pm_runtime_get_noresume(qep->dev);
-	} else {
-		/* Let runtime PM be idle and disable peripheral */
-		pm_runtime_put_noidle(qep->dev);
-		reg &= ~INTEL_QEPCON_EN;
+	/* Lock mutex while execution in scoped_guard() scope */
+	scoped_guard(mutex, &qep->lock){
+		changed = val ^ qep->enabled;
+		if (!changed) 
+			return 0;
+
+		pm_runtime_get_sync(qep->dev);
+		reg = intel_qep_readl(qep, INTEL_QEPCON);
+		if (val) {
+			/* Enable peripheral and keep runtime PM always on */
+			reg |= INTEL_QEPCON_EN;
+			pm_runtime_get_noresume(qep->dev);
+		} else {
+			/* Let runtime PM be idle and disable peripheral */
+			pm_runtime_put_noidle(qep->dev);
+			reg &= ~INTEL_QEPCON_EN;
+		}
+		intel_qep_writel(qep, INTEL_QEPCON, reg);
+		pm_runtime_put(qep->dev);
+		qep->enabled = val;
 	}
-	intel_qep_writel(qep, INTEL_QEPCON, reg);
-	pm_runtime_put(qep->dev);
-	qep->enabled = val;
 
-out:
-	mutex_unlock(&qep->lock);
 	return 0;
 }
 
@@ -279,7 +276,6 @@ static int intel_qep_spike_filter_ns_write(struct counter_device *counter,
 	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
 	bool enable;
-	int ret = 0;
 
 	/*
 	 * Spike filter length is (MAX_COUNT + 2) clock periods.
@@ -300,25 +296,23 @@ static int intel_qep_spike_filter_ns_write(struct counter_device *counter,
 	if (length > INTEL_QEPFLT_MAX_COUNT(length))
 		return -ERANGE;
 
-	mutex_lock(&qep->lock);
-	if (qep->enabled) {
-		ret = -EBUSY;
-		goto out;
+	/* Lock mutex while execution in scoped_guard() scope */
+	scoped_guard(mutex, &qep->lock){
+		if (qep->enabled)
+			return -EBUSY;
+
+		pm_runtime_get_sync(qep->dev);
+		reg = intel_qep_readl(qep, INTEL_QEPCON);
+		if (enable)
+			reg |= INTEL_QEPCON_FLT_EN;
+		else
+			reg &= ~INTEL_QEPCON_FLT_EN;
+		intel_qep_writel(qep, INTEL_QEPFLT, length);
+		intel_qep_writel(qep, INTEL_QEPCON, reg);
+		pm_runtime_put(qep->dev);
 	}
 
-	pm_runtime_get_sync(qep->dev);
-	reg = intel_qep_readl(qep, INTEL_QEPCON);
-	if (enable)
-		reg |= INTEL_QEPCON_FLT_EN;
-	else
-		reg &= ~INTEL_QEPCON_FLT_EN;
-	intel_qep_writel(qep, INTEL_QEPFLT, length);
-	intel_qep_writel(qep, INTEL_QEPCON, reg);
-	pm_runtime_put(qep->dev);
-
-out:
-	mutex_unlock(&qep->lock);
-	return ret;
+	return 0;
 }
 
 static int intel_qep_preset_enable_read(struct counter_device *counter,
@@ -342,28 +336,24 @@ static int intel_qep_preset_enable_write(struct counter_device *counter,
 {
 	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
-	int ret = 0;
-
-	mutex_lock(&qep->lock);
-	if (qep->enabled) {
-		ret = -EBUSY;
-		goto out;
-	}
 
-	pm_runtime_get_sync(qep->dev);
-	reg = intel_qep_readl(qep, INTEL_QEPCON);
-	if (val)
-		reg &= ~INTEL_QEPCON_COUNT_RST_MODE;
-	else
-		reg |= INTEL_QEPCON_COUNT_RST_MODE;
+	/* Lock mutex while execution in scoped_guard() scope */
+	scoped_guard(mutex, &qep->lock){
+		if (qep->enabled) 
+			return -EBUSY;
 
-	intel_qep_writel(qep, INTEL_QEPCON, reg);
-	pm_runtime_put(qep->dev);
+		pm_runtime_get_sync(qep->dev);
+		reg = intel_qep_readl(qep, INTEL_QEPCON);
+		if (val)
+			reg &= ~INTEL_QEPCON_COUNT_RST_MODE;
+		else
+			reg |= INTEL_QEPCON_COUNT_RST_MODE;
 
-out:
-	mutex_unlock(&qep->lock);
+		intel_qep_writel(qep, INTEL_QEPCON, reg);
+		pm_runtime_put(qep->dev);
+	}
 
-	return ret;
+	return 0;
 }
 
 static struct counter_comp intel_qep_count_ext[] = {
-- 
2.34.1

