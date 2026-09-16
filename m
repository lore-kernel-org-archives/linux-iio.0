Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4673AC0E9
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 04:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789532137; cv=none; b=tV2ObVEXvdEgbfv8lzX31b5McTdItLH3zVYC15qyoGNujHEzNJcayY/eZGiJviiZsIzOKb5tYuaX4FelnZ5T3xpWvDejTuE8UqSrX10boSLCrIrVJ4/+srh75GmqZo/kmGCaPLjhOvNIKe7s1IxwxQkbqEGlZr3CSMKxrIX0x1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789532137; c=relaxed/simple;
	bh=1otP8UYV9viBZZ+f8NwjITACufQDeLB/kdjE9I9R9IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvigHVMspmpEingg87/jiWL6T6I4oQzGucXxqGEMAI9HPYT+/hKfsmhlVak3V8SriEHZQxNHP/9XJlGhTL1vD3Kvi07w/NuwK6sgM/4pCqM1Ev+LOFReHRq5cCRKobnRGrWv8awhkL8GOHGq0fhSTUKb6buPsV6I/T+CVNqqwv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1JVgfOO; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1JVgfOO"
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-7f748fe2947so2232294a34.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 21:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789532134; x=1790136934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=54xUl28tB3oyyAr/XFRTTgMHGsQTvwV3/5B41pgtCxk=;
        b=O1JVgfOOlmU0I4Tqxl99oVgfDcJEB5svW7Y90jaLi1SAMgvrsiIkFUgbqvugCOM4u5
         tfGkUdjmWc1irLqpUEp/ZY10ug94aw9eWqJ503nlKLg+tl8vOxheEaR3aEoeEJ4Ptqkl
         3+xmSLdrISG7uD8E1ngtDPZ5Dw5wo7uEQPS8uRABttgCG6NNpD4Zbl1ghc3PiE2D0vAW
         WZoQGrt+uGNWHy3DmHM7n4LfLYKMXFv5DJdZWlzs+RnT+Kx2ph9BJFFmTW2Hzf2d6oTS
         akrctkyRFCggd8kPssK3lb6M+bTQ1ZrDI1tHR2wCwRoTdhIj1GYam7xtqChI4WatQYod
         68CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789532134; x=1790136934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=54xUl28tB3oyyAr/XFRTTgMHGsQTvwV3/5B41pgtCxk=;
        b=gxDLdRyeyjvDWIbEf1dsfEzofV1U3cajnXsM0pv3bBI5Kv0Jadb/zArgGopO5reeQ6
         Qv7YcgNg3AWf3L9kG1vS1+jMKJnPfCaY9n83fgb9MlFYtuwTgT/L+BnjgtZ91bedDznW
         nmlfAmsjpZo79QkhjSouFfrLNYgDrDhZyB5liRyneI6w7LvFjKcSa6hfMAhd4Ie7C8TM
         1t7OtPSAA0zv3YnBiknn9nkyuTr6AB0ESyhv0U+gME0rGILSgje9hRx5eaoMzg2Bs0Rm
         qZ7ORlfdTSxpKPYMNjvBwe4+lnm3/+gkJPruEVFRl893WKjlUySUhwWhSzGkskizwNdB
         IzqQ==
X-Gm-Message-State: AFuF++ktTTd9ovfFH+mWKcTNOlED/Gxp102Zvo3cZTcLZntkjcBK4hbU
	chuOlKP9uv3hzcvOiyMSxVbM5lt4Lerofl4IknPnlEoUDYQ/XCdBypKQ
X-Gm-Gg: AYBFou0i585wKI05fjL5uad4AOvfXdF9TGPGzNkVZQ8c//F0XLEqgkbkJmXbpKB4+wL
	N1NqW3cN5LObVuTOpaf1eBbrkQBxSkoui1TWLrGvYmVYHXeDLctXetKx0vl7IB9lKtfXayy29CQ
	6A2bdps/ZzLWZvnx8ugJkjcnPXqGCV7jVEiOxoUo5UkLCkVNGWqKFAvYq1dK5XHQdl+Ege1IVRK
	tj0Pw+yiqOkj9nI6K9lJX3ViS2vTeuUAeH24CmnucIaIGc2+LkE3q2t2DXwAY+T2ZviXkLIRWFT
	rRATkPx/vD7eC4ccC5S8Kn/c/itUcovCBsJv0v5ThcHsm7Lcq/Sk9VFfA1oTud2NlJv++iBAA6L
	UNihBQUFzWnI1AWVo6SyYRucHQAIpy5/XaW7qinwZ8xsJHAm+lK5jBJzZfZXNGC4s05IVbdQPYR
	mguyRVvDr/MgHKQwEAux3wCzk1hN1529e6bB27MTgN7adhcJ8gBybljgAtj9SySHeDX/o=
X-Received: by 2002:a05:6830:a257:10b0:7f6:8bfc:ddff with SMTP id 46e09a7af769-80b2cdcbd2dmr963693a34.5.1789532134233;
        Tue, 15 Sep 2026 21:15:34 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80b07ad0373sm1440484a34.26.2026.09.15.21.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 21:15:32 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Tue, 15 Sep 2026 23:15:28 -0500
Subject: [PATCH 3/3] mfd: mt6397-core: Add mt6397 AUXADC support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-3-d35d2ac3d6f0@gmail.com>
References: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-0-d35d2ac3d6f0@gmail.com>
In-Reply-To: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-0-d35d2ac3d6f0@gmail.com>
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
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789532127; l=822;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=1otP8UYV9viBZZ+f8NwjITACufQDeLB/kdjE9I9R9IM=;
 b=Qdf5f6KxhlBn6zznJXIHm5ylt2/6A7HbBfAy+GlK4uGnXRE5GEfZMjssKRRjN1v/McHSPhcj7
 o1QFlFIYqhHBqBAzYR+NCPtMKgwVYgLdEInxZcyBNZ1KMNPGeCtuh5w
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The mt6397 PMIC includes an AUXADC. Register the AUXADC in the mt6397
devices array to allow the corresponding driver to probe using compatible
string.

Assisted-by: LLM
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

