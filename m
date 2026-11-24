Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513599;
	b=vWkUB8qKtYemmPeZDgxSisRrF4QSrMVmT8Ntk7CCWlGXpb5ZcbrFXbSNgx5VQaIX7Qsj
	 FC2kCCPrtlP1LNfZmeXs72DcUybi0rkW05VYP4CFWsP9Dw4QMhLDez45GfcuSuVWq4L2C
	 GxGDWErGyeglIJhrekC7DMvMVymah/vqDpUnAbUDIRACsKFBiyKw/M3Mwgmhl4G9qiu4P
	 EdR3nLmQR0CpsNxxXFg9L1FpaDSjCPjpPrLaf4afUzNNhgV5lSW3jIh7pPheKDLVFTQcj
	 r1q9sDIeqU1JyEU88DrcPTadaQDlV1H6JkazdlVElk0TKKWx8bm3AiIq6XEx1rVx34g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oaLF5qIGw2nyY3NabfPF5nK44+ZydS+4SbcKbcg9WWs=;
	b=XLtC+Q0WKr2Asf5Y23UFJT20Vvue00CDj9Ke1nIoAbsGIEt2KdvD16DoTT/Yj1YJaW7a
	 wergmd1TEuCkQy/fesb6kzjUagE+aU7kuZTo9LB/qtu5IVIXcrtcU2U5Gi/mCciSJTsp3
	 n+jvgK7t4ciQX5AEa2AhWSj4gLAaEZK8r05upn4QV/V7M8Ir94/k1Hup8KaKWe3eCR+pK
	 pb2KEEK1yQIZPf3qhDWM7izxHTPhbgimuUHUZRaDWVTA0MrKSi8sTd0zyMze3j6ar8gai
	 ZcmX/HxdFqDSdBy+aSXWPE8Fo+KEGgnIOxG2EMQI78kwSUmlZgDygl7EOxxkw62Za5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="hDQ/Zwnp";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D90606CC20
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 09:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9D90606CC20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hDQ/Zwnp
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so54235675e9.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 01:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795513596; x=1796118396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oaLF5qIGw2nyY3NabfPF5nK44+ZydS+4SbcKbcg9WWs=;
        b=hDQ/ZwnpSFaBpYw6vL86oM48gvv/PCcWR1a3lXgn9Bq1G13dDdODKUnQy57OgrcMJ9
         1asTrnjUSy28E9N/SaG4tcI5J3RhYuQFwSb9zJFuirJ7d4bMtxHowLKM0Bz198y6c5qQ
         Q23v3HNoqpvXrfKIyYvP9bVdE9DA4b/QVsJbguQ1Kztphpo8Oy+IC0+9AC3Auf/QBAXT
         n2AyetudKrb8XS0lA7g8HD5/wyiRJXnv5RNhiXrGpw3pnTvR4sOLjqTF3zLCaaV99zZB
         dbs8ozO1zRDxVh32Quz9H8Z70ctOv8gzXbMft4p5cYAIFKig9CYX9pcstHarT0R6FHLS
         oEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795513596; x=1796118396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oaLF5qIGw2nyY3NabfPF5nK44+ZydS+4SbcKbcg9WWs=;
        b=0B8UTsjY965k1fIK9w+asnyxBTI7mjsjLEwHDQW1ZX/jZYoy3ld7eceRRpQ9pMMwCM
         /DBaNFo8VZ/4laRlu+EHkWJjWVi2iCkRMahgpf7xl7B66/6WCKRXPBtm2LB6fkP7IpJb
         Klh+oQtC6jfSJ1tx6JM6k2Xyl3utC9fMoBEGnDoGGje8mL4RDc6F27A2T+UikX0rAALw
         HUXXILOZHsodVtM7Ul2bsSkGKLmP251DR2Szh3/ZyDYsJcnzziEyp02ThtQ+qPXlliQo
         5YixgO5tnwdRImAXfM5dMUj7gwWE+mNxNUhx2NdX3tEBd2kwxdj1fbsFzZKio/Rp6bUu
         CmsA==
X-Forwarded-Encrypted: i=1; AL+hErFvX03u2GqcwuDlr6UFb9LKlqzzgX2FdDLTfrMRArFWB+M+cEAP/YAunYc47FpeqhZMWl2OINf9LTg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9M7p2mYIpT3mTzQjml9OXCRcCuxu6RsJOOYDw6y6Vidp53g2kw
	dJHyFE95cD/Ls5erdRRndYI++fSFEylDt6h418HIShCP3EbXI2GwhgbvLBa0+FK3W6U=
X-Gm-Gg: AZFdTZeBx6SBzlakIFnVtlwJ7oaigvCN/AzI4aq+mmv9hZUqjJAT5Jag9tbM4pTvjsT
	p7suLSEgEE8vWMtaBD2lXa5dpHa+dZUF0wlZRODemYXBCL8LI2wTLAhh7QkgGlsJaKDOB6rW53x
	VbmNHb8YWvjIuo9W/EDbcyKHxDMdPf0kNGrXCkh9t9KcMUUH9QDsuI0ez06xh69WA1lA5e+dXNS
	cZvS1x9ZsgVYKrOUdq8DSNF1hw+urUfE9+6Xk6LTAMrCxh4yMZPIdoFOI/FYXDHvsgX+0wtVycw
	0pd7YhjW8WFcyYoKpgyJ+y2vcpR42N8SzdulgqQXyPsqrM4jTymdT0CxUwYr1qFMbDsKJmA6UYW
	qMuwThQ6KjGdffrolJ59wsJezjWnRsv9gDKH4W5XQ1g96gQZf+Xg+B1oa910OroBc72/HvyCRBO
	qz53e3cVeVWmwhkzkM9gNngB2eXM/vFQe/mUQyXH4DaEKvPlTCvsuOEZ8RZda/W+3uwqKxf7cCP
	1CbUA1Lt57DwWQPvX70dlwt1o2vzjxEiHGB0Sxb88ZWPtfvlzedto7uia50R5Vb3V697nqBAU7h
	qWqR2Rw2ISd8Us4zyLHSQW+AOs9YWvTINinpQ6uX5ENvTeDZXGMLKGeYVY/z609CgSj2qWjR6EQ
	+orzY/ddt0Ss=
X-Received: by 2002:a05:600c:1c1f:b0:4bb:6847:7943 with SMTP id 5b1f17b1804b1-4bb88814510mr348413515e9.26.1795513596142;
        Tue, 24 Nov 2026 01:46:36 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm431782555e9.15.2026.11.24.01.46.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 01:46:35 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v5 2/4] iio: magnetometer: mmc5633: Reference the datasheet for the SET/RESET wait
Date: Tue, 24 Nov 2026 10:46:30 +0100
Message-ID: <20261124094632.8879-3-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261124094632.8879-1-gerard@teslabs.com>
References: <20261124094632.8879-1-gerard@teslabs.com>
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

The 1 ms wait after a SET or RESET is tSR in the Operating Timing Diagram
section of both datasheets. Describe it where it is defined, with the
revision and page of each datasheet, in place of the comment at its use
that pointed at the datasheet without either.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---
 drivers/iio/magnetometer/mmc5633.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
index b651f01e1b5d..8142ba741ddc 100644
--- a/drivers/iio/magnetometer/mmc5633.c
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -63,6 +63,12 @@
 
 #define MMC5633_CTRL1_BW_MASK		GENMASK(1, 0)
 
+/*
+ * tSR, minimum time between SET or RESET and other operations, per
+ * Operating Timing Diagram section in
+ * - MMC5603NJ datasheet (Rev. B, page 15)
+ * - MMC5633NJL datasheet (Rev. A, page 23)
+ */
 #define MMC5633_WAIT_SET_RESET_US	(1 * USEC_PER_MSEC)
 
 #define MMC5633_HDR_CTRL0_MEAS_M	0x01
@@ -144,10 +150,6 @@ static int mmc5633_init(struct mmc5633_data *data)
 	if (ret)
 		return ret;
 
-	/*
-	 * Minimum time interval between SET or RESET to other operations is
-	 * 1ms according to Operating Timing Diagram in datasheet.
-	 */
 	fsleep(MMC5633_WAIT_SET_RESET_US);
 
 	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_RESET);
-- 
2.45.2

