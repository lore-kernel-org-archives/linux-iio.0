Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB73624C3
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892321; cv=none; b=AAYIRySZEZetWuBsKci0aPNVxcITPxtoIN8Rq6l8qIyUatfZaESoxjGV11uITyX3cDNVsMmFTBH4J8etkjTaXFR7TyINfqxOxMso1ehLfA7SmD1wdG59IJVkmP26Dwu2QbZAn3MA2qZihy2kZcJiRpw76G4WIBHbitOgfCKmDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892321; c=relaxed/simple;
	bh=Gt/uar/oIK4Mnuu1/gqNjS5RMsUkmaiTnEqNdPU6xYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LqMtzyMUmnTP0RPtFvv9kOkuhkhkqIss2OpNMvtJ2MjwojVScweNqiHLEbF0v+WHIQjg5XxemWVdKLfK+gjlWjwgWXJAZqUFpNHS5DCnZHVfHIYck//2GfZeqTV6HFD9OiAaDCOU8a+M3n1JWw0gwxlkp5gZQ9vIkQF1zVjl7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Pp6rdjd3; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Pp6rdjd3"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c8ccc7755so5280471c88.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 14:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776892317; x=1777497117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4Z+puxdAQHIEw9u3fWE4f9kOBWFtbBRHFAkLT0CY0w=;
        b=Pp6rdjd3VIkuTJPr3iFcW3EOH3QLAI+NzMeydHJf33hGUa/H36rRFZTlbSm5NY9CvT
         +tbc1+kXeFLNyRz/4U6O04klFMvYZLRQkIjqIdq7QMaKNGLbqpQWvjFqYjzgP3Xe73jX
         Wb0aTMfzj02qE37YuTw8TcyhapzRJC+oSDB0QaVSaqg789PWy4d9+ieWEAGKlgtCU/vT
         F5ZRJT+NWSTTfjqY8wofA+ZlQG69eayu2pZVo/FmQWFr4IYLakUC985GvPilLntGHSFl
         CyVHM7Wjdg0vudp0ucfgJj7/GjbDPmzrZZcpWNlqSuSACAk8ZdtR1CnS/kaX7/IBeueE
         mpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776892317; x=1777497117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4Z+puxdAQHIEw9u3fWE4f9kOBWFtbBRHFAkLT0CY0w=;
        b=J8K+9avSyGbvS/ZhiKoFQ3ehBe+sj1Ctn9AKMQ6L43DOiegDxDgLyiCf9QRWUqmsTw
         /8srWIQtpW3RsnSsM7PpJXW5OclzVYsxMVQp1YFUxr5d8Eij3nXf4jRVx2ah4wOaFimS
         34FLtMSyLCc1GVb/t12tJeJHG+vCqwQXQuj3o1OdikBndOMlK6OtKIK/ua19j4qe75ds
         7so9x2y2LcM88WMPUfL5Uq6+aj3WbP3grYhNQVKkzKy55/irfLItMzPXNw5j6BcG8nQj
         dlo0WuDWE0BoHkoC3VMICAFiv6GKY26rLooyC7ZatqE8rJ0a60tlx6C0r2e2pWAqRb8C
         WbTg==
X-Forwarded-Encrypted: i=1; AFNElJ9YWFAzOiez/wTRKv7o2dmSd31kpUYC/rbAJWzdltikstWIaJ6XSPjs2uNDYdffWjOPGTsRGHv51nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPlFFt3PbhURC8R3ky4JOAiTph4suBWhubioiRPZFf8M8tsr5E
	0BJ3nGN3V0aNS6FAtuteY0XlNDkYRno6CaOBXTmX/88lIIZ5Z1cqYUzM6Gy4QL79IVVsuaigaZM
	0eqRt1RVbMw==
X-Gm-Gg: AeBDies4ZMfqI7JwpHGg6RoWG9wupigzcqq7njfMTA4Z9ifX9SguTQ9mCTXB5FJByyu
	aXfFIlcR5MB1apiBX2lQjXODwphD1Hf5rlQeyXaW0UMuQZFKnmcIJohm7frcdYLTAMeXj+bX6f+
	n17UdKYILTPHB3tdEd77Ln9aIkspWggUV9q2+DYWW9XmjqJCWVjqc/41AKGamEFPZB4v5V6Zsjd
	sClp0mNNPig08Nysq99D1dM292Fh7/+pUF0tiwzA4kjNRDfIT3/XkZiTxM4/2GNndq1KLAT3X2M
	QupYCXwbBcLfPywTIGK8m+KrH1WqIzzVYyHGz17+aMicPFd2bV+GvgDVC6n8WMbyiIAImYrNXsC
	gdIZXQfUW5X6LdIpdNckxWDMElP4DPGxHayMNKGmTGmIhC2DQzDAhuN2DpYlGRnu4M36lOJUGSS
	B+n9KzP58fB/iFbSFm8kmtSWQfVWxUGNCxUQ2Li46Kw1oLR5lp+iwecgQcGlayxXUqXpit1r3qQ
	m31TAssR/MzfFGaT3v4glgjwktZjltdv8dcIRdzMvXG
X-Received: by 2002:a05:7022:b87:b0:128:d375:f1d4 with SMTP id a92af1059eb24-12c73f98f83mr12766707c88.28.1776892317133;
        Wed, 22 Apr 2026 14:11:57 -0700 (PDT)
Received: from eduardo-Inspiron-3583.. ([191.181.58.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c8e837beasm16682218c88.11.2026.04.22.14.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:11:56 -0700 (PDT)
From: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>,
	Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>,
	Christian Barry <christian.barry@ime.usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: mcp320x: Use guard(mutex) for lock handling
Date: Wed, 22 Apr 2026 18:11:05 -0300
Message-Id: <20260422211105.48158-1-eduardoaugustoabc@ime.usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the explicit mutex_lock() and mutex_unlock() calls in
mcp320x_read_raw() with guard(mutex)().

This simplifies the error handling paths by removing the need for
the explicit unlock label while keeping the locking semantics
unchanged.

Signed-off-by: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
Co-developed-by: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
Signed-off-by: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
Co-developed-by: Christian Barry <christian.barry@ime.usp.br>
Signed-off-by: Christian Barry <christian.barry@ime.usp.br>
---
 drivers/iio/adc/mcp320x.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 57cff3772..799756f4c 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -44,6 +44,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/iio/iio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/cleanup.h>
 
 enum {
 	mcp3001,
@@ -198,8 +199,7 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
 	struct mcp320x *adc = iio_priv(indio_dev);
 	int ret = -EINVAL;
 	int device_index = 0;
-
-	mutex_lock(&adc->lock);
+	guard(mutex)(&adc->lock);
 
 	device_index = spi_get_device_id(adc->spi)->driver_data;
 
@@ -208,7 +208,7 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
 		ret = mcp320x_adc_conversion(adc, channel->address,
 			channel->differential, device_index, val);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		ret = IIO_VAL_INT;
 		break;
@@ -216,7 +216,7 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		ret = regulator_get_voltage(adc->reg);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		/* convert regulator output voltage to mV */
 		*val = ret / 1000;
@@ -225,9 +225,6 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
 		break;
 	}
 
-out:
-	mutex_unlock(&adc->lock);
-
 	return ret;
 }
 
-- 
2.34.1

