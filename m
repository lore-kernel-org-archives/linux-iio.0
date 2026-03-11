Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2283E6DC7
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253259; cv=none; b=k/8EXFg/DB/Ru1HOawN4Os6mtMgLfeCZxXSdt/O4dLa7jKpAdILRnLX/WHdyP6g9TiB+PKvqD6M07+z8r99hn0uRXhRDX5f1jX/6s9n8xuuXb+8OSE0Rj6Cu2SOW2j0i4dnk2mPUOHsLYmeBx/r5MN8Xos+3oekPkgoQCNbvW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253259; c=relaxed/simple;
	bh=W6OfwF31b2rGABO9tefiuanXN8lH7OHc0f1rsfmMDmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Doh8y50RK2R2HKlditDfz3K+wSt/7eGwyGcN3Nl38GZ1OgoiWyhHsOawPJeSexajJxixIWwP99j+rLIIl2nGRW8U6DLNiEHlsTv0qKODx50awS7FAKlSc8H3KE0cB4a0XcNc8ZviXksYyR0t9/FkgW0NYzrXtapHUxUN0XFnkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATIijjNz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATIijjNz"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-829a9c03780so191172b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773253257; x=1773858057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HlO23dYidqdEnQaBsJPTg7NR83Kx3suHG/BV76mrsTw=;
        b=ATIijjNz5x0H0jdI7P/U8Vz9egoU5NrKJT3HhNEoYWSwTk7il+1+WP8l93vTGIgl++
         w/PSBtdjoeSi1c0cB5lF4CykQzcrf7zk/Q9wCrqp5Cc+/Sva7wzNDwoltiUwQGLG1P4X
         QmCghoRqe4L+0jhhvmxavuSkubLH2SifllEXL9dCDB9RnZ8HGtK84aY+LxPSWSB8UgGC
         Q1j4aJM+1w0ZYgpXV61IddTR2Ruc3r3wojo5oGuKSU/OeT8I+XigcYFuFE+BeyVfud8n
         G8N2+gJBAtZ+pZlEsmbEYv3S9fwpdk/mEeE9LrO0XAJc/Ao3o5qwKUSfYKL9vJGItTT6
         TbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253257; x=1773858057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlO23dYidqdEnQaBsJPTg7NR83Kx3suHG/BV76mrsTw=;
        b=D4ay99jWqp5AfWHy+FSP6472z0jYJzvUVHquzsknlDFjx0smsrmjSuJ7pJm0btC/ha
         toL/dARB0L9wp5zC+ku+UkeLHWTSgpSZyThoxso9I/JZ0eeQDNJ8KGsJ8IvAjNtzVTsC
         gh7CnNUgAsbRHOgR1HEydZ1Yv+P/o6XB1vmwrsgn2IkeBj08UUUZ2pnma61wG3uYxe2e
         M4wheK0EngIIJnrvhn4g4UkjjHHEmZO3jjEZJtWdTvhtBwY7VRLCTEN7emihJsG7USps
         TEPzLeGplZsEusn4+wJ9MpAMrghxModNjv9HdXwOc0qB35czEW+rK4Czkly3DQ4azyPr
         IoyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI/SMIFt6OsoahPk0K2K0u0daZZxqxU0a5e6tVrEbKEAwFQUs2QvXbYNvA7Sg2xOKgglDN1wnf2b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YziRk50z2wobJBNDFkXzGQquoAG7odVCZTN/tb1FK83wx4G7y6R
	XGPxw10gEwEWYW5ZrGWwamO/pXgsM+4i6/vHZZq2dBq/GonYK3aygKPc
X-Gm-Gg: ATEYQzwpOrRVsRulYQirxj8KLMYJ4AZkI1kffgslOnV7jHHKNcxDpyVHyjXMubervQQ
	oBvQttkyspYLXXtHoUchuCYzDII/mtIaufU103Rm1A1k0EZAl6UBkhQstx9wtZq4AT02avKPsVL
	HxsLQi0PTvqgR2xion7Li66v5kXIulvb5ZtDBIJo3ALUwu2EANLkx+pwZgo9Y8mYoCXdCvqZEIr
	UbBcrjrdKty+IiRyhNNu1O1jyFNdvvvALiBuP2yoKqiSgDQwpG1y2nWJdg7A+2tiGTA8jpdpqUO
	suPi4myiEZtHF/KgSbesroN0nyePBzITi4xj5Q+x+INrWzfdjBXq9v6U6k75sk5aKzD3xAUVyh0
	LJOUixmyH0FrYmDoEHtWmlphNOvHTOJHnR2Cn08AhFS0N83qUSS6aJobpL6I855EuizRycp10oW
	k8tJOpMVP+YtL0RVVSeT2Bp7a34snCnsHW7v7rO5cOzScWg8xZ
X-Received: by 2002:a05:6a00:3e19:b0:829:837b:9068 with SMTP id d2e1a72fcca58-829f6ee46a0mr3360613b3a.29.1773253257328;
        Wed, 11 Mar 2026 11:20:57 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072414f8sm348210b3a.4.2026.03.11.11.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:20:55 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sanjayembeddedse@gmail.com
Subject: [PATCH v2] iio: st_sensors: drop temporary kmalloc buffer and reuse buffer_data
Date: Wed, 11 Mar 2026 23:50:50 +0530
Message-Id: <20260311182050.3467471-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace the per-call kmalloc() scratch buffer with the statically allocated
buffer_data[] field present in struct st_sensor_data. The existing buffer
is DMA-aligned and sufficiently sized for all channel widths, so using it
avoids unnecessary dynamic memory allocation on each read.

This simplifies the code, removes redundent code and allocation.
No functional change intended.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v2:
- split series to individual patch
- address review comment from David Lechner and reuse exising buffer instead of allocation
- Link to v1 https://lore.kernel.org/all/20260310200513.2162018-4-sanjayembedded@gmail.com/
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index dac593be5695..488e2bf6d117 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -495,20 +495,17 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 				     struct iio_chan_spec const *ch, int *data)
 {
 	int err;
-	u8 *outdata;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 	unsigned int byte_for_channel;
 
 	byte_for_channel = DIV_ROUND_UP(ch->scan_type.realbits +
 					ch->scan_type.shift, 8);
-	outdata = kmalloc(byte_for_channel, GFP_DMA | GFP_KERNEL);
-	if (!outdata)
-		return -ENOMEM;
+	u8 *outdata = (u8 *)sdata->buffer_data;
 
 	err = regmap_bulk_read(sdata->regmap, ch->address,
 			       outdata, byte_for_channel);
 	if (err < 0)
-		goto st_sensors_free_memory;
+		return err;
 
 	if (byte_for_channel == 1)
 		*data = (s8)*outdata;
@@ -517,10 +514,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	else if (byte_for_channel == 3)
 		*data = (s32)sign_extend32(get_unaligned_le24(outdata), 23);
 
-st_sensors_free_memory:
-	kfree(outdata);
-
-	return err;
+	return 0;
 }
 
 int st_sensors_read_info_raw(struct iio_dev *indio_dev,
-- 
2.34.1

