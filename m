Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5651151C040
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788375; cv=none; b=nnZqZ4w5e+a0UoYuEZeq7YwXL1fkzlY3OBugKsPcGkde3QbZ7aiCHVJwdPwHYtCme2bnRHmJuc0lWvPXOlrpK9A8ajPbZw9ZUpCEgR+fTSLn3jD6diuABRKH3xOY0md9/+Bkan1G/7THWLx71/GwgWOVB6dcGH4ita6epIb4+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788375; c=relaxed/simple;
	bh=WdjfwuLlNW7MMMae3ZeWD4EXVc3/c4TDscD9rZ6H6c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZ6QYD6vUyVimxkc8z7Kc4/Mq0QiuTSjNsKBepliHIQanN0HHJhdllE3EMj+egRBuj4DfLwujKI8pjmju2doH1M7xbbPzjEBaNjJ9bBRmhrc4OuYR3oWZyKtTPiJhcg3E6FoT32W6NyOyZJKN+vmeKa77+eBiYgcPk3oUwt18ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPs1em6E; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPs1em6E"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7d27b7410so803906a12.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790788373; x=1791393173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbmaV1Ht+pQcqM0UYJvv+5BLoui2ejuA1oa00pHWEJk=;
        b=JPs1em6EHuLRi/5HajN0B7ZnhHomT6j0oQ+Mc0xSxMbWAbK2tHwfSPEep/wi+7bXgs
         RLTnaWUIwXQdBkPomoo5RfeIv6W/y0rC74SeQJGk1AvJ5gUfd8nsekQ/gMSGCN6n6jVQ
         O7hgQ1ykn0LuY30yoGjAh+9GjeBsb5Hv/adhVz5wbWFn8CP0FTgjJkIMzMTfUmVf9c1q
         lTaZvo/5rawXGbO26vwgBV7SjdmwQ80EEfaBn1xg+xDUSsGHAEB6itwy+2EMFU5l3tgl
         hqoopJg579PA2FyGkHdrLK105cvDyydEDs7O6EQ2FiM6fByTnGbGxuOPBF6sHDDyQXn2
         re2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790788373; x=1791393173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jbmaV1Ht+pQcqM0UYJvv+5BLoui2ejuA1oa00pHWEJk=;
        b=D6KDHJc+9rlBD6OIEIkDwSjHSr/xzgyuR/Ve5IcNTcO6ui5I1p8Ly7FagF6kGib+wf
         YSLSZ+ac3/v0e7+sY6l8w4uDQiImjXCqK2odZ2QyXVjtDJ5tlAWhbJaAKo8qWC86RuKL
         3FRyMJqkgYfqU6stsljLH3YSLc+RAu7R5KWB4ucTprmFqydj+fSxlUzJd02GOSewmzPf
         GpxbQQH1fg3trKyTqRBBq8X1Qf+BTFhg38w4GF2Urcn2PTZ4FNNCw3ziNAOj/dT3maxu
         Wd1UxvrQFkTJY8kPcPF9Anq37z/MOITv4m90t6MRhW4oCvXYRPiRuogRlcSQ/C9CT5Dd
         x9nA==
X-Forwarded-Encrypted: i=1; AKwUvBx8Lixny0oGUSmE0liCWbz52xZ43dCXj5GAXy8c8Jr6wBnf4B4fqlkgHx9b505fSY7oOxBo9ejN3Gc=@vger.kernel.org
X-Gm-Message-State: AFuF++nyGOVB0kyjvB44gfnrh7+2ke3NxgcsnMq3iRWuyeHXvAwuSl7z
	mLbxPGvtnxCB0g2BH78S5BCh4+ouoKULZzW4S9dByKv/BJ3AqiTPOvQa
X-Gm-Gg: AYBFou2u5jq1c+IaTP+enCpTqNuW3avrY3XsOyBax67g1K8PSDQt02j/MlprNXSqT2E
	DHyoSXFBRl0u0hyRGdQTpLnTerOV4mrlyLWyeX+dB/BONzHbvp3VPHOOZT0uTIM0qRwPw50iT8y
	QjorN+c08Y7ujz/btCuz04m+UM0jwGAb9U9D6cwtwWyVM1DE/XotUa1VWojG2cLGHvSUpXv6tqu
	sI+oypUPG90RzR6hFIjhLNIbUSutN4kry7kITnLJ2IK/KbzLrYsh+VHI+tmZm92cFY0vgdQFmks
	SMk2StYuEUXZ2yawxVnIXaXzu3PiOXH2S8pXU7pnMFf0ampKevfMSGChSkEBrHmmBPUV7W1mbhH
	yaltYjoFgwGNOqOXquUo1qf9HlzUtGk0dO3NRQwlpQudWgn3MY4m0MWd9A/PeNE6b3IjkkWtkGP
	Uq+Oa5AL2zRBDSc9zmu7xHSlwTj1PD2dsMwsQ9uoQySVZ9iwePmn7/79G3Q6AHInjwFZqu9s5h8
	y1iyvssT1DZrHt2VGTggsGNf5Skb9lpVbzteBlIoisJUEgE4A==
X-Received: by 2002:a05:6a20:d492:b0:3dd:a196:69e3 with SMTP id adf61e73a8af0-3de9eb8f535mr2002403637.62.1790788373509;
        Wed, 30 Sep 2026 10:12:53 -0700 (PDT)
Received: from debian.ari ([152.58.182.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887bc2bd404sm636872b3a.46.2026.09.30.10.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 10:12:53 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v5 08/10] iio: adc: ti-ads1015: use managed runtime PM setup
Date: Wed, 30 Sep 2026 22:42:02 +0530
Message-Id: <20260930171204.12863-9-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260930171204.12863-1-architanant5@gmail.com>
References: <20260930171204.12863-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_pm_runtime_set_active_enabled() to combine setting the device
active and enabling runtime PM.

Previously, probe explicitly called pm_runtime_set_active() followed by
devm_pm_runtime_enable(). The managed helper changes the teardown
semantics by associating runtime PM enablement with the device-managed
lifetime.

The runtime suspend and resume callbacks only update the conversion-mode
bits through regmap. They do not manipulate runtime-PM usage counts or
other shared resources such as regulators or clocks, so this change does
not introduce an additional runtime-PM reference or resource-balance
operation in this driver.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index a790f694a1a9..9312822218df 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1046,12 +1046,9 @@ static int ads1015_probe(struct i2c_client *client)
 
 	data->conv_invalid = true;
 
-	ret = pm_runtime_set_active(dev);
-	if (ret)
-		return ret;
 	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
-	ret = devm_pm_runtime_enable(dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
 	if (ret)
 		return ret;
 
-- 
2.39.5

