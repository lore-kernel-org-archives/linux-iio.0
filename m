Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC293CE4AC
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041927; cv=none; b=Ebcbtephw5N8XC9VIVUUMLCD+oAxZWtZ0KqI1NRnmkgZ33Ag6LybwSrmVRYyxobyqLVQRncLxR55O+ZFhrIP+zrOe78b4WSNe/e0pnAuMxrljH1YFCG3zP3NCxPv2SjopmDaDfxr/rXPtt/qKIuAWlbktAAqHpsZYJ+RsNXBKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041927; c=relaxed/simple;
	bh=wEIJJfBuuiW6SgTlxZD7EP4tAEv7nIycNrSYwH0kNGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VzqQWOX4Buq9HoYaYVb3uo1N4sfrYqf1+6iixmuuxtoMdwDC6r9DEMpsARLKS+h7atnP+lbjM1Zs5F99Bdo3B+P0nigkMESfKlkRcwMRaTosHEMIK7qQpCTVtvfzQmqYqKudsIPjmEBrtGnMC5AhRg3BqtsnOJDYuGV84nV666E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=eXZlwdhU; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="eXZlwdhU"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-694932346a1so326267eaf.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779041921; x=1779646721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nI9W/EpiOktwEYbn/tmzmd85CheUFzZnXvaR6Dsbb6c=;
        b=eXZlwdhUIF5sIHKoWDuiZWcWuO1DEXH9Yh3UcPBYh0t/Vmmt3JofQnLrZCLgPmf4UF
         RZsFyCrCcQ0isNctYbYpEvIbdXCdWKOrKFBjYw0jh9wm/he7ICZ5luW1tBUHakTGHfkB
         F2D90nQJh243+hn1ObdqOOvfj4uYvm6W2zTp3ZF/PU68LOxBBEbplc6kPsBrphYXuhQx
         WPjGk7H2RfjKflM4MWwY+rnnNYPo5C9hXkYttRXPei4ChkP2Q/CH32nr0n7iHkoKyNdR
         3CiR1oDJb0zbSwYysR8sZf5yhnwEJFalyGAzzafcOXaM/m+gRmsxmqdERgkPZYORUpeK
         U3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041921; x=1779646721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nI9W/EpiOktwEYbn/tmzmd85CheUFzZnXvaR6Dsbb6c=;
        b=lRqxc7gvk4MJgbqIdDiFobDXKpDZhTeu1CjF8GGi359uesVX9429lsVeFgh6eaPFfX
         RB1V57gUKVNO0Xiv29nnRppQmHPvLCv935/tjwIMDWomEnIEtCBHXR+9CrDer7MsQnm2
         hkcLGbO2fZPm1XavpWLVDTfRgRft5JtqMzJNzKcLi0RXFNEBwDfM8G63RErGHWvvWZPv
         9MZW9TmYmGzAmKJ1b4bEfLOPyewqiUliIEw1NZgh6mJ841QuUmBa7GaIaqkvwiLCOTKD
         KQ0aQ68YCe36Hw7br6e6nCd/1ix/xYK8UOqsrEr5wFrLXtMXi+uxQz9x5XgZO7vwXWO3
         yDlQ==
X-Gm-Message-State: AOJu0Yx53Q0frmeSyNi8JX/14NdrluOBwU9Z067N2oH+xcm0YH03tyES
	/vOBFcr1bqffp4IIjj9B5Tcroj2pPF/eGSXdRjpnKtinAJZt3EgfoTugAIBqTXqbVyw=
X-Gm-Gg: Acq92OFt5LtM0Hyj6hFWi61M+cpOMlHLge3pnBlDNxPj749aHQAuiHDiZBFUPco0ZLy
	O4gcn6uZ54JvAGeDeOzfwcIJ5qxbNSMuvj8NL14DsE9M47TlC9k5ZH6vdM/sY27HGnivWZq28/k
	P9Es1LIvoYNtcu/5di0ZsaKgzfpGw07wj8QlEUY8fNVz9gZbjQ4M78sZePLNyj/idNfZuuV7SsU
	6fezlyzqbQ0s8lKMyFKPcG1blot42UwE+C2kdc+N2xOPRclxpxHzEhncHMr3PAuZ2ZeZ8gcyGHA
	deT9DdqaKA6cs1DtQY4cLPWhtNXryVjqZPLC1DnwVuDJ4a0BPRA2vllYzcCu3zpL6vSOjUM5d94
	+wgHP0ydvGvBEoLgzvgK206QkEy/PAbEYYcdYtd50/8wHLT9jBhYvgU/LZkJmeFw0GSYY1Q2V8h
	6ASwKAIpOafY2+sy5ziIl56p3Y/YY=
X-Received: by 2002:a4a:ee08:0:b0:695:818c:e552 with SMTP id 006d021491bc7-69c9c05b9c9mr7284877eaf.55.1779041921012;
        Sun, 17 May 2026 11:18:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a95766535sm2085539fac.15.2026.05.17.11.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:18:39 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 May 2026 13:17:25 -0500
Subject: [PATCH 8/8] iio: pressure: cros_ec_baro: simplify timestamp
 channel definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-iio-timestamp-cleanup-v1-8-61fb908c11c7@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=wEIJJfBuuiW6SgTlxZD7EP4tAEv7nIycNrSYwH0kNGo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqCgZl3bTfr9cKcWM0WeSP7fcRq1+d7XYc1F4Xo
 RfDj35AQXSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagoGZQAKCRDCzCAB/wGP
 wCfGB/4t+2/7CSmhBVt8beV0zuarKfbCi7dFgQWBJMcDXDyATSw1geVjvr3oVWj41/EraJRsc0P
 yP14hy3N7EI9S4MtFZO1OXirmeuqdzAruQ9YsX8BXEsAkb8yxjRm9aLhx1ODw/swqjMF0rO1+qL
 VG14aCHgmOlFOlZNgT1MirGmj7wCjcn0FMGLgKR6eCLrMrceSAwZNlPjf2YLbtjvaKCBZT29m9h
 /oqz7p7LzT5A5Ipa5T9JKMUP4Vv9pMZRknOKxy2FqV3G7JTWU9YJn+ZkV/sfs/QhIzaKfYuh3F2
 kIvTmBUeRS3JujorXrnp7PVwsJ9fsL/CjuCUrNco4EmKWYp6
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
manually filling in the struct iio_chan_spec fields. This makes the code
less verbose and mistake-prone.

Also drop obvious comment while we're at it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/cros_ec_baro.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index c6b950c596c1..87eb9359928c 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -170,14 +170,8 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* Timestamp */
 	channel++;
-	channel->type = IIO_TIMESTAMP;
-	channel->channel = -1;
-	channel->scan_index = 1;
-	channel->scan_type.sign = 's';
-	channel->scan_type.realbits = 64;
-	channel->scan_type.storagebits = 64;
+	*channel = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(1);
 
 	indio_dev->channels = state->channels;
 	indio_dev->num_channels = CROS_EC_BARO_MAX_CHANNELS;

-- 
2.43.0

