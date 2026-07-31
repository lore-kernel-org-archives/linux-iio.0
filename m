Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6E331ECF
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541728; cv=none; b=CfEL/WEYvqFCJsS9ewr15pVzWl4HDxrUocuVA/GC8Zd6EhPLGptMo7YmTegvRvABCNaDIh5OXU4wkbRoICNU+VRnti5gC1IbRmlY48yBib49aGFysZJekrU7r9MMC7xhGVTfAVY3KfCFuFoTOHcWIB63Lzm8P9zP/JmOVfCp0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541728; c=relaxed/simple;
	bh=r3JPcXELEI14MaPKJygm9Wac06qVhNnCV6sCDw2Vohg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ae3Pi7bG0/FxuF6E5Zzql80ltAta6l1XkEhBFDTeO5AVtgCiKAOceNhk6+SWD/HHsS+sfRP6u9BWH4jQpkODqlgNQ8BOe1I41ZjhAEjHIlLnqBb+S2GpvGzMNxFNv9e6cHKMnfjBJ7wFdD+J6ZqDz5TU6071ON3O4kVNvtSsb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=h0UWZ3sc; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="h0UWZ3sc"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso1035873a34.1
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 16:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785541726; x=1786146526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N/7SQDD7HWD3jYhQy6leNzFmOM8bWqVDGcSmTseDNbs=;
        b=h0UWZ3scz3XXoiFueeFA1MhyYNjNBenS7GyIL37xZyZOzZZCOnju3B/5tIo+RWRs91
         jhMqJzkGJwhzVAMnKZf7+u2HAPSnxY0jv+42x5x4z0S1Fn2ofsyMWHwzX3SpK0gom2oe
         r1a5wzJZyt0zbfgmC9VpQfaTd6M/qGmC4+Mo8iE3T9uzXSZfZJQx1FA8nAfHzeU2cUYj
         /a/vk7alei57N0AkKy5W/w4j372siBsTm4lSDHs+/YCyIoDzdfRgM59B3X3HBMxUvMQV
         gSyTBbXe2kqwqlB1lmEr2Li0LcEibQwuc49u2oPxeW5TxUspqzC4F7xe1hKtS9aYHYND
         8z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785541726; x=1786146526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/7SQDD7HWD3jYhQy6leNzFmOM8bWqVDGcSmTseDNbs=;
        b=Lh+bcQq6umxY6cFeOvA2DDp8AYvwzSXfne03uG3ddle26QePiczxP6nK33ptnCF6dd
         U5+qddN6WtgnBCu29PokzebmHF7p7zYAxUPL5QK17HbLNLiZiQZQu5S4ebz2rsu6Zj2q
         BpgDDSkqAyuU1dDIlTkbHXsQQrvkZyUU92r5+J657EhxFNZUyc1MvnFkQA5DW5WJAml+
         lxu2ndRnd5b+Z9ehJgTs5oBOe+YcWAlAylGSy9aiC8cMezE0zIK2RpkrOBS6tItzR8l9
         z4PROsvMLY4m6YJI96RhMo7O3riPvlpGYI56mlAWBSD6XrLkQcLs/GbX22xP7iPE7Z7G
         NhTQ==
X-Forwarded-Encrypted: i=1; AHgh+RrwMtNzPb9TJ4MrJ8aTNDVJhyRMtFLBx9AQwxvwfGrf2wHC8I4eoT+kSuFONIvFw8Z734wZsqp213k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8UTBPRNe+xYol7kXaunjPXkF3fYp5jgdUO1MGru4ibbkgSfF
	bIbXFpL5xWMrriHOeH1lA0HypRu6QT103UhdHoN10PwnSjmmMQa6ejP28jHx4M+akkc=
X-Gm-Gg: AR+sD12Ug8Q48yE1pYiRxeUe7IhRBMPGgoXdby0s/Pvo9weFL9+uTlzdHtJVEkRBToo
	PmbX4rWfBr6aXjJ+jx7nzOOALViWqh/4cE/hJBikPC9cEniiTS8jwrMwz9uIZoHNqJOxVpZGQif
	/YQnYAlPIv6tPiyLmiJp9OrQztZJU5bY3iLLI4cJ4jVYT28ihc8sIlHLeuf22UrjsGP5ZA9E60Z
	R7CqZ8Qo+PLvgpGBbgFpK4iiyvT+Dwontaa2XkZ4GLTa1S+SfHawdbnJer2LPACYEpytnnABQc2
	v3ZUqEI5S2dpnuH5lGrZ994LGH+/PvdN4hcw3HZeCfWSINFSqO5oVlipckGEit4xHnGyNDUG/td
	t1rudlgmo84EhOg/10mnPJ7Pu36N3tB+CdfKjsGLj9vDp6HIQ6cq/MJ/PFtRbw4r4ng9fqtC2BZ
	3Z0t8U0ZItRMSPdH8ju7TgErvP64hI4z/KFCUajpCo+gzcHUaDvocNcXiMPdmFoum1Stc=
X-Received: by 2002:a05:6830:411d:b0:7d9:f50f:9691 with SMTP id 46e09a7af769-7f1968c88e1mr4108190a34.0.1785541726418;
        Fri, 31 Jul 2026 16:48:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed3c814sm1736940a34.6.2026.07.31.16.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 16:48:45 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 31 Jul 2026 18:48:11 -0500
Subject: [PATCH v2 2/3] iio: adc: ti-ads112c14: create data read helper
 functions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-2-eb13da38e8fc@baylibre.com>
References: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-0-eb13da38e8fc@baylibre.com>
In-Reply-To: <20260731-iio-adc-ti-ads112c14-continuous-mode-v2-0-eb13da38e8fc@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=r3JPcXELEI14MaPKJygm9Wac06qVhNnCV6sCDw2Vohg=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGLJyTXxLHX8f8jrE7OARu+tZHFc+h+fd1SwRcbJ5EZxrt
 Q+Fvz/cyWjMwsDIxSArpsjyRuLmvCS+5mtzbmTMgBnEygQyhYGLUwAmYsrG/otpfXIj248tF94v
 2jqpT6NX50K4y4M/j6Xdw2Wnbjkptf2k4gT130w1Bsd/Hdulon3pva3F27Plqms2v6q8na5ZZbx
 xPWudXE6IGs/Srvsfb/9QDWOvWbcnz/GP41MJQTGtMvFHbUtXmlsW9h/6Y5raXlZXUyVxQXjP9U
 0h6//LJZZ0h24MDgwMj2SyfvG79xSvxTczBrcVV1zmVMscNYqIZHGX2KS3Wkw84ae1ymzn93VnF
 /Kmbgl/svX67UduP/jtS7stp9/7t1y9+p2WHduLnieGfj5Z7q3CPQxeG3+/LGQwVPqqfagl4E/A
 7YOqr3tYVctyeud0tf85Yvn24DVW87AJLv3ZfVnT4zjCAQ==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Refactor a few bits of code into helper functions. These will be reused
when continuous mode support is added in a later patch.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 51 +++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 177f7064092e..c6d83298c312 100644
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
@@ -649,15 +675,9 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 
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
@@ -672,17 +692,8 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
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

