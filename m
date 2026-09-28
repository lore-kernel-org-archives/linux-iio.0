Received: from mail-qk2-f8.google.com (mail-qk2-f8.google.com [74.125.230.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101204FC33D
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629058; cv=none; b=YGnbBdD1WAyhzE3r/RxG0fofAK1uLn8iOBPGcrGou4FhWL9gbR7KPGLurkhVkfPc/dYGRImhnk2I4tnWobODHktBzujIVwGg8EdDIXhYYX7lpFwMSyktfa9tE8ier3OwYQEQFQeEtQehVvmucLg8rlXTa0JM/WMyalesHR2Iixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629058; c=relaxed/simple;
	bh=7RoUzDOZY1QDhkSdG9ZG4g/IuQvy7fWK/zAReNc1Fzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cWARim1Dc3dlc7koP5Wx7Q67b3xhrdzvjXKE6ySYyF9bLDTimQ4YFelksZ6p5T3vbz0Zh/yFmmCveH33vzA182QUv3Mvd+bBZzlq7naZTu9mNlIXM0jmSwShH+5Nqp4UUtzV95sQfdiz8hQV4640Rg2I+z0aZCbSamq29BIfqGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edKN1scn; arc=none smtp.client-ip=74.125.230.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edKN1scn"
Received: by mail-qk2-f8.google.com with SMTP id d75a77b69052e-530e2f0c0a8so39985901cf.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790629054; x=1791233854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VERUOQXBp5L44ineuoMQ6cH79KBHk57qqtJbh8GU1Ow=;
        b=edKN1scn1pXm5JSWlBRsSn8T6B4V31ST9jTE/kSDwYX+AWWcog8zrl0tUj6j7prLEj
         MkyptZb3JlX+djoHnJl4DHjjd+2NmZykyV0W4L0dzA8vAktcIvYz4RHIv+Zq7eWAiUmA
         wLb61EytYn9ak4xWZbnD87poZCVwYrsQ3hBM5Vu10PctXw7PiZKv1h5A2Re20geu8zBk
         qCoC4kB8nQf7VaF74EX813Kh+9/VDO0KnYPmO6FjXgB7ls1vWA026yncfEl2/eIFFrea
         JCwh5MnH0/XgdlKSzoC+yESk5nsJ4CDGsM5ujYZfaKbNt4tsDW12jvvC5MJ0eaFaPvWx
         CV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629054; x=1791233854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VERUOQXBp5L44ineuoMQ6cH79KBHk57qqtJbh8GU1Ow=;
        b=Z5JL/CP+4rcqWOEOA0L0tsHCeGGj/x938GV1aKvyQNNM+XR7JZGs6gt0YD731rAweE
         XQRJFwzZduSpng8lU4t2cwoVCZgTbz9Hm9Ujdr23qC/5+FIrKKFY80EO5EDqK0yf/COE
         hwFU44yHq5ySWt91QhlrEfNMMnwt69Ay8vBtROSvptFjeFspyNqst0TfspVLdv2z9nXY
         P0RmcWDdkFCG1TosHAtuVyV3vW+1pXojkwhU0yuYyS2PDqim0OvjR35rtO60DqwZUJGZ
         QH0POGDtAd+7E2k2q5IfUGA1j2EaT+XjGiVUOWg984A6Zp3fR5P/0zzpLcv/kk/MI+Rm
         wWeQ==
X-Gm-Message-State: AFuF++mdA9MRHfi0ZLH/jdFceGjwF8qoWAqRGTUCBWY650i6zsrsZEUl
	hNisc7MdGmhFz2GvLUVmsr0xOiGN8W7Rh5rCRKpDx7GxAGumDEndvjwS
X-Gm-Gg: AYBFou0jNeIfrB5mOE2QJJbC09lN/xSUC6eC5Q2nEx9B706q9p5C1wNIY5/VsklN1Yw
	R9hiz0r9YDyI2wVBqD4GOFkg18KRrfpP3M/gLOCEEAJqzALYW6I2GGrkQY0erqjXfgYCb1Mz5yA
	j3sTm7V2VAaVs5ihZDr8SioDCyePGQ2y8K6bBqmW5HiFm9dDvaW1Ib3WCJoTjR9zQLDokB4/tRk
	Mlp5NT1qdxWKabN8DbyJSlEA8uUlHDYAGNyytCpzl5VLMSJ5veaOscawCP4CI1JL6xxbEUQuJYY
	hE/GQ7ZSq4tqd5Qt6Ailg2r+eT7ry6RTS1B83dsnS3iYenENUL0ArljlH3Oa5fZzw7Zefl6rjY0
	CGYVNeNZ3p3pGvMuNulMwXgrS93zRpwk7H1KT8B/lEti6dUFadj6NWSPRdz+2ct2zZBELFcbEgF
	xvWF3ia2KG56WzSZAe/lAbPadxl0hXohgnrs6O16+vuh6ik953ahASF8Am11fAQzakbDtnjdLHO
	We+yvY+gIqRu2AL0kFl2C0muE1pgjZ9jwO9m06QuB9kIQ8JKOlTTDrZysMWM6aqsPikv9+8MS8=
X-Received: by 2002:a05:622a:13d1:b0:530:e343:b65a with SMTP id d75a77b69052e-5330b6ac001mr253823481cf.51.1790629054051;
        Mon, 28 Sep 2026 13:57:34 -0700 (PDT)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-533223c6d82sm71443421cf.21.2026.09.28.13.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:57:33 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Mon, 28 Sep 2026 15:57:21 -0500
Subject: [PATCH v4 3/3] mfd: mt6397-core: Add mt6397 AUXADC support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-3-23533a0d30e3@gmail.com>
References: <20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-0-23533a0d30e3@gmail.com>
In-Reply-To: <20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-0-23533a0d30e3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, mfd@lists.linux.dev, 
 Roman Vivchar <rva333@protonmail.com>, 
 Luca Leonardo Scorcia <l.scorcia@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790629044; l=905;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=7RoUzDOZY1QDhkSdG9ZG4g/IuQvy7fWK/zAReNc1Fzk=;
 b=A6AqE7eu3ncyQ70or985e3ODrK8FHn79n9oI/zJvG4E8nupeafb2sik3BBKjwJARUxbfOYIEG
 cbE3E3gNJVsBZowBHGPEj6IcOlHtEOy4pJejW+IVae1ULrZIHdD/kjd
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The mt6397 PMIC includes an AUXADC. Register the AUXADC in the mt6397
devices array to allow the corresponding driver to probe using compatible
string.

Assisted-by: LLM
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/mfd/mt6397-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 9ec951996588..5d5f816492aa 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -261,6 +261,9 @@ static const struct mfd_cell mt6359_devs[] = {
 
 static const struct mfd_cell mt6397_devs[] = {
 	{
+		.name = "mt6397-auxadc",
+		.of_compatible = "mediatek,mt6397-auxadc",
+	}, {
 		.name = "mt6397-rtc",
 		.num_resources = ARRAY_SIZE(mt6397_rtc_resources),
 		.resources = mt6397_rtc_resources,

-- 
2.55.0

