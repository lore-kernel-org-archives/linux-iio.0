Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F73914E5
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241173; cv=none; b=D/4joncUTGEBTnZO35GnEy6XSQJvx2DGDTxoG5Gm3q/lHf7d5QJw3jC+1tavuZtpiJt1qBUDRptuR9L+FPzlPJDzFTShRXs0wVoxqP9J46leFsmcBN0BOyidN0o4mgWqaxHSwz/4IOgPXtSm0lfbjOSS+DcqCIWBXAUqUhht/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241173; c=relaxed/simple;
	bh=48aemOcrWCaMuI9OaLb1kPeXmDDnY3b+T5yp/gEBE7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F70MX4USBjhqgxGWcs4KP8ZFvjWilU3qKvytANUkuV+c9mJSLBlJlthbaMxyvw36ta3vi9dZSdG/kL3D1E+MEkxiLMiqXTZ3WBY7GI1ZI+gRUhTT2njsLf80rlK2cKjeBLjc7xNpFnt/3DlX2zEJYNW8tWSN/L06urG5rCphj0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FbB9Hh7m; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FbB9Hh7m"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef5146b56so1129121f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780241168; x=1780845968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PT9tXjqszedmkm8utnuW3FRNsoSqZ3umHWBcRjh1WUU=;
        b=FbB9Hh7mtvc1ex7tqtfo/K+BUD9ZMJ9zQjtQPFOGVIGGRQdx4koDIW8oHBhOsVy1VQ
         +WiDHSnyg3OQj74kBNYmyE39yT/Tw8tjxfFHyuk/PNMMzyhKaCAWi5EZRjB5TwSEA6+Q
         6jt+Hry0bcd353a+/TFO8K0l9mdVzr4xG8n2TP/3yVfrNKjBj1w6FfnoxiKvtKKMXPJN
         Pi5eqaQYjwuKubVxzUW6+4UIazqEl8i6Da4UtsaRyAyq0VRkX0ALiG1kXW3VqLTvVAKU
         NOY1Sntz28Xqf2004lYFD54px18BsdbUaQinI/IF3MlDzS76TobjOdOYpdBdUWfPNTnf
         TZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241168; x=1780845968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PT9tXjqszedmkm8utnuW3FRNsoSqZ3umHWBcRjh1WUU=;
        b=LqwAd4QlyknLvRMuppqUCoMN9tuTFXCbXIsXFCMkABZOO+Kwcacy6tTMFv0RMRrwO+
         cs272VETgQBygbJlzkgeMv/tN7tZJNSkUqqRg3qUev64SstH4copXUtblqmA3smmOD70
         vxY6/dMWKTxOxW+J3JbhtwlmNATe9sGCdr7k0e+oDACEzVKm5Oa8ujpBPhER44/aWkEK
         QVe3NHtsHxBxjfxbMTwFSRaRiFfDCpSK+hVoVb7u9vTC/fc+3tNwrJHWQPNbMlmgJcHV
         ITtitLuuQF+3xqHsQ8gTSpCVKwqqY2Q++bH+W1+UqxzqVzn1OVH1IG63Bl6bZBPY+NqQ
         cqhg==
X-Forwarded-Encrypted: i=1; AFNElJ8dC4t173RdgIY6mvX1u6gIsGoPb8uQV1nF+Zvc5Tf2lG1k9iM9f5G+W6GXzYkou72AKzZnqelPXhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhPPD/M8A4X2XfRM60ATOOixbqwVhlpHBYZajgBtBGAclrCEF
	yep+xQ54bU/ez35oyty8d6PoVzyrT3IwYJ8lguJJeQ2KDUUZVSMeXbiXIlO/a4c9vjQ=
X-Gm-Gg: Acq92OEHytBIKfDiAntfHbTNrKW1pWmUclLQja3OTxjYER93tRDO7Tedz3+jQnba4/k
	cWDQYULtpALEhLl9GNl2AH5aDahF99Rllt1UPkcDrv9V/pIaVR6qKgsXcJ7lm+19fbkT49tn+Sf
	CWO8Pv+yUFxLfsOMFhgOAypR4g8qBp5mNe+h87MQiAYWo4/5jgm9dk6+OkstHB2A/AnC22ARndf
	Ggw6eIOueX8EvOZUmf2j9f8CRQHNbDzpLJflVohqAITi9u8tV8XHkg7+DxvquwmtfprS/a3A6KJ
	FR5NuKnGptYFDGD5SKLP8aAr7atuCsMCXlYAmKfr1ySLyJTSlvZQvpf56WR3HZSngcjBAMOHNey
	+0lz3q1S9wztPkYmque8kC5jCyZ2wBRPcnNltCKmc794EltI18aa0NPUawlOucYp7QwPaPl/xbA
	Fb7JFWRfaWICA9FFf4WnXuxqe3OfzcwqmbtkITr0kKIg==
X-Received: by 2002:adf:eacc:0:b0:45e:dc0a:bcb with SMTP id ffacd0b85a97d-45ef1385deamr11155719f8f.22.1780241167790;
        Sun, 31 May 2026 08:26:07 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm18526622f8f.17.2026.05.31.08.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:26:07 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Sun, 31 May 2026 17:26:02 +0200
Subject: [PATCH v4 09/11] m68k: stmark2: add mcf5441x DAC platform devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-wip-stmark2-dac-v4-9-7e65ab4215dd@baylibre.com>
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

Add mcf5441x DAC platform devices.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- fix copy-paste error on naming
- use DEFINE_RES()
Changes in v3:
- simplified DACs as single resource entries in place of an array
---
 arch/m68k/coldfire/stmark2.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/m68k/coldfire/stmark2.c b/arch/m68k/coldfire/stmark2.c
index 536252ccb87e..d3be4b2953fd 100644
--- a/arch/m68k/coldfire/stmark2.c
+++ b/arch/m68k/coldfire/stmark2.c
@@ -8,6 +8,7 @@
  * for more details.
  */
 
+#include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/partitions.h>
 #include <linux/spi/spi.h>
@@ -83,8 +84,28 @@ static struct platform_device dspi_spi0_device = {
 	},
 };
 
+static struct resource dac0_resource = DEFINE_RES_MEM(MCFDAC_BASE0, 0x100);
+
+static struct platform_device dac0_device = {
+	.name = "mcf54415_dac",
+	.id = 0,
+	.num_resources = 1,
+	.resource = &dac0_resource,
+};
+
+static struct resource dac1_resource = DEFINE_RES_MEM(MCFDAC_BASE1, 0x100);
+
+static struct platform_device dac1_device = {
+	.name = "mcf54415_dac",
+	.id = 1,
+	.num_resources = 1,
+	.resource = &dac1_resource,
+};
+
 static struct platform_device *stmark2_devices[] __initdata = {
 	&dspi_spi0_device,
+	&dac0_device,
+	&dac1_device,
 };
 
 /*

-- 
2.54.0

