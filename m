Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5CA442B16
	for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384866; cv=none; b=dT1pM1KCrAcohGRViAiAnXdKRFxkqs1XTCxo/upX3D9CZtry5OVnQ/Ba3j5A7WdAwvBykeorE7pD6FtkWTHZeMk4nBgezb7qWxmjirkcw/sRLIAEzaELoZaYabGFynen4o1RKJCMkO86uZxInhI6CNIex8cWp2RdwE6gfIxAZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384866; c=relaxed/simple;
	bh=rq5NpiVVURxPEKHZWNKaVlsgTfHHMY+YBVtD98Pr4R4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYWY4MU89lllC8aFKiv5SRb1CuyqDVhDiTH3+moDZazxQ1TGA5B83TdTGytdcBdGCmJ9jMtq/iTnOSwfA0Nmx8iVA1ol1/sujtkw8XABbbkoAyLojq3kVTL3wK+Jr4QCxy8EMh56glkYaQ6C8LFZ3izRflSSpgseaME7JWx5iFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbAKtKuP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbAKtKuP"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d942c7cc2fso29894715ad.3
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 04:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789384864; x=1789989664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Me43ExR5DmXiMgXrmqqfo5yNv2WAFUvXbHnpJpXOxoU=;
        b=JbAKtKuPrdBdl+o2CcieawUG7iQQCX29AvomNPyCG25El+dd2y+1W7SetawKdzMyXe
         FOkSb06sFc/uqrBT499OH4PKEeU+Q+73PL1VjUCbO4qCSs/WWNq6+ZrpeZAIOXctU9hj
         2S58QYLtpha70MUPxNa8JHfk0YjpQ+/ddAFlj84G1SsUKLt9sG5k1Qxi7Rc0ezOJ2GaT
         4aCzXguHyzhnzLU2FC7ShkauHFouv+d4UODiVceiTCGr5kAMK3NGsDdyCwLpH1aC2Lbi
         dclQg7723eUgA2+uPnVEYfoD8w+x8Kerihn+sZDKBgN3sHkq9fU2H/BTOyG4UYGPzCj9
         oKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789384864; x=1789989664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Me43ExR5DmXiMgXrmqqfo5yNv2WAFUvXbHnpJpXOxoU=;
        b=LO/UVAJZ+4dIqBM98lulfQgxkbL5xPrpzjVLhmamoK5gDNtCk677Xk5X07A2KwB/6W
         KNtC7YHJO2+d4nwczXSrDLq0ZL5G95ejxCebsGuqITsbdlw/e98GAub/jKf5uE4yybGM
         Mh03sNi5RHBVoj0LZjJb1jAB4jBB3EiKYTvubBRqW+MznbXgtV0keAsOBrtKllkFEfrF
         OS9edNEfjQUUPrfjMdroo/3GAzozp6dWupFa/3oeAj84K7BPe23tuqUxN+j72bgQZA3I
         KkmKbAEzFha7s5oZMyXfqxRioC6lL/VIz7PHr2sPD8RvnBg59W7hpLTwnM15yrTDqEHW
         X/XA==
X-Forwarded-Encrypted: i=1; AKwUvBykXR06VED8AEqg2q+LXGVGYP/iKVREuFSsxlHMaccM0LwW2QxDWR3zq+6kyNkzm+y1Jkcr5q/bw/w=@vger.kernel.org
X-Gm-Message-State: AFuF++lcM7JAl3wg31LNd/sWV0CYhC28nMuujBnLMgw1ej/1s4S2ClYf
	VPpV7a5BnNkHpasZRTBzU+v/523ol3N6pR7hyI9PxX5BCOzcZFwmTdP6
X-Gm-Gg: AYBFou3aE9fTV5edguBPaWp8UWiDuKDD0k3U94j9U/tukFIW0+PYhis4P2QSqsXRZtc
	jQ53uJghFiJ6e7/w957Ge9egfDJq9UiO69+qZZSUfPnt26/n1qoNdiGv1F6LnLLSlHhmUxUXKtA
	wToqYqhp13j2AuZhRyig/W/h6oUOBHoNp9RVWNapKRL+RWoXtDgfB7mMfWJKHgYdgnX1ZLHmdOm
	0493hiA4qQiw0J21NgyE0afggUTWhOOkJXm1ZVZKvbzXO/X6ntCBvsZNrvqYtgi8At3QtfBBH41
	TjpYG195T8EpTmiUtml4g43M28yhPBBOcoo/FgGQUuWBCafJhUS1f1dcts0TDq4mKSTNIJE7WjL
	Q+VuzQrZ9VthZdPjbU2Hmxa2dvm7iDIZ489Fje13WxiTgvm8hhVvGRrP3hVnogPEQ0dn0z0tfAy
	ntPhlKTBbXKmKoYGAw1fNSoUfxgxtmemsqY1UZUT0VXJcXjDu7hV/v5A==
X-Received: by 2002:a17:902:ce88:b0:2d8:da29:da41 with SMTP id d9443c01a7336-2dd6c707c69mr42713475ad.15.1789384863573;
        Mon, 14 Sep 2026 04:21:03 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd445de320sm35512865ad.8.2026.09.14.04.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:21:03 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Siratul Islam <email@sirat.me>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] iio: accel: kxcjk-1013: disable autosuspend on remove
Date: Mon, 14 Sep 2026 19:20:53 +0800
Message-ID: <20260914112053.1686061-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kxcjk1013_probe() enables runtime PM autosuspend with
pm_runtime_use_autosuspend(). The probe error path correctly undoes
this setting with pm_runtime_dont_use_autosuspend(), but the normal
remove path only disables runtime PM.

The runtime PM API requires pm_runtime_use_autosuspend() to be undone
with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
set therefore leaves the runtime PM state incompletely cleaned up after
the driver is unbound.

Add the missing pm_runtime_dont_use_autosuspend() call to the remove
path.

This issue was found by manual code inspection.

Fixes: 124e1b1d0924 ("iio: accel: kxcjk-1013: support runtime pm")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/iio/accel/kxcjk-1013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 166fb786425f..c6b030f64be1 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1547,6 +1547,7 @@ static void kxcjk1013_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
+	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-- 
2.43.0

