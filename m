Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878269;
	b=gd/mcoyFBhvSWhdn/BsyElwEV9z1oopgsFwG3DrTF6/rI4N+88sdcAIEA5/8/Cl8Xf4x
	 YMrleIVZf8AIxoBiv3hOZsFL22DcKEL1+CWs+EU70vAv814gWcETiPbnHxBair/dtKSUA
	 fFsj9mxnHelmIfoVPwX6raorIO2Rp+hSsvvJGTz2vro+9G5N1ePedIE9wPnsdiJc1ZWMW
	 srm+4+V4aqK0uhHrRHDy6Jq6yik/aemh9OTwzet8EnVt72bBXN6D0vK0T/YlL7PBuw1Ut
	 ybXnqPb5zWCXu13D6Fh+qDJyCLFY9/BBw+xjSkegpnen1UzuZADGK6hCp/0EvYX91Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o9dLc90NOwCQ8gMqbMbmGkdZs1HGcCbm5itPdWqDFhg=;
	b=QrWHvkJ60uWVTyFF95qWVUr+GxYlpLwkQw4bgPp3mFlByNBEglIhwEjtilw6DOcELHDf
	 c8R2IFBDYNV7EbYGKYwy2gd59V4rfzuIzuap/u4AZDUBV7lReOIrUIoGDTVtuJa+R3bGW
	 5A0runK2zIuAg7kaB0W1rAc6zoJhkFt+Pfj4pPBgKRClKlQiyuQUjY7ySoC2PXwbaM+FQ
	 wkDEqMoIcOE2QL/XnyeytupoYCFlM2AygwXKSuVRTkx8C8fgXv5RHGNUt3M8/8gjiis5L
	 +J4h0ywIWTogakgFjF6iME9vdcyHMpDrEYBGoV1/CzCJlgTEB8SGKNSHQDNQhAIBq6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F3vnlwLJ;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA7606A31D
	for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 21:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09AA7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F3vnlwLJ
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e20edd106so1637123f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792878267; x=1793483067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o9dLc90NOwCQ8gMqbMbmGkdZs1HGcCbm5itPdWqDFhg=;
        b=F3vnlwLJxSQs9B3MUogpQhfEkXeXwkfpVfAWgu+HUDrbEJUoobOTEajYZL3MD1Mj6W
         7H31hNMbpYjyFA6tSGXQb/dnF3t9hxppaTNI9cOb8bH72RH+qC+D305nJ99gdGHxiM6m
         7OdCr4cclSTxb7xyDh3ZoUjxxx1Qk/grC0gv31SMkskBqaYENar9XhQbvJ5HkM1p74XT
         4AQrpYYpujsXPCCJiZztRrM/x3ANtV+HZvcyRtb8gqPThL+hH4hTLj5ZJrReTXvjA2u0
         t3VPV5P/WpRaYt6YSgoOD4DSpCDW0FpCNUzQhFIZ6bA3ScTkUrJrsLyTYf7NoAOLZzTW
         Tchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792878267; x=1793483067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9dLc90NOwCQ8gMqbMbmGkdZs1HGcCbm5itPdWqDFhg=;
        b=fajCIa9gsqsBUktZj9en79rAicdXkcPgnTTTinw5WMR9S/sLOyRWXabIloJl7PQ+lO
         ckWZF6k5uhnlmXF5Cd7QJYPG7o8unoIBfJL/eNn0/tVsc/Y1yFnwzeajXg4PmbhewJLY
         YtWpt8bssPQ8N9f2v8jCTim+hZdZptaFK/7099/8014Q42CdSjQStwg3AsAjlzxQMbNw
         +S4K6e27wHlFEXkBcMacOxWvQBTgxU6D7Qof55hStMpRx0QQxG55bG9tvAQJ7iAuPQzw
         +2my9o4R9ZFMqfFj1vv79gGNU0a5nu8DHtMaHrqKCww3knzyGgyRKFdC30jxjqysqAfk
         K2yQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKCg3Xdsa8Cy/1gc4oNCQPlqsXAwBTUbP/ANF24qHy6fPpp/PLCCIGA4bQonV4mgjUL4Q5mxcfn5M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKX07Kq4/5/vLCtMTkJRsuDsUmgylp6PbfgAAMevSEbin/6jf1f
	OTJdJPrRVJ/pm2Te46lfwuwnSbraP62rIUAqONJCBrxCNHKa3pXElOmf
X-Gm-Gg: AYBFou3/BHFiS53bxil2jmsMJ0jX8UpDuTqc4ZxyKJMrpa3uboX1zJoN/LS03VbnGFJ
	jmTS9n+NYGBjdbPagVDMrVtuISFqrefaihJvfz5nmvpsBPNVupaXbZjnvDhsww3Hb4GpyE5RZ8h
	EydwtTAT2YellyQI0ALQeRkFrLVlDvfFumeqauKp6gIf35PP11a6tG9Ui8LPIgh+UKrVjj+lDnE
	+FOpmA//EPBPosgDSTPeGTGPahZpreDA324dLKWDvoBOcXxL6FNBUTZyCdeNRVnc1tSPg2wyU0P
	HoLlPdKv6j16hZoMouPTwDFPmBXkIqadlKbALHqn5R3ifmZ8k5YEPQbsuu3/U0FG6NIC5ttQ79I
	pumbrIWepUS2aqe+LMUScXBF7WQ9ClD7FVyFqFesBeKiM6kD+XfqQlnVwvCCkrGRPokyPzxgF5m
	MbGmHFyMNdVPs5lUCfCT+CxC19RQngSCMqi8zezsdPuqhfLCKFv+pAZNDKTENkO3lbdal3Jes4U
	1I/5iLYxap2aUp8ks0mYnRi0CQeoRYqMMqgMfpajmk2a85V4aZaiiir2k+72S500EoM4VDRuhh4
	rZmI30XFUG3C2ZFgBjzswfgo9HjHy0LuF8DY3iE9
X-Received: by 2002:a5d:4743:0:b0:48d:f249:82c3 with SMTP id ffacd0b85a97d-48e3eb8b816mr3059620f8f.30.1792878267110;
        Sat, 24 Oct 2026 14:44:27 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3c5bsm6981411f8f.9.2026.10.24.14.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 14:44:26 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: dac: mcp47feb02: reject out-of-range raw values
Date: Sat, 24 Oct 2026 22:44:23 +0100
Message-ID: <20261024214423.865635-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
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

mcp47feb02_write_raw() writes the user supplied raw value to the DAC
register without checking it against the chip resolution. The parts
are 8, 10 or 12 bit, and the bits above the resolution are not
implemented, so writing 300 to out_voltage0_raw on an 8-bit part sets
the output to code 44 instead of failing, and -1 is written as 0xffff.

The out-of-range value is also cached in dac_data, so it is written
back on resume and stored to EEPROM by store_eeprom.

Return -EINVAL for values outside [0, 2^resolution - 1].

Found by code inspection. Build tested with W=1 (=m and =y) only;
no hardware was available for runtime testing.

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/iio/dac/mcp47feb02-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/dac/mcp47feb02-core.c b/drivers/iio/dac/mcp47feb02-core.c
index 88bffbab0854..1a0e80b5db87 100644
--- a/drivers/iio/dac/mcp47feb02-core.c
+++ b/drivers/iio/dac/mcp47feb02-core.c
@@ -696,6 +696,9 @@ static int mcp47feb02_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (val < 0 || val >= BIT(data->chip_features->resolution))
+			return -EINVAL;
+
 		ret = regmap_write(data->regmap, REG_ADDR(ch->address), val);
 		if (ret)
 			return ret;
-- 
2.55.0

