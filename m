Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB2137F8B3
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787389158; cv=none; b=LryP7ugGiMs7HRb5F8vSMXMLE4gmZuEDff32JAsD4h0JMk56XMTElP3r6u0hcuB+G6yqc9hlSrVX47qYbf5O1NEQ2/V5XdEe+gQ0w4fRUHG5tVwiTHT4G1cOxahRQiSsg5DjiOSssN7iocC/va3quxSsJ++6MZuHwM05Ebw7pCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787389158; c=relaxed/simple;
	bh=knEBHlFfwfTg3BZHtVetu+4kkb6goYIW9lT42atil6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fe6wszpeb/NM/SWJKjuzkUy9aVLNuFA9MDgRPVm7yK35qXXC+i/DX4mfLr6yi5hyLHH4RBHlmQgGeUWJwZVgLsmV0pjKw9bp/316NK0x3AKEn/1qLUWkDXjtL1ChjQm8DdAPBM6+jzOm04lPoZd+8a+3GVmdzg7uyyh1XwBNVio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQxcpLVe; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQxcpLVe"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4798bea72f9so856846f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787389155; x=1787993955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gyzSFKMQwJr+T8EdF5oNgce8bGN34YWsrDUToLRcePQ=;
        b=YQxcpLVejS2q7sX6dDG7AVnPrRzjNFwe/Jg+at+teKir7AzRvy7iS9MxWop3w0ITJx
         wUxV0BNCZgauXWVLK78WHU2Dn57HABp2DWAu4h9SHc7qd7l4W6LuijQP3664ZA6JDXyF
         4a0aQ3rOUh7BA2HfDhSYMHBQrNXNGd0C6TrXq6vxbE7x9Ll+mJPKudIhOAlzQpu8O4WQ
         vPVv4sfmWzwdI0hiaCiE8AEtWPleFi48+8zjjzvj+ZGQgrD+pf8uDvGZBh+/GD8nTZ8A
         4qonsMMW+Hf6ynQsgw1rpLwiFKAvvCj9RFMwqhQJuiEfQ31JfwprW/hrqmsXUMKS0eGg
         KXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787389155; x=1787993955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gyzSFKMQwJr+T8EdF5oNgce8bGN34YWsrDUToLRcePQ=;
        b=Q8SFK2zwqEN29RHdtpd/vaHs/jx7LXauvkkhcBo5R79Cg0QmmjiPxUtVJTAPTUS+R8
         gaKVqfqA1jRjx158caJLo8KRa74TVFprWL3QYToXsV2cWpreS3Ms0UFdjRs8DS5BSdP7
         TdOn4/jp/sfQgjqPaa9IV/gwsO6cWkTo6O411YsUwqEkj2DjWzZHqqswZXqBdNx3WjON
         xf0C2b/F0zmLy7mEq7yZf8JGk/vU661kgAxO58zb4AjbqXF2bWEFtcFijbGPMxuibVRf
         SVoLV3BhZjo5HrI4knCua9wFCdMz6vBNLCj95q56ZUEwvSdjsjp8CpuekkpjQfIOofMU
         0VLA==
X-Forwarded-Encrypted: i=1; AHgh+RqSUNv2JbVJmEQXQeFGVPc0PFAl3nJbylhdJ3oD917iYEV/BvFmYn6878iYf9HZhDmZoifmGX8N6o4=@vger.kernel.org
X-Gm-Message-State: AFuF++n16KS2P7zgXiMY1CFymR3StCP9zLB0a6IbiTYXljmrUeBo5NvH
	J6MGQ2+0CVjOxKjPFZz6xB7Va4f9nKVWYeBl0J/9bkGQaZcRNYaIxpxA
X-Gm-Gg: AR+sD12HR1ctimpY4hz1CdpSpvByFElrxExCUfQ6yovKE3lJeqTH6X4FbOH62lAlhsH
	E010V2PtcUQO16ANiEal1yCwQv3qcpB2xMuqPZjNu7mzcWxDMfvbYRprNLPe45e6hB1UEEmR1Vu
	zfGhZjQ0sshK98hEXy/n7M4Rft/jC28322rujnZW/0WT7/NEVhhF891uz06WgKGNwAp/+MMgPw2
	alSPJ2ooFGqs79YM11DI0LymRMhbaVD3lhfAV1LVkfmqRiISo3VJuuWwnQLkyWscn1pNsFVWytH
	r+QlVnrxEz2lBGchIF3bNX85XVQ7+D5TxhL5wevKm9oplc/GvaUBq6SVWBosY6iJNCUz/UlLxy9
	8s7uHM+oAMkmPubaceCxNXpYIp0qkXb+XlFAKeG8zrJ4727bBo72p8Yxz89nnW1kMe5H8dlPw04
	h8SmBsuAHlWNAbKLInYOoSQLkfPtkMRcmOVqOieBTV6OYRJscnxu8QK7Y97bB6rsAnA1rfzozbQ
	azEy1r5K1Q=
X-Received: by 2002:a05:600c:45c3:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-499b8325c3fmr149228495e9.6.1787389154922;
        Sat, 22 Aug 2026 01:59:14 -0700 (PDT)
Received: from fedora ([105.74.72.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c359b9fcsm13596635e9.9.2026.08.22.01.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:59:14 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v6 6/6] iio: dac: ad5504: support scale via output-range-microvolt property
Date: Sat, 22 Aug 2026 04:56:53 -0400
Message-ID: <20260822085850.17527-7-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822085850.17527-1-0rayn.dev@gmail.com>
References: <20260822085850.17527-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD5504 output range is set by the R_SEL pin, not the VCC supply.
Add support for 'output-range-microvolt' to set vref_mv directly from
firmware. Use device_property_present() to distinguish absent from
malformed property rather than relying on the ambiguous -EINVAL from
device_property_read_u32_array(). Fall back to the vcc regulator
voltage for old DTs that predate this property.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 74679feea385..d0a3dd4b000d 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -300,6 +300,7 @@ static int ad5504_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct ad5504_state *st;
+	u32 range[2];
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -315,12 +316,30 @@ static int ad5504_probe(struct spi_device *spi)
 	if (is_acpi_device_node(dev_fwnode(dev))) {
 		st->vref_mv = AD5504_VREF_ACPI_DEFAULT_mV;
 	} else {
-		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "Failed to get vcc regulator\n");
-
-		st->vref_mv = ret / 1000;
+		if (device_property_present(dev, "output-range-microvolt")) {
+			ret = device_property_read_u32_array(dev, "output-range-microvolt",
+							     range, ARRAY_SIZE(range));
+			if (ret)
+				return dev_err_probe(dev, ret,
+							"Error parsing output-range-microvolt\n");
+
+			if (range[0] != 0 || (range[1] != 30 * MICRO && range[1] != 60 * MICRO))
+				return dev_err_probe(dev, -EINVAL,
+					"Invalid output-range-microvolt\n");
+
+			st->vref_mv = range[1] / (MICRO / MILLI);
+
+			ret = devm_regulator_get_enable(dev, "vcc");
+			if (ret < 0)
+				return dev_err_probe(dev, ret, "Failed to enable vcc regulator\n");
+		} else {
+			/* Backward compat: old DTs without output-range-microvolt */
+			ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
+			if (ret < 0)
+				return dev_err_probe(dev, ret, "Failed to get vcc regulator\n");
+
+			st->vref_mv = ret / (MICRO / MILLI);
+		}
 	}
 
 	st->spi = spi;
-- 
2.55.0

