Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC9378D93
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776587512; cv=none; b=QK7smij0s0aO0K0wxv+lc2PWspHVUSI7ABLBPTqRdp1HLV9YDIjxflJ380gu8czmnTD0qj58/xc6FzFiSdpAVrqMHO7fylj563nnsoY1kjaB2AhOPYtoy+g2CuWIhGxx3qyFdfzq7Ky2x5xfZCq+1faO2De0t08HhKfQYKmcAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776587512; c=relaxed/simple;
	bh=gnrgxSiEplSwxVqqHjj5p4vKQYyPxU64rzdSlduHd18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dv7jFzJhVD8v3xVQMelyM6gSR6e7Ov0cGchBSQ4Qx/ss+ekPacQKKMto3q3E9g16ox94OCaIW5UZVOh+VR0P9aErGhBK3p0AxhL/aECesJs0055J098NPskoxTcjFNEl5pqX3YAosn2JmgeE9kroIycmULmfYFI+NoH6znaiqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhAubaXY; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhAubaXY"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso20493511fa.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 01:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776587508; x=1777192308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qM81ziYzPfu1Cz3YKli+lVf5D49rHetXa8ChE8aPwFo=;
        b=JhAubaXYXGF2slYp8hEe7kIwTPNWbqhPCqMfK0suS9zSP6oYYluOxuy826Pn43yNMg
         7V+uUUuId+q3szsjE3UVyXX01XjvjdssaW//juHrEiAk9bNGcgC5FrT2ULjmrM2VsylX
         FaIA5uDSPQsed2AioCfbEBgb2K3VjJAj/Ok1qy4qRYwlr/Kt0NUGIVXHeIPZfpll45DG
         SnvkKojC4wVjx6Q3QWIaFsQuZkQPs7hgBnXba7tDoFyXoPThiHD8ihFQzXLCQRPJR/jb
         3F0g61Hn2sXXpLPZ0dUxnWtjmvBCo/nzeJ0ryfD52cDT0ABZo2Kirres/6BMnw7MZVyP
         iVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776587508; x=1777192308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qM81ziYzPfu1Cz3YKli+lVf5D49rHetXa8ChE8aPwFo=;
        b=KgWwbgqnaKUTvV2IAq2Q0H0r+gXMVUskQeem63MQLlD/Wh6Ld2ziyKPMTH6FDXLhM2
         JogLnLy0sI23Jq12GU6X1ayRuFf9ckEI7sFXeYJMh2YO49axVCvbrkbOrS70Z6FAw8Nf
         MvtikMD0H3Ry0arEKirctA4l7IrfZHTHhfNV339TKperJGWa6D1mc1+0uKA7x9YxauwS
         MP+RkLAJzQVZSd+NatQ8okK/sH75fFL0aGx3dncaSYtFpz/NmZmCoi3rhTtNcNUR2Kx1
         6baBFS8w6IIWcEMUY244LaBA2CwlV3W/Q+H73ALzpz9iuzGiESL67W50M1OPzRpnYZrp
         TJwg==
X-Gm-Message-State: AOJu0Yxqz4DW9jFcCvGGk7qU/PfOfkSAQj83yQOwBrpk5HOwBVNxMtBR
	AVd/AVZj+X2IqS/GoobqEtqZyIqnZSyYwZB4l0Q9AJh2oOGjQFJ/GlaFIlStO0mz
X-Gm-Gg: AeBDietHnHxJuIFb0kekfx8YpB4Y4tRCGRaxOx91Y5AAprfgWe+WR1DrpKqHrS1VjhL
	bsnozK1cgnW6gYE62j81+RqMocLdVUIt/Azjv/1p9IwfLynXemLfwvMmLBab25zGmjShdbGp6u+
	1ozGiC49OTEeOAdoV62n16zn7ePGQ4OlPeEV49qL8ddP5WWAeLa7FCEyAr7cvIUqrJ+YNTDX8+t
	oN4BKd6XOlSaz72ekarFGOVvdGUzPBx5zctj1X6cQ9anLThDWG12fiqSYyHWX1YYoLkpdFatAuO
	rc71Rf+AwL8EePBmUiXI++JwkZy1uIyFh7shCdTnJ7PgCIEFn8TgHuBbmvz0PYf8d0ZmLcnibZl
	Xkehq05oQZqZ533Fri9mh8Zl0FHPkbFkx545Hs+SFK2LNT0K8819M3IExUtK3d56dlan6F8LJ9k
	PWMNDMaOHNcIHW/+3JUS41idH/P+3Qw+YHEg==
X-Received: by 2002:a05:651c:882:b0:38e:9192:b253 with SMTP id 38308e7fff4ca-38ec7b69c4cmr29093731fa.32.1776587508140;
        Sun, 19 Apr 2026 01:31:48 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb7613a9sm17852101fa.41.2026.04.19.01.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 01:31:47 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 0/3] Update APDS990x ALS to support device trees
Date: Sun, 19 Apr 2026 11:31:21 +0300
Message-ID: <20260419083125.35572-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Avago APDS9900/9901 ALS/Proximity sensor in schema and add its support
to tsl2772 driver.

---
Changes in v2:
- dropped all previous patches
- apds990x was documented in tsl2772.yaml
- apds990x support was added to tsl2772.c
- original apds990x driver removed from misc
---

Svyatoslav Ryhel (3):
  dt-bindings: iio: light: Document Avago APDS9900/9901 ALS/Proximity
    sensor
  iio: tsl2772: add support for Avago APDS9900/9901 ALS/Proximity sensor
  misc: Remove old APDS990x driver

 .../bindings/iio/light/tsl2772.yaml           |    2 +
 Documentation/misc-devices/apds990x.rst       |  128 --
 drivers/iio/light/tsl2772.c                   |   16 +
 drivers/misc/Kconfig                          |   10 -
 drivers/misc/Makefile                         |    1 -
 drivers/misc/apds990x.c                       | 1284 -----------------
 include/linux/platform_data/apds990x.h        |   65 -
 7 files changed, 18 insertions(+), 1488 deletions(-)
 delete mode 100644 Documentation/misc-devices/apds990x.rst
 delete mode 100644 drivers/misc/apds990x.c
 delete mode 100644 include/linux/platform_data/apds990x.h

-- 
2.51.0

