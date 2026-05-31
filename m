Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9B3911AA
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241169; cv=none; b=NZ9aENr9IVR7Qj1fsvkZRXnjXyewK0a/SggALOJ2yqImByyKyQClRqFwJVjosaA0xgAPFzNTAeWQopdaWMIFf2NEbRY654+19njfZOIHdx8lJGpe2tZcSErLEmAWOSVb6WC00ut8J0wiKGAVKRh3YT2rVRN7FH9VF8kcMeIKplk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241169; c=relaxed/simple;
	bh=ryo7ah0jlufiyE4iotFulcpPYAtwtOR7H6GU73oSvhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZBBGZpumnYxNmNJxUqUsOT4a9UvQGZxXNUNqpKv6n1fx0X7KFIh6jikEw556oFp1Y+DAHPlzKQ1a7Dvo9lrlSWcGM1Y1VoGbI8WTIhwZbyKiZm1wb3uFX8umjGseFMhZFcjE91MOCPiRy8nr/PSLleaDwt8zzYiB+AsWFE4hhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=b8+afdja; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="b8+afdja"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4600ddc4017so370289f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780241162; x=1780845962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glJxT588UgnMfOXSLSAgwe+j1CYbc1X+ny/bK5Tp2LU=;
        b=b8+afdja6w8iFRM1epB2o6kNTx5mUBAo3qqbdv4/sx9xyRlk/YJKyH/CjziqtSfp8U
         XB9yU6bpGNkyfmbG62m8xuCu6SJpPXSCd/seEOiGkSSG9uPMKbP2F7r/94ZGh3t74FLh
         5n8ta/ulv53+Enx5rRftkIXtJazySuEqaCUQcPzD2gmZFaZclFB2aNcy8qy88WOiB5tw
         cYH44R134Onj9ehnQdmIL0isp6Po+jIalcVEsF9ZDVyORXNQnpntm8pjcOZ7MHAAOHdd
         LIFEPb2jzmCUJ6gP4QYD1czBBBLNUR5/5lE23KdkInGNASC0Q26p0YQ8QZ1qvOYORVux
         Ufzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241162; x=1780845962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=glJxT588UgnMfOXSLSAgwe+j1CYbc1X+ny/bK5Tp2LU=;
        b=BjkvT7aqkG9qbZJg1QXyzHIJiT3ZARHWmGldFu5BpNrpzQGYb94x3DPVl0hi/ZpZ0A
         SVJswqflx/NlJ+EsyAR2L7ANrQv0j9f8CtVSBJdl1Um+cC3FxB+21BtMGRDk8FypobDp
         3iTM1rmfcKlL/2MxiqIffSo1JTsOPbqNMeSHUsdfMFcqz2g8J5ifXXl6LyFg+QJKGAdG
         gJBw8470htajjnNFpX/w54D3Nft8l98mEe7xrQodgRb6xo6FRLZo0ljaq0RnAoGPuK/D
         BZ5e3vpkeHtkdpEfT/uJbFUlZG7OcYuByqcah4Tr9BEeh791DNFTFQZGdTR8qwNvGj54
         BjpQ==
X-Forwarded-Encrypted: i=1; AFNElJ9TxLQYuFgtwKjAlOFGl9hS5Xf2ZLJjU59Ek9tKdKuJEPv21PEN268YJclikAI+JETgJohcoUPCw5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEfHCu2VqAbJCAe8XwKFNXHWLLPu/RiwS9a1YuZDlHBEeMVgPM
	nSP+VWldVMFLrtsmHtkWVFm77EdYx5w/awTg1aQ3+VH1O7MkhupePGiYenbwuXqHzvE=
X-Gm-Gg: Acq92OHox5stODXqyTFFAmvzT3pSiSRBYJ4BVk//p4Tf4ottigtBxiATSpKDkwzATvs
	c5HU0cb0CjXCrDK7XXQZ7MWdM8iabtBC7GnGZRPzZbahj9ezXWs7dVvtZqahCI3ABUonsRls6C9
	LC+tQiJVQhc+BV62N5XmBpTpBdAACYrGt9xPZHXqIHFnLorcC6V70+MGSUeYidEWMizAjFiP5wO
	yy3+A+D/E6y0R9sxrjuiPXyTvTURGFUBmoONbBVMQOwhTF9SQl/ldJrT69StCMm/q/1UMnbZSQC
	VYUqLmClC+8kBms77Z0023SaWT/c+4/B47GKuCwVHf2AM4aZSpcO0tB3F1u8oEraPhL8L94k5ee
	A5VWXBceHHw7ni/MTci0k7lSdVkoW+KIxlD2XoxATLn7T3IVk6ca441Vq3eBq87jb/vCp/dImjd
	0naMbK6Pex8qzIp7lvmsVrbt4EgLLgkqMBR+Rove2ybA==
X-Received: by 2002:adf:f089:0:b0:43d:77c6:be78 with SMTP id ffacd0b85a97d-45ef6ba1425mr10029801f8f.39.1780241161503;
        Sun, 31 May 2026 08:26:01 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm18526622f8f.17.2026.05.31.08.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:26:01 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Sun, 31 May 2026 17:25:56 +0200
Subject: [PATCH v4 03/11] m68k: mcf5441x: initialize DAC clocks by iio DAC
 driver name
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-wip-stmark2-dac-v4-3-7e65ab4215dd@baylibre.com>
References: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
In-Reply-To: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
To: Greg Ungerer <gerg@linux-m68k.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, 
 Arnd Bergmann <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.15.2

From: Angelo Dureghello <adureghello@baylibre.com>

Later in this patchset, the mcf54415 DAC driver is added.
Considering some other different ColdFire cpu DACs exists, the DAC driver
is named as "mcf54415_dac", related to the mcf5441x family SoCs with
DACs (mcf54415/6/7/8).

So updating DAC CLKDEDV_INIT with proper driver name.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- none
Changes in v3
- roll back clock names as they was originally
---
 arch/m68k/coldfire/m5441x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
index 5b5e09ecf487..b02ca2eb55a4 100644
--- a/arch/m68k/coldfire/m5441x.c
+++ b/arch/m68k/coldfire/m5441x.c
@@ -106,8 +106,8 @@ static struct clk_lookup m5411x_clk_lookup[] = {
 	CLKDEV_INIT("mcfpit.3", NULL, &__clk_0_35),
 	CLKDEV_INIT("mcfeport.0", NULL, &__clk_0_36),
 	CLKDEV_INIT("mcfadc.0", NULL, &__clk_0_37),
-	CLKDEV_INIT("mcfdac.0", NULL, &__clk_0_38),
-	CLKDEV_INIT("mcfdac.1", NULL, &__clk_0_39),
+	CLKDEV_INIT("mcf54415_dac.0", NULL, &__clk_0_38),
+	CLKDEV_INIT("mcf54415_dac.1", NULL, &__clk_0_39),
 	CLKDEV_INIT("mcfrtc.0", NULL, &__clk_0_42),
 	CLKDEV_INIT("mcfsim.0", NULL, &__clk_0_43),
 	CLKDEV_INIT("mcfusb-otg.0", NULL, &__clk_0_44),

-- 
2.54.0

