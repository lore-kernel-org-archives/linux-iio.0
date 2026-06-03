Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05624779B3
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506784; cv=none; b=YZKUzRT52CBaLijnfCplk6p2Rt7QNVTQE3IpZp1ENeA1q4NQRS10D1OyftWumeeds/QARDkW8wDuRYhoNTri1uhD1ME4j3FvKfN4oJ7rDqlSLkw0CMabPsyePtv34UnyKNIxEcOwYubzaZ4n4RpcMa1E1pFA8Lpd06dxjbIfEXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506784; c=relaxed/simple;
	bh=GSbYocIJXOXVrqb+NbfCvTTcwgSirCUeyUueMRCQ9HU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BPdW9coJtPfyGB54FBN8HNnlXjSByo8VX+J0uorYtwAk+SrskoxUDHSzcuU0uI6zdgAQOhMSmVW6vMTwGJfrow7cCiBNVAk1QhFXIyfEWrKCnOx4pJguU4YtZqCzwZ4zKr9w2S5BjWCJTxRxE2239uu0J0y2sVAp58Us8QVSCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vpc5i9J0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vpc5i9J0"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef4223be7so3397868f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780506779; x=1781111579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUXyreum+62zlbSUFK3jy0qamqOYaVsBhQyjVwfcOgs=;
        b=Vpc5i9J0Iruo3BRvjlCgsf/lo3younLwkfGctRMYXETDKc+2N46rit2VYU9IVd0+4N
         6TOsWsvql7IepxBfTLSdBn2/zkSeylwwuDpZzwjBFLOb+rKU3wizDAfq9mg3wWf9E/rZ
         gn0yBtpk5BcJf4QEPdq+0XkLAHDMVnjLzIg4tqIqmBq2x7jQVOyrmoyyG36yexeaGXNe
         vvK34uZiNMrZzcAYrTq5fcVrRqKcYUeb8+yvJ+eow2qAutvSas110uqO+TdY5hrWM9Vr
         L3vUlJbN+C5IO/ZklZUFGJBX7dCFUFXIbQlHntXbJzxLna8MT8CV/axvKl3yYVd47qXD
         BWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506779; x=1781111579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FUXyreum+62zlbSUFK3jy0qamqOYaVsBhQyjVwfcOgs=;
        b=Fg4dQ1FKlBCxM9jhGRVNy/W+2VT3MTZm5uWR0pfwykl6Yk4Ew0ZW6N67S10wOgpkJX
         tFowCHRA073ctF1vLEkT2obnaeAONI9BGyi/er511GZ0l/E8Tji7EOmkKEc6gJ5R3PAJ
         gtB5fb9AV/a+pp0gDVedvO19cegRnVou0bApMI7kf1QJH6OeQcmgVqHTAohEjUTo9H7Q
         x6g91gSKjkIBVOcwXH8/tCkJ6KXi3lcPbPcgMD0tKpPOWMT0/YFwRzRZQOfutvprhBUT
         Z5ZOImprg/WqJG7vzoGVEuogLeurUlitxaKw5oWjoDtoxHJCMiuoucwZVZWNAm4RRBvi
         CHTw==
X-Gm-Message-State: AOJu0YywciIMCekhot7ko522kEOOyz/ESnAKVrWp7PlIq2UE6Nk2WEML
	VFSEAq2FxaPxGhbu6hXCznqsot772N3AlayxsWdWKbSdr29quFGzsEYU
X-Gm-Gg: Acq92OG0qKCWv72W81uJ3TooXFD7PXQAWTVTcBYYUCfBkyY0WeEOBsY4/MchkZ2ansj
	kHqMKSI01wjI6REJMV/8A38DpcQHrW0G5eVaYxmzlA2dT7PcEOr+HTWwpMKWbWkI21RyxlDzmVT
	rFE963tRKXNJXqVKI5Ls1GSp0eEQRh9sjG7X2V0rPTbUxyi24wNz+trb+QisQHvxvSDTJj8Acha
	u8/nvRjA0Kb6Xyr0miLE63YliWlEDXFRMXQ5SIEJm41NADxpCTA9qiwP4dw9/1VnXexjiCUZHXC
	3kAHlkmA7uFiQwygjMApS1OVaCOV5ocsnuk/kGns1TLNV2qfINYQw6YHWbrt1Toc0x9RwMxV6NS
	1v4eDkFjmkdkR2GWdlEC5TonAc8TYs+wiGrObc0ZajBYrikQyFf3vCBzmg/oGgZ73DOUlv98e4H
	YgoucwyYuxg6+cOMSHmgrEjxibhjJhNXCW63hz3r4yL5fkaeOXdC67lFEasDUjYUo/V9EeEIkWb
	HidODUDaqcXcnaO6m3U+UieDeX2nRv3jI6lss4K6Uxr8yXQQ2YonagQVkK4mp0ijpbo2WZU7ssk
	IUoekDeerhqmp6dj7bXELquWMDirh5GWSwWkkenIvMg0N4+l3zM=
X-Received: by 2002:adf:ea8a:0:b0:45e:ed7f:1dd with SMTP id ffacd0b85a97d-4602184d5b2mr5379390f8f.25.1780506779350;
        Wed, 03 Jun 2026 10:12:59 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm8797506f8f.17.2026.06.03.10.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:12:59 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 03 Jun 2026 19:12:59 +0200
Subject: [PATCH v5 8/8] iio: light: opt3001: add comment to mutex
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-opt3001-cleanup-v5-8-3ef7b926d555@gmail.com>
References: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
In-Reply-To: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780506773; l=895;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=GSbYocIJXOXVrqb+NbfCvTTcwgSirCUeyUueMRCQ9HU=;
 b=DB9La+IUnianbNfMZUFD0205f/Unj/LbBJDG8Ov4CTLcnHs1vGEwgI2itgdUtrcRgGArvj5gs
 TVhlgADJ7reDCuF23tV36//m8SjU/2zhWcMyatT73sXjUAEJbh1HXV+
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Add comment to mutex per checkpatch.pl report. While we're at it, add
a comment to bool ok_to_ignore_lock.

No functional change.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 44f4e67eed0c..f33889c4b46a 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -103,7 +103,13 @@ struct opt3001_chip_info {
 struct opt3001 {
 	struct i2c_client	*client;
 
+	/*
+	 * Ensure data capture and read-modify-write sequences are
+	 * not interrupted.
+	 */
 	struct mutex		lock;
+
+	/* Allows for IRQs to bypass locking mechanism */
 	bool			ok_to_ignore_lock;
 	bool			result_ready;
 	wait_queue_head_t	result_ready_queue;

-- 
2.54.0

