Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671060;
	b=T2B2A/QFd33g1cKWHvXRe26su5foO3/L0xrICXjZwHYqObvhyXLvtRUlhRvykLNboKxb
	 MqFEvzqd/8TtVpTjyeANv1nCr8Bk/ypYQ12/Ao8yOmFVyzTePyoYnrZIETgi1lRrJcl5L
	 r/qesPyzoY95j8yTxIxCbV9KvJ3AED3cWp5grWrrB/zcBtllifg6mp5N3QqfhvOmJRo8A
	 Fvw8ou898etdClTxIKWGpMUGkblPV4VsTI3lI2cF/HZYTpDZFynHCIrLaDGYLovRHDT0a
	 a3eHNGjlWJSa1gNn2wDbfhhPask2moYGUvBC7FK6785/AgnEMVHkkf738Hva3nerH+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iopZBYuyd5Md/S04U0z1jsyC4Z5+nPgq1zvcRMuA70Y=;
	b=avYVUst5DZStLt7dYVp1W9HcOMzris4G6NxdDzzTbBURPHTSPEy94PMNbg98kpXChutb
	 gXmccEO7igvAr9sgwm+y2Dp/XXJ5EnAgyiahjvvYST3pqWSJ5Sl3XOW1L71qV7jeijXOz
	 JLqSCMgTL5iD9dVkec3AsZsxcf/gYSId5/szxOBGL4iNjvHBH6Exvz+NaAKUwbkmTCIso
	 0ahaQ8HWRmN+7qBvnCnVBGESfkt8eI74aHSGn/m4t6dLImvLtuwZtQbp8l40ybZ+E3gfy
	 p89n1hlkaV8GUuHAPPnNCKmBnz4uj1XbE901pRDgNiEAl2XLL51IJuQRLQzuMSLQWPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mO++9KXu;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A3606A31E
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 05:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 261A3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mO++9KXu
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso3736062a91.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 21:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795671059; x=1796275859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iopZBYuyd5Md/S04U0z1jsyC4Z5+nPgq1zvcRMuA70Y=;
        b=mO++9KXurWq1xtaZn1Fs/rnO3p0nGq49JlnP3dndiBcad0Ptxcgz91D3XrwQGoj7i8
         sS6yKaLG2PuWmj9W0tXAkU+VcFyfweziKB61assQapulXENKXv5v38S5ZOKHO/o3ew8b
         yX0qcb16Mp1NVoqsA/umdUIZBVkUsTt+QGwWyOaz9NakdLMd4jHFIfr0MQDiXE6dukFR
         fxXv3eNRbsad+jszQ803Sf1EcRhBeXxnnbALiaB9zM96QFyA1c3eXq2k6TLQ6Pu12TOj
         cn/t8jFQVGaXUDFVMmx/5H94QL0O2VC7ztzZzh7oIucQJcUoy73Rijz2yqePX5tUBj8y
         hMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795671059; x=1796275859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iopZBYuyd5Md/S04U0z1jsyC4Z5+nPgq1zvcRMuA70Y=;
        b=fU+csM5LbcvH3kFm9pNp8Mryfzjcua31e5et+o8sCZgpCDPJH9k41eGHUKl8/Bj2Ve
         fI8L+zyahMFwEyLPh61mT4JPC5ok3/RMmoAFyr7gem0sOkVlWh1OLTsawPhYxibOr8dd
         nrclOH4Q+CLu5/cSWZFN+iBwB5lOMoLzOToZpuWyFkXgS6O8Iqv7F83kf1zmjcEJcQgN
         UrruEVLzXvbBm7m/BDmezrBt22ol18P0xyz1n113pKSPejwwdDABVAAuJZXab7kEcf7o
         lr/bXBE4rmS6R9FjdtLYJjH7kSpFHb5z3+ptT2piTAHuACeSPgLLqIjGBeyRcLCyl/Ro
         oivw==
X-Forwarded-Encrypted: i=1; AL+hErFGMLoxLgWb1clF13VwOajniHonefOas9+ctR26jhbiFk+R1/vYa9uZRaiI61M988PZf0rhHjf1zJo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RtLPW32OxYnq/Xs4DGPehWEiy0boSpiZoAa3E8E57y0U7IJhU
	Gcmg5jVnjQi98e0X0DfYnHYTLFYbbBPimdrM+LiaVRkctXWIP5mqVRdg
X-Gm-Gg: AZFdTZdnrIP54FGom8rqROeusk0dovzveawvxR0UrGlVEFNrI3ivaZRBbIvx2Zt0cNH
	/CXLE0EDU7A8OzKbyHATvB53zYonF0vu0lY4WC4r/WM+HEtfTDSdv3qrlgGh8ZGaysmRWQPwe15
	r4NnWbIAz4Kz5YwKkLlcoA4RNP/jz3G9yBSqFI27fsxmyFSiqRUYPvVLw+LjmUW6z+aDpZLSEZq
	TzOkd1z2EhYaS2lRYk2aMCw4C4xkRIZgITod5d1a3Kp9DHWqU2BNyuqWWwlU+5L3Y6cSzRQ+ZCP
	WjC77KfcGmVr/fCgbzjCikC7iJwopGjYpqqGboglelzFiU9BURS4bVvGnnNnRNQRVvuwmkuNrcV
	97olPlbRJ8uXXUYExm9hNxeUq3YhHhe6NKiejMh2lOWYiZqIPXYJebVH+LiTmdB6zQApyZRbYtA
	aHwIjNGOQmr/XcspFGu4Ic2YjOw1zxZAXpp1zgBFEAFqu640hVdZCJZc1SN/dVHzTl6NOYuF6fB
	yAr99nGb9cN5//C0pVtdLrlYqwucVRX1baismnt8AfH5kru7lvYDMLJC+FeipXKaZ+1O9yC9hLt
	/vjgmsdMUAYiobbF63a8DktKIX24iAnaEVmE5U+FP2VVdd2T3s6FDU+jacJhAtyi7rXKmC8e+0A
	h41q6cwoW0npyvvqf3ZoHQ7iLy9m68qtRsiLG13KSy2bLp3F/HMIvHxKZBOfvxOfqWwNsTiIa+l
	Sy2WWfdkyFrEEZyQsUeGMlXeg=
X-Received: by 2002:a17:90a:d2cf:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3b41c8e0507mr12673486a91.8.1795671059384;
        Wed, 25 Nov 2026 21:30:59 -0800 (PST)
Received: from kapoor ([149.40.62.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b409330ae8sm33700520a91.7.2026.11.25.21.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:30:57 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Wang Shuaijie <wangshuaijie@awinic.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 1/4] iio: proximity: aw96103: report negative proximity diff values
Date: Thu, 26 Nov 2026 11:00:25 +0530
Message-ID: <20261126053033.603086-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126053033.603086-1-kapoorarnav43@gmail.com>
References: <20261126053033.603086-1-kapoorarnav43@gmail.com>
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

The DIFF registers hold a signed S21.10 fixed-point value (Awinic's own
aw_sar driver documents the diff data format as S21.10), which goes
negative when the measured capacitance drops below the baseline.
aw96103_get_diff_raw() divides it as a u32, so a diff of -1 (0xfffffc00)
is reported as 4194303 instead of -1.

Do the division on the value as an s32.

Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/aw96103.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index e3ab55170b6c..1fd0ceaf2a05 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -268,7 +268,7 @@ static int aw96103_get_diff_raw(struct aw96103 *aw96103, unsigned int chan,
 			  AW96103_REG_DIFF_CH0 + chan * 4, &data);
 	if (ret)
 		return ret;
-	*buf = (int)(data / AW_DATA_PROCESS_FACTOR);
+	*buf = (s32)data / AW_DATA_PROCESS_FACTOR;
 
 	return 0;
 }
-- 
2.53.0

