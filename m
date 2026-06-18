Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A1A33F58C
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781816666; cv=none; b=uZAtOE+vIf5Cl2KZJSUAcHfk4VNlGubJHMkiQ/1h5JD4bBlqNcmxmtNrpmQuzT3aqgRbkJy/qerjeNiTh1/bVTgfd/IvxmRtKCb98RUDT/xgTM/ZqTOq8KJ7/Om3KKoWu/iFWmjTKLkrZ8wDgyXAkhbhoRhHmIFIbXfm9MEdLSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781816666; c=relaxed/simple;
	bh=JjQuJ+WAC4HyNOpJNX50DDwFBWBZkz8SWnUBsgssTIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxTDLSPHh+1pyFsRVU3tbeOMkdcbbuGqn6Wu3k4A9vdg+rOb0sG7xXfNWypTT07ch15EYdn7bteIcXSHcKLhwx1P76XaPu/QLmScZRQS7gX1CByegRmoSdgIe4dYkV86WjU42S6UUOrwwU8zGST9xJdqRmLOa4UZGkBAQRVl52w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=JHVbVBP+; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="JHVbVBP+"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ad4f1cf3cdso1317781e87.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781816662; x=1782421462; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoOn6a9eFPu3j3lxjvRT84RKODlbnmxk6NgG22+hUT4=;
        b=JHVbVBP+wE16ssu7VvpHdC4dATy4qpTyZFd2b+io2vEs7Zm+5Y4kvLhXUKhsy+UqZZ
         40x05Mn+COicEARUisgGVkz9MGkn2dhvURnxX9ikAF3eVFoCaHbL/9hwyy2x1qZaU6/o
         ILykU8+Wgo7vX9a88351dT+F+nNiB9lRDbdN+1YfN4k1CO74tUVUn1wic6Cq37Cz03lm
         xtU6kY4dbcCnfqsGJb317NQqXDdFCUPuyPCImuzjA+n+ZKT2HOg1eiS6RAkX/R3/iCNt
         F/5xcC51AOgJEKt2f2MWNbJYoptdRYdkz0doppMmMY6dWO6OKx/0BKsg97v/COBfmhG8
         6K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781816662; x=1782421462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KoOn6a9eFPu3j3lxjvRT84RKODlbnmxk6NgG22+hUT4=;
        b=WyfXIIU51PH9V2b91UiPq5RR543SF5vDct14GILfbgm/Oz+80uiMK3NXLoc5zmBh1/
         GNvOXYoOIkIkEwfYKyumD6rQs+NifE2c+Bsx8tJNCkKokdZeBlq6NCYyd1U2decEBNeR
         /2JE1pAD6EnxFRj2bQbXQ+pyY45XXsCOw6ddU3dIvQyfSGePA6OJitaERseb7Y22hJXi
         iuzKd4XMiefZa1TX2juD5nEeqGzq63ANTRigkQSLmxcrG/RPrHBo17RHD0D4uxUjXocL
         6Tb+j8ce+YrLYb454kqydTdhAo9Ntrxcrj3Mq2UChuVpTNwKhizJtXEOc+3IW6szvCa4
         TkTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/ItdGIuwY06qq1lcYHuFQ8qPL9OZKSX8zg/s22DrkLWOMsx6VmFwMT0wFlyyvohIrkG2dL/FEYno=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3ThjEW4UcgI4pjIWNv9Xt9bqR4J4Y5A8PEdua44TvB4oGpWb
	ktEz36hRkbd9QG588n6ICPe+0ZJDHGg7mfqSU9P0zL+8UFbyBCj793Bt3lT+sTwsQh4=
X-Gm-Gg: AfdE7ckzpN+pqSps7delf9EDANoep7qmyTKLq1bR39UfrOvITVxyhORqtvNxpop3Shj
	yrjpa9VGycKbewUEHSSzmHmrHIgYcAbSpV/U15pZnP7SUvowzr0IC59gMSU99VRojEWiYuSZSo/
	6H3wf/8bYWUKe5bwy7Rak068oqd5lutfmlYl2MrvsLxcgbUIa9+F19iKTcR8SaJCghl2wUukcTV
	m8pHvrdifbLEWZ+LYUH9hAWan8nKDmvJT/DoG7QgzOTS+Hs19VQG6L0FAlGYTBD/+KGc1tUZG6W
	kH3l90BGdac+uBTn2gVCe5C29r/xdkgHwS9qL3vB59j5/oZ2T21MkiaZT5aYB6lvT04B23zHIHa
	haElpFBB9DXizz1ARvj7+Y63YO3+O9maeEYZ8uHqsiCbqFJJZrQbk5Ld3jWomhz2GoQlaOqkm8o
	TskARhczIeYbQQRVarnWpg
X-Received: by 2002:a05:6512:2387:b0:5aa:684d:3c7c with SMTP id 2adb3069b0e04-5ad571f3eb6mr148655e87.5.1781816662483;
        Thu, 18 Jun 2026 14:04:22 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad57493145sm108586e87.69.2026.06.18.14.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 14:04:21 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 18 Jun 2026 23:04:16 +0200
Subject: [PATCH v6 2/2] m68k: defconfig: update stmark2 defconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-wip-stmark2-dac-v6-2-48761dbb96d7@baylibre.com>
References: <20260618-wip-stmark2-dac-v6-0-48761dbb96d7@baylibre.com>
In-Reply-To: <20260618-wip-stmark2-dac-v6-0-48761dbb96d7@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.15.2

From: Angelo Dureghello <adureghello@baylibre.com>

Update stmark2 defconfig enabling MCF5441X DACs.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes for v5:
- move this patch after new Kconfig symbols are added
---
 arch/m68k/configs/stmark2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/configs/stmark2_defconfig b/arch/m68k/configs/stmark2_defconfig
index b3fb95f73a95..3941113bc60b 100644
--- a/arch/m68k/configs/stmark2_defconfig
+++ b/arch/m68k/configs/stmark2_defconfig
@@ -76,6 +76,8 @@ CONFIG_DMADEVICES=y
 CONFIG_MCF_EDMA=y
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_VHOST_MENU is not set
+CONFIG_IIO=y
+CONFIG_MCF54415_DAC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y

-- 
2.54.0

