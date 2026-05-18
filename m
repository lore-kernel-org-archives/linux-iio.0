Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029613A1A38
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141796; cv=none; b=a3CPEk6qvNqGmyNa8Wj8QjVou1UubUvpIxMiqJe0W8nUDUEfZdURs/G6nEDzAfj0vKjo7UQiYriNnxaoNIjWcKF+eLlIqTe4fYh+oIbhoq+zPYvi/hHrLnRb+hqhFi1k/sBgT+6vjZm5GlLKtqvKv1GIS752X+wjQEDxM9kCgk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141796; c=relaxed/simple;
	bh=R9bwTFIJwq+fwIoSatBtXQNRjV3224ZU1kWtKpEQ9Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIDrvxqRUK97Pq6qeoBCj9z/PWRm7hS3UxvpFXCoIntzyfONXJOXksyOZDdbpAXn7DMR64xth6z1OySPe76zGdN+My3cmQM5lREGhTthR0TH8RRjvd+4cjl9f29p4qmdGezhbaZHyUUKHwT39xZquWfzBNuwjN9uYZCmtsE6HPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbXdtKU/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbXdtKU/"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-83d5bbef760so1186986b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779141794; x=1779746594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvUEwi2/32Pm+I7ySH9JgCFLggtG2+BEwjV7D+cKqy0=;
        b=WbXdtKU/eCEjZuKwBI7CdlHCVikh+9TI8m7nb2YVRmOmS+nE40OgOXIKXuIbfALRMQ
         +Yvv6KqZ2g5nuXDflz4hNH6o85IAfRlHT8m+1zK9cQythbltEplGt0qQuRPg1wHPcY3R
         PeuIZAR8BfKOLVkig+x3do1N1IF3+ok0k3YzQpFRyVo5C1Vj/9JmGPN9us5CWHXJxx8O
         V2vyR7Z/3ou0Lmon+IlDPP7sBg6rrRg5qlgS+i8PVa+oq2MauzJ2sF1PbDzb0G5ELtkh
         S2jJmFIZxm7XPhztWOAKv/APy5XKTvGH21ID8oHciVfULlAPbD1IQMTorIg2VwFhzkUq
         Nw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141794; x=1779746594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yvUEwi2/32Pm+I7ySH9JgCFLggtG2+BEwjV7D+cKqy0=;
        b=WyL0dcvaxcx553QL4oOqIwilq+LiFyM2wf9BdDpHMXC2D53i6zxoeGtuOcjDHjLDtz
         sF0RPzfQcK7OXpw1fabsjdlZQ/4ntvBmv8wRmPVku8WMEBfhgQD+aR+h4JMd1rQojgSf
         yIFjUDYZnzI83gTdMFKzsbtU4hY18b+XhXVI3iaUkYVWXqIPaiDoLFhiT/fPkdNxbQfg
         z8mDUA0jTaX9KYndey9wDAFmOeU6Hh3ONpdDNDCE9b0ZT5spE1t4dRvnNAVpksxun9MY
         XphQs4/j1b0LWk4Br9YxEp+H49XwcsnIYtnQpKPvN+nMrlj6NlyMtdFZ2ZxfgqovpYIt
         D1tA==
X-Gm-Message-State: AOJu0YzYIHM0KwWWVr3+l/3Dk6twDpw8X1OjOpEBdvDoYKusrkkhsfkQ
	22DntCs3mT1GYG18phvajD2cUPXsEP3it0WdM48AFmd36gmBUCzg3Mox
X-Gm-Gg: Acq92OEDgPRTQeNLo0wpNHbDis9hlE5euqX0cja5ByMKOFZVOLXlCyJtdXgj6Ir8IRH
	7BjpxYeW4VVu8WsxgGfNTsMbcT9ddkXzrhKRsSpprONcEJzOYC8w/eQT9q+snYy7vyRRSjOctx0
	oN5kbvpZg0Ngl66S7zseNFFEQBPQupAsqN1VO1jZA99isJk3+rDQboIT0XPd5mrRDhs8aebMcnP
	xVA5BlErBJ2zwTR9FbRkSiUJnif78Bp0wyOYK682oIqd49BzzmbTiiKpnKPdN0PzZ1BGPMWeIli
	UFZR+ELINmq9kh2aqUjOKiaNcpAsZLuWDCzc2NpH7Ip7zcNNpMMTgGQC82X2Z1CPVayKjhYAL7O
	Fd1kkf+ngJpt3o34B2LU7WtGLlcSlJKzxdHs6l55+BCFNyoXEMkufhTcldAf+WAZDCKE3xn8obO
	JaDuK0QUurTlmcfmtvLZt5ro1yC/IhlQ/H3sbBFwIhR71uKBtDkhB+ZhGvM0bw35/1Z4RQofUX3
	ddBwmmRH6dWLsGDLJodBhXjCwmOX1+t3FSSDI5Ce5WxGAIGxTbFt7rSRfv//JXRUTbKDgU=
X-Received: by 2002:a05:6a00:12e7:b0:837:666f:8fcb with SMTP id d2e1a72fcca58-83f33ba1603mr16232568b3a.5.1779141794380;
        Mon, 18 May 2026 15:03:14 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977b128sm15772960b3a.22.2026.05.18.15.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:03:13 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v9 09/11] iio: adc: hx711: localize loop iterators in hx711_read
Date: Tue, 19 May 2026 03:32:25 +0530
Message-ID: <20260518220228.63322-10-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518220228.63322-1-piyushpatle228@gmail.com>
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tighten the scope of the loop variables in hx711_read() now that
trailing-pulse selection is already handled by the callers.

Also replace the 24-bit loop bound with a named constant while touching
the same code.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
No change from v8.
 drivers/iio/adc/hx711.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 9e5cafa1e307..0db2d2db9242 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -23,6 +23,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 
+#define HX711_DATA_BITS		24
+
 /* gain to pulse and scale conversion */
 #define HX711_GAIN_MAX		3
 #define HX711_RESET_GAIN	128
@@ -157,16 +159,16 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 
 static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
-	int i, ret;
 	int value = 0;
 	int val;
+	int ret;
 
 	/* we double check if it's really down */
 	val = gpiod_get_value(hx711_data->gpiod_dout);
 	if (val)
 		return -EIO;
 
-	for (i = 0; i < 24; i++) {
+	for (int i = 0; i < HX711_DATA_BITS; i++) {
 		value <<= 1;
 		ret = hx711_cycle(hx711_data);
 		if (ret)
@@ -175,7 +177,7 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 
 	value ^= 0x800000;
 
-	for (i = 0; i < trailing_pulses; i++)
+	for (int i = 0; i < trailing_pulses; i++)
 		hx711_cycle(hx711_data);
 
 	return value;
-- 
2.43.0

