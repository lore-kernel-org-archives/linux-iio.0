Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE436213D
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996131; cv=none; b=Yvww6J3hIayJEUqlWUg/Hif62BwYWmHBqHjZuxwhxut03ns+VEvS+aSyK4uBnfM6Io6SbJD0NHb3/LPcXZuTouESi/8PGWV88slkAqUMFB9+O6sJcTVw55+m0DfCgLp4xogOFipWrOqQIhTx6MEU3oHt2qnDI8uPbUrKw0wGWDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996131; c=relaxed/simple;
	bh=P46HKoi8ZF7lBMC37WYjsZNDcBWA1dpuzLN4UTPe4G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsGR6GOxU+bJbkRvbtx0pILb3khQ7oEw1VRDBZPZGG6w9D5bc1VEnSGDE6yDGcnMSplzwiIbYd3FhNhX+5fqRB4l1P9QouRcGbwvLKCGWpO3Jephzn6YT/cv391nodLRMhSRlcq0KpzPUQVcuojMy1WDv5X+VlyY2Rau8jVBBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaHpBpi8; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaHpBpi8"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b867142b07so69700eec.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 07:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770996129; x=1771600929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jxr9E7F+/W5lcyOhElHgejUw7bVh7N8Nbutx46AWWP4=;
        b=aaHpBpi8d2NyV5Idd9ywhCqAi7ltJufKsUa4B9ud9V40HLqea7KaQwXafxfS/cOiUL
         aFE3AN/mHhw6+vPOBhd70vt3RYWY/+HFKcoUL16pd5a43n1fR1Gk220TteB4wh9YB3dD
         PQwtZ8NAtDvufqkroUTnQ4lHT7UI4kyN8Yt7dPyOmDgxB9pmRlcd2IqENUpN6ZJI4eRw
         ACkeageYREbnGkoLRyXOD4Ac9AAhOehO57C0VTs1jDvKVxfh3cY5N6chipYAG4Wb49sK
         SIVZH4qTIZsqD37hNV1JwIRcvP8HBLjdHlu017ETaI7jLzpASKlMnEVywtQJuq5+tgPH
         B7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770996129; x=1771600929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jxr9E7F+/W5lcyOhElHgejUw7bVh7N8Nbutx46AWWP4=;
        b=TW0KqqbdEhvY4OmuFwMrnn4k/NYzcjWL73xonZ9T0XyZbwXj/wkCEEgb8Tp3xdnWp3
         A1Hs2P4IUcdfzrILQcmXGqp4KdJr/SRkDfLMCiRjTo0jFdVCIkiOTwCqJdd4MF5Ugpod
         nnL7yJxbqRJd0ot/AI+fmICr+vK143HZb1LhzRGSIdp/QSA4ifw+CE3Udv8nSoEkZELa
         pjqrnBc3lpXqCQ6p3yY4PhlPbXPxY+J5xqp/u/sNEAT1bnX2VFMUJ/VnowsZEe+RP31C
         bEn7a6cRFtNjeLmYLtr8r8kBbYHmIlu2Qk36HfADR4RZHHUYIhF5Ks/wFe93TbnUpD6I
         QJ6A==
X-Gm-Message-State: AOJu0YzqACgn+y61SETmoWnJLIgDTpd1P2B+ItQLCQfLlb3r7tUd1chC
	mQzp/vjhAdkJPNg7FkKoT8+vhoFq06C3WEovcyLBBsoffX+/qmhEPHNM
X-Gm-Gg: AZuq6aISGXC1uDU9wt47XXTPtAl7I3xGiA6X/yVwc214YGXx1oJZ+c+Ly1Ir3GTzobk
	shVbqVEWSvvDK5D2lL8BQRtmrG8gNMi5lvX11eEHgTGHBJX0syFfyfHuesHMG1G6hYOkyxS66N4
	gmBvRIClOnAl7oWkwFomAPmHNP2FamgHXGplpz8Y6fjTDtrYSVqgmCti0VZWNA8K/JIJ56yd2qJ
	eN/cp7Pbb62EiaGPgKemPPhJ/SfpkSVVxGvJ5guSr1mj82rJR5er7y2+cSy8OrZL977SiGT0roh
	B40YDh1HtfiikkXu7D3okMRcNgr/gWVf74YCAlbWcos92YUiLgdMlBC/ZTOZFNC2qHJHYLRP8p8
	5mvWKu1cZ6QGhQoL/XuOcRPqF7Nc4paSZ4bCJmBVt4FtpSBVr/0VIDlKuky/+njdQoN7kJQqh0V
	Hht9s3bnv+Hp+gEM1oXXdimYKcdl2P5CZja0hzFlSkFexYC9qkxRz+L1g=
X-Received: by 2002:a05:7022:419d:b0:127:3480:7ca9 with SMTP id a92af1059eb24-127397d3704mr647170c88.2.1770996129389;
        Fri, 13 Feb 2026 07:22:09 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd01d1sm6755006eec.17.2026.02.13.07.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 07:22:09 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Fri, 13 Feb 2026 23:14:44 +0800
Subject: [PATCH v3 2/4] iio: proximity: hx9023s: Protect against division
 by zero in set_samp_freq
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-upstream-20260219-v3-2-df9371d29f5c@gmail.com>
References: <20260213-upstream-20260219-v3-0-df9371d29f5c@gmail.com>
In-Reply-To: <20260213-upstream-20260219-v3-0-df9371d29f5c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=872; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=P46HKoi8ZF7lBMC37WYjsZNDcBWA1dpuzLN4UTPe4G4=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJn9jn3M3iIxUrzxv+d6OK54+KP92g+ORwzWE5WkFSTEN
 jadCPbrKGVhEORgkBVTZDnz+g1rvurDPcG/XTNg5rAygQxh4OIUgIlM+cjwV0QyWUPlYZ9QXKbu
 yem8W3cyFl/YX/hFae4p1b6qp1Hd3YwMrb3zqpuswhJef3mQLvF09fWqnaJr56oqWITMlHq8LV5
 qPQA=
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Avoid division by zero when sampling frequency is unspecified.

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index ad839db6b326..17e00ee2b6f8 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -719,6 +719,9 @@ static int hx9023s_set_samp_freq(struct hx9023s_data *data, int val, int val2)
 	struct device *dev = regmap_get_device(data->regmap);
 	unsigned int i, period_ms;
 
+	if (!val && !val2)
+		return -EINVAL;
+
 	period_ms = div_u64(NANO, (val * MEGA + val2));
 
 	for (i = 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {

-- 
2.43.0

