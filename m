Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3383B3769E4
	for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786924011; cv=none; b=T1kJXpDC1oEKxMQnWWyOxxCI+WNzkL5bA4lfEoTti8rGmioXfwsYbPNvI7uSEh3cInUU7WQElip4hVl+S5HOv9JYxu1Cb20AOKjLtadg7AQPvFkVBECdUY1fBl/stVhUTYjTz/Zx8Ax8iaz/x93SsBieJ9tmcMSubXIvWJcM9Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786924011; c=relaxed/simple;
	bh=3bTtYejLXGhqySQztKPdMThYp0FUeqy5qX0+QRrCMNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJ2Ta1qbWvRX5s2AYSD27o0kukszeu4WK6G2D4/wLghzo76ggAzanerr1lB/kEl6X30eyUtb5AHqLR1dg3uBrqY7lDopqUBMIGarUpuOVLka7gbJg2jO/AZqjKz3P/XX1MwAc/vTuigNclCFflVeG4HD3QN46x3R6eRFIivEt+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJnV3gez; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJnV3gez"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f7872abb6so1532880f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 16:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786924008; x=1787528808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3bTtYejLXGhqySQztKPdMThYp0FUeqy5qX0+QRrCMNE=;
        b=GJnV3gezJy9guC1LX4vwI71RiiTpyXFDfZIEDNwdE+YrPPRpqcG4T/UAhX/01zsw38
         kcioj+us3dPwbMMadQBm8nFL2zCUPYi6KQkg3V9IU6F9NahNtxvRCkrKxcg0Qq7x6Bii
         wQIuoZ78bdPPKmB2Ic2x7aU9ns83xcF1Un3/z3RnZ7jfGXEw+JNyCMdg3gzGY7J3YOGW
         9RSr6M/8j8xccNbpanI690phYcd/QvkmHTYzzzhyYAzwRJUQ/o9wisDI+rwgfi4r72ZT
         mVu5gtLVT5e6/8z8Kuu3Nc7WjbcuHXIxveGhuEsxSGF5sWs5EZO7vpX9YneGZ5R6jN+/
         lRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786924008; x=1787528808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3bTtYejLXGhqySQztKPdMThYp0FUeqy5qX0+QRrCMNE=;
        b=FWb8nxgU0dEJL//1jyvICTLJKCo8TkqhqLcVq9j0GaD1+5eK15Yj/LzhqR/N5STVzi
         4gWy+9on/VSRsYv775xDBNvUJhWK8BRdLWFq23aUCANRVPsZimg18rphm05nN+zVD1NX
         RoecENe3U7TSAHNU6+fuL2GfG4BfiLrRj1tXoomCCY7K5NFtH8EUgAfuLak7VKn9zc8F
         Bypp6juEBxuM1zXXWq9gN5pSo5kqG33Z2cXe8OQqYoU5uaUbdGN++llYH8DWvV+USF55
         2bWl9BMzRzPzJfnGeIgwMFNdlGrI07vkdp690KD1JBAhuzF9cFOb/IsEq3XLbxxT9Hs8
         4/Bg==
X-Forwarded-Encrypted: i=1; AHgh+RpKcslzLm8P3vRYHJtCqpIyvr8dJ7f1CnLs41eoXDOidaeYso6nXl81ymZX4MLhXbKuatfCNKZJjzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBzJKq7BJ/vMiuBknKpAeGvSvCeV5jJDffPuaAODUGcm9FciB
	q+yfGc2++ftzDhxcA0/QjVwN83OiUb4JMOfOM/bHtT85Yiz3ejZx2sO0
X-Gm-Gg: AR+sD13uP34R4bZ5K9TGBStljBQ2wv/63NBebns4yWZREWn5uedHLaqejOTd8Mxr/Q2
	2kQ1LtrN4VCPClXFEHMeFzHzttgwHKZxf2c+wjR/Qd3jS6ELNoq5gz4KGAXPU0j472x5xp0mzYd
	2uD22d1qzDKZbJ2syVzjT9+OWuN2bvBbvJz5koSJU13RKiNRaJwtEeIoa4WonMCexVOFClwet66
	nRl5p8mZ8AuIG3n0mges3QmuAJNRWnChfc1fCJwsKhSL9CZ8+5i7F+WnGMPTRQDDNYUe742ciUt
	1Za9iSjZlUCS05QpE25KZTAa8qKTDn5I2oLH+H7sTnABS2knZRszy6BC86clrx7r2wkcufzJw4F
	kBg39kWKxDqXFbT/8v2W21HYnxBBuqi74v0xfl9S+xfRvb60h/xvRpNFkvSjkpc9fiT2mDdfpxT
	rJSxF1+aBloVQAVxROxR6ar7O2r6upLxabbqNlKDcBjPELKsEjWBgljTtusmC/ip3YcIcw5WYIt
	bdrX0RNHqX21PG1GJdRymAqUPtk8vcX83w=
X-Received: by 2002:a05:6000:46d4:b0:481:5ba5:9927 with SMTP id ffacd0b85a97d-48160705dcemr21084607f8f.9.1786924008424;
        Sun, 16 Aug 2026 16:46:48 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:ac71:8b16:e755:35c9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cdc9fsm27511929f8f.37.2026.08.16.16.46.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 16:46:47 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: accel: bmc150: DMA-safe buffers and use iio_push_to_buffers_with_ts()
Date: Mon, 17 Aug 2026 00:46:46 +0100
Message-ID: <20260816234646.15767-1-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260815175728.99541-1-yashsuthar983@gmail.com>
References: <20260815175728.99541-1-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 15 Aug 2026 23:27:25 +0530, Yash Suthar wrote:
> The trigger path used a plain s16 buffer while the FIFO path already had
> a properly typed scan member (__le16 + aligned timestamp). Those two
> buffers did the same job, and s16 does not represent little-endian data.

Built the series on top of current iio/togreg with gcc 13.3, x86_64
allmodconfig and W=1: the three bmc150 objects (core, i2c, spi) compile
cleanly with no new warnings.

I also used it as the base for v4 of my bmc150 series (event-enable
race fix + guard(mutex) conversion), which is rebased on top of these
patches:
https://lore.kernel.org/linux-iio/20260816234231.14168-1-grondon@gmail.com/

Gabriel
