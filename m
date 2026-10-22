Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695444;
	b=n/QgT/5L4KVGpF/m9sEZCsUIfJEIPAeD/9zqdROSjrPnmEBwFaEeOBjwSMhxKGIgdcIP
	 Qy7oiyDL/Y/N0oiENEIBqn+1u1VoN/EhiYEhd/Ads9VczpU8fKfHEry+erA/vGGoyvldp
	 HUHIhXjEvtAuV9+t1bYyNBbhk2EP1i1ZINBT+CW6ZBFa3LIFb4n6Qp9y4WOR5luZe5gU9
	 6n9ie/pget4tlxv04buZNF7EMzic/rXpT6iULqV61uPyEZvbysozU5OlAPrerS1OZRhAI
	 tP3bXqdi+jVgnpspbl50jw4DDybiGyzdpdZH+SHDbRxBMjSnH3sgILoLqkb9N/VN0xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=B+tKf5vPrDaOI5M5gTd4aFyXjI3r/OLdMYL4js+XQMM=;
	b=LXyqq3qL5/FQFA91vJ0+uZ2LuW6YG4SWm29FcQ5pCe+l/tLBLWTDxnUmiLkHsX7Se7cn
	 rHt7eu86K9PYeUf0cI3SU7IXw1w42Lf00sm2JU5tLASdIKl7yqiZnWLQbOmoae1w0UidO
	 xKe4FYHhz2YBursAWusVXEsndDjGPcw2LxR0YGzLh2m067a/i4/MidT0hJDgxImWB29Rs
	 eMvQhTWflv3WUN2YixFvU7Ygv+Li4EJni0iQcYl6d8aNE3kfEtxj3QhQU020v/y3BI8Hu
	 7xpJOUVpcgUjWftEZuprtZK5aGpbk8ACkGTLpBeHJcw5mD3q9WaLpT1W88ANP68CQLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JhF3R41P;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C08606A33A
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 18:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96C08606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JhF3R41P
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso90165f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792695442; x=1793300242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+tKf5vPrDaOI5M5gTd4aFyXjI3r/OLdMYL4js+XQMM=;
        b=JhF3R41PjqwKSr1lg/42wT8Y1W9wsEw7F4bwvaCKdgAPFAm7nuF3Qp5VwD1i0e6Lvz
         46iCq/AZ5SV+4NYXeVjmRh4t/hbRc+t7L9JeAkL+HOFfNPGfDwHgfXZHET/lJ8uaAEM5
         fhFFmWL9iGrbElS+YhOs6u0C22xLqDRl4rZHIH796djk6SQ3NdCepwWrFTxGm35mU4R7
         +oxw85f96E2/yQ3Au8UwkQ6rLzHVsJB5/qgmQHnHCj6t4w3HK27rxHYH7Hy6ddTahREx
         QCQBHJ1KPKZWPseoFsqyH3X1cA16PQcd6VbFgnaickkzrmoqUcSgQU96Li3xv/LKLeh8
         V0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695442; x=1793300242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+tKf5vPrDaOI5M5gTd4aFyXjI3r/OLdMYL4js+XQMM=;
        b=N80wybhv3C24cgyIVsl0ayMyB1lad6kPCddoRWSoyABtXgioJMZ8pb5GhhzacZ7EHk
         AzaTipwIVSpsSFW4kLkLMRncq24wO9E20dRjtX1A5+mj6aOVBD/ky6dUMClBX4RO4zsM
         KIK3X7kdh1ABTdxNIGp8NXOjHPD5CsQjva/bXXjniQZmya86w2j9CYC7V2PVUORDuSOJ
         QBQmMKLo2+DgoywlI4svmt8lXrE+JXZ2AlBttLDDHb0VRQ5UWV4N4ZizqmKqNsvTX0Ho
         zL+YVon9dfMJ+h/VunUgOIVj0AJy3m1y1IKxo6AhFRX0sKJifBwSpQiRPcCPpgdo8XQQ
         SIvg==
X-Gm-Message-State: AFq9FYJBcdxnPekzuOpnxlROQLc2EO7zLdRWEC5koE+8oQFqVfanHMQ9
	SbFD5zGWayPRVT/dPc/+subTzLFunlrYYxXBLPPCWgj2vN4yfBxkzmaP
X-Gm-Gg: AYBFou0eAyw4GWh9NAa9XdSRxAINXEUmGugf8aLl+PHhXBykiN66/1GCNYwi7rQ7RlD
	fNQH+YayyU4HpotFLKQd3bImnf7lQHb/imqj3JJeTbGKNcOnP2IJ4sQgEvRAKoBdJiOMt8LY5jN
	uJzTIGt2iJIk94vUcfM7sFlti4yHul6OrPUMh2tquJxRJiJDqOTO9Om9pQxQ8M+Ywt4U8HgSU9L
	zHMT/scVE1tT+BoG6Y5wlY326ek6Wf/nE9ZUF+/k3/KDGkef1YcVsR9dhYC+BhxloKlYmbnjPmt
	uQqPuay1k8INKPBOWisEnsZcG+3Y5Xgc7oOUd9fa5wv8of0ZD+XC6NY+qyghw0kTOD5axgbK23p
	o83miYCsiZqu7yCcw5Kgo1Jp4Hx/wW4yVxoL3yDs8dH+5eBGi1Mbt62xRpnZO7oXhd/o5iiOKtC
	McDM5qJrNG4kk+rTDopPMAntSo5F3SMtuxfRqP791SxwfjcXB0NstnwgAlgPksI4Is+KhkEjc/K
	hFGbocWCocUFRh8mJD0fj8A11U8vHadHt9lfuGiLPwclC3rLvkPfw==
X-Received: by 2002:a05:6000:4b1d:b0:48e:cd3:b3da with SMTP id ffacd0b85a97d-48e2644f800mr12253638f8f.5.1792695441958;
        Thu, 22 Oct 2026 11:57:21 -0700 (PDT)
Received: from localhost ([2a02:8308:b092:fd00:d900:ff27:14a1:f032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37a0f66dsm150275f8f.53.2026.10.22.11.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:57:21 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
Date: Thu, 22 Oct 2026 20:56:42 +0200
Subject: [PATCH v4 3/4] iio: light: tsl2591: report saturation
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-first-patch-v4-3-90b2fc6e8e28@mycroftmind.com>
References: <20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com>
In-Reply-To: <20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Joe Sandom <joe.g.sandom@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jan Remes <jan.remes@mycroftmind.com>, Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.16.0

From: Jan Remes <jan.remes@mycroftmind.com>

When the TSL2591 sensor is saturated, it reports its maximum value
(specific one for 100ms integration time, UINT16_MAX otherwise).

When either raw channel becomes saturated, return -EOVERFLOW (like
as73211 and si1133 do) instead of calculating an invalid number when
reading 'in_illuminance_input'. Keep existing behavior on raw channels.

Note: Datasheet versions differ in the saturation number for 100ms. Old
2013 datasheet lists it as 37888, newer versions say 36863. Use the new
value although the hardware can report up to 37888.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
---
 drivers/iio/light/tsl2591.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index 8cfce720efb9..e3092ae77a11 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -139,7 +139,9 @@
 
 /* TSL2591 maximum values */
 #define TSL2591_MAX_ALS_INT_TIME_MS    600
+/* Maximal values per datasheet [v3-00] 2023-Feb-08 */
 #define TSL2591_ALS_MAX_VALUE	       (BIT(16) - 1)
+#define TSL2591_ALS_MAX_VALUE_100MS    36863
 
 /*
  * LUX calculations;
@@ -379,7 +381,7 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 	struct i2c_client *client = chip->client;
 	u8 als_data[TSL2591_NUM_DATA_REGISTERS];
 	int int_time_fval, gain_multi;
-	u16 als_ch0, als_ch1;
+	u16 als_ch0, als_ch1, als_max;
 	u64 lux;
 	u32 rem;
 	int ret;
@@ -417,6 +419,14 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 			return gain_multi;
 		}
 
+		/* Check for overflow; special case for 100ms integration time */
+		als_max = TSL2591_ALS_MAX_VALUE;
+		if (settings->als_int_time == TSL2591_CTRL_ALS_INTEGRATION_100MS)
+			als_max = TSL2591_ALS_MAX_VALUE_100MS;
+
+		if (als_ch0 >= als_max || als_ch1 >= als_max)
+			return -EOVERFLOW;
+
 		/* No visible light, this also catches C0DATA == 0 */
 		if (als_ch0 <= als_ch1) {
 			*val = 0;

-- 
2.53.0

