Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272119;
	b=H1WtTqZ1lbrApl164tOuVX/feeVnnBCrFbjnPXWa1bZ/ZW6zsHmEWfoglhLD4WxeJTZ1
	 Dg4+0dBjHablK4ntFjTgiaVFFOCsEOHCRxwOKipuYlvjvvnner25HtzVUR6Iaynm6JQcK
	 PEAWL/+y2+yz1jAI36bdy5FV/m3QmrpNu/hWe5p+GkF3IzMPVucdvq3yFqHsJEsx6+bf/
	 /e0v4RTsY53IhC33Y56/rM/I9dxXRnHiel1+i5AgwK8Jz/pGFn95HyaM0uxoQ2aTIEQvy
	 W0OSeOlx39OdLwGPvZq0OJl7Z0at5YBQwAd6fzr9AWwU2nCPLak9H53+Xh1hCdWMvjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5Dr8fUPXt5hNgYrHFxebqt4WTv+cM5sI+Rzy2ba6XE8=;
	b=uTu/yxK5QUMp8jAVzzDdGb/FenjYQR3/sX1xVECXYp02fhowrnpaDWiW1UW4PeqAMnRm
	 F3bEcTNf+5ARKpXc28AZSKjGXz+oCs9+DvyirBmQ6MJDsj6FlfhqK+bWnSis1Gh6cuAme
	 Y49Omp0ZhbOJTbla8K40wXKeWa+diUOiMd70uZHND3RT7Ps2RAo3RrerbDoMh6cFTFRhC
	 q468y5eZANG2ql9enyXsd9UOBbs3LURO69ldPo2ChtFXEQkYx8JtJPq8uZgFzNf5HFtGg
	 DH67drogDzvozu8a6mAZvM7GUQnHPpc+4/2ewI0zoyAeH/B3nXztnGxKsqoDnzGSUaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Izty4oPI;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B0606A325
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 11:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A96B0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Izty4oPI
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c450ab1483cso313651266b.3
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 04:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793272117; x=1793876917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Dr8fUPXt5hNgYrHFxebqt4WTv+cM5sI+Rzy2ba6XE8=;
        b=Izty4oPIDBwFCFplCs3kxMz5ctmbJ5Omimnq0qSz1LWjjyYa7ta6n54JeSqECbDYiz
         /qhr8igYzuWVOqyP/pSpC76a9hk3J0f93I4FpH80UJy50fL4zrBQYIldblSji4q91XJ8
         VsdsgEU8Rx1OXwLJCnuPf76Gje68k3ueuGM6d5LD1OOqIsnH8tmNI8ldWkSp47dQErBk
         dTEKdGDOBlk0aBgvwwL+vYAlSJuQ86I+38Yfw1I8a5TYOLTkkpAdEVktKaKiTmY0/bxv
         Mcgb0UPEVYhVQkeRNHb74OYddpPUd4aMqXJzXJHDqLHEYpyomyLW/v3tZJjDVXI+esuM
         dp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793272117; x=1793876917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Dr8fUPXt5hNgYrHFxebqt4WTv+cM5sI+Rzy2ba6XE8=;
        b=w7CIBI6g+EfKKtvv8rtoDgxDyLhzNl7IM4tFcGTrnFBOyjE6U37Vhc9tmw6+JFc7YA
         qoywwcP9ez44Qo1NoLlo6zxawiB+dgC8AKq//peXOqaRtiF/kl2IjvmSh4j6Qv4iyliN
         I1ndlO81ErmbYr+gnyfqankgczD5vUwCcvYC+zZtVlCWgkjyABCdNc2bbkWXK7yV4+BQ
         RGVCE+ywM/ENv1T4KMia21rj8GLrqAxut9wX4w7wHtpsmlqcmneQxt7+ZWplQzzOnSja
         CiJJ482jTWCBev0m4vEbRbKBCEsyJAoV0ujWO32xk+tN8YblwzoXRTk9Wm3xRkv9193n
         tBow==
X-Forwarded-Encrypted: i=1; AKwUvBwmbnj+0t3sF8nN0gSANm7F79hlxGHtlTelYWDMKGD/gefO9m/2J6PJCmttd7zqVdrtKM612UPYPVU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWczfb02d6aytsLYIi40R6Nt5LUeGerlj80aLi37STXz9eHiMM
	TcSPVIdRdMHczOuIcEPIKQj7V5lfAFfdliR0uBt2UbhGTdU0kanqPkE=
X-Gm-Gg: AYBFou2RDWdsntYsEq61YFivkUkRVmHnze7Mtc7ITKEJgzJwSZmZ8tDR+bxsPAyeKAn
	sXIR8s766PyrcTbh5aa+4SrWrr3vSes3AvzOnmqkoDyrSSFJolDZaSFsd/EAJm8NWph6go2zJ0P
	dt5WNov/53A5f45hH/ETd+VsMKSk5EFSf9f8TSi6x+0fdwQc/oIsroi9UsE+HOZtJsVWeb+3cIg
	kAdP+NfepA1I+IvCcO0jTkt3D4igpeXiJetrMXKUBRl2S+v1B74f/x+NtmoQV4mbXRatCEl9rWQ
	53sYF6E85QdRyia8sxKVwYemwBZAvmv565D9E5QmSp/yoM/XmcrgBGDveGgouVCIUSzJ/vpn8LL
	zxudZ+kn62QVG9Kt4f2HIXtOfTTr8RfwFVgUltjXlyXcrHp6xWUylse3Buq5H2TIkDznJErBs/m
	deVSotyMdV25WxkcrHQmRJQyvBqQGIdMOK9i4i2JK0paqftxYi1VZTdZmwOzvBeDiGde9RtqLpy
	bm3b1EwTBFxnb23BPpRA8kzg0/TSa7x5ftY1b1uhmxdpHnLkHqD3zLwtPtpz+jU2zYOd0GOtlQ=
X-Received: by 2002:a17:907:d516:b0:c25:2688:8212 with SMTP id a640c23a62f3a-c49bd9ce44dmr502861166b.0.1793272116807;
        Thu, 29 Oct 2026 04:08:36 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm33716448f8f.54.2026.10.29.04.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:08:34 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 2/2] iio: imu: inv_mpu6050: validate ACPI object types in asus_acpi_get_sensor_info()
Date: Thu, 29 Oct 2026 11:08:29 +0000
Message-ID: <20261029110829.1086835-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026142040.62383-1-tristmd@gmail.com>
References: <20261029110829.1086835-1-tristmd@gmail.com>
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
index f7bce428d9eb4..e6a4de4fbffd2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -50,7 +50,8 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 	union acpi_object *cpm;
 	int ret;
 
-	status = acpi_evaluate_object(adev->handle, "CNF0", NULL, &buffer);
+	status = acpi_evaluate_object_typed(adev->handle, "CNF0", NULL,
+					    &buffer, ACPI_TYPE_PACKAGE);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -60,6 +61,8 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 		int j;
 
 		elem = &cpm->package.elements[i];
+		if (elem->type != ACPI_TYPE_PACKAGE)
+			continue;
 		for (j = 0; j < elem->package.count; ++j) {
 			union acpi_object *sub_elem;
 
@@ -76,7 +79,7 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 		}
 	}
 	ret = cpm->package.count;
-	kfree(buffer.pointer);
+	ACPI_FREE(buffer.pointer);
 
 	return ret;
 }
-- 
2.47.3

