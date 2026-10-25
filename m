Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792951409;
	b=lF1bZ0+CAjD/KTDkfen4VBvM6Q/3yah/yT5cDDen17rRFgdZMhFeugC8GRdXE6mX0Nwe
	 12k5jCqkuPTjzBIHLfAgj1fK5d/Cq/J0NVNP/n/ow409NM0p9zC3Wg2Rs07Dgxun00wrA
	 cRf2ZqomXsDeEZHa9zKLP36M2T75tSciatBY/ulvKWtkEEY8t0v/EmNDgarstyXEOiR2g
	 udBYpNVQxs6rYLmEOtDseaUUy8DLmL87E8ed8TSoxlusgpiY82LErIw+oFMGW326VJj9r
	 N3141mdhaRaISj4quC2wCKNvB7t0dG4gz4AG5qIGVfAPeFv+nsM224rhsrbr/tCT1OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FuQYvevBom22bTnzSsTpOFkpY8t4qr2tg5E7eW5T0Y8=;
	b=KzLrIX/oC0Jq9zr1wkRn7f0XtAw5cu+nFmxaLmNmrAfvdtKlxCHfb4oP9c9d4Ue0G4+Z
	 Y78MXQNWIQJ2f7Ox8ME3CCKcW/y0psOORqOIZKeV9Kt45uWLkWQkdu/QbQfOadAGyYVFt
	 yXzIC3FC6wBnbyjY9S0TMYMoReVmdhBpPBHYj61jhjre0YmVhJGkrm5YjM2Q4aT/IXVwP
	 61V/SJzCrmcHkVZJv1+Jps1/RO6WMLMAerGxx7nEepI7T7mXf+ZqEqIboVGz5GsfWEBgZ
	 yEH6o20uHC3+Un3YfNWBZj4d9x4OLho7bxT+ZsNuY2qlfxVFCZ1m12n+vYZU3jltEtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SjwI2lnG;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B53606A331
	for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 18:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65B53606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SjwI2lnG
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so13000765e9.3
        for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792951408; x=1793556208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FuQYvevBom22bTnzSsTpOFkpY8t4qr2tg5E7eW5T0Y8=;
        b=SjwI2lnGWsinoP36jfi0ElwFZziJ93zTgjc/8QgRa5KztbBQbZawlofZ7iG+//j7vY
         bScv9n6R5wwlBVJmwebpIwQVyAV14rrLJYBTR6WqU743VDO18gsggzmUenDyw+twCZ9r
         A4qMbuTpOCk0EJTGdGomO9wqcsfMs8RykGTU18kRjzpH/i1vnr8irhYU2csD/kvLZrX1
         A4EyaDB8D56X4uqGMx+tMcjpQbx53lsjuqRt8fyi+ZV7nkmZwAVVEjT1BM41GSz8+uLt
         C5G7OuuGM6ePEkyWdb9G08Mnz2spgI+XdGeVlawZJBc0oAWkhAISYbxQPJW4qIdJ+kN5
         EKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792951408; x=1793556208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FuQYvevBom22bTnzSsTpOFkpY8t4qr2tg5E7eW5T0Y8=;
        b=G8kMe/b91uEWB0AIkTTUS1lYYwxN2yV/U6lFfUZQ0qj9b0ywBKVD7Dy4OGWE73Q5nQ
         RMN1YJ3y3z3Lk3bRXWghW/TtbNsL/xoEJXbnjGFUooacxWhiG/5/QQsaZiJbmZCYe861
         ZvQaG50pL+akpcAA6mXeRj9/BjhIr8ZCzg3CkU5skNVKkL37lOE4rP/BxLzNZ30LpH67
         Bm2ZdFZWs4iZ+LwvUkulaJMp8J1C3AhoSGWaceHB7NDWEEUzyWsd0PDvwK2Tvz0mT2aw
         G6lZ7gUmyETrQywhaVzqIvTFWFuI+ng1lFusicslY1uDrxUNc7jnJITKws37YW9tHdXg
         euoQ==
X-Forwarded-Encrypted: i=1; AKwUvBygPMJi3ayFxfZ1wkMD6XJw05SxOxAouye8zAF38gvs1x8NdckUVReZs+YldHcTVjqnejh0Lv3+HUw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLR7LMG4jd2ymPjcmvnZdAD6WarHTHqF0XqyAdUrYKhGN0afm4+
	RdXy9MirLg55h110RsXR1rvECZ9IKcqyZvsaeyXG0xUAtfeoU0RxBHg=
X-Gm-Gg: AYBFou0nTWp/N0Qm8+PDE8g8j6fUAFCKchgYALXqCQkPqZNt4raC/ULVgcZ1LIsakof
	r618Jrc2Ejtti9ldGsnLvyKMKKgMRFgKpvgjL2J2zdwfZDyJ4YO7xpyi+vI1BFIC1Y19FrML3ta
	YNsFU6vITCpfUZThU2UXpsFBWKvIcvOz+LChSl0qMvgX24bBozfyj9gFONyanGfE4n7AB8eb6ua
	94wjwf1enTL+AHrMFTFX6pVj5WtRNP9x/li3eAPRZnoEj2CcHKAWIXwSxWGFFjxgC/VDCSl7oCm
	F1i4EUr6E5IzsK2SUowk0h3e+5ppwnUdU2eoIl3UnsxN5+VCY9CfLTx1hJQAgjBgP4S9UPQCz92
	9dnhWiDUGMXzffhFfuyLvum/gxR5gdevt/yYecJMj0UUAhKMSjTyW5t+e+6Pe1O32hi4vpK2yE1
	RrwqpRK5sgPPIqZpVsZp9Ok5ccQaPtE77jj1KA893oV4nkDceB7qPhRPaFVWh16pBd0/VIaM9AF
	jk3HnPew6Bp0rlYjz+u8F81QJve+nX/zs4iuQ==
X-Received: by 2002:a05:600c:4ece:b0:4a1:6517:ccf1 with SMTP id 5b1f17b1804b1-4a35ac9d116mr83202465e9.9.1792951407729;
        Sun, 25 Oct 2026 11:03:27 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a4cb7bece3sm82641055e9.10.2026.10.25.11.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:03:25 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] iio: imu: inv_mpu6050: validate ACPI object types in asus_acpi_get_sensor_info()
Date: Sun, 25 Oct 2026 18:03:23 +0000
Message-ID: <20261025180323.3641477-2-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025180323.3641477-1-tristan@talencesecurity.com>
References: <20261025180323.3641477-1-tristan@talencesecurity.com>
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

asus_acpi_get_sensor_info() iterates through a nested ACPI package
structure without checking types at either level.  The outer object
returned by acpi_evaluate_object() and each inner element must be
validated as ACPI_TYPE_PACKAGE before accessing their package.count
and package.elements members.

Add type checks at both levels of the package iteration.

Fixes: a35c5d1aa96a ("iio: imu: inv_mpu6050: Create mux clients for ACPI")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index 460792ed27e03..81fe1d96365b4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -57,11 +57,17 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 		return -ENODEV;
 
 	cpm = buffer.pointer;
+	if (cpm->type != ACPI_TYPE_PACKAGE) {
+		kfree(buffer.pointer);
+		return -EINVAL;
+	}
 	for (i = 0; i < cpm->package.count; ++i) {
 		union acpi_object *elem;
 		int j;
 
 		elem = &cpm->package.elements[i];
+		if (elem->type != ACPI_TYPE_PACKAGE)
+			continue;
 		for (j = 0; j < elem->package.count; ++j) {
 			union acpi_object *sub_elem;
 
-- 
2.47.3

