Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170511;
	b=V469aUVUjbgDb9Sc0dsBPTZSm+fdX/OmTjMoAgFj08R0P7hpy9NlpSQzxybkbD5oDQbJ
	 TFj2pMfisKUSUVQhOkPt+8mSFV6fgI1AjLFwravTdWgQj/HjKdrGIIYLrvtWeIC25m+Er
	 angy9mnYKwp9bQfNRP5UpKzNPBLHWDSmOmTfTHWrCztdcfkr0+Ua6bqNZ/7yl3ereY7w+
	 T9RrjMlirRAZ2NV5WV/03k5GY4GrpCpBn4vGSz7JpZlRLvpCY6h15r4o6pQOG8Rb3KsXo
	 GLnyx2XfkSf6V+GvDc/cv4aaG5KiVIXnUqxPKZZX1qRwa8oiIfg5DsKDlryL45UPC3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=OB2cqonua3QslxurG3tUah50j5fz64F47osIRxGjQ6w=;
	b=zGEqsZvaRBIe320HHHv5JCPZp0yDqKChQc+6/E14v43k9zwKAg6cxxR5fj5dDdpP8JGQ
	 BtSUa2SGCRPDX/+cESk8cqDS3SnJ7gZTb2HGlxldHz6A+IIyE9VWi/Co6Yz26haMkQq0p
	 6CIXYYgbKxjg6AredelVw6y2vfcGMN705JlB5WWngmCi2lvleDMX02+MgY/e8JoX1ev1+
	 JJCudBlnUV6jLcrgTeZJniQ/p2MYUlNmIVvdCcipYMqrKvjVBXuOethxt7WJ49Z5xzZvj
	 N6lXngCRFJxg3zfv46ukn01FYypPVkYP+eLmqvFd4TJ+3oY5Uen2hNhbY3vERQmKlBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GnXV60lf;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCB3606A326
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 10:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CCB3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GnXV60lf
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so1594491e0c.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 02:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795170510; x=1795775310; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OB2cqonua3QslxurG3tUah50j5fz64F47osIRxGjQ6w=;
        b=GnXV60lfzDtJJFrcNWwAK2yBHlXPjFx23bGoPoWe5kW3vbud7rduIAppdWyUYshd2D
         U0sNRrwHj/KpolHmVwSD7MdhS8kJLKj4Q5W8A1K8cv8JWhn3e1xpWqrIiQNYOKEMiDIZ
         kcdSntcpf8NtROEPZh6Kini6rALbsMgAgIm0EKBRem9Zlb6QroHlxLiF8+dE5alOvY7u
         mGRV+3aK6AlouBOzFLBsSG5jPopJW0i5HsNiv2ObA4MvjRq4T7OFn1lCLC/1xYC+rAX7
         USn6rFRlVFD0nxOY0saYtTOtIbGVlQYVC5B32P3eZRlzqI+6FT0EhiIfj6lhxnM9JLVv
         rDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170510; x=1795775310;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OB2cqonua3QslxurG3tUah50j5fz64F47osIRxGjQ6w=;
        b=JvcwSksDbNSLfPvMueO6ye+A5/ZeCNYlAJIOOyUnaXj+v3Z4mpFQrdLHZrVe5qGFZk
         yrOvfj+Mdyg9xbilPVGiRVzKnzRpDvn7OM8ib34mVGWPgPIOhPd9PQrfUID+jtq1Nfdf
         C1C5SLVKKpSoX0/nvJSirmjCZVKmDtIyp2UeD+MDBaD4poQGb0AjYE++BFQmeKqqzdJZ
         ZCotxzeA8I+Jx7HZ2loe557QdXAaypT13s3jtqyq52Ila5W7m22jJbc3Y9tpBDYbpZ6+
         Od/xhpcVFDV8QhIlw5Pt9fLdjYzawUL+HYNbpS4geK6kQGhSPicoorlmNjfkMgKl3QJk
         vRCA==
X-Gm-Message-State: APuU4Z+XXRWqrZinpBQrlouO0fR9D+wRNqYkVSuQsaOOSGVMDKH1WAgL
	35Jsqj4zJ/YdV1fmiN0Z+vRYjcBLJ6KhH4a4/4HBoVK5MTKLq5sYvQqv
X-Gm-Gg: AZFdTZfMzacCPcOBZBg53kmCbGcCZe6eW0eeCz65vnhhoQQPCMEb5i19RgxvIUkcErr
	yO8O9BYIMOpV5BZSYpG6Pb/uhKLBg2+PUMb/2dVkLic3rf4nVAuY47Ub0HXfm8i0jC8gAdzKvNv
	gh1s/3axXBW24onxtao23Te9z263I3ryi/+fSU4MYPRTndq2F1sIqf1pxSdSv7+RtN3EqHoNtFm
	gWRH2VOv3FRWXAw+hvEG7wzbtjHQ6IvYccflOzvfJsRSAwlUOG/btfrUVatKHHEBn5vx1htfm9x
	WnIq9x0M+8ZiuiExQ9a0yKByvKkNOhX6zLkJN1xkRzYdB+3lLcXydz98c5o+PsJBZi9wPpF0Qxr
	UHobJv5ANp0DjsHdteLcr/tcRh95Ul5yj0LF65ANncQI5u8fzY2Vkv5IS6GGlybuvhftQZWVUSL
	+I6/Ip6xE45FAlr3E3z8IG+pasRDTWciHDO3hYpRNh8c8s75OeUADfUT9td80F85a4shxe0KwR3
	ESaREvz2Vdt/qZ9Yhdgys2wt0P/PG/8MwS+yB5zkczC7em8PtTVNad1HFAEktvOPjueQOVmyd0Y
	wkjwHjeXBj5HodnAxg==
X-Received: by 2002:a05:6102:6042:b0:7d2:ee9e:5373 with SMTP id ada2fe7eead31-7d6db9f7c78mr1041189137.26.1795170510211;
        Fri, 20 Nov 2026 02:28:30 -0800 (PST)
Received: from [192.168.0.9] ([2a09:bac5:565c:aa::11:204])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6e08a02asm2481753241.11.2026.11.20.02.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:28:29 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Subject: [PATCH v2 0/2] iio: pressure: abp060mg: Fix scale typo and I2C
 read handling
Date: Fri, 20 Nov 2026 04:28:25 -0600
Message-Id: <20261120-b4-abp060mg-fixes-v2-0-89a274d68a9a@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NSw6CMBCGr0Jm7Zh2xBpdeQ/DYloGmEQeaQ3Rk
 N7dygFcfv9zgyRRJcGt2iDKqknnqQAdKggDT72gtoWBDDlryaCvkf1inBl77PQtCTs+B7LmdCV
 2UHpLlN0otUdTeND0muNnv1jtT/23tlo0SJ67Egmt1Jd7P7I+j2Eeock5fwHlbTK4sgAAAA==
X-Change-ID: 20261120-b4-abp060mg-fixes-fa5c210392a6
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Marcin Malagowski <mrc@bourne.st>
Cc: linux-iio@vger.kernel.org, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795170508; l=1734;
 i=aleszlucero@gmail.com; s=20261104; h=from:subject:message-id;
 bh=iegFCUe7WOVMJAWKW0+qXZ0VNugy3wOr8Mk3yq4Hj0w=;
 b=Qh5LlBO23TNlTWUc/P9Lcb+L4o5YOP6Oz43vMCG/BU/jcVQmq5XWvLiendt5zKmPzmP+2nsda
 vU13t6pmDvzA9WB924qKR5OuzJkkLLnU35XNBfvU8jpsSj3uT7JTbz8
X-Developer-Key: i=aleszlucero@gmail.com; a=ed25519;
 pk=zRzEBMID7l1FXqr2CjfnlIn++3m3N05FuNYb5zPA3cw=

This series addresses two bugs in the Honeywell ABP pressure sensor
driver (abp060mg):

- Fix a transposed-digit typo in the maximum pressure value for the
  abp001pg variant (6985 Pa -> 6895 Pa) per the Honeywell ABP Series
  datasheet.
- Validate the byte counts returned by i2c_master_send() and
  i2c_master_recv() to avoid parsing uninitialized stack data on short
  transfers.

Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
Changes in v2:
- Patch 1/2: Reference the Honeywell ABP Series datasheet (Document
  32305128, Issue 2, Figure 3 and Table 7) instead of the driver comment.
- Patch 2/2: Collect Reviewed-by tag from Andy Shevchenko.
- Drop the msleep_interruptible() -> msleep() patch from v1, as the
  40 ms delay in the driver is a conservative margin rather than a strict
  datasheet minimum and cannot be validated without physical hardware.
- Link to v1: https://lore.kernel.org/linux-iio/20261120-b4-abp060mg-fixes-v1-0-2baf026cde47@gmail.com/

Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/ko-kr/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp-series/documents/sps-siot-basic-board-mount-pressure-abp-series-datasheet-32305128-ciid-155789.pdf

---
Oscar Alejandro Sánchez Lucero (2):
      iio: pressure: abp060mg: Fix max pressure value for abp001pg
      iio: pressure: abp060mg: Check for short I2C transfers

 drivers/iio/pressure/abp060mg.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20261120-b4-abp060mg-fixes-fa5c210392a6

Best regards,
-- 
Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>

