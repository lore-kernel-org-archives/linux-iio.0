Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017F73D9DCF
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506777; cv=none; b=HsBZz8STawlaDBZaE1+qPUPFnQIR2yHNBtHKkxREAfhlU2Ng4EBfbqj7iivvP7nVgc1lx9vNju3aT8SKPSkSvO+tQYdYnDppb6F+qU1qhkippqveJmX7SfgsuI2avlilksmjl/u2b8CbnfrANtbDqesHlLWq3SESPLpDdh4cICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506777; c=relaxed/simple;
	bh=E0+3xmqg4gTrbzUNQCJnc3jZRl6JO244O2IVnTrT284=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HQbJZ62BhEBK3po6hLsrqSDywCMWz3SVnL0US/g/dfsjTIYpKzFuw0H7FETIpQQuzxpBt5vZYhSgDW1H/gjUuI/j56CWF6TloPtfjsrCEZEJCXmGfwtP9rQSaOplRZ9Z3u/6+jCHPDi8ybns0goAp+fgFA4LhuqI3hDpOrcUKR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROQYx9rX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROQYx9rX"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso4739121f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780506774; x=1781111574; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fW6aLewYMKpXWcXrWP/jX7GmtM/ps4JaTexETYQJg+s=;
        b=ROQYx9rX2z9ycx4vXKY3s4OuNPJpTskh+SEmkJLvzOyYDPpZWh4SLT6AK17HWDVxSE
         ++hbK17MOVDl93CzBfHZlGeghNANVJ1wGIYhxBJL/IZcaHVk2utOWygGEJPiqzJdegjS
         /j0MvlWpApT7CsfH64CgP8At1KEAxItzDZDLe1Ip5iTrcypY7kPwI+selT8+HJH8phrH
         pJs/htD5pva5wOF8JahkGt4fZZp0As+KIi9YTqHJx2jRi/0TGKr3LreaeycOe+mO0kmS
         XCd0DFWLt2n8eH+dwhh8r3zqzoXQZMsW2PomNVuMR38nSLt8GuqLfnLzWQUBgcbVjO6U
         FrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506774; x=1781111574;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fW6aLewYMKpXWcXrWP/jX7GmtM/ps4JaTexETYQJg+s=;
        b=japNCETT3GbNq4SMA7OnQeIoXFKYku8fvevZvJ06S0pYiJQ7D3WiFg+g6SSXtFkxP2
         kh+pCeFwx00bnflPSN9SBZcfrYw0oZ6M/srIdTVlSoYauN1p96Tm4wdAkpHqtDhc4mOj
         5AlB18w5FQJlzhVVTj4R2Yrbrqf+hdqgC5Ay4gUQ32ttc1olTB2bFT09MPM5VmwCJaTy
         3UpFuwN8CAxlc5c09pLz2RgqXH2hbDmzGyWGUMt3ig3BvlXPArMeUX/xgQ2Msdsvuli7
         2FGXB5wHPqS9ezLKIEdFeQ7QwE4Q8RELtAu6QRDukTvuMXopGJW3spBkdfNCfpRWIHeR
         PvCw==
X-Gm-Message-State: AOJu0YyQbyXrF99S7OGT0XCk8VNVuasdQdKJ1JUWpKdTbprNmNypvA9S
	cbp+A8Pz3KR4F7PTXBoAf34ZUPnpL6qEBcH3vyn1laX+LSUwc9OT/+JG
X-Gm-Gg: Acq92OGezVTE2gcJvYe6J3u4Ioqg0Z5DtA1JI2TXo392iLIZ6uJIw5Mfpjd1CVdbgf+
	kr7OU46H0gSRoChNG8ajkhZaygcrb0/XxgwBKqiwcCDWAL02EAh5mxHY4GCvXTvYnlbGgsPHWeT
	zG45BvyFlWmPt09/UaRy4vSECnzRLXiNlrYdYvjDhHiD8GJoZ+ISlCfNbiIIGOQvA18Q9oWCT5v
	jyQkWlKt0TxIIq7opRpJ0bg4Es1OxAbk/71og7WGHGYnd1RszfrSghzKqiaT656PP7kVFDxKCvI
	iyKjcr+TT/F1NAt6BORWMOWyWkAFBYT4KL6VTFDPD7ptV2ncO26TxIjnqtqMMEr+AsfQM4d47S+
	gy1apRNdwqmLb4CcjDPfwr1Ue6zWBp8BGmatQ5jO14oTKJILI8LIfmAkKVI2paFixprRav7w5bI
	YCbuVCEsF0vOkCBd+yZxRmCnZcmdrF4NPd8jsoA92f8Wmq7LnY9f9f8zMYP2vm1rxuxQVDt4B7q
	ItVxGBmG0gWL41eOm4sZPRMTmD4wtfEKk0OhQIAshmh4OWOmUu3dG2KksBSaCTSYQtXszWEmrn3
	/lZMgJeJX8PYfpLOVtWH/DGNabLzDwywThSy7jABa1suwq9gxyg=
X-Received: by 2002:a05:6000:4029:b0:45d:77f4:1ac2 with SMTP id ffacd0b85a97d-460215f27cfmr7642331f8f.0.1780506774419;
        Wed, 03 Jun 2026 10:12:54 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm8797506f8f.17.2026.06.03.10.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:12:54 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v5 0/8] iio: light: opt3001: driver cleanup
Date: Wed, 03 Jun 2026 19:12:51 +0200
Message-Id: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwNj3fyCEmMDA0Pd5JzUxLzSAl1DE8ukVAPTNDNLyyQloK6CotS0zAq
 widGxtbUAjFwKeWEAAAA=
X-Change-ID: 20260603-opt3001-cleanup-149be05f699b
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Maxwell Doose <m32285159@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780506773; l=3027;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=E0+3xmqg4gTrbzUNQCJnc3jZRl6JO244O2IVnTrT284=;
 b=KTNfEVb6/E9U7e+mZm5xnkvreXcxiizZCUVa4/wmunH6gIcQgCHmTLIJqcnQxr/cbB5ZpgDfI
 yumddw4+cToDh86X00V1XUke3PT+BCXEVuJ8bVabJmWIWXhVdVdEbjq
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This series deals with cleaning up the TI OPT3001 sensor driver,
moving it to more modern kernel practices and improving the code style.

While reviewing, Jonathan Cameron (and eventually Sashiko) found a race
condition where userspace could start interacting with the device
before the hardware IRQ was set up.

Changes include:
- moving the driver to use devm_* functions
- IWYU cleanups
- removal of unnecessary macros and comments
- using dev_err_probe() in probe and probe path functions
- checkpatch.pl warning cleanups
- fixing a race condition found in opt3001_probe() function

---
Changes in v5:
- PATCH 7: remove dead code oneliner
- Pull new review trailers
- Link to v4: https://lore.kernel.org/r/20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com/

Changes in v4:
- Fix bad merge
- Edit commit messages
- PATCH 1: add free_irq on iio_device_register error
- PATCH 8: change comments
- Link to v3: https://lore.kernel.org/r/20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com

Changes in v3:
- PATCH 1: fix build error
- PATCH 2: remove struct device member from struct opt3001
- PATCH 6: edit return statements
- Pull additional trailers from previous version's reviews
- Edit commit messages
- Link to v2: https://lore.kernel.org/r/20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com

Changes in v2:
- PATCH 1: added patch that fixes race condition
- PATCH 3: remove wrong usage of GENMASK()
- PATCH 4: add patch that moves driver to use local structs
- PATCH 5: add patch that ensures correct parenthesis alignment
- PATCH 6: change int to unsigned int
- PATCH 7: moved opt3001_read_id() function to use dev_err_probe()
- PATCH 9: removed unnecessary dev_err_probe() calls, reordering
- PATCH 10: added patch that adds a comment to mutex declaration
- Link to v1: https://lore.kernel.org/r/20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com

---
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

---
Joshua Crofts (8):
      iio: light: opt3001: move device registration to end of probe()
      iio: light: opt3001: use local struct device and i2c_client variables
      iio: light: opt3001: ensure correct parenthesis alignment
      iio: light: opt3001: localize for loop iterator
      iio: light: opt3001: prefer dev_err_probe()
      iio: light: opt3001: move driver to guard(mutex)() use
      iio: light: opt3001: switch driver to managed resources
      iio: light: opt3001: add comment to mutex

 drivers/iio/light/opt3001.c | 383 +++++++++++++++++++++-----------------------
 1 file changed, 183 insertions(+), 200 deletions(-)
---
base-commit: ae8360f3715aa61714864fc81f39790cbb883d40
change-id: 20260603-opt3001-cleanup-149be05f699b

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>

