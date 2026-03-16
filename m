Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8394B3D3310
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682131; cv=none; b=NtcSjuddORjgVEKj33ywM8dCgVvogaFZ73zxHloYrjkTJoEymI+TMDV/x+dmOkZAucTlHjxVWBkRlsO23/LRC0ihtOZF1He2UFGUQrSRJVTI7roSc5mXfAXUaJ2Vtol3w4xFujpd2S8PyWoF5psO/RLU4e54MZn6k97f/6G4ENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682131; c=relaxed/simple;
	bh=W9aBpOKKKFbVV0kdhlOl19pl+zYg7XG3sfsd0cVI9aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCspHNMh+pXsFvzRqReZuS3ehwfB1jtHJf+8oGxO2FDPbWV+yCAVDOGCAtkmAFM8SMFQAXaAZzKeCJPblEwKG6N83bFkzEBPUg22VpXwOneRn6OMDKAXu4yiwJv9n+xfhf98v4rihtPKz26EQZdgpuVFkSXMz+JkzRHakRdmJCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6LS3JwH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6LS3JwH"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8299c75f730so2855141b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682130; x=1774286930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTqhxqJs7eKjI8L59gpNpQ0WCvni01kCG3d7ElucOKI=;
        b=U6LS3JwHSle0Slp5whEs16iMwAehL2EMLy5xMQYaZaZ8JjceZ8gVoKClMMUvkWTGtM
         v7wQVtDjlofFdeAe8aqgsST1/nlY5hwWBjrovHmU4GfSmB+8cdjM0ew/pR3WcuzSg4eY
         bs4/KM0vWP/bk/Um4QnUSdSPj6MSnaRya4glRxIlqlvJPvo01Y+sddK+Y8q6IGtoTpSn
         Q8e2b+v3buNALYu4k54T2izzZxFoEwY9gg1btrj1mzwVO5ftD6mmkCXwAY5TZYlw6dZZ
         ldgXJEh267FgmYOXQ0DJmHW54K2xeY16gAYUxsasIVhUHkX6PN8qQ8q2yMA8LpJFsEaV
         tRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682130; x=1774286930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTqhxqJs7eKjI8L59gpNpQ0WCvni01kCG3d7ElucOKI=;
        b=iB2QRbnJGHaw7hVri7DnzABkjuHYGhRGzXYsfGbaznLqmMUxq8n20Ba36M7hLlAeKj
         QBHa/hq+p60wsMUZ/QdtrEmXB45tbB2CnQVwaEOga4pAndVJLFx/zojNN7+8a1sWuGHL
         dvS3kN6M6giAIsdEHvoNoT/MonvYkSDmy8QJbUgsU5Zn0Opv5Pzw7UlTIlgH45qLWQiV
         2pNWoGzMjcbaJesM9RR7KMrZh1VOTWR3dDQ0lqAe5DNGsrYhGEBFO4Ab11bv5cpfofGh
         UEc3swor59ppazZ+CNGkVMc7eljxz4pt+5+7Jl1VV2TA7Qzuiuuv35wjbiH6j5/bKn7q
         t8qg==
X-Forwarded-Encrypted: i=1; AJvYcCV7F0xez5kwrYAnDR3ekilO3v85+E5Lou0RsKLjLyL6hBUF5artvkkUFFYEuVirTaEi4p17W6HN2Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8jNkuQybqj2HaWpasK44Eq4yXVmz+BD7hmBPUsogQZ5GBjImw
	fBcgP+RvTv4b8D+AJL4Aor+Xq1qIdbu7ZfIg3c70BxS2JCbhjJOsjGJr
X-Gm-Gg: ATEYQzz8iplGxISCEnUmmwUDIFV65PLwt04H7J1m7oC6JtFefntj+c1BiUWy0iu/GiO
	DSG0FvGI/ImzDlfskDA8Dqu34SZOe3mlmLzK4vOtWVhmYluAfgV1dXgOBaUeDMra6B3xHUmmVM0
	+6CU2OR5XrQ2oa3g7DmwBRBDVH/Z5OAUn7o0l8J9a0ol1krw0Hv+/aPKJWkrNNpf1E9U5i9u0u0
	RV1i2p2bhwSViplaVeyKgwxV/aw282cUuDl5cSBIH5lWodXPK5B7yR/+E3Bb0fPy84CsB+Jt8b7
	avRA7npz6JXPopEPWiCKDB5EdyQCkYXqdFQUwlehFMLL8VttMsTcrOrhI4mjaA4VppOVY/rk3It
	ybSYMpHPcPcPqEKsACQ4TFVHdP2xs21zGS0l6be8OZtObGTdVFc44tHaCV4/VwThY1zyEoLZj5P
	7quVs50+aT6Sf0+scab3xIWuR+WQPSonJtmYOVwmqqCilfou3ggCZQuCisNYdLWRmX5aOyUDMIQ
	/TZjLiANXRAzOs=
X-Received: by 2002:a05:6a00:1f03:b0:829:7e5e:8d7c with SMTP id d2e1a72fcca58-82a5605a3b2mr283451b3a.14.1773682129928;
        Mon, 16 Mar 2026 10:28:49 -0700 (PDT)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07341986sm14016183b3a.32.2026.03.16.10.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:28:49 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atharv Dubey <atharvd440@gmail.com>
Subject: [PATCH 06/11] iio: adc : hx711 : replace deprecated iio_push_to_buffers_with_timestamp()
Date: Mon, 16 Mar 2026 22:57:32 +0530
Message-ID: <20260316172735.11430-8-atharvd440@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316172735.11430-1-atharvd440@gmail.com>
References: <20260316172735.11430-1-atharvd440@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_push_to_buffers_with_timestamp() is deprecated. Replace it with
iio_push_to_buffers_with_ts(), which takes the buffer size as an
argument and helps avoid potential buffer overflows.

Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/iio/adc/hx711.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 1db8b68a8f64..e3f415b5e2a2 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -372,8 +372,9 @@ static irqreturn_t hx711_trigger(int irq, void *p)
 		j++;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &hx711_data->buffer,
-							pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &hx711_data->buffer,
+						sizeof(hx711->buffer),
+						pf->timestamp);
 
 	mutex_unlock(&hx711_data->lock);
 
-- 
2.43.0

