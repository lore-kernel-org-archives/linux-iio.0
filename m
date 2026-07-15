Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887A249EB
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 00:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074804; cv=none; b=e0xQQqLx381YmWj+P51pfFdWtT8q51d2b8gdxyFkyApgChRhTuzOI3oRuniWWUFylS8UJwr73auGSQuYVUk7fahVE/DW1ymRH3s4nPsXvtFVkxTN1FsL/ny1VFHS+kmssL9eRL/j2CmnFI8iOFUU8wEC5mtuqxe9NMzRiR4CH3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074804; c=relaxed/simple;
	bh=Z8GIy77JBX2RgMhUKg5pNwcJvDLIEJ7sirso5/tXXkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a59OTEExN1TC4zEGo5TLy4byZQzZYNzA8G99U0eUxKdWRGrSfbMpBb12mEubxLFjfy59jcj95tLjQCw0CMWR79T/NX5Ia+L54/SArm9oAG+Vq8Jn7PcUdGsQJ6ylXQrvuKP5Zi2A+E5WNcdkV9dYkyy9s3to1+Tj2YThNldu9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=A7RWIR41; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="A7RWIR41"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-451a49abd8aso1039946fac.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 17:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784074802; x=1784679602; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RCoi9uCgQDu5SkFAtNvA3J7+0TNFWtW/ZxbaScpId0E=;
        b=A7RWIR414PBHHH2PL8/lDHMLm1gFhM2H7GV5Xr5o5Dt9mtFEVyfjXnE+WOglYWuMoh
         fNk4J8RBSR3fFQjl9GQUV4HyeX6LdiWK9Bh49UvmcduZRQoy8u90haJoA+lmhW2ja7GM
         SkulE8MawnUaCjKo8hZtCpPUr+TjvRudhOEqPnXmYFrKsf4rLc7sF+M+GtR+rJhnCTcO
         oRUMSXkJ5B9ZPcniH6iU5c9u/j3d1QhhJLnyUeCfHSr3s2KArmIHMVoO4E0ScuOXvofG
         TN65KAzDg1tUXDhkX4kaZc3k6LUtqtx2SDo0GvkAbTIPeVEzneXfiboylUf8IooBS9tc
         Jlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784074802; x=1784679602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RCoi9uCgQDu5SkFAtNvA3J7+0TNFWtW/ZxbaScpId0E=;
        b=V4tK3WeHpmbhIAnqsmTz1i8nYwjZw3wGieSrXBQceCOCohIS60CptEE9TNbnSQWs2K
         nkPYBYwfqIOzVAuoB35HZ9Ilky+83JpcFHcyo65Lw2F/AFtb7hN4tJ15DTGZ3DWYQ9Fc
         ZmmmDEKECDzyh+usa9rQBp3RgMzXPvb6WH1ToQ5uLOf3OGUUtG50jjNlHVKemS1ZnGVB
         zRe4lgTwy2tK0QDaTR5TWWo/GpQhJuzjaEo5eaecedRrzPv4gaQv35JSSTEJRP/5Ok6z
         N7/iNJb1DN7tiBJ2hHFD3vFjOaWxd4jh5n95jxShZ8zwJ71WLPuPevgD2cgMTtCQSIkx
         XZCA==
X-Forwarded-Encrypted: i=1; AHgh+RpGH70AgnYWjsFpApzhC/Z0f/JrjoNlD3cIHGn3/ne5z6Jtd50lQBUkAe0SBV/2q2rwP23HZ8buS1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5RUyvL/2oibdC4fVHsqaQI3hsTQ8zL11gThbLa/nCCE5+QEIM
	3i1sj7mD6A19B6GCVP2kJ3i2G7CJ50zy/mOVkwkhgLsTql7c5jQh06TmDZbcFJURUYWJ7wNCXQx
	1E4TU
X-Gm-Gg: AfdE7cleg5UF0ZIUVxM04mfcpMJgK6W77KE/bLqMDRDlFwJID/+C+zDo/E3u0yA0UGA
	4XOV7sHTkk/HQEjpp0J2hOUgYpA9DAnVI9u1DFEAtBjSZVVqXSufT/t//F3vsNc2SPDeJWK1yXA
	rgFxLZbcAL7K3xTDc8FNN9tAeVVB2ZEUfgH9URgl9qdUFSfi+sUpKbBbtbW0kL2XV8HUKHPYQ40
	fQ3PwfWCYrVXtyTrskN2bSR53VJRsLdMM6uEejmksShK71hijfDlyoh96V1p8GUzX0gW6/b1IW2
	S2sTj39eMLCDEA6y+6BdHBDVivFbTFAS0LFcagW9oJRfi7sKg3hqlUJr5kzr3U2c7lkVRX1WK46
	81/ORYuRRJaXIAwYQ4VMGzzsTHnguvyclMI5wQCKvZCrGO2tjWyR4CmrsfbQ6nO4ZRqF2bJ6GRn
	gX69i0ezRYvd7ZlqoXhA==
X-Received: by 2002:a05:6870:ac98:b0:442:ae3f:f22 with SMTP id 586e51a60fabf-451f13dc06amr9651604fac.23.1784074801906;
        Tue, 14 Jul 2026 17:20:01 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-455b767413dsm8047305fac.3.2026.07.14.17.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:20:01 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Tue, 14 Jul 2026 19:19:30 -0500
Subject: [PATCH 1/3] iio: adc: ti-ads112c14: add debugfs register access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-1-fe6e1c971288@baylibre.com>
References: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
In-Reply-To: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Z8GIy77JBX2RgMhUKg5pNwcJvDLIEJ7sirso5/tXXkM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqVtIcQZEdpJlL/5mw1kJ7SXeLd8OsEOHNjaqAh
 G6H5lFldFCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalbSHAAKCRDCzCAB/wGP
 wPMlB/kBcQ3XkqIeBG+gYLd/jRSeLDzWLlP1CKQuO90Jy65/ShzcikD127w8MzFn65TNA1Gr4oD
 Pvti7azHW7F9XyEDy4zdjTmwQflE3KVhUTQmTF6Vc9FqKafhdrbyEBFFtyl8UYgOQKyWoYL7+Sj
 OjXfXNcy8uhjVjuv2W8oycOgmvy2+K65Itno3TmI8JiexZYpizbGwLRF7y1e/vgcnc2JRlXVYXL
 caa65IiaN+Lwvv2KoOn93vw39UP3VTjaWrjCjXZmYvbwDRs0ZguHTJ1ZZujC3tzZGUR1WBP4LdI
 jAVjgZXv7sruJaKlLks+k/7eKK7R/Riwvg1q/kvWYwHyP7D6
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add debugfs register access to the ads112c14 driver. This is a complex
chip and being able to poke registers is useful for debugging and
diagnostic/calibration purposes.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index fef3a9c37ced..28824c81908e 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -690,6 +690,19 @@ static int ads112c14_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int ads112c14_debugfs_reg_access(struct iio_dev *indio_dev,
+					unsigned int reg,
+					unsigned int writeval,
+					unsigned int *readval)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+
+	return regmap_write(data->regmap, reg, writeval);
+}
+
 static int ads112c14_read_label(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan, char *label)
 {
@@ -736,6 +749,7 @@ static const struct iio_info ads112c14_info = {
 	.read_avail = ads112c14_read_avail,
 	.write_raw = ads112c14_write_raw,
 	.write_raw_get_fmt = ads112c14_write_raw_get_fmt,
+	.debugfs_reg_access = ads112c14_debugfs_reg_access,
 	.read_label = ads112c14_read_label,
 };
 

-- 
2.43.0

