Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47247388366
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773530047; cv=none; b=FA2yNlxBvXn3jX3Tcm+lEZ6CujxzJ19/XgtvOTFFGp/t6hnMwpBKnzGs+hcX48WUXhDJU5VFZkmB/+e08jSYzuIzb371HEI5sN08oizM369WyDKH6qUJ0jDea+iVPTDZOGfuG7Kll3TLaYDEMoifeROAC+T6R8fwGWJjG90KDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773530047; c=relaxed/simple;
	bh=uP34d8adAjWGrdnFDt+v8AQuj1fzjsUbW7G1AbYMsxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c40NNP+GAotED5aAsyH+35iM9+7atpnJnCtONMVo8O4uTpLZ5c0zHoL74uJk7l9E7lxeBtEyioNe47cucGctrPEE7QSYF/F6s1xQ34HsAN7u5hGNOSQnR75yP4uOT4+e+lq7KE2gLv7lcfag+ZhAMDaXsfMX9v3NoVdmRy0eYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FLqsnHN8; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FLqsnHN8"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-67bb87f866bso2194062eaf.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 16:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773530043; x=1774134843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQ/lo8EuAyP/911On2uUUwkgjB5+vs41g0/zviwDObg=;
        b=FLqsnHN8hf+yEUipp3cQsJgnJhVvVp7VO58J/V/+qWgFbD3wu/IquaQkmOC7tgnQ4L
         0QZnDIIKIe++KCwDM4wJw6kce0zdfB2dfURTrdGCW7CpvmD4LwSLxsBRJhMCKUAcKk4m
         Y0Mv4nzfsqRbYkOYRPfIPEiR2jqKUSVkeypT2NLOyNGhJgKaE7Web5FqJXNUywETIwN1
         AHyFN1qFtvtn4fDMSTL6SIkFprInoIBZzu6qsgqFC3NH2Y0pZgzSb+lUZt/jx0Vo/LD1
         d0D1p2if96XnM6GDTbKgV35uzwt1nqF+G13+GZ0bLV9FAknth+aUWfSmqUVQ2SK42bI8
         OXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773530043; x=1774134843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PQ/lo8EuAyP/911On2uUUwkgjB5+vs41g0/zviwDObg=;
        b=ebqnGq/91UV7KFSihgjNz3Uhm4nNtkA9+yjPi8bXgLKE1O9Qlv66jcbH+TWSh89g6K
         jhkak54D+5LKfULwUuGMMm83c/h0bNqqY4de2V5weCmYwVi20kihVIMwb9Cqo38oqvxA
         Ksz6dXMP3ymJvuxjEwtLFEmOODF/vKOjhhhHHA6vffOT2HaMWIYGR/5EVQQ8autRn+7F
         t7ptr+fwvayhkR6zCPIRrYLLFuFiCBhA2A+ui3SNh+zx1rQdjeWLGIynbnkPmOVjcI4e
         ZSj3W9dp7B2sXAunvzWeL4e+ADhaiXkeaajIhQpscSRXz82j4CQZckYRUbl+e3aUKsG8
         H7Rw==
X-Gm-Message-State: AOJu0Yy1v4DE48pzxlGa+eJsY+wLpFT1qkcUUjTQFNOIPWVbRl4L4B3N
	KeZ5DDeBcaZBmzRa/mlSMBON5pr5Fy9t/Q9uQMJlLN4XJQIbRQcv+MqE7m1fNuj73Yc=
X-Gm-Gg: ATEYQzwZEIYx2zZHZre3oBRJP0RRTCGx+0TKZw46nMcqVwnd/JrShQTB/U+ZF2ivBwX
	7M8dfm+5l9YJB3i9VbNyFeajaNxUHSy3WM0IfH3o+qulEteMFRmgXdLhMu2j04oTgxInRaMyGfu
	XsAM3hsV4PyZ/WzhPSabcT8R33klHFxH17VcdUgok2Ad1wvOpwuHvUkLI/d276+YixHhnXoBICD
	zdRvNzpOU2dZR+PDsnzCgKxUfiQB+vwHcOmvy8qGjP6waPpYgmPvvgpPvFdTuak8D7uU3ZR6Rkp
	YkLhqrCFcJ+Mme47E46KcT7uBmPB6GjbiXAIAfL2jpi1qXxRT7JB6zTu+N1HkhYVps0HZbW35NJ
	j/QATxY4xCax7kGoE3RtF1Q/5NOPG842+Ogf/oQjEBOdfExXjB5ylYKJlZxNf1IgbfYWFMne6lT
	Ghih0CRQ2zcOoA8LQ6u6MlG3FM031o
X-Received: by 2002:a05:6820:4a0c:b0:67b:f12a:dfcb with SMTP id 006d021491bc7-67bf12ae0d8mr1262691eaf.60.1773530043249;
        Sat, 14 Mar 2026 16:14:03 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f27f:adf2:8637:6bb9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc93279c6sm6850885eaf.12.2026.03.14.16.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 16:14:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Mar 2026 18:13:32 -0500
Subject: [PATCH 2/2] iio: adc: ti-adc161s626: use DMA-safe memory for
 spi_read()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
In-Reply-To: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Matt Ranostay <mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=uP34d8adAjWGrdnFDt+v8AQuj1fzjsUbW7G1AbYMsxA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpteusVJtgDQCQIDid8LlVNKH/MoA5pI8xIdHgC
 zpGg7rGVgmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabXrrAAKCRDCzCAB/wGP
 wIu+B/9+iJlIPsEYIRGc5OzspV4dEONYNmFkQud1CRy9UPaPClUDSqfSclH8ZHst2aqOKFKmTND
 ztzALp2GYBJzfGZtHhcPmAb1WZC2/aUsBJ1qO3WEbd+zkDBPQsZfaF6H3YM1lWwk9jEteDBpIlK
 mtWuk8EmLgXdlklNf/yvBn9XIl8LSoKW84wnC8YufQhOLDFjADY4LZC+fCNembIkzx1Z7t99qkB
 6D8EnVkWp5VYYUtMy2SPaBtASAwIT3slRzMrd2pcFOF+NERRgD9YFsTNDGFO5bGHreSJ4xHOqCO
 euAhcws675ciPlvdN6PTJFEUeHJrLV+RntX1CGv9K3Bt1eUH
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a DMA-safe buffer and use it for spi_read() instead of a stack
memory. All SPI buffers must be DMA-safe.

Since we only need up to 3 bytes, we just use a u8[] instead of __be16
and __be32 and change the conversion functions appropriately.

Fixes: 4d671b71beef ("iio: adc: ti-adc161s626: add support for TI 1-channel differential ADCs")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-adc161s626.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 1d427548e0b3..6416d6a7ada0 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -70,6 +70,7 @@ struct ti_adc_data {
 
 	u8 read_size;
 	u8 shift;
+	u8 buf[3] __aligned(IIO_DMA_MINALIGN);
 };
 
 static int ti_adc_read_measurement(struct ti_adc_data *data,
@@ -78,26 +79,20 @@ static int ti_adc_read_measurement(struct ti_adc_data *data,
 	int ret;
 
 	switch (data->read_size) {
-	case 2: {
-		__be16 buf;
-
-		ret = spi_read(data->spi, (void *) &buf, 2);
+	case 2:
+		ret = spi_read(data->spi, data->buf, 2);
 		if (ret)
 			return ret;
 
-		*val = be16_to_cpu(buf);
+		*val = get_unaligned_be16(data->buf);
 		break;
-	}
-	case 3: {
-		__be32 buf;
-
-		ret = spi_read(data->spi, (void *) &buf, 3);
+	case 3:
+		ret = spi_read(data->spi, data->buf, 3);
 		if (ret)
 			return ret;
 
-		*val = be32_to_cpu(buf) >> 8;
+		*val = get_unaligned_be24(data->buf);
 		break;
-	}
 	default:
 		return -EINVAL;
 	}

-- 
2.43.0

