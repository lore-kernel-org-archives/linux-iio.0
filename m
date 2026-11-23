Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465584;
	b=LfT3r9Q3hq2i2eaIVHVoQBmIvmatUv8B4M3SIDt5MQ0Zvf0lyVGWw5pvIth3Q1waRuyf
	 T1WUdcRM6szBTPtsKIB5hx6A8bSXxRTaY/b6LqvS0S7uIwrKa459DXxNi5tPBUM5/9KRp
	 +KBXCwWY96lkHbqaEpwlE+pB47LjHmPNP5a0L/FZ3VSWx98zSe8pwBjNszOnXLUe4OGiX
	 WYFUWDYRTxv+lXFzQQaR5BBhksJBx1o4HehrEOiizSpAwAx1tw11QEVbLeuAfzZmiNB8I
	 x7ovSmVZqALqLdUFoB9Xur4kkaKoyuDJoRMfe4F8k9NpzEacpw/qxS8ReWX8Im0e3yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3oFVVXZVVAH/dGJyLdtEppjG6zTY+6XCUf3lByoDT6c=;
	b=CW2cmtwzK7KGuvobGTr9X2zuUtG8EXZP8OpUQBnncTo6GgoHZAFe7H5T6KJdjcjE634l
	 7wKIyAMgdWe1cjhqaZL22Dp0ARAijvUkty/qcwsRpVmX98AT8p7kaW0D4IijtWK+a6j1g
	 FXyowcVA9PdQDyXPaPBAcpGi9J/6H8pJ2A067VnqZcnLHFexlmSlxva1OU/ErTZMoewlA
	 bukvKTkvaBX33jb4ZCgLanNFsn9IhtD5njVyqTrQumEfBF6j1LFFRZovHyftJNlVz/Kt4
	 oJrzllceLwXVM2MIw4kGy/FktDi4o6Qi1IfcgBhU7XWD/oAi1ZfOlnDQ7nR3AIs59eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ei1iu2Fa;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB048606A68E
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 20:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB048606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ei1iu2Fa
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so38099455e9.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 12:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795465582; x=1796070382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3oFVVXZVVAH/dGJyLdtEppjG6zTY+6XCUf3lByoDT6c=;
        b=Ei1iu2FawtRxzzGB6bQgwPKaMQeP5zfk3orsA67e6Icah8ewSS5bB/J8bbQi5WGlrg
         5Biy/6uYR8C3yQYgd4RozUTBeJAWLj7QeCDF/eirO5+6r1/hKZUjzCD/mIjtLgUxcFEK
         CglMk+9Yth8FGsUhcFSHQdZT418ak3Hr8sGYDqZSBguH5877udN3J3H/i2k5ouAnC0bI
         b+SgP4DIyWkZGYTjVLs1OGh36abk+kGUxDBAgrGKawr+s+fu6fd5r0zmgMd/miGGewe/
         tEIDXh9WzPQeVw1EcJP9OrkL6seOAAt/rqMtpTuxodgHV3Qm/j5ToAGTzzBgLThSwN/I
         F0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465582; x=1796070382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3oFVVXZVVAH/dGJyLdtEppjG6zTY+6XCUf3lByoDT6c=;
        b=U/F0EXWjLm5S4Yda55LJOfxdLOs5bVG0HymWmw6WcuncXZLxzxRYzECcXN2PEo9j2R
         1ccapT4rpBQ/Zy2pIPe3blL0LFrHCz2Gus8ZVkhfqPTUfteAszmQQMgUEJB9+sedeugp
         6rNCGq6jgvzCXLO30M+lIUrK+ubz6U9MKupZlFwZN8W40OibsDpPs57zdJj34A2sjq3/
         QWUnxFg+VOc36aNM4588jnRyOJ1Mye4aLhp8+xM8Y+wH2G81l7cb6Wo5L0qnSlfM1bzM
         cpYuzE9BDZkEcTj/HokTjTTggG7FiJSnuh4TjNYbsvnKr8OtHfLuaCbenVbLutG//6wP
         dQRw==
X-Forwarded-Encrypted: i=1; AL+hErFuMI1D54UMejezPuAEaLM9ReTvO4J274VktxDJjGaZ9hgOiDRDcVu8wtlt+W5vKKwoMfsGhgvZ0o8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9J20PJnWfGsIauFAlNvCSKk+LBPZml9VIi91Q3K0YmkPCm4NHj
	fcUMrW5xNDTF+REq/5ph6+UzvSaWUnlE7FchqCCCl3mzSoeNCmYhMv7HtsO/jHmagYQ=
X-Gm-Gg: AZFdTZeAZbJwJs2eveo8KxUOKcttZJcPIBGZAZ32TU2klrP7Qji9JdpPXi7blJ8vHFE
	c6ThuE32xfAKW+OCGwsuCh0I35GHd9pqRH4HFkG8uizhTW4ARjJHDyGDa9bv0a5XXIIZYqb5tLy
	gvme121jab6/I1U+63cRspCrezDDMpSzAxHb+PKjqI0lPPu0vzGE//YbAqJhn9dW0baI0y7lkHi
	DP1IWctZucG1q1/VpF8kJ6ugAthZ28C/4Dx+9f+n7MLdRDVDvsrRxLSvHuCz6rDN5XxM7p5OPzM
	oP4LXdZbOkT3SIys8E7s75zAunMaQDOMnuJeoGdjZ8Cv+snq61suh0xsiOX6s79kVYimlz56n0x
	X3ueI0WGB5Uk8Ny6SkfffABfULraOY33TNvVmO3/xGwJf/2kiwq0b8L2xs3RdB8hzE50D7O3goH
	WWrVUlXZsAjheBJvUbM8xmj407CFbPZkXYQTrZME6Nt77Hs4C1ImRb8sJgqc9E4Hx17Zy88XU/y
	MbMJKZvUEKo5bHnSmdyMsvAsTeZ0vJB2OmFvaQ6uXsL53yzVrNUuwQOtNPF/0Cm94bjrpM+7h3N
	tue/AhG6IjsgLcfjsP8dDFDvSJzJZzDRn1xAL0qAAJDv+nP3zKe1IjI35NIo/9XWMvd9hyEZ7zU
	i1LqabafsBhw=
X-Received: by 2002:a05:600c:1547:b0:4a2:397:73f6 with SMTP id 5b1f17b1804b1-4bb8880974amr290934055e9.8.1795465582225;
        Mon, 23 Nov 2026 12:26:22 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3c4dsm20108713f8f.46.2026.11.23.12.26.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 12:26:21 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] iio: magnetometer: mmc5633: Enable the VDD supply
Date: Mon, 23 Nov 2026 21:26:14 +0100
Message-ID: <20261123202616.17334-4-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261123202616.17334-1-gerard@teslabs.com>
References: <20261123202616.17334-1-gerard@teslabs.com>
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

Boards may switch the supply of the sensor, so get and enable it before
initialising the chip, and wait the 5 ms both parts need after VDD is
valid before they can be operated.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---
 drivers/iio/magnetometer/mmc5633.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
index 92a09316ccdc..316b431477dd 100644
--- a/drivers/iio/magnetometer/mmc5633.c
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -27,6 +27,7 @@
 #include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/time.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
@@ -69,6 +70,11 @@
  * Operating Timing Diagram section.
  */
 #define MMC5633_WAIT_SET_RESET_US	(1 * USEC_PER_MSEC)
+/*
+ * tOp, time to operate the device after VDD is valid, per the same datasheet
+ * pages as tSR above.
+ */
+#define MMC5633_POWER_ON_US		(5 * USEC_PER_MSEC)
 
 #define MMC5633_HDR_CTRL0_MEAS_M	0x01
 #define MMC5633_HDR_CTRL0_MEAS_T	0x03
@@ -473,6 +479,12 @@ static int mmc5633_common_probe(struct regmap *regmap, char *name,
 	if (ret)
 		return ret;
 
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable VDD regulator\n");
+
+	fsleep(MMC5633_POWER_ON_US);
+
 	indio_dev->info = &mmc5633_info;
 	indio_dev->name = name;
 	indio_dev->channels = mmc5633_channels;
-- 
2.45.2

