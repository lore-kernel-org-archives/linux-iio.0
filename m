Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59873793CD
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174651; cv=none; b=SoFlVzyk7gWf6lldYQ8p2YzI2N7hXugZRsCcC2M1qgZBh6jDsgLpgelkGDeymqLG413fZAx9iQ8Tqd0z3mpN/lSPLIbpS9W8LX3AbYOxT0hOxNMuKTJGoU8kePted62nEcFoj4c3TuCjio7314xIYQ1elRxlwj7Sz0d5TjhSEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174651; c=relaxed/simple;
	bh=wVFpuURYItVvyI5m5j7jp0fLWmNsDF0n4W07DxsY1qU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9JdxKWxs7KgN3PftiSYhTDaVfZcok4FzvF8ezFpTrv7zV6iCdjDwFR1uVDHGx4AsDm4z4MjikWBLvy6NFCfKT2rWRxmD5zdiegy41bbNEE81ZSqs75Kkyi/0FnCNfehxs1Cy9WZD46PBLytIX+2t6nsMqXOPK7PNUQfiX0q6ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYiH2zze; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYiH2zze"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bde9d73678so13201517b3.0
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778174648; x=1778779448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nV60eCfhMURrDBtJa0FpwPcE4Ga65qLsJEEgIfocMnM=;
        b=PYiH2zzevduuK+hBtCsfvB/JnlLHwwnoscMKRmmHYbcs/WZ6oCeS3aPNq5IfObQ0IV
         dXjBYhQ8UBHFDiz+PMs5ISRX8NGAAq6JxW2w4IrnKsyzT61gdBEdAdkbguBvgyE6nloc
         STqXu+oRjDT/genB0d2212afd2zNLfk5dB2YcCccp+SuZClaJ74vtR8hmEJvZ/AAAkoY
         yr3WHN9Kxia/3NYyLu1ZI0NjyJ3gqTNgnGCl0KIB1LLvYKRKBumr/bEvXhh014yXZSDr
         gW4nJpi5Np6bm5W2vqwxQWkARua639OtLD3a37avA0SzmpnAnXs+abvqkcyLBta1LN1j
         Qoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778174648; x=1778779448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV60eCfhMURrDBtJa0FpwPcE4Ga65qLsJEEgIfocMnM=;
        b=Tr09ntb1E5Tm8JGVfsrSznurELgdzJNnsUCOwS6p8JeysR4lat7dbUF3yWBUaFXrkK
         r6UlDmn/dfDhqyHPh8o9omvZ7RfRD0mQNRv/dRwHdrK1rbRp3/diRMsKKn5FF6vA7UU5
         irOOpZuI8GDDhXOZ72vTyOWvyt52gOxTTjWRJ7RY1lpF4yNCavJi2OaqslKUQl7148m9
         KxQxpS7Ek0S0JyZ+j9sgkU9RZeuxgoKscHfCurFqLx+nc+udc2syj8nWniIZwU2UEV6z
         ejzoXhVNeRfVvNidY1vV3ZYYVcFHyh8bgOjYrp3nGq09mLlb9q0CYY1aw81VcBy9j97r
         7ksQ==
X-Forwarded-Encrypted: i=1; AFNElJ+L8ciICE6LbKuFZ8XrDUABR5oIZCq4Mmdvpt1Cmjr+kCV4/yOChtkDwD/Z9IIZF7jRasc5CneWSso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJVEtur26TWoNKehsODACIJnSexf0YPZkOiZJSVjuCqvmOuBYX
	dYngWtlx3p6pcwMh2+rp0m67BgPStXBdfXkP2e635w3YI30FOEfbBK8uXWMG7nlm
X-Gm-Gg: Acq92OECEHo1j77HkPL2eUIxVz7YiNvXlapuYKOEODjevM5pjMN2zjynBssQtzsWtei
	oPqOqGq79uG3LVG9vG1hQF9BAneWBhyledIy1FGFWW2xoB6DXiVAWWWFXqQVLO0GNgSkzF9Mp8o
	SM3ATt8V5ISj3lpDKknT6EmAwc8zz1keEgk2dERO2xT6l/R4ViKWrePgMjzmpXMOubibvs2onol
	uhmrxe/z0ed1g/EzpAIpvRAZOjGqKThM9RInnS/icxx18opzPGjWXShOFWMZSgA8x/bpHGrdlkv
	1sZF6/8JsccGao5i+tPna8J8CNUydCdyW7D4m62/MRyQeKD+q0YJ1m+aucnzUpFTVvNnQ//XcL1
	jdVHGGz1g/N66X+BQ7x2VYWmMmTWQjLsewQt/2HFRn4Mx3d+Cfw6fLqYBCS/3sMoqDvedefBmls
	MiOlM98j3NDFoevG82TuUlNJO8EqiwgiWh1ADztCRccDzabStJg7jFEi4=
X-Received: by 2002:a05:690c:f14:b0:7bd:8952:1322 with SMTP id 00721157ae682-7bf04c7ae6amr30274127b3.27.1778174647550;
        Thu, 07 May 2026 10:24:07 -0700 (PDT)
Received: from doosma.breckschool.org ([208.185.137.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665694b8sm95787937b3.21.2026.05.07.10.24.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 May 2026 10:24:07 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com,
	linux-iio@vger.kernel.org,
	Maxwell Doose <m32285159@gmail.com>
Subject: [PATCH] MAINTAINERS: Add myself as SCD30 maintainer
Date: Thu,  7 May 2026 12:24:04 -0500
Message-ID: <20260507172404.80435-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current maintainer's email is no longer valid and the driver is
being orphaned. Replace his entry with mine, as I am volunteering to
take over, and Jonathan Cameron has approved such.

Link: https://lore.kernel.org/linux-iio/20260507170950.37a46820@jic23-huawei/T/#t
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37b105a443dd..0ce067b3365e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24219,7 +24219,7 @@ F:	Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
 F:	drivers/iio/chemical/sunrise_co2.c
 
 SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
-M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
+M:	Maxwell Doose <m32285159@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
 F:	drivers/iio/chemical/scd30.h
-- 
2.52.0

