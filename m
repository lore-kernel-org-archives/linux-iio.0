Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9A53B14B1
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185406; cv=none; b=ob3i3G+gXa2iJ6whAA3Rxs6wHiLk2ASEMnDTbp8QfLFPmoUcm0iUxIMrD60L/HbXQLm5VAd4pli8p3MeFzRQKyMhGVHzOYp0K0OxbsYMFDZlZ43T7EYEngrM/3dHtNQ1n5E06AZGLt8D5sCv+Wsc3ah5B0JpXCA4ChNna/Fby5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185406; c=relaxed/simple;
	bh=lesOIwKd3tI9zi3jgIdmURXcDNocL667YOX64lLdhxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qmSLoprpZ9UWdJr+c5hfcA84ZgND9t6xHFfg9TuaB7N1pCi82auMmNRbsXUjt3bR5RxtUYAoT87MQ+DtGoY2YxWBgkIUfAGKrx1sGLle39vUI0xGT7JRFxnCVzoz1gOL69S8p7WrZCh+pxfLjw99ZIQeVb5fqnZTMFMiL4JVBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8584bbbf2cso5290657a12.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 06:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781185405; x=1781790205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXmHeyUxs/bF2/vwraancEFJ7a6zGFgulDKh86Yu6Tk=;
        b=dsAvt3Kve4GvcxXPKoMq6wia5gcDAIPs0cv1CGpjyzvejLoZbq+qBc/tkOM8iBn/U5
         kPKWnVGJZxeTbwFngfCEAVDBMHn4txi/p5QPqjsiHibDd5Qd+2GigApFWpzCpTI6dRvn
         t/8DK9SHYvbQkXIuqyexgdY+wjdz3VQgyyclKIkJjF/OcBDO6kEbqzh0qv8e6bPYzwTk
         AymW7Uz2HmDCbjAdvKg9LY7UeAZ6mi6/RePGkLAkF0EJDAs6rqW8Pzyn6zncDPoIaNfF
         WsOaiYl2udmuOMXtzGldhUo9rovtQ+/f0kQ5J6A8FotcYTV+tek9jtxe2wB7DSfPT9m1
         H9OA==
X-Forwarded-Encrypted: i=1; AFNElJ8EF70VTy6oBle/q0sCl6I7bMWmX/Fc0u0E72teT/JC0sOtBrndms5V3NFSFFVseoNKI/2hQAgmwjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaESHLi5ao+spT4tTTrGIgszFZmm1Rot1uHOcrzzXh/mJO91gT
	D/7mTq/Fyeg8BriZEvsFJWQo1s8gzLwowGV5i678Emp9LZ464X7w8sBaleBi0Klw
X-Gm-Gg: Acq92OH3MGfGH79GXhMFVMh+FhkI/MudSarwXjKp7RO+Dusau4SWSqdlWoJVFkGQFdQ
	L5ZuWMK3Wp4abmVrzlJYXlZis36cjaTyVr8Y39oGLGHnXrayt7eD34noHPUki++1js1PzWLe6fU
	5pI0gWPTO3J0vo0HmkXpT4tEncw0Jks3PgDs33ck6/el4qy9eGr5aTc3ikaObr2nW0huu90i9dn
	oQOFF72wqQ7ZrEkMPjj1EJWL/tCF4q9oqFlPB+HO1BTrI24R/XP/ScnN680HThBq04pgal/59ad
	LVAFBuqtB2KRBhT5WtX5aNeyu9V1D7/SOqMU4bcIkpA6Lt0ucNt9sP3KRBK8pIT0khxv+zaPq9P
	xJXZE4ZrSqWiqmXuKhgBCUIn1r7rqZEDkAeVurRLO74X5+Gqzkm4a8QL5tQEcHfwzzIukQJ07c6
	AJ4C05FJFQzdw4GB/X1VKzZ8HqKEC4picRXg7J82rcc2ra5bQi9kv8nyOVjKMxv4R4wXkEZOOlj
	RkBUAW24QFS8HM0UIXZWi8qugMJjoa2fa4lOGkvgoQuRfhwbKgoRxg9Rkf/qGVaT9kkiUZ4M3u+
	rJ6D6t/+7MlMOf/QkMrt
X-Received: by 2002:a05:6a20:6a1b:b0:3b5:53ea:b8be with SMTP id adf61e73a8af0-3b5e3370572mr3505653637.41.1781185404466;
        Thu, 11 Jun 2026 06:43:24 -0700 (PDT)
Received: from fedora ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86585b20e0sm1757973a12.11.2026.06.11.06.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:43:23 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>
Subject: [PATCH v3 0/2] iio: proximity: cleanup fixes for vl53l1x-i2c
Date: Thu, 11 Jun 2026 19:42:28 +0600
Message-ID: <20260611134245.30042-1-email@sirat.me>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series adds some cleanup fixes for the vl53l1x-i2c
proximity sensor driver.

- Sort register defines list
- Extract data-ready polling into a helper
- Fix regmap_read_poll_timeout() arguments alignment
- Add field definitions for BIT(0).

No functional changes.

Siratul Islam (2):
  iio: proximity: sort the register values for vl53l1x-i2c
  iio: proximity: cleanup fixes for vl53l1x-i2c

 drivers/iio/proximity/vl53l1x-i2c.c | 40 +++++++++++++++--------------
 1 file changed, 21 insertions(+), 19 deletions(-)

--
2.54.0

