Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695228;
	b=pPHbNbqD7HrIpF+3mqwDTnLfWwhzc7soIO1OSSTyB1sb0Vj0RU/bORmGaXOTiR9iC84E
	 wqfDUOuaLLUFQqimNgck/0vcEO7158a0NkSxg0LstgExaymr5zgScehDMV4enz3AmS3gl
	 HZH0sBXbbpYuqZ2R3ifPo17YfE9MbQhbSJRjkAasZ5PbLiZm9V4ATXt60OSGU0fg1bQeX
	 YtukDUJYZyBWO+Ij/ratmNMpXz6UUhP2Y8rEqiAN+SRZpf4diaHQvxpn5EemdQtVDUJJU
	 d+XA3lpCjHBEL8TwrHN0P9Jo3UqNXdpsn56xWPjLbVjRR/+H3rjnjQAwIk/yaiNBaKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q2xu2GjGe1J1BVkHf8m/d5zr35D1LtrCMJmYA+Hhslo=;
	b=1Z++G7i5rem39dGoekcrXB0ycidU8IHop4NErCM4PTE4kjlBnnSNe56iiUwvcXN7NNL1
	 ilzU5WbY6pCuWOJsQHEh4st/2tomjyk3qEkEdAJ8lncck34uV/DPq+ugisumdKrl9B/Mg
	 yauGuxK7NDkWCnDYxVrJngtafy71R80OW2NvfBeIOqy3KqSWHZgh/2KFXeRI5mF5/X08A
	 1H7XEzpwJnt3pInWnYLwJKrLSCsya68qBQdq2jx/FJF6lAWPfGLycnGA4QfbIVc3uaeBC
	 AWShuflgvPVzHqfWuA9e1kEE4tbWKS5Wri2rndwkbaM9AArOtF4DUCizirdXE3XrwvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=exj7Y8kb;
	arc=none smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73B606A687
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 12:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF73B606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=exj7Y8kb
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ace304021eso66324231fa.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 04:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795695226; x=1796300026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q2xu2GjGe1J1BVkHf8m/d5zr35D1LtrCMJmYA+Hhslo=;
        b=exj7Y8kb/3GEhGKzFXejN/pz3nNn3LERdMbiF9sMk8ow5cDrpKQTA9A8Xa7+FtJGqJ
         yLBB752LWI9j6lcOla9BY7VQnbXI2D0CcghQoDbZHZ0PR0uP62bMjJszvTXu+oIdL7pP
         fK/cueSVikZJrdalj0rnjZNJGjdH9shxTMZ4G8xvM/iYovbaEjsENUohCsk8AvLXWrIH
         5mhLVyr+actMeLvlB5vYsW2/RhEi44g+wDrgg4yELJh7M5IAE7QHRGiBElZX7BxgV7OO
         +/4+91rGGR1GoJ8hB/UdOa+H79f5nV9W5brMrlAN3MpfozaEzvlIX59v5SniTy/GFmjK
         QiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795695226; x=1796300026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q2xu2GjGe1J1BVkHf8m/d5zr35D1LtrCMJmYA+Hhslo=;
        b=PtMSapX1dJIJ/SUuq3cuGYyxo8gzHgtA5K6bla6ldJ8UT45/woeH8NERKijmgXzsF+
         YjZrI/jN50xwO+77SETRVjNFegb/IjO6OCZK0Fn3w23EjOetg7QSL7TsekufPBkKm49B
         L1wu6JEMTj4SkTgxbY+ZA+Wsnxj7IbadRnucKyZp9HnEf+f+C45TFGWFaXrmrzTShHDf
         YuqM59n0M1A/NtQDrDFalZ8wgQv3RD5Zrd5Zu2nR8vidNRsfI5tP4fJQbSIXL0s3oj1H
         rQxb8GRU99FTGueFqABYEDBVOt/exyLCWxYrrTrAQ4Z3YHy80NGSkz+JOr/3SdpcxTmw
         ahVQ==
X-Gm-Message-State: APuU4Z83bM1By1atHbw/3kldKJJ1bWNlT2jITEskLrLUEy/RugWsYjhE
	q4oruKONelUmi7t9K634/68ujw6o8F5OwySgFcMpUTQpbzX5jFQfTxj+lO+9pw==
X-Gm-Gg: AZFdTZcGMU9dxGKYYi4kB0X6g87+d2iYADIzE1D8JRjmlRrP0Se3iVTfcOYaZkhk+WO
	6TyR8PetcfH7NN5OJoIYH3vkIS3vCwjRQLkOs6HuKdaceGziPQDUvpI+9/8XVB1oRQMSr1XgA/O
	wdhS8MoCNFQhGRm6SHktQsR61rlS4DHR44dphqJJNWrcCP9prQWxtnSKUUmL1IYyRA1m7DBiuCa
	/DqP/dYeeYVUacwOTzQpgCedIHGSa4bxq+5nHs58lh8ye4ccx1zGpKzlOnpi1BBUUERWXbrncsb
	JMieGgD6yxCctKa5wJ5oMewPwNmDeIChI9oRzvmrmJ4R3H94uyeVcroLPdlUvBcAa6xvYRirlCA
	61jBSDh38fAn1CO5fOcwZrwlaLO3aOj9dwNuxAP1HwqYgPkUAaxYw2MRKtvA9kU9FFG/2HaCjdw
	ezwww16DYuv2AI0e1v8oPdEXBFC8QS5Z662aCAFpjnzJhNzQJ0zyfSqips9ghoPnTx/PzZ6c5mX
	ZnYxqXt44HYUPXEC9PphpnUBbhpcyOXv9CePGEaSu+OQcgA5g+48cejOMX+shQGftWlyUHntt2F
	ccLu0+OLxS51D+CoOXPquKt6DH3Uy/A9QTuzQBIxO5gNge/I5sjH0WHJrKIaGyI9NFG3Cj1oeuQ
	3YfW0TVSlYLu7d4edQlOAH8+iDTorL6ZeV6cb
X-Received: by 2002:a05:6512:b88:b0:5be:3444:57f1 with SMTP id 2adb3069b0e04-5c1bc85f23amr6082541e87.63.1795695225993;
        Thu, 26 Nov 2026 04:13:45 -0800 (PST)
Received: from yantra.. (nekmmqtmzjx8yvukhae-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:68b4:f70:61d8:6e86])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8044e8e0sm56541791fa.5.2026.11.26.04.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:13:45 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v2 5/7] iio: pressure: dps310: use time unit macros for sleeps and timeouts
Date: Thu, 26 Nov 2026 14:13:28 +0200
Message-ID: <20261126121331.10438-6-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126121331.10438-1-zoone.rupert@gmail.com>
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
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

Write the microsecond values as multiples of USEC_PER_MSEC, like the
poll timeout next to them already uses USEC_PER_SEC.

After a reset wait 20 ms with msleep() instead of 15 to 55 ms. The
specification says 15 ms, so this keeps some margin.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
v2:
- wrap the poll call on logical boundaries (Andy)
- msleep(20) after a reset (Andy)

 drivers/iio/pressure/dps310.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index f802c2c59072..1d46817ad04a 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -20,6 +20,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/devm-helpers.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -103,7 +104,7 @@
 #define DPS310_DRAIN_MAX_MS	(2 * MSEC_PER_SEC)
 
 /* Make sure sleep time is <= 30ms for usleep_range */
-#define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
+#define DPS310_POLL_SLEEP_US(t)		min(30 * USEC_PER_MSEC, (t) / 8)
 /* A period plus a measurement time; silently handle error in rate value */
 #define DPS310_POLL_TIMEOUT_US(rc)	(2 * USEC_PER_SEC / max(rc, 1))
 
@@ -369,8 +370,9 @@ static int dps310_startup(struct dps310_data *data)
 	 * Calibration coefficients required for reporting temperature.
 	 * They are available 40ms after the device has started
 	 */
-	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
-				      ready & DPS310_COEF_RDY, 10000, 40000);
+	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
+				      ready, ready & DPS310_COEF_RDY,
+				      10 * USEC_PER_MSEC, 40 * USEC_PER_MSEC);
 	if (rc)
 		return rc;
 
@@ -558,7 +560,7 @@ static int dps310_reset_wait(struct dps310_data *data)
 		return rc;
 
 	/* Wait for device chip access: 15ms in specification */
-	usleep_range(15000, 55000);
+	msleep(20);
 	return 0;
 }
 
-- 
2.43.0

