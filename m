Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716683;
	b=o5QDpUrGeAEGfUVqv70Rv+2OpFlU1NwI+SQ+l51spApV9on1AOkIKcLxuNLFKXFMfEC9
	 C1hU8kyKmHCAhW0afkEYxKIFVX/uByFgH9F4+EPYsRoWIiLAlg8/LOfUaVTnjKX6rAbXG
	 MxI2G61nougzcIQ9KykruJNJMh02f5bC9tYNBWDM/kQyaf8ofuWPoln0J+NLG3SBZm0WN
	 qa6cgZRXhaPdvt9RDEXN+Y2Cp2hwu42qhgkkZ7vdVKp+yYZsA8ErRrqOHEBJ5VRSr6a9Y
	 JY55pHywd10G5RNX5QbOM3zKInx5AhK8VckgGMW+GYVTIC9i62Bc8XmlvQwSRz6zWiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716683;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=PyFPyh7onnfGIzFlEfV+hvU2o7x9GiyhoFXfV+Xy5ik=;
	b=Ax0V0kPcwQnE/2x3U1agOdbmPwgSjLbCysGxfMvRmvz/o/OLMzHFynraEtHBLvcnr+1S
	 uwLO1RsYurrxSg92glTpi+/xz6dBgLN5kTh3mpQtfOcw1bFtydJ0wuC3ah2jtOYxSFoOS
	 BVSXAAnz4D9CC3UA3Edn/WBSyvh9yfWzBqmBufpOZgfrP4QQbfESVXBDbBgRQ2D0ZV8FG
	 gFhKETqO2BISmHJa9oPtC0T8JCVzQcDYkbKXA9L+tx5OIX6pDIuSdpcpA317kFlh8gQmp
	 eQ1fPAuv/S31WYqlUDB9aw6uKJvpLXKLRSxWXKWDnXvFHW4CpPj4rUVG8lmiHOA1GMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=IGvKLnCt;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF9606A329;
	Tue,  3 Nov 2026 14:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26DF9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=IGvKLnCt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793716683; x=1825252683;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=b7KpuYLFkgsOW71Of4SmLW1tsbLp+3A5iNgRvdk8BEY=;
  b=IGvKLnCtdcXgouYWM17nB9BE04qwr2HLxpaDvwdUHbDNHc8jPNkEfJEU
   590Zapo7flCssRO4eY2Mbhrcc3RcpgNV0JJkejwkkYGsT9f0tLN3WmE9A
   0SOfdSkuXnYqwaPL0pCaDgnCODdUrSxVcfixPzn0Ju9gJzH8zkpaC3emQ
   Ag7qrlPgd6hpCCwH6AmtR74xUmY4r0wcKESV5HoAJ1RyoEQuKP6cFW6vI
   v/J6/yQsm0MN5afwbiJuL1eeQ36KYGEJpRfx0X6GPmGUe+r0CNuJSXpnd
   eFfKjZ1kVVpHcVvtxqxb+6se62XficCHdhvhlCYHXiWBS/pHPAW9/vVvS
   w==;
X-CSE-ConnectionGUID: aQnAHX6YSSmb76y4zIvDaA==
X-CSE-MsgGUID: U61VNT1qQ02ksglDZv5pfg==
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="233020451"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 07:37:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 3 Nov 2026 07:37:58 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 3 Nov 2026 07:37:55 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Tue, 3 Nov 2026 16:37:13 +0200
Subject: [PATCH v5 3/5] iio: core: add iio_fill_val_int_64() helper
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261103-pac1711-v5-3-71c20101a52e@microchip.com>
References: <20261103-pac1711-v5-0-71c20101a52e@microchip.com>
In-Reply-To: <20261103-pac1711-v5-0-71c20101a52e@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Marius Cristea <marius.cristea@microchip.com>,
	Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793716664; l=1472;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=b7KpuYLFkgsOW71Of4SmLW1tsbLp+3A5iNgRvdk8BEY=;
 b=DlNNvT1s3MxZJqseuhegwvLivW6fhU4RUjjW6uq23cI2nvPSAV9f66QHvOQGI9GjOQj2b2eH+
 Ij4BgKadH3HBzK8LgUMelYLcPz+zFmriOStfnhvt62yDYNlj2hStcOl
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Add iio_fill_val_int_64() to populate the val and val2 output parameters
with the lower and upper 32 bits of a 64-bit value, as used for
IIO_VAL_INT_64. The helper wraps lower_32_bits() and upper_32_bits() in
order to split the value with a single call.

The pac1711 driver will be the first user of this function.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 include/linux/iio/iio.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 711c00f67371356c913ef0dbf2325e3f4d35266d..d8fd300a125d676bf60e0b59f84a69f99ff23c89 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -1099,6 +1099,21 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
 	int *fract);
 
+/**
+ * iio_fill_val_int_64() - Fill the value fields used to represent a 64-bit integer
+ * @value: The 64-bit value to be represented
+ * @val: the lower 32 bits of @value
+ * @val2: the upper 32 bits of @value
+ *
+ * Populate @val and @val2 with the lower and upper halves of @value, as
+ * expected by IIO_VAL_INT_64.
+ */
+static inline void iio_fill_val_int_64(s64 value, int *val, int *val2)
+{
+	*val = lower_32_bits(value);
+	*val2 = upper_32_bits(value);
+}
+
 /**
  * IIO_DEGREE_TO_RAD() - Convert degree to rad
  * @deg: A value in degree

-- 
2.43.0

