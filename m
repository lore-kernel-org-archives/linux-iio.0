Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6439630DED1
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779003814; cv=none; b=ARC+p/bST80JsWWCE7VWet8y+3BaapE/iNF3Q7mcZkv9/+oapEbBBRnXRq8x3yTMhaJr1equGYBAX+Wor7yIUj1/Unn5LwcI6WCyFDLNg/wGdACzH64fhv6soMWRNbHgBt+JH7Sc3M4LLeqbWqYJuKmOH56qWmnyoIdaBRZv708=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779003814; c=relaxed/simple;
	bh=Y+Ex24d/as2CHkwX1uEjCtuYJgz4R8M4AkquqzZdRGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uubI+ZHG8qunK7yto3IJo2DBjCY9LMD8+MTTmQXtI4MGDN/ZIatqjB639+OObWXhnsD7ZaLVpnb23AygpQ1dn9IJZB64MnnCQhuiFpPRg9wDM07/3aDfPx9KkH2ATyZxYAZIZD/Mt6nR2WKes+UYq9Uws+dOu8WfdfszSyOwxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejglwb88; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejglwb88"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-459bf19e87bso598499f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 00:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779003811; x=1779608611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kIN4QPzSpV0aaXXOpKphRYVC2gTnp619k6g01a8YFLQ=;
        b=ejglwb88a7xr+VNBcXRowPG20Fb4Ffj/yk9XWlHVovJLEvHQb2KNJh8mqIuBs5ZkA3
         MXbCNva6vdDuvZKqNbQ6CeWdbTWCQUbtRF93XyKlCKaTVvuhsZig468MInSZxUKnsuJk
         4hmEiCTmAOIREGGzoLyJye8ZH7Nv0/kDGEWQ3xijEJ5+IM7bC6uAi1ReXE2jen4R1AVg
         W9R+ukHqmBVixMrZkq5fmohIsW/gRWZFVdjm3jhLLEtUz/ASn0aHUiNpo8mlUzMNnBZx
         7XBgDCLQoR62JnYpvUG5nDFbtJf46W9AVqQfOQEXT+ZhBiL6akdYCjgCYlFSOV52Loh6
         rkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779003811; x=1779608611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIN4QPzSpV0aaXXOpKphRYVC2gTnp619k6g01a8YFLQ=;
        b=Biz7Vc2yQ5+1praM6X++Wnm/59SMBhjeACPWp4UdctbeYHNfGpy751XbOn0MYVxr8K
         lNeF+uXqb+hvANBwydMhUXED7Kzy01EVSRJ/tG+GDpZgiJCrf7DMCG4ejxRms/hGBIwc
         4IIgRLqGAZl/B9E9i7S2Ulyl5HjmxMA3jj5FLcT0Yo8o0GlqnG+dwsvfKok7KCtFTRFd
         RBktJT13hlGCwjlrhFcgDXeVCOX4fkMzcX0a0GbnU/O+0jTvh/4AF/ndC2NzlC5bXYjv
         bAZ8X0tPJhgyXAkaV0GEOpCh6TRNmtehIl86Ir5nyoPXNGj0G3D+4QL3mFdZZ872z/5a
         D6dA==
X-Forwarded-Encrypted: i=1; AFNElJ8VfQIpgu8WlDVAkPQeHDOfr0lGYNMO3yNjwtElHCOARah9Lix8uuSfeJL7y7N0kJXCwws014ZNP3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi8GjgV+8XBON+jP02pl7vId7SSPh7dnN9V9+AWz85h1IX/t6Q
	pI39uGnr2yoKBi0R1aJzRS/3qf2DdFaRXC6vntnLduleai8QVALCLErx
X-Gm-Gg: Acq92OGfIO90FPTJZGUT2ytKma3GakrkzIKJQsUBbvfZmqAcAIBrj8JY5vhzq5d3vu9
	KDyPYYCGqljF6fKUknktiywlZNNcJ7ZU/PLVP5xBc8O/Xo/NzvqqUJby9T8mTsCixcbQiiiEemL
	4YQHEuME+XFOMmRg6Mo1IKl4TUN04atANRkYyDaw+k+D6qbqY6ctUtFoYEKl1bYyYiVPLWKB1/T
	YRNA4qSfO5/4qm9nhmAiD8IGs8F//h0686SYRoRsIBaSCqXWnxVBkccjs3Y+SdlGOq+81tEJFtg
	8kXpQLbMoMhKHuu5biaY7PcKco/SaRBt2PdWPR8BQ/m7DiUBhHsPoIJKwhyHuPy/pxiOQ1esU9p
	w1NgDkxv3JY/mWgaKZdqBFqE3Er093P/pmotTsiWO9PkWHI9o8Nv15DRbj4F+5ho2qh2pv/HuHN
	538zdPd0rDcswb
X-Received: by 2002:a05:6000:2302:b0:44f:c886:89b4 with SMTP id ffacd0b85a97d-45e5c589d83mr15861004f8f.15.1779003810524;
        Sun, 17 May 2026 00:43:30 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm27512864f8f.30.2026.05.17.00.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:43:28 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v1 0/6] mfd: lm3533: convert to OF bindings, improve support
Date: Sun, 17 May 2026 10:43:00 +0300
Message-ID: <20260517074306.30937-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert LM3533 to OF bindings, add missing VIN supply, add support for
setting mapping mode and LED sources based on device tree. 

Svyatoslav Ryhel (6):
  dt-bindings: leds: Document TI LM3533 LED controller
  mfd: lm3533: Convert to use OF bindings
  mfd: lm3533: Add support for VIN power supply
  mfd: lm3533: set DMA mask
  video: backlight: lm3533_bl: Set initial mapping mode from DT
  video: leds: backlight: lm3533: Support getting LED sources from DT

 .../leds/backlight/ti,lm3533-backlight.yaml   |  68 +++++
 .../bindings/leds/ti,lm3533-leds.yaml         |  66 ++++
 .../devicetree/bindings/leds/ti,lm3533.yaml   | 190 ++++++++++++
 drivers/iio/light/lm3533-als.c                | 123 +++-----
 drivers/leds/leds-lm3533.c                    | 117 ++++++--
 drivers/mfd/lm3533-core.c                     | 281 +++++++-----------
 drivers/video/backlight/lm3533_bl.c           | 123 ++++++--
 include/linux/mfd/lm3533.h                    |  52 +---
 8 files changed, 660 insertions(+), 360 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

-- 
2.51.0

