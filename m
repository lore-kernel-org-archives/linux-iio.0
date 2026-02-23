Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D9113B5AE
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 03:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818041; cv=none; b=oKKxmqukFwdT+ANrqklP9YmDC+D5gOo+FsxMn0BYKocAbqrdnxvHZYK8PADfQ1cLyvkPqhxQhNY+BUvj/iGhkfZt7ViTCNXj57bvA9S2pYS5GZ6GAFmFHmBZCKnBydxpXrQCDNPdY5XEmznLJBXozg8NK8xZ+UcGZhJ+9PMMWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818041; c=relaxed/simple;
	bh=r1RFYdYS++vKOcG/gTUlViHkxEH0WN8JQoXCOqssjtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8OSHKS3ldTNvvbeXEWi1GfMRNsHuKMJwhWSWP5UMPvFRG7ASVtM5LuOI7xkOnOPjo+30G/WLBRGIAnGizZ78exyRrtIIej88YBL4U1T6g8ODB9Mz0txLJqZ+9ja/k4ZoPS2UP51Oi8gGB09Ffj92wyVS5AiWC937Po+2wZvnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCzrpI9O; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCzrpI9O"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7962119ff2bso35414917b3.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 19:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818039; x=1772422839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjV8snXmEBl8xVUnnm+j5Z5gtM4aqM+pzeTnsQY4+BQ=;
        b=NCzrpI9OSWLMkFRII1JeTiO1u/GlUsi40y2yAoSgiodAHUdueMC6+z/GPMe/uOqj3V
         nnbHKrdW5rLcrJtFaoayN5NWjQ2KUaZj3QUVpwbzBspstlBEtMOUF+cIkK1/ygTQ5Oef
         0s5wOY4cc15jbJ6/uvpDKQIhVjQHKPsNvS7G4hn2LQh5NiY2smIKYMcxro7oCEKHmAjL
         jAiTobeHt2nJ49aY4FvR2Cgg6o0hCJtbKgd1pQwYzpXU6rk/0xXfOiUqNQmdr4mlHaHD
         81ti1/8N0XX7zKBxQ5QQ0QjD+KRAq9NZtTTrmCHkgmg49adisfgLtlfDR8WRCgy6GdQ9
         xGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818039; x=1772422839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjV8snXmEBl8xVUnnm+j5Z5gtM4aqM+pzeTnsQY4+BQ=;
        b=TEsTguOZHDheL9A0mTWD1igE6XXqFInuH08Qfz+F7OeEDhir7O+L7zUr8CY2aaex1V
         meFA9VNAipIh8Pp3yL/YfAJ7sO2FHMgZyRxYglgnwsX/SaMVx+XMQqTCac2VcDT+SqU3
         fyzSa1glfKFazioPGbgWoyNHw7/Wj9YaDfvzE2rZ4ZMimThYmgkyz7pxlO2BY79xGr5f
         ZWVn9x1ayiOm1fL2cDW9EYMieWYudKZWVPnkZBG6VZNwWhNddcm/WO5TQ71HSyAV3tw+
         xXn0bmshobLLQ2MY5rsIMvIvmZWQNnz4Q9QLbYAcroYl+ZDh72t/dyFGJKSIX5aLoxFO
         7wgA==
X-Forwarded-Encrypted: i=1; AJvYcCU721eXUa9hjS+m1866/Ch6guliJRymp+95e8/bpJb2YWF8aSPh0EAp1p8Q4jczNd9+GUXQpAqwjio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtQmB398ydNO65ulx/EEU6/DMGZiiND+9Q67vSR1J47fN4eV5y
	aPIL9aCTxIcwgA3kL3Si9IfZsYow5M6dcpSBQPRIA5Tsh/1mi2qXCiUf50OZme9cCtA=
X-Gm-Gg: ATEYQzzD2tKicpjsM9JNy0c2b0UZyY/2UhaxajOjBo8+fCfH/uVKNP62BiWcCBTdxeZ
	Fd7m1VvXkWMUmm21geennFtM3XyisWXm3g4j2l5tF08gtfZwWqBF9u19d5I5FythSyhV38K0oRm
	3vBOX2w8jJgor7ki4TnVrp4iEU1wySqAmQqY4TTZpfX+8mMhunthLoGHYJz80oVobuXD749FYaw
	K9fL0mOnCr/NpoKgJYl7V19PyHRWYLZCtCzhogyElsP/FjFeat3sG34t85yveDRIJYFSx74rPIB
	JBBHP6hnkPJIoGf6TbiFHslue9zExV+IdRRFHhet/z8jYIY4Q5icHF+IgzvCGCaneaud3r+fJQU
	pcx/CnRhPUTyMvSg6jAM9lM5OgZgDG50DrtkIHsSh2TqaKi4oqO9bEH5fEXf8YVKlNvlaC7XYLt
	BmJ3PPQjooE9l4Qxhfg/d97VP1R6W+ijtNqBI7upopeTayned2deHCsnfdDCQPBNa3h8LG7yjKI
	Ng4lt6iCb9UpDZYC2XWrwtM
X-Received: by 2002:a05:690c:ec7:b0:796:360f:e1a9 with SMTP id 00721157ae682-79828f4074cmr70198487b3.29.1771818039393;
        Sun, 22 Feb 2026 19:40:39 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd5939sm27285237b3.15.2026.02.22.19.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:40:39 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v5 00/10] General clean up and bug fixes
Date: Sun, 22 Feb 2026 21:40:10 -0600
Message-ID: <20260223034020.27625-1-ethantidmore06@gmail.com>
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
fixing a signedness warning from Smatch, an error swallow bug originally
spotted by Andy Shevchenko which I expanded to cover both buffer setup
functions and general cleanups written by Andy Shevchenko [1].

v5:
- Patch 1: Integrate some of Andy Shevchenko's changes.
- Patch 4: Split patch up as requested by Andy Shevchenko.
- Patch 5: Split this patch from the patch number 4, to keep bug fix
  separate from style fix.
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
  iio: light: gp2ap020a00f: Return directly from the switch cases
  iio: light: gp2ap020a00f: Replace custom implementation of min()
  iio: light: gp2ap020a00f: Use temporary variable for struct device
  iio: light: gp2ap020a00f: Explicitly use string literal for driver
    name
  iio: light: gp2ap020a00f: Remove trailing comma in termination entry
  iio: light: gp2ap020a00f: Join some lines of code to be a single line

Ethan Tidmore (3):
  iio: light: gp2ap020a00f: simplify locking with guard()
  iio: light: gp2ap020a00f: correct return type to int
  iio: light: gp2ap020a00f: Fix possible error swallow

 drivers/iio/light/gp2ap020a00f.c | 303 ++++++++++++-------------------
 1 file changed, 117 insertions(+), 186 deletions(-)

-- 
2.53.0

