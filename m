Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31EF3C07A
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 05:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775884622; cv=none; b=hG5BqUqu+IACXP72i3LW2m/KvoZvVHBnbQHKHzUA2uqxmFSC9rCc7P7Qg3vPskgXNw7GhzRsD50kI8H45PjobnHnZQ4O6UvFvEjj8n9H7H/5HgMsZ9KB9+SQ3C1IQWbfY8IdZWmNHCDL85MDlH9jyoj1fxpczTKDgW6JJXs1QqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775884622; c=relaxed/simple;
	bh=eNvYXNyfnH25I738ukYLk3/PMgne9H5EN6cnapDytM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZyxIylGf/MwPo/Jk81ecWHJYIWQTOyH1dlt22mCi6s6kRYMdvIyC4stKGLW/HHkAW7TF0doE1db8ZPVPOx840kgv+r2VKCn+WJFVpw76GG1rwOuzMNiYM0tV6rNlLZKG1un39I05sjY/PJOn3OxcXK4iJ7RfTQ0jy90cIfSY/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+IlYzvk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+IlYzvk"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso19267995ad.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 22:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775884619; x=1776489419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rTtGG/RUmkrP7K1zIfDszkeojUPTO80nITk7Ob+EURI=;
        b=h+IlYzvkhtXHe1kKmSXsz+ezfv8DKeoTqUbPsGZLh9nHQx2DdgUgJHZQIqVmmEfnST
         OVGFhggwvi5RyFEgzC0zB4Aw68eTa2d/h4Paz2ncvvxNxtdAhgmLZQ8/2e3ubV3vMKi3
         RHzV+S+xhW+cAgEuK6YpsmekoJc2cbdOcCg2q5yUey3gprd3fGYMtWPhjxNUcGm2oA3m
         i7OoFxUqzY01SK+eVdOxMcRHJTB9mlrhDsX3BTgqeP3vwE6xxsU1rsYsa6aevdjLueJq
         hZXjdqS6MVoa63FfQdh/2QjAV+fgDXOqdRVjUeFe+iTaFh2+7eAqhVqQl5x5kX/2jRV3
         0znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775884619; x=1776489419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTtGG/RUmkrP7K1zIfDszkeojUPTO80nITk7Ob+EURI=;
        b=oKyGSFDeW2Oh3JEsivmzR1z+Mn5JLsJn4Ix09N/FPoVcSWNVUd63K0a5GwMUcWoCAC
         k8bLaQDnSFZRMZS62F3asQ2jQdzHt97z4o5umvjU/I0H2UTHy9DRrhqHCmTtSmXSaWxn
         Kr+Jwnf9O+T+u95RkwJ8fV79ysdIH0TOcxuZFRxD4GhNYcB76oNiCBvB1c3N48WS2oL2
         4RZID2VxSKO6lgoz8hbITopzWAjGm/Fa5TA2FyVXPDaZ3x0fcA5VGssbP0Lv9i6DAIV+
         f1xBqDo6noDD8G6D80HTQK7HOYWmTQo3+w3GUpyy8CIpNYbeOeJO8y0QUfaQ5T1GkTso
         mzgg==
X-Gm-Message-State: AOJu0YyqmAasf3QHc6QonJuilzmHKmS+E/LZqEEVckcArbnFlD1cFFWm
	y8H4vaptbazCh4AWJayoIx9TZ7Tg3iDgyGaOnEJQc4JQuxErrhGtsy3Q
X-Gm-Gg: AeBDiethbwaO0V2yqDqbNS9BFDthyroZ23eSgDntWNYo7vKsy4yDVxgRqQeGa+rT9rA
	vE0tQY5gm7Qel3qQiP3JHdbYAAB3G5CaVLw1OET7DFZA6NTdwWeEi9RWlwXF8SufZ/wG4cPh9Re
	qAx0+MrW1Ed9nzrCQgmDfFpGgUwAVyUbFdL6fRUwYvfKbefFRTL3Jt3Qjarf5tp5zULIf+e7HhZ
	949WYFhcniXoZPaEtLo7INpxdx0lNJoJ2nmg1tVybm9Qqf40sw9zWyehJddaT22o3PGVBriZXz/
	9YlEzqVoAKTutkZTdibBEJG7YSxfVq+QK7btI6zpb0+KxBoQpPho8AoyABvw5pRHn3/0JjDuPOt
	ElDWJmGJLsdvzwXZjYQN6HjoWx1c5YlT04OeXhF7AoWZvECuZE58ksSro4q0WFN/obCF0W8rP4b
	nK34Y71B+N3bn3cYbWWmIaAQo8cXCXYuLBxIASpQNRCLSqI+OjJav2W5ko/s99BZ29cignqcucn
	eEUhK8MQxLUkV0m70Rt1eybyLjLgbhCYE8yEaMa
X-Received: by 2002:a17:903:1103:b0:2b0:5a4c:726a with SMTP id d9443c01a7336-2b2d5aa7fa2mr60329865ad.43.1775884619145;
        Fri, 10 Apr 2026 22:16:59 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:c439:cbb3:23ad:5424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dae27asm45701695ad.7.2026.04.10.22.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:16:58 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: ad3552r: use field_get() for power-down bit read
Date: Sat, 11 Apr 2026 10:46:47 +0530
Message-ID: <20260411051650.11949-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use field_get() for the per-channel DAC power-down bit instead of an
open-coded mask-and-shift sequence.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 drivers/iio/dac/ad3552r.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index 93c33bc3e1be..f206bba3a701 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -167,8 +167,7 @@ static int ad3552r_read_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&dac->lock);
 		if (err < 0)
 			return err;
-		*val = !((tmp_val & AD3552R_MASK_CH_DAC_POWERDOWN(ch)) >>
-			  __ffs(AD3552R_MASK_CH_DAC_POWERDOWN(ch)));
+		*val = !field_get(AD3552R_MASK_CH_DAC_POWERDOWN(ch), tmp_val);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = dac->ch_data[ch].scale_int;
-- 
2.43.0

