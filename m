Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81119EAC7
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 03:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770952345; cv=none; b=MFhkCz74gudeRqvUUgptbXlceWOA16MseRoDeRJJQV2lHa0zIM1EJJUKgbCo3jbJXagcUwFvbMR5Dlb7w3XQN46ZUhO09VsoZLw2F/HPQCHDT/trQ3e6Tb0fsBhX7bmVGnUR+o4zXlxiQK+B2+PRN31u2e0WWpKYOzoyc3vxd3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770952345; c=relaxed/simple;
	bh=MhVP+yfzZVMpA8enSgzOkflfggkaNZAKk2dZ+TaV6cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXsoFvLej+7Z9WqK9L75axaAl/nltJioryfb1wdGtM3A1gauUuVk9U9uSLLVkEPiRR2jCQXJfLd+ZeLBOUm4kHbWGiU6F8IkOuwocHRC4vHNVMgUVmTDToQrGLKj5Y53FcdXk0za22nKWyjB3nvH4pDTVGnrVVIftUBAGYZiT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgLHvIyT; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgLHvIyT"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso500821d50.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 19:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770952343; x=1771557143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VjtYnX2kZxkvFSwVFltgTODNPuy1sh2FeuMW80aw76g=;
        b=mgLHvIyT1WM7qr6fuBIHmPveL5y4yJQqOpJ4m3WAGC+248j6mdHlfnW0BknF1FKmYv
         9hbTgqlciMh8Egl9RABfPvuY8+mtmFVLX6bkSyRicyM825bOvn0fZVKyvQEXaf2fUxp4
         b6FBZYm/tHFzMD+IIwVGZei4kh2Uwq4OPDx0rtIZzzWIs5oZuOFP4IUdw0/X5T+vyiHI
         LGuJ0GIyClTI9qu9x1Y29QhkbPYvw9LVK9qGuIkymf3djVoIEC6I6LolNVNrbErjI+NG
         c+aCKmPnGHPsHchgJPuv334035glOqD25OmiRSbjpUlLle+SSUD1/bnz3zQdmOZC+oqt
         qHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770952343; x=1771557143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjtYnX2kZxkvFSwVFltgTODNPuy1sh2FeuMW80aw76g=;
        b=wcEJeEBuGPzvT2eorKO8I4V4AbiPjvWKNnJFh4jPv0nZWLZJsERnnVh6V1dJhUIoZl
         nakPzo4b91Cl6nS/2x77xH9NR1tSnogJdZYXn9CEvAELsaoX/RqDNW6K9mabuYNDGDP7
         fZxoGdeUfOdrHxUJRQ2ntaryNY6ppPhqpsJDL9+AjUG7YXMDxN14iwbM9l44Nh+tk/2J
         X3osnNvyk7O14HVEK9yBMzWvMOLApTsZZ4tgfG7/0nMNczlG9wXc6pZDTEgrYatW02bL
         Yu17uxfRByYT/71k3KAK9k4K22mLm1zjndEjtxSKNYZ1UUq3veDzmhs3svkt9lqTK6Nr
         D+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkXtzw8eAuHC6rpKq2bsGTJqfNBBLtpLiFrEBgLEpszBOWgHaeVhIW2nu/t9ck6WuOwyd1UGmNFzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpnmnv6Naa+uy6STDieP9quHIsWnJwP0uxi/xtduhQgeq7+eVE
	DvM68boIZzRQL4c6QkQYZIsGjM5aLufumQjN84zBt8Anr7LeoYOcMXit
X-Gm-Gg: AZuq6aIRVR0q6XMXPG75EyUZQ1VUrByD4whFAg3XWFsU70hClX1KrbN53vh6dlvhU/4
	wlMZXXRrwdk2omqiLvsZT4OvNrk0QFuPAbXXfYQ7Rkt849OrE5JYXgjQ632jbFjYhKBmExAC9Y2
	A5XFJbmxl4pJ19hjltNlv+bxtU1HQLdqMPknb8CeZIqv/4nqJGt083xse+ooNB3+Ka7Lpn75VPp
	gYS02n36UAZ+l4eq5b/38c77NtVkxrTdwziGI6yoVD8yS/YGmfMgej2KxOKReUIu/4YQxV1Emlm
	faNWcJ7F4p1Zhz0ELELL/wj6zSj4PbkYPzaLvtBR3rGlr4aHABEIsvLjvQs7cKYyt3pMBncij/2
	XVpptOVIjrzbunfxd/mx51JDZmFQYBPYNiCT8ef9lgG9SK+Z/3IeDi6qnF8yOTnpx+t+3obBbyf
	ZyLt4YN2YAbKzylTsATee59J/+6la9LRt6ZfNW005mHQfs0kiOmx6ShrfiylR4oqAfvSz0K7v21
	vcNZov9/2Mz4owsMQUA0Xr7cKPzBWLO83nPw/z+qfM=
X-Received: by 2002:a05:690e:bc5:b0:64a:dcf7:c13d with SMTP id 956f58d0204a3-64c197a2cccmr309031d50.13.1770952343454;
        Thu, 12 Feb 2026 19:12:23 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64afc73fe6asm6209076d50.0.2026.02.12.19.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 19:12:23 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Jonathan Santos <Jonathan.Santos@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] iio: adc: ad7768-1: Fix ERR_PTR dereference in ad7768_fill_scale_tbl
Date: Thu, 12 Feb 2026 21:12:07 -0600
Message-ID: <20260213031207.21291-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function iio_get_current_scan_type() can return ERR_PTR, the return
value scan_type is not checked for this and immediately dereferenced
which can cause a kernel panic.

Add check for IS_ERR() and return early to avoid crash.

Fixes: ff085189cb17 ("iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/iio/adc/ad7768-1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index fcd8aea7152e..f45a09e39367 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -541,6 +541,11 @@ static void ad7768_fill_scale_tbl(struct iio_dev *dev)
 	u64 tmp2;
 
 	scan_type = iio_get_current_scan_type(dev, &dev->channels[0]);
+	if (IS_ERR(scan_type)) {
+		dev_err(&st->spi->dev, "Failed to get scan type.\n");
+		return;
+	}
+
 	if (scan_type->sign == 's')
 		val2 = scan_type->realbits - 1;
 	else
-- 
2.53.0

