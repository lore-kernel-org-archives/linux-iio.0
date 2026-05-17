Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DBE3C3BF5
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041920; cv=none; b=oRc+neyronVVPvXrGsn1ePaB8o+8lAufC5pWOZsjRjQR7U3UDCZjKYu8mkFxqneA095+vyUTiE42a8ZC2IcmrgbhO8yTr4em1pIzVIsK7grncK10w0u741KwU3PLSCmW/X6/rYIHhdyuh1Hlkva5YytbqUw5oYBmUn62tgPXyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041920; c=relaxed/simple;
	bh=G7Szwiws6C+kXgCk6xisivu6OlVDwdV0dSr7Bj27sJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mKoPlC7RzGQQ59/9ukp1iQ+Ve0cEPi0wq0t5btmIpN0ggDA1eR/NvrQLMk6Q3gQwMj/CEOBlRt9/alatwkFrdo3Z1hrqHl934qPdoQHKGCGfExgRxQqvpuYgq9MaTd/tTxWMpaXGxnvtQPQe7D/9JuBUUL/3v89Er1OAD8ef7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=g2gWBKjW; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="g2gWBKjW"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dca00c1591so377373a34.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779041913; x=1779646713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsMbxEfC0uMa+kHsY4taTb0VH/LIItEw6BfVK+qBf2E=;
        b=g2gWBKjWIJYEflBs/N5HnGWWiUBUty1gGpiuuURNlMik/KJKSDP4iDdZY98rPg/hcv
         3v3N+BsaCIeRud1bgnaIHCnsGrlxdnGp2sPuldDcIPpjtvFykMdDUnHjqtouVrHmHGzJ
         HfiPZIqKntV9a5zlMfksdKILgphdXJEWA33v3lrEV6QmTSrydxeQ4AGkqlwVvnhKGxWZ
         V7phLkoGpFqkny6aRxZUaJ6LdOhJ2Gdol8flsEXvP6gqh9sGGr9Huu7cq4o9EhPB4SGO
         o1YRGI3OjSslqq4yhLGUguEINxr3pnKShwdWQJoRSf5QbMt1dC8EC9Jq++Ubre2hvwdx
         Tu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041913; x=1779646713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bsMbxEfC0uMa+kHsY4taTb0VH/LIItEw6BfVK+qBf2E=;
        b=hXU3Di/siT+cCRuHmg462INnAaQkRL+oveQOzvDjWlgfeNbYkqLLRS5Ii4KNBSZep6
         oRpFwbS+6lzxume9LT04nvehXz0nXzLRcO4GRhQbG917k0Dn9L0LDPQ8ClXL7GewMfXc
         KAFEFO4izSoVmHS/fZxBaQH/BwZ2oWSxsnfcvv/nfxb2Q2WHVaEO4YJIykIj1vFEVCrW
         IB7RBeSfi6/f0WNKhErZuVty8unQxOt78IMrZnVRDfQ/bBz2SesCzFr4na2wt9vglXq0
         H1Y2UdKVu41bllJPnmKJrYkvit7Y6EaPKpwa8lfGFgneSsDXDNs4xtqy/IbvtjnpXPF8
         AI7Q==
X-Gm-Message-State: AOJu0YyAsFTR70GXTnV0Oc8ukVvhbjdzl9ZdVG03ooa5CzHAGRiJkDJ3
	XsCNvkCqu3X8ihckzyOPCxKnIlMzsXllzpGNSHnrqe/qBlQIwHiiKjDyNTgcYLH26mk=
X-Gm-Gg: Acq92OEQK/YawF3YcgN3dRUr9PGVEqW7bebuPXbiQ2xCaDGr1aUpCc9F9jwVMhTa8rr
	KZt6LSPAA4TY9J4+oOOO8fdavuybiHRQUD2YcgLBgpujOzCG6hFF18rbrwuwMu40Z1CbfCwcAKw
	gCdW/sikVQOXsYwZg30dGU3rS4g9dRnODUEobqIJtkO18oeJ+RaVHduchu9w/MtT1g2gYkfsRAA
	aThUDqnWyP84q5kkOKy19j5eLUfor3xJeaHRsT7FQAASn3w/N82lDQTrU3zmNRpImWQS0dJcUw1
	QWhEuUODn3kK5dI2pRrI+YGCs9E9WgJVPe4HsksdkK/1qI5QtDwOYbWzwI60ha42JAoFXaA9Y2/
	GB5tEzl8XHiwaGphd+auihmDU0QL9oNDKrJ/95TbxTZBBiJiWF89klnNNcxCv1zla3XkhGvYrNw
	jeuuI898dq1DgVA5pSYT42pz+5jUg=
X-Received: by 2002:a05:6820:16a6:b0:69b:196a:de62 with SMTP id 006d021491bc7-69c94377590mr7647901eaf.27.1779041913148;
        Sun, 17 May 2026 11:18:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a95766535sm2085539fac.15.2026.05.17.11.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:18:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 May 2026 13:17:22 -0500
Subject: [PATCH 5/8] iio: adc: stm32-adc: simplify timestamp channel
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-iio-timestamp-cleanup-v1-5-61fb908c11c7@baylibre.com>
References: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
In-Reply-To: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
To: Jyoti Bhayana <jbhayana@google.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=G7Szwiws6C+kXgCk6xisivu6OlVDwdV0dSr7Bj27sJk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqCgZRVFRaQSBdSkHoxJ6yR/B8XlsRDlUP3cMKz
 CVIMrFdEM+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagoGUQAKCRDCzCAB/wGP
 wOtRB/95xIxW8VGaKMif9Izi7JG162j0YqsXHso5T7C3wBxKCbha4uf4X+4lM2uAPDCUAIYTa1e
 hRZUTSXFWZfvnvqS+25laf5z31Wa+ybT61fYxb87EXbWlhwPPlfS/BvXjYKeWljsJNw+/VvC5cE
 DY5MR93FTBEW0Oy51IA+PzInlkVDYO5NvhgDF4UBBXxQw9UdzVO1dcHe5f2Uv2NRgPokVx8OX3G
 +70ao6CG97J+tL6sk0SbhbajYAYyM3KBEQ0JsuymiWfyKo5HvxpGtSjjB6wk9WjOYQ+sKnsnxv4
 YmYMoLuBNLjDgWWPLV1doL8ycCy/rp+0lVvXbLzXCC9R0pJh
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
manually filling in the struct iio_chan_spec fields. This makes the code
less verbose and mistake-prone.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/stm32-adc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 46106200bb86..bf68f28e7c3a 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2443,14 +2443,8 @@ static int stm32_adc_chan_fw_init(struct iio_dev *indio_dev, bool timestamping)
 	scan_index = ret;
 
 	if (timestamping) {
-		struct iio_chan_spec *timestamp = &channels[scan_index];
-
-		timestamp->type = IIO_TIMESTAMP;
-		timestamp->channel = -1;
-		timestamp->scan_index = scan_index;
-		timestamp->scan_type.sign = 's';
-		timestamp->scan_type.realbits = 64;
-		timestamp->scan_type.storagebits = 64;
+		channels[scan_index] =
+			(struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(scan_index);
 
 		scan_index++;
 	}

-- 
2.43.0

