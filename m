Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4697D410D0F
	for <linux-iio@vger.kernel.org>; Thu,  5 Feb 2026 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304067; cv=none; b=ZjRu4FSDCrhLNv3n0ihN5AJ86XGkX35AXdDGvyD0eXeuoo/itJN1yS2vROLVT+cTgHccHmj80aLNQAeKaQFJmmt5zDXMFFiOgN60SIi1UiF4B3qjT8J2qfCHcQA/GXo/CmBvr4JXDRl5x7Nnt8sCD8kwoIrQW3gzVFJXYXE3xZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304067; c=relaxed/simple;
	bh=fqTz05JeHTFypfG0U1BlGozBV2lG3rX8sQTfDRxWegg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DBPH37cjntdz24yXB9OLE68+3Z1XzCVzIQvQz/O3Id4Ot6F1d0zh8CsQrykyanU2uJARWvMfsgJ3tVaQMf65CmZhLBHYOKR9QrkQqNwUqCw4DBdDPW7MN7ATAccDPrBMA6NFyLlyNQHZSGuFNXzhED3R1ruNTIE36z5JhNmyoxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fra0zjtu; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fra0zjtu"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b834e17c3fso939570eec.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Feb 2026 07:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770304066; x=1770908866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dF+tb1gguJoM1jCSGUZAY+vHVI+6s3nIhtyjPFjvk/4=;
        b=Fra0zjtuYE6gorlSpxnwNjeHjkRjSjyvRbhYedoGDUg1inN5QBkTHPX0hIP6xOyw3T
         oVIlpEHofGT/mnjDc0Ek71aGIsi32Zt6awxzu81+FHcUIiEwxRSh4l0ME7rdqJsBweRX
         SUeCYDWnKAGBaCW9ObNu+X0HF+6CPuNbAGnlW0snHkXXaHWaE7dJlHQsLSu5i5eD8XLq
         OLEAyPZM17vgwJ4bgrDglBmBIAEQy3csheDFeYoJBD8axEJst1iLLEEYsc2OK658KoVq
         EK00QMUOgukHHqlZmxl2i7o1N97BKfowBqfYBFhu/Jccc0HbSmdztQg25XYIU7jzNsRM
         Q3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770304066; x=1770908866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF+tb1gguJoM1jCSGUZAY+vHVI+6s3nIhtyjPFjvk/4=;
        b=SRXr6vkBLTtjoi9FH3zraKfnXSvUeuLKbhtj6YWj3/Ikibu0enfEhPBJWAYJCod5Xe
         XeHERu6x+5GeXRzJg07KGyc+zruKl9bulUglqBWYp+nq97/BHXxd4Z1JquuM4M4dGzR3
         N2y4ensBz2ZhW+aHIKe/1My0eae0lT7mBqPiRbNLz7p0kmCS+EGG+7cGz+d4fGa1j4Lw
         7hTE1O/KFaiEIbGbGsptN+Cp7YtQ+rBrOVeNHWGpt6ZuHTdhzdCuFPb8H9HlQvCNgmLt
         QTTriTjx7WCAkg65bFdNh5/ZUXpLT2G7vvSQtkXThPDmaTh3BhRJmV3Zt44P0lQMld6q
         VKdg==
X-Forwarded-Encrypted: i=1; AJvYcCVcRyQ8z4nxi50kBLm0Cl8Z2zrs9OgVsaQM0olJMuG0fSwzLKK7tctegQCWPF+ZifmzHOCHfmjSDvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWuYYhew9T/9CdZp/5V2JXpyovG059+67T/uax7UrrlS2xHFR
	3+LSOUEVwBv+X0t/TkHxyzp8sUNvSm67JYFSlLnGuF3kzxU6mTcDHxPV
X-Gm-Gg: AZuq6aIS1we5CIDAGskWJzh9nBPkbPVNIOFmJmJVxjZC1W1Z8ENERabsyylmhzuMAnf
	5iFsffx8v/4UmSDIO115t6wYGghrAHyz4ta+lpFksfPy1cSA1IbBFU0XckuqIoIuydsnDiPJ6/G
	iIzyO3yq8RRbepo60kzCbIAEu6CuZ9V8olS9j+ykBbMdRGv4Gm9j2JLK/7H3BbRSbPYCXj0AMa4
	1gFljGtb7FERaqd6jtK51BNck4RJNXIU2Z3q02g4vIIiW6eV0ILWVzF4dlb+/VexuHOrPPN6PP+
	AOsRYXph4EuQfKRxOKyN1mFkmmJoUbt1VTnRbe26Av8PNsHmT8jYqRHijth5RnARc9P/dyadEcU
	qgP8BKn7HqVYbRz1vvCZpJYhdu7uqSNycdGZ1XwJMnu0qwaqoBBbcDGsbSmXadJw05UdEgzBxu+
	cFeReQ0x31
X-Received: by 2002:a05:7300:6418:b0:2b7:857:db6a with SMTP id 5a478bee46e88-2b832979ecdmr3268252eec.21.1770304065550;
        Thu, 05 Feb 2026 07:07:45 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a52:d2b1::1004])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e04467sm3909693c88.2.2026.02.05.07.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 07:07:45 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: linusw@kernel.org,
	stephan@gerhold.net,
	hns@goldelico.com,
	jic23@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v4 0/3]  iio: add support for Bosch BMX055 IMU
Date: Thu,  5 Feb 2026 23:07:27 +0800
Message-ID: <20260205150734.525947-1-jerrysteve1101@gmail.com>
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
be reused by simply adding the corresponding dt-bindings for fallback
coompatibles as follows:

- accelerometer: bmc150_accel
- gyroscope: bmg160
- magnetometer: bmc150_magn

Changes in v4:
- Please replace underscores with hyphens in the compatibles.
- Link to v3: https://lore.kernel.org/all/20260203143946.301233-1-jerrysteve1101@gmail.com/

Changes in v3:
- Drop the Linux-related comments in the bosch,bma25 dt-bindings.
- Link to v2: https://lore.kernel.org/all/20260202110304.236320-1-jerrysteve1101@gmail.com/

Changes in v2:
- Use fallback compatibles instead of introducing a new device ID in the driver.
- Link to v1: https://lore.kernel.org/all/20260129071105.389493-1-jerrysteve1101@gmail.com/

[1] https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf

Jun Yan (3):
  dt-bindings: iio: accel: bosch,bma255: add bmx055 accel binding
  dt-bindings: iio: magnetometer: bosch,bmc150_magn: add bmx055
    magnetometer binding
  dt-bindings: iio: gyroscope: bosch,bmg160: add bmx055 gyroscope
    binding

 .../bindings/iio/accel/bosch,bma255.yaml      | 40 ++++++++++---------
 .../bindings/iio/gyroscope/bosch,bmg160.yaml  | 12 ++++--
 .../iio/magnetometer/bosch,bmc150_magn.yaml   | 14 ++++---
 3 files changed, 38 insertions(+), 28 deletions(-)

-- 
2.52.0

