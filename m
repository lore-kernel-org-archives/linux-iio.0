Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B5D2EEE86
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151831; cv=none; b=bNWZRe2K9+Ut0ahJ1cbQ5TM3dTsXnYbdac1UzBF+IFpYJRALoBrjgOq/xM3q90SjMKRK+aLTKCInCYeJGZacV/FBhsFcA3nrrqxru5U9rkEaVo6vSd7Y42P5EBWOkBn3VlGPndjtGmhNCnZ52ZaLgXlWt/AgHqbf5VuACFhup58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151831; c=relaxed/simple;
	bh=umw+GP7VZc1+CqFVxUxcSdGb0+FvPMNpLf5KJaXRijM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z04Affccb/JSelhnKHRgw4oVmjRyaK7zONmrFZ25oSYKTFu3RuqkkU70Ig8EohiQ+B5jLxI4T9ApsF7ovbe1p63oYAM4RyFKPX4LQZ8oe7baHqLIt3MUTIOF3puT3rB75alLfUZSXeNWI4cyKXU84+VNruN02SFu93fR5uhMlhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlRiyUOV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlRiyUOV"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47df6a5655aso292052f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 04:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785151828; x=1785756628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=81tkzjeQAIPKkkYyx1+RQuRGIgi3srno1xvK6g//W0Y=;
        b=hlRiyUOVJNwNl2w5y0NFCch0/Sw3NpdACCCqpKoGu6wIgVVgds+Ih0AP2iGcHs43xb
         Cp7ZvqjJO7J/wwvps+gOqHNJ5WUGWtx44gigKEgQo0Iodhf3BaUeQFsdcrkYL1ZC5yez
         FTbxWHuU0srVLWhO6LYnEmbT+/oyYxeu/2xvyl0mcxWgcRmwaTpmbzPXdDdeu1WcjH+Q
         R9PcJCHudIPjiv+YfEisRjAmIjKBs+BPc8s61N9/yJXmiC3D/awvOn60AV1w3pa87xTY
         8N+8ch3iLN7SGgrR17Ra4mU1rdk8YS3BQE++T4/QlwISldYEGrAZDKpDGoRnM30w87ON
         czkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785151828; x=1785756628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81tkzjeQAIPKkkYyx1+RQuRGIgi3srno1xvK6g//W0Y=;
        b=jDhl50t5kPw2EDbUi3l3xCHXNcFqhvuEKdKbHKRMb0LlzXWsiTEHvxoAqpW0sShrw0
         3itkdfDr+AvsexvSx8qQFt+zmvEnudb+509jW/YuFQCXpYHFd9R5UUTulWZWT0vlPdiN
         uSg4LWMovJySwrHlUMvbDzPlCCdjjzgVhO6eACH/5juSEpWS27DfOVhRImd5z13cx24m
         dV7Ou8tuRYPVtgOmUUI6eDOJApNE2CQHPdUeumJosu3rfrJIisr+Nj6/90ojG29xsw9V
         LmZoxymvisDpmXLeu6NnfP/z8lV8mizjTcGu3ONUxx6kkgBhkys36U90bxwhNWH9A0KW
         XTGA==
X-Forwarded-Encrypted: i=1; AHgh+RqBbRGOuosTPeV4eWqyG7ZA+8SFq/ZuFq0X0uXn+k59QI4afWHkNUVB7cQis0FvVInCleKNLobhZSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqTf3bdKDB6KZltn3bsfweIVYTrqVSg5S6ZJqVbD6lfn1VL4m0
	tkIxLXdR3AHN2/CAZFnq05YEdwY3Xt6zDRFe8/QqsIouAtTf7Kn8mzrXRLwQ+NVV
X-Gm-Gg: AR+sD134OYO/0GFU4+/alRGiZES8CvQVRUCse+Z3gadja0nMjXrf4nxS3dV3PukAKC2
	h/09v+EyxsIwMnvo08CfTa8SV7Y6D8iX0uoFC7RWlYwGdStv9lyX9fjsXCWwk7xw0LOheqvc1OI
	UM/JAPQYvUXHzZC8TX9g5mXv573XbT1g2oJ95GQJWZ9QmBhIZgaIi20yqjsOiPYp1S10vLzv3xD
	wAV4VXt4wWGF/jrQAnIIuEZZcvfr4Ak693PL6LoZBuH/5kMXTjlweBFQv+gOutrjupoG2I0gSd4
	1iwa6ckL8K33Rsl1PYPbrErwDHn4eobOTVrFWq9sTe5P7p6wAHF9sx5JWWX4oVfGd/KStpORUnZ
	0omoYo7YfZ0iew4ythfczdxbcGLUY+ymxSl4DrTWU0kAOY/bH5kSfW57XDs/smOz71eSUyr5vms
	FQQq+jssOvGPusqORkZRD7vBjH0gqGpELegcZ4wyz2+TkcsCV92CVqZ5YQzCrbYOPjBhQhVfS0n
	l8ewCdnLcoDEjRuhMpNfEvNsfgaBpPYyBGxjb7z/A==
X-Received: by 2002:a05:6000:2084:b0:47f:959f:d5e with SMTP id ffacd0b85a97d-47f9fa5982dmr10259735f8f.0.1785151827744;
        Mon, 27 Jul 2026 04:30:27 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f9c4fe4c5sm28683734f8f.12.2026.07.27.04.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 04:30:27 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: joshua.crofts1@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
Subject: [PATCH] iio: light: veml3328: remove redundant cast in read_avail
Date: Mon, 27 Jul 2026 15:27:26 +0400
Message-ID: <20260727112726.211344-1-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>

veml3328_scale_vals is declared as a const int array, so
veml3328_scale_vals[it_inx] already decays to const int *,
matching the type of *vals. The explicit (const int *) cast
is therefore redundant and can be dropped.

No functional change.

Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
---
 drivers/iio/light/veml3328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
index 7ff1753925c4..a3c49beee93a 100644
--- a/drivers/iio/light/veml3328.c
+++ b/drivers/iio/light/veml3328.c
@@ -228,7 +228,7 @@ static int veml3328_read_avail(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		*length = 8;
-		*vals = (const int *)veml3328_scale_vals[it_inx];
+		*vals = veml3328_scale_vals[it_inx];
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_LIST;
 	}
-- 
2.52.0

