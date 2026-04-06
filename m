Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCF83081D7
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775462943; cv=none; b=ofbslzu+AvPdB+sE2Iyk/xIze+ZQ4TwUs2iC2kLXMfRpDSuk1VsaPk15AqDC5ehDTyW0kV1ENwJxv1ZKXm0A6y/ou7Yge8KWX8jkL0uHwgdDr9tvNktzHeE/2MTWmQQAQSOL3LjMVQxGb34GiS/3UqbAOYEkGjfJ7I0pQopvudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775462943; c=relaxed/simple;
	bh=yqSb+xj+j+Zsm33QL0jScZhrcDvdKz/PHFkslCX+jao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X2gGNq2pZdJCgQF6UraBvf+/qGTuEcavm1UhmC3CxXnY9hQQyTJDWxmB0qj+Om0DGqft9V5Py2ql0FZAc15Zi6cEnI2fMPp8pgG3nbmvcubooYI81X+dFSVtXvuoeBwwgWvyN57sQTLJdt2ynTX1o6fZqwxyR/4c50CJroR+Aw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg6j6gO3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg6j6gO3"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so2197045a91.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 01:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775462941; x=1776067741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI8mxu0XOiC3NdF7Tl4p8eKdsZm/Gey97Qxo+LUKP1k=;
        b=gg6j6gO3+D1qmC8oyc04VsIgVRRO78WPM8E47k4KqQlcMXDKOi8W8EfU1eL+It1sDe
         fFT5mK9lVlY9hzm3SUgSrZ1xajN6lYdhpYhG39MiY4/1oZbH3C3wO7ECoFKX14FUDf2F
         LPcmi1TYK5XDoO/pIiIMMYfV3NqmhY57AIjLLv2ukMTqNW1CXpd3VnyrOn4q2B72yuul
         YzR0BRVtqBj8kBDPtwsygnYQCUEwobWFfyAfHxj9tZLmGVSsZdKcdXTgffN+Qg2GRCrv
         lndOsPjWD0pJ28uQWg0Ec/cbpl+mNalsWJlbyppNZPId7UDgXsgyHryRayrp3r6U9k5H
         sT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775462941; x=1776067741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WI8mxu0XOiC3NdF7Tl4p8eKdsZm/Gey97Qxo+LUKP1k=;
        b=csyy4MFGm0dKYvlbTWrMM64n19CUBX3Ym4p2l1x3oG2/kcLn20d32UftIUYob9mxUB
         cuHcikfWUtUL+Px8mgGeVACwQhaealhUjl6JhjIxYoVLdRu3kfZQI5bte4D15Rdk9F3w
         PBFetYVUPSNBI/aQ5wrAyyJxRB4veN4O6EeLumHCBwYkCmX667cGdPdAKyAASQ0z+z9d
         hLkZrr8v2hRqOgn1Jv+hqkIySVOXiXE3BfDWq2JcembG4KkPUKTVzNoxi02Mi0EPtfgW
         qbtKlHK6jL6Z5v6HfyiFgsLRj0C8c/W3A7yG3ylyrmZWhUD05DrpZMnknoBqbmVDnKIP
         Vcpw==
X-Forwarded-Encrypted: i=1; AJvYcCUfH9oK0bJJLH3FUgQbu1Ie0ngZ7jihpXCtijkfeX5Zz9ndQifiq7ny4YGAXfnAlbqeb/uWRBAljP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+OOyqgTC8rk20M5tMN/5O/cke4rZ9zg4YjCM6FbbYbT+wc5S9
	6xbKlShl18zkJr4LXOY0zlblNL/udB2vOsiajbH56kw6WS8rwGIKx/7x
X-Gm-Gg: AeBDiesOIdZum6sApFXJGS3op8jHhCjlle8nohCm26Z2nan1ySJDuJ3NPiMFFl1+V56
	2mEL84F7AQJbNszfpKfG4CrQLm2U1kSilmEtH2p63iBWfJu8xA+xBgsb2FiFcrtKxkBIJDjgkBc
	drfCQD3eR0qa4PMGy997dJ54VnjraHiw21wQAjmcV3K+kSwE7p5Ico6sYsW+PCcR6zCF2/oBUjI
	NAz8uQlMZyN8zgt+g+PMiw4haBYFoXc8+zOHij9Sv91N8ZAxK2JuBzmrDMoAPejQvn+bbB3aKzJ
	bkRK41U43ZT5R+3PrnEoh+HtR/Q1/zIjEoXH+MoyxFkNFCXsSFOC6kZu236MEtdg6Wv1EmqBDDQ
	C3vizwY6EZxlwnstcGt+DZW1FApw2GXkgjyfuGKXFb/WF4hMVyeMgXL+R6JGTxm9ckWhIelEn7N
	xD5q3IZcE8pudEq43BDKisEsVDCIESv7IL/QmUGaSIkl4Ijtse
X-Received: by 2002:a17:90b:48c1:b0:35b:d795:cf5d with SMTP id 98e67ed59e1d1-35de59535camr8452884a91.5.1775462941386;
        Mon, 06 Apr 2026 01:09:01 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af19sm127961835ad.50.2026.04.06.01.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 01:09:01 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sanjayembeddedse@gmail.com
Subject: [PATCH v5 1/5] iio: ssp_sensors: cleanup codestyle warning
Date: Mon,  6 Apr 2026 13:38:48 +0530
Message-Id: <20260406080852.2727453-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260406080852.2727453-1-sanjayembedded@gmail.com>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reported by checkpatch:
FILE: drivers/iio/common/ssp_sensors/ssp_spi.c

WARNING: Prefer __packed over __attribute__((__packed__))
+} __attribute__((__packed__));

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 6c81c0385fb5..8c1e15d61db7 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -29,7 +29,7 @@ struct ssp_msg_header {
 	__le16 length;
 	__le16 options;
 	__le32 data;
-} __attribute__((__packed__));
+} __packed;
 
 struct ssp_msg {
 	u16 length;
-- 
2.34.1

