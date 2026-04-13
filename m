Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA23CE4AF
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087757; cv=none; b=QQ9rpvcGi18OHtqjdiPNQ+D5ThhdVf97w7donjJDrywfeMnJP13cXkSZH9qcidnBwx4kLhSIRrz3SvQ1NnMY83JmGYiGOjnLZvahUt873bcAO4FgL2osWbWKeLE50T0r5Q7pxeUp4m9e/1dhgLscLh6apK6Ak8YrMmo1JI8qLW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087757; c=relaxed/simple;
	bh=UK63ThB1NKP8hWkvg0Sv0Hf4BjuBcNIB4MKf8Xvmu/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iVRbuiC2ZGwQTr6Wso1PUsKsyI/nSqoKSBAPFxrvBzBEIi8NPTJpLtti65pVyA9mwY18nf5qFVpOxedjrHoMVDS+Plr7QSrWxRWkMI7HfmPowjE1kEhXDvh9yNm2aX6qRCWehZ4UuUxRCwtIL67qrIutOq87huneSpRXv+m8qqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/QGSHny; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/QGSHny"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d95017a68so2760405a91.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 06:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087755; x=1776692555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0prApvQZK9QRXZS5/ii0ysHpawWRdd5nqrrRr9z3pg=;
        b=G/QGSHnyRVsKIX8WdjEzWoM2S+AjBBPT8dkgEpenXooDH4WjwFtl0Vw2pmgjZtkYyA
         8rbMgiKRrWQvVz8PcowIsDbB38n5BCeZak4GZY7ofQSHehKYOmlmC0qeW+Z4wfVX8oe6
         d5i62jfiRUduYT9wnrlFaT1r71VXI2FlLorRP2lOENtgQBYxfiLLXGxe3YeBjnLZuX99
         KJbDqv/uB8h4URYs68dFZkvNiwipgCFOCzVEX1nBJnNdx3ZTDN3iftVPdV7wxpllhgiJ
         zEgjzht9yrQANLDlx7UiSrNn6rNBUTPGARGU+D8q+9dgSr7BljbazGJKLC/c3ZwXXGqa
         j3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087755; x=1776692555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G0prApvQZK9QRXZS5/ii0ysHpawWRdd5nqrrRr9z3pg=;
        b=GC1Uz43AcPxjCl/rXNKYfn40K/G8Vkmppz6CXHq0GSTK/EslRJtL5WWeoss+NLeiwJ
         Z1QGWL+6TxJxTHAIF3kc+QNiHfTxBPvOJzKwN6kMJRV9ekGjIthBDRmURoPITF0NaLtS
         qRrxL7kYvtODcAP0897bMNiM4mu/CcgIfS0UxdXrUMg9CytCuWeDNvaaLSk2WTDC24F6
         XZyyaYyzFkLRKgvYKO3ub5tgR9GdPFuKdLR0C6mflCDhaUtNecQ3DvdO2fxwoAKGB6dD
         45LwZJ/3fc9hQSDh7T09G5wq1OQWjXEYky1E/UyJ+F4uNEZj7amoYOklki1yZjiWPNv0
         VbPg==
X-Forwarded-Encrypted: i=1; AFNElJ+DyJ8fQk0BlBT0GO6Wji2y7HPEw54vfJMpIEuiV1ww65gc8vmGUD8tcUSWxKqMU0ZL4S32Lt/+A/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJS1JXKV6cvbjN6wZbpGCwbvz2toGjS/MHF2JoVEB9NQRarKpE
	bMjQhig9ybpYftWqNnGJg7r6Dlhpv59gzPl9wffAf5SsX7xnA5SUBJkL9dOqtg==
X-Gm-Gg: AeBDieudChWIEPxSAYxqcY9zHQ29PKt3rhaF85XeeScgg7XJBcZtdLEHXhvg8VbQPAa
	utSzuJM8f/fT8eZgLdr+nupthV/E8scDA2er+LKtBOg//OHB6PMohhilele6YaihS1EFgr1j082
	Q2m2kKDdiSyM0+SqEalKk62jDsDoZVcN6S1O3/8BXKxKRtWpgl7G+3C4e2G0GUdGg6573h9tuat
	xW1xA/8vdPbdwhvXjtUyppXSLACd/lXvBWu63oE6xG2/Om+pcT+pVyHjhkB/C50VdrkBcCU+Hmb
	QpDfKXF3N67NOA0wFSVvfD1vWIRzpTmHxRQmIGy2IgYeY6kM0q3X/BaLyBYRWY4z82458Tj/93k
	gg5h6MByi3UmdoISQFluWeHWYD7Atyp4azSRildwtC55Bs4riHDQvNnHC476uoBHm/N8eYFHWbx
	hHNs8XlalAPjDqHQmSphizUn6ZW61z2p5XGO1rhX8fyVOFuykq
X-Received: by 2002:a17:90b:4a41:b0:35f:bf4b:c396 with SMTP id 98e67ed59e1d1-35fbf4bc5afmr1216337a91.1.1776087755259;
        Mon, 13 Apr 2026 06:42:35 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fb0dbd953sm1832186a91.12.2026.04.13.06.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:42:34 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: adc: ad7173: cleanup codestyle warning(s)
Date: Mon, 13 Apr 2026 19:12:22 +0530
Message-Id: <20260413134223.2331911-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413134223.2331911-1-sanjayembedded@gmail.com>
References: <20260413134223.2331911-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reported by checkpatch:
FILE: drivers/iio/adc/ad7173.c

WARNING: Statements should start on a tabstop

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/adc/ad7173.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index f76a9e08f39e..b9c563947e2e 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -666,12 +666,12 @@ static bool ad7173_is_setup_equal(const struct ad7173_channel_config *cfg1,
 	 */
 	static_assert(sizeof_field(struct ad7173_channel_config, config_props) ==
 		      sizeof(struct {
-				     bool bipolar;
-				     bool input_buf;
-				     u16 sinc3_odr_div;
-				     u8 sinc5_odr_index;
-				     u8 ref_sel;
-				     enum ad7173_filter_type filter_type;
+				bool bipolar;
+				bool input_buf;
+				u16 sinc3_odr_div;
+				u8 sinc5_odr_index;
+				u8 ref_sel;
+				enum ad7173_filter_type filter_type;
 			     }));
 
 	return cfg1->bipolar == cfg2->bipolar &&
-- 
2.34.1

