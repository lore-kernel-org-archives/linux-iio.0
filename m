Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264403A7595
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855621; cv=none; b=R7+i0+H9BIPKhbdrvaVlgw5YoGOwy7+Fs4n7G87qyRMTePfeYI5/Gtxy5UeyUqcFQcYg8N/XNnZ6BLIj4MtFMn/wz5+O9iO1hD1ZbE40rDobJBqGTsqh4kfJFog9H53VNyIaroyc1dBgy68g+Mhe69EaJhEF9c+0nJg8JglVaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855621; c=relaxed/simple;
	bh=RAozP+VbHyQFKYgEz45qjCh1Ow7iRHc6sS2QirPeX6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NdmHjc3mjkF6syHiKQi6HitL9jzXgHe1GL6T5OU5AiFdNhrl725DAAcNnOf3JtpQmIzLdC9QH0cvtED5oEcozY68datbymNloDi8KipJQGfkxNY8C4E01AFFZYMVst6o2kGZtxq/oz+BOA5a/TDgzi1ejMa2WPeMHAaRAgSB37s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bpy1eBNx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpy1eBNx"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35d90833cacso1733698a91.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775855619; x=1776460419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oa7RWE7GfngIzdmApNxMxE+R7EIFKob9N3wDr4D9W60=;
        b=Bpy1eBNxfC0IKIYGwYGLYenMjS9XC2URwEY+oOWKg0tutMKAo9dkPXn9lcH++bl3bn
         R8Pi7+wuCcNQWpuNoDC84FUVsls3rjNxDb85SVG2rkZQOfLXLSPwNzM6El3j1o2bXmgN
         7rocMDB1ATitoAP5IrYMKjI09b4OFNG8ljHPkT5/hLCmF+b5VGEwV476+DxTsEuYVgnp
         0Eo/Op1ebLhOLACWBF7Ny9srn3a4u6fM/miK2s7mwudyolgBUUYpL8TNs+qWQM9/gd5g
         ufDhqxipVQp07xbgE80GXWNY5f7B9egGL51hn3oT0Jui0jHeZ0MP3xgXcJO1/BZ4sz70
         W5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855619; x=1776460419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oa7RWE7GfngIzdmApNxMxE+R7EIFKob9N3wDr4D9W60=;
        b=ocWvquik6+YV8EmzVlDcFIM4uMJw4MII98gxyjJE8mRZO3G1zkzgls8QW7yfr6s/NJ
         VBJdqb0q6gI6YV7bjHD7jcWk1QlfiABuGOtq+raNcRVfgRGrjRTAdBDCfzZrZqqD/V1p
         abQR9bgS9Vcsbpguh/jkRo7p3UScyfYM6wizGgiPcF42/qfNmFiuetyus6E2fcj8PHnf
         5IDWTX5Iov4L6t91Kil/M7bRvAdNIBpXBIbTf4wOmSdmBkl26qFwDAdpuO9Q9/gd9e3E
         iBi0uNW9RrMEPDDPKrsNJaza3Mw0zafgibbs7FSWFlkjUj7leYUm3a2Rf8IQII+P971b
         RNxw==
X-Forwarded-Encrypted: i=1; AJvYcCV/ASaj/DCpRbOoPMR105IOyOUAyvNKFJUhu8yJXR+VU8iB4Dn5LAT5wjyofV/Q4d7tq6dU1r7zHlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9eVPSEGLG7qELJnFZkwqhz5uwzNjxG0fElaBwexXDpPWciCq5
	RTg2OpD2lpn8O902hL3C/qjcI6GCDPQNFXri645W8UIAZOUGBkBzcnil
X-Gm-Gg: AeBDiettU9kylyAnfDTyrvJaHeK0ulbs1kaFUe18YG5vC2DC05TDO/Kj1pltSz0qZMq
	oZiYDUpFQt5EovxQ/CMWUV8D++3JtDmncsSQctxzU/hRI3RZ5cZpIx3BVMZX4mZ5YyQLoaSTRTJ
	uOhPC8dvTuPbqrAue3uTiDwVaFUsBis0SdljJ1+QWIWyzCvyJ8qI8ASvCXMZQ0uo6I0DYPgH5tG
	Tb45Zv9I2TcwaPXWj4fUBlXbK8JSiQhQ/r5HSoHoTts4Ps406qd6RXu/ZlQ+DD2nEdTAaBcJtSn
	63TYwT1bYO5VsRXSd+zps70b+17qGx6Uss/MFHGeEL1ssIUc56fmBZpS4v65dDf71jj8/Buqsg6
	40feTKqKnjXEPtiV99deITTqVASm/xuqiaWIAOpv40Ol9do1PeeGIR2xfPJetD7qsxU5Fs/0JAn
	AKuvd6dhk8l/S7IetYYuoRKCqm91q6XmT3UA2B5nqIsAm0vgXik9j59GsUdLxqG1/pZ8wkKPXD6
	IRMvto10PdJxJOddj+vp3VpxdaYIktYbJ4RFvPZJlVE3t9oECk=
X-Received: by 2002:a17:90b:2c88:b0:35b:b907:370 with SMTP id 98e67ed59e1d1-35e423fc9f7mr5274097a91.0.1775855619461;
        Fri, 10 Apr 2026 14:13:39 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:a107:5c92:b303:910a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e35178460sm7684743a91.16.2026.04.10.14.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:13:37 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>,
	Felix Gu <ustc.gu@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: nxp-sar-adc: use field_get() for EOC bit check
Date: Sat, 11 Apr 2026 02:43:24 +0530
Message-ID: <20260410211329.185147-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses FIELD_GET() for constant-mask fields but falls back
to a raw bit test for the per-channel EOC bit, as the mask depends
on the runtime channel index. A TODO notes that this should switch
to field_get() when available.

Use field_get() here now that runtime-mask support exists, and drop
the obsolete TODO. Since NXP_SAR_ADC_EOC_CH(c) is BIT(c), the
resulting !-test is semantically identical.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 drivers/iio/adc/nxp-sar-adc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 58103bf16aff..d6c2a0d50bb4 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -316,11 +316,7 @@ static int nxp_sar_adc_read_data(struct nxp_sar_adc *info, unsigned int chan)
 
 	ceocfr = readl(NXP_SAR_ADC_CEOCFR0(info->regs));
 
-	/*
-	 * FIELD_GET() can not be used here because EOC_CH is not constant.
-	 * TODO: Switch to field_get() when it will be available.
-	 */
-	if (!(NXP_SAR_ADC_EOC_CH(chan) & ceocfr))
+	if (!field_get(NXP_SAR_ADC_EOC_CH(chan), ceocfr))
 		return -EIO;
 
 	cdr = readl(NXP_SAR_ADC_CDR(info->regs, chan));
-- 
2.43.0

