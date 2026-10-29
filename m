Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272114;
	b=sYDCGrcy+HMMZJvrrqA/N++Sra35dLenMfjrmo357D72xsGgm1qchkFo45OPErobTnay
	 b8HqiIMC/j/jNpd0RmaOJfQBCHxput7c6O2yv/VYC7Q93nIHeZkDoggZHr1lapKgTNjVd
	 AbYqpnd2yfXXq3imxK2O+aLbimZ4lA5i6/JNg31+FaBO1Mj0d4oLXc1GKoJytV2OGk1/c
	 Tj1VYdVvhxr/gyqkt+eF/wyn/f7Z7lEXB4jIYttbmz71557mjq7uGgHaaeKw8P5+sBCB8
	 JATDE1gFbowy4dS7vAJVV7gWmu/5qn3aLQqOLNm7wUMzSY2yVFpVw7okKq3R5tQXmcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=H0tYkJYy3C880yk6BHBia02WiTzz3Y2QDCRFZ+JDpxw=;
	b=sB0sHGd5D03DTTEcxRRVNogww5+tYaVksf0iYDHqlvGxZNEqmc+mmasIoejgVxt79S2X
	 Tho4D8W1SocLMiTHbv6RsS+nG+dUxGy9RpeNQDouGrFfOeMAixKeaCHcvi6g9Cl9R/q7u
	 ls//FQ43XFYabrC7KWNDb85TwqI2Ul0cDFGBXwuRcVHpG2js1i+kZRd0EXHiP0XJFa6Re
	 iU0QmyjP7c+H5abBqTJpcmi22I8bIEpIC+Ed0ebmfuLM1cvVsuAFhPMh9SjkmvAHmuy78
	 z0X6FYTP291SafOuabsQutbUoSBJ+hCjVehjQ1mCU2UIn4Rm9edy1MRHKn+DOYrvSQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vtMbs72i;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B47606A327
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 11:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74B47606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vtMbs72i
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c46d41f6af3so295210666b.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793272113; x=1793876913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H0tYkJYy3C880yk6BHBia02WiTzz3Y2QDCRFZ+JDpxw=;
        b=vtMbs72i5Bwdg+EQEg0LQ54+jb1t7DAQtNOEGkP82cMcmWhR72Yob+mezasr9+t7/4
         mw6CFywSWfKjify4A2dxToGllevETEqsU6CtEtZkw1viIo7kinb0f/b4YWwPCFIvN/XE
         Z4Th2VBIja6JR8q6bxYsuWRHUZi/wGDYy5Y/PitS/sraMLvF4CsrSgSOOHMTicJvDbh9
         QoU+ETHa3SxSeoXWtHIVYs5G7UpijQ9HuNkuqfLcvTudhPgS6Xwxe5PIKA0BfVpK8x3E
         HiMvV/sC8KnW8UYPJdOl0ZUS1ahob76GAtia8Y0ESQKSnZ9XL0dtikB7AEoB60LOqFwa
         nycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793272113; x=1793876913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H0tYkJYy3C880yk6BHBia02WiTzz3Y2QDCRFZ+JDpxw=;
        b=s9RVg0eN8OaGbfXSTKygYQkgqR7ky9M6LtGiUXYGPHQgCNJPrsKu17IswlPBkfr/CG
         Awn+vbuHZIMeU29mGxbKYbSYCa8wpr+fJ3/sgXMMHHTpCYem2gExWZL3rCNKMqpGJsUQ
         wmcidHP0+OY0iREpVFrh9lCx38KZjowIxiSdggUbpAe5BNsp/kxVxjiXPoIigpvgcO0v
         i9Z7S2QcbR96h9LdKxP40W35n6rCBNgR5PkT/7ZuyrnTheY0uZIdFdyoka8wiwC63fW6
         qKFWi7Vl4OYg8SQ87mLhBB6P5+C2yKPb9KKe8JiQxYLCrtYb80V0SzoePDb4sjyJlDds
         JyWw==
X-Forwarded-Encrypted: i=1; AKwUvBystD6r+nF5JkT7GBcRcy054Q77+SCQ4Mlo6MmU17irIh2V/hEBjuRZ0rX6vZgZcH0ZeuKD2G3lTQE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTLSniNrDTz3zetD8gnPRQDmZqFOmxr29shhs3RYUbaAZmjuG/
	r87jUxZY7eQNpuJUQ+MPICb5Uba5maIdJ+mbDVX5XYTfj8KVfSbLUpM=
X-Gm-Gg: AYBFou2IiR08NTKhQYySQ0xoZnEaahrReFhvcaNtiWbQ/w7rKWX00WfgWKsP1ZS6NJU
	5DthDAg3IqYQVQHrV5Y+F/by0gLqDAmHg+pvqNBuYYI4lSEtUgXvNuCA+ZdbSGav+Jh4zgFUijN
	xSjWsuV8D9+Fn6PhTuyRcmRBXHAgUv0LRZqrXNxuE2JSaG/a40szKxKheGHPYN2XdleR1XxLNc3
	7CDvBIhQe7nvKHQ42gVGjIKDduH0P8HXnJbHx5+5vVQE4WkdvJjPLMg0WTGtcADJDoRL2kfWkaX
	+u8g2CYIWFDyS6OuY0vvmjH7q6AYvYMXoTNA00cAmOYiwFKziRhmPOgdYjK9pbHk743Qhi/R4z9
	ybHBUMR0lw2TQ6GBhEt38BSmU74zYoEfZMtRKFTzQMwHIm8vTTT0hGltkHugaG50Da5eyJHYdpZ
	pAJztL0rUxIeg7qr3NmKREontwxIXbnFDHQruBaYOBklbVeTC7Uv3MrVbHrs/m9/WlA9qyfM+/U
	LxfhTkdfR+QK28ZSw62+3HVvQ7vSaljJa/LENpujQ4mROMngosjYrE3Ljp1WPjAS9HJBnv0hA==
X-Received: by 2002:a17:907:72c3:b0:c31:e958:408c with SMTP id a640c23a62f3a-c49be046b2bmr424030766b.38.1793272112734;
        Thu, 29 Oct 2026 04:08:32 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm33716448f8f.54.2026.10.29.04.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:08:30 -0700 (PDT)
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
Subject: [PATCH v3 0/2] iio: validate ACPI return types in sensor drivers
Date: Thu, 29 Oct 2026 11:08:27 +0000
Message-ID: <20261029110829.1086835-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026142040.62383-1-tristmd@gmail.com>
References: 
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

Two IIO drivers access ACPI package members without type validation.
Use acpi_evaluate_object_typed() for the outer object and add inner
element type checks where needed.

Changes in v3:
- Fix alignment of acpi_evaluate_object_typed() continuation line to
  match the opening parenthesis, per Jonathan Cameron

Changes in v2:
- Switch from post-hoc type check to acpi_evaluate_object_typed()
- Replace kfree() with ACPI_FREE() for ACPI-allocated buffers

Tristan Madani (2):
  iio: light: cm32181: validate ACPI object type in
    cm32181_acpi_get_cpm()
  iio: imu: inv_mpu6050: validate ACPI object types in
    asus_acpi_get_sensor_info()

 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 7 +++++--
 drivers/iio/light/cm32181.c                | 5 +++--
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.47.3

