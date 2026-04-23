Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0D219303
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776907251; cv=none; b=jmQg4te45IjpfsskmvRvXKpG874RvKt8FMhMPrfuXl19w7xRez7ai2uqb47mlG+q2OdN5aNfOwIUATeGxN/piS6nsfpsGShqTrTI/sISr/Zm7mRguNaLKH5vW4Rd5vTdFNARwRot4rfGmMU6FaFDRndAGCXHiPJPldhDgOkNA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776907251; c=relaxed/simple;
	bh=ii1o11+bJleLQbIf0IzWcB8eQPNGW4qwDC6++JDm43Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7q4DN8ziYb9TBS5hLGOIhPfF9DLaDaFNt/ecNIqm/4E6lrWYl75x4/TvPLH1LQ1m0pHoV8MCOsOBESQbro57363CQ+GpHiqUCGQPBwIrypvcps/mbdpmvKSVYEzA7l+V5ukbslwLLpC6KiufjZMPhMO0PKJjdQVzIwOwtgHd5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=KsmppuDC; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="KsmppuDC"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c565476d7so14974228c88.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 18:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776907248; x=1777512048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeSe76m5JOq4TxmOghOzbF5DZ8GPv4in/IzlHhZA4qI=;
        b=KsmppuDCyVe3Z+ma/NmRaoGbOIaEtay1zAycXdEpcmsG1Nhb7BqnEMNw2a6wf/J8Rf
         gmVMKQLCzgTIllPfJYDk1qqjL5A9O1jPKMtyYomkPIklbAKHDQMdgXcuHKYdGZTwcADC
         Z43YmqojBMLSbDucJwzL+qWJFLIvxN4P7AHtX0bJ8gnt8gVMgySI8LQhTvWrh4lphkua
         H+h0ldev98dA47vh59d+NG7H48n59Ye1oG0RFTQCW5ypIZxlJETfHPLU/4w+kE4Ny2dC
         PTv42YvGqzCgZoJLnf0pntWuUhObj9qBs3ijysjkawNHnesx3Z/jq5YIy+2DHX/qdD9I
         TM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776907248; x=1777512048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yeSe76m5JOq4TxmOghOzbF5DZ8GPv4in/IzlHhZA4qI=;
        b=iJQzuGZCYX8iYSozzIV6BCTg+HxDvUJAekKvt5ax601XVRd8WF/l1CksEHE4MDjkxV
         1bWn5Zc5a2RVksY0lH97pIbOk9vTyL3Ih5VvLZIwQMk0TbKc/y+qFVKUfUTpb9OiHasF
         EO1HIz2P4zd0tg6Wy3dKwUUYpEO2RSSJdkZL0hPtdIj2TOee3ZmiMV5ct1wcfkpgJ5BK
         AXg0+1kodmAt6QuSa8yHNKkS1ejVH6uYO+sJC4XVsGBPvLJiw02Tg8fLwJLdkLMsnHKK
         8imjVJlKjqMVyZ1pB1HlUm1trRQWoufufdn3d4cX69/W2+yiwZR4r57aujZRxUeKapK+
         jtPg==
X-Forwarded-Encrypted: i=1; AFNElJ+aF7+xGJKfI6IUoHvomBTmaP8fKhUgUY31tjDjqZ979qU7zw99v+kXSU67tOeY/G2QuUBy9jtz4Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu1ZE4s4dhosVqeDDredcTQLckvIHWu+/b4RwTNfnkPx0/xTg8
	V7pWgVoOhpLeTwlUyKJ10KKghNP0/G6oP0S1rHB00UKM5e8s/4Z1QSIi2a31B+s7W30=
X-Gm-Gg: AeBDieuK/H7OQcb4WodvgHg4BsgVXGtxU8uuPgXLkECy0F/GQAThIg1vwjnePp6NCIb
	97l04SJagID48Nd3/7LeQTW6IH+zcDkTqBo/Q5OHk1092DdbgBXJH0LYrauFVCN+oAFfwq6gdfm
	gQARNJeO+v4PYdIRiKuRupnmHOPN6p3BbWBGTHWiyvhGeaUg3vdlj6tADnyTkTqEPJhdGq54wYH
	FCkjsKcC8vgJEgDW6mN/fpoiiJYqnJSQ4z8RNVmUTt4rHIuDI6WzwNjbTB7vknpbJP8AGV4Q8up
	6/CmEsMEinM9XXWCxvSIZeBeL/zelGpaTj1Vm04ArqPKdzgmnekoqeVodWOfofSUxY/qBdPwSIf
	PE9GmoA1wqPEGcK2vz7iX8QBI+94IBssQWbXk68qjNEvXKtjn+7fEiTtz4h71ETx0lpw2X1EKyt
	FZDTcIfmyjAFVZ7MChHp8Uju9HtXlRqS4RJ4Ovlh0L8Gn0jmR7VLRf+8x8
X-Received: by 2002:a05:7022:f9c:b0:128:d24a:a5c1 with SMTP id a92af1059eb24-12c73fa5bf6mr13388981c88.28.1776907247649;
        Wed, 22 Apr 2026 18:20:47 -0700 (PDT)
Received: from localhost.localdomain ([177.81.10.105])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c919266f6sm18139235c88.1.2026.04.22.18.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 18:20:47 -0700 (PDT)
From: Felipe Ribeiro de Souza <felipers@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	paul@crapouillou.net
Cc: Felipe Ribeiro de Souza <felipers@ime.usp.br>,
	Lucas Ivars Cadima Ciziks <lucas@ciziks.com>,
	linux-iio@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: [PATCH v4 1/2] iio: adc: ingenic-adc: refactor ingenic_adc_read_chan_info_raw()
Date: Wed, 22 Apr 2026 22:18:30 -0300
Message-ID: <20260423012011.41001-2-felipers@ime.usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423012011.41001-1-felipers@ime.usp.br>
References: <20260423012011.41001-1-felipers@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the sample logic from ingenic_adc_read_chan_info_raw() into
a new helper function ingenic_adc_read_chan_locked() to improve code
readability and modularity.

The helper handles the mutex-protected section for sampling channels,
while the main function manages clock enabling/disabling.

Signed-off-by: Felipe Ribeiro de Souza <felipers@ime.usp.br>
Co-developed-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
Signed-off-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>

---
v2:
  - Adjust order of #include.
  - Replace guard() in ingenic_adc_read_chan_info_raw() by scoped_guard()
    to preserve original behavior.
v3:
  - Split out ingenic_adc_read_chan_info_raw() logic to helper function.
v4:
  - Adjust code style for better readability.
---
 drivers/iio/adc/ingenic-adc.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 1e802c8779a4c..ad1b7bbc059a4 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -628,22 +628,15 @@ static int ingenic_adc_read_avail(struct iio_dev *iio_dev,
 	}
 }
 
-static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
-					  struct iio_chan_spec const *chan,
-					  int *val)
+static int ingenic_adc_read_chan_locked(struct ingenic_adc *adc,
+					struct iio_chan_spec const *chan,
+					int *val)
 {
 	int cmd, ret, engine = (chan->channel == INGENIC_ADC_BATTERY);
-	struct ingenic_adc *adc = iio_priv(iio_dev);
-
-	ret = clk_enable(adc->clk);
-	if (ret) {
-		dev_err(iio_dev->dev.parent, "Failed to enable clock: %d\n",
-			ret);
-		return ret;
-	}
 
 	/* We cannot sample the aux channels in parallel. */
 	mutex_lock(&adc->aux_lock);
+
 	if (adc->soc_data->has_aux_md && engine == 0) {
 		switch (chan->channel) {
 		case INGENIC_ADC_AUX0:
@@ -678,6 +671,25 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 	ret = IIO_VAL_INT;
 out:
 	mutex_unlock(&adc->aux_lock);
+
+	return ret;
+}
+
+static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
+					  struct iio_chan_spec const *chan,
+					  int *val)
+{
+	struct ingenic_adc *adc = iio_priv(iio_dev);
+	int ret;
+
+	ret = clk_enable(adc->clk);
+	if (ret) {
+		dev_err(iio_dev->dev.parent, "Failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = ingenic_adc_read_chan_locked(adc, chan, val);
+
 	clk_disable(adc->clk);
 
 	return ret;
-- 
2.43.0

