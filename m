Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F326158B
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 01:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673200; cv=none; b=MDrlOcwxFEN/XWokPLJ7GUKzBEj2GkSQTt1FOA+6nhTlUfoicJ1HOaRWaZl8sUCtlhXdk2xuDiLNrGb9hjybJPpGWBDn5WGONt4FecIeX7+dOItZzpy4CLtohz3ev2YqJzbh1CFXLLSg8FHY7vRW6SflLnf6K5U/SBs8yMXcwl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673200; c=relaxed/simple;
	bh=kT7iBeb9XCkWmH0M5c7AuCVAJn+S9r0mo1T4JiYsl94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=APQ1BuplZiH5L6D9OwXyojXkfDe6j/13vvONeiBwBkvMaZuM0CoS1kPnLQEtPgQplcq5M5gJkZSsE8gH3+crMXwxJGrF2yqdHuVUH6blVdnBfXf157fcqYNDcV4Mj8ZCrRm2/hLbrwWX2KJwlakJbzHH65V4QIGedMMQfDgmR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nFrE+iYB; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nFrE+iYB"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dcd17e19b6so5104643a34.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 18:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779673191; x=1780277991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcM+8coPu4v1e9MEXIssy6i1P2Q9YXTHeGPSK4NKRC4=;
        b=nFrE+iYBX03JaMl9k2r4PCbkrxktH0RQZaYzOc+FDcwUrsKMn8ZztIev7CVKjJuKa3
         u3iEunhFYjFmdZ08CniwTBD3H964lhVFbMKqardflLZ0XmWCxm6JDemfTVniMRrZg4eV
         TWkl2X8k/IB4DAYBUaJ06zZ75urtExQqDChpqLCNxCdwaBK/x3c38vSoQbFNUgOLVesm
         Rqh9x8Mcne2VroDLP+2PICRjEE1682HtOnmkbAm9O2Casr5BFTtzdoh375SJou208feJ
         U3MoHaAD8l1uOvFlVdX4YBKlFd73Q0J98BP5L5ob0hKdayEX6fjXwHwyOsNbu7EBhyvK
         oksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673191; x=1780277991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qcM+8coPu4v1e9MEXIssy6i1P2Q9YXTHeGPSK4NKRC4=;
        b=PRcPnCqWgUvWwAqwm7Zdeq1cyLUMzrzKa8LCSRdvrA4BQ8mnjgVgsYucF/G226utpd
         RBrfonskm+xZdSI5Xw+yNFwb9STlnyT5inhYqhNM+rzHRAGzS1/vLKp1yKuRCYrEKtYp
         bKBi6GtCk/l+C0gq4Rpxn6MEXYH/M4feuQUTESEvtY3nS0wEN1164TWLyhKIDKahEWAw
         mj9kraCkPzN6g1FcKbXlGy113uWf1wnaA2st8TGGuli1nUpDRA4cAStgopgqg6aC9Cxp
         d3LLDaPhgGMaxcEzyZAUaWpeXFpv59/euXiAhBUi+LMy4vCtc7Ju4cAgILjSACouLSNn
         o7XQ==
X-Gm-Message-State: AOJu0YymHWqiqneSYa6ItRPMGzsqHruINSkRMQJBKWaObRZvetIZeUdg
	AWqFx96iNR8HtSRkoCCZzmlC/d/A0xHVPOLCkOfd+pGuKeVzTgNDhPQNiWKDm//wyww=
X-Gm-Gg: Acq92OFpEtM5t4pfj79G+r/YyK1Q7+tOyXg/9qndbTp5EnjU7qdTLrJxnsOKgKWjwQd
	6PmiZrl2fdgx0kTw28DjN0JDeHM3DK9m1k2uQAOgj3h0PbmC6MTh1I2L0mRjhPBuLtrvQDBiIdb
	jrbXwdzD7AH633Ym+7LO90Xy+awHy69l4ocpK84gWYBS55enwcQupbf1t8vLJhT4H9bq6Od5J00
	IhB0z9qFLQUruNUjj+F8oNhqroOzdekImhbck4nlsidj9bS0pztuk1i8DV4VFS/GDMNxsbPhRPe
	/l8rf01z7wjoZmlrkpsMPzijO8AGMKb9tqoNJ29C+jEejnI/N4MpJE0e/Z5rbxQoOYZ0H9vIHn2
	y/nEUnrPDjxvZo+n3De1P8wb+0mTMZc4RKeCiRIh8g23vOiB1ApnlI/e96gztQXXyW6sZLRuIz1
	4nCjCf6UTREQw7rHoq9PT/oSo2bb+2
X-Received: by 2002:a05:6830:6d0c:b0:7dc:d99c:c441 with SMTP id 46e09a7af769-7e5fedc8241mr7219838a34.8.1779673190623;
        Sun, 24 May 2026 18:39:50 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:713b:3006:84c3:c1bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6060b2dffsm6250206a34.0.2026.05.24.18.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 18:39:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 24 May 2026 20:38:36 -0500
Subject: [PATCH v2 4/9] iio: adc: at91_adc: simplify timestamp channel
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-iio-timestamp-cleanup-v2-4-c37c9408b7f7@baylibre.com>
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
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=kT7iBeb9XCkWmH0M5c7AuCVAJn+S9r0mo1T4JiYsl94=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqE6g4ZzvN+pLtbr0EtlFMYHDp7WfJxXmMKDzwC
 v9MYmHcbzCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCahOoOAAKCRDCzCAB/wGP
 wM4kB/4oMi3qMB93dUQsrGEQKP3Ylxt+25M4VOOtJqdg7N8vJaJ1C6Lmi5F/KK6qCauA/lzIV4X
 si8btQlgwRRXDQ6XKwu3cWj/ai0R3djV9ReHCVfEGuiQQ0tUgB2QROHEnXiC0F4tBS6FWCVUlYJ
 I6DBZOM1nFp9tt6ap6GXFJ3BcwoZ7V/n5Z3GOC+N2BdEyABMsqK6hVrc8Db1ksyYyjbzIhaETVj
 tIJsfrSn2JjVJ5299p8Gm7hdyOXXZh/t2uRbe9QEeahWGaTwcNWvv9HlO4izEY1uM+pkipAIoh7
 Sdf1+Nlh+iWCpQuVbssgfyPaZxlw0P8K6guLhv28vVycI7U5
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
manually filling in the struct iio_chan_spec fields. This makes the code
less verbose and mistake-prone.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/at91_adc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 6e1930f7c65d..f610ad729bf3 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -481,7 +481,7 @@ static irqreturn_t at91_adc_9x5_interrupt(int irq, void *private)
 static int at91_adc_channel_init(struct iio_dev *idev)
 {
 	struct at91_adc_state *st = iio_priv(idev);
-	struct iio_chan_spec *chan_array, *timestamp;
+	struct iio_chan_spec *chan_array;
 	int bit, idx = 0;
 	unsigned long rsvd_mask = 0;
 
@@ -519,14 +519,8 @@ static int at91_adc_channel_init(struct iio_dev *idev)
 		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
 		idx++;
 	}
-	timestamp = chan_array + idx;
-
-	timestamp->type = IIO_TIMESTAMP;
-	timestamp->channel = -1;
-	timestamp->scan_index = idx;
-	timestamp->scan_type.sign = 's';
-	timestamp->scan_type.realbits = 64;
-	timestamp->scan_type.storagebits = 64;
+
+	chan_array[idx] = IIO_CHAN_SOFT_TIMESTAMP(idx);
 
 	idev->channels = chan_array;
 	return idev->num_channels;

-- 
2.43.0

