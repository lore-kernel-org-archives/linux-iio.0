Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6933121D
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683356; cv=none; b=UBpmpgeHQOkMc5f7/HKIwJHG5mUq5nsZ81Bq4yUWhuy6unwNKb+WF4+2fx3SRCn+L3xY/O9vpL3lcv98sx0rGEg4IJ8yE75DX0UUgixBnd1RkbF1YlVkamMxUK+5dptWH9iMk4duLUAoq/vumsdJq/KPZF6aWib1hXRlDFIVd8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683356; c=relaxed/simple;
	bh=ehAoEioXlK2bbwaPGR0VG/LgK1qwui+ow7QoLrqGcDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7a4OHncl4IJsauDPyiT0K+mETTKNUVJTFpMyujQLyLXpnQkl62tyRqvgPswrOxQGEMJG+z1vY0loYuQnFZCf2jEy6XoAEAJoWtETEdAMSoX1aBNxfFI7b504j3XZ/8Hkbe0IifUHxgqGGAxim9Ce7dp3baryyKY+oG9ITsSRjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFwNz0lj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFwNz0lj"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so5093484a12.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 04:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776683347; x=1777288147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy5ceEZ1H+cn+eR4z5x+uo5SVgR0jdWeY6+AWxfsWn0=;
        b=bFwNz0ljG/oUFngkhfYNEKnJPNJkl9dCP5e+7fBIYIvrELh1BoKSxASMi8pgZA9MmO
         pC2pLGOCz6RXx5O6MzSBTY7hPV1bvDw6HAJG99MJ8iGWyqpGfXQuNIevp6M0xaCKsel2
         Ku7E/Eo6eJ8JV0zMNQR+mmd3nZZ38le39C/XpeR6Rt24/Z42MyoCAMQC7MTkawkfrvBk
         hqAmUzLdC6r5pOKhzsuPzboHeELGBQ7m1MHT4y01OdaRUsEe7RVRlcZ6Spl+9I0gIbhh
         xxP91DCHbiWE+5WiFPhyoOTqH3BTPHg7WLqMDvI13kZdFvPnolkyEH+8vk9mvXr21C9O
         P2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776683347; x=1777288147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cy5ceEZ1H+cn+eR4z5x+uo5SVgR0jdWeY6+AWxfsWn0=;
        b=NAE/Q9O3ZCcN8/7DUJfaMNC+9x8UUh6BDp0SEjHya2h0OT0sWWjmanO8v8DsG0dD1U
         lQKaVf5a6IBOFvvEGPJlDh+m3QYjACA/flrntFBOkH+Zs29+2iecrNyljKZdEkE7cuV+
         fdxea+XkfVuCCxDViRFq/kNwaSRtBzck/UcFTcXtPleMj8gC7uD9THTlWbuVyDxgjdPh
         sgAgujKr+cvlZKUruT7OGGdjj1G4ntqCNqNNozK0ZKNGaLJKtE4jEtZUOX1hEIQM7fKO
         m0i1zdzihjajyd73VqObyvp5VfkZpIGwLourgMKkx9AShSNWGx31bqMufzhjwNmQ9Yr9
         hiRA==
X-Forwarded-Encrypted: i=1; AFNElJ8p70drZ+0N6+wBP/1CRHSJXi5eOOQDXrAMkW07Te4027kbo0e+lFv4BR4LVfdQjFvi5Ka3uWx12sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzMgyl/Pyg8xVcXWi209Q4mKTM/3mB8SDe97Bwo9qDLVMwgE6I
	+NwmWPL9hbBRcKnJW4CIRaWmvJ7QTPbdYCpYTWfTZg1aSqrYaAqRcBKPtvPNfNJwbxhKlw==
X-Gm-Gg: AeBDievxt+AvNUYtX3EKTYSzMSSv/2KllSCQUEvCQs6/dkzhGfMntoelUiThXp6YmtX
	EzlRq/gPZ3pROaB6XJ6WfTiJK9IsxIerqc7Mvg+qtR60R4pgMCBrrqJsjPIc08WqV4Uz2YMMl4h
	hXY1uLgIEublPUjlbqMvMJu2nW5OCT42JnuHreXv705uJ13hiNmzR8Pte9pLgCFTs/PK5QTcokj
	pDfG/2MrKNS67/smiFs7Km8aWHG5A7SD//0W8LIK123o5rrekcn/QNIfqWJuER+yeKYkf/DlglU
	NeOSiFwT+ATH+0V9FTPwGTHo1cbeZ2PMcXwVoTvoj8kvNni+NhqkKzm2DxBipt3JK3jEA+MYf+i
	3T1yvHOT6p90igW5Vm2+mLNsPWY+PwKZB2mkZeocMXAaaXW5RZwgZNAq8RNAbkMoVkSJQdgobw7
	Ibyz/C0Lc55frSp5BDtVXvZb8oxC5HUlLvfuWwjPM9nphIMLWumvPRrUQzX/5sViTUr7wlExuSW
	j27lQClQHSxHapgoZx1buuve+n/noZluMpRlzGc8uUMa2t/iXASDM4OXc0uSfuXDD4F9zlg+bKs
	STO7OhxnUntSMF0x3MSFE2wEKeRppdLZhvt88KcBtNw+CenBcAxePtvIjlUxvI0zaQxA3xhVeLf
	QqUmrJoOLscOi/2dPD7KQ5LMl48Qf6e3edBLm657boMBSZJ7/i54QjJ6byVeEhBQAB7l6HZ5hrz
	j0rq7NpzU=
X-Received: by 2002:a05:6402:90b:b0:66e:41a9:1198 with SMTP id 4fb4d7f45d1cf-672bfdd9dc0mr5528972a12.22.1776683346735;
        Mon, 20 Apr 2026 04:09:06 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (254.196.90.34.bc.googleusercontent.com. [34.90.196.254])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c47fe8a0sm1947664a12.5.2026.04.20.04.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:09:06 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 3/4] iio: magnetometer: ak8975: change 'u8*' to 'u8 *' in cast
Date: Mon, 20 Apr 2026 11:08:03 +0000
Message-ID: <20260420110804.1353-4-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420110804.1353-1-joshua.crofts1@gmail.com>
References: <20260420110804.1353-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change 'u8*' cast to 'u8 *' as the former triggers a checkpatch error.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index d4ba96a5630..c57ff6d99f3 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -760,7 +760,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 	ret = i2c_smbus_read_i2c_block_data_or_emulated(
 			client, def->data_regs[index],
-			sizeof(rval), (u8*)&rval);
+			sizeof(rval), (u8 *)&rval);
 	if (ret < 0)
 		goto exit;
 
-- 
2.47.3

