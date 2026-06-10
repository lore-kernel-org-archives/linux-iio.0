Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B97E792
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 04:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781064315; cv=none; b=JP0BHy0iz13khJ+pObrH9b5WV2nel8BpniRbGlwcBjVnIiNbiymg8bdlsGY97imst6ABRwpzsNX0RySUSPJr9cdGCo2PLgx8GMqxMwyVXpGeO1W+HnhBBbfMYAF2vAC69RV4jBoFphFzPft5hUUsn3mhowvd1+LQ6+71AJ8su7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781064315; c=relaxed/simple;
	bh=NRBTLiBGF6QeueVT9+dPIAKIgwR6Rf36t1TD9fEkirM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSXBOIjYOGZttB/asMcH+RWyHbbGTZxlTO4XPG8YICLxZs9U5DIsFVauUY1D5JgSMcl8+E9wv0NiSTbH39H3x9VoDEUO/U3XFZRztqC6IwQ5+YV+gnWL6hDvlWVFUf/QhPKMNJSGrITf0mHpkLUQhm9ubqWgbJbTubqwkpoUJts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn54NV7H; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn54NV7H"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-304cf518c9dso7790499eec.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 21:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781064314; x=1781669114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4J5kwNmQpUocJiL8vdtHeu0sq1/6oMdyliF92AEKvU=;
        b=Tn54NV7Hu62EmC3E+IEQmCvdznsT/S3hKxX10UcU87P5+ldrtVTsUgtRERhEylio9b
         xRPJR2iq1iXpxcoFpAA+V8TaB+upiGiba3QaP52WHqr33FA9C4bYgYPY1hmUFztAER4o
         2L+TPTcgqbSiXBrwZXcFjl76JtNlrvyTqQ3weaAYI9qVFVabCZw5nWGV5SdgOTjBrORf
         TLCsF+lZPPEmiFDBwxQbF7rJklvQ/gQntamMPkWDkDEZmggCg01UTeaHBX0VMb5pFrDn
         vEGxg5r/SxStzTKUCGpWXCILHcAX116MTqg99g0+l5bW8CGtn/Lybvzj93/m2KdA6vAB
         hq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781064314; x=1781669114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4J5kwNmQpUocJiL8vdtHeu0sq1/6oMdyliF92AEKvU=;
        b=VyCq5wIFQ1uJJPrvwkciN3jMLfLiQ9vIaobjasAnt/1cvbOxY6JwPVzPs1EF00wOZf
         Te0cDGo8jTvOGos0ZiDIAln8KOosR4Xw/Zrvvh7+5NV6wxsdfTkHzI/2GDGkKXgWfVts
         og5dbJLOLK81VIzctF4QpaPuDpzlMzKe9Z9c0Tmuf1DhguMQaXW4412IPyCG/N9TC3Ha
         VdyWUS8qiiE7qkTy/CMCR6KYzRvzP77yiRWSSe3PGJI8cLZ6wTmyJkwlq5r2+yYXR/4y
         CMAeaqFu4gvnB87tOTtcJj2c/EFjLyWcYtuB1kFk2fGa9pFJTs816n8suShqQLl/eaR0
         ZSsQ==
X-Gm-Message-State: AOJu0YzQQZbJT5cALmdBHDg3IYgVfwWj241tiWrU0MJiTjiVIIZ6b4jv
	z4PZP7R/Hz4Mw7oEKE/1thB7pJky58tIESCT4T3N3qyrjYJK2eRA/8ItJFuccL14
X-Gm-Gg: Acq92OGu9vg/Cpy314kszJyyftcwEQWbS5tAJFwunkdDJjbfhj+pexM9GAhh1A26DgT
	QURijREAgmWAexoBSopo25TftPCslII1B9fx4Pz5q3KJRzi20CMiTlNPu1Dd9vAASHfBqy6kYZd
	e7FnA3M/vHYVQM+IsOiC+mYPl23zCtvwOi9O/Svvc6ESAbTgMHz4M6gC3skTx7LL6Id64MucDd1
	3Z1gStuFCzJxKMZH2rjK5XoNcDhIkk+c8t0P3ArG0NF06jbIh5P80DNeF3c4svrCs/zUfT1JWed
	btG/Zd8P8WK98I+INEAOcj1AxHGNiN/NfYR7iQuUfaUT27xgrjB0tMsRY3LuOuECD0+U3/CeTch
	zNwn/1JLLRW2sE7VV8PwIw7b/h/H1wQaoh3eJqW/D201tFhYnWuUL/hPpp8f3NOPhtsw5x2j7UL
	8KfwtKH+ZuIBx1n0z2d/kfth28cdDQHMzMZIhIB7oIW2dx7dR2uISVlMJkojA4sgQ2lIN5CbuX0
	bDiEClkyaJNNSQ/2HQxFfgMpD29gEQwtLdbeIHPCY30k/ztTsaOM5Sd9tGbNDEdWgJyMEKwT0Vz
	9u1qHYwWS/DltjkgXekyHSBqQAQd
X-Received: by 2002:a05:7300:80c8:b0:304:5a53:7dac with SMTP id 5a478bee46e88-3077b216e26mr13128814eec.25.1781064313468;
        Tue, 09 Jun 2026 21:05:13 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea9226sm23925266eec.19.2026.06.09.21.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:05:13 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH] iio: core-trigger: correct CONFIG_IIO_TRIGGER macro name in #endif comment
Date: Tue,  9 Jun 2026 21:05:01 -0700
Message-ID: <20260610040501.204967-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment in drivers/iio/iio_core_trigger.h incorrectly refers to
CONFIG_TRIGGER_CONSUMER instead of CONFIG_IIO_TRIGGER. Correct it.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/iio/iio_core_trigger.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/iio_core_trigger.h b/drivers/iio/iio_core_trigger.h
index e1a56824e07f..4698a857739f 100644
--- a/drivers/iio/iio_core_trigger.h
+++ b/drivers/iio/iio_core_trigger.h
@@ -56,4 +56,4 @@ static inline int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 	return 0;
 }
 
-#endif /* CONFIG_TRIGGER_CONSUMER */
+#endif /* CONFIG_IIO_TRIGGER */
-- 
2.43.0

