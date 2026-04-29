Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F09834F492
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 05:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441598; cv=none; b=ZHkIEaQN/TJ+kniBZ7ArIfhUnHqb8eqEY77b1sVGdfD1b1PjyekdT07JSfvf3UoNRc5cSzsySodtGknECXdIMZh0UUb/ng36v7fGYU/DGHfWaUZejuV6WgVQ0ERsX5ogAtYn2Em9byesoDdcI/E8b49QOuplXkA9tccPyJ7mnsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441598; c=relaxed/simple;
	bh=fQvcWMwpPn5jGYP4rTJSr7QPrnzNGFhXHUOHyu6rfqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnpIY/QTqnUaWLxn4OSDCtEWE5YjaAlNl75p1Hgh5EbnTQYLntQVE12uvZXL6KhnAojopdcm8RlAY/z94OUJoSTWP20zsY3LeJf/tCI2mZsv9wJ4k3MsLdJKVXnFpSF8euHRMGsGWlONewdgwpXKtbYcBf/AZHvm+hhL+2yAlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVcH7tf9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVcH7tf9"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b2d3a9e149so2193565ad.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 22:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777441597; x=1778046397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERdmP9UytYv63GQaQ/8HDqVpk3AgA73GyDjAubkwUxc=;
        b=TVcH7tf9NYUNKP1AdQJxpP1l6TF9SmSlZrI5vyPPIo/2k+DXDhfH2hHV2SkB53gZyc
         0f0DEM/zkTd70eT8u3NSAyNiPgQm6TaLF3VmXevgr5QTdLIS9dhwG2qJk9VzsfHvg5eW
         3MkccEyinFvZLzk91m9V43/NYuvssTHuy+QEThd9Nc1Y9vFC7wIxKMSJjbmz7ZEpd11n
         Pui+Y0lRJd8TyPOMdmlBCFU6yQFlfQtXguw3v62TvWqU3+alWj2Pw8m/iXT4HC+Obj1K
         cZrLO+Zak2XWins+18S31Jvpr4kjjHrchEV//yC1NXrPBri4xF8OjXJdXVy1XrtcS9oE
         gWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777441597; x=1778046397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ERdmP9UytYv63GQaQ/8HDqVpk3AgA73GyDjAubkwUxc=;
        b=cd809Doniwmuv2bW0PScrYcMClEeh+Fs1tYoSEaBZk5Q3cVJJzppDK3avp+6pgUs5T
         VdgnBZNPLvPX+WUyxVqBJTbrHzbNpFR0qVIoeaojIDBOW+fTJVXRapBihs1s9vmMYJAj
         8BkhxT080AU2wMGdt8mw1XOkuGxS5/THqCWxc7vj5yWp+tn1SIkgVqpwz+dAcF6AyYC4
         7o4TO43y5nhoikiS0b9rRDpnudJoaR/bBWSEEjGFtstwhVGOmQq0Cn/POzqYj4wTWTwc
         sJtlRNGfNGAIHcmJZrbb1Onl5sIaJiiyIU3xTT0qD7J6/h5xVOauiNU7/uDTBA+kMWcR
         Cg0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+27uuyYDqU9bhRz8ceQqRUi+eDgI/2KrYXkuqa6ZqikuqKLGcr3K8nDPd7Oc6abmoYaOxKgybAMos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvWFPpSBKI2jV4y6h80idGpDdBI929SNBbfhkbAyZfRNtSsxHp
	HFWHU6eCjZFCB4vmTSSOvr13wTtbZO5yVMi/H48ggN/e+uuQoL0B7sof
X-Gm-Gg: AeBDievW/yR6wHthiUklWgidu5cs2VG7+W+MZCTVlK6RzBKOnoqD6D4OaPIwBuAL4yY
	7xgVohuMUSHmih2AlBUTK/E4PcO59a8//CdB10sqMhWfz1C9Clm//dt7U7ffRv98vBs7kU5eUef
	R8d56UuyIvsMUFOh8UMWP0B7fO2768Iu30wkBXQKtTQIfEEd0yRjsH5hBHMmCdUVI5mjvpSxx8V
	7rPFKDWRsjX36/GjMzmmPGkXy1NxEv7tSZLU6LrK2lWMgwlTqTZRmWX7gT/N0lI56SLOAw0cHuF
	pP2yHptUeY0d46ShHYJ6yP8ZbcxLKx25Glomnt7pYiZ0FN5Eu07uaf6FgbnAVtLwOlcL2nO1Iro
	1EE98mytMp3LLlWP3jSw4skFHEDRbuOwxl1HjpcbQ0B0f8MqVcJBkTrLhoRRm7gezOeBT6no4f1
	waWg02eFk6/7TjXvn+F/hqqTEUrJS4tDOeSp3qEbRr8mkm19rug80KxNnELYKhlxPbLaJ5P72P5
	rn3RPEChDm4JBw0gK1uKQkJVz5P2DUCQWGsFROxrB+0xTvmBA==
X-Received: by 2002:a17:902:ce11:b0:2aa:e47d:e3b with SMTP id d9443c01a7336-2b9880a66e9mr17228955ad.0.1777441596911;
        Tue, 28 Apr 2026 22:46:36 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:5fb:20b2:c2f6:85bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879656dsm9346365ad.25.2026.04.28.22.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 22:46:36 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/11] iio: adc: hx711: split hx711_reset variable assignment
Date: Wed, 29 Apr 2026 11:15:43 +0530
Message-ID: <20260429054544.123862-11-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429054544.123862-1-piyushpatle228@gmail.com>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate the hx711_wait_for_ready() assignment from the declaration in
hx711_reset().

This is a small preparatory cleanup before the later variant-specific
changes add another local variable in the same function.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
Changes in v5:
- New preparatory patch requested during review.
- Split the hx711_wait_for_ready() assignment from the declaration
  before the later HX710B change adds another local variable in
  hx711_reset().
- Keep this separate specifically because Andy Shevchenko asked for the
  prep split rather than mixing it into the HX710B feature patch.
---
drivers/iio/adc/hx711.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 914c6efd0f96..e72f3c2cdbcf 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -204,7 +204,9 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
 
 static int hx711_reset(struct hx711_data *hx711_data)
 {
-	int val = hx711_wait_for_ready(hx711_data);
+	int val;
+
+	val = hx711_wait_for_ready(hx711_data);
 
 	if (val) {
 		/*
-- 
2.43.0
