Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595053921D7
	for <linux-iio@vger.kernel.org>; Tue,  7 Apr 2026 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545271; cv=none; b=l12TB/kr2lujj7ouybnuJFU0+Mfr/KYBW+V8OUzyswGxd9jlJj2Jti070lJMKi2MLsn4nBjeniRsIY6NT2PctR2kz8RCZ142yCK8boZWi3FGM+vBIBTiNFGGOqWaEyB1n3NdoQiU1t8R3JTzV6SEJ5MN2xNH3Ahst9h0pQ5a8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545271; c=relaxed/simple;
	bh=bMBU/Sp/Hd+8dWJzIBSChhEWAq6h8QnFVVi6t0Td8CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSGTUK2cymTFd310b33EnCSovIEHVA7IMaNJ8vuCp8XE9DFo8o1i3sVVn30G1k1vVIyOSc4GAwqIfHu4tSZDZbdIGroIum6qhoVV1L8f951bqJ618J5iog5EesO7CPVqb6E0eDx3z9YngW53gY8J+uYoqP61az/SJqxd65R7rqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jv4wGLU3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv4wGLU3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so24074955e9.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Apr 2026 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775545269; x=1776150069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7ul7R4AdJ4kZnhxBsfC1ozDk40Au8wWcQ7o5oSGrE0=;
        b=jv4wGLU3E6ICSsU2CxpV9f9xARYR1eLI45GQ5MTNBsltAIWvElmcKi7oALKp7lss9G
         ybbGsnTtNMoYP2sZ5aoDW8BICJ+pkenoUq8/L7P1y9jJIf2oGYIV5GI6FSAcZ+AoPVL2
         NieuXzVKXIK6GX8nRD+KlxqgdtPdbhmIV0KuQpvmGGqtIqIO1lzCQwLaKvdyAR3bTAUm
         r0nC11tmEM9p2BDm5sm5i/85/Q9VZvmTa05R/wjQuMypo7oCVb2E5N30ZJvo5biWEMjm
         eniaxydYeq5dFC6yEBjz9m5wHOsdlV721IJuPOkTDc7xu5jfPF1J9S+aWn+XoTEiaK8W
         1ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775545269; x=1776150069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7ul7R4AdJ4kZnhxBsfC1ozDk40Au8wWcQ7o5oSGrE0=;
        b=c5lEzExpEUJTywoHIXDUMSWpgC1P+mDwxC3yK0+rpGLvmVTYlpfhK4nX1VV/hHyrEZ
         Urb52HDNR4w5Z8mxUqgHMM1yUQIJuwSN3A76+YULCmgJ9fyTH1uiPG0XfBnBItw0Rajl
         N/ROMGesW4J5MSNZsqWdC0RDUlG0q6AXSZosdJkAQn1+G5n3KDTmHdELRRn7oienJnmR
         bCcso04fm2DcWpalC0qSsAH6pw3Hi3GVNCBaJA3E0p9/3clU6I9o/dZf5XkAJmJSsIAQ
         LaQ1SaC+dbub2Cq+8kame+4GJ1AkmO5PiPldaEJVJZkg8vUXSGvqY7Hfe0hS46bI7EQY
         WMlw==
X-Forwarded-Encrypted: i=1; AJvYcCWCyaWXNioQTKg+xE5M4WkC4U42TlXgYJqJifLh0c+P++v7nKtR7VpDVUXNZlZb+FcLxusDCPsepGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUoQhQ3OSu5Q9p+ii2zhxHrl9H8JP51nAQpwLNX8Tv52sO0gZr
	DqXsiio2RiqXkIvTn0QP/QyK8H999x641XdcLw6OHJzcl3Rw3aDXQBZ/
X-Gm-Gg: AeBDiesZUiFobJvH+wWPQBI4hBv5pSsri22zR/8tBGvhajZgoqe5QWAilxm8VmHc/0l
	tgcpL4jtBXWUqbp9uLjtDi8JBKVIZIVjkBpgTjMVZNhDD71sn+uTiuUkev+w2C8I8M5K/xXWpGC
	HvfG5m1YEQlZ0gvg0O1vdwx/rgZ0iim4097YtHEowYxu84vZq8gudXghFc0pU4lzobdgHUUqbXN
	HYianEiXHFTKWjlB5LJ+Lf/JY5SQP4BJLZA1aZ6mf0p6Olj7kciMQNYH2J7T7n8GazJyfdSXl5B
	KcHYV0iluvtFtqoFiC99IHTgjp5Nsv4dIRfBRGRN0lNUxgchL8S0grpjI1/woANRgBjHA7qOQ8S
	2NQ/r7LFZnqyUuxSFY7sWdkyczuS2LDOWRfTr2XXx9nTZWElSr7tACk4nK+sUOlowbGz+Cbi5za
	zvMvXgfLdQu7Vy4hYRG+DPziwnoWDa9NiA9/N/dNM2GfTuMU6ESR9W
X-Received: by 2002:a05:6000:400e:b0:43c:ef4f:79dc with SMTP id ffacd0b85a97d-43d2927ff7bmr22786558f8f.8.1775545268585;
        Tue, 07 Apr 2026 00:01:08 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5253sm42167576f8f.9.2026.04.07.00.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 00:01:08 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: ktsai@capellamicro.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	daniel.baluta@intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 1/2] iio: light: cm3323: fix reg_conf not being initialized correctly
Date: Tue,  7 Apr 2026 09:00:52 +0200
Message-ID: <20260407070053.9359-2-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407070053.9359-1-aldocontelk@gmail.com>
References: <20260407070053.9359-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code stores the return value of i2c_smbus_write_word_data()
in data->reg_conf; however, this value represents the result
of the write operation and not the value actually written to
the configuration register. This meant that the contents of
data->reg_conf did not truly reflect the contents
of the hardware register.

Instead, save the value of the register before the write
and use this value in the I2C write.

The bug was found by code inspection: i2c_smbus_write_word_data()
returns 0 on success, not the value written to the register.

Tested using i2c-stub on a Raspberry Pi 3B running a custom 6.19.10
kernel. Before loading the driver, the configuration register 0x00
CM3323_CMD_CONF was populated with 0x0030 using
`i2cset -y 11 0x10 0x00 0x0030 w`, encoding an integration time of 320ms
in bits[6:4].

Due to incorrect initialization of data->reg_conf in
cm3323_init(), the print of integration_time returns 0.040000
instead of the expected 0.320000. This happens because the read of the
integration_time depends on cm3323_get_it_bits() that is based on the
value of data->reg_conf, which is erroneously set to 0.

With this fix applied, data->reg_conf correctly saves 0x0030 after init
and the successive integration_time reports 0.320000 as expected.

Fixes: 8b0544263761 ("iio: light: Add support for Capella CM3323 color sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
 drivers/iio/light/cm3323.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 79ad6e2209ca..0fe61b8a7029 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -89,15 +89,14 @@ static int cm3323_init(struct iio_dev *indio_dev)
 
 	/* enable sensor and set auto force mode */
 	ret &= ~(CM3323_CONF_SD_BIT | CM3323_CONF_AF_BIT);
+	data->reg_conf = ret;
 
-	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, ret);
+	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, data->reg_conf);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_conf\n");
 		return ret;
 	}
 
-	data->reg_conf = ret;
-
 	return 0;
 }
 
-- 
2.53.0

