Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67933D47AB
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366465; cv=none; b=MaKzE3O7DwjpNd2M/Kxvpi76uKP1QiscMgHMT/zeYeJrEXrdaS9DPo6wRTgQPfYajVy3goJC4J0kI866wfEA/cUScOUwHaDL7U22PezzU2Nrbd0cQv5Nhn8SgwJhh3W6SUrn3hjmc88NXLYFceQ/X01j4bAhGczdloZdmD8ujMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366465; c=relaxed/simple;
	bh=tLK+tC6TYxNzQC72XC7IlLuKDEdGi5R9Bse+98ha2BY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rag+4WZ3NWHlXHWLNX1eaIw/PsZ+62zE+nXu+wPkV2EjPMlDdPFfMuE+N3fW4cxNgxU359msQwps+xHeXl7GaiTBbcr+z2RbPBggqAHT/Tk4SkDtspySn5DlQ1XclH2dMmSlj3PGmagbobs9XdDJhWRhB5eaDGbEzLpHDrpJ89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeSAUGAq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeSAUGAq"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d6fbd0954so8511183f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 01:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777366462; x=1777971262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DfVj/tVZK79XYfs9HcZVg9EVSDRHJfiafBzJ5oUzPSQ=;
        b=UeSAUGAqfYJ72SGBUlYxptjP3E89XlPEeDpnlbZGMH3KyWEsr4nlvGtWmf4oeu4u+X
         yQQPcnFZWLH5diS0im2opj3qZ7VQu8h+HJC+eF5F6C1E5Qa99CViAzl4yTdEEC5Agj34
         Ith1pVSjJrrm4owuHbAUBppOpfMa/fa/F7IbvhvRYTPH3HhPk0eUjHvouokYDXZbPJqu
         SXL1NAb2q/0PxUoVRGFMlCZ+1afnCyN9KY/+al6FDZUWN7yOyTpOvkYaGvu8re7jL/qG
         FNeprz7BvvQXYpmTOPnCnXExMMG2FHcwWGcnzOONI7HwAIAIhH5LgP/C7diJKOO7DFII
         8f4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366462; x=1777971262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfVj/tVZK79XYfs9HcZVg9EVSDRHJfiafBzJ5oUzPSQ=;
        b=dqDrxKIlYhe1O92mcsHWq34y7JKSmENueoRg+jCRftgBEPTLUtZ8bPiR4fz43FztTV
         GToaNvL5cvKUd4d+R5jMZLSlUN4Y54hSXTL+ggZ03IrkzZ3X5piCvKeddXoydsI2Zfis
         CZZG1I97c5EjLqHpZFYS/NzGdJYIGeqPCaoMImPzH8F0K8eylisSY0Qifk9mzOe3InH8
         4LmsP1w8OHUAnzpvMr3l3GwKaw/CX5e0tIEn1bkGxaB6tJ4v+OvE3SHNm34L0bW13BEE
         9QgkGOfvX3FmXT+C3HQVoknCJsYGiDqeEXjxU+S86btQP4PzUb+GHQ3gQ1DkBiBkEIGi
         PMvg==
X-Gm-Message-State: AOJu0YwfC8gbybaA6bjZy/NteDB/mqDB9xum1rL4umQzQkM66OiJEYSG
	TmC49YuvQfbQCjvkqm9fmbfwZN9D9ABLGzY2U0+Rgm50UfCppKqoNXN4
X-Gm-Gg: AeBDievCR4AOIvX1MRovVDVIE6SHHXPZoUar7D7KzURYquXsNX64NFVPEgK+iqCX5E2
	ONYX7mTvCuLf495jnq0EfmIn7mY0O2KtI2X8QqicpNT49uo6QDvmsxvyCsTuErkeRoiHE8O7wcH
	aCzfEoIJ06gt/OjJZc+ki7GwhiNM4jHELbHph23QMRb5RxJ7NUIwwH4iknqtg0YdZLug6zGoVhR
	Wz04f110M4wHBDx8ZZqbDuTdmBwOl+Lf/RmTxkeiOcey6GWe3Ryzk+8qqnnHY83ajmtyE9MWdcS
	Tg6UTT24c1duKYv398gJoanM0BNmuaifLBPX+t3pAX8K33n2coQGuWJ7Gp5KMWpwrqlnodb39sA
	yH1kiXL7BJ/S0QthBornIKPFXhCliA8LsBC9W0CQSuvZunc1rzaO2H7KJJQ26kmD3SgXvYhQb3D
	FSPNy5oH9H3GbvwhZ/0EzkRcpntAGTkWEMic0GhJCSB8IaI0sS
X-Received: by 2002:a05:6000:1acd:b0:43d:740:fb37 with SMTP id ffacd0b85a97d-44649ba23ebmr3992554f8f.24.1777366461932;
        Tue, 28 Apr 2026 01:54:21 -0700 (PDT)
Received: from localhost.localdomain ([196.235.239.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463fa89140sm4634632f8f.27.2026.04.28.01.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:54:21 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: temperature: max30208: fix wrong scale value
Date: Tue, 28 Apr 2026 09:54:15 +0100
Message-ID: <20260428085415.52858-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver currently returns a scale of 5 for IIO_CHAN_INFO_SCALE, which
leads to incorrect temperature readings.

According to the MAX30208 datasheet, the temperature resolution is 0.005°C
per LSB. Using IIO_VAL_FRACTIONAL with 5/1000 correctly represents this
16-bit resolution.

Fix the scale value to ensure user space tools report the temperature
correctly in Celsius.

Fixes: 9ee95ae4cffd ("iio: temperature: Add driver support for Maxim
MAX30208")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/temperature/max30208.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/max30208.c b/drivers/iio/temperature/max30208.c
index 720469f9dc36..96f63c4fb2b6 100644
--- a/drivers/iio/temperature/max30208.c
+++ b/drivers/iio/temperature/max30208.c
@@ -163,7 +163,8 @@ static int max30208_read(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_SCALE:
 		*val = 5;
-		return IIO_VAL_INT;
+		*val2 = 1000;
+		return IIO_VAL_FRACTIONAL;
 
 	default:
 		return -EINVAL;
-- 
2.43.0

