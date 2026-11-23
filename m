Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442170;
	b=olr3VfVwxFJNU2O8yIc62eKlrr4PGro0Blj4HYaVqo3zPYuwAwgS8hDGMO/KKvbwi9RI
	 X9Do27Vu2j3ebkJKHYYgdjCuclcIj8F33B7C8ry3g6I2KMwHWrAU4pR87dmN/2JGkbkTe
	 9U3ipEkfdcekzhRM2vcvoTOGADyVSNeR2MHWPI8suiiAj0jQI29am+JCMs88df9VaVWFK
	 3xs7w4U6DE86XKrAB8vSn3QPAJmvV7/HDEQqnmjkde2pKPyAzrvJOIScu1lmLtfH1Lj8C
	 qvgVag8T7OBcE4OU2MsCsqjLKMuQQkdK5sEnBBJaAUcqjNlK23aHWcXDmNWnsXXSbnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/3guNZf13G5Yw7QIG/YFrB1eETKjUH1IhjAgvye9rMY=;
	b=M0pJrD3dmIS6xjhWvqVoZx3IkuA2GvpJOMnRfcNFz6TxvnKjGrKAUJe+iWsAvH5IKOBf
	 WVim8l58akeXapIIKJpYEzbabE83i+EIN1Dh31pXyvYwCLqOu1VxiBJGEwpdZaarA0Kff
	 /jotXNkKB3xgVnaxKTzBX2xwh8OQ7M2/OYAJqnqPT3Fjn66OC/6Cv4gC9h+oYDarsvGUp
	 u7g/NxIn3HMEFKiePCuHsa5FWJYEHLWIsf3/9H9P/KMIuNfGA9NBAeqb9ePtoA3dMRgEP
	 FYpsGMBvAQGt3pF8YfeRoVcahnomEhqFRfPCP6VXkWG92PwkyZMH0m+6qSI+sXHOhGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwLhHpGL;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F32606A686
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 13:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6F32606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwLhHpGL
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-38564b4b017so3556962eec.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 05:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795442169; x=1796046969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/3guNZf13G5Yw7QIG/YFrB1eETKjUH1IhjAgvye9rMY=;
        b=CwLhHpGL2qIjFKjdQbxk37x5aPvtVZLifjT2ZE5aZHkMtUbY96dHKlwxrdOP1amngn
         kviOrn6Pjn1fm2XVArUV4joD62KCzRKJwDqTrCpHyKHgreZ7Ht+vHXbRWtzSMtXrYrUN
         0CaNQj1rt5gjQBipzX7cZTMN9hEQzuQO/v3+/t2DNwTheZi+vnPsV64z+e71UBIlhEFo
         UCZrOi4Q/Z+32CiT0e3NVwhzGHnpzFzkdUfCJvrd3C8i23hkPAr7g51ZX1gjfmnACqYT
         ATmSs7OhCuXCsYlq3k56K1SVgd4z7Lp/JjAxWft2ACpNp/gAevPinx+P4KzxXput4D88
         kAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442169; x=1796046969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/3guNZf13G5Yw7QIG/YFrB1eETKjUH1IhjAgvye9rMY=;
        b=kthfwSaC8xXnJq0OumVNlI1iHuAcWM2dw4WM6xaO7B/8PGl5LA+SGNx2SdPLTcP9dy
         X8iPHnyrsOLKcGN9tAYoPDIa4grmQCIlqPRF4XbOXAnfz291geoHyHPIq6p+l8d2Y9Aw
         93CZZsyvmJDnlBl7UK/9IwVX3icA5ba9uSZbz6nM4nmOmPH53GFHsxN0CQ8K1F/SSgRc
         YWNOBwso6YgEgOh2w21jkcaMcqqDn8PKYjCRCX+nefe9/TxNNci6xunMlGBtwGfLsFG0
         lxvgdwwWACN3RJQDLJdAVelPcIBLlBoD7J9vrjhiX4+SPmXm9gGyZKmrjrdpUy2uYR4t
         fisA==
X-Forwarded-Encrypted: i=1; AL+hErEBCz1NhHXKFghsMf8bxt36273KOCirjHcLKI04vPuue3zesip5ylrBSkx/gQe0hP41WSy2zrfNhNs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/L6+0QweigSfI3yWXo3bBxD5QuQeyIexYqynvZUAwktQp3dCuj
	bO+mxtiywl+/ggXZdTNxKdxsuo0zVHeFtfBJq324JBf88SRzOftIJZNx
X-Gm-Gg: AZFdTZeoNp85H+ue8JN5zn9O73Fa/MSjUPEGJpMcXuLUid2+qlK9wAe5r4ronAVnpwZ
	5STNYDrSDooCbesDYsiyCAY/QhaO3q88B4jr7bzIUAvk4AwF3ggxwz/u5NLfQFevNfZlB59CtBn
	RqbaB56DxkTsnaxbeerEtG1v+9cR31f1ghKxKPlm1tp3W0FHe5l4e1MpudmNPGfQs4DRPhT9ZGg
	ZBLwkSFdu2kkTpsfK+fhzJZpxZRes1e5W5VJ4DqGPjI1lcs5xVi3Sgs1XM3lduQTsbvEsMArHmk
	JUJPZpT1dBtyo/K5uAy+KBIAF6H9pn918vLU28qi6/8c2QqyrjGd0HR2suYN/4VYV5CGxwRVdq7
	HBG2QYhwIjajXRzj7pAnuCKC7L8vOEpyCwgZB4aB/yAlkyw4zQoSFojjgYVp+cuo9hpQLNqhmpv
	hWYox78bru+8aRai8K6bqhgk1j8hCi7xvSViyjHlxsLu/UTCy725wlJGoA6dkEjBXSAKkQp4ms/
	6LLgl74YiHkX7p6P2Uf3thBte9wDjJvtF63kCHpTjzeYGFcMRmcT+4OrX7laK8r57JoS2w+EmaI
	WjFS4xZCVmVJmi2V8n0IOxoKYGpaj/TDEobFvdjdJiJ80qJBxc/QsnI=
X-Received: by 2002:a05:701b:428a:20b0:1ad:1574:aa9d with SMTP id a92af1059eb24-1b5566e0ecemr11995778c88.0.1795442168534;
        Mon, 23 Nov 2026 05:56:08 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm29310267c88.5.2026.11.23.05.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:08 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux@analog.com,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Andrea Merello <andrea.merello@iit.it>
Subject: [PATCH 3/3] iio: imu: bmi323: check the config fields used as table indices
Date: Mon, 23 Nov 2026 21:55:54 +0800
Message-Id: <20261123135554.2983499-4-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123135554.2983499-1-maoyixie.tju@gmail.com>
References: <20261123135554.2983499-1-maoyixie.tju@gmail.com>
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

bmi323_get_average(), bmi323_get_odr() and bmi323_get_scale() read
ACC_CONF or GYRO_CONF from the sensor. They use the AVG, ODR and SCL
fields to index lookup tables without a check. An AVG value of 7, an ODR
value of 0 or above 11, or an SCL value above 3 (accel) or 4 (gyro)
reads outside its table. The driver only writes values that have a table
entry, so this needs a chip or bus that returns a value it should not.

Check each field against the size of its table and return -ERANGE.

Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under ASan and UBSan, which report
nothing with this patch. Not tested on hardware, only compile-tested
with W=1 on next-20261116.

I used an LLM to help write the harness and this patch.

 drivers/iio/imu/bmi323/bmi323_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index ebeb1b10c38c3a6..2a5c5b4537950dc 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1475,6 +1475,9 @@ static int bmi323_get_average(struct bmi323_data *data,
 	}
 
 	raw = FIELD_GET(BMI323_ACC_GYRO_CONF_AVG_MSK, value);
+	if (raw >= ARRAY_SIZE(bmi323_accel_gyro_avrg))
+		return -ERANGE;
+
 	*avg = bmi323_accel_gyro_avrg[raw];
 
 	return IIO_VAL_INT;
@@ -1578,6 +1581,9 @@ static int bmi323_get_odr(struct bmi323_data *data,
 	}
 
 	odr_raw = FIELD_GET(BMI323_ACC_GYRO_CONF_ODR_MSK, value);
+	if (odr_raw < 1 || odr_raw > ARRAY_SIZE(bmi323_acc_gyro_odr))
+		return -ERANGE;
+
 	*odr = bmi323_acc_gyro_odr[odr_raw - 1][0];
 	*uodr = bmi323_acc_gyro_odr[odr_raw - 1][1];
 
@@ -1641,6 +1647,9 @@ static int bmi323_get_scale(struct bmi323_data *data,
 	}
 
 	scale_raw = FIELD_GET(BMI323_ACC_GYRO_CONF_SCL_MSK, value);
+	if (scale_raw >= bmi323_hw[sensor].scale_table_len)
+		return -ERANGE;
+
 	*val2 = bmi323_hw[sensor].scale_table[scale_raw][1];
 
 	return IIO_VAL_INT_PLUS_MICRO;
-- 
2.34.1

