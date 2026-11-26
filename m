Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729081;
	b=gwhQxg8IRYr54PLmywGCq2dvxSgGMX/tcqNKUNDkdOpdchh9ig1a2Laz3f70IpQe7fQF
	 ygWu3Ty+D0CkH1oNIIJTl5+fhvJkI3jYcXnyWWTnMHctRIiNfpaC11o650FUkuK2d/ZDG
	 Il+sSqSWpBFLgXMMqDAUxq3xF7QszQq3tYhFfVG9tevSQkgWRyXYnKDLUmDLuX6s9wvp3
	 NIbE/JHh3m2xaOm//XsW1W1EcxhFiN8r+dIFGIqgM/MaD6wRX+H3sFQJaY6S+llVAOzb3
	 YNXG8jAIxw3ceMlMtG0GGTLPA3aPo+qUrAiggoTprCAbPjqw9RLtR+45JcuCO5W1Qkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K2W/5iiumMXjFlLM/N2hQ9MSD6+kLpBpFnv1u4EVM04=;
	b=WykRgyLE5li59UxIraOfpQo/4kLwMiqMQxNpH+fn1KlT/XwHwYmKPkgABGDKRjwd9Q8y
	 Sct4ILgMFPlTm6CS+kP2yizOZmmTrRwQI/7aXw35XTr+KtBLgrVIuBac5g8YfWEU8UURM
	 XEZoFCPvKM0cVm6g8l1kHmIsesep2exirKeii0gVSs0p8UaJh2wmsfuV/iowdkWrOOA3a
	 c5Ne1td+GbVs3PWbMc4DfSzIW/iS6O2p3cZoERhKhXI+6DHsnAZH+fNXOEL3iTE3c3gdi
	 MmTbC9dAH+rlyECta0HxG/Znt8D/tbjajUjpuLPTQMzvUM0is9ZnEaqM18u0USuZrxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x2qfrdTt;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8C606A327
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 21:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AB8C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x2qfrdTt
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b41188c8b9so5117208a91.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 13:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729081; x=1796333881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K2W/5iiumMXjFlLM/N2hQ9MSD6+kLpBpFnv1u4EVM04=;
        b=x2qfrdTtuJCmuejOHvH0AxDiiVjqdEwuktypRPW7t+mgckGGKNLL8IATqHxBuJcfjf
         DkwfJ2+4L9HACwcElhpSovlmkU2Ojmrb0c2r2jIOSQheYBubcriyRtk63cVZ7jN+liSs
         kjJCuLVje5STPDt0Tg3lALACLglRps8wuc+/XeHL/BVXingbu1K8mClwJPIM1+O1S1cz
         h2+AzHt83eW3XudoB23oyeDRH9syx8+jSoQ12mPrB1lcDATeVAYNS0kdqin5oGnwRu2r
         jDv/nESIE7DaOPH/6H56Jj9F9OE3541Id2REvPmgZNcU0sUXptwHptMRP3lBzo47sGpA
         b4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729081; x=1796333881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K2W/5iiumMXjFlLM/N2hQ9MSD6+kLpBpFnv1u4EVM04=;
        b=KZpdAIkJ5tjmN56xcG/my3kMZKHx1tDldz9yNWElr4G901I/Tu5gO8mHgonIlLUEZF
         9Oi8ON7SKprlsj78HTWKvWGnQBTDdShKSkbX6h2CKkzr0KqdUKcUB6B0JKosL7rxARVP
         o8t3LET3hy9u4MODviESatVrUtZx99fTZvJm9R20XNaPzVZkA6CPi36EVu5B3ti5N5cZ
         tekFw/wSWz7CPQBu2uX64eaQyU3t2ZsghoWt9Zdqtj3jUVLFm+28gUVyqXK+sheCmWiQ
         sNgksFz3hR1OTyGyKDdgjqq0W9exEo3JBWX0fN9nYKtXCwLPb9UR+Pdd2WARcgcAU4c9
         4mQg==
X-Forwarded-Encrypted: i=1; AL+hErECW6FRwG2UI1ZXzZL/eX/mxoZu2BkTNNvBZ3Wrx0kuaOrJ6aDEHnYW4IGdhSbfLme2W9j8NH674ws=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Xa1ci8+imwkEeM/DGqdenk5cJiZSuaujWhoYzVo8nEypFWvqI
	vjOS8hz85pl4fyWKsG+e/N83qlg5vFxajt56gjhvYytSsImMNC657jpV
X-Gm-Gg: AZFdTZcCELbF/yocZKKtfVSq8epD5UkSjKBhUWdwwz3M7LQGa7b2acfGzIIrI/cx1hT
	R8gk/YQh4YgAf8OzTYHl0RijIpYpWO3/Tbb/bytUrc6b7KzcQTd4bCnuZVsUFDPIKwQUe7wkHDf
	iWIqKhT0PikXwAQdQWzQ4QV4X8CgVgGaDJz/SPut20vKLtToUhQ7NplCKOM6LJYG7z984T3Gq0g
	ZKu574IeeJm+RwnlRK92S8YNUp2ezJzLVnZ3TV9W5FqB8wklVdYI4KkFvBH38BJmembENYkC5wG
	LXzEK13rXbV5EQql4K02v2hiWAkmPnzMQHZG0JJ0r9G2qcBTi691q9TyHJcReyE2O0NcW20yTjj
	atvGeaOWgLuHwgbYP4qYTuFYfvoRX7Fz5ni6ts+9kayeoBYCcWquxoPVzzdI5TseZfuXboXSkYF
	4moPfHYh4LmXPzhvqY17FZnIS45dwlL/HpUyCdiJxx+7m0mUBsCGAeT8X/1d7KYAPXMBSwF62Fc
	OYo23FqH11jtyYNs5kEN5F3xrdqsxLHiBi2TR/UxF1wFmMb6C9fKOqgtCGOLRg+TjNeDR35nnB7
	C+L3cAwSG8/SluIT9qW2IKU3wp83r8323PqJD4Fieb9kXrpjOIIr5Snco3xqPci/E7/DMdB9wVS
	SRe5zY3/1tHgED1lAHchGxCqDJWQfeQPPJS1G9MXKrQfhqSATiPHLXZXbT3PE0UcCAMumTxNFDV
	8PZ/t1X3vkXxVqbiQ1WMNGXQ==
X-Received: by 2002:a17:90b:3891:b0:3b4:127a:2bc2 with SMTP id 98e67ed59e1d1-3b41c8d9bfamr20845589a91.14.1795729080668;
        Thu, 26 Nov 2026 13:38:00 -0800 (PST)
Received: from kapoor ([149.40.62.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm11703905a12.2.2026.11.26.13.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:38:00 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 4/6] iio: proximity: hx9023s: reject out-of-range threshold values
Date: Fri, 27 Nov 2026 03:06:49 +0530
Message-ID: <20261126213710.1047676-5-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
References: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
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

The proximity thresholds are 10-bit register fields in units of 32.
hx9023s_set_thres_near() and hx9023s_set_thres_far() mask val / 32 with
GENMASK(9, 0) instead of checking it, so a value out of range is
silently written as a different threshold: 32768 becomes 0, the most
sensitive threshold, and -32 becomes 1023 * 32 = 32736, the least
sensitive one.

Return -EINVAL for negative values and values above 32767, the largest
value that still maps to the field. val >= BIT(15) catches both, as
BIT() is an unsigned long. The low 5 bits are still dropped, since the
field is in units of 32; add a comment saying so.

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index d509de6e265b..2d2774398259 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -441,10 +441,15 @@ static int hx9023s_get_thres_far(struct hx9023s_data *data, u8 ch, int *val)
 
 static int hx9023s_set_thres_near(struct hx9023s_data *data, u8 ch, int val)
 {
-	__le16 val_le16 = cpu_to_le16((val / 32) & GENMASK(9, 0));
+	__le16 val_le16;
 	unsigned int reg;
 
-	data->ch_data[ch].thres.near = ((val / 32) & GENMASK(9, 0)) * 32;
+	if (val >= BIT(15))
+		return -EINVAL;
+
+	/* The field is in units of 32, so the low 5 bits are dropped */
+	val_le16 = cpu_to_le16(val / 32);
+	data->ch_data[ch].thres.near = val & ~GENMASK(4, 0);
 	reg = (ch == 4) ? HX9023S_PROX_HIGH_DIFF_CFG_CH4_0 :
 		HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * 2);
 
@@ -453,10 +458,15 @@ static int hx9023s_set_thres_near(struct hx9023s_data *data, u8 ch, int val)
 
 static int hx9023s_set_thres_far(struct hx9023s_data *data, u8 ch, int val)
 {
-	__le16 val_le16 = cpu_to_le16((val / 32) & GENMASK(9, 0));
+	__le16 val_le16;
 	unsigned int reg;
 
-	data->ch_data[ch].thres.far = ((val / 32) & GENMASK(9, 0)) * 32;
+	if (val >= BIT(15))
+		return -EINVAL;
+
+	/* The field is in units of 32, so the low 5 bits are dropped */
+	val_le16 = cpu_to_le16(val / 32);
+	data->ch_data[ch].thres.far = val & ~GENMASK(4, 0);
 	reg = (ch == 4) ? HX9023S_PROX_LOW_DIFF_CFG_CH4_0 :
 		HX9023S_PROX_LOW_DIFF_CFG_CH0_0 + (ch * 2);
 
-- 
2.53.0

