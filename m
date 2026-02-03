Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21085EEC3
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129601; cv=none; b=sCwVwrZECICjtJ6a48Ydy9eLtncJuto3AiUhvs76a9iyJd2vItD9tZ0hmpU5zCx9QaZQuavVFBHELut/wD1aD5Gq5uUvhl1XYPxjcK6MdsuRAlXMFYUZ9JIOPTjGb15EWSmAhDbFPK+FZFDnEIYCKWLfz9lIlX8sklCFhB8WbSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129601; c=relaxed/simple;
	bh=TvRD3AjguO+xjUqd5XxbM4RKLrlp9TFG7KID5RJdo04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aqwIFHL/aqhoXIIXeY8hoIrhw6NY5Hq+t4mlHb08CP6ngOAvGaET9EGExCYy2VgYAn3Q/f+vFhxAC80sYbOF0t7u8tZjftouo+ia5KUseKOZqEhPqjc5HglF4dLFmPHm7O3Ucrmejku2ya+5KSyH92QFxHZbBbp/zmx2sy5iF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP9BQJdO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP9BQJdO"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81ed3e6b8e3so3025635b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 06:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770129599; x=1770734399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTGhqVzKjFBVm5+ZaNpYJl4UXsnqfPGrO5qDUt4Kj/w=;
        b=KP9BQJdOHPWJeFUh7hOlQ86M9Det5hi0b75JX7SbmW2UwuGAcHJsILdt3fiPehJiBX
         Q9jU/C+/Am6tBAP2B4K9YH5prZxxTKQk6FfcxLmM0tDZJ7yuN9EhfJYAxBEW9lU3GnUg
         628XfLTk7AJhVnIHfEd3kZRWOe/eqvxM7kOoKc/iy+vazRaqJAnjQ8yyN9CQO3U0C3C4
         zogI8uVPNnnwbAaBje/SS3KB4K733hKdmZFb9iEFnbW2fT01p5+ookaZMfi7rOHc6JNj
         +3VreNv7EGDanfllv75LdWjpIrhtu6dnnuQ8jhBdkljob70W0Sg6otR8DXVNdcKgKwMe
         90TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129599; x=1770734399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTGhqVzKjFBVm5+ZaNpYJl4UXsnqfPGrO5qDUt4Kj/w=;
        b=Gr7Ozh3mX67UTECe+Hei/173w3x0iO1MOKKO1mepuX9aBBmFWUcnm9U+I2zlIJOvER
         oNIqqiYpDuhFQqdUUrAyu6JGgWsfya5napiOHzL3YEryJHjMqEHJ5GL8EnCvGlH0XdFp
         pokemkfAM+i6ynxaK/F6OC7fldBvMF2S9q5v4rzmpGAN7FXo5FNBTYx3ZTb8rARSwyEA
         xWcjziPsS6Cl6bQUVZWJp4+3cb7IQHhhtxgr6xP9rD+mqUgV52LbRbB1loK8cg3dCPQn
         FuNW25NZPcDRMYpwnbRx2HGntcGmKHog/j0hPxZFtI1Buhy/PG3VMGMOpfAT3EJbfpet
         CeBA==
X-Forwarded-Encrypted: i=1; AJvYcCVm5ysHUvQOncAuN2k4a4yTOdsgeOZw1Vytmz6y6ij0fs24aiDmH2egn2OcDXrYENfWuPZ6UYtfPdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YznWV1TsJDrpOw0OM50VQk3gA8Dj7oQW80yEylU3DbSlBfe46uu
	Fxu4VGkmyxSHVLlhl4x9Upf3BqS1dQa1pHPA4STNk/ttYezAixNleBiwuUl1HoUL
X-Gm-Gg: AZuq6aKTbFIIEgYNN03cF6mLrtVI9eJnVTj6ywJbGO6lzhG6nKGVOORWcLPsi8femTz
	e4PRmlakAhTUY0rzGnnA+s4gxxQ3T4+fLIxYo+MbMyvwrttjYYhc/QObUhK3TBs4dZzfQP5Lsod
	PRx1AjBwtLxTOeokCkT8VtlD6NnjTcNSQx7F9sEL7Ebxv+UgbgXYKuBLi7Ct2I7k4ac0LMWE/aw
	jOZQzd5o5AT0oqBauhwxNMXlrCuZSxtbNEZiL86lsM306GH+pJFAhFKrjgM7kX2bsCt+EVZAHZT
	FJzou+YDT9rK0aPGNVQrKsfOEEJiFIS2d87NmLlA06ATBw4YFCOAlHVng2/H5j2GKmhBYRU3Lnp
	GYbV23zvKiFWgah8RwcIbjesP2ik9cFa8ntNqkSnL06jS0RtlDT3Z6l9n0nnq/CY2LMjRU7g8mh
	PvLfK846LP
X-Received: by 2002:a05:6a00:39a9:b0:81f:be3c:37e4 with SMTP id d2e1a72fcca58-823ab67bc4cmr13036552b3a.27.1770129599262;
        Tue, 03 Feb 2026 06:39:59 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a52:d2b1::1004])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1ee89sm19810313b3a.14.2026.02.03.06.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:39:58 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: linusw@kernel.org,
	stephan@gerhold.net,
	hns@goldelico.com,
	jic23@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v3 0/3] iio: add support for Bosch BMX055 IMU
Date: Tue,  3 Feb 2026 22:39:40 +0800
Message-ID: <20260203143946.301233-1-jerrysteve1101@gmail.com>
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

- accelerometer: bmc150-accel
- gyroscope: bmg160
- magnetometer: bmc150_magn

Changes in v3:
- Drop the Linux-related comments in the bosch,bma25 dt-bindings.
- Link to v2: https://lore.kernel.org/all/20260202110304.236320-1-jerrysteve1101@gmail.com/

- Changes in v2:
- Use fallback compatibles instead of introducing a new device ID in the driver.
- Link to v1: https://lore.kernel.org/all/20260129071105.389493-1-jerrysteve1101@gmail.com/

[1] https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf

Jun Yan (3):
  dt-bindings: iio: accel: bosch,bma255: add bmx055 accel binding
  dt-bindings: iio: magnetometer: bosch,bmc150_magn: add bmx055
    magnetometer binding
  dt-bindings: iio: gyroscope: bosch,bmg160: add bmx055 gyroscope
    binding

 .../bindings/iio/accel/bosch,bma255.yaml      | 41 ++++++++++---------
 .../bindings/iio/gyroscope/bosch,bmg160.yaml  | 12 ++++--
 .../iio/magnetometer/bosch,bmc150_magn.yaml   | 14 ++++---
 3 files changed, 39 insertions(+), 28 deletions(-)

-- 
2.52.0

