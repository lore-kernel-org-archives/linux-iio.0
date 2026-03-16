Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5305A2E401
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682295; cv=none; b=PGRL9nPPYQOrCQ/tsXKH80oQpvQvmCE6CouiC+FRW7M3nvvCSK5UbN1nrH1CE6iNKVznd66wDxW0F9ivaUbjZHdWUM1F5URjU/WPVs8bYD0SQ2lTF/IKqCA0GxP7g+5LVco2eUZD2OyOuqWRfWhogAG63HNGwHgGYul2etnehEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682295; c=relaxed/simple;
	bh=rF7xa+O1dKg1J50al7OSx5L2Ivr5slrKdOJx4ofFgoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cRLMH9sv3O+gBXCtP6rNdvQ7Jthoz5x5FAksNwCvgK/p0zgO4dhQFbqdp37/JoUy87hDwvY5w2S/hfDVi5qDZ5IMqWzI8QQPdGMryjoPyxfBWxRU7mDRCb+MC+oYsbQEYu9fyjaEjUBDfJUzbpkod7S7k/CY18Njr7KMROTVm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9HFCFlZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9HFCFlZ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b05761bec1so5420125ad.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682293; x=1774287093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jjk8AiPOpTiKRWlQdLUxjRDsHhudQG2+4LwcnYhGSOM=;
        b=c9HFCFlZI2e21/fYQZNNocpBfRnD8nAKykZK+UTTFY4uCUirgK1skCyDKUNMUOLCpF
         ub0i+UDTDkXGLWWx9HqsdD5LWc78UmB2dOfELP2qzm80HViladX+HGs4p5Gz2Gg8FAUY
         MAWEh6j4FOThoH0L2iNjbjA+CuxcH23XF7TgGoVomyG7V07STJ+v4cXVaLiWL4rgEk8E
         MD/bGsGZuJPSu5VHlkeEwvu5TG+AYJFzl+JBxlC1pZ/mFvABHnpFJfOHvP5ZjIjRvBnP
         XxYF1atkerp6tlJbnyIUoDKfkSDkvJvMBIYxUb6uPvL+1tTMAY4AwxMyC16BIVLCwexj
         ID7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682293; x=1774287093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjk8AiPOpTiKRWlQdLUxjRDsHhudQG2+4LwcnYhGSOM=;
        b=d/Mu+0H2Ise3GTuZayZ3+5van5hbg0LTpLwWcKB+OUsjYscr/YKYITgEucn+zivJHY
         3+KHfD14oxRXNWEVQ/F6fE8Cn08D/yOx9H9XjY2EnlvEJZLMLhClw9XRGTLp5hriOQ/R
         z9OR8bfcZLTwZdkNWLOz9hEX3HKn4ArYPnQoHPHE0hFeQ575wktZI5hbvDMXxFKwWNIU
         2o3qIltWy64gZLKArIHTuYJB6J0Hg535sPG8wel8tWpF0/6svD4/3sKsaTh0XpiWnJq/
         qHJ25HklJftkbmExe6ZZdbww4ULuAexT9rfwA6rSi2xiZ5D0k7QbdirIqmWBTviuVjhg
         Zpsw==
X-Forwarded-Encrypted: i=1; AJvYcCU9FaQCdWt0Lr5eHukpj4bPIucfyDK2+aCrcVEegzcv74xXVSVv6KwvSopQ6mKziRNR9q0/Kd8r/EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXx/uLdUZFQOWtXO1HEK6gmzehQwN6Q8b9/tOO+oyFvanWhlUB
	7izTZzI2SRW5NOPrymn331S38Eca8ynbIfnmneLwx3yW12KPJnpCUAfD
X-Gm-Gg: ATEYQzxEDH32L4UVadphhbLaLezIwa8WYAQ0/uJYKxXgueyZHevaRQbJLiCeC+Bs6Ry
	fYJZUWAy5Hl8mP1OqSf7cFS/HqsNXrCEa2Vwa1lv90UyleuEB87fpv9Erm8H+txMGWkM506+ki6
	ozo34tq9uSd1kbsMdmcKqiGQzSmKK/tB0jIdXN7N07lnHVRsCLiOEeZ1deI+7QEBnSh/j82gCUl
	WJK8hh1+Jd1c7LwB9cciMu4r8yMD8fzABesRZN91mtW+dJW3QJEC2+CuHhG83tfXjidwWwxd0Ln
	UZWeXRpZttVmHwLkYEUsgd7r4fnYM+xyV9s7fJQi/k5z81E9/TXOHrnGFOwf2C+NprbRwN9GfOM
	FT4thqflkjChrKqHG1gxFxpIf0qtw27QRIO4L/EiRkk5gceqY/sXzxM2MZvxv5iDOwGR5dMmgOY
	qUh+vwcllEKlIEC/YHpm3StnimxAGgWNeY5InKsqrUywn3NQPEPXWow2bmJTlk+GI/Y8wAR6+oB
	9Bf
X-Received: by 2002:a17:903:288:b0:2b0:4f16:22f7 with SMTP id d9443c01a7336-2b06363e915mr3301005ad.16.1773682292723;
        Mon, 16 Mar 2026 10:31:32 -0700 (PDT)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ed9cdsm117046905ad.60.2026.03.16.10.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:31:32 -0700 (PDT)
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
Subject: [PATCH 11/11] iio: adc : ad7944 : replace deprecated iio_push_to_buffers_with_timestamp()
Date: Mon, 16 Mar 2026 23:01:21 +0530
Message-ID: <20260316173121.12210-1-atharvd440@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 drivers/iio/adc/ad7944.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 7722cf9e8214..479ab882edc9 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -532,11 +532,13 @@ static irqreturn_t ad7944_trigger_handler(int irq, void *p)
 		goto out;
 
 	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN)
-		iio_push_to_buffers_with_timestamp(indio_dev, adc->chain_mode_buf,
-						   pf->timestamp);
+		iio_push_to_buffers_with_ts(indio_dev, adc->chain_mode_buf,
+					       sizeof(adc->chain_mode_buf),
+							    pf->timestamp);
 	else
-		iio_push_to_buffers_with_timestamp(indio_dev, &adc->sample.raw,
-						   pf->timestamp);
+		iio_push_to_buffers_with_ts(indio_dev, &adc->sample.raw,
+						sizeof(adc->sample.raw),
+							 pf->timestamp);
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.43.0

