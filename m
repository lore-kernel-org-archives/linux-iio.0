Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716673;
	b=PJSCqkQ4LMSj2psRF1WpqqpR3/6vUcHe5nZgHAeGaq93d8KYbUcGUu7l5aWKbW96ho4i
	 fPBTRweAvPBcAJfK5DrjcUbpt7/VPcQSIRug0DwcjNrLsaDfml3Gvj9wMRL4g3HiW3pdQ
	 A6ESfus3qhzQZbDYuFXh6IQYmV/h4+HdY9VUfyw2yfzd5i7Os3+BhRU25G2ZIHuc53aW8
	 jXnlHsPJUwwX08Y9UZYgLNNjDlRetu8K2RAwM0lsN+5yhF0f706lCIQOASWrfpG6yezj2
	 S5uvzVK5fixw/JlV4HfrpiTVvGueBdvPPXQegaJjJXKLL8E5vHbNNy4b2MGjH878xeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716673;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=X9o6EOQw3zK+Yo0NGNS0WHuIqxr/imfshAQpZ2AjIoA=;
	b=0q0ZTjneVKaiZsSa8lltUo1nb2S2Rvg4EhTggI4oFKZGXkgmVrM9D9q5jOdtxgi+DnVm
	 mfz06N2ogCHTHcUGQvKOa23E+8TAq/iq1JkZKeDvJcWPnVqvKzmAXbJamrkCz3HtUCjMD
	 UhE3LIt4rStq0HsFFCBbrhrh90XRQ5NxxEN36AmzAw9dpJ9/8gGls+gkIywgHz0Y/GANl
	 Pf/gulmoGthrybGNpfhxU0yF7ojVrrR5/MJpBiv6C3ivJ0Uk8h6b9Hu515dnIgHjj+Djt
	 8vRCSiyO1R6xRml6sM/53AB7/RFruPhZGR683VfbWkxR8VUF5vT5MtqDl3aBjtnKpDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=oKurXB8v;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED0606A328;
	Tue,  3 Nov 2026 14:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BED0606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=oKurXB8v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793716672; x=1825252672;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pzy7kVgq1xH7adL54nCSRXYa4KTJrSsgDmmq72p9En0=;
  b=oKurXB8v/ftcWygn8Emgs1AhQBTR/D+zi9C2Ge4YNYVdlbZewamOe1+r
   RIiv9mQ0478+8GFVrjMwNxULoEhcbqRTXiLNG+xYoYXiStjmlPKoSYo4L
   vwFsAL5zzgmd906NGVj9j9NmWEgGO7/ANm9ffjAF3Wl/9f6eLnLZaxmDW
   D3UbqwmXs/2zS3FdjCMBxpXHCgxihtCv75/pSHwxP31ru8/Qw5Tq/4cyC
   B3B5npBEAyfZQwag2mb8A6Ypk+twzlba+Xf1fjeHl+ZylwccRpIrkXTOb
   luln3cWGAtNhb42ZKl6efrr1AYbnFVponObhinOB7u4DKH2TjGTAuccR0
   g==;
X-CSE-ConnectionGUID: cAoUdr69Q8iAgvtYC70I4Q==
X-CSE-MsgGUID: tMdN2tM6T72XUqN02GYrxA==
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="76535158"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2026 07:37:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Nov 2026 07:37:52 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 3 Nov 2026 07:37:48 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Tue, 3 Nov 2026 16:37:11 +0200
Subject: [PATCH v5 1/5] unaligned: introduce be56 unaligned accessors
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
Message-ID: <20261103-pac1711-v5-1-71c20101a52e@microchip.com>
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
	Ariana Lazar <ariana.lazar@microchip.com>, Andy Shevchenko
	<andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793716664; l=1559;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=oiZXqaxFp/k49L6TW7OI+zrql3ZEO9PkDXV81lIwxSE=;
 b=463pwk2xyZIQe14feNs1J2Kr09AQBwksshZAhoBiIQGn6L8s2EBgRLsyg0/nozG6EX8l3UwbQ
 h2qkM8akWxbC2PLDQ2qv/UUXDhsS/nsmzUBQQFshKBbZzAkCdn458R8
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

From: Marius Cristea <marius.cristea@microchip.com>

The MAX34417, IIO driver, is using some unaligned 56 bit registers.
Provide some helper accessors in preparation for the new driver.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
[narmstrong: update commit message and move to include/linux/unaligned.h]
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 include/linux/unaligned.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/unaligned.h b/include/linux/unaligned.h
index 4a9651017e3cb9f407994ef55973908b6917b5af..2105743b1800f1a8c3f498e939e55e4ab0521aa4 100644
--- a/include/linux/unaligned.h
+++ b/include/linux/unaligned.h
@@ -143,4 +143,31 @@ static inline u64 get_unaligned_be48(const void *p)
 	return __get_unaligned_be48(p);
 }
 
+static inline void __put_unaligned_be56(const u64 val, u8 *p)
+{
+	*p++ = (val >> 48) & 0xff;
+	*p++ = (val >> 40) & 0xff;
+	*p++ = (val >> 32) & 0xff;
+	*p++ = (val >> 24) & 0xff;
+	*p++ = (val >> 16) & 0xff;
+	*p++ = (val >> 8) & 0xff;
+	*p++ = val & 0xff;
+}
+
+static inline void put_unaligned_be56(const u64 val, void *p)
+{
+	__put_unaligned_be56(val, p);
+}
+
+static inline u64 __get_unaligned_be56(const u8 *p)
+{
+	return (u64)p[0] << 48 | (u64)p[1] << 40 | (u64)p[2] << 32 |
+		(u64)p[3] << 24 | p[4] << 16 | p[5] << 8 | p[6];
+}
+
+static inline u64 get_unaligned_be56(const void *p)
+{
+	return __get_unaligned_be56(p);
+}
+
 #endif /* __LINUX_UNALIGNED_H */

-- 
2.43.0

