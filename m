Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E112F6904
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784361034; cv=none; b=P7fpvNWfaq2t7w4Dl5qjEo4/8+GlBBqsYrnDGkJfqLeIWEoxsbxcJL2DD6gBqMAhaoGNse7aN+rqaRQ6Zf+/3d8oake6KqxVlmSB3HZ6O7M31nAtlVNlx+0P521B7/WZxK3UzYYuullhuW1VJbnlGuQmHEjEKdLUcTVEJ11bqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784361034; c=relaxed/simple;
	bh=G+l4s1pogVohaIX+XYOiBzl9VrEUwOrDVgtO9182bfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qgGDlK7mX2SGtM5WDmBb6JxCYoNH7I15d8b/buTwiBvG/08HBkZbXbF589SiQyAaUteIZUlWVh/PpNsnDyCAQoS6rHXa5mXoa7FPLYKDJsgQ6BHjkqZseXrmyJnXZWIh8gTn+itXvvHBJSmOHSlQhDdFaBVHr0oMAgpvANzt/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOVISh9i; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOVISh9i"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca88130e09aso5533144a12.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 00:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784361033; x=1784965833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YXpzVCJeTEdmM8R8kfDejMRWHI3lDmE6Numc0cR/WHw=;
        b=LOVISh9iXnzcQhH72pgFxIy1F0NVltjz0koyr9CF1Wbq3mhnCUX9idhzeAjJiuhBaS
         IFHnI9utayA887i6P5uetaF49aNGX/MPg6djfbWuLJHIsT5/yEqNa5T+O2Q0b9PJKBpN
         jbSyqPt2fuYSZ0mpa9BBdVPQ1ob0EF9NyF4NPkvdFiUIsG+VlGC32z69JKEHVwUAE8nv
         vTeIj9c2CXVdv5B/ji67EJ2fgwtoVCE3DMF7/wUS830wHrvsgwrwIMG7CfSfCp9ln3tB
         HiXNpxs1jrp7ZDvVgK/6BxBkCc6OT6AjX7Jmv20/go9UVbUUr3URck3QBLS5uN4AaN6i
         hBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784361033; x=1784965833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YXpzVCJeTEdmM8R8kfDejMRWHI3lDmE6Numc0cR/WHw=;
        b=QDtagvJ73DIhaMurqof11VQQo46wuQlrvNCu4/b10b4VeW+XvD5djBMIMWBFza6HRl
         LYQ7PWfESXG9GXmHXXGZTa4dyPfXZBiLQWmIugubWmdTTT276KKsQ4LkRxeBxK1/w88j
         qFaq7xTn4pLRLEIkxOGm90eS4nfdQtn0ocvE14phRzJqddXlFYr5v1P0QUEYkm6R6fL4
         LIjMP//IhwzWsFvItWVkLK/K3Nom5LlPDVHXtJncsQtg8TBzGHtqEvbQoA86Dv+bCnlX
         m6oBRIrr3Qr8j22wEOYm7tUcSZGOo9GzhqDPkNfWwiqCdHjySTKwuOFYBFmUR6jGdIIo
         Tp1A==
X-Forwarded-Encrypted: i=1; AHgh+RrZ8SgyFp3i2ZB6Tmdoosxy2YdwU+XPcsBwJ323mthsm5X+31n6UoWsfFwVANXd+xEafFanN/2IJFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi0VNBAjblnxVahw7kYKDxSpMxcbNyWz9ULhLDNZ3CumsJ6OhL
	K2X7FJbvM5ptAP6GljEmntvOn65DFe8/pgGPA0c05V5JNTrDtcbgGfAu
X-Gm-Gg: AfdE7clC7ClLUmv8yvANcVeYaCbh3OnpFtmXnuo3L9BSyj8SeKlPlWzB7GIavLVmoXU
	tGCGgPY42Xxl7EvykqG6TCQArJIeBFe2Cn9S1jCihY5dTb4zM1e3kr/mzQxiLC/WYvTqtZ9U90k
	v2DP8x+MU14et8C2yw87HgrESZRSH5VI/g06ga9HE3G6rU436Mx7qNLy8qsu/WvMVAtysK4PaRa
	sHuDVtiJb+n21H5HNfcG5aExwDRZmUXj5h8CkB7vDSC+ZAKNGWNv56gNc55D0wxHVsoZXeA0Jva
	r9S50LO43SlQvDHVTrRLY89/RP2skgcmDtUai9y8Z1LPHHEPicXGD1f3rU4PVAbSkhgdMufOK4o
	6wti9RbCrv3T/RTeL9dsg90BUBCTfKkkR61nau1R74L6iLzeeORkM7GwUqX9DmjHvej/v69dRiE
	ATj4x/C2h5MF/OVm3OxbqR7QPJ3epcMDDYxH5YK4x6BmTzmNVidc+Z
X-Received: by 2002:a05:6a21:6816:b0:3bd:3800:7538 with SMTP id adf61e73a8af0-3c3ad777edemr6673890637.33.1784361032793;
        Sat, 18 Jul 2026 00:50:32 -0700 (PDT)
Received: from debian.ari ([152.56.157.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20bf96sm14354220eec.28.2026.07.18.00.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 00:50:32 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH 0/3] iio: adc: ti-ads1015: modernize resource management
Date: Sat, 18 Jul 2026 13:20:13 +0530
Message-Id: <20260718075016.27750-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes the ti-ads1015 by transitioning it
to a fully devm_ architecture.

y moving resource allocation, device registration, and runtime power
management to the devm_ infrastructure, the teardown sequence is now
guaranteed to execute safely in the reverse order of initialization.
This allows for the complete removal of the ads1015_remove() function,
eliminating boilerplate code and reducing the risk of future resource
leaks.

Additionally, a minor housekeeping patch is included to ensure the
header includes remain alphabetically sorted.

Archit Anant (3):
  iio: adc: ti-ads1015: sort headers alphabetically
  iio: adc: ti-ads1015: use local device pointer in probe
  iio: adc: ti-ads1015: convert to fully managed resources

 drivers/iio/adc/ti-ads1015.c | 89 +++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 47 deletions(-)

-- 
2.39.5

