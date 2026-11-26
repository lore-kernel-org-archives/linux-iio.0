Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795662638;
	b=sVG0Gghr63UqJZTI7fUX5utFwcZMEycYB7fqYsX4Khus2nIuh1RSRNDYPWTzc26azZE0
	 jIj2zZQSzohltSR4sqENwEXjBaMvr7KwI4UGFGEikQZPhgbPU3uvS0XwIgRGRF0jZdKLo
	 2T1ziEuLTtTgJlqL+p7++Wpil6ulOSnHSlb145qaQUwnodo57/WPy8cBzNQBftgnwKlwT
	 cazOen2qAeYuJjqnckszavPETQhVhMR0RGEsJAw08eTyo1ftKDAna8KMkREOxmfh2WdR2
	 o9uzXKLXW9305cYiMMXto+VJnT6bQsqbwwltxKzzKGtqIvT4Yti8FGp/XRPoZ8pGqtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662638;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8I57ZSU/sW/OUbXh5CAZCyvQxIaUbucbzW2WFatF0oc=;
	b=FJuHyd+H0DCRmpAPWgprheVpLOqq9ry07tySmBXYS+5idNbKIf+W/oGjlhemEhLYToit
	 W8KikVDiuG/SR+UVyjCSh9MRKA/jUnpmMCTKgfXmG4qhCQw26a1sZUphcIfbtsCHpLmdB
	 CSuNz8w45E489FTrf3DZUoRulZlnhFYKhOH0oEdwIAltrFjBJMpv6wMS6z8Nkwf9dWVV5
	 eH+U/GRRvHd5/eUQJN3gTILS3CL1sQPH0lIa7g6+DzM2Edj5cGq6qCIYWbkz/iDNiLlKI
	 x0whRRA9Fo8vKyC0Lk0ANLmity4RIYh06IbwiBMHK/Y4kdMpvM7cYz+btnJlI+FMnhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QVkW/SK3";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F883606A33B;
	Thu, 26 Nov 2026 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVkW/SK3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795662637;
	b=fx1dJhAU4N3MmDZrpXYk2s574iMR6P179VzbnnCcgTrBLn6Dz7agv2F44dilAsV+HCbV
	 Vgaani4vI5iYMKwi6vIdw3fycbWCh9LTfluBvMlF3i9wZARUD+km7pdPf9n+6TbLkXIev
	 wlLc1XTD6lwnerUMtJvulfg30DRu0vYxpe/BQpHu44vxAgO/DUcfzL32hGXLarQ3gjcdC
	 o6t00FkEAplwZdqB9FJb4taO8WYQLFnF2ve6Nweedzj3bnlkHFHGDSsGhR5RpT4XUqMsb
	 Ciyau3GCE26x+t9HkGpRsXmbD4DCTnb1ggJOB8XbL05CktzsCIL00q2TCXdShvbuu2A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795662637;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8I57ZSU/sW/OUbXh5CAZCyvQxIaUbucbzW2WFatF0oc=;
	b=J+3c1duk27jr7Aa84lJ7z1P1JgE7glOcgOvxlbylDQDbEoY+Mx39i6+5a65EWgAZkKhI
	 Iwynfo7gjfiguiDVY83wrAFjb+bPPhxEd5X9vjrJ/sUJfdx5EAzRlnhjt81PY0bsK4fYN
	 agRHFjWUAsXJr8GWKk7LbHZltZLjec8L/r/quiyBmtx3MuVUK68vs+G+zrQ0hw4/F2djY
	 +bUqfSuFBFSF9g5WxoYU1FVm6Gp/LU0MntJ7JK+T/z1xVJXCTMMxJY1urBl4QpB4sUe9l
	 uOP3aIl134rRN0Ab0H2ntnGV67tyPrZ+YnSkyZP6Va0qV02HYhbCLFyKY8vQUjwLzzA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BC1F41F00A3D;
	Thu, 26 Nov 2026 03:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795662637;
	bh=8I57ZSU/sW/OUbXh5CAZCyvQxIaUbucbzW2WFatF0oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=QVkW/SK3tBZmz0rsnMGMmstnmuABn7tjLllWWak4OV7XwXjvMqcrntgsLV7t/tj4M
	 ygGLt39TW99ARIRhbAo0ygRxtB06Q5gC8SpaKF+myhG8rFzgHDvvXEPEI/zWECD5eS
	 akoqrzHWqDI4XXJb3Cbac+liYOeLTumLt5zOUioiYOlWvH2fwK46Nd1Qvu3SSvuUgz
	 FwBcEzZ6YiDDvuFKUW2nGiY5Ie2IxS4L2ivjh3tYI1XuC/Re6ZRxKF/1glMdxC5En6
	 D+F2iLc4VtHae73+aLyZIzhddnwVdjaz4c1ZW86ero4Sjy3LUh5qgaogztsA54JpBh
	 ZRvImjkBPZTjQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7910B4D202;
	Thu, 26 Nov 2026 03:10:15 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
 andy@kernel.org
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iio: adc: mt6359: fix MT6358 VBAT impedance
 resistance ratio
Date: Thu, 26 Nov 2026 03:10:16 +0000
Message-Id: <20261126031013.27701-4-iasnezhkov@gmail.com>
In-Reply-To: <20261126031013.27701-1-iasnezhkov@gmail.com>
References: <20261126031013.27701-1-iasnezhkov@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795662614; l=1349;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=JtIaf+aptgsdQNrjuZzOWwJGJsMlugQHaT8ZbxTFbT8=;
 b=eGLXWpH2yraGWz+KNJrogA0lqnF2eVewr9fxOtNOMs9Xshy/+DKsMdIEp3d1TMGUw+k2IuUqQ
 Dg/dFyXh6SODzWb4u5e9wR74AnpUW6wFFS6oy+mIc4RJYDD8OvK/0OX
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com
Content-Transfer-Encoding: 7bit

From: Ilia Snezhkov <iasnezhkov@gmail.com>

On MT6358 (and MT6366), both BATADC and the battery impedance VBAT
channel use a 3/1 voltage divider (5400 mV full scale with 1800 mV
VREF). mt6358_auxadc_ch_desc[PMIC_AUXADC_CHAN_VBAT] erroneously uses
7/2 (copied from MT6359), over-reporting VBAT impedance readings by
16.7%.

Change MT6358 VBAT r_ratio from 7/2 to 3/1 to match MT6358 BATADC and
hardware.

Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
Changes in v2:
- Move AI coding assistant note below ---. No code changes.

Found and drafted with an AI coding assistant.

 drivers/iio/adc/mt6359-auxadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index 4a66253..915378c 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -285,7 +285,7 @@ static const struct mtk_pmic_auxadc_chan mt6358_auxadc_ch_desc[] = {
 	MTK_PMIC_ADC_CHAN(VGPU_TEMP, PMIC_AUXADC_RQST1, 10, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
 
 	/* Battery impedance channels */
-	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, PMIC_AUXADC_IMP0, 8, 128, 7, 2),
+	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, PMIC_AUXADC_IMP0, 8, 128, 3, 1),
 };
 
 static const u16 mt6358_auxadc_regs[] = {
-- 
2.54.0 (Apple Git-157)


