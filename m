Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F767383C69
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651679; cv=none; b=kZJ57AUoNlcjV7NKUl22H14duRlPnC+L45Q4GTWV5sfbVgN8he9CWM3V5MbT5FGb8iOlz0bPrlj9GGybKyoNeA2jwFUKRok0L8xBtopy0MsXJ30bQOZ1gVi2EeTK85NhvP0CcPSAeOBD5ly14WyyZT99FpinwHtPpCwzukQ1mu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651679; c=relaxed/simple;
	bh=43jYAPikT7gsClopq9KcKvDH+4DA4Dxsmik18qGx1MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mu+zvX5ORw9BRYa0mT4Dcp/P3xOBolkofmPX1gfY5PJIreVAEa6Y/VdryWmn+BWI/lnQQD21YoBYta59VAAi612qb/PhvJMvLyM+KGDt+g8Nb2V7AOUxs1REAO/Rj9raZbCTXjwI42bW7X1JghPMkslUCrfiM4kYTMmbmIMb15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIRMHzUu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIRMHzUu"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aecefc7503so17773065ad.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651678; x=1774256478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzdo6gYIjgrMdJXz8XZ6QtxoKRvPIRnI09TITiQ2hfs=;
        b=EIRMHzUuEqP72WtbKnBKWpuLMO8KS++VrMjLqarnj37RXtRHUFGud/exOhbNqLZrrM
         4TC/wr0dqkDLxlo3WonUw6x9hFJ1RWDadd6vhRW1hmjtnz8ZC0dNA99DG7whETokHTf3
         KL+LIfN828gfwhXo8wtAj2K+8zXmyVd4ajTCgd8lLuajQ4VjeOymo3BwJSrHx4XieNhn
         pNv7FJ/QnUcw6xTRNXjhUfKM9bcLFuHV34duwCKmlNfDZMTtWBFlFPzpcrXGY/wBPG1a
         P2tlq2vM6Js02we4GTVXuCHioyKw14drDb46SCeLfRjaJV83Mgnb7+ShLh+YVMAsB9xp
         /rbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651678; x=1774256478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzdo6gYIjgrMdJXz8XZ6QtxoKRvPIRnI09TITiQ2hfs=;
        b=fw64U93FTzaZBdhwEsNvM8uk92gX4jVMPA6en4cD0vOMZqFBG3DpBWH4GaosELtzBb
         XiljBWBgz1nbkoEnGobiLxOd1TCr2VeN34pxubPk5CoazfPyPODRbs0ug8chgdQMA/6Q
         uFDXnrV2cuJsGqS0f/im+9hCC1ePn0ckLqDB4jJB8L7MO95PLNycyb0twT8eqKEt2j1T
         9v/ZmJB/Mq7dAzRmaM1vIXVbxNWGW8F2tDPxZ/GzEYSJ+BN30McGLBpqO/9J6UM7F11H
         MvNQxPdFLCAMpxRe07fJxWtBSAkqBE8HEpeZwbVQc/GwBQLqYnwF0pJhJxb1rhgbJTPR
         NVTA==
X-Forwarded-Encrypted: i=1; AJvYcCWIvxKXEv53qcqz42dtLukpF4+vKWC0sdC6RCAY/Bk0GqFzC8zNoJgphFtzYU5qoSiVPOb+DCz7YrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcU00m+7khIYd+GzVmyrihHER3xxhF2EGoTpd8RvztxuSYJgO4
	iUVhbMWWFfAL5D12XDRdtvXkFV11QpsvxrQrE/YbEFVAlbHsvwChSLwu
X-Gm-Gg: ATEYQzxU6JmNNmrHqg963ES5GOT9u72/rWghRn6SdZWBFpBWM4RLmWuJQgaFQ719YPX
	pbld7BM+acZipPICniGeybFsh7ltLSR1NAkjWs/pDAD/ls81v4v78+IHG2ntJpZ4wr3VUZXgJbS
	ZtVDWCOsccJWizVUd3g90WMJvBkEWvrsmXaaipcN+kTwUdbGILJoTDVIgDSL5C7jH7wdNxefDOh
	pZfHnBHJlWav0bTfke5A9UBJcbkmoMl6Z6Hpom/unpT0gqmCcey3daH0euF9ISvFA1LxYLkpT9j
	sVLvv/3jl4InQbH8oCfi7bOD8XDiIPtsUJ1jgi44u+w/+nhQoId7oTJD7pVqRZzT9qcjP7QupdY
	ILhgtVXSWhICNb/HZNoVgbtVyJQQSxSO69B/UFTp7BMCNIEXe4i4VKgMSqW4iUDrDvoPKwSOIMZ
	7WOaF4MsmPTqxtpXUnu8VQVC6+
X-Received: by 2002:a17:902:ecc3:b0:2aa:e3c2:f920 with SMTP id d9443c01a7336-2aecaa96a34mr126421215ad.36.1773651677754;
        Mon, 16 Mar 2026 02:01:17 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:01:16 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v5 07/14] iio: proximity: fix typo from currenly to currently
Date: Mon, 16 Mar 2026 14:30:15 +0530
Message-ID: <20260316090023.14691-8-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316090023.14691-1-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect spelling from currenly to currently.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/proximity/sx9324.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index c7b2d03c23bc..f61eff39751d 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -821,7 +821,7 @@ static const struct sx_common_reg_default sx9324_default_regs[] = {
	{ SX9324_REG_ADV_CTRL10, 0x00, "adv_ctrl10" },
	{ SX9324_REG_ADV_CTRL11, 0x00, "adv_ctrl11" },
	{ SX9324_REG_ADV_CTRL12, 0x00, "adv_ctrl12" },
-	/* TODO(gwendal): SAR currenly disabled */
+	/* TODO(gwendal): SAR currently disabled */
	{ SX9324_REG_ADV_CTRL13, 0x00, "adv_ctrl13" },
	{ SX9324_REG_ADV_CTRL14, 0x00, "adv_ctrl14" },
	{ SX9324_REG_ADV_CTRL15, 0x00, "adv_ctrl15" },
--
2.53.0
