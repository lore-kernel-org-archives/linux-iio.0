Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A81E8320
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389471; cv=none; b=mpzkRq/xjaFigO+7AQvbK0TOdKE+FGdyRSxTabByOnaIASdRleXwoHJC7qyVZTXuaNZ7Di2ahn4N6zzkhx8GzWayYh0qi3LBjQ+9FCQzh4BtziWV4ybYa5iXpndVCGT/SgGBpFFCVHqfMUkNVbyZhEHvWwNZCRLsoTOL3Wfw+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389471; c=relaxed/simple;
	bh=JN8PduOnqm+b69G4LhqEI+v7hY7lXf76IbAo59XBbmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TolqncTu3L8ygUq41/02vrwV1dpQmc9pv5J2kNn2VpPwmo8nwdtmIRwdbqVQN/hRbnOb1UpVeS6Y/eejMnH1xDem0VzGacvYXCVLAiciQLzA9hJi5fnObRTDWp9ttYWi5fEVtbSgJ8Niqh+www+pFO1dw7ztdt36bpAPPrK39Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS/V5RIt; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS/V5RIt"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-790992528f6so42244527b3.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 20:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771389467; x=1771994267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbuDijcWciVVjzkbQF6mJ+gztIZX1FbNQNBTLwdc6cU=;
        b=OS/V5RItWjj7lRtzDnwyjfCgOUrdrFOPglxOt2LaZCyh33IfzSwS32RW0Y2SHqyv9M
         yvtMXO6Ng5PHuBqI6fPcGbSvAiBM10Z6zQdmKZup2dS33prtV6yl6q8jsVVuUNq1pRG5
         S71JFjTWcs32Kb6qorjctKZjWVpz8rmTZQmGdZTJh1OM2eDp08iHt78RG2uvMaNaUTfu
         CQ7T7V5WxFq6NPBeeFQr34hvoiAw1R11nyLbi2qrzjAkHdy5lNmlUmmIhVjmF8wU2qka
         bGcBo8V62z2sZT6a+g9J5xloLgBJMKAlkoYBxUDEuB6mwG6xyVEcCnr0qopZSE+7kXaw
         IOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771389467; x=1771994267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbuDijcWciVVjzkbQF6mJ+gztIZX1FbNQNBTLwdc6cU=;
        b=rxc/yyjTJG6MECzQiPEU5zvjpQ/Y592pBvU2o5wv7+m1ZMndRQyFKvtr2IKbHkVtHm
         wkDhigWn4b4RUOADUHgU5CiHbXPM2IAG1uNF+r130u7VVh7BhztKm3cGvmG2KXLDuezG
         xvFgGfERf0kOujVFQu4/cSothzaFx5J3/PFvJdpzU9r5X7ordsE18fMeS8s7WYPtBQWk
         cpGTzhxtpCyddxXtrWI+SP49fProuLXyWOlnBfjrK/T2OMiU7i2xQHfOKBSAKh63L+01
         XxDLzm7sIKKu2gL1ZY7xLySfCoTPRf2MDR7ba/ebXwLEn0//x0t79zWEWyElpwaC9PZv
         mV5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhZZnuJGvgPaxbXfY8hdgdDOPLoLWyT2d6HdIo/XmofwWA0hQiJJxBlVjMvkkUWGnDu7+5gfOayYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAsApwLVNk5QvPV0hGPAC/9C2KhmoXYOT9VzHjfPa68fPSlnAp
	Cl659m0Qey6vWVg9omxpeI6xM/6Ql9bn+5pK7Gy7KDGBdH9fIwNzSvBH
X-Gm-Gg: AZuq6aLEalwPC1ag1qlO2wwAMsyDEbwloJozaX9aH90ap7D7YyrTMZd6edQlhloKaQZ
	3r2EEen3X8yu7xal45EMWqkyi4An1Dt1hQorcQI9G1eSHzYQHvWyEBwP5DYtXSLqgb7+FRSKMSe
	23qJ2gGRYrxG66Z08VtxLCixSe+xIxE+xcEPwoO7aeZUFYnjtHgspJEXnM0/lThLEWiRiXRre8k
	8opAufrMWuGXMvzeCoDhIK9K5ITP3NWeC5PhcUU6Z0IdxkjwogaawFKpiWj4HUtChAGcSWP3ih/
	roRfnNFNVrwQ/6lNEi3b2/E+wEIQrI6V6+jK7Nx3q5eRHTxUjFzMK3bWwkf6liun92RnlRDugkD
	bwuNqYblTDiURwpmxZ+HI0YJ8sWpRrjhj5wa0Af1KkbmyDfV3+wAvVE8FhXWWRm6CC2byjVxOED
	VILGnELIwEx7DiQISjleQ+Zbi7/0MlG+nmx0Ymmv9+YIQDE8O7LjuOXU+UqykF6F7531SAIpvYx
	lthxdAE4jGQGPti3dbmJGzH6nK6PnpqrEgJBAdcLc4=
X-Received: by 2002:a05:690c:e34b:b0:795:1ad3:26be with SMTP id 00721157ae682-797f73a50d4mr4764207b3.52.1771389467432;
        Tue, 17 Feb 2026 20:37:47 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23e4bdsm119850617b3.32.2026.02.17.20.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 20:37:47 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org,
	andy@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v4 0/9] iio: light: gp2ap020a00f: General cleanup and
Date: Tue, 17 Feb 2026 22:37:19 -0600
Message-ID: <20260218043728.609659-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series performs a general cleanup of the gp2ap020a00f IIO driver.

It integrates my original work switching to the guard() cleanup handler,
fixing a signedness warning from Smatch, and cleanups provided by 
Andy Shevchenko [1].

v4:
 - Integrated Andy Shevchenko's 7-patch cleanup series.
 - Patch 1: Removed redundant 'err' variable and whitespace issues as
   suggested by Andy.
 - Patch 2: Added Reviewed-by tag from Andy Shevchenko.
 - Patch 5: Updated commit message to describe the pre-existing bug fix
   in gp2ap020a00f_buffer_predisable() where errors could be swallowed.
v3:
 - Addressed initial feedback and simplified locking logic.

[1] https://lore.kernel.org/all/20260217102318.1354103-1-andriy.shevchenko@linux.intel.com/

Andy Shevchenko (7):
  iio: light: gp2ap020a00f: Use correct types for 16-bit LE data
  iio: light: gp2ap020a00f: Replace custom implementation of min()
  iio: light: gp2ap020a00f: Return directly from the switch cases
  iio: light: gp2ap020a00f: Use temporary variable for struct device
  iio: light: gp2ap020a00f: Explicitly use string literal for driver
    name
  iio: light: gp2ap020a00f: Remove trailing comma in termination entry
  iio: light: gp2ap020a00f: Join some lines of code to be a single line

Ethan Tidmore (2):
  iio: light: gp2ap020a00f: simplify locking with guard()
  iio: light: gp2ap020a00f: correct return type to int

 drivers/iio/light/gp2ap020a00f.c | 287 ++++++++++++-------------------
 1 file changed, 112 insertions(+), 175 deletions(-)

-- 
2.53.0

