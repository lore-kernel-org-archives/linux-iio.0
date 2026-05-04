Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3421937648D
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886472; cv=none; b=RI1Yb9Fu5VYJDdTX7vaezO/vNhI1hqbbXRpTaNRwcpld44yDP4cRG6tS8OHVl5jWcmwq86UDTQ7CxG4bFJuL3RCcngWZDaL9lVIsakZJeZPKUvuNIecNDf55SnwPDjwNS5IOBpzpgY7Ngy1fDNYywbSuy5kKXckp+LWvEB0I41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886472; c=relaxed/simple;
	bh=ulzqJ0A64mCZb6Tz8JZ5fB2Djo7jXZEPXe3GaCWOvpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEglxnU3rEcSMx9CMDN+JMKYlYIBAfrXCm4ipTO8PTJE005vYbxrX66xECfHuIdvUr+PTVmP2wYvRlPo5JMJZLRINkP/BI/q4k/umXsbbZogBH0Um+0OXt+QVY4M9sMzzM71U1nxuWHwH6QD5Ylo7+G9fJVYkFKE6nCMd9K4AJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2XpaMpU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2XpaMpU"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c801b30188dso404701a12.3
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 02:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777886470; x=1778491270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGuDlYG3EUJIcPBUufNdlUwETr2b6TX7eTkemyWIaqw=;
        b=h2XpaMpU/cplPtVEoDW4+sW/X9GrSJGJ60SiE+Dw/Tv2lgNgeoZsJhCu7iwXj5rsP3
         vW78VwnISx2BgFbayl5atght8PhtvoBg+0Tdqi70EakcFUST0Dy9TCURkQnBrdPJ0t50
         mLGCAdklTJrcptUsc5H8YFcRw91y0T6jP3YmUvq0kT3fAIIcZEP/u3bWjXFywtMCG/uO
         uqEqfyZfKDPoKm4dX+lL3tPFsHJosM4DCwPRGituzzcF8Bx8Z55ARseyngKxT+I2L6HD
         K8KofzJlracEbDaMRNQG4YkyQoqr4UrGj6feG6N9W+0OUI3nBjeA4PFvRiBhUmCmFNq1
         KE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777886470; x=1778491270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cGuDlYG3EUJIcPBUufNdlUwETr2b6TX7eTkemyWIaqw=;
        b=TXwElD7GfksFUk9Q5Wfv+t0BULwhruBi+Lyb/U6Ten24cyb9m2i3lvPm2lp+gvvYYi
         iClh/LjT1IaBcRq50TNFRIHOvPa6b7EO/SrLCzv8tFQKc6gCBlvwwpmMJIvHFqNq+x4G
         0JacBC8yS1XstEUWq0kQmWCbA54zfBPOzP+MDO4z31wsPsxinSUw9yY4wr/8tJNlQUkg
         4FLmvk3EA3jk6LeWL2Nmq5wjtVuLvpr1lP2ZgUI2Ts2JZgdJ9q4uRhXvlGxplkTq65fK
         qC3r+AoMHlKjID1HSLTHwnYecGa2VZodKJRAhbWl547Mz2J1LpQ8wy75vXBCcKfbwN6U
         Pe5w==
X-Gm-Message-State: AOJu0YwSnPtkSl0/dmSSiINvYjJ9T81bgkZmzPV9X+KlYY5fbJVmqcZa
	ezxuokBLWWFKXan8N0joTX7iWO7+z7IJdIhCTgT9x7nISaDWsrV3K5WxSy3ZQVwhLgY12w==
X-Gm-Gg: AeBDiesa7X4/Fgi7CqyFqhpiB69Xe8OIhm8V8rNdzoFjtzCCliz5Iyd/e2g1XRpcvsG
	uuI2RqF0OJvygVnClcnQbfrc8ERoGVnAinI6/dfyQUV6cEcjgm0GRrqBfhsNaswBwB57b+rAoYy
	XMTha7jsATtG5Y2MflPpDexzVHTK6eT5KXOeVQLFkEYITx01h130lV5X4QvXbb644aWT5Ro919o
	OOJUgNe8PfFMpSPWKgJAajEJL7W+B7Jap9I2KdN3NGGajl61Fu67KQp82lBWSqQWQHjINFBql8P
	hE2+i3ciRFDu59YBUG1bo+aU9q32p/ijHrRFnaG4qv/v+cnSkUVeHWwH4WNKb8L3+OsXAhxBz46
	nigBwYEmLFaMcMmJlQcCeGkV/grZE1OKxxLNdu4bwpdA1U9XWLNkqHPcVU2U67rHUDuLq02R1EP
	KWkwVlNEY1Gij09LNZ0YS2suNC+nCXN/52++Tz2Bzg
X-Received: by 2002:a05:6a20:7f98:b0:395:7fb:9362 with SMTP id adf61e73a8af0-3a7f1b344a7mr9071850637.19.1777886470098;
        Mon, 04 May 2026 02:21:10 -0700 (PDT)
Received: from scootaloo ([101.179.98.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c802545908esm4163923a12.27.2026.05.04.02.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 02:21:09 -0700 (PDT)
From: Angus Gardner <angusg778@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-staging@lists.linux.dev,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Subject: [PATCH 1/3] staging: iio: ad9834: simplify -ENOMEM return in probe
Date: Mon,  4 May 2026 19:20:57 +1000
Message-ID: <20260504092059.1536094-2-angusg778@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260504092059.1536094-1-angusg778@gmail.com>
References: <20260504092059.1536094-1-angusg778@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_iio_device_alloc() failure returns -ENOMEM via a local variable
unnecessarily. Return -ENOMEM directly instead.

Signed-off-by: Angus Gardner <angusg778@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index bdb2580e29bf..f2bf7123ffcf 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -389,10 +389,8 @@ static int ad9834_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, ret, "Failed to enable specified AVDD supply\n");
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev) {
-		ret = -ENOMEM;
-		return ret;
-	}
+	if (!indio_dev)
+		return -ENOMEM;
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
 	st->mclk = devm_clk_get_enabled(&spi->dev, NULL);
-- 
2.51.0

