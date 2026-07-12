Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7D3B3BF5
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783887909; cv=none; b=Z4jGU6R7OjnpUSp55yqBDs3ULGX5aj7CHS0GU7CR471P9Tw8ssH3HMVslIa0uABcX+ZXSKXkZSh2tL5egILy7N/Sc4n5pcwRR3xlJ1gmbL2KaqzICwFp4cyXoPqwjpSiXJCHyuoCZY8QXUq9E0fP+ssZwp1VB2VrtK3dvxbNGQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783887909; c=relaxed/simple;
	bh=LA4IXDpuC9u0QiPddMFLuzDnH4o5N4TD7ifw2M6c/48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l9RhSXIeBRrsFoo6EoNNkckTiYbhcUXKVN1Tc1J1IS3ZwSBDYa+lxYDRp0iC3jjPakDZHz4de1uGQf8eHcBs4BMpiJA21rwSud+rmw2JuHmwqUtbdTqx8nzlc+E6FncZrTuB/DPWGk3rblPTtcWF1DU/12emE9n3Ehtgr4ckDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z62h9GSX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z62h9GSX"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e041ea211so47500a91.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783887908; x=1784492708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WE0EEtBOg65KudGIfJulYxabJqSO2+QxavCYGvUf9nw=;
        b=Z62h9GSXqXn/Tj+gXtiXQSJ4ul699TCa8uczCCB/11kwKrDZDaw1zESkBDoOqOws+h
         REZQBKvVIGwrhEHKwDCeQifezQbLuVpU3GRsPNv4f2cdUdqs+BBdKnDWBAnWSPVEQqfF
         Bo8EjocHAi0R55t3bjIcFTlMMwtuHH9NuqwKJiWw5SnIqcQu5UrPJq9EzVHMKcmNRn4J
         Cifh51iZvwJrpmjBwHDu8HRlgXisGSN08TALSleCgev7NO68YotzVLwqJJV0tEqiEfRC
         91vzLg63Vf3rZm5Xm7ng9LZ4OcsN2DCny1/h0tu3ChZELXJsw+wVdQF/D0Uc89WeCwQ4
         riSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783887908; x=1784492708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WE0EEtBOg65KudGIfJulYxabJqSO2+QxavCYGvUf9nw=;
        b=QcdayNKJfH5nfU1ItlN/e1pd/24RhhewC05Gi0wWvl89WkHBST4SeLqMGuseqOj2Ak
         JrbzYzCh6bAiIyjgEKSiGdn9T4M/oZywm0elCEQ0C+7+TqC/x8ACYv7j6iyVLzoHbuY+
         hBv62UsolssuxK7+VU3fV7az3YYBfHcp0xtlOcp1wkMNlmnM/ERllvIL2Dmk/VNmbM6i
         HFnOIgzp9oYDwNTbU9RfFicU4juh/S6SzDRl/PRQjTm9TTOhsk58LtF+tGwgesTOKo9z
         FHumYJLlg3Y2/GDgDFmuyrR+7q54s7hgGwlGoXgJMG+F2NOr7+bxI6T6oxJD/ZFeKe/J
         qC+Q==
X-Forwarded-Encrypted: i=1; AHgh+RrQMB9Wtl3xa6cMTQ8llu+NexdC36nVXuQgXrty3DYqYrZbtkdGutddJCEs/nduOoMPWw74ygj4fyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd9Y4ZG5gV4y0cwPWnmnIwKAM1OLC+haTSgTykEkoCNeFntkQ9
	g+CjcyECrMfPU39l32jE2dEei8dcdbbXIYXv91p05DDBz63b1FjszNo=
X-Gm-Gg: AfdE7cnE909Ht+nkiuWJ5vo/ElqUC2dLR1W/FztFPi66y91e7p1qd3dSjDzSp4CNmYF
	/XjdUVaZ1+N+TA5OMtrG0XpN1ZwrXa+NXF9CwNB/8dyWM/1BCfZuqvxouJPmUitaTjEykHP7vrs
	n3nzkv3nDzpBIhXk9j/mv+xKGHoHlHx88FeKJsiN8C3alxGoZAEHXRJgBbxoxgp+KlkWBDtgRcm
	n+QvofmYq/L2TDx3SbhRk5DryYIyFT5RGBhBW9cE7HXQlJUkehsO8KQr5+nCSwFBlebaGAKNfbs
	w20EkS4w6zGjWmx2LBwCMNcQPTM/jaPOL0+moe8ebSWFRhD9W0WKwhLBJV9KqmYjxiYj209PyOr
	0OycndQ6aDlKg7T21wvXb+IsWHzsxsxEPkIzBfv/QnDy17qva1B/p5Gk0XRBpHdX1SkDuslm8eu
	OdhBU3WrzZpAYKNTJeX2hP1bsbar2e5fL05DAl/Vh2E8tRiIfFTJQY
X-Received: by 2002:a17:90b:5585:b0:387:e0bb:57f4 with SMTP id 98e67ed59e1d1-38dc779922amr6312878a91.37.1783887907835;
        Sun, 12 Jul 2026 13:25:07 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm58833648eec.4.2026.07.12.13.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 13:25:07 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v1 2/4] iio: light: opt4001: Fix incompatible pointer type passed to div_u64_rem()
Date: Mon, 13 Jul 2026 01:54:49 +0530
Message-Id: <20260712202451.20822-3-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260712202451.20822-1-nikhilgtr@gmail.com>
References: <20260712202451.20822-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

div_u64_rem() takes a u32 * for the remainder but is passed val2,
which is an int *. Use a local u32 for the remainder and assign the
result to *val2.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/opt4001.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index f2cf496cc243..bdb1eadbd450 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -173,6 +173,7 @@ static int opt4001_read_lux_value(struct iio_dev *indio_dev,
 	u8 crc;
 	u8 calc_crc;
 	u64 lux_raw;
+	u32 rem;
 	int ret;
 
 	ret = regmap_read(chip->regmap, OPT4001_LIGHT1_MSB, &light1);
@@ -199,8 +200,8 @@ static int opt4001_read_lux_value(struct iio_dev *indio_dev,
 
 	lux_raw = lux_raw << exp;
 	lux_raw = lux_raw * chip->chip_info->mul;
-	*val = div_u64_rem(lux_raw, chip->chip_info->div, val2);
-	*val2 = *val2 * 100;
+	*val = div_u64_rem(lux_raw, chip->chip_info->div, &rem);
+	*val2 = rem * 100;
 
 	return IIO_VAL_INT_PLUS_NANO;
 }
-- 
2.39.5

