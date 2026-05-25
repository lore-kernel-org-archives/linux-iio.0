Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1DF21883E
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673188; cv=none; b=OUfPHDct0Rn1msGWA5pWPwqAiZT2bpexr/CZHkdlr0aHNKBk3AWv8m7wQe6Zn7NAdFzSDiWvGnvdbDE68dOLqMiO8WjRffd7XCZ0auEDToymjorBaz02ypg8vu/AAUPWTYmdiZ4+AQLPYk8H8Yh4hipPmbI56hkgWfAroiAd7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673188; c=relaxed/simple;
	bh=TEHUifL7/4dnIMKll3xLMjX4V+n+021/c18PVpzo3Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7gyXCK/uc0zpR8OUl5qdCdf6F1yyo1X4HiI0K3qKCGwjszyXbQZ1XmrZCtgHLYR1F2VH1BKLwacFRF7fWSkb4Zj3QJLRZngcFmIVh3Mi0YNmkxp33jci6tMCirkslPU3oUy4BR/whJ5J9ENYZwXVfTBIy52elQEEF0ofDu8Dn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=knQJ+l2r; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="knQJ+l2r"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e582b3bcaaso7828225a34.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 18:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779673186; x=1780277986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sqYdvGVyKC5T85bHR3ghgWWsyGPZVu/btJbvGFyKsw=;
        b=knQJ+l2rA5WuNQ0mwHfLNbDIQlNbhn0r07ew05TOlWaoJ5YCfa9mf7syniyRg1SEar
         9DY73RmpGPPpl/w26GIGC2cFOsbtIlDtdelif7Jae1cGmZw70/3RveXFqUc4Mq1pu+kA
         6Brcr7+CIXo5/InGMibUw8mWjZ4lmAkEo7JYBdBKKbs4urpBpoQKEd5fhgvykFGhp6j+
         pllwpTVT3vKEM451VAwZpdw+Go3fAf01C7STPM9KSEMCrOv1UrnGCio9rauUFEy+jcti
         q4CkjjiBhCcwJrsZjrHmr2k7hMOqjKnmN2JMPLp3hzYAb/YDyHI2S00y68k7biEMUzF8
         rf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673186; x=1780277986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+sqYdvGVyKC5T85bHR3ghgWWsyGPZVu/btJbvGFyKsw=;
        b=ZycIBiz6znJakwFeO8lNuDWXIBOyYBFL8c63fu/yB8gCtWGwOHkWfJ0LFp3o6yG/1b
         PW3K/dk8CJXybGRRSk9WQrTaEMHEtIBZju9gHmNiylopDNRusitoAvXywin+LQBMW78A
         nfRGAKiD9Mm+IS1gQ/nA9uFFK103sqbUQnghmixxbCvKvNjrFM0fSutucm73ZxluWT7C
         2km0NSEFbJ8V53h75KiIpx79WbA9xDpePS5l17CP1egdSREnwRdxRTGJ+cccOSzJkn/3
         GI8sohgrGBhdh703KU0EWklrreuKnclCUOL9zQ2oaPujy8KDqBinhQreQxq5hqLJe0h7
         FVMA==
X-Gm-Message-State: AOJu0YyhkS1qdNLeFY7UNPZ/bIZPE8FClKjZm/AB7+EPiEkaBBKj1z3v
	3Ijf54p0R3x+iQhxHTif/a5s38iE74Xe8FgfkSoB9dR9Z7k/12+B2W3k91N48wCHIis=
X-Gm-Gg: Acq92OG4yoZTpeNHMtFy1tzSM75nzvVEkgaEeKkDt/e6LsyW07iAmON9EH1Ui22cNBL
	z8Pf1tK5ZwgnF8n+6XrSPap/j4F+D4lAvMOvEaYt4UnnkkT13yeeA+rIZaX+ia9F/2z5v8WQTud
	OVnhtbCzh9xeQfgsletZIoDc55hkyJXrogHlWHdNWI1aJEWGlacPxpzMP5oWVV+NLovo2WOf40c
	2HWPzgd5+8uCpMLP9psYmaG4KYptJzMGi7WBFrsPqoCK23lHFENwobT2BEprx46cqQVrAxf+fTG
	T12FJti4z3J7kMm+S9eemo/UX5t/hN/mLYe+c07XlZwksLWpnX9+xXuzY2cUWwU6+kLtxSkLmhP
	TPrhh3aK4XaUu+E/epoWMBEvSC2UWozSCvZQK/gyUzlwLH0/PjYl63Sa4mQHSDMbJzjy4nklljl
	IpDjt9AR2qNpjqFcnGdqwahAXNME0x2akoey9o6qU=
X-Received: by 2002:a05:6830:3c8c:b0:7dc:e0d4:70c5 with SMTP id 46e09a7af769-7e5fef83672mr7641141a34.25.1779673185757;
        Sun, 24 May 2026 18:39:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:713b:3006:84c3:c1bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6060b2dffsm6250206a34.0.2026.05.24.18.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 18:39:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 24 May 2026 20:38:33 -0500
Subject: [PATCH v2 1/9] iio: Convert IIO_CHAN_SOFT_TIMESTAMP() to be
 compound literal
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-iio-timestamp-cleanup-v2-1-c37c9408b7f7@baylibre.com>
References: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
In-Reply-To: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
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
 David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2508; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=fKuBtJfAfzCPrk3RdMloY3OvsD35TA24knEc3HPqxbI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqE6gkbp2XpLy55TfXwCfXUXCOiKIRuOMxo3k8B
 SKcIFfNBt6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCahOoJAAKCRDCzCAB/wGP
 wGJ0B/sF6GcNKoszGrdS3K3qVjnpXeZGkJO10bpDXR4Y3SRxc7dVTNe9sllJCpyKPQhdmnCCdbJ
 8MYmZ77vnGZLM3YPs09/4cO6Oz6yDoJdjxh7zlvnMcmgzm6Dj5l0P/a5r3Uh0V2wvH2dex7ggHd
 SaF2Oi0IeM0dI26Bx0hksIsaLx2dTD8BLZqrx+y6qY4bVH9v0EmzoSsAmfE7WKnvYGyxdGtFB+2
 UvMVrh/rhy3kOiOk0JJNOyIo2OsCanJ/fKxsfW12+iDCn6TSQXXQZG9iH8086GSo3wlX5XRc77q
 SCocumfHN0Fis55ywvYaqhtzzSiGdfFfcIICVJQWNs/3mTWy
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Currently IIO_CHAN_SOFT_TIMESTAMP() can only be used to fill the static
data.  In some cases it would be convenient to use it as right value in
the assignment operation. But it can't be done as is, because compiler
has no clue about the data layout. Converting it to be a compound literal
allows the above mentioned usage.

While at it, tidy up the indentation.

We also have to change existing uses of compound literal at the same
time to avoid compiler errors.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: David Lechner <dlechner@baylibre.com> (fixed compile errors)
---
 drivers/iio/adc/ad7606.c   | 2 +-
 drivers/iio/adc/max11410.c | 2 +-
 include/linux/iio/iio.h    | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d9271894f091..cebb8ed8dcb1 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1475,7 +1475,7 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
 	}
 
 	if (slow_bus)
-		channels[i] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(i);
+		channels[i] = IIO_CHAN_SOFT_TIMESTAMP(i);
 
 	indio_dev->channels = channels;
 
diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
index 69351f4f10bb..dc1b96356592 100644
--- a/drivers/iio/adc/max11410.c
+++ b/drivers/iio/adc/max11410.c
@@ -804,7 +804,7 @@ static int max11410_parse_channels(struct max11410_state *st,
 		chan_idx++;
 	}
 
-	channels[chan_idx] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(chan_idx);
+	channels[chan_idx] = IIO_CHAN_SOFT_TIMESTAMP(chan_idx);
 
 	indio_dev->num_channels = chan_idx + 1;
 	indio_dev->channels = channels;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 96b05c86c325..711c00f67371 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -353,15 +353,15 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
 		(chan->info_mask_shared_by_all_available & BIT(type));
 }
 
-#define IIO_CHAN_SOFT_TIMESTAMP(_si) {					\
+#define IIO_CHAN_SOFT_TIMESTAMP(_si) (struct iio_chan_spec) {		\
 	.type = IIO_TIMESTAMP,						\
 	.channel = -1,							\
 	.scan_index = _si,						\
 	.scan_type = {							\
 		.sign = 's',						\
-		.realbits = 64,					\
+		.realbits = 64,						\
 		.storagebits = 64,					\
-		},							\
+	},								\
 }
 
 s64 iio_get_time_ns(const struct iio_dev *indio_dev);

-- 
2.43.0

