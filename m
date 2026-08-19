Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473436C9D0
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787173718; cv=none; b=aIsfXQmzZ3UAaf5ocJKUUiXzZw7vPEoNJ2ctAntELxqHwCQXzGEReSw/79+StKZVfWTUDfJwASRxwCIxM+mZC3BgIcTBz9WtkHawE45u0Azq9issjFC35OrOAZwFpeywXJUVSsILmNHDL8Ml+JiXT1Dpl6MchR68FiHCQ26SyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787173718; c=relaxed/simple;
	bh=N9oyXLy0WiaRfZjfgg1R/AboGwKo8XSCOjqtwgTEGt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqYRMW+RiPv4XrpKdXl8XpqyAUlaJnR7Ra+3zgIShvLPWDqOfRRQKsvlWfqIKWNdzrcw4AZOuwgwp+x8Cg5kjuJ0/X8aEqSsDnvB7fST4jHycnaF545HZPrmYFOCmlpWHrrOpdWLdHELWR95reHjKFj3X4wI/NJUky4QBWMaRtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ri3PjD4S; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ri3PjD4S"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15d47266baso160487266b.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787173715; x=1787778515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cwbjjKC3COcea0mQY+gH2Wfh4IpOMKpPVpX8d5q721A=;
        b=ri3PjD4SKNyv3cydU5FyXQVJz9T/9UMMPX7GOBrXcDhv7I5e3lXEbh+VCi3TTTWAAB
         ifqvE/SF5fGnb2p/vaeZtvA6gShI3fjdP8jZ8vHkCZI0e5/ixoIO471A5skLT2MnFtCo
         85Xw7tNn1eX0v0j3HzivxPAB8U+Q4p5GAc9i50TzRT+ib/CHl3oKdq0Itbp8xU1Md7rA
         O2yguIaUlQeiXpsYaNVuvtMD0/uVUjaLHjZag4eYuVKaxrWTp5q9Ume1npdM+Z2ZJEyj
         emwtnk1gMKkXe/5PmEnXkZxgz5TZTp7CFTW/9fORByx2UbLRyY3yTGqiPcL+Ei/rIzhs
         p+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787173715; x=1787778515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cwbjjKC3COcea0mQY+gH2Wfh4IpOMKpPVpX8d5q721A=;
        b=RX5tpYfbgU7qtyqiXhPgT0a/23TGauHiaoPfTXPDhsaSWMlhVo0vcBzIzQ+bAWam9z
         f3QO8E9Lzd030IDDEoL/WthaPMoRjVCzNnIhwtjNyiiK1Gto1D3qo8xKf1fSRFsK8xF1
         8hBdhFsOmZEMblR9+r/3xqMh8BpYZMp4RXEUnQCpXM+jtyyEhdzov8ruMl+W02q6UgRm
         K7n6hLpujBlK9pHF6FTc2yhFQlbC/y8XdShIw/IrwtB8Cnj3k+zA91m3HMSsfIGfsZ9v
         pOrI3L+73XJYYpnw42p189CRJLO45b34kEXrdY2zC6QJJFeHUqMjaw3mbacHZHWw4JJ5
         uYQQ==
X-Gm-Message-State: AOJu0Yz7nCM007XhX8DQRH3+yvXU0l+klqZPL9gM2/lgzQic4YJtzuiw
	euYwjiQnpCkuhvwtRmlis4e7IjZDkHMnSOHTAQTANnnlAO15GIhM02xe
X-Gm-Gg: AR+sD135eEiJoSvhsjyh+1wQfg2HGtVQFD4miyEh2YSPmIu4BHvUVak41Xwp7XGTCWx
	hCKSlQqJwWTdHVWw04VGkmqJist6f3uO9yGXebtYP3bdh8L1PXBAnHEX1X8fH862GHzXhX33qBF
	1+HRBXT5uSDrdJKq4NjwzcnQ4w032igpwf1zz//JR8vXIfPhGu/zhPwtPhG5ejgc5+xTbH9aJFm
	EZw9PK3XoE7wuOSpSqI9W5+MLWFXsqA+Rylq3952V4ekc5hnM/0cPHLlRXFXz9hVW0xV4Btv35n
	VHSofNgcG8T9MB0Ve9dtZZF9iQOwnH7ZtJuGSlgqKqyLzDAipF0InWHW2q8jBOrTJHh+fd9TI4I
	5gWj+depkLjJSc+odl+FOcNpbSc7m05slB9zVHBR3ZycWB7UVnBf1W3J2s/VyksRhHSjakQ90fN
	svWXOpiCPCA3/q6peRF4GIsCZRbu98npE4LoLPJrEK0wCh689KRqFJYtecYVt8lR/KeuH2jl2ym
	RtVdtTBgK4zPw==
X-Received: by 2002:a17:906:4793:b0:c21:94f7:7ab with SMTP id a640c23a62f3a-c242e364b30mr485022466b.12.1787173714788;
        Wed, 19 Aug 2026 14:08:34 -0700 (PDT)
Received: from localhost.localdomain ([196.235.194.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c27771csm121374466b.62.2026.08.19.14.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:08:33 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: proximity: aw96103: Fix early return in IRQ handler loop
Date: Wed, 19 Aug 2026 22:08:26 +0100
Message-ID: <20260819210826.14395-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an unrecognized proximity status is encountered in aw96103_irq(),
the default case executes a return IRQ_HANDLED. Because this happens
inside the loop over the device's channels, any remaining channels are
left unhandled, causing missed events and stale IRQ status.

Replace the return IRQ_HANDLED statement in the default case with
continue to ensure all channels are processed even if one has an
unexpected status value.

Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/proximity/aw96103.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index 8fbb755dcae0..b1f36a51d56f 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -669,7 +669,7 @@ static irqreturn_t aw96103_irq(int irq, void *data)
 				       iio_get_time_ns(indio_dev));
 			break;
 		default:
-			return IRQ_HANDLED;
+			continue;
 		}
 		aw96103->channels_arr[i].old_irq_status = curr_status;
 	}
-- 
2.43.0

