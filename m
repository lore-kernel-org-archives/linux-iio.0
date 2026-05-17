Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D37C3B636B
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041907; cv=none; b=O6xwe1U/bi//+iZoUsXVfvgOqc8xMxEr8XDNr4g7u7Nkn6Pyi65Iips01uqMazdWcEGqYmoWibwJ31paD0vssJ6DjP1S1k9EGI955zO4lSRcIKyyQDxiCqKUt1jcJGVCZvq8ElKOylQqDkdzwTg60/L7zNFsiHdCBacsryqVzwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041907; c=relaxed/simple;
	bh=YHpI50wSYZTXW1ieL+zX+tDCAyrdW9auMcLS2k6lfoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fv7TYhTnhb56LT6XD3QZfMIscq0MA7Q9JN0E1CHThPAY1aWNNeT+acmTLMiwlk9RsqxBDP0OCdXpDL9C/qdnNnzLxDFeDrL5+U/irt5XNYZXiyYBbWfna0elXDxvucXR28IgmwagJyujPsOkc+6k5AW+P6l3NST6AU+fjviK47c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=hiBRaWxq; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="hiBRaWxq"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-69b8bac50dcso198616eaf.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779041904; x=1779646704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5md7O2xvTV43+eK3/wu5mO/23eGXmmz5QIIajGxZX4=;
        b=hiBRaWxqbpBeq7dtC7vIwQ4wlF57yjaYPHABhOUXbSxxOqQM4rUb5F1moFdH+jPd9U
         3By/YH3Mb86TKoxQ83PadtEspCjDxK49OG3eRMDRTkPgTSvKT7JpbHMboLt4qMyXzJrJ
         AB2DSca47v+JU7jM4qc4h9THvvoO3r/+m9rR0G/WCzeCdjgChJm7r9ltg2edseBE1U9r
         JCOOwk87OSudrdsgF//7bgG2dBqyG6OPlIhEcsVvNFvMGEP8fNkckEqtm2kyuGnFf4M+
         vbxcKp6pF2kSJyQ6npHavWAyw6zWssfGY/HJzlaCOIjmTcDez2PkBA2SEO8NJDTZb6ao
         sl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041904; x=1779646704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R5md7O2xvTV43+eK3/wu5mO/23eGXmmz5QIIajGxZX4=;
        b=f1yPfb+09yUMYvkpPX/gOXtzQmnUQpqGzAQt3UGw3fJ4wyEF3KPTUyn9Maezy4b2o3
         6xYJ62blhu25t3BvQUQ0/dFL4s+A6jGST2jMAr+s+QBbWCVU7dFe9/SunsPwo/NBPi1a
         6ptxGQYjLOdN4ZxFh7b0TbxYXIVL7ZFJTMuAKCjSgQA0WPv+otEev+ggsueadwRs5EIu
         BMf0cqS8B08whTARyc1Xo+Y3YGHuwCT9jgDiDKAPay+bysSCma1QdlvhBE6Rfm5Bc20l
         e7Bc0kr68wFoIPJgQmQtHqo5WL5pgUVFMtyoUgfSI3Rc30Qg2tFELpKTmsUVUkINu/Q0
         01kg==
X-Gm-Message-State: AOJu0YzQPKYH/jNXc9txoXs+qP/lweQ+kFzGVWHJeTCnLvRlsVvYoLSl
	QJyzWvxN7kaloqEReQbJ9yPP8h07HYOeJZwYhl8EmEOz3pX8GIC/w8dXfSiJlZc0a+I=
X-Gm-Gg: Acq92OEsDjXBkRwmPCBj2b7FmAKn1c8Ivb7Wldup5NRRGxM2xqFEQ6j3P7MzEk6Ov0x
	EvBm/srEA5RNk6YtuQkeSOQAfEdIWZF/y9IRypyK4kaZPodTrXEt1GHhztdqCYk1FZiXLLnxSlw
	Kx2LHXQP9D5hkuhp2gU4UzCKCafEvXtJotH2FZs26Ca1B0dgk5ugIyljOe9C4mmlZqgAtz4ldCg
	DSoCXR5X84JFf5+U4110tm+0yhCIQD48wShd7yhnmcVjpU+XpXmTqqYlk7Lz6d7nA0aJJleLocR
	PyZBFFKpikoStXss58u42rPiG7i1HBso0H+w8yBRBvUfuLVAxpDw1eszy0dnWNWEaU7YIx8dEQa
	bz6KO3/zm6NRaHUnxWRBpHMio43gz2MRkoiT26bJVV0z4r/jsHTUe+Q6qMzftgDcf3U47y7qKuQ
	8L9Fh1y0hedscCTj8CeeHWOejJw+HBE1rYKjvTGg==
X-Received: by 2002:a05:6820:4c87:b0:694:9707:4e59 with SMTP id 006d021491bc7-69c953dd3b3mr6941197eaf.46.1779041904452;
        Sun, 17 May 2026 11:18:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a95766535sm2085539fac.15.2026.05.17.11.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:18:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 May 2026 13:17:18 -0500
Subject: [PATCH 1/8] iio: common: scmi_sensors: simplify timestamp channel
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-iio-timestamp-cleanup-v1-1-61fb908c11c7@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=YHpI50wSYZTXW1ieL+zX+tDCAyrdW9auMcLS2k6lfoQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqCgY2aTT2VX5TYgMCbz8OOiBDnYFmV3i0a+6HO
 ro398kMNK6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagoGNgAKCRDCzCAB/wGP
 wOFCB/4xQ4eSKQgFfsKouXQR3vu8NexauORSshAXou2t3MRLSZK5t6EF9VUuh0inu/5WRCWFGej
 u4u1nzKt/RtnOitc15cyY9Nnn7nkczdAzczNckuYghWXqK91XhaJgcRwG/HFuNtLIj4lKoxm+Sf
 q0Pu9iIKleW9yv4r8X+98Kbv5DjrCSCaPYDHTexcSLUAT8wJohTJAL71EMnB6FODtdCObmx812I
 rURmDEmfF633QDjdS0XJe4MEqg1T4IkiUhtfcGY8NszNTCxYMwSfI7i0oUR13FIruJz1m3VsXVT
 jK2zkSF2GmXef8vaZjcYIebODvZ4ngMnNUIx3PtA78Mw9WPo
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
manually filling in the struct iio_chan_spec fields. This makes the code
less verbose and mistake-prone.

In fact, there was an error here as the sign should be 's' instead of
'u' which is now changed to 's' by using IIO_CHAN_SOFT_TIMESTAMP().

If we find that this breaks userspace, we will have to revert this
change, but seems unlikely since the timestamp channel is well-known to
be a signed 64-bit integer globally.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 5136ad9ada04..86e1782deee5 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -419,17 +419,6 @@ static const struct iio_chan_spec_ext_info scmi_iio_ext_info[] = {
 	{ }
 };
 
-static void scmi_iio_set_timestamp_channel(struct iio_chan_spec *iio_chan,
-					   int scan_index)
-{
-	iio_chan->type = IIO_TIMESTAMP;
-	iio_chan->channel = -1;
-	iio_chan->scan_index = scan_index;
-	iio_chan->scan_type.sign = 'u';
-	iio_chan->scan_type.realbits = 64;
-	iio_chan->scan_type.storagebits = 64;
-}
-
 static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
 				      enum iio_chan_type type,
 				      enum iio_modifier mod, int scan_index)
@@ -629,7 +618,7 @@ scmi_alloc_iiodev(struct scmi_device *sdev,
 					 "Error in registering sensor update notifier for sensor %s\n",
 					 sensor->sensor_info->name);
 
-	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
+	iio_channels[i] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(i);
 	iiodev->channels = iio_channels;
 	return iiodev;
 }

-- 
2.43.0

