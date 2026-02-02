Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42C35DD1F
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030200; cv=none; b=TTOeNLzvaogp5e1LZ1hE4ws0Hq6zsU33NtxKAALaGzeY9z8isziMgAq/S0jU5CO4PAbZDKQ07BQpzhImkEHG5OrV0lNQgWKG8g2ixSWj1al+D0U74hXebynp+cfTUEkZxDwUra5HxUQHrS8F1ru/FGGeU+fIFJBlxt21FpAwolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030200; c=relaxed/simple;
	bh=+j0EnP9zt4LTBAyPPEyYHngmnoaaX8Pl6yaSjAoIlY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XrC1NKTQy62xm5mbegVuIafnid/3BLWBKLPkWt9UQn4uMuQ/LMAxpg/TYgqdD0lJBrxvjHehozO5LKbPjWj099SHJHMEwadjZOMcxAKTr3VNqBOjd5yDl/I/I5/HmrLkoS/6jEi5RG7T6V6rhzK6WBwKTSakgAgKxzbdihEv1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cChhY/a5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cChhY/a5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a77c1d5c3bso19052325ad.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 03:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770030196; x=1770634996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LbWtZXsDcHnHf1MTiffLe3lEUWNoWKZ3o9ZwYaD4P7g=;
        b=cChhY/a50HiWsqalSDil5VxFWl5a+TJjYJLBxnzFnTYMt9VPsipSpkK3pdxZePpJv4
         XF9WA9Iz8h/DxTlaLe9o+uBOJG7BNjknhftRRhLGjuZPTYXPsjm71kqTbIcM1Ea5G4Is
         DVmuOGdbQd+bBh+njSjZDZ/dZAaWv2CQH1vlqgb77aWPuk+STVBE+P4Yn7/SKE3p+Yi4
         W7QA1OjOMZbnfOd/t1TR5VeW5oI79XT9pukSICJ1wBvlFCD+VeOifF9ej0/d3IOB8uXg
         KuPvt8B4XEEAKBQaDVIvsDHspEBCPJTtEWh7e13D6cOPswo3pbOvHmkyIy9ZhBOauYvS
         kOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770030196; x=1770634996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbWtZXsDcHnHf1MTiffLe3lEUWNoWKZ3o9ZwYaD4P7g=;
        b=turaJx/TsVew/IAHnVmXI7NFljfyZPi1vwhC35p7Oc7XtsDGEOe19G3z64MLan1WBx
         +I+sAczUVMaZ7dRBWbnq1yTp3/puBAC6yaBy530/UKIMDMgnoY8/ItDQz8vbs5O9Op2b
         uNDDQmHLdAQRGnCte4mrxkcMkdlzIz3UaAGJGv6+DUE3CDkxtT+5cgPI5O2DuU1CxsMf
         BuRHFz8clSiw29hEvp08nZYS848nkkldENQSX/1rTfs3VyPnphvrUNb7Iban2fAZeVff
         DwAxxG2cCdwYwgeEfWqDbW9KlRkTtN1f7dOvB2wkvCsQis1leCTd1If6yXb6ErJLcqWd
         tK/g==
X-Gm-Message-State: AOJu0YzcK18cGlOc5U5904xzK85xrq7tQk8/SnX/Rh9XE/8hf9HtKboL
	+P1y6fIjbsxEKwftYaLgcJLPhiVvE29w4wwDpcslG7bpBQ3lFaee/60uTGa8dA==
X-Gm-Gg: AZuq6aJjfaL2NGCKvBxr380dDqqTY4G+I0Px7y53spRxyiVzFZW2EByLRf6fDkEbutK
	G/dAHk1EhAj6kL0i+58dWtAprfjtwdn/+JX7oggsnGUvAAKG1X6P+cMD9gXHpty3IDgTOp8otn8
	rPzQ0mn61Sg8yAHw0s0amM/9K2NKd/LzAtnioMfRopmXMO5B4Fp4cXO4LePSbZpHsNU43Kq5gMF
	QwUYVHMgNkf81l/C17FBXMkv9EyzAZQ4FjJIOjwGo7pcmL2WAtzKvrtujTVi4nads2FhGf8aGeL
	aCr6x6kbCZuVqSeUVyK+GYaVSFiOF9KKUF7bE1bENyatWj480MPQK7lPty/6C1HMrw/1IdV1LxE
	JlnKhP+Ttp2EvHGe4/im26EjiGSZbwq4Q/CGvUIy4+YofkxMa3Em/atCDOqIw+/YOF8Y0ZxQYX+
	RHIi4fXTb1
X-Received: by 2002:a17:903:41c1:b0:2a0:d074:e9f4 with SMTP id d9443c01a7336-2a8d9a55422mr112278165ad.59.1770030196140;
        Mon, 02 Feb 2026 03:03:16 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a52:d2b1::1004])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5df0desm144007105ad.82.2026.02.02.03.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 03:03:15 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linusw@kernel.org,
	stephan@gerhold.net,
	hns@goldelico.com,
	jic23@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v2 0/3] iio: add support for Bosch BMX055 IMU
Date: Mon,  2 Feb 2026 19:02:57 +0800
Message-ID: <20260202110304.236320-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The BMX055[1] is a Bosch 9-axis IMU integrating a 3-axis accelerometer, 
gyroscope and geomagnetic sensor. 

It supports SPI/I²C interfaces, and existing compatible drivers can 
be reused by simply adding the corresponding device IDs as follows:

- accelerometer: bmc150-accel
- gyroscope: bmg160
- magnetometer: bmc150_magn

Changes in v2:
- Use fallback compatibles instead of introducing a new device ID in the driver.

Link to v1: https://lore.kernel.org/linux-iio/20260129071105.389493-1-jerrysteve1101@gmail.com/T/#u

[1] https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf

Jun Yan (3):
  dt-bindings: iio: accel: bosch,bma255: add bmx055 accel binding
  dt-bindings: iio: magnetometer: bosch,bmc150_magn: add bmx055
    magnetometer binding
  dt-bindings: iio: gyroscope: bosch,bmg160: add bmx055 gyroscope
    binding

 .../bindings/iio/accel/bosch,bma255.yaml      | 43 +++++++++++--------
 .../bindings/iio/gyroscope/bosch,bmg160.yaml  | 12 ++++--
 .../iio/magnetometer/bosch,bmc150_magn.yaml   | 14 +++---
 3 files changed, 41 insertions(+), 28 deletions(-)

-- 
2.52.0

