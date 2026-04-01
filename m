Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E9472764
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060747; cv=none; b=me/WP000/QH7bJvHnAPQYZgndbU6NrswqBx+pG5Sibklaok3rZxQc2198cwkxauT6GVvAw2f3bQKg7yb0sbAx/nJONbgmnokjHSw3/soIh54IKry+DiKCO2dWdCyslPLqk3pvJ64lUMO62NL6bojz3FOi+1stD6ecllnVpIJ3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060747; c=relaxed/simple;
	bh=JHZaomVmYY2I/XkWsxtkjS8/76dzEdRMGcPYxXG9t6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6u40rjvdqkV3jGHB1e//M2tN/mCgUuUyiol/4ecuLnu9L5vJ/UoBwJ80G1bfOPPOftaQutY45c9dv1mDhNa/zQyUsO3fMcc9mYh7bw2/V+qKqRAVWhOwv/+Z3soXbZ7P0NYdc8Vc2FwSAb1bBh0/ZGsyOPovVHHQVDTJ16x2Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mirrorstack.ai; spf=none smtp.mailfrom=mirrorstack.ai; dkim=pass (2048-bit key) header.d=mirrorstack-ai.20230601.gappssmtp.com header.i=@mirrorstack-ai.20230601.gappssmtp.com header.b=DiZrhrB2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mirrorstack.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mirrorstack.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mirrorstack-ai.20230601.gappssmtp.com header.i=@mirrorstack-ai.20230601.gappssmtp.com header.b="DiZrhrB2"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35c124d2613so4505652a91.2
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirrorstack-ai.20230601.gappssmtp.com; s=20230601; t=1775060739; x=1775665539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CdKWlJC7fiD6nBYqrx/pcO9OeCyCqC2Lwr6JIyiolS0=;
        b=DiZrhrB2ih/LEIgnkmZxmi/LCjauEYWqooDiH/Y/5zfiPVvAYtKKm29SDwSNxTI9OR
         7ctDUImxINWOws5/VciluwBgjIq6k7TqFAUzhOxhAAZ7BhzDMq/oVSE43e7ciqtRMpRo
         GORye2kcBhzdgrKoTqgtyfhXEcGPp4kQ1NTQ4bYMqp4AR7dZZtJEY6UX4W9xAh91Xrvb
         /ysrjWmV7T1RUHgx436MbwCIX2ml/Q7ph8hbYHdyohnFfa9Ewbp5YWkQqImC/RbsiQ83
         bVapC95rAUwB+n6/opGyaGVXjsCMS693H9GoSGhB8Kg8xHs/UCUTi7u2oSMAiDba0Ebs
         DgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060739; x=1775665539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdKWlJC7fiD6nBYqrx/pcO9OeCyCqC2Lwr6JIyiolS0=;
        b=cR2lJUygEeNtHlnp4uc7Xyk+yZnu6QoACiFgCPb0Yshz9BAYTo+rdKKSoYSjKZFIaO
         K4YeCOwvA2ZbjU0VtmI3U95Y2wF38wzq933F5I5yoTgv66EAMSuEEUw+lic2PkIGTzad
         mC929eb4Wz2G6NCa/CG8vaDJAGj6pPWeyGFnYKgJPJ9RDXtu6EL8qb4KoGl8XU4g3ndf
         0RBqFy71vkwaxSLeDYXNvDXnd0bBItFEtL0ejPGGYSInKxJhAe8JQJNvEo2vUC5nf4HD
         8dDmEoMbKEb01IILuoxq0DYNnhfBUSagbAAC/1t6QI3n4GS3TcKM+9lGZumbhi8QltbM
         uFWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfPQmCaYOuZDRyDw0QnQ6XErMWf9b1mOeJvPAHpegBl7rybjxxLeYXZw7lzAbzRpQzyOClme1fx1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YynVfQhDg3oBTvYs+D9LBAW1L2aElSSxI8ZG5kkHoAis/KYEAXK
	My5gS9k26KW2NeyQTqqaIK11446h5h1OI16yM/+aMKRG0mkhu9CJ26LhnenIg0Gg3vf4
X-Gm-Gg: ATEYQzzTEcuBvqozOzFdnk4s0hBpK6xiLbZNNzBXJ16QB+CryFkiJMwpHV+E1UkxN+R
	vLNjc+G5SSn1EH7GVWal8ajBsOhNn9dH9mouIuyN05eebBDRH1mm1ScbGGJAR3qBFrZz/ptaQwm
	dG75Hr/JckeLRIh56G085HNG92Qp2OBbC3g8gSDnaPRYMHtVjUj4oyTaYPqbOAynuLzmVj0qCz7
	VsRVrVMck0cuW6nHCog5jQSQ7IacNdtNA6S8SZ3jCoEJ/L42yXy4AhSBfw3Y5ccfa0Z5+b3UfSw
	atT4Eq3q0TG09wYfhcfc4h+vnYbWnwZ4h2xb2dV0Z0rvhDDu4eIZ8zud0gcy2g2PpQteFJQ6hxo
	0hcuiZETEhSJbx+4HCS0fiiTEBjNwfHI1oQMmP7lWqKgj7q38CLlUg4/RS9mXFDKOOb8QCNuksY
	0O9A0MeGNhXrWfJ4W433Kh91WerHCLWArqyA3EDrV1V2MVOHUZ1qtXcu2C8sg22f7iJI7iVhO5w
	1E91w8p6EqbKB/onxN3sRwn1gcd4eAMzfap4GxHhe8+4LYtTg+2
X-Received: by 2002:a17:90b:3f4c:b0:35d:8ea1:62c3 with SMTP id 98e67ed59e1d1-35dc6e43b1dmr4400337a91.3.1775060739077;
        Wed, 01 Apr 2026 09:25:39 -0700 (PDT)
Received: from ip-172-26-8-186.ap-northeast-1.compute.internal ([2406:da14:e8:bc00:e546:17ee:7142:6d05])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35e34eesm281813a91.2.2026.04.01.09.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:25:38 -0700 (PDT)
From: Sheng Kun Chang <nothingchang@mirrorstack.ai>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sheng Kun Chang <nothingchang@mirrorstack.ai>
Subject: [PATCH 0/3] Move adis16203 inclinometer driver out of staging
Date: Wed,  1 Apr 2026 16:24:54 +0000
Message-ID: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves the ADIS16203 Programmable 360 Degrees Inclinometer
driver out of staging and into drivers/iio/accel/.

The driver already uses standard IIO channel interfaces and devm
managed APIs. The only missing piece was devicetree binding
documentation, which is added in patch 1.

Patch 1: Add devicetree binding documentation
Patch 2: Fix MODULE_LICENSE to match SPDX identifier
Patch 3: Move the driver from staging to drivers/iio/accel/

Sheng Kun Chang (3):
  dt-bindings: iio: accel: add binding for adi,adis16203
  staging: iio: adis16203: align MODULE_LICENSE with SPDX identifier
  iio: accel: move adis16203 out of staging

 .../bindings/iio/accel/adi,adis16203.yaml     | 52 +++++++++++++++++++
 drivers/iio/accel/Kconfig                     | 12 +++++
 drivers/iio/accel/Makefile                    |  1 +
 drivers/{staging => }/iio/accel/adis16203.c   |  2 +-
 drivers/staging/iio/Kconfig                   |  1 -
 drivers/staging/iio/Makefile                  |  1 -
 drivers/staging/iio/accel/Kconfig             | 19 -------
 drivers/staging/iio/accel/Makefile            |  6 ---
 8 files changed, 66 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
 rename drivers/{staging => }/iio/accel/adis16203.c (99%)
 delete mode 100644 drivers/staging/iio/accel/Kconfig
 delete mode 100644 drivers/staging/iio/accel/Makefile

-- 
2.43.0

