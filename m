Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDB52D3EF2
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720483; cv=none; b=OGBx15aijflWDPr9/exWtxiU9evctOH51RYGe7ry8qK0YVG+LkhFyeY3AFQrYbYcmgo7AnIzSJhmk+d+x3RzVyMtGi/cS9O0IQBg1MPx4TDRja8lr+4a6PbxWJ5Jduj5xVkp5YlrSgeF9KidvuweZ5Xjf7dYdh4sf1RgLZ1Hly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720483; c=relaxed/simple;
	bh=NbKYeMkM5NguN09KkOFfqTgmRSOZdoHYNf89lOAIJxs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cf6RyJuCIgs4DQmJldUb91h4S4YJpMPt58UYN21oMHIKaoL+hJuKDjxe/asm2ORPAPN2D4HPZO5T8cQaNsgEd0MQRuvzvZtRM627gZC1SZrOFv1EiidylHCdSjURm8A5wzTeXQ53s7dKfEv9MjaodH+eLIAAsflKEbr6en4iX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtSUalGF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtSUalGF"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b941cd869cso47107355ad.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 18:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778720481; x=1779325281; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2wuQ5LwedAkHBzdU2pK2avP+JBelQMIXLc0TXPSN3NU=;
        b=AtSUalGF6HKT4+eO7+Uzv6lI/zfGGH39C1aVBWNwVM6K5Q14UWhY/PRoy7kh/mAX1B
         UvfW2tZ3ZK3ZZuVL0pjiQijh7v4KVrqHGSUUHnQhZMAYfxe4GpNXYTEpO+/gTHzVTzTZ
         bHV9zQ8JFNp+v+53UFiuwjtdvNU6sG7jRaCepgO0h+Mco+iM/ucqM86vUONqoIZTH9CM
         6pWhaeQK8GvGQRI4D2frknK5F+vrWStCWkXmvA6lRcH6wrU41TQzQOSP1CyP1DMP6zW6
         Dl6U5yTTfDveTu+G3wqUfklBnELRM2VzC7AuPoqOyKxtE9BCLQ+JGDLvThfq2OQ98W6U
         duJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778720481; x=1779325281;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wuQ5LwedAkHBzdU2pK2avP+JBelQMIXLc0TXPSN3NU=;
        b=TdVk6EVcC3Za+RJ/EYBiGe9qh7syhZa0lr6I+uFjwRXl9Ewf07ow3bNoEXh574F6Dj
         UmXqUg39vqv7t/MBf/AlDmRs/TFqyJgmsOqNPhzLdvh+UZjO5F9Tm9jmvltRXGIJwYAX
         SfTFlVOuJyZ1b3iYMrkgRX1207BV6qSnqDz/mTwnl1OU4LslSWb8vNnNXmu6/XBXAtBi
         /3/cXqrq3Jl6v2Dikclfeuzv83UiPAv5Bav2CN5NcLJoio9OJN4yao7aiJt9FK0wg9Ky
         TwNnbBwZ7iE48OWzmIz94ZKvYTkVbxDDyvsi8wb3Jl6UdQ9OkeaFEzBoYEG4ZE2BrkTR
         6kBg==
X-Forwarded-Encrypted: i=1; AFNElJ8xyBHhc+3+rsgLMO0vqlHnMl0p8NUpqymaYMSlriizOshUN//teprL7FrY6JmU1TZ1lBghAfnJZ4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzDwW4tZ53C/v66GPXJDEXY6hLCVC/imdGlWQl2LJu5mPnWsZ5
	ndLC5yFLoXrFNAZtRXW0g+R3uwECjyXwsgcIvz4SOzkcrlZ6rAxsVHXYbqpM5r4G
X-Gm-Gg: Acq92OHWAgv8ej6sDmw3yy5Ujs5Zth4SzudVP2ZTdJCC43sDj0KLVrRDiAwXz6T0QnL
	5eFpR9mdPQQsUkCIOMdKPPKyX87CMozhROnCbcEMfwz+7wdtD/mkOXd/yhbfwdQPSj6vq1x/jcu
	OwtK84xXHuellrqQEUNY5VGf7g4fAcex9c/TOYM4Wg1753Kk33Rjy1PqbQOVmY9j5FH1EpHfyNN
	XKXwKh6K75VZKd+o0eH8camrrwylnpVJzHUQ06wHP59TQdNJi5JP9IDKFMmJxJqx3NtRLgOTHQE
	2qUEPoWHonQwKCPdT6v/o/E2vvM/FOTsQ08s5utwzkhBmN6DBA0pb4MgHj66DIluxOk8GMzwbCq
	KpAXiicraMdVl/p4PNgwSKgBaCriDbEWcpC0qdm5wFQ5KaWPb7nfom9RC6aYDxbGy0Qndb7oF21
	vExVUtdqsgPxla2qPb2DA7zE482zaFnvDElLXD
X-Received: by 2002:a17:902:ea0e:b0:2bc:ac76:c1cf with SMTP id d9443c01a7336-2bd2fe21d31mr52498435ad.24.1778720481118;
        Wed, 13 May 2026 18:01:21 -0700 (PDT)
Received: from [127.0.1.1] ([203.99.159.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fbc05sm4645895ad.57.2026.05.13.18.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 18:01:20 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/2] iio: light: veml6030: fix channel type for events
 and remove unused read
Date: Thu, 14 May 2026 14:01:10 +1300
Message-Id: <20260514-veml6030-fixes-v2-0-abdd5837be50@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANYeBWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDU0MT3bLU3BwzA2MD3bTMitRi3aREE+Nk42RzIwtTcyWgpoKiVLAEUE9
 0bG0tAP3bmQxgAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778720474; l=1937;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=NbKYeMkM5NguN09KkOFfqTgmRSOZdoHYNf89lOAIJxs=;
 b=A75f/7N/g7XYIsoGd3lKvTwGkRrCG4ZcjYc7Mj0Ue8hfjtcs7GrYt/tlwqP+NbkG3q4h2j/tl
 ZThnAmCNUx8DeMmld/prRxRhv4yoEaGAl9DaC5xUFZYVEZ7rHauUa/d
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

This series fixes a current bug that leads to pushing events with the
wrong channel type (IIO_INTENSITY instead of IIO_LIGHT, the latter being
the configured channel for events), and also removes an unnecessary read
operation when setting a new scale.

This series has been tested on real HW (veml6030) with positive results.

V1 of this new series is V2 of the one I recently sent to provide a new
driver for the veml6031x00 family, and additionally fix these issues.
As the driver will be split to ease the review, it will take some
time until I send V3, and they are actually independent matters,
I have moved these 2 simpler patches to this separate series, keeping V2
(where these 2 patches were sent for the first time) as the common
ancestor. I have provided a link to it at the end of this cover letter.

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rishi Gupta <gupt21@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Changes in v2:
- Add fixes tag to the bug fix in [1/2].
- Remove Fixes tag for [2/2] as it does not fix a bug.
- Fix indentation in [1/2].
- Link to v1: https://lore.kernel.org/r/20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com

---
Javier Carrasco (2):
      iio: light: veml6030: fix channel type when pushing events
      iio: light: veml6030: remove unnecessary read of IT index

 drivers/iio/light/veml6030.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260514-veml6030-fixes-ba43c3c72857

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

