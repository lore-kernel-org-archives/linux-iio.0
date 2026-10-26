Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024454;
	b=BIPuLs/tn7pAii1+Q2lFCwuqp5rbxP/zGLB0XWyerYeAyudHhAddKO9R0UOVUzfQztCc
	 nHLXFL0JdX80WsGzlIOHxYK3BoxYgF5wHJZImulre3EsVC0EEbQLRUx9jy0mJIt5NOJC4
	 nkiXCqAI1SkP0rRaqVm/8OD2r7pIRNJjxwjdZtobSXpZEkrhzgw/J/jmhjMd0I83Pv78g
	 P14d8hi9G5JHAf78OU9jrYnmmzw9qBhJeSuV9+silS8bzuxDzlRJSbNgavOP7ZEUWXd3z
	 k8GSDrd44eyR6DxDdBmkb6J0aLdV7WGlnE8gRypUZYyvwJo8Z6e+LHFlaS4stMguCQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LgPmm/ErrwehZ+XLxJlpoTIoC++Xdryf/n5RHQZpOtw=;
	b=2VYHf+0BWJa597+Mthjy23+CBYbdg8AHy4kYADdKHivn/RPyv/p3r3ZIaLBxi01McCIo
	 mMb2Rdu6MYm9Qde/CbOTRKxa2ehyxikGoUDNmU2+bnNdQXLW+T0oluU5nGB2JYy1QhrGb
	 44FPo1tZqaVsRZRL4rJZcttBc96wS7Z0OX1vj3kWd8OW0gRwSdPgYzMRVJsOPoN2gP4YD
	 GUL/D75dUASDbvqiJoLWWjlFkKgqZrEY+LQg5aM/eZfX6P7bU3Le4ME8IqniD0XK0Mjkl
	 Bek0VmezpGSgP0oAf2ywQ1f5jGKs/F7UZIiH9JBKlD9f1TwKZVQpASRYPTdzwdO833g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I5GO8QeG;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1260A2617
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 14:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCB1260A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I5GO8QeG
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e0d1da913so2460940f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793024452; x=1793629252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LgPmm/ErrwehZ+XLxJlpoTIoC++Xdryf/n5RHQZpOtw=;
        b=I5GO8QeGXNlCXahnsOgpe1kLFB/P+Gajs3d2ivcElZp0nGsxs/o6SfavY7cXPO8qvv
         K+QXcoc3M4fpLcByidkS/r0GpQveUhNex8boBCdmPiytb0i1UCDVm1w0rk+ygkS+hxKu
         g4NiefZSDhIoEYqmn/CbZB4ebnuhRh3bhR8HNGXZRU8bEHrpsXnW2k2sbW+sDlys5ifG
         HQNNyhN8uQtoWr/jXcy9cqgvw+fHwL1nhhLiVVbBEvf+gssXMoyY4Z5dOLWTXvOy+/bu
         1buqLolZ+Nom0tYxf47BgLF1qqvhVB9JoddlCsXxrVCqbdgaVv81kDiBdl2nv7Eesy+S
         uSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024452; x=1793629252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LgPmm/ErrwehZ+XLxJlpoTIoC++Xdryf/n5RHQZpOtw=;
        b=huBQRCD+apWklcbbHv+qxhNdVMEUsb74bBQDDuqz52XELAnbCwwfCObJUc6NYZuYHq
         KOsXdJ1Wrnr8KHMt2Q1joLklwAPUjK2W+rLRP2Qdu86f0AIbyLE0+/ELFb8jm+A+jvuD
         Rcb8SiucMG+7Psp+1GcUQPv2doAlXmZ4HuuZ41MlkauydGgDQkMlNVLz77AdbLJDa4Eu
         YEt66N4Yvn07mimum1uYnswp9rDv+2F31B4tJnylsTLJrw0yeXW9GeiGGAeKZfpm2boP
         7g8RvAN93EE9/bOixoELU0PMl9iGoaL5tUAaUTADkiwJQJuRDwQ/+EyLDLRJ6U6YUr2j
         g/8Q==
X-Forwarded-Encrypted: i=1; AKwUvByzx1/6KmXagJ8Jksov2UDg8+x8EN2X2DuFgzrtDtLcRupsVHCbe51C2dOjw2zJxOoOuWRq/9HRlgU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnrl2CZ71gavGfQISZZFVNRy5BNS2QpAym70OkGfBuLL72kchd
	uGRg8KSTUZZN8Oxrw4JyDmkr4qHbekdPXAduugSXKhJOCQdqTscI4oo=
X-Gm-Gg: AYBFou157EzuG6DbZGHClU87FtJ7m1VV052FIJtBWQGo2FJ/JEioFIyVc88i8fWwdus
	eg3gTe9Z6/AkTukR+fE5DcQ1rTxOHfj44YOPP6DvvzO3YO8np858p4e5UgYwy+JqRkHS2vDwwok
	MI4UlRPdtSEhMQNW0YmuvAroRgKI8H58VOXi7CT4V4VW+whdee7veAvu6Be/sBQdadDx/hvmRcd
	i2fNWx0BTwnBHb4JDv1pKRSvvV7/ALWYUfFX5k5OVHZeWTimCXWea9OFJx+915UORQ7AlRx/Zp6
	7Pzi2kdHWeuuVkIYgQFaj8e3Rf4aBSYVwngT0pvCY3GYbXButROOe+JAfIr4AQh8ayB0nVINCPy
	3V6FHsOlkQ42sOBnwsgftj1V1gqrbfMXWDNKjH61x1haqWKlPh+WjdWoOBQGQenM0fIOEy16hWh
	paqjb/Nak+HcaW8FWFOIa5/lhaR3GpOOrxY9QoItA0nf07oDMucIOV4KqhomnhtxM+3ZvJLRK7f
	b3KZorbN4LXGIWY6htIUsDprTgAwC4pXydjXkzSJsw0FA==
X-Received: by 2002:a05:6000:470a:b0:48a:f4d4:e1f3 with SMTP id ffacd0b85a97d-48e3ed1ef39mr13569277f8f.13.1793024452132;
        Mon, 26 Oct 2026 07:20:52 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb8d5sm17484186f8f.28.2026.10.26.07.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:20:51 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 2/2] iio: imu: inv_mpu6050: validate ACPI object types in asus_acpi_get_sensor_info()
Date: Mon, 26 Oct 2026 14:20:39 +0000
Message-ID: <20261026142040.62383-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026142040.62383-1-tristmd@gmail.com>
References: <20261026142040.62383-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

asus_acpi_get_sensor_info() iterates through a nested ACPI package
structure without checking types at either level.  The outer object
returned by acpi_evaluate_object() and each inner element must be
validated as ACPI_TYPE_PACKAGE before accessing their package.count
and package.elements members.

Use acpi_evaluate_object_typed() to validate the outer object type
at evaluation time.  Add a type check for each inner element before
accessing its package contents.  Also replace kfree() with
ACPI_FREE() for the ACPI-allocated buffer.

Fixes: a35c5d1aa96a ("iio: imu: inv_mpu6050: Create mux clients for ACPI")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index 460792ed27e031..e5ffa0d5f6b1a2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -52,7 +52,8 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 	union acpi_object *cpm;
 	int ret;
 
-	status = acpi_evaluate_object(adev->handle, "CNF0", NULL, &buffer);
+	status = acpi_evaluate_object_typed(adev->handle, "CNF0", NULL,
+						&buffer, ACPI_TYPE_PACKAGE);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -62,6 +63,8 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 		int j;
 
 		elem = &cpm->package.elements[i];
+		if (elem->type != ACPI_TYPE_PACKAGE)
+			continue;
 		for (j = 0; j < elem->package.count; ++j) {
 			union acpi_object *sub_elem;
 
@@ -78,7 +81,7 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 		}
 	}
 	ret = cpm->package.count;
-	kfree(buffer.pointer);
+	ACPI_FREE(buffer.pointer);
 
 	return ret;
 }
-- 
2.47.3

