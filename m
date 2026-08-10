Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5811043F8C3
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389703; cv=none; b=IEcJ1T+0BpQFDDAcV3byyKwSVeobcxdjq5hLKpwgPDOqGU9bnzRyzwuQfqcwMY+eKNz7OC4HxRYMbwscIjVONU3I/zce5nKJB26xpElnkHAGr4rMaU1ptQHsZctJVRuifmJXPpl3rinx+DICzNi4+1H9XnOonQx2lwFObx+vE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389703; c=relaxed/simple;
	bh=3yuvh37gvldMLTVcp2HWMOsJBUGMmkZte23xJK3JMSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvcuaP+X/9VUwwR5fJC4pLxAvNqK4Bu8zUF8P/GwY/bTNNXPoUUngJ7R5fnVpBcLWYlbfOVNwS/Q21zftuYStkJQCz+F5OOHrFjEFp26xvw3pcQ1CMD9Bf6aGqiCInwtIFabvsBHa3i7Hl8VXFpyzo/xh3JCJ4/qI2CORJ5XK7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kpm5hWeS; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kpm5hWeS"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6685483aad2so3289092d50.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786389700; x=1786994500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g/c4cfg6jpQyViNV1y2+k/TbTPYkzleKc6CPIRjyJKA=;
        b=Kpm5hWeSHt+aSUa+O00s8mm+lGkBfMzBPM1X+ndt6BJIgTNJvnTlfVKDKzMymAcYps
         Gp3c7VjK/CC6pUwBlZW9zjeD4sfRCkbPz9Apc3GxMpBzu67/j4hUwOOgKm7525eCFkV6
         Dw8djuBdWoUIVGHWngR1Fyff9W6rlEjW+QmS3GDYorC3bAK1wlubs2WPioWj9Ijm0+U/
         EroRgkFjmgsMJmtZEDHGVCsxZwBBIq7CjKdbElEmgOgZbuJrxc6GpnJDKL5hFY3aiOEK
         S6KavpmiH25naO8aBS9BRUIDt4F5RAwMREkrlDL9qlZTD5HWCOZfzWMR8JBG0dwsJBXN
         24xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786389700; x=1786994500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g/c4cfg6jpQyViNV1y2+k/TbTPYkzleKc6CPIRjyJKA=;
        b=MiRIeKf2kFUmrqUIswud+j/RZTqPUeg6v97QbzCLehijHViYNjvcpjdjqQlU9a2V0h
         Tj22/bjNw3PYPpbQbCPp7o6jIC3iwJ/GJMdA+w97a5nMBejp06BCAHkix02Lhw2ISEV+
         aMtyha4dGgdk7rnLI2JALtnsEXZVnheiZyQUvwGyZk9B95XkGxpixCFw/y/R2KNyZJqI
         GlKIMVR5fCJjjoHkPoPT1mKnVnmNt1VMuyiEXaT3m8mA6mQnDh8wh7si5cw7NACZ131g
         LTC7oHdlRBBS3bDcU/TRP3Bix1qVKBxN4KDBdcqYoN0QIJcjHZglEpQ7y0WHgN8/Pk3u
         h02g==
X-Forwarded-Encrypted: i=1; AHgh+RocpmmY6UBPWlEfeZNwSzVjGxz7Cq9lLjgtdd3cgb7rjJa3eGLu2S8nP9ec1p0vwqJqjLNGrvotdyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhY5c5xNeWTjiMUz+7DXghynvX1kGenX+Dzu1ig80PNahm5USY
	/GN9r9UF9jfDY5Ez+KNedjvfshaRKfn266HuQVT4M/8+U1/cIjEFi1nU
X-Gm-Gg: AR+sD104W2bFSQXzW/3WKLAvLfwuP5aJLy4Ai/4ZHJYZS74+Gyc3S29F09f5aAz94bU
	gTAKbhy67C2qfxBqYte+aDWKq7pfSosvyeLpaVauxbLFPvhxjfdV9/WQAPrh/CMKNkeRnqvCbHm
	u/DXV25T2EFmhAOBlH1Crb8gu5VmZa4BP7V0GITux7J5I4eJpmCWGpKUIe2wGQ6PT1IIOPlzC/R
	pPoFP8TODbaruSt1RIkVuwC8xDBv+sjZFGyvdC5p0gBi2AZhI3nVkKeW4p+4XKqABnK7KCeGtS0
	ZP2Kxk8wjFSEHl+bR5XmcuKCsTD6VPmqHs7qrYWKufG9NYtKfc856g6c+gpiJRBTAzCwWMAFKsc
	eOSDOxz2xJ4e6c+j44nLNg3IyufhHiklSm31Mity//WSdUNytT30ktbtfPu0UNHyHVaA8iNb0Cc
	Vh8VbQJ94ZItsNjAI+MLtcXc/Hw52SRErjvIInYOywGwqZPNM2yLxQaG8FpoxYYGoW12KBkABcY
	zHvnxkZfWmy1yts5Z7MbEwGixS6Y3xGK93DQH9I2ILzwINat613vg==
X-Received: by 2002:a53:d009:0:b0:668:7fa1:aaf0 with SMTP id 956f58d0204a3-66ad72b397bmr11972611d50.53.1786389700050;
        Mon, 10 Aug 2026 12:21:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:82a2:5c54:b9f5:beef:8bf4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acafa90basm6928863d50.16.2026.08.10.12.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:21:39 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mranostay@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-kernel-mentees@lists.linux.dev,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] iio: proximity: move LIDAR-Lite out of trivial-devices and add Garmin fallback
Date: Mon, 10 Aug 2026 16:18:39 -0300
Message-ID: <20260810192131.153495-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves the LIDAR-Lite v2 binding out of trivial-devices
into a dedicated schema, documenting the power-enable, power-supply
and status-output interrupt properties that trivial-devices.yaml has
no way to express.

It then adds the Garmin LIDAR-Lite v3 as a fallback compatible in a
separate patch, since it is pin-compatible with the v2 and already
matched by the driver, so no driver changes are needed.
---
Changelog:
v5:
  - split into two commits, one for moving lidar out of trivial and
  one for adding a fallback compatible for LIDAR-Lite v3;
  - minor changes at yaml like: title, description, adding irq prop;
  - improve commit msgs for covering the vendor acquisition and PWM mode;
v4: https://lore.kernel.org/all/20260714215433.41259-1-rodrigo.gobbi.7@gmail.com/
v3: https://lore.kernel.org/all/20251102221643.9966-1-rodrigo.gobbi.7@gmail.com/
v2: https://lore.kernel.org/all/20250801224112.135918-1-rodrigo.gobbi.7@gmail.com/
v1: https://lore.kernel.org/all/20250701223341.36835-1-rodrigo.gobbi.7@gmail.com/
---
Rodrigo Gobbi (2):
  dt-bindings: iio: proximity: move LIDAR-Lite v2 out of trivial-devices
  dt-bindings: iio: proximity: document LIDAR-Lite v3 fallback
    compatible

 .../proximity/pulsedlight,lidar-lite-v2.yaml  | 70 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 70 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml

-- 
2.48.1

