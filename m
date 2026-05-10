Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1932ED2E
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778406631; cv=none; b=GVPnWvdF/NNDbuofO4rPUuxGYCHFfD0qrhapmI6YdmL17TREXh9vLAp8TEn2OJuZA6eBjornHkC9rNE3djLQDg6gnHD10MO/qjJjXRuO9lA4UVi9mVE07jnvbAyM+xZNAeVN5DCbZI8LGJKbvToMQTmdNQb6t75P7uoPHV6J+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778406631; c=relaxed/simple;
	bh=YLHPgK3pUAPlY51BqL6HNw4pwuJLemrMc6wvzb0DoaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p9WYlTPlHGqbEthkVKcxjLfCPNPYDRRJiSPIyh7wW2mkdt/3KpuMUaH9l5q18QT1Nb1WX535CD8K3SnMlkZ6ZHmJAT2QOwoZr+DXxkhSSpVQvto9q0NBfWQ72AT74FnCovGrozLscHXN2180Gz0cHO+mYSCRKxhOhsL0yF1uEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmtYPVyF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmtYPVyF"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48a525dd2b5so3428115e9.2
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 02:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778406628; x=1779011428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2UZfHcaRMhvdDu2UoYQ5a6aaE5AUxZFKI7bieKAj9Q4=;
        b=kmtYPVyFJZdnxil6Cz0p8iSWhtd0oBPh6VAVG/7l3BVnnMtl6CyEMYrqzxsVEOG9CG
         gxvAlSUWXEAk3L9/xGSgiw50uvNWcjw1FxIyRgXCt1HccGJu8bhaeiRDPOzgCdCT7U0z
         hKhvV3AUJJgyz++Ob17dLdHFqK7OVXiG1AvCYDWE7hZalUHPPmdW3wCnhEjxCNnPlQYB
         NvFV633IICygxLqG1o9IhRC2ZQoLhk/motltgi321t5wIbbqoqScvdupmyRKP/Zfx6DG
         7xFIOV1BmVGjryaNQJZg4gUpTrl07SonFIsht2EYMFdeTvRUWIULTltwSwQ6J3DGfYYS
         nhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778406628; x=1779011428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UZfHcaRMhvdDu2UoYQ5a6aaE5AUxZFKI7bieKAj9Q4=;
        b=c3wes0mFmpoX3oLZK6ekLHSCm30cJoFllM2XGz3qfs2ysvHkol2b1qA2LF4pe6h57Y
         anwjLNcgpVlAqVxOwuqP7wAnTBRSXLpX9EQAP/1ihZacFNhkrRUTSc3Ue9c9xgddmXYW
         w3XZyXtrXWj3XjMegUcGNcbH0JI5TEcF5l9X9kdRO6VExx1zfPiHw2xvXSreBwLr7U3Y
         XlpvPzIeU1ucc8oNO0rgQg1HYCbwIdUijBV431nai5CvvMNgUjrYOYyKJr+CY+nxdlu/
         X3DeV/pEFtS3Ptf0FNLE2I4PNyMXOnWuGMSSqFfbDTqPOD8PoME0ouNnP0A1ZFanT0Gw
         7YxA==
X-Forwarded-Encrypted: i=1; AFNElJ8DQrKOUequY5Pa+pGLajPxGABbErtMjk344L6siKQJlSLqulFjvtvi6lLbMaPxK09aMZlcAnsZA44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32wneuZZrjGruefhCU3+8lmzsRcAAVysSWUsXNcD7JCyvzwdB
	61XwYxBi+MppU+lhqwjafbTw48gpCA9QnnSpR6blN3GTv38qdxlaSNph
X-Gm-Gg: Acq92OFvD1s5mxkp7tEKgzd/xrhVlZFxXm20pizuIElf+YQSE1+UJjPdmlQpNkY6HC+
	Cvsh2mRf3EIYUKrgw6SwYjMiZCMA6NE//euZ3GR4nEiiIThojOs9MC7e+oJbf8+uD5IU2X7K2Zu
	+ehEy7rGPe+n/a2i558CWNAR9E8QcIlkPG2GEVOlPltTA00UjiFYaag43u0Es1AWC6vzKXi0yi6
	S7BSNHSXrZJTE9U+o6/O5vm231cD07UX8h2mbyjZR98xm84oCAmDHFAy5VV2LjoieeNshIaJhvA
	/Iy4T79pH/YkUR9/glfGDqRDkp4Kj4Wn/NBfGx+dIXW5GPCbzz2Lt9S3p9gYXvR87fnFTJ2VLNJ
	s4pqQJCkvJ+P2f8+uoMm47dp6EhZzqcd+NUiS6vyGy/DOyE4kdwOnUXEWT1W6rsD+LZdyb4Hb3P
	sEcxRO7/SKWkld/nHjSvnBuVwgCbU36BRc3LjgJnKwHEQ=
X-Received: by 2002:a05:600c:4588:b0:48a:5302:8ed9 with SMTP id 5b1f17b1804b1-48e52f1574emr150415515e9.0.1778406628229;
        Sun, 10 May 2026 02:50:28 -0700 (PDT)
Received: from localhost.localdomain ([94.158.58.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db1413csm39247795e9.29.2026.05.10.02.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 02:50:27 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: gyro: bmg160: bail out when bandwidth/filter is not in table
Date: Sun, 10 May 2026 07:35:00 +0500
Message-Id: <20260510023500.61036-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bmg160_get_filter() walks bmg160_samp_freq_table[] looking for the
entry matching the bw_bits value read from the chip:

	for (i = 0; i < ARRAY_SIZE(bmg160_samp_freq_table); ++i) {
		if (bmg160_samp_freq_table[i].bw_bits == bw_bits)
			break;
	}
	*val = bmg160_samp_freq_table[i].filter;

If no entry matches, i ends up equal to the array size and the next
line reads one slot past the end. bmg160_set_filter() has the same
shape, driven by 'val' instead of bw_bits.

smatch flags both:

  drivers/iio/gyro/bmg160_core.c:204 bmg160_get_filter() error:
  buffer overflow 'bmg160_samp_freq_table' 7 <= 7
  drivers/iio/gyro/bmg160_core.c:222 bmg160_set_filter() error:
  buffer overflow 'bmg160_samp_freq_table' 7 <= 7

Return -EINVAL when no entry matches.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/gyro/bmg160_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 38394b5f3..58963f3ea 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -201,6 +201,9 @@ static int bmg160_get_filter(struct bmg160_data *data, int *val)
 			break;
 	}
 
+	if (i == ARRAY_SIZE(bmg160_samp_freq_table))
+		return -EINVAL;
+
 	*val = bmg160_samp_freq_table[i].filter;
 
 	return ret ? ret : IIO_VAL_INT;
@@ -218,6 +221,9 @@ static int bmg160_set_filter(struct bmg160_data *data, int val)
 			break;
 	}
 
+	if (i == ARRAY_SIZE(bmg160_samp_freq_table))
+		return -EINVAL;
+
 	ret = regmap_write(data->regmap, BMG160_REG_PMU_BW,
 			   bmg160_samp_freq_table[i].bw_bits);
 	if (ret < 0) {
-- 
2.43.0

