Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700911;
	b=W7cYzWAVkeERZxYpCdlIDV2OH4jkvLd9N2cQpOvxJYh3jbXKKK9RKoqDhQ+UiL/e7rGF
	 0shvm4JrYUJCR5JRNBe3YyupNj87me/wYyZhMZZKqesXqnGoPVWfCp20mmAEbQP9qcl9+
	 HOjPRE3CAKswxhFvYd6orJeDhUvLRy/92bpxLTlXroJoTobyrof45iLGt8RqiTgT8Zy7s
	 Kca6zI+iql7TQMa5ottNtDqzUXrgNA3jfEHMcnEqMauCBHZl4BMSKOSt4nRSPtlq0T1Rb
	 1G258yxTycdWXQEsx8rc9bYRpR3iZ4bERt6oECA9zztrpiGqJUiCICXq8lHzYHG0LGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Rm9Myfp9UNOe4eMcJGRVkZiHPATpQ0cO2bVLAIkG12I=;
	b=y4X5Ey+Bz7/M+9IGkC4Y7a+4OR/cht1/zQ6SHue6vlaoiXYEf75748NREpuQVuwvIZ5T
	 9yKKHUe9l3FyScU/QLPG0gnv6sfA7hRPNXVRxyM0yGM5hfMWQqRQRinOPVZoYGU/UZrNG
	 u+3kVRfDou1kKLfjCO35v3PdTn7Rn0kHMgpq1Q8SlNww0LzNzJWGUkse9IfL61H5vqBf9
	 SHY3SrK3a7sObizyqtuNJfMFsAzIUm5z5UecAJ8TRaK4fZrpFnRTs75Pnlk0P3qDgXu/f
	 ShePtwHy4mgtjCoKnOUApphWRYid4e2iNhXCJn+OWIFeLvzl6H4+dsNwfJd0Eo8YRtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YYYqiX33;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F5606A332
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 13:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E38F5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YYYqiX33
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so43870765e9.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 05:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795700909; x=1796305709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rm9Myfp9UNOe4eMcJGRVkZiHPATpQ0cO2bVLAIkG12I=;
        b=YYYqiX331Uy8GlHegZwnmL8M2gdNuEmd2y4FgLMJzBrtRRTg31i1EvYs75DI49hK6R
         S92SWOdBbl1TWmOZGHXtjlJ7wURi+o7F8/Vc23U086MMxYO/IsKJjeLUGUHlT7fWuYIB
         1Vd0Su9q32vl1oDxbCDXnPavu86w0GqSm4linkryRaw4TTJQLT88vK2NN+TI6VC26KHW
         U+Di4QRNwyEAYO+T3sK+CoJ/AyRE4ezKVsu+v+lWd0eNCgvilz+/oqQbc4zWlnfGNa82
         SfdXw/X8Alpb6zrTCJrKfJL1ELKWaR0qfYpCf04PnQU0mmKmloVx2Iqi6pR9w33sW17P
         ZJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795700909; x=1796305709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rm9Myfp9UNOe4eMcJGRVkZiHPATpQ0cO2bVLAIkG12I=;
        b=0TPxzjxtPG8tliuwfNKjbuvDzMKcK0Pvi8qBac/RvXH31eeewqrx/lJssvbgm2RsWD
         sQkLmFZD/9Lm5liuprU6Eq4tPZ3vakJk7b/kc/8TvoFSPXC6bHtn66vq/LnMqwb6tqWG
         aso02T/MPpuS5XmCtzEpBreA8y60AcluMUvaCsWZn/Z8lqQmrsXqxnv+qWHp3gEmuhbN
         b6i/sXPkDZ8Lm5ggVk3u/wVoNH9jlcTv2CN3dOwlnU8dDJwz/pUKZkKbL6V6n2qX5u25
         6xxyKyKEsp5bdjx7r2NkRI1D4wDQO7tqlJ2kwLtHcJ3WyPBKJHcffoSapG5t5Q2HXifK
         HSHA==
X-Forwarded-Encrypted: i=1; AL+hErEGDbDn7meXW9NerX4nq73pTo/KCtJcMEofocpOanIl47V85khv2tDeKqPtJH374DUoYlA4+EZYUJY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zvdUHfLhRix6Va+mmwx0loKE4buVPPemyXygWpuwcTatLy37Z
	WZpVOht74LBYQ91s7y2yxqEl6Ddq+138q9xr1UpCuxEQCSv48lCglCKs
X-Gm-Gg: AZFdTZcFxrC9YJsFT/8RFPqmJODAgNgaFB/aGelmr/mhF4HM3I9gMWEALNdU+9AysEE
	V++mE7st16ZHVvFJaZJX9gBJ9dW0KIKoN4bwWAbFBPHI+Ke3u0Rpp8UtEE2145T6fuOdk44nvVw
	QvsgxyubdH9MQfsFhA8tu955VOlA9BLh4JlgPfw7itouMEXn7suaE/B97ACMXC6JP8N/3qqJ0NI
	QQbmsiFakrhTMum7hfbeIj2DFIFOhPFQNQVxli5DHAYbkL99AjFKm5Qze1YHhc3447BohTpVNVH
	XmQuk5MrDJJu34dCHoSXCpAKD5KEyROEzwAQd/j3Fjqde5PvOg5sn6QYvqacBsJhVm4YwKkaxxa
	KF/S1txDJ061dXCEUfR/9aG/d/AlWKX8coFRYqxmq/xblyN60TwcP2EiMVoqvZTzaYSCpL3LoBN
	WIhMfSAtmBjcuSlOobfLVtmAurzkumzCTOAEh88VNr94gBQtrNxdovP9dcCMJcFjp5vDo4IBk1g
	NdPlsIekkSTuuj3O1FB/kZqwdct68eyOgoj5awHmfDtj0lL3xGFonohA2RAJT+GVyJgF3zDmZ9J
	fAu88P7BORmjD4VNM3fedyH1qD9D42jDG7bZmitmG1F0szw78cMoaOlr0D3JzA==
X-Received: by 2002:a05:600c:828e:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4bb88785898mr440409255e9.0.1795700909186;
        Thu, 26 Nov 2026 05:48:29 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a702:d301:c60d:8d79:1008:270f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm591221015e9.10.2026.11.26.05.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 05:48:28 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH] iio: adc: rzg2l_adc: Add fwnode_xlate() callback
Date: Thu, 26 Nov 2026 13:48:19 +0000
Message-ID: <20261126134826.46044-1-biju.das.au@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Biju Das <biju.das.jz@bp.renesas.com>

On RZ/G3L ADC1, IIO channel indices don't map 1:1 to hardware channel
numbers. Add a fwnode_xlate() callback that finds the registered channel
whose number matches the specifier argument and returns its index.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 340813f6f890..f00cfb897124 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -286,9 +286,23 @@ static int rzg2l_adc_read_label(struct iio_dev *iio_dev,
 	return sysfs_emit(label, "%s\n", rzg2l_adc_channels[chan->channel].name);
 }
 
+static int rzg2l_adc_fwnode_xlate(struct iio_dev *indio_dev,
+				  const struct fwnode_reference_args *iiospec)
+{
+	if (iiospec->nargs != 1)
+		return -EINVAL;
+
+	for (unsigned int i = 0; i < indio_dev->num_channels; i++)
+		if (indio_dev->channels[i].channel == iiospec->args[0])
+			return i;
+
+	return -EINVAL;
+}
+
 static const struct iio_info rzg2l_adc_iio_info = {
 	.read_raw = rzg2l_adc_read_raw,
 	.read_label = rzg2l_adc_read_label,
+	.fwnode_xlate = rzg2l_adc_fwnode_xlate,
 };
 
 static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
-- 
2.43.0

