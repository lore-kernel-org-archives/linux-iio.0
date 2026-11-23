Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446468;
	b=QrcDsxc7ynaYVRTx2V2qWfijhpyYMZ96iyTBrIaqrazBrNf191ExRUyCyJWQB3OUFpBk
	 UaNGfMvXN2YM366bSQOhfcjKBovrPI8fJXwjufUa9wsz82skem2GX5A7Eattm2KW1rVVm
	 AzvsD1vU1lO8HVcmxRDo04RAdrofxr38nstl7SSiT9fFUi4PPUObVyT6wGwyGDf5AhPkV
	 IfRhKGtzBMLSoqL5Kna45fjhFgee8tcW/TKQHPCqRWWB7jjV9qG6IgRe0P0QW1987AW8v
	 AU5mgeBenP29RxDz72bCroS/eS/UnL8rYUVUhOZSgabBORsDcpWlWWsdwEE7BJPM21Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xh8JlClPQjIKYSMwaXks/N+gTEcs+PhZFyDS0fpX7rw=;
	b=dfKRjJgugqD2iHrO9C8Ux801sV8XgDNBqAqa60fw/CaTWh9w7kQxHM4B3NSxQAjfCoYr
	 pDFwFKU1s0FMwQ1DyW+/VDpWyMxampFG5M65SU5BK35Tp7CTQKedlMdsko8aDeuuZU0Fl
	 +1w8DwCNPhVIo2Tx5NeYikv0vjUwP9ENf3MWgIkfquKi99hsKE4OKcDg6ZpMl8A0uZk2X
	 hEQJiorBNYbCBf2qUTroe0UKeHHKgldGuD90LIxjHBr4fR8YytGOJsR3hoDAEdb5NQ6Sw
	 0RMgBoDMuOwxC938j51xnt7CbxEBkQg1bEThUlMbmPf1DaFYg/VFr9HTbhs5d56KiZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z3xcFD0X;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7F606A338
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 15:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACD7F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z3xcFD0X
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b876afbb86so4285111a12.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446466; x=1796051266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xh8JlClPQjIKYSMwaXks/N+gTEcs+PhZFyDS0fpX7rw=;
        b=z3xcFD0X6rjc7qxVPfx4nIHKdcQsvmgdw6i5mi7HnD139rzKT/gw0Ape8OiNUGzE/v
         P7uRLfxSHx6KSzuIQNTBC5PoLU7MAjxqXEcF7DfP63UQFYM4UBAbWCCFCfJpOvIG+3uD
         nvqhggWkw4NdXLJ4moVlaOHGCPXRKyjt0/eN8+zGWKWnhc6dryG1WL9CiuD3QR9zy7cp
         1sXPYwLR7Q7Hk5zFm7rfKmURIARmWP3CklIaRV+mjCUWrVBOyapv4eWRpo1kK2FnTEln
         AE+VkbAp3ZpJjiZqBajcU7QrBdsRotLMClMthu5BWOvnLez9hQNtLNdBPmQH2nXBi+Fv
         Tt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446466; x=1796051266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xh8JlClPQjIKYSMwaXks/N+gTEcs+PhZFyDS0fpX7rw=;
        b=1nCRfy/eZ0u4pt/GK+WdIHUJnvbrWcO4q+yNIfaAqAxYkTi06MxnLF6fXxGMwHVKNy
         0bdI45fNZYZx50EJjj8m2ZZt7DGd6OdRYSEcAZVpJdV+MvYjewtWwn5LLO/sy7nKuQdl
         J0S1Nh9c/4Or4Qdu5SbkHxGPZHR9IfG/py9kPuxtIUtSL5tGAY2xMicRAwujHLa2xSpA
         LSac0yd6LH5Vgwuga4OPOYFLA7c4kj0JCd+UXoPQSTr6Y9TLdlM1jlN/P+a4yKdkiTUQ
         NIIv3mMicOhEQC4qe0yfzJOVvKNhn2i1GVgl0nIpjCivV1gtknazE+8s+rfGhZw9fdF2
         XwUw==
X-Forwarded-Encrypted: i=1; AL+hErF3bHUoDo2vPVS/PrUlOlvtSJOUn0vwWN2eagcjrpMdds5Ht2LoeII6Tu4nZ43ILGkyj95esWadUwQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TXI9548XMCetnbV7zKnlDfZBaNrjVS9j2dKCD4QIpki6EBt5p
	fjggdVi1IcrgOV0JyJVsyXYPWoVKYWQAf0e7JfekoPKUyL7odGAxvNDH
X-Gm-Gg: AZFdTZclVa6arTkNBGw6VW3fAj5DrDqIPfG2U5aJ4UazoKvCXb0ljXl5bCCLrf6jNwr
	EekdrEvhvcDuwODoNwqSIb3O6NGxSYzse813oEiLeqadr31EVFeZB5UHLlzp4brdLR523afnaXf
	nLnF6H+ZHS5alUZOJzGTvM4Zab0/9yOfo5WFqd88069WHEnrSZlDaGY25whF0CuST0S2nSZ/3sj
	z+fBArmk8rBu3Lw9ZfiO5pI5PvleTMqblaleC2HLwRMo+sPDhl/cNdL31P8HGvnpONPSsxAR/HR
	4a9p8c65IGncTfWOSpfePphOJVOFcNPog09csvEO27hFJwJ5bKaWIUKna8Ys1bdEzvUD17+zY+I
	Viit+yQzXMZ8cL41P1N3qs3moe8C5+qUlbGhmTQ5J9jYjM/h9Tql0988Th8Elv4QrXwbDi/E0sX
	l9b6Igqjp5NDOaFSgYCLsSqnTa0gEkdtIzIARzv1zgmOSCOf77uqbbr2LogIcnFPXJGtlk/JGHK
	lsyxLkO4CUgMv1BZnuoNWZd4+hVb7oPYUamvXqlr3n9/ycAoRxlkePlCW3QeBZg1Xgq7d+9lhPN
	O2hDam7YkpDTERAj2mDb7HbeUKxyOXJR1GLied8czRkjzcU6MXVjS1eZGnDlBDVT5OaatVy4Wr6
	+P9Pu3POxUA==
X-Received: by 2002:aa7:d789:0:b0:6b7:6c8:70d5 with SMTP id 4fb4d7f45d1cf-6ba37c76e5bmr5952130a12.3.1795446465996;
        Mon, 23 Nov 2026 07:07:45 -0800 (PST)
Received: from xeon ([188.163.112.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370fc020sm5446279a12.25.2026.11.23.07.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:07:44 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mfd@lists.linux.dev
Subject: [PATCH v3 4/4] mfd: max8907: Add ADC cell
Date: Mon, 23 Nov 2026 17:07:25 +0200
Message-ID: <20261123150725.212836-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123150725.212836-1-clamor95@gmail.com>
References: <20261123150725.212836-1-clamor95@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ADC cell name to the list of MAX8907 cells.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/max8907.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index 103294c76b97d..ac7b41ad400ed 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 
 static const struct mfd_cell max8907_cells[] = {
+	{ .name = "max8907-adc", },
 	{ .name = "max8907-leds", },
 	{ .name = "max8907-regulator", },
 	{ .name = "max8907-rtc", },
-- 
2.53.0

