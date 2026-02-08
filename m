Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C535D617
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770563130; cv=none; b=ZSqmEpqvK8zXsTTEGOzMh/kjFgwXurffFt0HwjKCBokBLwZcT2plBdxtrp4UbBsfok6Dr0slbjkqVLDJndS63gtSCtas/9PFF4hZ05fzln5GYF7R9PEh49GQ77r/DpoGP7VlLDDwf1mzn/kJHWmrNmuTgvJ1XBKz8edI2NAmjI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770563130; c=relaxed/simple;
	bh=REzYKaXLBwoE4Plvf1gN5k8tJVJVi4O8VE71Wbri9PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXQN7yaDohtdI8jtFJjUwrm5qR7lilIKdFDhgsWLziYKSXDF8wicKU4ffnnno8qbR/VoyxdeF4Jrjgd5QXAzsGFHWP5oOUf8lns0wQhBQYSN90YiHYInIQo4jbDv0Cnvm+bJOSJtdPZ5/AdofLVYMULfv21w5r+uvjWJ3l4FOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV3k0c6h; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV3k0c6h"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso31273035e9.1
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 07:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770563129; x=1771167929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cHsiJILP6hpkRCgoXucesB1BnAyegGp+ZNei85NfukE=;
        b=jV3k0c6hIdiomZ/9bmD7NuxV1AkHhjvI1PGSbWbRHpn3gkTIZFqF+TC3ItYVsNP3VO
         F9Y85VdAbweKOPvWMlV9KdUr9PkmxMXdXsXlmz1jUapb6OnIsU18mHJxVu+9I2N6qoz7
         iAsPmiLhYWhO4KVDknjmCwbCgp5EVVL9Nv2hKYGs+2T1HMqNv8fyPPj+/IsvLgecptxH
         gQCoEjNWq5d80EwcMqVV9j8f4b7ysiAWCtDcWwiPoqDJgs//f9sMdW6Hb3Pa8/fCUIYo
         9W2+2RrcttqgmF0oVEkCbtqDERGZm8DHF4HXTUKpnXgIp+Xdfz6UwpTV76RRRyHZJlMP
         uhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770563129; x=1771167929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHsiJILP6hpkRCgoXucesB1BnAyegGp+ZNei85NfukE=;
        b=ix/xN+AV4gpYV71r3M00+7TTnXtP4sqxcgD78lwRhLI+0AkGVEkuU5gIc79ptiRlA0
         NH/W+xBtYkHxVNZfad8miTEApwl4CjhbPLep9Ni2X+0MDRALzt73JOBvY7KPcivjj/jf
         CZggzxtTEdTxL+mRPcQMck9gVWy/TJgy4duX+/xoLIydZ7pPgVltK5Ei77yKZZPCyXJW
         tmPt3alsO6T9TVZ8bSKB9twl2XyBX4ll39lwnHIb3x5IzFRjob+mMfGerQFYJfD4Juhr
         B6Zwf+3j3e7ApDnYeo5+4m4NWCxASachsijojnD5BPs4WMAi0+s1r/L7G78u4/s84IuR
         oepw==
X-Forwarded-Encrypted: i=1; AJvYcCU6V6Pmi+wrx4Fdt4x7ENjqZgoghkQI8LmxpFUK2H2BYsJRvNiymxzBL3/GCQGCS4+QgWzmltS9k8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnqWczLKJHYJK5a+3roPlKWOcPK4Pj/T6It5lHED5ilmrKveC
	qoSIV/3ZmWidLY8auBr/cr5zP3Vl0f2D6JyfQYtoB+Ao8DXzzGH2RPLK
X-Gm-Gg: AZuq6aJYjvhAP3KkdfX7VdKhT+jUv5PgnlO2EJE5YikDEon948qkYMS90f//iSkZ0KL
	nzo6p14p5aqi9j6bGmXTLi2+AIxmBlROcz+UFjwKPDVE1GowUZlSKYlv5m85ma7GkRxYCWcBR56
	wgdY6n7ky4r/StLdkMbfzoTeZ0WICgAbFE9eVbrZOjSBPSfxCbOdXHAQl5tS7rPs1IwI1qdVzKz
	bxVclImor34AX6iPi0L8WzI04B1daEe9rmT3su51KKdY1o0eaKESesdkeSr8MF/f9v4aH989igG
	QjG9UsGYKw6kTCltf5K62K3k3CQEf8fQtbE3L34mhsBuaQQwVg7DR66URvOYH/aWYyylZ0FDXQw
	PCcqfDo6q+SdCHyVqtDMMxlZdCT1WcLjFHOM08xs2WSDDXkYm6oqY4ll0NXOpQBE+aJtJDPkl4s
	2uZvkHb5i4NgChzf26yIZYzGDp2GDo7a86c3B5sHWCPL9SbBkwzw==
X-Received: by 2002:a05:600c:4f4d:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-4832096698bmr114979165e9.19.1770563128638;
        Sun, 08 Feb 2026 07:05:28 -0800 (PST)
Received: from DB-VM.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206cc7d3sm179326255e9.5.2026.02.08.07.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 07:05:27 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v3 0/4] iio: accel: adxl345: Add event scaling and doc fixes
Date: Sun,  8 Feb 2026 10:05:01 -0500
Message-ID: <20260208150515.14798-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses ADXL345 driver non-compliance with the IIO ABI
for event thresholds.

Currently, the driver exposes raw values for thresholds (e.g., tap,
activity) without providing the necessary scale factor to convert them
to SI units (m/s^2), as mandated by the ABI.

This series implements `IIO_EV_INFO_SCALE` in the IIO core and applies
it to the ADXL345 driver, ensuring that userspace can correctly
interpret threshold values. It also cleans up existing documentation
errors and typos.

Changes in v3:
- Patch 1: Reverted "axis" -> "axes" change in documentation as it is
  used as an adjective (Randy Dunlap).
- Patch 2: Reworded commit message to "Implement support for..." instead
  of "missing from..." (David Lechner).
- Patch 4: Simplified documentation table by removing repetitive scale
  values from every row. Added explicit table entries for the new
  `in_accel_gesture_scale` and `in_accel_mag_scale` attributes instead
  (Jonathan Cameron).
- Patch 4: Fixed "inscale" typo in commit message.

Changes in v2:
- Added core infrastructure for IIO_EV_INFO_SCALE.
- Implemented event scaling (0.612915 m/s^2) for ADXL345.
- Fixed technical math/decimal errors in existing documentation.
- Cleaned up grammar and pluralization issues in .rst file.

Taha Ed-Dafili (4):
  docs: iio: adxl345: fix typos and grammar
  iio: core: Add IIO_EV_INFO_SCALE to event info
  iio: accel: adxl345: Implement event scaling for ABI compliance
  docs: iio: adxl345: update math and examples for scaling

 Documentation/iio/adxl345.rst    | 65 +++++++++++++++++++-------------
 drivers/iio/accel/adxl345_core.c | 28 +++++++++++---
 drivers/iio/industrialio-event.c |  1 +
 include/linux/iio/types.h        |  1 +
 4 files changed, 63 insertions(+), 32 deletions(-)

-- 
2.47.3

