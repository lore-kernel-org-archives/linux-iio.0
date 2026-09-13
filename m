Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D98383C66
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789289632; cv=none; b=E8aNdQjlMFdqhmiyEB5QFKbPOoqcPdDMIIet1TS4VDFjuXoO7KDUTZSd0hYfZTQGryfhKUGIC7p14TcP/JPF/0ekrMfQDTGC98rOk1vnJ0m35kYjnaPuqikQ7f2rQ1JRL/9LmaS1hq6RMt6DgFDMWd7JGpLsWtJ6z7ekAxZi0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789289632; c=relaxed/simple;
	bh=8tYMLwTuWe8fYcGR09huCcpUaAb1MgVXwJPlzqSxY1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNQAeFRYbkTtsS5XtSBMQOzFP2FmNrlm/PNVWvEHrL9FFai3Xyi0BBtYcI8JF042465n0Rbgqx3ryjBr2nYlAKHHNDHNqwx0DxsgCZxTZrkZUaLdHJNhqjGsGxPMK157rBfN29TGsBUbNtNkIsBuP8ImYD3COJLfAKI17ftbakI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTx9s3pW; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTx9s3pW"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-483960225ccso420077f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 01:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789289629; x=1789894429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KSDgB+q40G0XD7B1gkgkSaOt7eTVxj8YhAlhk59D7iE=;
        b=WTx9s3pWY47qIOcvPnHGGFCYz+nqJ8h9z/Oa3CekhHIOthQR5BbCDjzNbwgGvWZ1fI
         mo6nSunbTUgvo7wwq2Gpk1knzjK+dWbNkKaWozaLgvDqjxmew0TfTlrGyRxTuRP4eCA0
         L1c5vBNt8XJuvXsQghs2ogoAMpQCrjNblqTHEbyVDJamSiv0GSZkNdiCuFTWIv2OSgpB
         HasisYFFafil2ybmgRQZIHbqnDyyIWmJsefWMIgpG/Xink/F1LwaYVmi46tM83o8dpqM
         DKDOf+2/PlC57mLIAtbRIxl2pMIrjknHCRaNnE0mLmAJNxjupfVDHMZNIlLah1v9G+Kq
         xk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789289629; x=1789894429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KSDgB+q40G0XD7B1gkgkSaOt7eTVxj8YhAlhk59D7iE=;
        b=rp1l2Ig7K4RMgVAmwT7GFX1A1kuLvrkL0cSjs+AxcL0x/i2HgPpx+hk4MrXhUOtzbZ
         LkrpD1idE86k31mzQJO+chW6DKmBMKwM/cLu0IGMnl6dOFajzUrYosY6UKn6PO2Hgfn8
         5bEq7yJe0HzArl6URIzesV87suW/5ZuH9PgG8sdthQnoviuTIGDGLoUE1Fc10AIbNmue
         g1FMG5cf6zjc5yOVOOkXlDM9bOKUfOQXMHMF4pk/6tANK3B4yjMZNRl0ECfKUZH8lCYl
         n2VH9t6ArRKqBu/WJHi49KImp8Y6fHF2Ch9GAfobIT4lV0/x9XPT5pxJ/3HfBJeWzwqp
         l4UA==
X-Forwarded-Encrypted: i=1; AKwUvBzuQk4GWhaMGtcGv+K7Jrac2qo9Aq7nha7s4ZnFPFuI4xxBI4oogaGQiLAvUs12Jw0EZ1f2rI5ZatQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n36/vtkw1JithizYsX9lb6UMLwrq7yXC7G9Hycs8kPJLR8CBmb
	4H/oWFzeFlNoePgwqpiZlzy0/cCnbd3vQdZjSeadlt+vdNlYqLmAVhGE
X-Gm-Gg: AYBFou2oLCBy+95zCalvxrmKx9/kNTAeQNXLe4yEFD73/JHcGClpEmfut7b9qleoCn8
	7jepEQE+Ab5Lk0vszRngsXgHkIM9iJ+RyeF0u1wdOUZew5AAab5kJ8hfaU8VwZ3Vcmwu8CzVRiC
	61ZXv1mJ3qisYcPDzSUBydNxWZwl1kzS0sYE5EKdkySUa2pjmleQHEtWoV1pyMiJL9HtPlfdnA1
	Ph58QPGIIq3zlwYgp2me78oI404L4CBj0QVmaW6WuBewTDdJu0//XfFX1jHr5Ta27J2iUmg4P+c
	ofzo1qC1BW8GPzajjsmOgu6mQLF0sGgThlulaqr50CFHhP8O4+Sumh7gxrVf0Z1VhDrMNj5mIcM
	B6BgRhQRZFZp8n9jcXOXBa0JRuo7CyfwvjAK7EUfoE2ZYqnUe/3eDEux39ioj1qRAeE7CAQ1kdN
	wS/ig3MPlKYnNjPfh5o5mvsSyT8iO18ED0T9S009bGZyfOSl2AMCjY7/XYdFZOQ8C8mNjywKHxs
	lTTLHQLbahSKM+g+Ds=
X-Received: by 2002:a05:6000:4024:b0:486:f4cf:59b2 with SMTP id ffacd0b85a97d-486f4cf59c0mr7888496f8f.4.1789289628683;
        Sun, 13 Sep 2026 01:53:48 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e7f5sm18228489f8f.9.2026.09.13.01.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 01:53:48 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org,
	Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: [PATCH v2 0/6] iio: accel: merge adis16203 into mainline adis16201 and remove from staging
Date: Sun, 13 Sep 2026 13:53:01 +0500
Message-ID: <20260913085307.13846-1-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v2 series addresses review feedbacks on the previous attempt to
move ADIS16203 from staging into the mainline ADIS16201 driver [1].

Key changes from v1:
- Introduced adis16201_chip_info and adis16201_state infrastructure
- Added SPI and OF device ID tables with proper MODULE_DEVICE_TABLE
- Fixed adis_data stack lifetime issue in probe
- Fixed IIO_CHAN_SOFT_TIMESTAMP index collision in adis16203_channels

Patches 5 and 6 carry Reviewed-by tags from prior review.

[1] https://lore.kernel.org/all/20260831184201.34416-1-shehryar.amd@gmail.com/

Shehryar Ahmad (6):
  iio: accel: adis16201: add SPI device ID table
  iio: accel: adis16201: add OF device ID table
  iio: accel: adis16201: prepare driver to support additional parts
  iio: accel: adis16201: add ADIS16203 support
  staging: iio: accel: remove adis16203, merged into mainline adis16201
    driver
  dt-bindings: iio: accel: adi,adis16201: add adis16203 compatible

 .../bindings/iio/accel/adi,adis16201.yaml     |   6 +-
 drivers/iio/accel/Kconfig                     |   6 +-
 drivers/iio/accel/adis16201.c                 | 123 +++++--
 drivers/staging/iio/Kconfig                   |   1 -
 drivers/staging/iio/Makefile                  |   1 -
 drivers/staging/iio/accel/Kconfig             |  19 --
 drivers/staging/iio/accel/Makefile            |   6 -
 drivers/staging/iio/accel/adis16203.c         | 315 ------------------
 8 files changed, 106 insertions(+), 371 deletions(-)
 delete mode 100644 drivers/staging/iio/accel/Kconfig
 delete mode 100644 drivers/staging/iio/accel/Makefile
 delete mode 100644 drivers/staging/iio/accel/adis16203.c

-- 
2.43.0

