Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503023;
	b=mEZn3Nc71am9UoabSZw+9ueXNMUlByZ2Fue5aVulW8X4q/zaRO17CGFxK/jfVTNZSFcE
	 xB+DQ4XkdoPb48ye7qWtNlxOsv8VzVY39HIkbDJcWa3To2Ovsp3ABJu/k5FPkrkUIGoRn
	 ib2yvaGEbD4KaHhMtMGgyTFe/NBjle9DBSj0ib/6viMQlRVjLvzsvnOY68C/k6G4xRWDE
	 r2cifHVer2WZhTM/HowNTxtCXhjOcohQVbB46vL73v4EzF/bc4W2UFMUdFIlpPS8O2ZAh
	 a5KssTj9m9CjrQgWCK8mrvqTy/BQ38cyLO2mGDy7Dv7wCoutlvn9NVwxwitopVOfOIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d8p7lDtqSWp9hcD/jDb+a5iwCIgUzEOBbTORh5GXWgU=;
	b=DHjQwhHvNmt7BFfbxLvYAkE/kN/RxqHNYCrcW0qYxqlhD+dMzjeg9zC8ivQbSjACNzDh
	 1BGOXqy4UnbeguyiRL/4vevaOmFm0Xt0kUHx19fHx0xWyY2bX2V6LXQidNV4XaEJMI+6G
	 zYz67dpxkhgNMDo+5jCnHAWWBttdKMOWsJ4w/sR9MJp/5iHtSW5APTLfgD3Bgd6FM9krW
	 DF6IGGZtbRugExvzuxstS0BlKLTKu+7JlGhXMWtv4/CRZwsJniH0oVV1lPVnYZ7jY+8ab
	 H27+PthYFc5EdMCJesG/qqZKMMG+ZZy66RhCOPCgXJIue3c6/xh5hkaRdCpHX+GYQug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h+QmA9AR;
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE64A606A335
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 06:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE64A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h+QmA9AR
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c15ccd7fb5so2415149e87.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795503021; x=1796107821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d8p7lDtqSWp9hcD/jDb+a5iwCIgUzEOBbTORh5GXWgU=;
        b=h+QmA9ARrJKNULKcXhbLT8ygEDhRbdeSxV8qOOPUv8AKxQj4QWmtSfZwKC1x4+S/27
         cXyb0NEMls1pQWzOn4//3TDka2xC96HbfM6jzVxgjVJDE9pfbqI4i7IbJbudsSiuTUXx
         X0nXYjWSJoqfvtPHlhRRPvNyv/gemhkTcSz0pU6T53XsLm/oOg4Nh6Wz/N0dK0RrpY3q
         sZftxciC5khu/Joqg/3KJyopW2ZctWVviQCP4uwY/4LxdROEyxJftmTw3cL7GwTzsw59
         t3EhSbFSb7cUTcBKvrwyLoGTh2uX+uZ+ksELYmVKFepuXEEIBtrqHCw1HZpZzAXfsSkh
         DBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795503021; x=1796107821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d8p7lDtqSWp9hcD/jDb+a5iwCIgUzEOBbTORh5GXWgU=;
        b=mvhMU+oXYj8QcKJoVcOcnrz2qaiDf1rgvwaR0VNAyYnvyFGWRbBUU7iGcbBdLNQjdl
         WWQHg9g+DV3jvnO0blXqWJgL83UEGJk/AHkP2koiQYjN5QlmK8b4uLG9FiUtFYwaQA+j
         qTJBe3UH5DH4bscclqlp4x6kjkJNh/7/GLXYu7TwUkyIZsA76Rh/VLuBnPteKD2MovV8
         n5cYXl01NBoG3okPhA+dI+TToyiuV+MRzNIgcRn+//lIAdIyyhuLGeBA27tiZXca0Jkg
         +Cda6fE9F+xaGHZPNPdgzoMNY5Y/mZpMuz7ilXkUQSxZWMTTnZSoKaObyVtTDafnEGVv
         TC4w==
X-Forwarded-Encrypted: i=1; AL+hErGBwCJzwCpGIYNwSU+sdNb0CnbbaJG1A4tRTNgqIjpu/N9+DbOEW3KoodmKeuoDu8ktFkK0FV3PdeA=@vger.kernel.org
X-Gm-Message-State: APuU4Z80EJvjBdO6JdL2OFRDk6y7DT75GW3IQqLA+k3H6twDy4TMm8uK
	6LPKh8IA06nkJnJCGjxFDqDEwFD3ucjXi9xHY4I5WMuIMIg8mKa+bjeN
X-Gm-Gg: AZFdTZeGnmGz2FUYjITA6theqy6nvvJlB4/Oy098Dje2r8atIKmgYjxrikDQh5Wc9h/
	4neHgC3cULtRcMrkVWqp2wnvEoBHlLhyhpgEpDnHGK3COZf5TBqObpX9CeUuRfDS/KjN6h3dG1x
	gO9w0nZqmv31CqjHkTuldyKxrH3XyRZRXrYc+PyUGHrtVNVKDRQ+CIo2+8M+Jk7fcNLuXZAWhHd
	vzEtDWvrDNgwWFjjE82LuXw8t6JF4p7tKhBkiBGb5clyItUF42Q/h05GCSRH4lgVvTANQbNcLwD
	Sg3PSL+MT3AQkWRrG+/xZz/95LgZ2zyB9/EYR2XKHOPBQyzrIbSOQoHjRiby9MEt8zSjKlY31V5
	vsohKS8MJMsHnRJypNDdoq9+OCnFWP302uWQ8aPHPJCGJpn4bQ8lca1rU0g0SANnU8+OTMFWNRa
	CWKof2OaIoz/oGVRTZxzmk2SClGImy8ytF1agiupQ5kOdFEu6ZR6vg8dhMHHNiKtYijx3SNZ8Nw
	csrOsToRg0fsOyzGpOMd/opIiXzRpdIef1maLXUQkQNx7/mo7Ck35ITS/Q8FCqjEhRfFplpbHbb
	kA/kwFh7kpnAx9B2djJD54jn4+ru/0Q8oCnVgTuSTUJRP1boZSfzMt/6pRKKKA1E7puLpe4c0ma
	4B5giSnIHpNtPjIBPuwsHVF7Gxnq9XORV6H0u9A==
X-Received: by 2002:a05:6512:4207:b0:5bf:ce41:b440 with SMTP id 2adb3069b0e04-5c1bc7d6de5mr3651594e87.31.1795503021012;
        Mon, 23 Nov 2026 22:50:21 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd018b45sm3538556e87.41.2026.11.23.22.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:50:20 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 2/6] iio: accel: adxl313: use iio_debugfs_reg_access_regmap()
Date: Tue, 24 Nov 2026 08:50:12 +0200
Message-ID: <20261124065016.185124-3-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124065016.185124-1-zoone.rupert@gmail.com>
References: <20261124065016.185124-1-zoone.rupert@gmail.com>
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

The debugfs callback only reads or writes the regmap of the parent
device, which is what the core helper does.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 6dc918c4ae17..c37bf11d77d5 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -1131,16 +1131,6 @@ static irqreturn_t adxl313_irq_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
-			      unsigned int writeval, unsigned int *readval)
-{
-	struct adxl313_data *data = iio_priv(indio_dev);
-
-	if (readval)
-		return regmap_read(data->regmap, reg, readval);
-	return regmap_write(data->regmap, reg, writeval);
-}
-
 static const struct iio_info adxl313_info = {
 	.read_raw	= adxl313_read_raw,
 	.write_raw	= adxl313_write_raw,
@@ -1150,7 +1140,7 @@ static const struct iio_info adxl313_info = {
 	.write_event_value = adxl313_write_event_value,
 	.read_avail	= adxl313_read_freq_avail,
 	.hwfifo_set_watermark = adxl313_set_watermark,
-	.debugfs_reg_access = &adxl313_reg_access,
+	.debugfs_reg_access = iio_debugfs_reg_access_regmap,
 };
 
 static int adxl313_setup(struct device *dev, struct adxl313_data *data,
-- 
2.43.0

