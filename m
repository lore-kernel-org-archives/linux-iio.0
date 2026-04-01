Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002DB2701CF
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063715; cv=none; b=AmHhpnUh0U5g1g1L8D0Vb66sp5NAOIAbyHMdYboYq3yDEAAgyu0Ab1JxM32UcRHd5ySq2CyDjcewfVkukibFlb/FiedREQqnNK08IQsaWSERqoBQjKcCfk7FwbCM3A2POV8gosnf3LOyo3NRHf98ytU6xQXTs25RnGdYyYJFEsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063715; c=relaxed/simple;
	bh=LqK+F2Ypb2KsB2A32FqA6hBr8TMRaI5NPIP89Pl7v08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoJH3vA8dSpF1MMkeDg3NopjKTvh6Ijb0mC+aExxD0V12Boxa7f+35Yv6LZFpSLlKrz0X9YXjdwQQkOwI0fFZPaX/2H1xe+OdygUPkG6M+jmZl4uGOnH7E8xN5xWcl3Cxa2zZ/qVLmRtYLB6rSo1VB4Q++jHlIum3cYyLD3VPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mirrorstack.ai; spf=none smtp.mailfrom=mirrorstack.ai; dkim=pass (2048-bit key) header.d=mirrorstack-ai.20230601.gappssmtp.com header.i=@mirrorstack-ai.20230601.gappssmtp.com header.b=KJGaw8jA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mirrorstack.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mirrorstack.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mirrorstack-ai.20230601.gappssmtp.com header.i=@mirrorstack-ai.20230601.gappssmtp.com header.b="KJGaw8jA"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b24fdac394so38663915ad.3
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirrorstack-ai.20230601.gappssmtp.com; s=20230601; t=1775063713; x=1775668513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqK+F2Ypb2KsB2A32FqA6hBr8TMRaI5NPIP89Pl7v08=;
        b=KJGaw8jAEAwhi6VI/lHzcUdOY0V2hPevjh+UcVbF0CIhi/37JsgDFvTdAtetk4BpM+
         0dRvWJWQUBdf67CiT+SlssHMIuv9lKv2XZWDjI+8IQF4WJVE6F4O5zNCkA3Atns3ypmM
         9dZ+svR0obkETpmmSdxFx30G+fhvxHjRIOE3QWFn8yUGjqH1VRcGzAPZCaw0b5oakW2b
         hcsY1wPtFNm2PpNpPANcOkdRHVjcxKGuGd4FSoDPepJcQ8KGrufkBJb5PAGI1F96TUBH
         mM4oQi1GlSMXQPp/bVedDB6qAsYDr7s6aebw1uwDYvkGjzyxI/3HGTRZRdXLb1Td7E7X
         KS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775063713; x=1775668513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LqK+F2Ypb2KsB2A32FqA6hBr8TMRaI5NPIP89Pl7v08=;
        b=PCUCq1XoirXts4bwmX+y89v37qggrvZiO8YspQGQ8QniOtqIsimfRwJW2NONm8ssOH
         p6vm/lXN/j4EZ0uepLrJyVZPv9TIhRQUjH/cbq+V5hSclISUlnXj7X3sGeM6+OLkSGn7
         3Q+tJDeqWiSB1lXd5KJ/eOAFnp2Zzlt2QS6JNZjniuovUD2tBHBrbkyalAynBw4nwIwo
         fX262+TcSkqX46KMrZ//GrUqLCJ45faMkaBSnHl5R8GSZ3KV4Du3Dq00jiFt/C98hqKX
         VujlNukXbExmi570u7oF2UaCcrFQu5P+1KeXPioYY1U4jQZFo75uMp6gmi39kqglQop2
         GsAw==
X-Forwarded-Encrypted: i=1; AJvYcCW/jhweDBqI2eeXmDht+Fe5v2lUmzvGKfRIQxmC3svEd+P+U77hgL8Docl7wKIOsFTZeRGlrdubBlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/svaiNZagzjsPCM8kQaJzpclcHDENcxiI17CGb8lkmXKFBQC
	tOtg8YfUpA8k6m6z7jcbVNcmPwPIysM8Wqj8eCRhC6IX+NCdyYht/vD/SHcNAha7kQr3
X-Gm-Gg: ATEYQzwLSnw1PcrZ476t4EHTFPQV9lMiEwJt9ngBWCzlu37rzPVx6HMwiS+CopyMc/u
	b1wcLk3UQLgLOjUSlGjBuKOCoPOXxaY6/Za7HQBo664ul7M3VbTM8VbtVTGCMfkyN66lUYUrqqa
	/lyFDlE7UWA62yVsG+SvM3QdLkteQOaL94oMx3jugwBkeAAHVA33igFM36TQePCUm75riu7Bl9Q
	hPV2Mej4G+wPwE9Uy4lDov4zjjd8L/kwcXsIUi7XCPjVFRbbMQDi/3hhF97utSWSQzS1HrysGwx
	PFU7fLA7xw8oDMsrwyRSuDv5OhV48/NP4eoQiG8hlFeeygKEnxk/B4Zhzj0ajIerZKQrF8FkB23
	cBoq+OVnulWlSX9mN/KvnebiAjoPcVhbcm2i4/LUCbWmMmYjSo+KS9WW1qHUCKijjj4uwfoScMH
	7Rd738OgB87a41uiJCMAmg77t4f0ceWmWlDXTUAyBiAYtoWtLh6t4PUPVrz/xIPR0RxaJlJ9Wvs
	UblBUf4eU+GgbBaZPe1VoPzOBHM/QhNuffIkrm8VQ==
X-Received: by 2002:a17:903:4310:b0:2b0:b325:748a with SMTP id d9443c01a7336-2b269c8490bmr30058745ad.22.1775063713302;
        Wed, 01 Apr 2026 10:15:13 -0700 (PDT)
Received: from ip-172-26-8-186.ap-northeast-1.compute.internal ([2406:da14:e8:bc00:e546:17ee:7142:6d05])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749c38adsm3578525ad.69.2026.04.01.10.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 10:15:12 -0700 (PDT)
From: Sheng Kun Chang <nothingchang@mirrorstack.ai>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Sheng Kun Chang <nothingchang@mirrorstack.ai>
Subject: Re: [PATCH 0/3] Move adis16203 inclinometer driver out of staging
Date: Wed,  1 Apr 2026 17:14:25 +0000
Message-ID: <20260401171425.89186-1-nothingchang@mirrorstack.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
References: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

I noticed the existing Fixme comment on the Y-axis channel and
Gabriel's earlier attempt to fix the single-axis representation
(v2, April 2025). That patch was not merged.

Should I address the Fixme as an additional patch in this series
before the move, or is it fine to fix separately after moving out
of staging?

Also, if I should fix it, would it be appropriate to pick up
Gabriel's patch with credit, or should I write a fresh fix?

Thanks,
Sheng Kun
