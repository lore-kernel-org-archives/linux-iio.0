Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D97654528D
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987435; cv=none; b=j57nyFdHuUyWw7asc3hzoeM+hj4+lSjrvJlsL5+++MO8AMhcyvd9ezDJYbwn9sKHfcgL7YkoKZ3KPzqkJpzY39pK0pNYctXEUDS04a3uGO4/LPImPhg7MyO1tMmOZEV2lv/DihmOy9PgT4Ftw3KdODzy3koayzt+cNx9+7H6RCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987435; c=relaxed/simple;
	bh=12MRTeFclhweew1C1prLdAJcV8GatmH8datWPSP+CmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCEvDT5b71WgTJDMOsaCkMkPP0iqtHCpcV9N2lWOKQKEo29aR4Q9vDOqswRm82ig9nyaBQPIUIfgE5HMZvS0rIngmDHbsdS3gTMk3L8gTJvd2CD0I15TfRtCcEXaCgn+TsaeK8a/6MRalUr3srb66IdGg6q32K05BuGZPzhyVV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i12/Lt/H; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i12/Lt/H"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48af27fe287so588080f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791987430; x=1792592230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uoIt5WxqupAhldD1CTOZ4gXFLC4tvJghYLwden4T97c=;
        b=i12/Lt/Hw+alTi1MRX7ctEAeayEu1oKWeIBShiqhVtK7jFDCDLM35ab3qJ95hTQZUd
         B5yz6MfB6sp8Z09DRCs3IPSD97KNlmC9o5fIrUsEBcb4e+E4v5iG6qGV/EtO241Ndxhv
         JmoLdQKXmfs+pViEd1ROrhpN5XaHxQN2iGqv5aHoD3nhVQOe5xAt1k5+s41lGABR0djH
         X1a+TF592mNtsNPmaRbzUv/H15IfOG7rYx4y617evukY21i2Abc4mUZsQYyeuRTIY+pZ
         IJSh4JgNFFzYs9sQojSk/HnzYGyVrAkl1cx6fO2d/dagkaTgo2UnG4Qi5p6hPc0ncsdK
         WUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987430; x=1792592230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uoIt5WxqupAhldD1CTOZ4gXFLC4tvJghYLwden4T97c=;
        b=Tr9EUQReGNcitCnRJVjO/BTK6tj65l6e8Lap59FLqxA9qUiWqjpsjbm20GiMxyjbq6
         vsBRB2f+DHAmE7lSlc9I0F+v2j5r1GhQA7tn4mcFM/VBgOARy/yVxnYssGYjaKDd8IuS
         aELRTWcoVmxBJikY5J82NJu23CzvCzUqRHEU2nPfv1iUfHZjPVwqzyEX4DNbYnrMP6my
         KDLIDAosjTIxbfrXDxhZmcwt3qWbxao2xurT5Es02RWFLPW0++WMv74Hpjp8F6XlH5oK
         78MaHE4iVgQ7aeBL0t7fJl2oIrFhydTkqHdNJGJnoC47tMFKta8GZf4Hn2uPruqkmlli
         Ww1g==
X-Forwarded-Encrypted: i=1; AKwUvBxE+qw0ui8gJWLZjCZvX+D6M3MP/lb7qqi7DdoPS6Rf8lnrjgGFNe5tdqtZgakX8WTYY/QESbiHUFs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUsG2sIrg5tGcJudcoVyY5l5UNLjZVYerYHfMOw6SHS1JX6xxF
	MoWws2sTs/mz+h0o0ShszvNIhMWv0jOBZ08KrDhCo/9KKxixr+AT2U99
X-Gm-Gg: AYBFou318TRc8NF62tQtfKSUao418yzGY4xDLqEBTA3nDgpxA+vCbgu1ZBPqm0PIicv
	YvKa181WyrMd63Cigx8V6qn2ggkA7UkGcxxFWsDh9Xb6I4h677SY2ojtSHhtUfz9Zns+E28HmeE
	Wm5yBvqgC6GA8EKMLJp7uySi0ezWzj/zTAGUDeEKYXpnhvl0B3lPNd8p1hmOQJDWk9Y+O+eyoEW
	Nfu420RX+9ghkp7p4R8ZW25O87qhFGhimpmZtxfsvgsUCyqKb8/Pl9ih9Ubg8denKI263HpbmY9
	7AiidxfT0mstl1SwRuB+Gku6pby+OzzNI7QdP34kXFfKcQTaT/5IiVkQ+n4wjOoBH1PzzhhunAF
	007mBVAxJJofNNEzs0vrHspj134/n0SCW1Soq++q5y5S9JvsS+z7p6TN4F76CM04kpLpWO0xZN8
	sLVthVP+c7xqT1p8qcUMMnk1BGDrBbVgRNZ6ZYO0oQuOM6PQB+2RFZurE2uls2qjkJB/o=
X-Received: by 2002:a05:6000:41cd:b0:48d:f14a:9183 with SMTP id ffacd0b85a97d-48df14a934fmr841460f8f.15.1791987430359;
        Wed, 14 Oct 2026 07:17:10 -0700 (PDT)
Received: from localhost ([2a02:8308:b092:fd00:d20:6232:49ca:4be9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc5e0asm12209106f8f.50.2026.10.14.07.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:17:09 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	martin.triska@mycroftmind.com,
	Jan Remes <jan.remes@mycroftmind.com>
Subject: [PATCH v2 3/4] iio: light: tsl2591: report saturation
Date: Wed, 14 Oct 2026 16:16:49 +0200
Message-ID: <20261014141650.259929-4-ciakval@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014141650.259929-1-ciakval@gmail.com>
References: <20261014141650.259929-1-ciakval@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Remes <jan.remes@mycroftmind.com>

When the TSL2591 sensors is saturated, it reports its maximum value
(specific one for 100ms integration time, UINT16_MAX otherwise).

When either raw channel becomes saturated, return -EOVERFLOW (like
as73211 and si1133 do) instead of calculating an invalid number when
reading 'in_illuminance_input'. Keep existing behavior on raw channels.

Note: Datasheet versions differ in the saturation number for 100ms. Old
2013 datasheet lists it as 37888, newer versions say 36863. Use the new
value although the hardware can report up to 37888.

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

