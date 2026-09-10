Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD993B14AC
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074884; cv=none; b=W1nJk1ZsDTH3TdZv+2apkLX2SsptmlMMD1fp91YawVtcaPBjphoLXYzOgPkKLz5XMgOqAMGJd4Nh+RPOn/j26XG/CXONqfnnXcla+d0Xj0mfHzjOYZtRWq8DBFC1AD7iHKGhG5/4qFcQwbLmnM8PQ7yPviarcvGeLLTXE0cWwns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074884; c=relaxed/simple;
	bh=yI4Hk3lgmAclykhu+CF4IfwMFXOwKo7xr12Yxb8s+vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cGi0tO0uO+Tl59I7aRtCoqqtavLGRJNU4udiIxIX4RFM4QDdvEiIrjpatmdnShm1N/Scb+H0YB98VWmtf34Ub3eYJJI6icRkqv2P8UVuUVIDffA52vBscFhC6H8PJ0sfhVia6DmLJNf9QSi05Qjvipau6KqcD//834fxk/MjAmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LUA4weC/; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LUA4weC/"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4a451915d8aso297374b6e.2
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789074873; x=1789679673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Lqb73MWiqVxTq8osVaR58AWy47UTsGolXWTeVg1RTI=;
        b=LUA4weC/0J2nvc/ZX7bYOQXDG+oXdIfkx12oJYBY6jGnGm9UzLIQfq6aJYKwuUB2v5
         KAvGS+xViroFsTlAsBWEJ0SuO6IVZcetpcyk/vxRZjTM9G/45vzDi4gH++KNAPaoJYCv
         lGNuAdrvdJImmRRF0OfkrtQfefLayB+XafQ6OMlv3SWyYa5xM3aLC3s/6AwCYCb2qM6g
         B5wwIoKSnLNUV13KQUkdmKoBslRLB2rGQujpPee3vkHuQoOHicJnE5F7rdwcqhYwSXAP
         GApU5Gl1eyBYJ1dW/zI393LMppp25HKpc5oPjqwSKm4Qh7TAyCotmcpvuCmJQEkMWSnw
         giTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074873; x=1789679673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Lqb73MWiqVxTq8osVaR58AWy47UTsGolXWTeVg1RTI=;
        b=JmCrAUaZw1HeUAlSOcq4reYxWzmuYsYZAjv/t4J4F6B4Li0YNg1v26/Q3V4t1ouLNA
         VXdphVSg1uHdnDvwcApiXasYV9UQuRy/xZejyr8FbZSkF6kRmImlvXngL6hKsQFCq9lY
         c1jlxi5W2aG/m6cASjAHAeYeJzfkDem4CoBQjcZ+52iN3fStR3MmX9jW9m0lxv8krUeV
         GN94Op04tBS1nD/6rfVHGyScUa408yBIs9bLKfPMgDWNECSoknAX3PkqedQ7f692Nq66
         w5hgiqzt2tonniUYVNklvlwA67NTeOzKQTelaTZjGaijh+wgQr2rqobk2eakGjJw5DYk
         IezQ==
X-Forwarded-Encrypted: i=1; AKwUvBwntXNDDuKyqMix2tBzY7KHiJZHQUQUeIS9oXBIosyVGQ8XPzl3f0lG1L+r1rJ/KvfYQDWSqbLgoH4=@vger.kernel.org
X-Gm-Message-State: AFuF++ltFHN2wKbIt0utRGlYMfMNbtLg7Yx+E4zGdKb1E6JGH3XVSymI
	hF8GimypFiDuOS3tZFBIrNDZoNlkR5gQxe9xQEKSdVfSg05nFiPzM9Jzx7lEbixE034=
X-Gm-Gg: AYBFou2aY8FTUyzES0IBm3Dz7XUFn/toZrJeqW51Vhx1VsI9AYV/uWT/2l+r61VkZPJ
	f4so3aBhqk+JaqiQczE9706I2PA3wMnYk+weXfJOTi2fTRPSr7qcNQbvsM/rrE7lzAS6Fk8t7Uw
	IKISpx3UJQ15DASFeXj/vlo3eAZ5/O6Xw3Zn87GOOxijvt2yjsUbDvIHr1CvOp1Wegu1mzQPB0b
	B5uOemlGh9UFJy4Cf/psP7v8SJs6Jjz7ID30DylVda5b5fkpuwK+dWBSELb3qYeWmIHCcPajYKi
	Qe0nxZC2eOJmh0V9T93tup68DsFqlVCFTziRV10v5byFhVeesU6pdubPjNo1jgfUTZP6GZAjxep
	pO+R6K/aDJHRlslT/BWM9d49fvgSLO/xaYCNGFc/F+xKNxuakVx/p3l2j2OWmsBH36RAwaFc9v+
	gTe9EjqVRMV403EKMfG2XSp2qfomr/Iz3IFhbbSXdbGwjbuIG/JarA+Y5w134JqJ5Wk5Cv2z8Ck
	D7d
X-Received: by 2002:a05:6808:d4e:b0:4c2:dd8a:fa46 with SMTP id 5614622812f47-4c319a4f5d7mr676216b6e.16.1789074872995;
        Thu, 10 Sep 2026 14:14:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fbf1:d0da:69e0:11a0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa42esm347315b6e.4.2026.09.10.14.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:14:32 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 10 Sep 2026 16:13:01 -0500
Subject: [PATCH v3 02/10] iio: adc: ti-ads112c14: create data read helper
 functions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-iio-adc-ti-ads112c14-filter-support-v3-2-e5a9b27ddb1a@baylibre.com>
References: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
In-Reply-To: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=yI4Hk3lgmAclykhu+CF4IfwMFXOwKo7xr12Yxb8s+vc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqox15NIzRzXG8xctuhvC/NL85GoIo6+4MDso3a
 G0oJUKViWuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqMdeQAKCRDCzCAB/wGP
 wGY+CACXYZ57zGgdJRSF2r+iC+IQwHm+q11Hg+ZWHf10JIRnoxLxd5tgo92Z84B62yFC2t1FE3v
 MXcVUFOfsbDLwlLnwooMjHjM8H6dHpHXVQEL5pFF7z8KliwiDICIYslKPaETpewZ6DAfU5LMbIH
 BfEEzYkzqlCHE9ROYikkTjFDar3n+bgNQAtz72m3aRV0apIKmS1KmL3KIi60nnPwhW29Mad1Xvk
 tMSrKcOhNKLbxoVxokKTLHhAJ6nf1cNS9cLg/UFxSVxT+CrH9EyX8e61bcgb+18v7iIDHsVXqaT
 XPkukubrhbuePjac7htbsHTvCV0sjg/XkF7tTW2w6VxFpB+I
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Refactor a few bits of code into helper functions. These will be reused
when continuous mode support is added in a later patch.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 51 +++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 9058ad34bc06..b2940b5d3c99 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -601,6 +601,32 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 	return 0;
 }
 
+static int ads112c14_prepare_channel(struct ads112c14_data *data,
+				     const struct iio_chan_spec *chan)
+{
+	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE)
+		return ads112c14_prepare_measurement_channel(data, chan);
+
+	return ads112c14_prepare_sys_mon_channel(data, chan);
+}
+
+static int ads112c14_scan_read(struct ads112c14_data *data, u8 *buf)
+{
+	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
+	int ret;
+	u8 len;
+
+	len = BITS_TO_BYTES(data->chip_info->resolution_bits);
+	if (data->i2c_crc_enabled)
+		len += 1;
+
+	ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA, len, buf);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data)
 {
 	unsigned long remaining;
@@ -644,15 +670,9 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 
 	guard(mutex)(&data->lock);
 
-	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
-		ret = ads112c14_prepare_measurement_channel(data, chan);
-		if (ret)
-			return ret;
-	} else {
-		ret = ads112c14_prepare_sys_mon_channel(data, chan);
-		if (ret)
-			return ret;
-	}
+	ret = ads112c14_prepare_channel(data, chan);
+	if (ret)
+		return ret;
 
 	if (data->drdy_irq)
 		ret = ads112c14_wait_for_conversion_irq(data);
@@ -667,17 +687,8 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 	 * with CRC errors, but rather leave it to userspace to decide what to
 	 * do.
 	 */
-	if (for_scan) {
-		u8 len = BITS_TO_BYTES(data->chip_info->resolution_bits) +
-			 (data->i2c_crc_enabled ? 1 : 0);
-
-		ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA,
-						    len, buf);
-		if (ret < 0)
-			return ret;
-
-		return 0;
-	}
+	if (for_scan)
+		return ads112c14_scan_read(data, buf);
 
 	return ads112c14_i2c_read_bytes(client, ADS112C14_CMD_RDATA, buf,
 					BITS_TO_BYTES(data->chip_info->resolution_bits),

-- 
2.43.0

