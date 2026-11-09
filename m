Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243194;
	b=TYbnLLksv8k6gAc3smH91bAmbk+tzQrcy6tOtYdaqVi14wpeeSfO9ukDGCh7Q/tKVFU7
	 tlFoW9IGvWOP7HFyN5svo0Y2C6tdnCZ1H17IJpd1izsIhjxL3ZzgYdA5Xv4BAqXIAf1P6
	 21N3KscsxZThlDNx9jfyG4XmBkZXwKQcU5MyF1fMETqePhIRCRxs2WTTIEtBJ+1J6p4Y3
	 lU/KSRkbJuC15DKz1zPM3D/oE8cXGMOYOca0dviewnmWjD3zPxYiLFKdl1DyMS4bBAE3J
	 Jce+tI3sMU2bnWqqxFfAcnjGuMiIrdaD16nHunJDdHlijYHjFW11v4zgL6ctB8TAJ0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iW5Y6DSmv3mo4M8j1f3fncvFLgJhUVoqDVLP18y5N8Q=;
	b=OQAZfc9qHEsOSv/YuDpxkmt2N4YwESNqO4bDQp7VF/m9j5QWxJsynJvvUEkPpalp37q3
	 rlAMgSWyqvTCpRCrx0kH/ToV3WcH75iqQfkwTcGPQOAI7FcE3FaQSgm0jKKWkApz4Qq9Q
	 WFZeCu90BVIg4lCbYvJGNJvmp8cKZB+HE/N3i3z/EU70NQ/zywBpiKiZsTT+QRss++4FC
	 9W/AzFLg9uPSHycPsZbppOm+vPuaFnxSufkCub0UjLTksMwIFWmkyAc4XrvCH2x4R/FZD
	 JjND2+kJuOgxd+Qyj+gRxbIJ92mgZEw8mIqSMCPP1TEVsrqtIbFlIkGuey1gMCaVv/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s4i9hlp1;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC3606EE8E
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09AC3606EE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s4i9hlp1
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso698748a91.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243193; x=1794847993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iW5Y6DSmv3mo4M8j1f3fncvFLgJhUVoqDVLP18y5N8Q=;
        b=s4i9hlp1/qJM1+WFUAFoVfuVvOCSAyZ0m5tykRk8wxkgojTOUiihpd918olM8kox63
         0ZshFTCcqk4sKZg007UaKq/SmZZUE+snFrJKhibDahsUnQP1sbv+uLCfjzpFIA06cfCD
         1vW/UjUUr4/L/yMfQbR7X0odHyUrpGZbov7tvreksP0LpxftS2yG1ptLuPFKu17koZkb
         wIcI6uw268r4oDqG0JyWuXrgrPUJp7fdIOy9qdQIMjtt/AIq1GRXJ+xcCuqm6/8iP9UM
         sVRLqXnoPS/evm3q9X+TIQibNbDn5nEp7LMzQ0CwrBxr1KKtgEZNvCiMOUqmVOA1DK3u
         Qvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243193; x=1794847993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iW5Y6DSmv3mo4M8j1f3fncvFLgJhUVoqDVLP18y5N8Q=;
        b=k4Z4plSQKJB8MIDzeWJ9Md477hAxu5DbkJ/3tEJ4hvc8K4XzvRwMveYXsGHu0UIZzZ
         O6QrDUuvsIxZAxSFcXo7UINyb0WBpbIeR/CfXjiSIpxR/uAeCGtsK5017mBaJN2CShj9
         nkKbgem+LIb6Ndb3skY4oIQ0rCcwiPBNy8F9a4/cYOurkTjkLLlUsh/5t/WeZI23Jhs1
         HAoD8UJHJiEGhd0LAw+0Ml0sLSQKnOZPqAVlYZr+lOhWI/4EeESriznx4jJy1y4EAEJZ
         H+Cmu8vNt4kW6r9YjKSMZeT+4A/cB2Af8p43Ol+VkiB8f8J+bFelUTMe51g3mHDlnqwy
         8eWw==
X-Forwarded-Encrypted: i=1; AL+hErHR3pDIXSsYz2EZsFo84ilDodhXNOH8tWwaNPeGctXz0Hb1h9RmTbMzQYscCBpGE83i5f6+fxze83M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Rr70RM67KidXT9sIj/6OmVso/DgsyQQaom0hCY2btlb6d8YEv
	cIQgjKxiKPHL2VEVHejNCLHRz+PZ0o0TSWbfhgjkjFDzZbJn5bws3ZK/
X-Gm-Gg: AYBFou19eKR67oTXFfYiWfwfMmXI8J+3gTdgfMxdskGVuIkMtjse1VfNDNvhKtbcE5t
	BSUlQdU2nAP0WKy/SIVJNIRh0NMNmL+y+z+2TumJZ79pNcGM0J31GSyUVAHhEvmauHr67Nl/BMh
	GgTretZJSlSc+TArM1Y7vZFHlPjsSzm6PmEdg/NAd1NKaxJyoKoS0PVUtfN7OXLWDnznXbT3p8C
	FNfDc3sK83M+jdTPXEFHJ6I7uwuWEPRq93y8wpaiQI0q8wUMjrceDTKXVQc7imPnn16fcslya8D
	pOqz5njKENhl+p7ynGefnqzX6kGSvfcRMrJKpQoxxL4s9Da4nidoJC+5pL4Gh8oa9ceh3aPDqP8
	4H7TPTz3Q5JV8ysoqf55bEYNcMtWHRQjI7n31LXzMghawQDtpyy+I+E2cAcJl/8+/4xneiPZ6/e
	hPgs/zBP7U4k9aSSmkJiBFvPxouM7CcjahmCzFNJkdWplRu0YK5aDAatsCQzg6bSNcllD2oVMzK
	BcRHnPx8avJwDjNLKnHNK4jb7hLqiBSPf4XCownGVtifd/SatnPFrCVAwPwl7EqxTQBYvMNJQJm
	HmxZ0MhcmopxIfoFlOCEMi9IkjG6hj6IQ9FH5tf6+qxCQU0BJEtXScWCxCuX6+Xov6V3b6uSWJZ
	/+WY2
X-Received: by 2002:a17:90b:55c6:b0:3ac:4291:f569 with SMTP id 98e67ed59e1d1-3b166ae70f5mr249394a91.8.1794243193329;
        Mon, 09 Nov 2026 08:53:13 -0800 (PST)
Received: from debian.ari ([152.56.156.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm6455688a91.4.2026.11.09.08.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:53:11 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v6 01/11] iio: adc: ti-ads1015: use DEFINE_RUNTIME_DEV_PM_OPS()
Date: Mon,  9 Nov 2026 22:21:29 +0530
Message-Id: <20261109165139.30803-2-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261109165139.30803-1-architanant5@gmail.com>
References: <20261109165139.30803-1-architanant5@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated SET_RUNTIME_PM_OPS() with
DEFINE_RUNTIME_DEV_PM_OPS().

This also configures the system sleep PM operations to use the
runtime suspend and resume callbacks, ensuring that the device
is properly suspended and resumed during system sleep transitions.

The new macro also handles dropping unused functions when
CONFIG_PM is disabled, eliminating the need for explicit
preprocessor conditionals.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 0f9244107c6dd..7211cefc731d1 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1089,7 +1089,6 @@ static int ads1015_probe(struct i2c_client *client)
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM
 static int ads1015_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1110,12 +1109,11 @@ static int ads1015_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops ads1015_pm_ops = {
-	SET_RUNTIME_PM_OPS(ads1015_runtime_suspend,
-			   ads1015_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(ads1015_pm_ops,
+				 ads1015_runtime_suspend,
+				 ads1015_runtime_resume,
+				 NULL);
 
 static const struct ads1015_chip_data ads1015_data = {
 	.channels	= ads1015_channels,
@@ -1170,7 +1168,7 @@ static struct i2c_driver ads1015_driver = {
 	.driver = {
 		.name = ADS1015_DRV_NAME,
 		.of_match_table = ads1015_of_match,
-		.pm = &ads1015_pm_ops,
+		.pm = pm_ptr(&ads1015_pm_ops),
 	},
 	.probe		= ads1015_probe,
 	.id_table	= ads1015_id,
-- 
2.39.5

