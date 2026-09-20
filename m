Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B73D6CD7
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882330; cv=none; b=dq1K2gmOE7xvD29BvM9QTxUsbZmtFUT5TVsjY3PzAaWWLzbXdnwvC5hGpb4jeGdkV0P+uZJ8drwWnr44frX0CGs4enVtsGRoXddJoeuW636dvsmno3XYCIpNvFw3pqNPvoNcyDDbL4ekNuXewVPraSOurQEoZHE9XmdA3XMa4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882330; c=relaxed/simple;
	bh=1otP8UYV9viBZZ+f8NwjITACufQDeLB/kdjE9I9R9IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/6B7bINE6ljfdvEXLI8MXa+F42OPfNnFLIB8G2+afK0OQ//hMV5JMwgJTAvFZY3vqTZgpox/ZbAU/z3h80Utg8Jd2WY+uvmrmNP6PQbs5Irl40vALn2mcJufEVJWSDGNHQNPc8yvpAKVD9u/WURC5wnSeRAxmM1VQwIc6vMQvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEchglrN; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEchglrN"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-4511f6a63edso297083fac.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789882328; x=1790487128; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=54xUl28tB3oyyAr/XFRTTgMHGsQTvwV3/5B41pgtCxk=;
        b=cEchglrNuJlLC45J60P4tJ6kTKISj+g7r23WamFMMTF/k9fbbVFvGI0e57s5YzuAAk
         Aeoge6jiTvuBjdAZYLL2LIE53huRy1BteP0fdAuD8CH1oRS0xqvzh5UKrTD5ZIoBFw82
         HVtodRMIIimS5nnmf1DvfikNl9WQxLcVsZBkWvRrdVEPu+WdVww73ygeZKyoNeQrHo1P
         GihHDvUOMtJpIPhLJhasaL4rrC8QUVbVyOLnI7QuRN43fD4A/XrM5inMtJeBtY4BpxUp
         raa4pJatHTqzo5/nRJ0Cp1u0cYuGxQu6Afv7IY/aG8QbP1CYmRFUFSce+/4aB2MYihZU
         5raA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789882328; x=1790487128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=54xUl28tB3oyyAr/XFRTTgMHGsQTvwV3/5B41pgtCxk=;
        b=TKPYcvzW8o+vTqbg3dg5H1qNihLmJ8vxzi2HpbBiBAIOErkKAsGV6L3jCJEmiT+TBa
         lL6MLn6b0RCuKR51jO+ztFcepi9YIUgdBmrT/ZywNZJU+BCxGRnC5d8Z76APnybn6N8E
         zQLuBpx/M3JrTiaJZLke0Qs7isKoZgVuwytSqnTS9KWF1K2icekdufPqd1JhTm6LMRXW
         rIW9rQtcTnesy6e0+SK4n9tpUg2etH0FX7gHenYTFdek55IQPvtfTETY65six/9fTBzd
         0R4AWa2Iuoc6BMNOnJXKTQ/dJKblwgrXZ1bxlwBrB4R7fhGIlYTrAn8HPlU0PmikLczc
         0DeA==
X-Gm-Message-State: AFuF++lxDvRauvMaP13Q+bF8EjdQB9gCp5r4H3Fc0zRsvQzlOq+ffKpI
	/bAC8AAJ5tm9qYd5HVsOrugmyakGOP42i6eqxXUfAtdXKCY0e93P7kiR
X-Gm-Gg: AYBFou3/tYp6eP8Mfrom70wfZUK/0aUopYg9tk07+iDwri8nQ/ezah9wTOt5gLnnKaa
	9WZ+Q9tg84/NHkIYwxCDmufHtHubgwKve8Ly0J7DE4Is83COEOpCjQ+qA8gge6L/B7E3UXuyaEN
	gIMxq4bBCsYMKgofxP1+Edyf/fLL+AYuHWBVCx3xiP68nKlBKFCOp+pP57HtEms37Uk4OMDQysj
	b7NzriXWtRkVx1+iuItCJIUGYSInyeHUx9DVNW10oqhBE3ykvxQyHD99iGUvfv9yHI/CcQ7pIs+
	KahzPx01ZE2gLlZoNFJwGLh3KDjpd2AquxnyotYRo1vmGhA8UaoMyDHbfcmgqRO9rYmtRd6+7fa
	mw4vnbX24YdcCTgz4WHtgpvrUcI3x0GEr2uy43UuhowupukHMMUNO5wgb+aBexewen1qJYIM0K+
	ZiQsdQp7utuiigZgliWG2vby8rEd6YsDn09s7hnRsSce/Vxb+AWGKyiaRGhLwseXfhIw==
X-Received: by 2002:a05:6820:818a:b0:6b7:8396:f3d6 with SMTP id 006d021491bc7-6ca9ce4cfcdmr7217118eaf.56.1789882327657;
        Sat, 19 Sep 2026 22:32:07 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::2620])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6cd3541f07fsm5007319eaf.10.2026.09.19.22.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 22:32:06 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 20 Sep 2026 00:31:53 -0500
Subject: [PATCH v3 3/3] mfd: mt6397-core: Add mt6397 AUXADC support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-3-c00edacbee64@gmail.com>
References: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-0-c00edacbee64@gmail.com>
In-Reply-To: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-0-c00edacbee64@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789882316; l=822;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=1otP8UYV9viBZZ+f8NwjITACufQDeLB/kdjE9I9R9IM=;
 b=9u9PT8EgMhT2CU7ynGTjZXDCJlhMILqp7KosTLFKUyKBrbzaMyv7T6YSoFBmQnoUOssaMtNEq
 wq0GEJz7dXDAC/rXFbTt3HuxJH3iGRrtfTsh2kyNLr/fEKdyaxtfq/X
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

