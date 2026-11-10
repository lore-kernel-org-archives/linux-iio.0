Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319487;
	b=RQ2MzSA1LTRqvr9Cyutolk7VIOe44V7JbPISaWrFBCOk2mPJ7nTwDjEkf0FrZiIWjv4a
	 eHRyDMSlWNrc5dHQ7Cy6hkifzITO/h3hB/7sjxlmQQg8KN8XdtIJ2iH3LbB8uqRjfFXSN
	 E7LAay6gqBDX2K4N3pX762ENTYqrHtaymE2b5aJ1y0R94Zu9iIWzMZPNXfZqd7JwHvuN9
	 h6wwFu3fW9tUirY/gK1nHg7EIGHG82NZVDsstoPpD5w93ktfCtS/QGD8x+nkx5CwR8hNs
	 98ZYHXXS+9DkE3Fqv7sorppjZg/G1wZeROBFVhaf/+h/eikVFF2wgy0FWwNnO27G00w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=418qL2keCn/YC9lRyTTJ32argrNbioPNqzsGFZM0jp0=;
	b=jXL3EKTNnw6wxQTmejK2uPBcqoSstZZ6DtyKXZFvnp0quL/Vtw1y3tkhjwt6hlAuY86g
	 iFXCiXKhJrnGAf6gUeXdF3jhaR7qQJD5Kcx9XtLgRN7J5jCmrHJRpjRDDdrkOId1NS1BE
	 9l/1fClFGjfnDv36Sn+BlcYmGO+aEj2LpbSVJzXjUxBgFDzvGZyjrXIU95PSnDQSQ+cc4
	 gU9oUwkOeZDKu/gu67yIaM+0Kw0NVAgiJ9sdXU5kRrpsDHxzBW+esvdPXHVCZbx3sppP8
	 pNBNcOws8Cu2O3N5BjAbJD6fIqFWB+ntQxbmHNIyrxg/vQWCaPcI4lwiB3EYBiElBJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vWtTmGCr;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46260A260A
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 14:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B46260A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vWtTmGCr
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso755806a12.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 06:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794319486; x=1794924286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=418qL2keCn/YC9lRyTTJ32argrNbioPNqzsGFZM0jp0=;
        b=vWtTmGCrwobFP4zJww8Q+XzfMCl9hyZEiswN2YzfeLyaZY+ThZgKsYFihWrzRdrF7V
         SwcsnfuoYO+jpoLlnekqtsQFMxUDvHewDr/dYNu/eiGhKpQg5n3vPGWj9sT1jDhNFWZ3
         B9tESisHXDW9JO6kvF3mg+OA5+edOc5ljNGp6fsEb0fr3zIzuDbGIAl/3Gwdgpbc6EM7
         g9FJ8LOEYTpTlGif5N9inWvR5ST7Ns5mEZZbF3eLripB0v9gUYhkvfPfFG4frDaAQg+I
         I8AxymV8Zruu4E8L1ERDWepQ6Cxsp2L6q4Xir/wauUyPAFl/jVpumFuCPcybwSt8INhY
         dvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319486; x=1794924286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=418qL2keCn/YC9lRyTTJ32argrNbioPNqzsGFZM0jp0=;
        b=YphzXLb8lp3ODPDwPQRsV1ntYBFJswHkOFkNi/E5IafOYC3z19hObt7lDNV14ZXJej
         BZ0ftmVE3t8qfUwGMgj55teyH91YRBNTp/DTxzeaQ2xsJ5audWq3qxV6kW9SbXkjmjMY
         3QxsUIwiKoFVNtwg6XoDrdFjmIO14yqamUAKN6NXbYRj3q8vJDa9XBgvroOZUfUvOFxU
         SnoQl/ZU4jaBjeskFVvvALJfqjQ9obg7Hx0sQgkISdicga8mRNPwsWHr9GVv4twhDXMI
         VHcuA21/QIXEVQD+bQAPKUXWXheNDUojz1Ji5AHn+u4WWdJBzC/I4RDY3lnhcWjCRXFh
         dLWA==
X-Forwarded-Encrypted: i=1; AL+hErFlL+B11nnTSUw97FbjO9z9s3OxRWgk0SGAlwWdJ2jFmM/MXD5e6cJ4xBbmU+WNvc0dnahecm1tEcU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8B0fUaVVbWF0zRMXtB7iCPgJ0dfYGKo15jSZ6zRMkVjsDbnOBp
	feTP90kbuA1qf/Py0rquglqhpJt2lep+OMYIpocF3zv6wEsV8VC3mkBC
X-Gm-Gg: AYBFou1o6ajXIT4O4p+8raoprCIcNmiU51SkTrm9YMvByYnIq2VepMqIA+pTU+qtkPv
	gi35n1tYD+whJEK0dJfdb8Puml1we5vkAzSzqdeQy5lLxaglig40VucZauRuWrM4fHLcWKi6j+6
	/nHVXak3ZXDa98guLwAzN20YCadOUAKvqxdIAl+hUdd6O+2Jnfo3tVYKrIatojoRrnUXhLzf3UI
	/hv1yCnFA9WkdeTYXS76P80CPxVk7iDsYmBOl8XrMZo0/8lW7IZepWLZlL/mXUyA2png5B6r4jp
	5fQb17RnFnJkF7qSz7ZK2y7ixyAbkA2RqlzIKS5r//8sX4dIeU5A8X0eeIHFjFM60y/SIqbQ7Bm
	JGCiI/BhvBJmCWBw/D2mq85svux2Kb8btZSktgAeVNhEuL15nqFGLzPoRtR96lZWd5Iz8Ig7SYf
	idtFDjF8iweRghkoRHshDa2N/Oh9fFADQrWfWH9440IAQD3LHl+suCEa5fnH8f5pkXZ2q08ihAy
	AaSQrfEuccRA3qshlNYvOEfT7odPz38mjtEijYaV7k1OnyZAHJP2oDSYP4lfSyL76Q/G/SSzWKh
	9wK803wIafkCRAfwARQnpla1LTBuz+ntPsKYnIyKsr0+gvqtAyI/oS9Ca+5D
X-Received: by 2002:a17:90b:1a86:b0:3b1:2810:dfdb with SMTP id 98e67ed59e1d1-3b166d1edf5mr2895888a91.48.1794319486272;
        Tue, 10 Nov 2026 06:04:46 -0800 (PST)
Received: from LAPTOP-6IS184GT ([104.28.251.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16903edfesm1875444a91.2.2026.11.10.06.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:04:44 -0800 (PST)
From: Nick <nick21042013@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nick <nick21042013@gmail.com>
Subject: 
Date: Tue, 10 Nov 2026 20:33:54 +0630
Message-ID: <20261110140354.2047-1-nick21042013@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
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

From: Nick <nick21042013@gmail.com>

Date: Tue, 10 Nov 2026 19:57:26 +0630

Subject: [PATCH] staging: iio: adt7316: fix camelCase violations



Rename Vref and AIN to lowercase characters.

This fixes the style violations and brings

the driver into line with the kernel style

guidelines.



Signed-off-by: Nick <nick21042013@gmail.com>

---

 drivers/staging/iio/addac/adt7316.c | 12 ++++++------

 1 file changed, 6 insertions(+), 6 deletions(-)



diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c

index 20f6052cc..a71502cf0 100644

--- a/drivers/staging/iio/addac/adt7316.c

+++ b/drivers/staging/iio/addac/adt7316.c

@@ -663,7 +663,7 @@ static IIO_DEVICE_ATTR(da_high_resolution, 0644,

 		adt7316_store_da_high_resolution,

 		0);

 

-static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,

+static ssize_t adt7316_show_ain_internal_vref(struct device *dev,

 					      struct device_attribute *attr,

 					      char *buf)

 {

@@ -677,7 +677,7 @@ static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,

 		!!(chip->config3 & ADT7516_AIN_IN_VREF));

 }

 

-static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,

+static ssize_t adt7316_store_ain_internal_vref(struct device *dev,

 					       struct device_attribute *attr,

 					       const char *buf,

 					       size_t len)

@@ -704,9 +704,9 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,

 	return len;

 }

 

-static IIO_DEVICE_ATTR(AIN_internal_Vref, 0644,

-		adt7316_show_AIN_internal_Vref,

-		adt7316_store_AIN_internal_Vref,

+static IIO_DEVICE_ATTR(ain_internal_vref, 0644,

+		adt7316_show_ain_internal_vref,

+		adt7316_store_ain_internal_vref,

 		0);

 

 static ssize_t adt7316_show_enable_prop_DACA(struct device *dev,

@@ -1684,7 +1684,7 @@ static struct attribute *adt7516_attributes[] = {

 	&iio_dev_attr_enable_smbus_timeout.dev_attr.attr,

 	&iio_dev_attr_powerdown.dev_attr.attr,

 	&iio_dev_attr_fast_ad_clock.dev_attr.attr,

-	&iio_dev_attr_AIN_internal_Vref.dev_attr.attr,

+	&iio_dev_attr_ain_internal_vref.dev_attr.attr,

 	&iio_dev_attr_da_high_resolution.dev_attr.attr,

 	&iio_dev_attr_enable_proportion_DACA.dev_attr.attr,

 	&iio_dev_attr_enable_proportion_DACB.dev_attr.attr,

-- 

2.52.0.windows.1

