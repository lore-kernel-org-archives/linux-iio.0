Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEC32DF13B;
	Fri, 12 Jun 2026 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301122; cv=none; b=J3sdBR16YqeKrCyvpL3HngJSQoY5vG9DQOi2W8Czwt0lqwVsOdCiYj5fME0e7XmIEvYbhB/F8HVOTTw7BDE6Y0ilb78McArrXq0K9Sc4oWKla58DdR6KS+/DB5e56wsbqBAcME17hS+jvpeal64VYrbtc3XEev6jAE9jkhec++U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301122; c=relaxed/simple;
	bh=I+4Stp/Y9tN95sbjek5A/i80iz4c/UX1jXiwbw4p3kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHGZ1wkQXjI5mELjf+bdtNMxr9Ke/uWAGoHMWtQAK4qXDqoJ/OEzz3ydH+4Hs1GJSLlQhz0SwNQ280lfZ51v/k4588Rfb+NaYpp2vSwSZ6yrCIjnxiVB8Fv6HDZVsWeREH3GSPJkMnwAjihoYt0XLdvkbHR882u7Z28/1dg15KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COHQ8nn+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COHQ8nn+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8038E1F000E9;
	Fri, 12 Jun 2026 21:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781301121;
	bh=qkIx8q1CfZPS2O/VG2jjN8ujjCBCEKLsuaA9oPqWhZ0=;
	h=From:To:Cc:Subject:Date;
	b=COHQ8nn+uwEmeREHJbwM+ltA/GmYxv8zojZJDDH0O/FMsq3kOQyUyg8/pB2S2psgE
	 P6rdCYfomyFhWZyc4cVVAe1stYBHUUflYgm/MN+n9zc3I+IPpzeC/DgoOtnT4dtdv5
	 JVBLM9mFZBHZfa4xp9QoSDst0mg8yorOCHpcSr2EgzsT2C5/lDuKTjCQaW3RmJ0XVx
	 js5T56CwI4iS4eilAKlTzsop6BJwF6iAfk/xk5ANSqY5x3UFUT8DMIcUGHiT/kffd2
	 eNS6AgSaNlucRPT4BINvUY0PRbGYU03r41WKqASzYsoqd/59uqiIhcYUnZ1j8UhxpF
	 /Xl4r2Xxgd0RA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: stm32-dfsdm: Treat flags as booleans
Date: Fri, 12 Jun 2026 16:51:50 -0500
Message-ID: <20260612215151.1886851-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "st,adc-alt-channel" and "st,filter0-sync" properties are
documented as boolean flags. The legacy parser read them as integer
cells, unlike the child-node parser which already checks only for
presence.

Use presence and boolean helpers so both parsers follow the binding and
the property type checker no longer reports the flags.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 9664b9bd75d4..00f05e167afc 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -660,11 +660,8 @@ static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
 	}
 	df_ch->src = val;
 
-	ret = of_property_read_u32_index(indio_dev->dev.of_node,
-					 "st,adc-alt-channel", chan_idx,
-					 &df_ch->alt_si);
-	if (ret < 0)
-		df_ch->alt_si = 0;
+	df_ch->alt_si = of_property_present(indio_dev->dev.of_node,
+					    "st,adc-alt-channel");
 
 	return 0;
 }
@@ -1815,9 +1812,8 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 
 	adc->dfsdm->fl_list[adc->fl_id].ford = val;
 
-	ret = of_property_read_u32(dev->of_node, "st,filter0-sync", &val);
-	if (!ret)
-		adc->dfsdm->fl_list[adc->fl_id].sync_mode = val;
+	adc->dfsdm->fl_list[adc->fl_id].sync_mode =
+		of_property_read_bool(dev->of_node, "st,filter0-sync");
 
 	adc->dev_data = dev_data;
 	ret = dev_data->init(dev, iio);
-- 
2.53.0

