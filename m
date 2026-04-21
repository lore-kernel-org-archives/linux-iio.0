Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948E23A545F
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809817; cv=none; b=JdecXhQyINR+qF4U2l5Yqe6FwGaWCQa3A0g0IBkXh6UfshKv39zvfR8IJgrtQu8iDI4esqapfA31p+7CLqYkYDn4EGjPBkvJdAdRdQULjhdUBtnx1aXFqdbFd+BWLyvi4U01O269pAASzMC5fxOjP+NFwDuEbyt1M7D9YSxybbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809817; c=relaxed/simple;
	bh=6AKe2j+ZTiyHFGANGBS7sRDCWEU5fxVETQ/G5/4Y/NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ac+EbCwRMYwSGjxK9evpdXjvwYomhumbKVgVjHaiyRf0Z5WGWTb3MEv151/Q0LKnJR8uaUJnfWujr1loxiqkMeNIgMteOAY39MN6VMro1Ce2J0rgWq9za7mI3QyK/4fP+DVRcAa5tnianiVDGYzERqriO0TcDtwu21ekY8ZQCjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=XtNu6QDc; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="XtNu6QDc"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c156c4a9efso6395695eec.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 15:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776809813; x=1777414613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIra/b+6e7aLoRcFqQoUS7o9Au+O2oAnllj7azZoDCI=;
        b=XtNu6QDckGMjfCVqkkcnOul8hGw/BupPbDf/pNYKSapjPqTifKpON27oEdkCuvA/fa
         HjYGjXyTkd5y+or7ZqrEsKDjaQuqBlU/w7nLgdP3rN7h84oNcKmzXxiAL4IffCwhtmHS
         YNBAKVbr0tNXIm+PbJn7KPm6tO4fViNsjklB5A5+LM9+VZdqTZbkOKw7bNYMZumcpzxT
         EpH8u0HvbxpKRXO4b/YXtrxai9rf3JvlDp/QaQXkq7RKc6Klde1cSL3jraupM6EZEVhl
         PDuzY4TGvh4dTapMx69GkmUmmBpLFcHD9QAGfGGDJnZqWs7qHV5gYYIRC6UO7H/WL8NC
         p8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809813; x=1777414613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NIra/b+6e7aLoRcFqQoUS7o9Au+O2oAnllj7azZoDCI=;
        b=H4Z2ytrcYo0ZzVGVCH+oz8yt0o2hG7gpt8MkY1SlTxoKoz7RRVAB4UTzLOaWDKzrwi
         uzTmPHNEd1kGhDKKM4PKC38JzwV7OA5lJkyyWPrdQw1cjppsxgXs4+p4UTZgYAEj7VQL
         nXf9/epy5N2VbLnl3OB+0WpXsFuyd9AESh4hkLjdAgIBTcoC0DkVT4ga7lBWAbUUCZSe
         MAqolKE29WjYX2/S7oAaej8GikTYKtgbo+jSeu/EzeSlpFXUSTQme7AmCfe8/OODSoIE
         ztEUue69qqMPj5Ha/ygpITr2w4GnnK4cZGMY9k07KquZVoM0Ud7tEK5BIOs2laPFMGoS
         zVng==
X-Forwarded-Encrypted: i=1; AFNElJ+A7Am5tS7iZGLx25O3+nRuEEXm746a3O+VqsG7bv4b2UqQmD8KOwDDhbEjznZJu+PMhip3JNuIUwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMGt9O9ZD/8yveaE23P2DhZ+cZsUdWMMd/100WLq9ABJiZ82g1
	cosWRhFkPKEXNZ1dOmhfdW5YIE5cH3p8iQTvdzs0qW++7WiU6koPKHofP8tP8qRaISw=
X-Gm-Gg: AeBDievd/wmaqMRTru3c8CaS7vr6Es2p5zMC6M/xFiHyJsKiFJaEIBYAsn07YEmLSKU
	TRxfeL/U+EKRD1ajTuZvOZGNl0mWa3aSbTG00sS3wJg270vAekJcBc8YEK9Labihkmw0IWCBmAm
	ap6TV1TYHgcL8nfpRJqE/5rJycsFD9+9bAQICNih+2/gvcIcPz4oX1oXoRb+PSHeUmHeZY/Nb6E
	jNZNZ7znCn2GsLzKA9Fb5z9sAmZRWBVTe6PF10zaqa3gqWUbydso2m2nG479gYYufeFZSbVk2Bb
	yv/hbxyCFlhxqwnRZpPeZ0h/l0Tmie63Bei2X8oc23UESnwIiAo0wEapxbE/UZCIPztcOkLS1Zd
	erKwdfXj/sQRb+SNy3t8kjINw861pn6jK3voHWpVUh1iTnb6e7YQ7iHjEFoeG1SSmrPicXPxRYa
	I3e4/7zI326PPWo32AQM/zlnmAlkkvzugRDT+xQzBSBUyonM7vJ5xIqxXmwhLCxCW3DnTAeRZog
	W7oxiEkgAf9jvaE0mxVBEI=
X-Received: by 2002:a05:7300:dc93:b0:2da:45f8:1b41 with SMTP id 5a478bee46e88-2e478c1f80fmr10076497eec.19.1776809813351;
        Tue, 21 Apr 2026 15:16:53 -0700 (PDT)
Received: from felipe-ThinkPad-E14-Gen-4.. (201-92-135-6.dsl.telesp.net.br. [201.92.135.6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfef3sm19827980eec.24.2026.04.21.15.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:16:52 -0700 (PDT)
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
Subject: [PATCH v3 1/2] iio: adc: ingenic-adc: refactor ingenic_adc_read_chan_info_raw()
Date: Tue, 21 Apr 2026 19:14:58 -0300
Message-ID: <20260421221629.70401-2-felipers@ime.usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421221629.70401-1-felipers@ime.usp.br>
References: <20260421221629.70401-1-felipers@ime.usp.br>
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
  - Split out ingenic_adc_read_chan_info_raw() logic to helper function
---
 drivers/iio/adc/ingenic-adc.c | 36 ++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 1e802c8779a4c..81ed92f4490cd 100644
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
@@ -678,6 +671,27 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
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
+	int ret;
+	struct ingenic_adc *adc = iio_priv(iio_dev);
+
+	ret = clk_enable(adc->clk);
+
+	if (ret) {
+		dev_err(iio_dev->dev.parent, "Failed to enable clock: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = ingenic_adc_read_chan_locked(adc, chan, val);
+
 	clk_disable(adc->clk);
 
 	return ret;
-- 
2.43.0

