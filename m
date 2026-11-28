Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866737;
	b=0ylkiOn9kHEuLShlOF+vasNXm4IMw6/IV/aiUtWA47yHfsM+SFPCvm85t6sC4bu5+QnQ
	 ZXRosGTvEau/kALWAMTeO0oc0pm9PWiKWUVUZ3t+ueV3Vb+fDHLIDonzyoWBGOR29ad3+
	 XAZ+2gjRlL89XN9xY06KkVB5cDJbBse/wBc+uR/+WU9SSN4FYI2jkqe3YbQ6oHka81Cng
	 X9zaBN9J/wk+TsX1N89iDDGZ3EcVZ8qix9C6opL+HZYEqWjbpaJqMV7b+g/xbmubJF4J5
	 VRzG9cughRizFOvKxWEcDNXH49rR1iteJbI9cpZaIZHHtft8KnjbyftdTjLx57wlmVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AMCCMFTB9S1Cvq8SlSHHPzrQndoGf5ALIJy+dGBBDm0=;
	b=BvX/A1pv3RZ9fMPyVFR1ppva6n27K0y/+RTbxq2dWz6ZO80yKQvMjuNabIRucuD27Dj1
	 tgmiplMuS4pxf8414+vsO2iblNDuo1qndNDauN9QvIUaGl+7trRJi5srbLzyR/4Gw8Yyn
	 XiJbYf02D9mcGuBELSaAJJQhmkXVQJUKKZ/ipX3n/q+OY+NBFDCQxDNx5zrJb6Imz7DB7
	 k0eQS9ME6sGe165R4YA7XTjmtSlNxcdyV/m9ExrpV2aleuW+9x7dNyWSccR8xCJPch+Yj
	 Ryyp0+ZYWgrrm1v6rgY4TTDgKfWQtoQpS54OlPd0bR/WXLJAYpkafKpEBAk3KYJvREw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0SA3FblE;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F25606A31C
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 11:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8F25606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0SA3FblE
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-386ab9ab619so12653555eec.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 03:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866736; x=1796471536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AMCCMFTB9S1Cvq8SlSHHPzrQndoGf5ALIJy+dGBBDm0=;
        b=0SA3FblEfN0nRomJY5TN8/9AZ8cYODfLS84aVM6AGnHmH/Yqbqa0q9U4RcdH3o3WqF
         DaIhJzDd2SVCgWakDQ17AmuBP+XgYDvixyU6WbbjDX0oIs2S9028bC4YiLZQJZir2jqj
         L/DO+LC7+XLPVMiSH4SFzfkaEtgyakccTbmUvv9UmkP4tseG2lAUcYqiahx3DvawdGlW
         WWKKGJGY7DR8VXJIz8cUT6FXj5uxh5w/6pfD/QHM8Jnq3foI3D8mtOrEa0J8msYO52Bk
         ND9DfXeQaVIzGLymiTzJsesllTgo39oH5Gg95/4F62pO0fE5YkQ1a1IbSee3rH7jS5UM
         OzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866736; x=1796471536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AMCCMFTB9S1Cvq8SlSHHPzrQndoGf5ALIJy+dGBBDm0=;
        b=TiNh+Q0lpMQVkMYgpEppjRig62EQkm5BDhlorYFwqPrBu761DmnZ8lmQLaZvW3R4Be
         5nGcqXKz9z4CjDidNVQgOi0of0ftqqmUPcR3/A9GkMCYRRCjACjB/AV/UGr6XCLLZIH4
         VsBL2LEtiuutL87i52TDpKzrSxKz6/vOn5x8cy5mcbjl1pWKSQAuOGzLqe8owhxLm4Bt
         kEqJ/FxqmAJ3+3K/8j2nvFUuHbY8SjuDgRz3gJx2gUZ3k68HjdrqMeNXKx/E7HHZGp5q
         EUIyM0VQDqvFMP8SXPF7+IFDBKHoIrJWpNy7OOYYKdlIQVK/ZF2obzykSoPtB32FDRxu
         ZfsQ==
X-Forwarded-Encrypted: i=1; AL+hErFELWfAeQ3P5ThnXVIwnEOvzMZv3KZGHHwoxAIaHt4Yf7Ls9tDR6RC0YMC8ywpkHFnuaFbDARjAhho=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XDRyEWqKObTenPc6tBqJpjcaEewMMUqKvEGcsWOFmhi4/CmZD
	MmEDsZupw1TxxsA8T+dv+BqI3uucavXtUKDxsZ1m2dk3nTkg42I0WJnE
X-Gm-Gg: AZFdTZfv296s2tlN/k1pBsRyiYB/+tao6PZp9bL/VvDoXU+adygtYKAnEl9VL0gjBHc
	RKO3No8kH+sD4FPHucvqQuVXodLSY6uq6f5RTEuKzVz7YGIQfzVZJFhXSuqU8mUJyihyqKYv1Br
	mS0D1O8z+uQ96GZ31mo6xNGnUabZpEMvYDCUjx77nEZ1xbxG4EqqevTfTQ5ftfjiTpYGe6yzpC8
	Lyt39f5wy8ErKa5D0sraQN+IJKr1n5E7JtYz52M6/CGyxtZZUO366IICDB49eqhVPc/G3ZUnzbL
	suNcncJ8N7a5fpfn4F/bF7hynMywR7zN9QnRZiWjtqt7ddALBI7l4OMV7X3yHAPNdB8duHXu82j
	mznGMVunhYFLNJOzAgJQpqd2rFSnBU0+j8UME+A/kPr9AnX6Dj3W3QH8QSdeKBhhly68zn5j9H5
	LoT/td1VD91z3ppvOoDDTAYyZk8PH7AwiQcXaR+1TZQ3OhBVS1fooNS+CaKKQzRwOc0WtyJv7Yv
	Vutp6SvE93lQ+RoaV0LERN+NqkmNnzTn705DvHuKPvwIPlKFZfrgEp0Z2l9tFHyLxou8sfoQ56w
	AeaINeXSGcAyZGv/mlr0Ndga6Tf4KduByKDp7Bo5A4FHZxCUav6hWReXKtJGtSSw05TwIlByA4Z
	XNfi3Ny1ermnu22ZgNEAo0HERPNXkYH5gZaKEetLeCaTJY6TvfzuhwTImcjanL+zDJtfyn8F7nc
	srjqXmStn+2N9y/HWmxTnuoHjL7PtU3lE6gBChbPvbrQ==
X-Received: by 2002:a05:7301:730c:b0:381:2114:99d0 with SMTP id 5a478bee46e88-38571415bdemr25231867eec.39.1795866735943;
        Sat, 28 Nov 2026 03:52:15 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm74256544eec.20.2026.11.28.03.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:52:15 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 4/4] iio: proximity: aw96103: reject out-of-range debounce and hysteresis values
Date: Sat, 28 Nov 2026 17:21:41 +0530
Message-ID: <20261128115144.557411-5-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128115144.557411-1-kapoorarnav43@gmail.com>
References: <20261128115144.557411-1-kapoorarnav43@gmail.com>
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
index 82353be284a7..2ab92fac9a0e 100644
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

