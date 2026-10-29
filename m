Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272116;
	b=EGBFAhZtwWo+xASMFgYKZpTtFi16hC0OmXb0uRc/kawT8NuM6gpjDAa7TFLABp9pqrMi
	 UjYI33mdBMCq8wKHFvy4GsjPikwE68cCXFCVf0iuNS0R2QaMJtlRMzKhDxSU8dIuy+gnE
	 Eu8t0h2x+561zVr/NtdeNiA5Z/Dd8pCFFbJwVSJXSx/+2wQ08CRBWUGftf1Z6KdU8p8aa
	 1ssBm1zHOkBa69GK4Nv0VRr/fsvwXZ1vvFn2M+0oUlmLi3vkYJwDa47EUC8ZWEfMtPmZd
	 peTnbFgloTDXm9J5BwujdzORWMV/3Gv19uA4B7OcLcuaCk4ctMYcTmaYsB64uHQpfMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=D5Bct6ORVWbKd1PZDSJ4YkoXvIXlK7X6xeDbDKwtWiM=;
	b=oM2xYtJ1VNs03hRZNob0dlq4NOc4YFvK2CIzGMmMxnCzq68bBeUWgE/lAgC+I1JvW5z7
	 b3FwudCYJTNTQsI87pgbU5dHf1T0zKQe+Lcq/ADY/WnYiUmsLOnYNOu366rC+tukJRHAh
	 zskfDbzz4KiqCANSQtcQlTcmsKQspThnxHDxLN0hO8YcwiVCNWyeQOMtgKmSV7r5NCATj
	 FG/NeUIG/iBp5utBi7DMmMmtQ0jjm8H+NGY74A0QTQxoOvIx16kc6TddXamE4+VejKsjD
	 81kWI1LXWDNzAsi/YPa+zqgboq+0/lWZ5F3qrYcvB9s/TLv1uQU7zNk/Xh1dMnfBcpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XVU2S9f4;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5B606A326
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 11:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECF5B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XVU2S9f4
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1632489f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 04:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793272114; x=1793876914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D5Bct6ORVWbKd1PZDSJ4YkoXvIXlK7X6xeDbDKwtWiM=;
        b=XVU2S9f4VIweHZFAxkuAGLpNrTAFXPJAh2+1+VWl9ZWl8azMfLX2uYKK6FnTAgKgNU
         XHTURhdfP0iNlwhm/9j2ZN3nvw8+EpkJBXs1PdlkkuqhzD1yc5n+4of+Hm9H5DGv7BNF
         8WXhfPc0FGrFAy9hkSMv5u6dk5p1shiQ3smIYRNMOhnFwdQRLOFTQN8pi0TNB0VH5eGu
         0tjPxztmUzoQUvei+WoCv4p6sjg6UtWsHiwFymX2uo7T0wd+jRGc4fYWTed/Hu3/QaNS
         g/17ZcspeDY6jHg+o1++iSKLmx7XWnrLHIJHh3m7rnb83Vio0bYWpCJKdI6S+ELOg9vU
         zJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793272114; x=1793876914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D5Bct6ORVWbKd1PZDSJ4YkoXvIXlK7X6xeDbDKwtWiM=;
        b=XfiyoU8Sr6HmarxVF4NXx6BkGQ0UDi7s6q76+vCIB2D7Runqkp4wL5xTePZr3UmcoW
         lzrY0EKMyG7IgN8yiNunybxa9IA3MmcRqlcux5HoWNRhx7Sc4CITesoJcpU/+hr4ITLU
         sMJKySAIIdbIZnm/R+I3G5g2JFqppbk7KcQMO75AwoJa+Hpbnll84TZSNqx1X70103Wn
         uByepGM3Dvb4TY6c0L7RbOfrCf18EXR3YZvW6JKxBVg7CFCDCq16TWL7XWk/CnuA+wrT
         mP22DdCQlSvvBBNovROyJFwv/bMtTWqweqmA3AWmnAaFS+3DayzXJphl9irodh8F4gc6
         oMQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSwQRi5Hib9bR/pIoMwyd6tnF8BsAjplIiXqC/h3nU1uezptXMh7sY4t+5Ddz1jvygvO7J4jPRxAo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlqJpd/W4diD9x/u4aj6NcQhnbekvsNbJe4MgHJAAHEN1Zf0lv
	CgbQpp4oOT3fhtOIZI6EmL4YMbTrVVISguwmGQaVx1YRJVczdwYR8uk=
X-Gm-Gg: AYBFou0nCQwWtXWvJ93h4qYYJUXS6PcJmXHbijjTsEShEysaWRP+b1zGbuxtW0Q1jhW
	vjU02q4XEYnVuCIy55MgnodbL/E0jM2Ico9boEEWFMAG9B7k25zwp81KTbIw4gshjREvHXOVz6V
	UXkBwd64NZhp3zuHQ3EA8UBtFOL6Wu8AL9lslua795WMeh/Zyott6odaz0acK7zzaOa+ckcryfy
	XURapobawOcePpxAR+FLw6TtdDBVsZzS838Qymn2RFoHz9in/arYSGLG/yagUgcQRjAZt9gqxzy
	/EwdXr3zcRtYYV4kl4H1dFTop1etRxIWkvQKctBbT4BZEkJxK68MGpHwKKJpCJXwzmmLevWKv7K
	XgwzzCMcDG7ymElGwWFJLq1xRjPeWyNoSShxQvpzjqzQpCM2gEvXDyFKuQCf3Y4msg8koxP7YwM
	Mn94o58BQ1GnJUjM41LxduTuVb01wMw+TM87aIS28DtNNugI3WqTGaj0Rbf3JYakN1Dezvg1lft
	9X9brJrAu0I7lTYdzgxXVFXHA/MlnSohGX/xdcfisgQ11lBDpqZ6WL1ESaryUrKSbZYvHHgWg==
X-Received: by 2002:a05:6000:40de:b0:48b:e50:714e with SMTP id ffacd0b85a97d-48e5d308159mr11719738f8f.36.1793272114213;
        Thu, 29 Oct 2026 04:08:34 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm33716448f8f.54.2026.10.29.04.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:08:32 -0700 (PDT)
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
Subject: [PATCH v3 1/2] iio: light: cm32181: validate ACPI object type in cm32181_acpi_get_cpm()
Date: Thu, 29 Oct 2026 11:08:28 +0000
Message-ID: <20261029110829.1086835-2-tristmd@gmail.com>
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

cm32181_acpi_get_cpm() accesses cpm->package.count and
cpm->package.elements without checking that the returned ACPI object
is of type ACPI_TYPE_PACKAGE.  If firmware returns a different type,
the package union members alias onto unrelated data.

Use acpi_evaluate_object_typed() to request an ACPI_TYPE_PACKAGE
directly, so the ACPI core validates the type before returning.
Also replace kfree() with ACPI_FREE() for the ACPI-allocated buffer.

Fixes: d34ca613b939 ("iio: light: cm32181: Add support for parsing CPM0 and CPM1 ACPI tables")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/iio/light/cm32181.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 9df85b3999fa8..a16fc83bcbb08 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -115,7 +115,8 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
 	if (!handle)
 		return -ENODEV;
 
-	status = acpi_evaluate_object(handle, obj_name, NULL, &buffer);
+	status = acpi_evaluate_object_typed(handle, obj_name, NULL,
+					    &buffer, ACPI_TYPE_PACKAGE);
 	if (ACPI_FAILURE(status)) {
 		dev_err(dev, "object %s not found\n", obj_name);
 		return -ENODEV;
@@ -132,7 +133,7 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
 		values[i] = elem->integer.value;
 	}
 
-	kfree(buffer.pointer);
+	ACPI_FREE(buffer.pointer);
 
 	return count;
 }
-- 
2.47.3

