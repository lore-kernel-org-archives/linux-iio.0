Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FD438E8CE
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484889; cv=none; b=XVfgoTXphy3T0dARunLmL/jgZKOYoTyS8Nd9+v9oY9l2mY8Bah9kBevg2fLfzt4j0eMdRn9AxiRGA4YebjTKv51ffdbPQIFG21x3Wrz8YLZ2M0ZptPIGAb6naXQL72EyO+6JhLWWl01QQeBD65LudurR9EatWaG0mIiYQTIl7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484889; c=relaxed/simple;
	bh=48aemOcrWCaMuI9OaLb1kPeXmDDnY3b+T5yp/gEBE7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HMtB/+UEq7YauLCXwsnLKI2us48G3bfsepmyoo9wSt989wPGfMJobrNoYTbMprrSNnWgZvd111SMGsOaVj31abdCfWeHx7B/Yj9u476+f5AsM9UcTasY4A2mphT2s5E9dIz0F6JKEG7mRMvsL5U/2iV+2z4G95eXMYuEpAC7/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ct3I+z/K; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Ct3I+z/K"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso1818755e9.2
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779484886; x=1780089686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PT9tXjqszedmkm8utnuW3FRNsoSqZ3umHWBcRjh1WUU=;
        b=Ct3I+z/K/WSBtskOJIxa3Zjk0YEjjqsGK97sHyeHYdFsVtLo0uprMityPqLYPzFz94
         u9uL/bJ9wNCOo99VCI46nEnzRgD0Cy/zQPL0+m5RzOyzxlor1WFfsDI3CoqVkP+8gwlt
         2IO3a7xh5tJa59cdOVRpZj/QLz5YdMWYCouc0s4te7Sxr3Jw11IzThrAJKbzd7lNMyvt
         ilIlVE3OHLlKCrU6TgIqFcNA2wdsJcX0TPu6AcBLKH4iblkmphOcXVWQD06ZuNYI16LV
         PSIcni0ZSlK9R2FTuHctFQved7C9YA5O8Z8eAiAaeT12hs1BwPNtdCSJDNBnKWXr5EHf
         UYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484886; x=1780089686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PT9tXjqszedmkm8utnuW3FRNsoSqZ3umHWBcRjh1WUU=;
        b=HmZN1DW9TXuiAa+BNJt7/A2s4ooeB67c9ZDhpSPE1bzq4R9xVTKX+neKcKgx3Y97ri
         ZSZfZnCOCL6+62Kr4Mu9NjlPFyg7E2qt/iCYJMj6MqTd9bsBZRbQAsdBlFjFdT2kPeFG
         2p0yQxY5T7knOa11lLXFuuQcPrSAMzyZLjfxdo6efAUsMt3Th5AGJ+nE8I7MzTq7EXXz
         K7lSmMKUUA6rGFARGPjyvs3jjMWjparNYCFKfazulPUr4mTmI+v/ca74AaZ+VA4VwfnD
         HSRRhqGtsNMKOq8UfbCht3OroLQcIfpwzmTyK99ePT3VKuSMjDXe23cuK+uoHegOO/cs
         cWNw==
X-Forwarded-Encrypted: i=1; AFNElJ9trSrIOZDeyNpqYOAV+ttNJ0XCQ4NOEbbCigRA+ExKmOVS+UzwK6JTnHy7HVzjoNJesvLuugbGhls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrJZv9Lf5T4aly0UDOXhnQeCvh4dcqR/7SYyTyjft0sKJYDYMz
	YjYxVho416KPYoSJeGkTrDV7EM42RwLKcG1U3ag+dWPezNZCa29DDGCfjWAl8qfttI4=
X-Gm-Gg: Acq92OFSTuK2Cya161C/0QmOanYCJzel98Xtezo+4Qd4K7nv0ZvaZzseLzR4pVUKy+F
	2REmjPALTQ3fXZ2XPn0qMvtRMMQqFXHg8yPw7TLoZHusp7p2bfgUyrJ1J+BNOZMJqzjxk9u2JfQ
	sRxPthFnnBY13w31LJJIw/XVQ5CwvEnS/gI83zWG4CNfGzz4sPMXo4KUNDxXk+Yg5Dnj/VXnkH2
	YwFwVZkpvICtnqqXIErOT5KIYERAssE0DXkr5+PJuLxHGIc7tlAQXSPksAgl15E8/kja0BpBS/o
	gKul2otRm9hxfN05fap1I8SwnO1CmjEhhAylPCEw583Ndts/7dMv7N5rJQV9BzBY0J8sAHd2V+R
	dMPddza1KhCIH9yFF0H3pCXnCQ2/yItQ7oSl83vhDBcLGUwsrgrBqIr8v0yHlsjZhwa6u6yFtfN
	pfjThsVzuxmg/oIkbZGl44qUp+gW7uXgo8bgwg7LWn52PkMLVUKcf6
X-Received: by 2002:a05:600c:474d:b0:490:467e:a3d7 with SMTP id 5b1f17b1804b1-490467ea4a4mr57405925e9.30.1779484886067;
        Fri, 22 May 2026 14:21:26 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm73312225e9.9.2026.05.22.14.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:21:25 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 22 May 2026 23:20:37 +0200
Subject: [PATCH v3 09/11] m68k: stmark2: add mcf5441x DAC platform devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-wip-stmark2-dac-v3-9-16be0ad35a67@baylibre.com>
References: <20260522-wip-stmark2-dac-v3-0-16be0ad35a67@baylibre.com>
In-Reply-To: <20260522-wip-stmark2-dac-v3-0-16be0ad35a67@baylibre.com>
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

