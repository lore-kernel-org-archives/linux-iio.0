Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671085;
	b=UWrsIZQfDyA/yLF4BP3JWsr8qGCquKELOTz3yF4aLbn1dMlSx6cNYtsJy0VnG2oQIRl/
	 vqaTSsFYAOp3jE6ML48BvrlMUegna2HmTLSiRKDt1NH44rStgsXPnYwVB/wM9+AczYOx1
	 JoKvHBh+N5TU7uXvwlRCxqGzZs9vZH/nHz38C/iOyFPuqTBhs/auxt/tIuWRGmrRT6sGc
	 eYf7JECziEqUVeXwZS3ERZTYyCXCkhbX+7filFN47wtHDKY9k43EPVosarTqqLMnDS/X1
	 XmcL0EN1eSplvGmp6wGBcqKuz2PkctzToPpqhY7Rcyi8tKj+ZPTQkb/rTF1gTyRizcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SaQxUBzvPDkUX6JJATROn1MzfwU+l51Jz8uEr7sIMqE=;
	b=xnrCHDrazg0hpJ6jKfjztjXwrGWGQUY7SLRmKj1GQyAQXcQEcA9xEvVJ3A8+Zm/Gt/lq
	 8coaB/LO3hxAhv4DpIM/4BfYNfpdgUCrqaYowueLBMTWJYhvG7MAW2+WlxGqpCjxoId18
	 RzCc2Z8NogJUjtpC2xuo4BQ6LEUzV/SbFkyLOu7ppUrQkGkSuJIheHsIz8lfvJByG0AKK
	 UM6Dl+tbwOZspaY1oixSRkv1WQid60SDFpNqKq6CqWMXI9i2EowFNOWZTK8kYnk+eM3Lb
	 0msYCZroth/l+WW0k4cceLVEnzTUQU7/eiteNnXfCommTQLbxpvg/Q0f04WVO2T/67g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Shh1rc8V;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65A606A31C
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 05:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A65A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Shh1rc8V
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso3215294a91.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 21:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795671084; x=1796275884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SaQxUBzvPDkUX6JJATROn1MzfwU+l51Jz8uEr7sIMqE=;
        b=Shh1rc8VN19gQuDTe1+BTKbXrtc8OhJ5ZXeGQWSgzwBhjEn7GmivVeYQ9KCcfuNnKi
         c8K7UQPF5zvqhYVkEuLic2K79uX7sqy+Gfbf6X3fZoF9GWL1HHhuBv5xMfp7/12xT1pH
         tpmlwF4/ON4RRW8TYFzpwYfSC/O4WleOXznlBHP1lCQOnNFo3glhn9iIiYKcHaZ74b6j
         2FopkxR4J/wZsofnHBYesp5eMB6Jd6itOJ/xX/NQ93mc6HN/JxQ49R9oFRTWWQfEIPHt
         QntBZaRo5YI0lkfZa97LP9oCnd91gb3e7nFonNfVYigGewkq2ueJX6sEJcAw9PfK3z96
         LHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795671084; x=1796275884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SaQxUBzvPDkUX6JJATROn1MzfwU+l51Jz8uEr7sIMqE=;
        b=WwS/prGdKeRYK3aLpbC2CFN6yxjpEOjf6Wkq/pDN6pGn+Gk9qiWLhR3fYCdCMWPO/8
         aQ0w92dCjpdBQIT9yfUiBp3vgv1YvsUikwXuUswLsvQV60Bgh69kTwhU6YD2TfEVN5T5
         jTAIIqvyx4RQwUkEvfiTupRxLlbCSqssz6ts/oDIMs9O6LO3M5HqIXNgsmdrAt9t2ZAu
         8TCOB64OVjZDuOlCLdmVeREetU4//pjfKlv4h8josNBw0Lv2sUOsehCNesWnVYphxmN3
         XADAhCzcz57kFBBriLU11Uti3dTgaVR/9EnL+zg/3qwf38BUmYdKNPEACAqeGL/fv+Nq
         Ezfw==
X-Forwarded-Encrypted: i=1; AL+hErGk10Stpbc4jCytVS1ju06vhxmr6d8WZjvrpAr6bZyLDlPf0udIa/5NAOS0DWpbNYgSVNrC1n7aidw=@vger.kernel.org
X-Gm-Message-State: APuU4Z80F0pvHl9OgSEweTxj6srEH0B2rmifKIosXYN5eKpNiyBRgnp2
	u4kbv0XHGTJPMeLj452DPwW3XDPDI2HDSOk3JiCANCMOIL49oRqifusHaS1ME+zElOxSzA==
X-Gm-Gg: AZFdTZduRI2D3YfwIkskAK0loBSQPYPBH8GhQoNPZ4ZHkvXO9oDqdBJtCbdZgtJl48Y
	00M2xMIT4pngzBxP6lSD0OQMD5RSbnfRkiweT3s1yxsN7pf+6RG+K+op3iMLirBx38k4oqXez+k
	o2DaUC3arFTk0kzYiACaiZJuoXBdvQDmGUgO3fz9c27nvDdKKfI76qek/08Zz0UCDR6KnVAo4Yw
	VAKlsSw+jATwSjTlKhvumRrgVBDq3ZG9owQUOriaQnxgfUP+u7TwOL1PLQyqjYV/JV+Q81Z4J3Z
	KV+MJZu6Fn+HI09ImLFwyhXcMQGcLK3Hy74M3dR6EFuhIV1uudsYFaeEEcHX1b5Pg2/xUC8XqNg
	is65jXQiUVYFOoxw4RCWZMMg02sMzogRCf5OrYl8A083hvgcMAM72B0ZRMgRWJalewHzgGHtCjm
	R6I5CYhTQ2pyRC/shTbI1p3YBXgHLGdjUizJxZy1vz8tfsoNygr15G/9UNGsuaqkOPyH0gEMypj
	naaV1Ub8dI4li8V98QaYIiKpti62B6Nj7aRGrSh+cG0LWJclT860N3UxnUnhag3nBEyYwwtDTEK
	9RpyANFy39G72vJ0taCJag06WysX9sKt56V5u6dlFX6r0wIWKyBEZMQraxYxfRzeY6w5nBjKpjv
	27nt0tlVaFFHUZJBWYQOn95YYDXSCSv9jTQRlKoOeuAlV8GIMTJ6qXuY3nNTlOIYxOSRCmb9TGn
	lrr6VXbBp6g9w9jLdUKJgl208=
X-Received: by 2002:a17:90b:5546:b0:3b0:a1c6:95ae with SMTP id 98e67ed59e1d1-3b41c941f9amr11689057a91.31.1795671084563;
        Wed, 25 Nov 2026 21:31:24 -0800 (PST)
Received: from kapoor ([149.40.62.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b409330ae8sm33700520a91.7.2026.11.25.21.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:31:24 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Wang Shuaijie <wangshuaijie@awinic.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 4/4] iio: proximity: aw96103: reject out-of-range debounce and hysteresis values
Date: Thu, 26 Nov 2026 11:00:28 +0530
Message-ID: <20261126053033.603086-5-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126053033.603086-1-kapoorarnav43@gmail.com>
References: <20261126053033.603086-1-kapoorarnav43@gmail.com>
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

The debounce (OUTDEB, INDEB) and hysteresis (THHYST) settings are 2-bit
fields of PROXCTRL. aw96103_write_event_val() passes the value through
FIELD_PREP() without checking it, which masks it to the field, so an
out-of-range value is silently written as a different one: 4 becomes 0
and -1 becomes 3.

Return -EINVAL for values outside 0..3. Both debounce fields have the
same width, so one check covers the two directions.

Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/aw96103.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index b4aa31a65369..24557a8f764d 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -401,6 +401,9 @@ static int aw96103_write_event_val(struct iio_dev *indio_dev,
 		return regmap_write(aw96103->regmap,
 				    AW96103_REG_PROXTH0_CH(chan->channel), val);
 	case IIO_EV_INFO_PERIOD:
+		if (val < 0 || val > FIELD_MAX(AW96103_OUTDEB_MASK))
+			return -EINVAL;
+
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
 			return regmap_update_bits(aw96103->regmap,
@@ -417,6 +420,9 @@ static int aw96103_write_event_val(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_EV_INFO_HYSTERESIS:
+		if (val < 0 || val > FIELD_MAX(AW96103_THHYST_MASK))
+			return -EINVAL;
+
 		return regmap_update_bits(aw96103->regmap,
 					AW96103_REG_PROXCTRL_CH(chan->channel),
 					AW96103_THHYST_MASK,
-- 
2.53.0

