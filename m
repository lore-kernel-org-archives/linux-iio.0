Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6272DEA98
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 04:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003354; cv=none; b=bkihLFw0g54B11kzg9mY3HQvBbJ5Fh7MQslQlTvJu+GBROE2AygXRAicBZAy8hgpP/VQohRW3akTuDPRs968xd5EeO2UGPzMAqZnNRSgNNHDAxwIT+7xCTpPlonwJvbrT7ELZrOb78wnPNd1OIV+VOhWiZptqWVGhG0IZQp70LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003354; c=relaxed/simple;
	bh=QJOPYkRvIadfRFcGP8v6wXwTJZ7TicjFOV8r1Yj1qH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ejQ26JuUeqkQKxBTt6YNLBpGZxTGfMQ0+inmENEt6lo2b505r4xVE28rlTMj6ED9W3dC6CxXsLm/dJauMi7i5y+4ZHi3lKBaZ9f9NwwVXRJNBP0dy8be/7AjW4naL6pMFnRmKX6cvHTb8BiyZLliuKVyAUVhHwmAtuQZHbdVoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IO8K3XFz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO8K3XFz"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso1113810a91.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 21:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784003352; x=1784608152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8taiq1gh/0OoOQDBR9j9Bhwzd7P+6aji1UgJtYLJxrs=;
        b=IO8K3XFzVzBTc0toXFHqYU2GEUClzPOL7ex1l8voUsryvoGpDdv9ickB8oTmFCdOfw
         UkPCLTTXxrWS+AmPg7RfFne2qGsfB8qmwHl/ijOJhV+JFiobGMw/CleiProYj0ghEaE/
         n15sZclzmmd081M4P/lTvgKpL9jgfXr6c2zne/pYpLh+SEzik7NmLVpzeabESl4eTFtu
         MpVn4RQb37UetoqSmqktFIEj/vXINVQ/dKM7mxsaQc28ZGziD23k6z8EQtWdeqPOvzLF
         vduLrkAnAZ1l+x7WhFCLj7mp5vEvHC13suPs1QmGpuUoOpt8aLmW581rTswBqbwUpQHD
         Z/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784003352; x=1784608152;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8taiq1gh/0OoOQDBR9j9Bhwzd7P+6aji1UgJtYLJxrs=;
        b=GzYKo9vT/rD5Xmzfj6F2eTHrrKp30OG2udAicPtLzuWWyDPNhsH0aq4oIUvAb93ZYw
         OFd4COkTlml6LkcZ3G8NxlNV45t0ssBWoSzKOH1nJp6vDrf8V9oWgbSjUOTvRanrlzHN
         /pcUw26SIx3zpd/Ftw3V+DSoAP5bUTLTtjlGPVx87TCt5dN161tEoT7NjRp42IOho+wd
         oLGyrgoWSnAH3w8MVm4rfSOZNZmPNGqynnYkMj4lqleXfXQp2C15jkXRdMWr7a7CBOTg
         MawRu0KIwXajpO+kDdlrif++tTYmgbudf+yNINrxbr5U2OTYYxfR/L4ofVZnVGCgzHaz
         yAvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNZdmKDD6kizYGcgY2hbuGvh/dsbMtGmwcs8Bg/QZqzhF3y0x8eontkU5UE6g4BilP06R4jvkQNPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPv8Q0fKcgIcSeTVUOcL4odZV80mUsb5WF75F/Ga7g0FPqDD/X
	7sBv1/efnQx745r97+Iglwr1kyVqZMOeDNo0QeGGR9Muv10oIeq3F+kd
X-Gm-Gg: AfdE7cnw9rqSII+8WOL9aVoYonqAZ3YeWXKBK9c4OUoquZ9vfCWpMy7Jp78KVn7oTOj
	BbWtxyhZJo5LPuR9ujkeZzBhQWkpgKWQigIFUcThhLwqHczuiXeLiCMVS1gW19NAOPWtoMZBqke
	3BV56O4Hf2X9OLaw1Wxjr/b/lGU9uA9dtZDWLWTLHTsbn6ncS5gZ5AETMwysrkJjiIR1vOgXR2f
	6gUJvc21FQ9of7vKvC46O9FL8g73gD++6lzaMXbK83mhHanh6ptCP3fhuPiu8pVxA8uVaHEGbFI
	qyqY+hWufxrmZ1YOkpotpdIltYXyPtZqMjDfdErcgomJNpneYie7yGxFYW2bovVs5Qan9R7gVyu
	l+0vKKT6hDvz6QvHcP3O1H5eiseKRlc2qZriny1HyUX4UiDLiH6d9isouydnAYWw3ZQFeQ8djPP
	IS0ZeLH3LLiJAj
X-Received: by 2002:a17:90b:54c4:b0:37f:db06:2299 with SMTP id 98e67ed59e1d1-38dc777b804mr11414344a91.21.1784003352088;
        Mon, 13 Jul 2026 21:29:12 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172cba1fsm766340a91.5.2026.07.13.21.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 21:29:11 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH] counter: microchip-tcb-capture: Fix DT channel validation
Date: Tue, 14 Jul 2026 04:29:10 +0000
Message-ID: <20260714042910.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mchp_tc_probe() reads the devicetree "reg" cell - a u32, per the API
contract of of_property_read_u32_index() - into a signed int, so the
bounds check "channel > 2" fails to reject cell values at or above
0x80000000: reinterpreted as a negative int, they compare below 2 and
pass validation.

A malformed devicetree can therefore drive a negative channel into the
ATMEL_TC_REG() offset arithmetic, making the driver access syscon
regmap offsets outside the TC block's register window, and into the
"t%d_clk" clock-name formatting, where it truncates clk_name (sized
for "t0_clk".."t2_clk").

Declare channel as u32, matching the API contract; the unsigned
comparison then rejects everything except channels 0..2. Adjust the
format specifier to %u accordingly, which also resolves the W=1
warning that exposed the gap:

  microchip-tcb-capture.c:520:56: warning: '%d' directive output may
    be truncated writing between 1 and 11 bytes into a region of size
    6 [-Wformat-truncation=]
  note: directive argument in the range [-2147483648, 2]

No behavior change for well-formed devicetrees: channels 0..2 take
identical paths before and after.

Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
Assisted-by: Claude:claude-fable-5 [gcc W=1]
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
Note: struct mchp_tc_data's channel[2] member stays int — after this
fix it can only ever hold 0..2, so converting it (and the QDEC-mode
comparisons reading it) would be churn beyond the minimal fix. Happy
to do that conversion as a follow-up if preferred.

 drivers/counter/microchip-tcb-capture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 19d457ae4c3b..e53a8390756b 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -483,7 +483,7 @@ static int mchp_tc_probe(struct platform_device *pdev)
 	char clk_name[7];
 	struct regmap *regmap;
 	struct clk *clk[3];
-	int channel;
+	u32 channel;
 	int ret, i;
 
 	counter = devm_counter_alloc(&pdev->dev, sizeof(*priv));
@@ -517,7 +517,7 @@ static int mchp_tc_probe(struct platform_device *pdev)
 
 		priv->channel[i] = channel;
 
-		snprintf(clk_name, sizeof(clk_name), "t%d_clk", channel);
+		snprintf(clk_name, sizeof(clk_name), "t%u_clk", channel);
 
 		clk[i] = of_clk_get_by_name(np->parent, clk_name);
 		if (IS_ERR(clk[i])) {

base-commit: 3b029c035b34bbc693405ddf759f0e9b920c27f1
-- 
2.43.0

