Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9642F363F
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 03:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778211680; cv=none; b=h412KJfAl03ivpiq/Rpu0zrW7C3jWKiCmMr1821aeFvgcvb/YzCy2VVu9uZOzPfouTgkBkRf8bjHT4wzHP0sidvdmQ4fe8LgzOmDYimvVuWCZ8E8n8hYg87uga6hmxdm9BlKYkSlLRftDNm3fp2UCYdX0LMZ+S3vQ2H1fa2YFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778211680; c=relaxed/simple;
	bh=y1zKzWQSHZtzLLfgNwQpgMzN7dFjX+rSjLZ9qTmynxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ptj7kzwXYpq1e4GcVubnM77D7+/dPLOyp8IqmeVggN1O712sRaRD/IQ364UkbDv61SWlxVADz0PqNzl0zHW011AsoN7hyjdgXbDTCUYJS+OE2hZQW3sYV6LmcebLMebFoGcAL2u/MJGFsKqxvxJxL6D1AA79Cc+zBsyi9iyiBmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=kHJP+MP6; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="kHJP+MP6"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f68f3b075fso2831937eec.0
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 20:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778211676; x=1778816476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ze8oLF2pGTrWHsOe1t0bRJErfjX97nYdIV0dO8S7cY=;
        b=kHJP+MP6TrrlvdTPOqHQBXjXmypQzVOcYF3W9TvLcunlTAPPLmyD179WCe/0vC5YfZ
         Cy56eboytQ/0uyiNPko2lNmKFH/ImX4S/9qZ1E0ZNikG32qkj+0l+3Lph175oRYuAY/V
         +Pmie6b/+v5zHjwox29I0dNByvaXKJcL9MAI6eDyTOYNZrXuRNAn+09ZWtxj3JcmqXPZ
         VYmzeVP3II36f0CckZ+ITnKLr8KZpoxNH/TsJXc5O/amXx4XSiiL8lwA6baXcXJXFdUD
         9O5x6dKBB3Z++3hYQZDRnnIjFniPutf7S7uyu6HZTuB9ICl3Ny1hR3oc864EqXlkUfzQ
         Z0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778211676; x=1778816476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ze8oLF2pGTrWHsOe1t0bRJErfjX97nYdIV0dO8S7cY=;
        b=CulNx0Gz/hhTuUUXqwExHHzXF2afJPaPldKPPhf5aBF6E71VOlpsFQ0bcmtoBT1w74
         Qymc+v8qZVVWKVhLwb7zavD7wlkeS0o3poUA/K+6/OIF9Ekm+JNNlYFNO4mlDpBblUYn
         dwBQ9uSrzQiD55jiWLvzg1L/Yj1YrQppUD35Y3qb3ZENnsJA5lPJdmas3Fiwg545pvnZ
         TpNO3VlupIKPtH6Pgwa/Jvg7jFLVYuq/Qx75p3LqDRRdCj2h88+vlMF7IF9sEqjFTaz9
         9y3byG11qFVHCQKJi5FFFRwWk9Ez5sTvxxbucUlFEX10nuLYH3U1dTmOmFAZ7lENOC+d
         okyw==
X-Forwarded-Encrypted: i=1; AFNElJ8WI4LMareyTDaM3TP+xS8Ojbbooh9s+vLOLF5ogMH/h5LR6sxLM9tzQsgJLTua2unZ6x5RS8hW1B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8XKWHQcr+F4+4V7thsdOk2VcGRS5na+tDOiOI9UMps/o5YDu
	eMN8+YVCA06I98CHtehPqGeBBaOg+7YPlxwHm+sdpE9wfgGVxKBjv6H098NwXbN1y7s=
X-Gm-Gg: Acq92OE/+ZLEJzVouTfL2q29q/ob4L7cQhT8TddYl1gdoqXCoXqTQVx3S/MqF1qhaNi
	KeV5wLhWtc0VKebMUnYB5OM5vsLj6xii+spMX/0cggqDoyZOadeiaBnukzWe17zvkuxgoIyWO0e
	iK/ghpCxrO/xgtKwGQUNyQrpgHOSdNXYejIoC1YH5pUbSvVJB3n3K2af+8CMnxEmhpoWU5yM6TJ
	O+EwQM9XnPqcPOEAXWUpbgopcBJA8jrI4fTwgRkuD6VixM8qIxztYADmP9Fp39SB3UY0qlELkIV
	GTaRDcPjOYigTlJo2JZN2pKlRwZX3hD3/qtjhkv2cLc0eHbFbvhaQrmIVsZ6F5BK6lsnko9tePt
	Hlg3T9Xp2Vdp0FC7BwwzMW0VHEeL94ulpWPCVm2t2UGQmZSrHaG/qDpgLPI/0C7PBjr/IJyTtlM
	JGWJAKnd2QwRB8kSu293ildqL3Rgc4ELO/QMOmqq0Wilw2JPGk4qrd4NWHtJgdDV8=
X-Received: by 2002:a05:693c:2c8c:b0:2f5:5907:3a49 with SMTP id 5a478bee46e88-2f85e62da93mr535715eec.30.1778211675586;
        Thu, 07 May 2026 20:41:15 -0700 (PDT)
Received: from monstruoso.. ([179.119.119.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafacsm594959eec.1.2026.05.07.20.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:41:15 -0700 (PDT)
From: Joao Paulo Menezes Linaris <jplinaris@usp.br>
To: ilpo.jarvinen@linux.intel.com,
	wbg@kernel.org
Cc: jplinaris@usp.br,
	Guilherme Dias <guilhermeabreu200105@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] counter: intel-qep: Replace manual mutex logic with lock guards
Date: Fri,  8 May 2026 00:40:57 -0300
Message-Id: <20260508034057.23595-1-jplinaris@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped_guard() for handling mutex lock instead of locking and
unlocking mutex explicitly. This improves readability by eliminating
the need for gotos and by clearly indicating mutex will be locked only
when execution is in guard scope.

Signed-off-by: Joao Paulo Menezes Linaris <jplinaris@usp.br>
Co-developed-by: Guilherme Dias <guilhermeabreu200105@usp.br>
Signed-off-by: Guilherme Dias <guilhermeabreu200105@usp.br>
---
v1 -> v2:
 - fold the commit message properly
 - replace scoped_guard() with guard()
 - remove unnecessary comments

 drivers/counter/intel-qep.c | 47 +++++++++++--------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index c49c17805..ef6eb3249 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -188,25 +188,20 @@ static int intel_qep_ceiling_write(struct counter_device *counter,
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
+	guard(mutex)(&qep->lock);
+	if (qep->enabled)
+		return -EBUSY;
 
 	pm_runtime_get_sync(qep->dev);
 	intel_qep_writel(qep, INTEL_QEPMAX, max);
 	pm_runtime_put(qep->dev);
 
-out:
-	mutex_unlock(&qep->lock);
-	return ret;
+	return 0;
 }
 
 static int intel_qep_enable_read(struct counter_device *counter,
@@ -226,10 +221,10 @@ static int intel_qep_enable_write(struct counter_device *counter,
 	u32 reg;
 	bool changed;
 
-	mutex_lock(&qep->lock);
+	guard(mutex)(&qep->lock);
 	changed = val ^ qep->enabled;
 	if (!changed)
-		goto out;
+		return 0;
 
 	pm_runtime_get_sync(qep->dev);
 	reg = intel_qep_readl(qep, INTEL_QEPCON);
@@ -246,8 +241,6 @@ static int intel_qep_enable_write(struct counter_device *counter,
 	pm_runtime_put(qep->dev);
 	qep->enabled = val;
 
-out:
-	mutex_unlock(&qep->lock);
 	return 0;
 }
 
@@ -279,7 +272,6 @@ static int intel_qep_spike_filter_ns_write(struct counter_device *counter,
 	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
 	bool enable;
-	int ret = 0;
 
 	/*
 	 * Spike filter length is (MAX_COUNT + 2) clock periods.
@@ -300,11 +292,9 @@ static int intel_qep_spike_filter_ns_write(struct counter_device *counter,
 	if (length > INTEL_QEPFLT_MAX_COUNT(length))
 		return -ERANGE;
 
-	mutex_lock(&qep->lock);
-	if (qep->enabled) {
-		ret = -EBUSY;
-		goto out;
-	}
+	guard(mutex)(&qep->lock);
+	if (qep->enabled)
+		return -EBUSY;
 
 	pm_runtime_get_sync(qep->dev);
 	reg = intel_qep_readl(qep, INTEL_QEPCON);
@@ -316,9 +306,7 @@ static int intel_qep_spike_filter_ns_write(struct counter_device *counter,
 	intel_qep_writel(qep, INTEL_QEPCON, reg);
 	pm_runtime_put(qep->dev);
 
-out:
-	mutex_unlock(&qep->lock);
-	return ret;
+	return 0;
 }
 
 static int intel_qep_preset_enable_read(struct counter_device *counter,
@@ -342,13 +330,9 @@ static int intel_qep_preset_enable_write(struct counter_device *counter,
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
+	guard(mutex)(&qep->lock);
+	if (qep->enabled)
+		return -EBUSY;
 
 	pm_runtime_get_sync(qep->dev);
 	reg = intel_qep_readl(qep, INTEL_QEPCON);
@@ -360,10 +344,7 @@ static int intel_qep_preset_enable_write(struct counter_device *counter,
 	intel_qep_writel(qep, INTEL_QEPCON, reg);
 	pm_runtime_put(qep->dev);
 
-out:
-	mutex_unlock(&qep->lock);
-
-	return ret;
+	return 0;
 }
 
 static struct counter_comp intel_qep_count_ext[] = {
-- 
2.34.1

