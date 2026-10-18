Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C815A455626
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792315684; cv=none; b=EwlPLUzWpY0r1l9Gu5UcSXlGxa03ObJAdjtDnDaSkf1ADnaY/IYqtyvelZekZh2+fx9sZXYPgxwFvI/lAdv3MtttMGuOK+NPGPkQmWAQZQTOZEwRe0rKo6Sy4E5v/U7hVunPj6c+ddEwUzlKj7bD1WPx05Ka7TQiTsLHhOPYDls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792315684; c=relaxed/simple;
	bh=zg95vLfihPyluNUmN9wHjCiqDxcBF6RAVkaymuHBbMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XP6y4jc1CSG0cLInX2ppeMlQTFXTUmVWtlB+V2xkboSUUXEbfnQru/ONvjrI9D7ZrHgW6pVsS3Az4upeB6eut0yl2SCfenPHh90dRISuui9WnY5mB+WhxGTH7uShFi+hCsfn9lvkEj4WC9H8qb1UoHPF/7lg/IAq+i6Ze5oHfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED8IRzGF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED8IRzGF"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso777787a91.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792315682; x=1792920482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JSekHcws2Pk1pfnhpXYhJN9WJ46iQlH59bEeBjR4wUw=;
        b=ED8IRzGFmgROJWFwYkswF0BZp3+hqBIJfM2zpzPbAI5e4rcfdg4cXTbnVDiZSwAh9h
         473gFKlFKA3YlscFRy8gPU5q2gjJUGyldeN/4cSrcMn8T+N5RqwVflnkupmyz+WWJ0j6
         x70smsuBtnJOykmgiR6p3NMK99Wioad4PJ9VwIny+UtoUUcUULOQZKm4WcvU15KRMxgh
         HqBCBUiUKSQjzYR3Gp6SvU7pxkkN9uxczTD5sdDR7hB8XjMjznrcOtpI7M6oISqrqWgK
         HMPCvRgqP7woo/l1BMhwlYIg7pj9/NsGPK8xB59NO09UaU/kabWwrHwcteyrWd8IA4oQ
         Lf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792315682; x=1792920482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JSekHcws2Pk1pfnhpXYhJN9WJ46iQlH59bEeBjR4wUw=;
        b=ltKDy9Vzuu+0PB6eVMkA4dk+CkFCx+nHxdGtr2xQlDQZswzTLQ5VNz2ECRd33cvTTs
         ccv1Ksoo1K+5dXPaaCGkdKMY1AOVaBSwxH3UXbYvXWxyXBpzpHNEeuV/mluhppwHzmim
         V9oi61ZwH5DbWj9R7yonz0MM1mx6KWn6fUQYM3WtHrqaC0GhrTiIQOLrGyBM6jG1BjxJ
         Mkc5agPpe9RK1+ucNNLOhih/KoqDZf0nDpaV+4h6e1QnhGBRm0KkIRuAi7ZmHQgHj4t7
         d+v7QyYCiQpcw1PpQ2sQLLqej6PmxfeX6TJRkLFboLi33oxq2pOucQNhuVfu6OIaru+2
         BeSA==
X-Forwarded-Encrypted: i=1; AKwUvBzlU2lfGlAS2VyJlCAuv7m1dIL3Vaufe0wjpQRU2XbAfX6p9C9QLzCQE+EHZuK0TfPX1/n3UreY1wk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ91Ldh9bZGV3fgK9+ugnKBMTgaEYDQLfOt86HGvB+ueg4hW8He
	sk3k+a1/J9hN6g3VZLtyZSXBap1tJo3etIx3ybiZ8TvTdLvK7GxEaprj
X-Gm-Gg: AYBFou3PqMoZjtnh99sgQkyZ096smYfPJTRv+1blp5LqCAF0aRt9RgwT4VjPDZQB4jR
	w6dhL8EAt+U3SU1m9oCCpsocxEjs2sUvJxZXhY7xSUrp8lLVbeE9NvA09jMg2ghu9g7iXIBQNiI
	qSN0ANFjWV9n6gDNJMsRB07ffH/L9fRPxh7ytpvwOosq4YqTBFZwEFLZriNbhR4MmuaSkEqZPw9
	x8IxjFCx9odHBycPVIKlz8kBaoePbL5znP2y9VucFzJ4M0tCoBYgXdMIMg9S9DZhidUr5xTWuho
	ypKZs01d8ALL26abUNuQ+rbzDKxAeSPfXSrqqRzlkaomrMKvzN3mELYtC4SXe2IoOgoCPDuHaK/
	IufMQ1FTegoUwa+Cdc0CsITIuF4oASZa6vnasofudGhr0CyEmZhUahLikhx7O6PDTfTZoUBbY2A
	Jcb/3A5IL5GlN/dn9MQgrJMNprXo7FcN/g4iftaVcE0/NshT4pyqCHcpXYDfq1F+o8XWz9ykurv
	CtgoZCNRBV4SKof5eq6grvZq+jf38PD1GSYb1CcF1j1KZ+XptmEYoxIpIjc98rdS/P3vmsRec4w
	Tn7lG6s=
X-Received: by 2002:a17:90b:17d1:b0:3ac:96a3:77d5 with SMTP id 98e67ed59e1d1-3acef29b9f8mr3781968a91.36.1792315681941;
        Sun, 18 Oct 2026 02:28:01 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e74bcsm16568217a91.3.2026.10.18.02.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 02:28:01 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: osf: keep the RAW cache current when the buffer is full
Date: Sun, 18 Oct 2026 18:27:05 +0900
Message-ID: <36f5bc0a26aadf8f2208e6423c8a9847568ccd3d.1792315003.git.kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A full IIO software kfifo returns -EBUSY from the buffer push. The
sample handler currently treats that as an application rejection and
returns before publishing the valid sample to the direct-read cache.
Consequently RAW values and the last accepted sequence remain stale
while a consumer is not draining the buffer.

Continue cache admission for this normal saturation condition. Keep
other push failures as errors, and retain all sample, scale and session
validation before publication. The buffered sample is still dropped
when the kfifo is full; subsequent samples can be queued after it drains.

Fixes: 2da37c28edc6 ("iio: osf: add IIO devices from capability reports")
Assisted-by: LLM
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/sensorhubs/osf/osf_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/sensorhubs/osf/osf_core.c b/drivers/iio/sensorhubs/osf/osf_core.c
index 4f73ff5e9572b95e1cd237671f01e149784b92b5..377645e7a8a31c60bb719b7c98e3230f04725f1c 100644
--- a/drivers/iio/sensorhubs/osf/osf_core.c
+++ b/drivers/iio/sensorhubs/osf/osf_core.c
@@ -231,7 +231,8 @@ static int osf_core_handle_sensor_sample(struct osf_device *osf,
 		return -EPROTO;
 
 	ret = osf_iio_push_sample(indio_dev, values, sample.channel_count);
-	if (ret) {
+	/* A full software buffer must not prevent the direct-read cache update. */
+	if (ret && ret != -EBUSY) {
 		dev_err_ratelimited(osf->dev,
 				    "failed to push sensor %#x:%u sample: %d\n",
 				    sample.sensor_type, sample.sensor_index, ret);

base-commit: 6a27f3a7d1063aec5aa3d9370161e850fc3a85dd
