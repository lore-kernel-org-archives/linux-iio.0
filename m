Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F5B234984
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773530424; cv=none; b=LzK/zmiM5n5OCMqcpDpMSAlFUm24sTQWCzti9QZ2x+CBv1RZp/63O3H0wGgs14s7E+l/XkrBafCsyVGw7fVkMjfnTE/gDZPaQ+66mHo5ue3/zvtejXkSAci0IJnvAgs0BE9J9wJ61vUO6uh1cm4eauEC8bCBee3fY2gv1t+a1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773530424; c=relaxed/simple;
	bh=MrjO0FXfMZg/d7CKBRYNn5t/yugORqehXrvJku1NIY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u0jzt0IC7/s6jws80YftDRLcSPCH+N+rPFeI/vCJVSa1XWGam1/7PJGed2zeCHIAoi0eyEYBZA9lgAp/HSV2xdSgkimgWU2HMh3ZBv4F6HH61+EDAuzH9yuvLCi7zDIBNM34pA1ikvDmM61kQjuN35xpgyyKiQ0BvtOx51ukQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ii9r1Omj; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ii9r1Omj"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d74dbfe84cso2379933a34.1
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 16:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773530421; x=1774135221; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e4AHg3nOSwsDyo6eCizR8PkpBebA82ghrP9qMD/lOxM=;
        b=ii9r1OmjehIWe9QZ5HntrOA5aDG5L5nyqMI7uIAF96nnQ3AlENS+oMTCa+SfUZauvW
         ICvIq+VcX0AxZBeZRqNMQT7X6LQ1GH41DeRTwnkCgAKggDEm9uQzR4pocKR2hp1RMDNX
         6BropmLDTI+YHgcNkddO+phMxS6vYuBAKs097aR/2p4DOd/+CorGU6XQVn+VmmCDwdB8
         0rpXCf6OJwRi+puvT6bzr9C9y03D1cACSUpJ+RjFRzf/EMsYYVPsATwTAf4qsGUQSuNt
         6+GPNV94zCGsLmvekjSJzJJpuwmzOtLgORPUDPg4IUkhtjQImWlNixlHGn8bo+JzUaCw
         n6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773530421; x=1774135221;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4AHg3nOSwsDyo6eCizR8PkpBebA82ghrP9qMD/lOxM=;
        b=tFVloDL9P6+OMC/3jW/aTlc47S3sbRHycadlYSrbDdeeOkmlzbwUN5qPQhM+7BA9ai
         RkIKEPEv+P1BC/+hakw19GdkttF1C5poGnz2d1dkgAxuPjNgG6zDUuzH9bT7oK5Dvg4r
         slJdUga2N7a0AA+3nKAkWdt7zZsKhyZU7Dhw51GanbvnJ+V59DbMnynAeImpPj/s0Mck
         aQJ//NkQ3w0QQCQwdYR2+Twpqth16C/unCFmueInJdghHTr+2YiiPuhDygOhjbGr3ErI
         QN8mBozxGAI5iE/MTFEL+DUwksrvlELvZCGpfipvnZMA027mm9vkplcazuX2G6lwH8NV
         RZCg==
X-Forwarded-Encrypted: i=1; AJvYcCVD3E4SA1O/OKiE1Bq0Q8jHePPYWhcj77NEVXEAgSdViAFZs59X7cwB2YQul78BpYdU1S34LuxKyGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfz7V7oKv7QLMLbc/TjebrNQPFAjJ9ZU0FFM/kttCo9gIj+ej1
	t1eBluh4iEahh6LH+0giRsXoCMFfA7txHCnT2egjR3Bfw1RUYrtzeQ34VJke4sJPGOo=
X-Gm-Gg: ATEYQzyi88cAv0GQrNfwc7N+bphK/5uH0L6PvEfmW9z/pBUUSxPAdm9ebvjus944fBI
	cK56azq0csFYGx2Q07Choekm0NpgDcO79c1nVcwjoAlcc5ucZXnZB8FzRLfPo3ojnNFdFVuKcBJ
	VzeEsZvOu15qpUgiRNfqgwrwrX8NkviC6L4Bk1VbllDdcUQRzQCUe6tRWhd2O/YJWrrys+ABlzv
	SRqw0d1kNEwp+QGof+4UwcBA4WW7byqa9/qru/tyXdA1dfAIR0qfseJ7jmboHKvuuKYHtcp8LZ/
	l4Nldu8YeYTV9gQ3+O//LfehFbn2YWjIoC4/hXxEOOwj3CPkNf1grCP3IdmCAIUISoHYUVyfXox
	c6S03I+p+eP71ccJhKjQ+i71XGfmT+EbTp0zRbjjXwLfUibMtLAcTsjKQPn+d3n/V1334h6PQhb
	6XA1FQZuOG+a6o5+8EHqxp9On81cd3
X-Received: by 2002:a05:6830:210b:b0:7c7:69c8:2d2 with SMTP id 46e09a7af769-7d7824d48c8mr5389508a34.13.1773530421571;
        Sat, 14 Mar 2026 16:20:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f27f:adf2:8637:6bb9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae3a55dsm10366339a34.13.2026.03.14.16.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 16:20:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Mar 2026 18:20:12 -0500
Subject: [PATCH] iio: proximity: aw96103: fix firmware read on big-endian
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-iio-proximity-aw96103-fix-firmware-read-v1-1-c74fe9ccd82b@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQ6CQAxFr0K6tkmHMSN4FeNiHKrWBIZ0UDCEu
 1t18Rcv+XlvhcIqXOBYraD8kiJ5MHC7CtI9DjdG6YyhpjqQd3sUyThqXqSX6Y1xboMjj1dZbNr
 PURmVY4ep9YcmcaDGE5htVLbTr3Q6/7k8Lw9O01cP2/YBfTRIeYsAAAA=
X-Change-ID: 20260314-iio-proximity-aw96103-fix-firmware-read-c9378ce60830
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, shuaijie wang <wangshuaijie@awinic.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=MrjO0FXfMZg/d7CKBRYNn5t/yugORqehXrvJku1NIY0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpte0tu1jeeA+Pt2sto/shylXemItKaN7M2281Q
 ZVkbwoJqmmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabXtLQAKCRDCzCAB/wGP
 wJOUB/9yTw8WjkGTnC1a4cWKTeXVxotw0i7i56GKTd7MwYLp5wg6m7ZbNUAOUyRYKSa4RnQfNSC
 V93Gboo0VBLFT33mOSeF+XPEygn0mk5fz6xWq80VSLFX5GXikONashGbudWGMzAbfbyi9uTETxw
 OJGce5wwgY5wDP7iwZ1mQoAo0pLp+FCuBuLV1fOttbu0PbYUdq0VDBvjobjug4pbFLjMvMeXUZM
 sCBDbFKEKS9bwvNuFht3H/KSvMpCFBvESHo8hcR4jwBjwQXF07tqYNF6ZA6Q5/Sw/zfT4H7BmHz
 0TEif8aubQ5Z2CNtgh5euw6PJbSYEt+QgjQ5RiYoyJcxm7pA
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use get_unaligned_le32() instead of casting to int * to make sure that
reading a 32-bit int value from the firmware binary works correctly on
big-endian architectures.

Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/proximity/aw96103.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index 3472a2c36e44..8263411c06df 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -233,7 +233,7 @@ static void aw96103_parsing_bin_file(struct aw_bin *bin)
 {
 	bin->valid_data_addr = AW96103_BIN_VALID_DATA_OFFSET;
 	bin->valid_data_len =
-		*(unsigned int *)(bin->data + AW96103_BIN_DATA_LEN_OFFSET) -
+		get_unaligned_le32(bin->data + AW96103_BIN_DATA_LEN_OFFSET) -
 		AW96103_BIN_DATA_REG_NUM_SIZE;
 	memcpy(bin->chip_type, bin->data + AW96103_BIN_CHIP_TYPE_OFFSET,
 	       AW96103_BIN_CHIP_TYPE_SIZE);

---
base-commit: ff0843ceb1fb11a6b73e0e77b932ef7967aecd4b
change-id: 20260314-iio-proximity-aw96103-fix-firmware-read-c9378ce60830

Best regards,
--  
David Lechner <dlechner@baylibre.com>

