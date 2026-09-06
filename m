Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8BD426429
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788694878; cv=none; b=UxTerLgxpElgq2whluuQtQWQnC8mFf+4y6+SE9oFzP0wHdVHqKJwRGKGbeb5/LnffbpZqk+1cZKeO0vypajx9pKX/FLy3hELrBwfvByQj/WzYkWOKqRFX8TRIAaPJ+ZkOukSq+b/99htK37vTO2SFeNizEFwggnT6wDXGBmtj1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788694878; c=relaxed/simple;
	bh=L7WuRDtKownGDfemfPtuBDAiWjwoIi+XSLXQ2oaKJoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRHcckaTw0n4/ShCD2FYka8mSVhnz0fvXPa4jJdPja9RfexZmWEE7XBhWHTjlpFAsguhZFgWHbGdg3dB1ykXtQq48U04vpH6X5saJ5xPKEu3yDXL766FpHjLGQt5+AfRyawd3/o6p1HYfchit7eG0Wg86/A/lrdo0SL6F6JCHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+maQ081; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+maQ081"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48431648f33so2596925f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 04:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788694870; x=1789299670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ARf7a0QuDmnTVS4e664PeRczUd5kEyLkns5J9FozqNA=;
        b=h+maQ081zONsj7qZ6XiHcb7KdCz/Qgk4ncAZamxVeHudJLjN0RxTiT28NoI6SVFYIn
         ZOLqAKRwNIAFrJ6Np+JyjlHi0BU/onEE9KDcoIoqakEYcMkXHHDXCJhsgZWvSQES3uTY
         32Ny6wEPua+SxBmpdUANzHgU35/qbjlZTorqkgnGow8fTkpBUaH57TH1yYQJCkQfYFPU
         J+1wR8nHItqcxzZfDJauPAXKq9ToWl8HZBTV8+MnnBFuL7SekNo++Wey5sYxSKq5GgiF
         0V5o4kkk0mDNbrctN+nCKlcKYwi95G9OY4TNzHl/BY1nJdEsml+hIgSMfGq/G61/5eRn
         /uCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788694870; x=1789299670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ARf7a0QuDmnTVS4e664PeRczUd5kEyLkns5J9FozqNA=;
        b=pgQLnmPoH3AvmLJ5d1MYS9u0xqEX7xmZJyrxVDLALSOMYtkWgq2QrnqKOAQfyigQgM
         hqm0MxKGLWqx0/8wgqopZreWzrXQhvFrpMDcpoYm1EJ5FSC7C469WLf55rE+2/6GWmKt
         VSuRMdeEPvZVm8JoDimYsmgfxQNRypR78XpHtNNRcHMCU85lsImkyMabFBNNn0+beM3F
         eubH6t3dTFe//z5Te+0In2Gc5TruTcul5s89OXc3rhtNXCUKfbiZFkMo9r9cMp1xNeaA
         CtxIVanJVW3/h0eILgM5Zugm2mPdTVRgoC/i8xqp+U2annA8ZK1Z6txlIHU2iPxtSkfe
         xSJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRl5nNAh3JzdDUwpH8VArS6ejzxeQamiFPoGtAy+siTkIXvicOCGU70XUZ9TVHrQQz4FGZ6mIOGeg=@vger.kernel.org
X-Gm-Message-State: AFuF++llj5pybDy/a1mythw7Ecr3xfN3nktnP3Z/5ywuSz3LS2tURnwc
	hnJnwEuMv4Idggrq+oOgtsvSYAI5KSNNv1Ck01ikPXAp/SzKzPSjSsZ9
X-Gm-Gg: AYBFou2Att+DiwtzO18id2/iLKPrQ7oyOrEfI3I5BKR1sxGNVA/D99zdbIrviCGoWKa
	ouQXs60vL8ap0GoWZ8SB9dCavYcFrjL2ccpy8EiGw0MtK66+/p1sqTB4QES7bRKytGQAx7uVcjp
	DgPHH+F617bCDxy8O622/NOi/uUYpPm72aNrCLj4jBgztshjBiWyNa3b7/61uLWya1xNfYRBEu2
	M1k+XBraAy4TjU92yLusc957NTsgENnVuH/eIxA72H9eM/YJDqjKWD0VcSpuvG39608R+42Hm1e
	cXItNycg1yP+wyOXzPtEYUUfgckk8CCO5O6flAqWiGU9mtKrrIEIBEev5eS+t/ehNFcaI3Gm4L9
	uThFRz68mAqfwSCky+Kyhq7oABMjIFYQiJmSXTd2vHVqIDgO6ePQ001243NFEsLLmGeP/5+TdVX
	VU95paXx8tYQIVT3qvutntyyO6v5xsvTXyUCXTeo+90GdTAlh+/2wCZfBEp0oST9/5NgCq4O0Jd
	/rmTap7
X-Received: by 2002:a05:600c:322a:b0:49c:f13d:ffef with SMTP id 5b1f17b1804b1-49d0089db4fmr67572685e9.19.1788694869655;
        Sun, 06 Sep 2026 04:41:09 -0700 (PDT)
Received: from fedora ([154.182.82.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ab73c2bsm19356223f8f.22.2026.09.06.04.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 04:41:09 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v4 0/2] staging: iio: adc: ad7816: Fix SPI read operations and VMAP_STACK issue
Date: Sun,  6 Sep 2026 14:40:47 +0300
Message-ID: <20260906114049.32912-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
- Separated changes into two logical patches.
- Patch 1: Used guard(mutex) and devm_mutex_init() instead of manual lock/unlock and mutex_init().
- Patch 2: Used __aligned(IIO_DMA_MINALIGN) instead of ____cacheline_aligned.
- Patch 2: Fixed the sizeof() argument in spi_read().

Abdelnasser Hussein (2):
  staging: iio: adc: ad7816: Serialize SPI read operations
  staging: iio: adc: ad7816: Use DMA-safe buffer for SPI read

 drivers/staging/iio/adc/ad7816.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)


base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
-- 
2.54.0

