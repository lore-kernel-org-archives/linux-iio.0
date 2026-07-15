Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004B43C7DF
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110264; cv=none; b=AUbqZMkk7nPlzNjPWvUV4jROplS73+y7ULlipdffRlQfzBFXM9ZxKbuuePxI0bPsywOaA1DJeKFRhRbcU8Q0Qo8kI6R2IpyWK5dNY0723YINH0FSuzU4rWnYcKanGkHHnhZ19c0IyFZs+wSHFrherJZl/IgEPK9/ayrZQmwNPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110264; c=relaxed/simple;
	bh=DO4pUTloSCmd0KOmrWJsUS2U9gK6DNRCgmxLFrZRTyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dY1TPm6PKFoAQFB0g+HD2eHPHBEQpB9WrJt/jFLUqjLfx2LPOaDSBK+cIRJBHlKbOLdSd1OvaBzwWMp6oBoCOCnwI3lNclugPxItkzQUQgb9m7p1qynRDPtZ/LQ3cif/QVaxP7G1I16vwQCPRrMC8+2YCqyP1l+yTdgsumefQag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVTXlJC1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVTXlJC1"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so2126508a91.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784110259; x=1784715059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VNXyVM0mnowONm4346tNECsZGvG1q+nnKtqJNufizQw=;
        b=FVTXlJC117BcjWQdJBRHKPXSTi5H9rrFFEDofRSu3aMPyn0emuR1LG5I/lFnfq6y8A
         hom1aVRIV9N057hMQNkvFW7ukOgJ11LzU/6vWPN/A80ddE+zFzLUoTFBgb3I4Gw8rQxj
         Q0ZOm7TJUkyZIczLXfP9r5l5fKbe+h5mxVYfMoof9o6bGbjy+fpq9PU2ASlN00YI/bas
         dGLKdIQGmv6tNInT8NIt4yocE3PtXhhF7wjD+kR9Q9u13Ov08WzfY0MeIvwICMHJias+
         bfEGpm0itCMBazmuxtN5l2FY5NCGF/QAcCPvEP++NzBWBzIlG2MeB1m4WDqjNb6UiCrY
         JSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110259; x=1784715059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VNXyVM0mnowONm4346tNECsZGvG1q+nnKtqJNufizQw=;
        b=KXj1YdfolTpDAYZIcVB6u3vWJ33WA4rPE0JCaKuA0rVCRMn9PVHeAFUIVfzF8WnoKt
         arurO/RbR7QQ34Ypf0ybNkZpqfSQWI5UMGDO33ytHqJmMbOAJ4pzCE/dPEgjUq95qPnz
         Cba/PeTOVq2Fe/IXVCJ5pr90RakTJdcYpr532Ciu+D0tF9ITFM5nnAFvDLak2FlyVeZ9
         4k8mdP0y/VOkLv1a66NbF4iEnYA4CwwBd4O7PqI4NXwVqvrpIsI0nA1hZrwFdYhO/GTV
         qh2sKAECD1ETgiaPIFdp8Ckq7P4lTLiQ/nR1WtedMtdrIj/K2P1ETh/LVdcCCR7nOPKW
         aHOw==
X-Forwarded-Encrypted: i=1; AHgh+RouaRQgvsTKVAKsV9l7WTi9+Z5hMzinF6O7sl3HdculykJwi+jELoNMlDqDh2O8r3jllXN2PhJP40Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/73uV45VMDzJo4EY7k3BRgfvqHACMU3CudUj76Pim2QV2OFM
	G0Y3EjHTZLTfNNP/WAWmYH87qTbe+Z7sSu+WRCiuObOeg5X17ZxC5geW
X-Gm-Gg: AfdE7ck+l2Q5V8A6x8Murd1yzd23upJBrWpGiG06ozKi9ey8K1iFstI9KgpDytSPgeY
	C8CNOm2O1tpbhXrhhv6ODnTCpzVJrhUsRrELSx1rpzq7V+s+O+rLeigwsePo08imLFDIfyJUxr3
	+T3RP/JtBb1GRuEBc8wp9ERtbKZchSlzCkNeyENEJ4uJGBlekyXUGcXD1cG8Y/iAnK7vlApWPRY
	AUQFi1Z66GzFdXg1GLK1D5IpCCOGo4AyeqS/hajMnX7IdQ1ixLZ1wS7yIbpFQzp/fH+spqpYQAX
	N9E42WHkvKAxGHOL4v6mIeqZdlAg83PkQUv3VsCetSEchn/a1IPQjHUoU3C8qqTE9HXacggmUOg
	w1QmOd87CgvpHvtVzsqcXs7qlpY9QG9j28PgWPDnTBDooRrBKYarXnHRxPb5OoyVUBwyc8L3yAg
	ocJbgxLlYGhmD/uUUxVchDN++k0USwR0gx72xTAha5
X-Received: by 2002:a17:90b:2b43:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-38dc7a494a6mr16685376a91.14.1784110259262;
        Wed, 15 Jul 2026 03:10:59 -0700 (PDT)
Received: from primary ([223.181.23.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119c2a7bb5sm62079757eec.25.2026.07.15.03.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 03:10:58 -0700 (PDT)
From: Vidhu Sarwal <vidhu.linux@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Vidhu Sarwal <vidhu.linux@gmail.com>
Subject: [PATCH 1/3] iio: light: opt4060: Reject integration times with a non-zero seconds part
Date: Wed, 15 Jul 2026 06:45:42 +0530
Message-ID: <20260715011544.281148-2-vidhu.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715011544.281148-1-vidhu.linux@gmail.com>
References: <20260715011544.281148-1-vidhu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting the integration time, opt4060_write_raw() only uses
val2 and ignores val. As a result, a write such as 1.000600 is
accepted and programmed as 600 us, silently discarding the whole
seconds part.

Since all supported integration times are less than one second, any
non-zero val represents an invalid input. Reject such values instead
of silently accepting them.

Fixes: 0c6db4506ad0 ("iio: light: Add support for TI OPT4060 color sensor")
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
---
 drivers/iio/light/opt4060.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index c391ad3271c6..cf6f69e5be35 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -632,6 +632,9 @@ static int opt4060_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
+		if (val)
+			return -EINVAL;
+
 		int_time = opt4060_als_time_to_index(val2);
 		if (int_time < 0)
 			return int_time;
-- 
2.53.0

