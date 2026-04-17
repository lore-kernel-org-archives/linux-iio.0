Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776819995E
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776387075; cv=none; b=EKLAUfnKoBzx4ZBosBKmCRdJdfdFToxIfnzuRLBrdQCp+xvAazGGU8YCDhYICs1DVGmTHR9yZtoKrzEEGiEzAi0v4WhuFTgwWcflTJhi9RR0ko3C8LiqeQ3O7Aox/j00SYycsmDq1zH24MEr6WFjJjmHQseYw8XOb30NJtkzWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776387075; c=relaxed/simple;
	bh=FHw3hDoedxqM7jrSk4Ox7v2kyPR9viJ+hZIDFBKK34o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sVIGxqcdhz/H42T5EelgZ36n9PlhZhOJlOIUQwIvh+SEz1gtGubNzEHeskewTP9did1jB6E6NiGuCk/SToJgtuTc7gRvSXHmybg8XF57XdV8QWafU2GdBnUGSVeUFz+Tl/qscTJzGQZ9KPNlCSd3Y4D0QF9PqWrJqQ6TasAGz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=fi1RnodE; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="fi1RnodE"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-6058a955e04so123717137.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 17:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776387070; x=1776991870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k9YwyMF5JlyEibEyL5rY/08LB16Jwk11gInJ/3AQN/o=;
        b=fi1RnodE03pCva8/HcIVDLS7HMSXWyIr9ztsfUqPG1qJiRz9wzS/Xhx4D7WaorUVOP
         76IAkI0yO3J5lvVnmHB1c7I30pIIVwP8tlGHqbkdZzIbPN4jWoGddTzHCDvYhMeFfP5I
         gJAywWgoO8XCHLGfk/4LGkg9sY1YCVy5LFnttNgareeYI3NHLPFDaM4kZoIlSX+UmJf4
         TPVogP+6RIkYTPntk2vUytKUStJhOTxKrqxxomp7IcZNSLtwjSc80Z6bB+eTqVByhqYA
         yt+hf4EGKVP0gx2WLPg9WrPPJHY8/xp50+afAxNBZh5njqbQitMzXSHJrW6ytXu2ZHF+
         8n2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776387070; x=1776991870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9YwyMF5JlyEibEyL5rY/08LB16Jwk11gInJ/3AQN/o=;
        b=hKbqLg6txl8VP+OCsLZniqUnJ8tuVC9nIjGo/OnzIPftEdQdKkibB6hbpTZUk3St0U
         9SgGzVbOcFTPrqoPf/cHm2V1bKczdKofwWCjPthbP0jgp7ERxqEYhFcPJgXgyXpUxcZn
         ltIWhROsG3PZZTyiYtrFeCcoJLxiX/48X0sN7YprKN85cI/l0hU5hvcyt6dgLE8+4QbB
         FZ4dvLAyWkoJ31I1HpQKMdaZDAYj2uw/HL88Mr9Z9aw/Amz6tyGwSgKMK0SNA2Gq5eYQ
         5HmNuoLipM3W55xz3FkGn8ojFEsOvxlYHPqIfFEsj8/cLMmDhalBCgpPjQ1rrxJWYa75
         0+wQ==
X-Forwarded-Encrypted: i=1; AFNElJ89q7z8C4UWemktV7G8pYTHhBeINI3VM0RxIeAY4Hl4lrlVfH3CJOFVi2Re+PGa9XjwDOOi0eocIYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5w9i2zFNz76lYVSffuOUysw7UzmUruemnqSe/CfqoaJMDWa2b
	pup48e1/U3IvkoHf22PIG5DG1PzsWEeJOBOtYVFhkQjlBwvozbbCKqjFHiL1EUKiPMQ=
X-Gm-Gg: AeBDievYgM/Gscrb84/QwVnxkIUS9qPtFSPR/fcv8Au2CgxRwG0AkQ2IMuL7uylH0Xg
	f1kdkGtf+T1qFqLVDifjd0zeys8ngPF64Z+ZAOxV6BRW2cPdovodAs+hfBsA/TK6+ReRAzi0mF9
	M0WVCzcXDrSSVpU19fxRIQ4RF43N21c9QA48oj1jfNnlFFATjE560f7B0xYKwnu3EM+LMscAr7b
	uUZPpVDV1nfU4Ijo54PmQ/lil2S65TcNPU951f7WKEq3SkBdEaSC75byOxLVWu169czJPXIJGV5
	O54LBRPPjwz0q1s9GvL73w69guz/pXOldn6NAO5D7GhJfWdun1ycZaHs79wNVFRZB00L9YDxJNi
	ZrbQVL6JwO5grgsqBTMGJAAL2Nxx103jL6CYq23OoB1QJmQXp7ILWtlpqgwF9hPL9GM5BQJ/RJj
	QVKibUdRamuUKTQpJ6HYN9nFhgT+zuYzMREVEuQvBypR/sP/rNEGbA6IjZnfBb
X-Received: by 2002:a05:6102:5114:b0:608:cdd9:2bcd with SMTP id ada2fe7eead31-616fe05a9fcmr278012137.15.1776387069947;
        Thu, 16 Apr 2026 17:51:09 -0700 (PDT)
Received: from avocado.. (mvx-177-92-77-170.mundivox.com. [177.92.77.170])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-958909bd5e4sm40040241.6.2026.04.16.17.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 17:51:08 -0700 (PDT)
From: Marcelo Machado Lage <marcelomlage@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Marcelo Machado Lage <marcelomlage@usp.br>,
	Vinicius Lira <vinilira@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: mcp3422: write bit operations with bitfield macros
Date: Thu, 16 Apr 2026 21:50:40 -0300
Message-Id: <20260417005041.484742-1-marcelomlage@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual bit manipulations with GENMASK(), FIELD_GET(),
FIELD_PREP() and FIELD_MODIFY() calls. The resulting code is more
readable and maintainable, and some macros previously defined in the
header are not needed anymore.

Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
Co-developed-by: Vinicius Lira <vinilira@usp.br>
Signed-off-by: Vinicius Lira <vinilira@usp.br>
---
 drivers/iio/adc/mcp3422.c | 43 ++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 50834fdcf738..d93036bf9a85 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -13,6 +13,7 @@
  * voltage unit is nV.
  */
 
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -25,9 +26,9 @@
 #include <linux/iio/sysfs.h>
 
 /* Masks */
-#define MCP3422_CHANNEL_MASK	0x60
-#define MCP3422_PGA_MASK	0x03
-#define MCP3422_SRATE_MASK	0x0C
+#define MCP3422_CHANNEL_MASK	GENMASK(6, 5)
+#define MCP3422_PGA_MASK	GENMASK(1, 0)
+#define MCP3422_SRATE_MASK	GENMASK(3, 2)
 #define MCP3422_SRATE_240	0x0
 #define MCP3422_SRATE_60	0x1
 #define MCP3422_SRATE_15	0x2
@@ -38,13 +39,9 @@
 #define MCP3422_PGA_8	3
 #define MCP3422_CONT_SAMPLING	0x10
 
-#define MCP3422_CHANNEL(config)	(((config) & MCP3422_CHANNEL_MASK) >> 5)
-#define MCP3422_PGA(config)	((config) & MCP3422_PGA_MASK)
-#define MCP3422_SAMPLE_RATE(config)	(((config) & MCP3422_SRATE_MASK) >> 2)
-
-#define MCP3422_CHANNEL_VALUE(value) (((value) << 5) & MCP3422_CHANNEL_MASK)
-#define MCP3422_PGA_VALUE(value) ((value) & MCP3422_PGA_MASK)
-#define MCP3422_SAMPLE_RATE_VALUE(value) ((value << 2) & MCP3422_SRATE_MASK)
+#define MCP3422_CHANNEL(config)		FIELD_GET(MCP3422_CHANNEL_MASK, config)
+#define MCP3422_PGA(config)			FIELD_GET(MCP3422_PGA_MASK, config)
+#define MCP3422_SAMPLE_RATE(config)	FIELD_GET(MCP3422_SRATE_MASK, config)
 
 #define MCP3422_CHAN(_index) \
 	{ \
@@ -138,10 +135,10 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
 
 	if (req_channel != MCP3422_CHANNEL(adc->config)) {
 		config = adc->config;
-		config &= ~MCP3422_CHANNEL_MASK;
-		config |= MCP3422_CHANNEL_VALUE(req_channel);
-		config &= ~MCP3422_PGA_MASK;
-		config |= MCP3422_PGA_VALUE(adc->pga[req_channel]);
+
+		FIELD_MODIFY(MCP3422_CHANNEL_MASK, &config, req_channel);
+		FIELD_MODIFY(MCP3422_PGA_MASK, &config, adc->pga[req_channel]);
+
 		ret = mcp3422_update_config(adc, config);
 		if (ret < 0) {
 			mutex_unlock(&adc->lock);
@@ -211,10 +208,8 @@ static int mcp3422_write_raw(struct iio_dev *iio,
 			if (val2 == mcp3422_scales[sample_rate][i]) {
 				adc->pga[req_channel] = i;
 
-				config &= ~MCP3422_CHANNEL_MASK;
-				config |= MCP3422_CHANNEL_VALUE(req_channel);
-				config &= ~MCP3422_PGA_MASK;
-				config |= MCP3422_PGA_VALUE(adc->pga[req_channel]);
+				FIELD_MODIFY(MCP3422_CHANNEL_MASK, &config, req_channel);
+				FIELD_MODIFY(MCP3422_PGA_MASK, &config, adc->pga[req_channel]);
 
 				return mcp3422_update_config(adc, config);
 			}
@@ -241,10 +236,8 @@ static int mcp3422_write_raw(struct iio_dev *iio,
 			return -EINVAL;
 		}
 
-		config &= ~MCP3422_CHANNEL_MASK;
-		config |= MCP3422_CHANNEL_VALUE(req_channel);
-		config &= ~MCP3422_SRATE_MASK;
-		config |= MCP3422_SAMPLE_RATE_VALUE(temp);
+		FIELD_MODIFY(MCP3422_CHANNEL_MASK, &config, req_channel);
+		FIELD_MODIFY(MCP3422_SRATE_MASK, &config, temp);
 
 		return mcp3422_update_config(adc, config);
 
@@ -377,9 +370,9 @@ static int mcp3422_probe(struct i2c_client *client)
 
 	/* meaningful default configuration */
 	config = (MCP3422_CONT_SAMPLING
-		| MCP3422_CHANNEL_VALUE(0)
-		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
-		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
+		| FIELD_PREP(MCP3422_CHANNEL_MASK, 0)
+		| FIELD_PREP(MCP3422_PGA_MASK, MCP3422_PGA_1)
+		| FIELD_PREP(MCP3422_SRATE_MASK, MCP3422_SRATE_240));
 	err = mcp3422_update_config(adc, config);
 	if (err < 0)
 		return err;
-- 
2.34.1

