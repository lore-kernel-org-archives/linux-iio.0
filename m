Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311605;
	b=F8Ey5s9kV8vstgddJJLK/5Uf249voZJx6iBuIC84V0Tx1tIZ+BfTD4QYH0dS8UEEYota
	 R2tjukE/Oqxn543EzkYSUPOaEQmNaJ51FiswTHj1dgei7K2MNtVZCmpvxYzwIc4V1S5Si
	 O5TtTNrHgaV2xWgKGa33MG9+kV3TVAjDxBDohiM/G/4NpKR7INiirMM+zThUTjYW3ZVA7
	 BpCogKGZdL5HsZ5TWCZ9vaK4X6lQoRSrHimdnkuwT5swwSBKfw3KCnvV1i22FCQ44qX5J
	 QNvyJQJEnLHR/eL1YKFwjyxERRqiBHMfTRqukJLT1be8JxvE+r7DKfG1rqtOxo7zH6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CM95CZe0g372W/3tOJOodM15hD4zC+QYzaoxnr6paYk=;
	b=a11qLe56ztcxpqLvMo5TJJm62Hl5OqtFeQxPYyD/pIMWue6dA+DgmOCKjH2POHHZZrFH
	 MQ4ddNv4JuaCC47AtsA5xTFfRTFnokpy6cg/0+ncMGm/m/0ArwZ8dqEpqssPjFpIrQry1
	 3LbLXD38iPzmANzV76rCpQXAsKLCcLyihvHnlGD+pXQyD2EyHnqQcZDweJxWojhvNLQ/+
	 du0Qi+PHW08e59BkXHcJ76EcbCTUuj3UEenHmIJFIdkY/pIITbvmId8muktnR/nV0U7BW
	 82fF8Opay2SVEgHkOvT7Flf++VAyurbMuoYaj31Nk60NxOUdxH8LWSdI/Wbplfn6U2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oZ5rRgMn;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6708A60A261C
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 22:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6708A60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oZ5rRgMn
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5be3ea5a7adso138313e87.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793311603; x=1793916403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CM95CZe0g372W/3tOJOodM15hD4zC+QYzaoxnr6paYk=;
        b=oZ5rRgMn3RSuBdn/cBqQooDbj1WBhO5sSuLFa8BctNJFppk99D9r0krKoBHRV6Vi58
         0nKT2PAT8VAzmxnXWqY/XW8jwVghCEANdykJYtu3KIu7oNkEeUJYriw3t9rxP6ikgaiB
         vCLcG334yObsKLqnhsENfm+s8lEiWftQPZ5p9UkpNKgreDLpvfdrxkWas/PMPLJ6q8Nw
         gcl/biz9E1iL2KeM5+h5kSltnghWlxVX72XSlqv+F71YCLTieUcIYZhfBlOn2VnTkCOi
         h1/y1w+/rfKaYggLNqCkKdQQSeL5KEjYixURLpxPWSjw/dhbdJ2o7csZsrt91TsdSow1
         yjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311603; x=1793916403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CM95CZe0g372W/3tOJOodM15hD4zC+QYzaoxnr6paYk=;
        b=JUVuFb6ZKoPKO6lF+d8fReTzTDdIvjbI5Zmi70x/4cWmPdvnWqGJf9nK7lRgzC6Zfh
         r2fWyxLixRaoqgr4eZ+PkTtQiDE/t39qj0CnRtzKvDEpX8PfdGONOCJjHg2hSdyG4cAL
         qkOKH8ZqWPuncP/B4Vdr/+Kg3kkdnueejq4E8DMWW4EsZN88Jjwd8scPfmdrRkB7Huii
         urN+6AeXnJS6+WtBWypAENcLDw656OF0pT7MSd+cyrkXTtWcpw5yYUQWCMqHE4u0YhvH
         2SszZ0M0YgR197YAd/H31vui3ifdCZhmzEzSuG6BF1VFU9A2bFY78HWA+2vWAfdo8TNJ
         a08g==
X-Gm-Message-State: AFq9FYKeZ4TuFveoNFokZF19EsXoPqdwF0Za+THeqK1uuyuPXmnVjhAU
	Gp2H1syBJccELTtz2iMESk0fc59tFnFp84ZOW8cAOIyIrdNgDH8H+Q0B
X-Gm-Gg: AYBFou3+eJajQlBeySZm7+S7p+ej8WTQsAUWf+8Vf2cfow0oCGKX8KGYsNIn8Q7u1UP
	IwZ67i0TymkMmf2crlRvm+mabjh+sgbZVgY76vyAC6+2tFZB3daVbzLOdk6iwR72fSvKDPnUO3a
	z1feawUcBQLgfpE60k81asPX6t9L/Tl3AQfYPS9tCdc9T09SAzg1vZlADE920DpFmS3nXDJpss7
	q1kIeF4z87JvmiaFFWxF0d9VrDNaszKsYQxZ4hCwQYTFGO7H5CuOHAT1qw1Cp8Jy+Xw1Wj8V1qP
	1k2ftUptvYjdqHoxAB7STqm03a/XYzWgN3xTNr2KYQ4HZsHiPKYaBcxE92pnVwVo+7lazBlA/lk
	iSzzNdLW1xuI1lQAC29V1/MCj0ISVUi86cWwUx+s5kWFy/Zd7bbIgWGdgY3R2Gjkxsrzu/Zrv6C
	QkCO1SeaFFgexyV51ITuSRGQUNPCfujoIs3QPq2/3I0BLhO9GXH8xjvwsYlgb4/z+eRWNJm6SzM
	KqPlXfzVg0IxD1kEy2D4Om8npSMX+yt4uFYvzpFJrC6OImeHW8XDZsL3B/TqZtD/rkZDX+iPJZT
	15mr4QNFKHUajCsIxC6Ts3xvcyE8u/DFE/gUr8kzLfXqZMjTNbGEU95/in9nl1MXZvKdmqDIUcU
	SVXavt7u9TxNFb6NLEQZyDWlMtnIeSpDdfoIk8Dk=
X-Received: by 2002:a05:6512:2311:b0:5bc:ddf0:d96 with SMTP id 2adb3069b0e04-5bfd957b9a7mr87098e87.59.1793311602508;
        Thu, 29 Oct 2026 15:06:42 -0700 (PDT)
Received: from yantra.. (nekmmqtmquaao4qwdoc-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:6842:e549:8c95:f73c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfd9c507adsm9605e87.65.2026.10.29.15.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:06:42 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH 3/3] iio: pressure: dps310: keep the user's settings across a timeout reset
Date: Fri, 30 Oct 2026 00:06:35 +0200
Message-ID: <20261029220635.18816-4-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029220635.18816-1-zoone.rupert@gmail.com>
References: <20261029220635.18816-1-zoone.rupert@gmail.com>
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

When a sample never becomes ready, the driver resets the chip and runs
startup again, which writes the default rate and ratio. With 64x at
4 Hz set and the chip put in standby, the next read recovers, but both
channels are silently back to 1x at 1 Hz.

The register cache still holds the user's values. Write them back
after the reset, before measuring starts again, and move the defaults
out of dps310_startup() so only probe writes them.

A rate and ratio the chip cannot keep up with, such as 128x at 128 Hz,
now keep timing out instead of falling back to 1x at 1 Hz.

Fixes: 7b4ab4abcea4 ("iio: pressure: dps310: Reset chip after timeout")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260921183132.233136-1-zoone.rupert%40gmail.com
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>

 drivers/iio/pressure/dps310.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 29778f25bb33..c364fbaeb3fe 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -306,10 +306,9 @@ static int dps310_temp_workaround(struct dps310_data *data)
 	return regmap_write(data->regmap, 0x0f, 0x00);
 }
 
-static int dps310_startup(struct dps310_data *data)
+static int dps310_set_defaults(struct dps310_data *data)
 {
 	int rc;
-	int ready;
 
 	/*
 	 * Set up pressure sensor in single sample, one measurement per second
@@ -328,10 +327,14 @@ static int dps310_startup(struct dps310_data *data)
 		return rc;
 
 	/* Temp and pressure shifts are disabled when PRC <= 8 */
-	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
-			       DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
-	if (rc)
-		return rc;
+	return regmap_write_bits(data->regmap, DPS310_CFG_REG,
+				 DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
+}
+
+static int dps310_startup(struct dps310_data *data)
+{
+	int rc;
+	int ready;
 
 	/* MEAS_CFG doesn't update correctly unless first written with 0 */
 	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
@@ -551,6 +554,12 @@ static int dps310_reset_reinit(struct dps310_data *data)
 	if (rc)
 		return rc;
 
+	/* Put back the configuration the reset cleared */
+	regcache_mark_dirty(data->regmap);
+	rc = regcache_sync_region(data->regmap, DPS310_PRS_CFG, DPS310_CFG_REG);
+	if (rc)
+		return rc;
+
 	return dps310_startup(data);
 }
 
@@ -1450,6 +1459,10 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	rc = dps310_set_defaults(data);
+	if (rc)
+		return rc;
+
 	rc = dps310_startup(data);
 	if (rc)
 		return rc;
-- 
2.43.0

