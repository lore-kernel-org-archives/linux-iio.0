Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A291E885A
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607080; cv=none; b=WWDCl1DP646wk3Kau5wKY629h2NtftP5l6d0xu7RDr93KsUakIWKKTZ6TLXBIRmzV3mxXwtihsaFYOoEF0d7SQmt/dHO8+aCeek+ZTGeouPO6G1vbG14TJ+yQdB6lL0bUS/h1rvK6WQ9i7dbUtpgmk67hZkfFueGIEbgsyspycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607080; c=relaxed/simple;
	bh=7ylvAkWKyRx1lYOIUNA0FfdsoQUTIreU5TKe9Wg6ERM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R4V2NzuZ2XytMJRE7zgiY3xqQG5hoTZb0EasR1KOwGHKgPEd7id5kstw3qv2Cl6a0JmXVGANM7uOfxFJgR9qIj8u5J/PT24aq6/6gGjbldtyq8uC4myKE0J/Xi69hchfqhgvuXODOa40Rv9sENe/khpjKCBETMfwtgsJJ//zOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=fCY78bzw; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="fCY78bzw"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso5732686eec.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778607076; x=1779211876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zfJWDVy4fKwxOBwHHuK19hwmI1EvW8iXJmB1a6h4XUk=;
        b=fCY78bzwczf+dM2uBLr1/J5yO00eT2kBwM08lI4j4glbniPUAYBe3mDKbLyOM5GRfC
         ZQUe682UR0lnyGWpj73krDkFEamMYLSg91gi74zFASwp/TF2Ua2ZpeZRkzwn9Hn27oTH
         QTSvdDq2SU0j+F/pRsWB0EAApfy9czefd/i0qLxUtFko77lDT1HIiTxtwxOiaymN2gP3
         jhdm60zoxFOunrMdCEpsfIjdb07omctpV6rAAtJEvCDptbWzqazha253aLFpXNLehpJu
         Qnf80Nuem4xbXe5f1nyN7hszedOy6WUysyCxJok/O2wvMi+jP4KFvkKPB5HJPUK7flCe
         P5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778607076; x=1779211876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfJWDVy4fKwxOBwHHuK19hwmI1EvW8iXJmB1a6h4XUk=;
        b=Jb7hnPcwyhop9EGu80aC7VoYur9vh6Vsdi0efTG5SpqW+7pgGH2p1z0+9NF/UTciLn
         /nTp3DARtJ3Sre9LsWeOnaAL3xlxZMIETmVohb7czflW8W+1TN3cYaJbr3yo9rxT5OTl
         Iyv7TxrlhylDyTYlsgpo+VG6EE0Rgwkromyb28cy+m/evuORqaX4mJ0PJGmIUWrAvEpX
         nYRHhGDBTr+BiGbDHvPa7VsJvcgBbQCiBDkPOlZ+/edAMOI5vJ62DKwQhAlzT7GOmmU3
         U06MEJOqv134QDe+vDGdpnwKq7zFRi0rIKt3QQCKfuUWf4q+apbK4PEALzs/SAWx151L
         LE0w==
X-Forwarded-Encrypted: i=1; AFNElJ/6HDecyCkn4i6bBuxKTMwjJ4GWKOaJe1U9gcDTm5F5wxogAj8QIUBHQMW86xWVwAJtkHS5vECbPNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ynPdpGxGM9iI6I5a8bTi0CfR/lo85biPIwgssJMJGblMX8ne
	Z+0vY52XTT3RPQkmskI9fzVv92Yh8JI8KmfZ6NNngQU9/sbzARuDrBR9JtVBB/6m7bg=
X-Gm-Gg: Acq92OGm4CbGOnulIcLmW5OUYaALXNz/Yy+FEDuDV5OMkPXPSg9cMU/jnWY6GB9mccz
	bcYiR0Jq0FGPz1FAbsMJQVuNOKTUlbq4m/ZWT3eHzEoKYCL8pnLa7tgQxbFQ6jHnr8o7OHxu3lE
	Us2VXFTnWROtcxksg50Jmy+boNBd3blzpo1nnPIL4GY8WQ1WO5Wy1hKypeXs2jY++3BJMdJvGM8
	MUnCL7oWuP1CYXdZLt99mjrPm5tCVoKffHhSEN7waS3B9j4YZgoIxA90OuEfwYea6SRmDER8V/0
	lkhL+qhKxNgvrq3ocnXcvAbcll9fHp4xunfrUpa67Url2xazf97y2n535CWuQ0Av/AohdqZN0su
	AtxmrQEOHmm5FhcFIFhFXEUS6hmW2qjWKFFY0T96soGbDrhVpGXr/5fybVOYUtA9SRy5ZcY4WBg
	pEY3NhkWUmTb7BR7cYSisOePXBtJZZtI1LdoEWeO1laC+7KiwbfX2/
X-Received: by 2002:a05:7301:290d:b0:2f0:5605:466e with SMTP id 5a478bee46e88-301181ab18bmr17369eec.9.1778607076142;
        Tue, 12 May 2026 10:31:16 -0700 (PDT)
Received: from monstruoso.. ([179.119.119.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859e8389sm18804381eec.3.2026.05.12.10.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:31:15 -0700 (PDT)
From: Joao Paulo Menezes Linaris <jplinaris@usp.br>
To: ilpo.jarvinen@linux.intel.com,
	wbg@kernel.org
Cc: Joao Paulo Menezes Linaris <jplinaris@usp.br>,
	Guilherme Dias <guilhermeabreu200105@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3] counter: intel-qep: Replace manual mutex logic with lock guards
Date: Tue, 12 May 2026 14:30:57 -0300
Message-Id: <20260512173058.14858-1-jplinaris@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard() for handling mutex lock instead of locking and unlocking
mutex explicitly. This improves readability by eliminating the need for
gotos and by clearly indicating mutex will be locked only when
execution is in guard scope.

Signed-off-by: Joao Paulo Menezes Linaris <jplinaris@usp.br>
Co-developed-by: Guilherme Dias <guilhermeabreu200105@usp.br>
Signed-off-by: Guilherme Dias <guilhermeabreu200105@usp.br>
---
v2 -> v3:
 - add blank line between guard(mutex)() and other code

 drivers/counter/intel-qep.c | 50 +++++++++++++------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index c49c17805..9c6536f75 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -188,25 +188,21 @@ static int intel_qep_ceiling_write(struct counter_device *counter,
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
+
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
@@ -226,10 +222,11 @@ static int intel_qep_enable_write(struct counter_device *counter,
 	u32 reg;
 	bool changed;
 
-	mutex_lock(&qep->lock);
+	guard(mutex)(&qep->lock);
+
 	changed = val ^ qep->enabled;
 	if (!changed)
-		goto out;
+		return 0;
 
 	pm_runtime_get_sync(qep->dev);
 	reg = intel_qep_readl(qep, INTEL_QEPCON);
@@ -246,8 +243,6 @@ static int intel_qep_enable_write(struct counter_device *counter,
 	pm_runtime_put(qep->dev);
 	qep->enabled = val;
 
-out:
-	mutex_unlock(&qep->lock);
 	return 0;
 }
 
@@ -279,7 +274,6 @@ static int intel_qep_spike_filter_ns_write(struct counter_device *counter,
 	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
 	bool enable;
-	int ret = 0;
 
 	/*
 	 * Spike filter length is (MAX_COUNT + 2) clock periods.
@@ -300,11 +294,10 @@ static int intel_qep_spike_filter_ns_write(struct counter_device *counter,
 	if (length > INTEL_QEPFLT_MAX_COUNT(length))
 		return -ERANGE;
 
-	mutex_lock(&qep->lock);
-	if (qep->enabled) {
-		ret = -EBUSY;
-		goto out;
-	}
+	guard(mutex)(&qep->lock);
+
+	if (qep->enabled)
+		return -EBUSY;
 
 	pm_runtime_get_sync(qep->dev);
 	reg = intel_qep_readl(qep, INTEL_QEPCON);
@@ -316,9 +309,7 @@ static int intel_qep_spike_filter_ns_write(struct counter_device *counter,
 	intel_qep_writel(qep, INTEL_QEPCON, reg);
 	pm_runtime_put(qep->dev);
 
-out:
-	mutex_unlock(&qep->lock);
-	return ret;
+	return 0;
 }
 
 static int intel_qep_preset_enable_read(struct counter_device *counter,
@@ -342,13 +333,11 @@ static int intel_qep_preset_enable_write(struct counter_device *counter,
 {
 	struct intel_qep *qep = counter_priv(counter);
 	u32 reg;
-	int ret = 0;
 
-	mutex_lock(&qep->lock);
-	if (qep->enabled) {
-		ret = -EBUSY;
-		goto out;
-	}
+	guard(mutex)(&qep->lock);
+
+	if (qep->enabled)
+		return -EBUSY;
 
 	pm_runtime_get_sync(qep->dev);
 	reg = intel_qep_readl(qep, INTEL_QEPCON);
@@ -360,10 +349,7 @@ static int intel_qep_preset_enable_write(struct counter_device *counter,
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

