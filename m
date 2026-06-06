Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E477C12FF69
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780706690; cv=none; b=Mh3ogkS3gwDysfNCupUmZD2L8Zn4ZwIWhWhh9jpAssMAkxmK3UzelSNFRtzyVQeNIy0MHCyZibieLf8nyJr7S1mB2jMwtchEUNJReg7iY4Qxp1fqm/8tRwY7axKnNq1kWsq3hX18hBJSGRE8P+9b5jeyMQaTkXsdFnmjQaOkm5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780706690; c=relaxed/simple;
	bh=dRZK27N2byQcY1LNOqt6bEGbXPueyY87I0cDb1bEmh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7KgIeV2sm+K8EfWHWVoGXbFfrsuzR4D15kUiPU8ZB9+nT6+SltiVecyeScBZ4EtXebYzTViJ+7dKDp8L6JfkvNsRX5wKKRqaFIRKqWQXOV4L3PigvxVbXXUYdBN97Cft3W52vHzJcu0BWZkQekLzAze1H2BBR+BtJmBrNatm7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5/5M9I2; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5/5M9I2"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7e0b3db3499so19133827b3.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 17:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780706688; x=1781311488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kVxvw0FXwX0MOWo86WK/chtHgtRPUdaNPh5FdNMHb7M=;
        b=f5/5M9I2T2wHJqIH4UKikTHz4DNUjVtT0sizHNaq3w65CzSR3QI0X9rcDwvYsREgeW
         hcoJroCpaqNtS2xgySchbleiAYC/W7OOHITrCAGfrlENSeLEQgmpJdRlwa/2/PKJiPf6
         RWUHzX8UK5T0gmlltMi+Jw54uEhL+0J8jAZ9gsIbaMot8c3kUjfxNlCcUFVIUYCqrdco
         0VAG10MXFlnALmskIHM7eQZHItli+mi2jgkFz0CNd/zYnFQkS2zf+XZERv/Gm6igEDjF
         GMBf8pO5mv+z3bzQ3McqwZRx/bMQGkiSw15P8fsRXaRK3cu+AAizHtrzFeTxLyo4gVDX
         p64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780706688; x=1781311488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVxvw0FXwX0MOWo86WK/chtHgtRPUdaNPh5FdNMHb7M=;
        b=OixJqpWXREXhTCETub20xYSKL2ItRYQ1rqNUF5/1B7S1Sy9WjUb1wz1ZXBSZKGsLD3
         p3e53h27DFhG0G/AFWpNpGbS/P3c0/hzTHp3QxWftpbMIK0DVCg5OqtsspP09CvxVUvx
         JCSpuyS7xtNoIu133Qfo8CTV3bpLjsHEm9B/RkMtNVwVhxY+tcGErxkKknJZhIpfBafc
         cSgras5r/Rm5DY6tQlCIGNSNshZtggq2XsHEqOgPXGEOQkStZuayq2DBAmuVNRfQc04C
         OfRJ3ef+ZuKLKYtk3Uby2buS4yUidWk+3Sd3LrKlwHbvHGAK7jLIkcg9BtR1TG66WeXC
         iGew==
X-Forwarded-Encrypted: i=1; AFNElJ+1abxeeRCp110HviyJ9X7iVGQVQJIU8HFUsfQQ6WpZDDiBfpI47GTbOdv5m19G44CyxUyASqzRuSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGp8kCEU/Us3eA9JwuP5YIKu+jd4NaIo2vd3qXUDDWWfrTUZrC
	mc5MDZ5kc1EKPetTDIxvm+O/FWx/ApJr3tgnggWw/6rFbts6qKPesQhv
X-Gm-Gg: Acq92OEDh49A8KGN00Onuz5PIPzrYIcJ5G+95NDD1yO5kk0/5T2GZX4N0idurFhvD2f
	Ent1/sUj2siYI7dU3wmP7snNktKMF9iJ8F/CGt6FQOa40aIixOwcgt/3BPnS+lFMA1U4xHhXTQr
	/ZOYAFu5g+p7LH9gZh1mvZcLD365HkdL2Rq2mcCpjfHnSUsLyFPRNI7UCoTy8hcvZCDMRax2rTl
	Qot9QjXWUeSZghfTwQf4cpKFk7H0XJmLT2Qw4KUWMV5XpORhLLv/VeMNkTnrXTH7jT4XomGHF/O
	kIE4uHXPToUpVtblrHo2j8lInpsPw3zdvV3N2/P+RBbt39mCghOD2Y4fB+6uqNjZpqJM1eo1Ewl
	MGivXDjQ9EcDDSeJuLp6rolJ0yZjZPJI8JzCl2HVcJS9ZcLwtLOQTc/6TclszcptCZWcehxESFQ
	m5fn8SwyWLeyNrocKUjfxArT57+9E7gu6Sf3gJNtABllRX497l66o0x3ZgiVjvW0rybF6tsPWD2
	es=
X-Received: by 2002:a05:690c:a9d:b0:7ec:59e7:459d with SMTP id 00721157ae682-7ed0cee82bdmr62097807b3.37.1780706687989;
        Fri, 05 Jun 2026 17:44:47 -0700 (PDT)
Received: from i-use-arch-btw (c-67-187-47-172.hsd1.ga.comcast.net. [67.187.47.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2148b168sm58212937b3.14.2026.06.05.17.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 17:44:47 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: Maxwell Doose <m32285159@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] iio: chemical: scd30: Use devm_mutex_init() over non-devm mutex_init()
Date: Fri,  5 Jun 2026 19:42:04 -0500
Message-ID: <20260606004203.158853-2-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code uses mutex_init() instead of devm_mutex_init(), which
is incorrect as the rest of the file uses the devm automatic resource
management API. Fix this so that the mutex is set up in the same way as
the rest of the device data structure.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 v3:
 - Return ret instead of -ENOMEM.

 drivers/iio/chemical/scd30_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index db5cc295aeab..f1f2507c03b2 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -714,7 +714,10 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
 	state->pressure_comp = SCD30_PRESSURE_COMP_DEFAULT;
 	state->meas_interval = SCD30_MEAS_INTERVAL_DEFAULT;
 	state->command = command;
-	mutex_init(&state->lock);
+	ret = devm_mutex_init(dev, &state->lock);
+	if (ret)
+		return ret;
+
 	init_completion(&state->meas_ready);
 
 	dev_set_drvdata(dev, indio_dev);
-- 
2.54.0

