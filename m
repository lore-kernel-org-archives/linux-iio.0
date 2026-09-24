Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624243BDD5
	for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790247606; cv=none; b=qREAYgUZvaPEP6pPnn5zD+Ioj/PFiaUXA0h4g1d6Ljcu2B6L1psPVxs/1YpSr69f8tXCK+uMjeNsYvavY5ueQwhSgMSyESqxixYYmDwJH4EXxC6iuIR2FXIgeSiYOnBw9cElTD08OjlkbBbqVK0HdJmiU08CGmqBda8y3kp1WWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790247606; c=relaxed/simple;
	bh=R8/zNeA1183GjFYCkqBaYfGjkmgQSMkOqPFph5HP22o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YIAhOnMsj5tookOovmPBHtJcFS1DL7Lo9R/nQE636GrR71dh4GM7jSuLrS6NZ0vIkeGm6/54OoCP+iaJ9GYesFyfKKlqkPvbSsHD9pzgLcoTqFar4ygeMQG3dlQX/IkuIgfermcrkjzH+ppkAVd24ivV7Y0pTfXPrZdWEdqn5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECQ//m1F; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECQ//m1F"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c254fa663bfso328801766b.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 04:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790247603; x=1790852403; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v+pOxxYYEV4wxah+lHWFr1aWlk7fFLFIYKT2k0YkxRM=;
        b=ECQ//m1FLpWiBa/g1V7iCqvqjkQf5jJvcdwib1YBABTSuXr1I4qu2imKgw1xoWmpCr
         aZuPPwxdxlEy9p8oqnpiPW11+R4cYXmLTLOg6ehts6nGvSe5HhNttsRERjHwQB5GhD1X
         NpPBjxsie1y53HlNf0ruyESJwBrHR3qC/rmps4ujuCrcTDtm6BbvGwTPeIEUG0ZV5aU3
         eSZa+SFyzxED2w/279DsnV0uqx6iDV71bAnnuAo8GMjdACQvhKQUHFqwYbacv+EyXdtG
         S7YQx8kopmMiix0jn4Y2XPTaOGeHWFPYiG2HbNoPl3u94EtTu7eZsNTmkIDUpkdE310a
         FD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790247603; x=1790852403;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=v+pOxxYYEV4wxah+lHWFr1aWlk7fFLFIYKT2k0YkxRM=;
        b=H+aGNk1ZnRgiLwDTgdAaRLrlA3UHGBheLPPLMWDHDo2Jq/X5GxXRaiAaDOnkhFIBH0
         FKYir1eOvrOz7Pl0BwV73Q+/Kd55XOrEtcgTwA+AiLvL5vxOthM9rPh3/Cc61E72KHju
         i7iMrXGa3MpQfHdGlxS/1hhbL6pxCRgrV1YNGdOtI6a7NvkUvcXQc+d+rdOPPW8raq/m
         GL/CdYKxNQO/UjNeyECmlZ5EBZiNEB+98JKTphFxA8ry4EipRO7FrZOQGu6h2pvWLVud
         55J3voXXhh1oXsmxrK3pT03qWTacD7iHLhG+WSMIm/2/efM3SV6NlXq0z0h6n5f5xwDH
         E/7g==
X-Gm-Message-State: AFuF++mQZvshUG1QdZj2eNpqDYSYJNKvzxNzcttRE9nawJkMSNb+gECv
	ZbFuaPanmJCF0A1wkX/EC85yB/JWiJi5nlTSqTcEtoUuI1gmrXoVB6ul
X-Gm-Gg: AYBFou0xhdagCpwhE7oNqPzENCSl7GNbgoJ6JwPPy4NeH29tRXWEczAYu6wGrZ2jvoE
	e9xv8IWtkLvAb+EBOSUBXgBnYJK8N5T8z8Gh7eXkAW4iG5GT1Y32RAxZ0cBDvGwS0LWSSSMixhe
	daXT62DY6KjJdor24ZMylysez+lrSjB92jpn3Ha1mLtWyVPkqLjcXL7SLpnNHDyXk6o0NfUVJ2f
	4E4hfj4Z80Cj1rgHKfNr1oJw9mc6wiNw4rAvVXgzlVqdUibAi5o+Mj7TnCoQhgHS7nEQolghyTd
	GE+DniKKzWlElzRMRllq1/d3ud7e4H/4LoerRmk3lkNlGYZq2R5Xy/vq4G/URzNJDjFYP85avyT
	T/33/4pLBWWUrBTRONWc1PUWItWuZTABhGDiHXkSMCw/crAqzBlLfbik0zuENpCmLBu4O6Mw4BR
	FeyxsCD1OfAwkOkkIIy/x79+wgDDzZrZjOj18SMablE1Rq7skTaJEhbK/dZjdUx/aaeLDGrBZXu
	Kd4TO3PZ6RlhIv+
X-Received: by 2002:a17:907:6ea3:b0:c25:c67d:53cc with SMTP id a640c23a62f3a-c2ac22da292mr180150366b.8.1790247602745;
        Thu, 24 Sep 2026 04:00:02 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:105:5e97:3d03:7131:95ba:ec76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6b8b32sm281806966b.49.2026.09.24.04.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 04:00:02 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 24 Sep 2026 12:59:57 +0200
Subject: [PATCH] iio: light: veml6031x00: Enable internal calibration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-veml6031x00_als_cal-v1-1-c046a5e4e998@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKwCtWoC/x3MTQqAIBBA4avErBNmFCK7SkSYTTVgPyiEEN09a
 fkt3nsgcRRO0FUPRL4lyXkUUF2B39yxspK5GDTqBq0mdfMeGjSUEUcX0uhdUNYYspPHiVuCUl6
 RF8n/tR/e9wOALRfRZQAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790247601; l=2218;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=R8/zNeA1183GjFYCkqBaYfGjkmgQSMkOqPFph5HP22o=;
 b=jnW4blAfSvX+pvDYqU4nXCF8vGPFLZxfzzoR3jlVuSjMme0nZpXKCk5q2SxbvlqjPEBqXJ+EX
 J3ExtTL9NaHB6J2N3l+qWWY47RCFg/9JLfWoEAWW6HBnrbDf1FLP4/X
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

Enable the device's factory internal calibration before entering normal
operation to improve ambient light measurements.

Set ALS_CAL during hardware initialization.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This feature is not documented beyond the bit to set in the CONF1 device
register, but after direct communication with the manufacturer and some
tests I carried out, it should improve the ALS measurements.

I could not tell much of a difference with the first device I tested,
but some other samples have slightly improved its measurements compared
to a reliable reference. The manufacturer could not tell me why this had
to be configurable at all, considering that you can't calibrate the
device on your own, and especially why it is disabled by default. But
fortunately, this feature only needs to be enabled after powering up the
device, and software on/off switches do not affect it.
---
 drivers/iio/light/veml6031x00.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
index 085a6e2ff717..f6308498e422 100644
--- a/drivers/iio/light/veml6031x00.c
+++ b/drivers/iio/light/veml6031x00.c
@@ -52,6 +52,7 @@
 #define VEML6031X00_CONF0_SD        BIT(0)
 #define VEML6031X00_CONF0_AF_TRIG   BIT(2)
 #define VEML6031X00_CONF0_AF        BIT(3)
+#define VEML6031X00_CONF1_ALS_CAL   BIT(0)
 #define VEML6031X00_CONF1_IR_SD     BIT(7)
 #define VEML6031X00_INT_TH_H        BIT(1)
 #define VEML6031X00_INT_TH_L        BIT(2)
@@ -1121,6 +1122,11 @@ static int veml6031x00_hw_init(struct veml6031x00_data *data)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to disable trigger\n");
 
+	ret = regmap_set_bits(data->regmap, VEML6031X00_REG_CONF1,
+			      VEML6031X00_CONF1_ALS_CAL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable internal calibration\n");
+
 	regval = 0;
 	ret = regmap_bulk_write(map, VEML6031X00_REG_WL_L, &regval, sizeof(regval));
 	if (ret)

---
base-commit: dceba8e581e3e8f475da0efbd7a73f3d9524ddd2
change-id: 20260921-veml6031x00_als_cal-93319bc0be81

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

