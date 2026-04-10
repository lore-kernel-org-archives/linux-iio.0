Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EFA33D6C0
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775857303; cv=none; b=SVrg5fXelffP14htFIaPoeoQP3jBiB2ZBtfScmGaQH6ZTeo93J+nuCFmzPniU5Htm2tpgGUSUCLWYRVnT30pI2uBSBxfAP9y3Kdc3LDonG9a7iyWW11pLMXvIk/meszQ+GCqwgwhISAm6wVqy7SZNazI6iaETHE2ANdzanxyMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775857303; c=relaxed/simple;
	bh=oUdIv2n/8Ehvb2lnbhg+EcMTh8GtWfsgCktZOCe4DD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELxTCn+GZjUoqzZdzONQMie3G+DNDRAlYDMTCDJjttNbIKUhzSl9BGmv7MXZWEoiUhfVulBlLrQj/MZkQVDiuscHFsp+F4LBA3sH5lViC7bN70j3OKAzzJ36kh+VGkmSxXOl0d7u+N4ccwFquXVG8zABYzCe6iFuqAL9yiL5vZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJGgaZdj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJGgaZdj"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f1bfc9b8fso251357b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775857301; x=1776462101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XoHxj2nRC4e86b/a0jiAov3b8pnJ0NILSyDTneQ2a0=;
        b=rJGgaZdj3eik82s4VR53sO41goccLJU2nn6NMYZ1pPmwsYOORoAg3giWeTK8q/I0ju
         H9Zp7Pw3hgmkE42nzKwsHxU+RvtPi6FKxvpgcUNc7K+vXKyFgTdo2hTwdZ5ZJt4lILru
         APDwy6AdQWjdP28KCnHOiWkPBWmoyYUdGWobgCb0t0W5w8O55JF01nqoroC370euRJqe
         AYOrd4wwsR8mZ/F26GNzpf8hak8Uz4llzeJ9y9BVJqg/irEDol3MQVFWAxe61P9n3noG
         BbGlHE9vMm5uitNFN/mlW3MX68uXmjw4T+kOa3xdgJApGh/gylJv0divl2S+E1pasl+C
         bYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775857301; x=1776462101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5XoHxj2nRC4e86b/a0jiAov3b8pnJ0NILSyDTneQ2a0=;
        b=pBiOMRLsaVRVa3ycXPMYs7s7mGn4U5xZnPB+rmKMgD7nJ4VGOt+mLi8T7Xy7/tMIEo
         kPw7+4zcxryuaULwEOMxintPFCW+kUefok3uUGFeHvoVAbVfKvc9XV3PNWEavnTBe4i1
         HqQSbj4eLH03enT9VoIz8dvk4DkMs++8qnZd5klV5L12Si6aEsR+F21dxn0sdi9yLo7A
         MHicQUCaZu5nASBDJEtj+PCJYgk+e9pJrzp4zuSp9V+w+v7NnsKbTz0r+7U6Uo1l+T+9
         l0cK0oipuwOcDnAZC7XwX24hZoppkL/CqsZvaVzLT3mJai7UWCFRqFYmIlLh0OruQs0H
         mL8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWABN7BP7dozP/2EHL66ZPt+Q6QllP0kMJNZEuEpvOq7XfUKtr1SeyeACm1kIS4/2IJGlv30OMyP10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTeSc6YGmVUtA63Pzm0pWXmdKZdc5S1NelysRtUHq+aGBsqwhM
	IfYy8/z7F+doxhn5m9UFcXtGI1SVX4/uDaR1weclZcEmZKiMH+1PofEd
X-Gm-Gg: AeBDiesbE1ygXKbr2P0P88fhQqabu2xOdBnVyCEGdBKyhNqtkyu2eaeCs3KI5QJSxHm
	SvzMuiaGKUUOX5sf1vbVmTauMfajTT1ICIfwgFQ3lnSDv6M+0dEbS8fPXILzgp84wsISIOUZPsi
	pr39txG0j9+AIfQ/hH4XOF6idTUefrhf3HVd8H8nhMAlE/E3EhGHfZVyV1G6HnVePS/jveut/lt
	vZaIx2tnce50om5hCZeJYifCige5DzvhzCBk2HaMziJ9AIXlECs+2q2MJi10Hg9in1DyxpYvynK
	uGErtYS073uOnOEIulQEnU7PkJ71wvEGFkR7TNqaSJjoVIQiUF3kE+ac91JndFXYX7XiDMkcQlT
	dkXo7NWia35JgHwigOIkZjUcte/efLPXKEdmx2vUsG2p2nmoJpJJM1TVpaT9qmHM8W8IgzkR/Cm
	eg9tjYTbYKiesB3zspd3vkq8Yuzjm7ndCFtzIsn/K7cmgwbycq6hMwKZdHD/BeHhDCYZVWbTV/e
	vIQY1//XiMSuRfT2KXF1LziTn7v9nZFTtPvV6nC
X-Received: by 2002:a05:6a00:330d:b0:82d:99d:5a39 with SMTP id d2e1a72fcca58-82f0c3649eemr5879362b3a.50.1775857301521;
        Fri, 10 Apr 2026 14:41:41 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:a107:5c92:b303:910a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c338dafsm4210533b3a.17.2026.04.10.14.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:41:38 -0700 (PDT)
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
Subject: [PATCH v2] iio: adc: nxp-sar-adc: use field_get() for EOC bit check
Date: Sat, 11 Apr 2026 03:11:25 +0530
Message-ID: <20260410214130.188694-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <your-message-id>
References: <your-message-id>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use field_get() here now that runtime-mask support exists, and drop
the obsolete TODO. Since NXP_SAR_ADC_EOC_CH(c) is BIT(c), the
resulting !-test is semantically identical.

No functional change.

Reviewed-by: David Lechner <dlechner@baylibre.com>
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

