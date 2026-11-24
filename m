Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503024;
	b=p5U3Qb+hfEjIXoEN6jOgV6X/yTBXdpDjCXopM0dsVTmsAGwB8kxhgvrisGRAxB7yhsKV
	 Ycd47DrDhhZ7TTj5A9D6m7BPwkPcz7qU1WUjm4Gjm/XLirh3139p395FVvLRRG+9nUayY
	 /abAtG9emDAXJZjVzOnAXbl3GHG1qfRybbtFOHLpyw2BPC8WiKliuRJ6fSOCNqZ4nwmVT
	 rbRErdPyHTDzqDLpUTX8+aDaWV2MemAoRShlVSSxEJfjOGGCrx76zBqxzGKskSMCbY0hY
	 FcmUaLsYD4oGIS8GtY3d0Yt9Cvu9yvlihQdRBMD0dG70P67kxARBV2BZNOwyVj40EQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ojqsbiWlKNfr1mrx1SXA3SitSn0FIQVstV4SumJAAn4=;
	b=z/ue1/y5eO0r7t2H5JElgoOFxhkAxj2+Js9glga3lGJSAPjZ/mQ9KnKp9Jn0XceEpa8B
	 bUqjCdnu2+s533I3qCj+v7LVxqmYM/MyuclRSZXmT7onBYO3aDtDjnSSRxZXcG0aS44oB
	 fTvewylOywo+54HQA2qlzL6ZDGGU2Ep7kndazAL4AdqU0D2MrlydLNlqJMn07FTZ7vWEU
	 dvtRDPolPAmI2YzKW1wKwEFgucayOrbSAsiPALABjR01R1QwiIuIAfgjjB1TtS+hr0agk
	 SC5V15FfoQ6RjmlgYFRMf97eXE+D4suXgIM74/ONMnhmN42fr4TvdHqTYok5j8lykDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nVX5ITCv;
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97232606A683
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 06:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97232606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nVX5ITCv
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c14f3dab66so3376537e87.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795503022; x=1796107822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ojqsbiWlKNfr1mrx1SXA3SitSn0FIQVstV4SumJAAn4=;
        b=nVX5ITCvP6SU1Ep+7c2AwUzdtcXBeX/d35hdNdlsaK/r4miqXTV2L6+9wgR0m5mK+8
         /phdqqYxCZDjpkHFu0KL6rpvEzPF5CNWuRtOBcgDXZ5q9J2/CiguzYsz28FUD9zM8AkO
         1+e/U+f9/xKBxSdh5d58dnHjQ5BZh345u/wiid37ZXYDNfElb3GzYcwTI4yQrXB770Am
         OFSZftGqSgzcbQzYqAudOAtm62nriJpDM4wYkcnlTris6njYsVyVOyFJz2y7HIjT3F7q
         Ng4gobJONiFXe+HpBgvqV1/pmoUY1f2v+fS6mDCo5s+DCAEh5GhHlMQn108xCX6aoAeN
         skBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795503022; x=1796107822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ojqsbiWlKNfr1mrx1SXA3SitSn0FIQVstV4SumJAAn4=;
        b=wT9X+hAMGHMpmTJNY8oJNw3red0TKK8LQD9XHeXbPh/+VqyXBPrgi+rOuVWpKnToBM
         GhU2lmdzSdy5G8tuarmtGEmK+MZP88RNUwXu/1DgYmJ560BMblL4WO2v0EjGa7RAYmkf
         rnayRKbbvWutwyP8yBEhsKv9IrZyNFL7mdQcPVAq3+NOlI+JLSXXbL1kBv+SZjMKQUOd
         JyZ5uuJX+A4EAvJYL/gGJYPCXhSrYkZ4EkbdoVD5oSbLRneljNSu3+k9a3cKSW6Kd+yt
         Z/Q2LV2lx8bZwbnndoBjKeQW/uSOFPT1XXf741JbG+jjhFBNvHsihZi5rehTJAGCIYpX
         lU3A==
X-Forwarded-Encrypted: i=1; AL+hErFPiS1c957AaFcmYJ/kaJmzCStWJ9DLo0VoZ6YnVNR3BYgoAZGxTA1HdGnrbSPKbO14lXPxadzOVeQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/R7wS4el51LHx4tENmwOCXs4N3AonSyfiqPS5ZkoThOpOMUMhP
	W+WuQq59iVKnzS/NR7+7+FMRvXmOjEhjtb6ZcoY6EqWz66C1E+IIaJPR
X-Gm-Gg: AZFdTZdP7CEdUnW6satkTHDscmQxXylawWPmKt2WRSy08EgrIBftwwGv6of/UlqSlEu
	7qqB/5LnKlHlFhLm3KU4g3OR7W9QDNuDnjobUBv9NVS/5ppZ2BEz2mDX78nnYH9v7ChACPTXv4K
	3uvtNMTp6xUD7kvlP0pDqcTKPql0zBXcpNBhM0zxtyZ91mfwsqEaBIQIjU11gdETgVC4UgwwMQw
	WBts58vEO7sVoSmLX1YwH1u/PUO4GywJHyPXYVBbu0A5eE5d+Z51/DbHwmaZhS28EiVclw4XMCy
	ATCm4Qjsbsw5ZXE4GJzdLrOJjIMmDWZ7z23jYc8yld8JOBl+2gs5+YbeLMOetQtqMBWzj4PYSB8
	LkfqlHYkm1b5o+0OZQ+lv+VKb/t4WB1liPBXMBfJSFxZbPlGZWX7cuRPSUGFxdhHpMiPx1rkZUI
	ny+VJltaBrvyTgskhjUX6Sj+XEoByNZ1FOXW95VVWwa+CEnrxiW5SHAUrpaniQcAd4lTXfSL2CN
	rrizt1K8Dn9gOnO9ULWwS+rAmUBnOlzccQ93Zd9l+Xs0nJT7+uY0d1+J1YDIRhmeWhoU0Ska2yQ
	eDp4A2BjQ2XzjF8b/ThVuszPGtJiNsFUHDkwIdHZc9U4okI6Q2/NDsZ5M6hoGSo2rss/mg05M29
	IJhFWl5kAUxeAXiTpBJ0MBTvD/q+Bp+oci8L7KA==
X-Received: by 2002:ac2:4f11:0:b0:5c1:4e10:20b2 with SMTP id 2adb3069b0e04-5c1b7cd5ed0mr3313092e87.45.1795503021696;
        Mon, 23 Nov 2026 22:50:21 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd018b45sm3538556e87.41.2026.11.23.22.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:50:21 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 3/6] iio: accel: adxl372: use iio_debugfs_reg_access_regmap()
Date: Tue, 24 Nov 2026 08:50:13 +0200
Message-ID: <20261124065016.185124-4-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124065016.185124-1-zoone.rupert@gmail.com>
References: <20261124065016.185124-1-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The debugfs callback only reads or writes the regmap of the parent
device, which is what the core helper does.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/accel/adxl372.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index a880ff4bfce1..994c5cd58bed 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -806,19 +806,6 @@ static int adxl372_setup(struct adxl372_state *st)
 	return adxl372_set_op_mode(st, ADXL372_FULL_BW_MEASUREMENT);
 }
 
-static int adxl372_reg_access(struct iio_dev *indio_dev,
-			      unsigned int reg,
-			      unsigned int writeval,
-			      unsigned int *readval)
-{
-	struct adxl372_state *st = iio_priv(indio_dev);
-
-	if (readval)
-		return regmap_read(st->regmap, reg, readval);
-	else
-		return regmap_write(st->regmap, reg, writeval);
-}
-
 static int adxl372_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long info)
@@ -1221,7 +1208,7 @@ static const struct iio_info adxl372_info = {
 	.write_event_config = adxl372_write_event_config,
 	.read_event_value = adxl372_read_event_value,
 	.write_event_value = adxl372_write_event_value,
-	.debugfs_reg_access = &adxl372_reg_access,
+	.debugfs_reg_access = iio_debugfs_reg_access_regmap,
 	.hwfifo_set_watermark = adxl372_set_watermark,
 };
 
-- 
2.43.0

