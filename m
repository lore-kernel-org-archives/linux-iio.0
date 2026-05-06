Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92145279DCA
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 02:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034320; cv=none; b=BAl0atTvtVNfUtAAssAIcwbNRfh57IRRqS55Z22P4flY4BPCMFKs2XB+HARBNdyaP2AtA5sAPVEAN8Y3FtNnD9VpoSa8JZwVyo6T7J9FRxywH/dmOygyxC87r+R4wZ4QtBY557p8sYBCshEBviv8UVjMl5V3cT309V2acohTBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034320; c=relaxed/simple;
	bh=37S5U6CY9OuzJ1HXSFD/jSK7WF76mIFw+Q5kHdxMmug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QE8+UZ2y9Ol1qQliYWBwLDr4ST2YbbJBWJk6Wb/Qgyi4O7/h56LOVj0AugqK2CimWAvbg56iwgOJnqwqJl3xek/dmjFOh5hQQX/4Wn1v7U/SuzYmsGIJcXGbG6Y+SojDAEBWJy+DoixIO1XOFocsgggOcR0jDDEEYshTcot+KuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=UGqQRB0N; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="UGqQRB0N"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba895adfeaso6470625eec.0
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 19:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778034319; x=1778639119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcxwFVgZ0Mxzf9TM1ThCp8OFBdfEfB6n72sWT9QuoEU=;
        b=UGqQRB0NibNxK4PjFyvrfIP89ebngjPPCdmn5dfx3HjzG/5woyynbJITGgtA5Px6Rv
         L6X7zDPkeuoustJ4lZO21XpHkFlGmKptYhhMvb3VwYQgMTPa7QionjX2CvHlTF5HqaRB
         fiEmGn8lISZ2LUTWUkzqJ2hZ3PIFrXvv0X62sHbh7rYi/Iw19wkBTun2Pkl+5otSczh5
         twHqHcU16phIByukwpsFYJrLTt5D5xG6//GmONWfR/i+Ru6gFpzLxcMN1GGohyRJ7N9L
         oZWJxotQP4hUmC44F1YDnZVGucqEsJFM/1AUGfgTzqkVsJFFDumZH5TdfxsBtysJhi9d
         R4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778034319; x=1778639119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WcxwFVgZ0Mxzf9TM1ThCp8OFBdfEfB6n72sWT9QuoEU=;
        b=l7MBW0ASbtjKaT5gw4jBxzy1rMDGXOEL88TI0Ais78pEeEDBGdG4vM6+811Tjp3lSy
         NveJeJUe8+FoRNz9WM1sd1E4vnRXtvF6aXg3Vilv2LBKgPKD0YXZXHUxUcnT8gATxzGA
         jMTNUyeXSXET0Z/p30saemG9emyb4+sg4ibp3y821u6nIxD+SNEIR3SE/R6X1WNAtWmZ
         pV/B/J3XUr2DpQQ68Krcq3AidLXteX0ro3q5qmdZepiIjSIkuPMg7CVTa8xcB7oZ/dOP
         /2p0v4reg3DjRp7ZkMQwL7QgQYojK9YsvnA1ZYcelFiCCsGVVm8ZLOm1PsF+i8FjUxv7
         IYBA==
X-Forwarded-Encrypted: i=1; AFNElJ86itXOzsVH0X6KbOgIICoMUe2BrQR882OjHXgkrrPs4KHDG1Z5N4a2mxGVMN8x2jUhs97FXof/1gA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4ebvRLvOJJKFr0n+XReqC1HHOyLHqVk8vT0M+FSs4lK5RqZV
	hUxg+18slxofOqiRuXECQur3IkP3dRE3wtADeCFGSN1GkI+cmfZ/Hw8lxoVWtkEBn/o=
X-Gm-Gg: AeBDieuyvhLPE0x2/10zcWWT1dc7MKmigKXrQdaMlAHCDLzckas7uzjjRrXjeqULikf
	BR9dQRI8SfXwg7qTl/e2sYbhEgMlsmaJeXFJJXQZ3U6lijkP9Ye477RxXHPA2c2n5j93AZVJ8Rl
	ODvqJZo1lH4ok3XLUR0Padt9BrUkhnosr4HuOkFjab03LDKC+sxolcAkCs3SiDhXQmHI+DWzUv6
	q0O1A7U3AYRgvj9e4SnFNzAn9MqX1chPbX1JiWSd+4jnNgz0+k1zHpzRhxwo8XPMh5N/3JJC0fA
	/dgKmI6chhi869klLNpi7ubF48mJUFc0w1HK+A3PhAlJu7K+a3KfqY7u9PUAqGSCG44onEHefV3
	uW4BlEn8zd0H+x+f3/r2pYaSA+mrWZ2Vbct6FOc6gAq5i5LugOEH1t2tCe3OUb8zlfCY8eOW5UN
	UMu8r7QjvILHscHDp4b/YRX4kDuFGt7+gH9WW5wCUFNj8WbQ==
X-Received: by 2002:a05:7301:1018:b0:2ea:ed70:3ea8 with SMTP id 5a478bee46e88-2f54e3802ddmr806350eec.29.1778034318606;
        Tue, 05 May 2026 19:25:18 -0700 (PDT)
Received: from localhost.localdomain ([177.81.10.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56d5c3783sm1669552eec.11.2026.05.05.19.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 19:25:18 -0700 (PDT)
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
Subject: [PATCH v5 2/3] iio: adc: ingenic-adc: refactor ingenic_adc_read_chan_info_raw()
Date: Tue,  5 May 2026 23:24:29 -0300
Message-ID: <20260506022454.128169-3-felipers@ime.usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506022454.128169-1-felipers@ime.usp.br>
References: <20260506022454.128169-1-felipers@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the sample logic from ingenic_adc_read_chan_info_raw() into
a new helper function __ingenic_adc_read_chan() to improve code
readability and modularity.

The helper handles the mutex-protected section for sampling channels,
while the main function manages mutex and clock enabling/disabling.

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
v5:
  - Rename ingenic_adc_enable_unlocked() to __ingenic_adc_enable() and
    ingenic_adc_read_chan_locked() to __ingenic_adc_read_chan() to keep
    the convention about the locked functions name.
  - Move the mutex lock back to ingenic_adc_read_chan_info_raw().
---
 drivers/iio/adc/ingenic-adc.c | 40 +++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 231ff8d584c2d..91e3ea6615942 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -627,22 +627,12 @@ static int ingenic_adc_read_avail(struct iio_dev *iio_dev,
 	}
 }
 
-static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
-					  struct iio_chan_spec const *chan,
-					  int *val)
+static int __ingenic_adc_read_chan(struct ingenic_adc *adc,
+				   struct iio_chan_spec const *chan,
+				   int *val)
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
 
-	/* We cannot sample the aux channels in parallel. */
-	mutex_lock(&adc->aux_lock);
 	if (adc->soc_data->has_aux_md && engine == 0) {
 		switch (chan->channel) {
 		case INGENIC_ADC_AUX0:
@@ -661,7 +651,7 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 
 	ret = ingenic_adc_capture(adc, engine);
 	if (ret)
-		goto out;
+		return ret;
 
 	switch (chan->channel) {
 	case INGENIC_ADC_AUX0:
@@ -674,9 +664,27 @@ static int ingenic_adc_read_chan_info_raw(struct iio_dev *iio_dev,
 		break;
 	}
 
-	ret = IIO_VAL_INT;
-out:
+	return IIO_VAL_INT;
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
+	/* We cannot sample the aux channels in parallel. */
+	mutex_lock(&adc->aux_lock);
+	ret = __ingenic_adc_read_chan(adc, chan, val);
 	mutex_unlock(&adc->aux_lock);
+
 	clk_disable(adc->clk);
 
 	return ret;
-- 
2.43.0

