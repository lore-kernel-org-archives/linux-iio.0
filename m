Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9EA30AACA
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769845127; cv=none; b=Fjd98QK0F1sJx2B0zrBcenLaYfUBI+EFC/eWKLHq0lwLVoWZ3WchX4FsLd0G684AUv+L5Gj8TV0M5+B0oiziU2LZSEWCWzwqJGPQ9j/8yB1odf279WrwdcT/bTdJdsfRUvDdmV2UR5qu16gCkdrup4L9PQqNSa7j195EntWQfec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769845127; c=relaxed/simple;
	bh=ZbhXHQm/EzqbuYxAdcS4R9f0ohVNZh1Ch4KsMRDzubU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pcKD9cnSfMQ+vgztIgvWPkQ4aX6yUjHskbGtywWRVQaObGMFqFaJY48+hGC1YV+JxQTqQGn4k4xJ5QVxd9mZxCs4fgPFzdN65pUo7TgmbtLLWbaappVY0ae5MTGqDGqGAQAq4RvYU8sPFjKoxEzNaAcck8K8PAM6oWbgy3QEHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtL+6aDM; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtL+6aDM"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b71515d8adso2912727eec.1
        for <linux-iio@vger.kernel.org>; Fri, 30 Jan 2026 23:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769845125; x=1770449925; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7bKH5RTNHbe2elnMdDorbjBvqqH+0u5ncD0iPbRs7u8=;
        b=HtL+6aDMdfER6NWSKzIbKXKWJ3U2VdbZ0IDiRoIDpWO8Xxir4XcPx28VQdT3UV0Q2I
         15fC9dahjD6mzfO1+tgll6BXPdlfcex6ygn0ULpfmshga8wi/Sz0SfQgCVoIn7RM9yGA
         52nEPYefNzFZ5c99QVRXW6idbqmyZZtc/nire4FDRXe9axFcb2zts0FFfFxdU5AzcxKG
         O46ew1tx4EED0TGVQxo7RxtAwvJbZIlOgJWJyzPPmhQSEqlUT0TDfGGkLuMeXtSSKVZm
         k7KrP8K6Kt4orv/LTDWo9I1qJgiZzWRsQAPJa/QYy5vJy2ZkPwjKKA5VhuqdJr4BFWYM
         9AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769845125; x=1770449925;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bKH5RTNHbe2elnMdDorbjBvqqH+0u5ncD0iPbRs7u8=;
        b=dE+Wc8DEUajgg0fHgUE7ap10IiCGYdIqLa4r22vAV+7kgirLsf4z3OrgBaDSaalVu+
         JpqM/7t4tDVkCibjR0G+o/g6qokDA9+LKTFmFIqDRLxvboA90x11WYCmbfmeC0vjBri9
         l4KQCtEZKqDiOa4n72924XsNg5BlZKfpB0p0PomPML+I9IYM2FCmRJeebBkS3diy6W9U
         leX0YqGzUeI6Hbqj1Z1PPcEaXklDyoWaLsdyH9YdxBWmHmzZLL1m92tLW8KzK/cT9S7c
         7NRynFeIzeTfBhoW3rxg4dk/zR56NumLRwj4k+ryvGgIK2dT/HB0721IzqP3xBcaN22I
         PbXw==
X-Forwarded-Encrypted: i=1; AJvYcCW0aYpWbRhhlih499V+tugFimBybvsnHmgqjPMkAaLgYfA2m0gqx9okl8qZxw/sP/e68TCs6nHHtw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyecvXO9TLAya14V2BVC5/6UNrdE/Kprc2nAJB5S+NLXO4YXR5k
	h7/VixBlWRTH1SWnayg8TwtT3nQ78IcUp12xKWiSnJt9lvecJa6rHqrC
X-Gm-Gg: AZuq6aJQcrPupmZlQb3iny91q7+EyRsi3/J/U44QgwMiY1CZvkOgPkn60RL2AsIGYa0
	T280MA9cTKryEAcHCWhISXNWwCGVaDArc7ahGib68MDcIqhycrYSvV0VMBbsnAwUg+E2IfvHXCH
	jensVFZUW/lvOsrTdFO2/7yYE9G0KknXC8Hu44VnI2h7JJNzeopVlaekQo9Jc7KIwjWHSLzBj+O
	JEwFq2/CzOf5uGefxf8qJhSkD1Fp2Xp8zjSJSBFA+Grd8m/DLuyCQmdnfUNBJfTmS1K+hheZaqR
	OmBI9lAn/Fyrtzep17yKrbaLV8zS1znrBbEkErphRjZtVP9/6NOyQU6UCW2Na/jXLhqbDOuJLsr
	f5L262E5DXOlBD/fGV2/jZB94d21aPR4K0gtfhiEmuAesny0+PXjWUnFeP6yFBFsvlloz24yaSD
	VgSvqE6MPLYJcNKn/wvNJllrsccw==
X-Received: by 2002:a05:7300:a146:b0:2ae:55f2:ad57 with SMTP id 5a478bee46e88-2b7c88f831dmr2350600eec.29.1769845125234;
        Fri, 30 Jan 2026 23:38:45 -0800 (PST)
Received: from [192.168.0.61] ([76.174.137.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8d6sm14337027eec.3.2026.01.30.23.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 23:38:44 -0800 (PST)
From: Michael Harris <michaelharriscode@gmail.com>
Subject: [PATCH 0/2] correct macro issues
Date: Fri, 30 Jan 2026 23:38:26 -0800
Message-Id: <20260130-adt7316-correct-macros-v1-0-8a71df1e42f1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHKxfWkC/4WNwQ6CMBBEf4Xs2TVd0EI8abx49ODNcFhKgU0sN
 S0hGsK/2/ADHt9M5s0C0QaxEU7ZAsHOEsWPCWiXgRl47C1KmxhylWtFhUJup7IgjcaHYM2Ejk3
 wERtdKWoObKkhSON3sJ18NvET7pfH9QZ1igeJkw/f7W6mrfxnngkVHll3reKKS83n3rG89sY7q
 Nd1/QHhU536wwAAAA==
X-Change-ID: 20260130-adt7316-correct-macros-b6801b4ae1b1
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michael Harris <michaelharriscode@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769845124; l=753;
 i=michaelharriscode@gmail.com; s=20260130; h=from:subject:message-id;
 bh=ZbhXHQm/EzqbuYxAdcS4R9f0ohVNZh1Ch4KsMRDzubU=;
 b=1ZK+NMjCNy+HOiiw1I7h7XZj4G8DK8U6+KhILK4WKv+AgNKwocCj3Fpm/+upYA73vp5O4O1DC
 uPf6uxtsu0NAK4HMwSiosfi4Bs5rLkAUrpAYDBGn6ELb0xqvU+WfpyD
X-Developer-Key: i=michaelharriscode@gmail.com; a=ed25519;
 pk=td/zQD3XANAhdG3Kf3mSetXiynk1Ql0eM4s0+eks5DU=

This series corrects the following issues found in the macro definitions:
- Magic numbers which correspond to bits or masks, but aren't using
  BIT() or GENMASK()
- Macros that aren't in use anywhere in the driver

Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
---
Michael Harris (2):
      staging: iio: adt7316: remove unused macros
      staging: iio: adt7316: convert magic numbers to BIT() and GENMASK()

 drivers/staging/iio/addac/adt7316.c | 91 ++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 51 deletions(-)
---
base-commit: 5d2905f2c6acdd1c553f9b022dee730ab2cced71
change-id: 20260130-adt7316-correct-macros-b6801b4ae1b1

Best regards,
-- 
Michael Harris <michaelharriscode@gmail.com>

