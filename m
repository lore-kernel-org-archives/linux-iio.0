Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5474514743
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902423; cv=none; b=cB3occlFUQKnUmwTlKlFt3HiaOXfMs5wyiRrRIVYw72ZtqBHj6nCO6O90N1yy+vy8ieYL8n26p0Srpev2//D5YXwjaLc78dA19oxzLXB/2J8lpppJ1pep8Yg7WSEQOMuJ5Mt3XmkRlBMZJNrCAXH/hxHrH0q3Ag8iibi8xD+LJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902423; c=relaxed/simple;
	bh=kUxVa5mGjgd3Hwbquj61TOyvRjlHlIbwg1qSJUSNsZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuQO0aBE+bGhmTcFs+nM2g1DA715tLtPArxyElda5/T4QHtsNEQ+tYqDw07C38iFd3hDIOhXFI3zW7Y8DmBwVsU+bpBO7SBW4yi8AXcPlECXhCRNvhmBrzZo2B+CRTuCw9e2vdxkf3UeQU/y0jQ9oXfCsoJNeBiTEDSVDb7rlt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUdbCzpG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUdbCzpG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so26430185e9.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791902420; x=1792507220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+dcTjNdpl6sXOUJMEgViEWWx4Hbq5B7m0gg3ou9K64=;
        b=JUdbCzpGr9iiCG2hIh2ePKqwJAsecubVQ+FqoYeRnDzjwDraryHs1+4NJmImZosUzq
         UtXLIzEflFlc2+mUXk7sA8gfb8Q7FyiP/uACK2VV4H/4qQgbgn+21cyis76rQELq03d0
         /g7PaOLzLsstioL1whpnBtq9ufPI1c/JOY8y1Rz1lXS7iV69dbZiw6wa2t+PxcjpHiSH
         eJgZUAmo6I+fPW6eTJpDDpExRN7kGL6f7+ueQYPYWQQSpzmZwQAui0AUlWimk7/pS4eC
         zda/p0A/9DzHx28noJQ2C85uwEqsA/gzY+KZr3U/8EJybBjRdmLBM/Xd+uutbHdVCI4I
         B0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902420; x=1792507220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3+dcTjNdpl6sXOUJMEgViEWWx4Hbq5B7m0gg3ou9K64=;
        b=XNlQedcnnZsEyfyHjT2wim3LO2ZlAp54JYIOvxnVH2XYX3frOCbvm/zpQBg5YJMtJv
         V82xpxT0quTBrXzeEHRwjpGb0hvuk8aFCdOKcfESSPbJOjtDyKhjf5XruKtfsf/fFjGl
         fVDmCAeBE+yi5KdYGAB7lGqb8vUzuGLsskI3kGjkx8rqexBZck0jkoAlGl/ILPqmFHJO
         pEcENInbMtv8rURlQtVID5bRRPDk981LsccNCIQCj0f0nweX0/sumioEgtsu4LpE8e1P
         6ncPaRhQbvfjtqzOMsufqEB403wa1s4doZgbv/GGIikHpT1+gtSrMqsEVQbM08omRQt4
         XoVA==
X-Forwarded-Encrypted: i=1; AKwUvBwF0EnxOxjFYXTKC9XO/AQfP0TmK4pWBg7d96em9U31mRBHI5db/cQjNjIFL7oi78nsMSiG2KqWJ5M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrMJTNedM/QPDcDGpDWI+XouScFOeTDDYIQ0eAbRC72Idprvur
	aqQtVfJ9R4iWgWICscalyD3xttW9B8KXWjqeqUNiftVhwu5mipotiPv+
X-Gm-Gg: AYBFou3OXjLy9qOgtQw3GW+pxE76e5oNERe2qApMOL3ZvnbDwRVUVXoVCCrpJw8t4aZ
	bW8Zz3lunyXzOOZMz+/YiZCzyiJMiR081ifaRMTTpzkfIM7ntIT1wLvBbC+ZykVigLr8fhdu8NW
	xjPMgniL8qz0HOkpTB1RFMQciraxnuQTG+VPpmzX6zaIWp96kPZWLzkXoQ/KORznP1Cn3OIa7gG
	nElA5Yf1jwk5Y+EjTciLO4O5M65BHmw6DHnp3VudUAjCyUQxB0O5lOmrm1dHlxXfLdx14Ohyfau
	9C0/necOooCkAVxvc60eASloC67sxaw/ntHP562M82q5s/tZVpRQAch5n3gIK2kKE6wEWTkgvGv
	jna013NOQr3gP1ESmPjuj8ldP0n5fIufK6qCb61qw1Oc4YwO5yX2xCbdRJ5fPPT17uf2OOOX6N2
	vSJLsHtKyrq0REVueYipK6VR5zHeMxON78h9dgy1X858sLnVk1xiPM8isxvJx5ZLkf9TiJoUMbR
	YLsRzqX12rkjsk6ykEv4nucl0GWI0QF
X-Received: by 2002:a05:600c:8b70:b0:4a0:108:3b48 with SMTP id 5b1f17b1804b1-4a18e4a174amr246218995e9.7.1791902418613;
        Tue, 13 Oct 2026 07:40:18 -0700 (PDT)
Received: from mm-ntb-00805 (ip-94-113-240-150.net.vodafone.cz. [94.113.240.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bb6b3cbsm294892585e9.0.2026.10.13.07.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:40:18 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Remes <jan.remes@mycroftmind.com>,
	stable@vger.kernel.org,
	Martin Triska <martin.triska@mycroftmind.com>
Subject: [PATCH 1/4] iio: light: tsl2591: don't divide by zero
Date: Tue, 13 Oct 2026 16:39:40 +0200
Message-ID: <20261013143943.436816-2-ciakval@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013143943.436816-1-ciakval@gmail.com>
References: <20261013143943.436816-1-ciakval@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Remes <jan.remes@mycroftmind.com>

The TSL2591 has two raw light channels - CH0 and CH1. The algorithm for
calculating illumination from the raw channels requires division by CH0
(which can be zero) and by "counts per lux" (CPL) value which is also zero
for (gain = LOW, integration time <= 400 ms).

Furthermore, the algorithm assumes CH0 > CH1, which can be violated in
almost complete darkness.

As a result, reading from 'in_illuminance_input' results in
division-by-zero whenever CH0 is 0 (complete darkness) or whenever the
parameters result in CPL being zero. This results in kernel oops on
x86_64 and in reading the value as 0 on arm64.

Fix that by:
- reporting CH0 <= CH1 as zero (catches also CH0 = 0)
- updating the lux algorithm to only do the division at the end

Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
Cc: stable@vger.kernel.org
Reported-by: Martin Triska <martin.triska@mycroftmind.com>
Assisted-by: LLM
Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
---
 drivers/iio/light/tsl2591.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index ef3ed9635a1e..f56d31404c25 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
@@ -362,6 +363,10 @@ static int tsl2591_wait_adc_complete(struct tsl2591_chip *chip)
  * Scale values to get more representative value of lux i.e.
  * lux = ((C0DATA - C1DATA) * (1000 - ((C1DATA * 1000) / C0DATA))) / CPL
  *
+ * CPL is not computed on its own: at 1x gain it is below 1 for integration
+ * times under 500 ms, so the division by LUX DF is folded into the final
+ * division instead.
+ *
  * Channel 0 = IR + Visible
  * Channel 1 = IR only
  */
@@ -373,8 +378,10 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 	struct tsl2591_als_settings *settings = &chip->als_settings;
 	struct i2c_client *client = chip->client;
 	u8 als_data[TSL2591_NUM_DATA_REGISTERS];
-	int counts_per_lux, int_time_fval, gain_multi, lux;
+	int int_time_fval, gain_multi;
 	u16 als_ch0, als_ch1;
+	u64 lux;
+	u32 rem;
 	int ret;
 
 	ret = tsl2591_wait_adc_complete(chip);
@@ -410,23 +417,28 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 			return gain_multi;
 		}
 
-		int_time_fval = TSL2591_FVAL_TO_MSEC(settings->als_int_time);
-		/* Calculate counts per lux value */
-		counts_per_lux = (int_time_fval * gain_multi) / TSL2591_LUX_COEFFICIENT;
+		/* No visible light, this also catches C0DATA == 0 */
+		if (als_ch0 <= als_ch1) {
+			*val = 0;
+			*val2 = 0;
+			break;
+		}
 
-		dev_dbg(&client->dev, "Counts Per Lux: %d\n", counts_per_lux);
+		int_time_fval = TSL2591_FVAL_TO_MSEC(settings->als_int_time);
 
 		/* Calculate lux value */
-		lux = ((als_ch0 - als_ch1) *
-		       (1000 - ((als_ch1 * 1000) / als_ch0))) / counts_per_lux;
+		lux = (u64)(als_ch0 - als_ch1) *
+		      (1000 - ((als_ch1 * 1000) / als_ch0)) *
+		      TSL2591_LUX_COEFFICIENT;
+		lux = div_u64(lux, int_time_fval * gain_multi);
 
-		dev_dbg(&client->dev, "Raw lux calculation: %d\n", lux);
+		dev_dbg(&client->dev, "Raw lux calculation: %llu\n", lux);
 
 		/* Divide by 1000 to get real lux value before scaling */
-		*val = lux / 1000;
+		*val = div_u64_rem(lux, 1000, &rem);
 
 		/* Get the decimal part of lux reading */
-		*val2 = (lux - (*val * 1000)) * 1000;
+		*val2 = rem * 1000;
 
 		break;
 	default:
-- 
2.53.0

