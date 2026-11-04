Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810732;
	b=bBxH9wIlzyd/xTNQByXkQWebZZ5fRq1dZvrORbHx9MxevpkAUEw11VuIwoleG2DwayPe
	 9t8JvI/YI4ZGHkgox7sxyxcSzyzLp3UtmsPy4EPft1dax64ak3vl4kpp/y89ABCU58KI1
	 D92zJwX3hEzIUb6vhdvUX6pt4FQbxrTKW3hJpG3sqTfJS/jumTvPT3jqImbPfw8l+KZKC
	 ffoM76ZfD02N81u3neO3TSR6kHPl0er2f2QtAFln8n6CXZXkXpyuO3+9Kpvv3yjbmINQG
	 opJEpGt55xIMHu63BWbDd/XUu05msZ2G42x5UxCdPT542pxuUzhYee+T762QGgcnfmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a/9ygPAkTkEPoEGsinPiA3vfqnT3GrgOWJ1i5yM5FwM=;
	b=llRdXLS2IAAD6MWE3F7o6sb9KaJ5F7egOmXce6I/QrqcaGdJ/8VWKWCQzSrRHJrWLbIQ
	 8h4IyerE0qAbMBGSpCtGSlyK8rDuGyBLjEHcmt+uwM1MRzw64mk2qFDDPwhDqZJaJGJgM
	 gwJy3LYSqCXX825K7aS+DLwPhmrlVwCGJUigrPt5pgEAY1rzKMWmHbKdthjR9uFLuJMb0
	 fYjxF1+qbkQDN+caNkJBFqoqmAhbom4IpZL+4AfAKyLT6eJQ/Xyl5nZ49wU8u86HAYQE8
	 6k4JtOnEe8NhFvr/e/CojLS2zYGj+cSg3AEO8AblktWvkO9xn0xW7f8uk/tVEhrUSwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bn/OceYF";
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31271606A331
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 16:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31271606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bn/OceYF
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36d6765756fso713719eec.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 08:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810731; x=1794415531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/9ygPAkTkEPoEGsinPiA3vfqnT3GrgOWJ1i5yM5FwM=;
        b=bn/OceYFwArPyDFSPPPx6F7fxbevCxKT8R7FeB0p2fbvIf+7OBijoe08vy0rwYc+5G
         /QZBWvJuKv/UYxDHvFcwLo1G5AofW5PO7IZT2FC4GT2O6VrxOvu2JcN1jB7k5hdV/kYN
         fS38yTExWUTJGvZc8YTuWCR+sxiYYi1vChhUP2aaBrFUuS7OpBt8gd/X4hXLV1RRI5mO
         ChyQV/5HOvlWE8Kuu1Qu8f1m4wzI2Nu/JhSro6UmNEX+Pux9AKYWt89R04k4H1B1tg0q
         BH8kBQIYND/ACmTt+ZaioNGqcPPB4bwc0yDq1hYXQKG2B83ZPSN2qQsgFmuGLfJUj+QH
         xj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810731; x=1794415531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/9ygPAkTkEPoEGsinPiA3vfqnT3GrgOWJ1i5yM5FwM=;
        b=zbD+L8hdPzQo9Qvz7Y0BYPOhzW4HnsKiuWPKop8TV+7K7IW3dO6c9zB+yYxNHz8aj4
         wyNraZzyYB7L+osK1HMuEPTn9q/mV76uMNftWDNXTn+eUh5AGyCzdGrHjeUG/v/qgk8/
         hRiSuSkakrnUl1+3Rph1Rj00PzF8MS2uS8NWdkj06UxkFMH3kYh7qvUiNxNE2ccN2ybe
         7GoeN8AidWKsdf/z1ubKvsoKp/mtJq+Pw99XNX1HLqi1R/nF0vdzGEdtTt4Y60pj/nl0
         R0MRTXllwlJG89SamoYatajskSXg7Dciz3YCFbn39LN71NRWkyvYLsK4z25eeSFNQQZm
         6Qgg==
X-Forwarded-Encrypted: i=1; AKwUvBxuIXG7Z8CnsLn9xh9fPr3stdSKgwq/eSZwToqhUp66I2e9guPcD5soHq25es5+v5h4GEU6TVajfuM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WLEENv7H5jVVCcKSbZ4Nb+NQ42FLdfRzXAL+gASkSoVFYGVIx
	PcqUP02NC5YhI4wQ4Pg8X0UrHU9AEwUpQ3kXs5fX8A/hTa3Q+M1Foo01bdrdhYAkl2Y=
X-Gm-Gg: AYBFou1ZbzwEMKf/aBFI8mTPF8PhZ+FXxtOwvmXlN+y0vY7BJ3NHH4sLt4711g0KKd1
	+JhHU0f09OYCAwzPUOI84CXGb2VJxfQas+dDKFVaCCcX/32iKEzET842TxlFW7R6U01ID93nBuE
	IhRjoTqr1QahmwA492vSi93T6WkOq761jdUPrpWR5K+YLC4XEkif/Gmsr3aUhbJhCrvl7GvlEpJ
	7PHUqgsJnrwCrz2V4TM1j+fjS7fXJYj4ktauJlnzedy2XhdI6/kRbzltxHnMCzAZPp2ukXhOZDX
	ejzD1HIqYGPm5bB9fMcUNRyXisMsldseYZTsthuUWxs7JGcQS8w1q+J66u1MURA1EZ+JpbJukM6
	vjFjxAJHT0eUyn73Vc7EhyTUUeBoXg5XQc13SGfYHwpXKmIELKiEx2GzVfudrnqEDJxm5SRSKUK
	KOetDLzxVgORYaRQJX1uSFzjg1M0mhjybRGPW6sV6AQoW9mU9WesUsDj8/JZwdcFBCENh0iVfR3
	VAikHwv6igSZ93aWKCrSIcyY7i9qYpeTtQNV3qKArW+22a8iScxmNoMdMypUIH7UZu+cv/K9O74
	ycY2OQeF5wh84FrJVzlmLCW9TdSHdSKRyTq0Gn29p4O23f6lTAr4lT8sKy9UGJXv8YbbYB9GZ4W
	/MCCn5bey8MxrV7Y/VWRv7O5k+O9eondznTN0+NPBF8ERYmDLRVeMu2qWKwfIhsaIq+WsR3ai/E
	1W+qyv3sIbGRMsJs2nS9/kLhtkbpKpw+2G+XgutPzE+Q==
X-Received: by 2002:a05:693c:4154:10b0:369:f4d7:19fc with SMTP id 5a478bee46e88-36a424988abmr28669874eec.41.1793810730934;
        Wed, 04 Nov 2026 08:45:30 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d36a1sm10368825eec.12.2026.11.04.08.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:45:30 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Salih Erim <salih.erim@amd.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: xlnx,zynqmp-ams: limit external channels to 30-50
Date: Wed,  4 Nov 2026 22:15:00 +0530
Message-ID: <20261104164510.105359-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104164510.105359-1-kapoorarnav43@gmail.com>
References: <20261104164510.105359-1-kapoorarnav43@gmail.com>
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

Channels 20 to 29 of the PL-SYSMON block are its fixed channels (PL
temperature to VCCADC), which the driver always provides. Only channels
30 to 50 (the differential input, VUser0-3 and VAux0-15) are external
channels that can be described as "channel@N" child nodes, yet the
binding accepts any N from 20 to 50. Listing one of the fixed channels
there only makes the driver add it a second time.

Limit the child nodes to channels 30 to 50.

Fixes: 39dd2d1e251d ("dt-bindings: iio: adc: Add Xilinx AMS binding documentation")
Suggested-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 .../devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml       | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
index 3ae1a0bab38f..0872f5f314c1 100644
--- a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
@@ -160,17 +160,18 @@ properties:
         const: 0
 
     patternProperties:
-      "^channel@([2-4][0-9]|50)$":
+      "^channel@([34][0-9]|50)$":
         type: object
         description:
-          Describes the external channels connected.
+          Describes the external channels connected. Channels 20 to 29 are
+          always available and are not listed here.
 
         properties:
           reg:
             description:
               Pair of pins the channel is connected to. This value is
               same as Channel Number for a particular channel.
-            minimum: 20
+            minimum: 30
             maximum: 50
 
           xlnx,bipolar:
-- 
2.53.0

