Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024454;
	b=GEHJ6ZKJ2B0F42gkQYlx1aAkMBC9cIrQE/ST+2Vl2wuO1QEmx1DJvz5enQeoEna8FtZ4
	 rhoRiS78ZcFztCPeqUPLmxxPljGYk2aLzq5MVtUIVFBYZjK3OgKyGvrIxvmSRixV+CtZx
	 L3sVP6G6rO10l+PTB+YtNjYR4dbyH1IXYSBpPDUU2Jyrdib9w3cYIe6ZtfIQyVWLqAaru
	 f9uW3a5So97ME55QBBJ3G15QzVei+IxhWpSnDi1eulTKwDe94o7jcUw3GAeo/1R1dNLS9
	 UDE9f5ZLAcDULMcxY+qhfQXbfBfwJsK15T5R+vV88MgbVBZeG71RyyPm6F618DQNFJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qtgx3aMD/495ZX6s7lgn7crrN/uSuC+ZVzynjH2rJKA=;
	b=KKWUbkpOI7SgT6oRjlMVmnIglc26xA0+wt2WVRwZmjRik9Fi5bv2NFHfahbn/vkqkDmO
	 Y2nRSEdhBMMd0eHplXSNDZxr3JiFoXOXAEF63AGwiJYAndiaNJ78K//80uUEu5it6l9/1
	 eFO904rjMUJVzj8RjtDScgAQOsoVALadtw4BOIW0cKgoOwb60N0fDvKHH5qjKpvOqw/Tn
	 YcYs6Ui5DQGTu+TqQ/0uytACAnzT4f9XmUXh/oIdywiXBgsulzAmfQJZUsUlhhi85fmsU
	 hU83zc4rIFpRcAETrKgrGWG/ZXgf9jLQDQydtOHskFAg7B5soLfMlTcvpVjgMjzSPAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VibjgXv+;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93A560A2611
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 14:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C93A560A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VibjgXv+
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so2432462f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793024452; x=1793629252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qtgx3aMD/495ZX6s7lgn7crrN/uSuC+ZVzynjH2rJKA=;
        b=VibjgXv+bcagRtSV3WmXK/WYP/g8lMLfHDmEGVKYDuOO/nSMvtUk/CrBhMiWpgZluv
         rvtIkQsRzKvGYEjHsiDv139LqoROgRtSoi/gy+ihu2aB5WB/GDAX6SvkwXnbj2UiAWOL
         uMkXie73jCSAOgPAOrCkkubc9VdDxB6iS2K5pzXM0JYIEaAB2fGrnm0lONCcj9G57EQG
         jvCiAvfeiyg2zAj6ZQvjO7e9DZ2xH0qVlSiX8jlJLTs+HjBLBe6GaDqauDYBhfBAsPmK
         srFpmb/GYbr1sbdxmEmwTlpa+l1+z1NBGg/tt70Olk49SdWQcpu1c/hynBdXfNOWMiLc
         Q+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024452; x=1793629252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qtgx3aMD/495ZX6s7lgn7crrN/uSuC+ZVzynjH2rJKA=;
        b=NKAdheMHZpKYz7Izh0Mhfqs48WbVjkfgdnZycBZ56N2UopYC+VCzj6ipp8lRX2rf/5
         ES2rmxWOJK3rpN7hnGQYN2HX8XR6+cRF/hPER8xZb2SyEl7i1s0o8HDn1EJT5gOTNz7R
         cV849zRE5OmDwd+//u9pjonSpT/liI9VEGDzoPmDee/ACE8EBSnu8xLFJiVXJyToe8Yn
         v7WLaPAatLXNQ8G+7DylgUPJv1rvX5+AwqpXyVJupks1ZD3l1uc/dCEQ4jFF7bo8M8fF
         dLn1hf/OJ5B9R+VK761gIZ8C4D+35QtiS4Ms9YAmqV8/TtY5yhCnf1cXkZaKRZC7WEFm
         QTmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxO05mrLELh0hz7zpJRnTy13Pf0ZQJtRGpOi6UntgsoxFKjYNllW7OEdieylk2llWX2hAgMMFzonwE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLI461bSZ2ig2BV0zhWwdYwbdNqELS5yLe2pu/jAKKKiw7iP4aU
	UL+0E7+OSISXEY4tHt12mQfWUytpOJF6Ndc96J7phsHKVUYXC0jliT8=
X-Gm-Gg: AYBFou2pvWWP76Lyb/FgmxAtNpTv+LZ8uGjj+F20OO++nQKl9Uw/QawK7n99MKm7ErK
	Qwd9hTWUdKGwm14TIL0nWtyOofS2K/LUbzBomQ/otSjeCqmngNflQ3qOdLyWNvUpj/dDoh0iDwC
	mE8vKCGjjF6OFTIe/WzLVbjMZlD3VXbkTQsNT+xgPgmsKOMvmR8bqkGFBGMz2waybIqd2ms358b
	Q4RylVuuHjnhficgeSMNiF9yixenv/VZl6CY/tqIQhm5RrQHlM1Y0zh2MALVihmOefzgwbwusjU
	kJLJSOGKE4rMemzflhAZntHOzkyrNGHGZjyGM5QKNd7CzBBeojoKVSV26CAQveLSvdHnlZUQGmc
	OvbD3cL1xKDdov1S99y+fBae4DMMGWWgo/ar8Waz0mRpmK0xS3l6W3W2NzLX4Pkxu2Ek+3LCsuD
	VoFu8TaY2Zfj+MYVcJOVUjge7sQGA3OxtGiq1STOaZfvoVlp4tuf7dmVSDYsQybD9HRxcJyj+Tc
	z+E08ZOAQhNnQVb2M/zAe8yOWdi9A1D8PhPZaEgSQj0sQ==
X-Received: by 2002:a05:6000:41d0:b0:48d:ff71:dd97 with SMTP id ffacd0b85a97d-48e3eb2bdbcmr13969716f8f.7.1793024445723;
        Mon, 26 Oct 2026 07:20:45 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb8d5sm17484186f8f.28.2026.10.26.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:20:43 -0700 (PDT)
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
Subject: [PATCH v2 1/2] iio: light: cm32181: validate ACPI object type in cm32181_acpi_get_cpm()
Date: Mon, 26 Oct 2026 14:20:38 +0000
Message-ID: <20261026142040.62383-2-tristmd@gmail.com>
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
index b32a94028f091e..8d00486af608c9 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -114,7 +114,8 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
 	if (!handle)
 		return -ENODEV;
 
-	status = acpi_evaluate_object(handle, obj_name, NULL, &buffer);
+	status = acpi_evaluate_object_typed(handle, obj_name, NULL, &buffer,
+						ACPI_TYPE_PACKAGE);
 	if (ACPI_FAILURE(status)) {
 		dev_err(dev, "object %s not found\n", obj_name);
 		return -ENODEV;
@@ -131,7 +132,7 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
 		values[i] = elem->integer.value;
 	}
 
-	kfree(buffer.pointer);
+	ACPI_FREE(buffer.pointer);
 
 	return count;
 }
-- 
2.47.3

