Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF03D0936
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051566; cv=none; b=Y6/1XWivt7hSTik1uwOQo0LFOKVudLh+ijCexeWei3Oql45IcIzuaoXdnqdcALwr3Pe/c4YxPHSXahi37idr7yKEGB8Mg4raYXRyo7qIoJ718PMO1t9KziyPlBaS6JCRWjdG/AS5X0ETu1Hm7Ui8cjWZcnyZq2uiGKYR6rTHSzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051566; c=relaxed/simple;
	bh=BzKay9Zrgr8HUXKy/Wnq91DkIwvyoKa451n4hP++RhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cH/zeqdJflKcvAfDYNmmoAWZ6SDmZ3kCcnXkYBXto+6X18pZmX5O2qYWwG19fNURl4PPFZE9jYfoVAsrDqbcbC2NKKPCfNP+9RmsRDYEcFrK8eFofkLXhTglIVvRsQNXAQuzGmSnaxtR0oEAveNXYMgGZ6yo7JvCJUogY/XezCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE96DDkw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE96DDkw"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a8e3849de7so1528615e87.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 03:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780051564; x=1780656364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UilomXHH4waqyt5qI9rlYVpSlWxvQ+5JxykD1SfQgw8=;
        b=gE96DDkwmsyBQIhZSOLojF/cyIQYToHk54Z5zs0HukxE+gQCr0W2psTL6d4xFd5iTL
         5pGVSCOlLAa2vvqvgqqFCHM9s/dypvOkVAfk/MxgC+1mCQxkPRACKHgv3c5xNGfp1YPV
         fXmB1ptwLHONtZFchkxNK9neXFsKiqatiWR3mh4qYx02tgB9Q/QJYm27LMkCL/HWAcLF
         6UffA8DrEllrUxZG9EYDEGU0EVXLgLU3Jd0xgM1RPtiUSz78eI4jXLRJ2m5hgZRm8AiD
         TDLBQs4TeO/UOqYtbde/IM4P8FkfEHiU7RvcE2cn1MwjMq380zml30wBc6+Tp+XD2BQX
         h6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051564; x=1780656364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UilomXHH4waqyt5qI9rlYVpSlWxvQ+5JxykD1SfQgw8=;
        b=ahnYqcKXgqDggW/FWquWXvLVqJ2L8UQaLjHYttHKYl0Cp38tXSRinXk9pWzJPzu8HD
         NPH/ccpGR+v9utEreDMEJ/OgodZmhCRkw/0mogtavWOKQ0Svolx4otLtIPbZrFeg+oyE
         FSohGrtEsSwFp1Oj1jb9nJoiddfQ5IpKMXoZ5dEH92dh3/X2rnbfCPu0upRY+hs+HFfn
         1reUzsLREzRWM3kGtERjwgbF+oTm5T5pDZON4/DH9BMdtu9ehIQL5Aw7pZNtPsayJenm
         WiBXX60uCgziJCu/cjzNIX0EVBUrlOc7L/ks7fEcVs/tysU2SMJEWdcbwFpfp/2uZZ/6
         tJmg==
X-Forwarded-Encrypted: i=1; AFNElJ+ggt2t7Qq59FPsgqEjf2KSVKHbIcxzcTwDts1WTYSOo9Ut2W9QZ1l79HGaileKe1DHh32MRb1F8XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9ct6ahtAWRtpjxHczB6ecmGutelrClI36KfZYS8YKIU4ppN/
	hYiW/3P69mVfHI4qbhnN832pk8gHApg0cqJQ1E2EE9vNWZWFW3VMalKD
X-Gm-Gg: Acq92OHps9HxllxW9/u4vDjnuWdX27nibzJ5n25GB5a0/VlXR0RztHAQ/DsTPe371R0
	MZZb2RQOBRwARLzZBS6+oMR5PyzQDkFX7vkB5tzGqm67jlvDZFZjYSx/LB5KcBf2eneOq+WLFF6
	CAfIeYJhgLAl5l1OJtrMpaWuDRdfmOeGtmQNADY5wECcL0iNrubZWOvpCkHRrLxqMEMqSJWm2yl
	pydwol52PY5Y58/tH8m2OmcKrxtNBIeGZw/og11DKWOlsLZGznRRTz4Lm146GN9t/uMzxF0wrw3
	Um4VAn6hhMuEUneAHPnmM78GDSOnaRk/k3UfTuia1enSUTT3ZAuc/X/jPEvIgZlutLW/QP/ZD4+
	nOIKowJ3oMSkk1nXqsk6DEsCoTS8T9Jq1eh9S54l4ssq2XbRsEcJzCdh4SKykkDaIX0txfs+b5z
	JOGNLunc8IJUSgwKrIjupN39VY2vtvHSVFzWnT79xTHkP9s/chPv2Bvow=
X-Received: by 2002:a05:6512:3a8a:b0:5a8:847a:dee2 with SMTP id 2adb3069b0e04-5aa5949d066mr324829e87.3.1780051563496;
        Fri, 29 May 2026 03:46:03 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b788811sm192604e87.63.2026.05.29.03.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:46:02 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iio: accel: mma8452: use devm_pm_runtime_enable() to fix probe error path
Date: Fri, 29 May 2026 15:45:44 +0500
Message-Id: <e10c970e911bf68e62e0a58d48b3513f1f947587.1780051096.git.sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <cover.1780051096.git.sozdayvek@gmail.com>
References: <cover.1780051096.git.sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mma8452_probe() calls pm_runtime_enable() and then iio_device_register().
If iio_device_register() fails the function jumps to buffer_cleanup but
the existing manual unwind does not call pm_runtime_disable(), leaking the
runtime PM enable_count on probe failure and on subsequent rebind.

Switch to devm_pm_runtime_enable() so the enable (and the matching
dont_use_autosuspend) are torn down automatically.  On its new error path
the probe jumps to the existing buffer_cleanup label so the triggered
buffer, trigger and regulator cleanup chain stays intact.  The
pm_runtime_disable() and pm_runtime_set_suspended() calls in
mma8452_remove() are dropped; the devm action runs after .remove() and
handles the teardown.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/accel/mma8452.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 15172ba2972c..88ed47d33e03 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1693,7 +1693,9 @@ static int mma8452_probe(struct i2c_client *client)
 	if (ret < 0)
 		goto buffer_cleanup;
 
-	pm_runtime_enable(&client->dev);
+	ret = devm_pm_runtime_enable(&client->dev);
+	if (ret)
+		goto buffer_cleanup;
 	pm_runtime_set_autosuspend_delay(&client->dev,
 					 MMA8452_AUTO_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
@@ -1733,9 +1735,6 @@ static void mma8452_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-
 	iio_triggered_buffer_cleanup(indio_dev);
 	mma8452_trigger_cleanup(indio_dev);
 	mma8452_standby(iio_priv(indio_dev));
-- 
2.43.0

