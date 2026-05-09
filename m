Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3F7372EC1
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778351527; cv=none; b=G+uJaS2uBq0A/fe4dZJvACHQBAwIDyADsQOxKjnl/WVOYUWKJHggl33T3bPx0Ce2q4AC0I5EGftUTVJKz7+o6SO8Evf2pxPJV05bl4/M9ohMWEI3vVbna6pKXzzJvT1u9Xyb5PvczCCW5A3UKXX1UkZXhE5IngfjoAYPZDv3Mg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778351527; c=relaxed/simple;
	bh=+38zmIFz3eJno/wNzaq+qElkGAgsWUuwwE51oF2p08A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rkdzZsQRxX1v0RIwM/Do5SIonEE/mm1yTOYUgbhu/Mt9EvZNHQ+ge6/KMj/6smn/7OoafYBBHV0auoF+ez/LbG75RKHSnYI9HIAYT8mvDVrevnhj3j2B7NqAjQQoeu6qKYjXZepPyyTgdnN8TA5MD5Sm2BmKiXC2w7QsaP22tMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHHLmDdf; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHHLmDdf"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44ad87a57f6so289241f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778351522; x=1778956322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+38zmIFz3eJno/wNzaq+qElkGAgsWUuwwE51oF2p08A=;
        b=UHHLmDdfq2JLLr6bk+G/W9OK+BojXR0O5oDO4AZsKvS0bQn1aZ31qxX0vdiG41fTb+
         UD2h9tWeZSu0NsITBPLgPN0jx1kZWjS8jaZNgVHFHBSGRLgz8l6EQ74lziVI9gKl3xPg
         P8E2kf9hD9xIAMfMAisElDh5svblIw3PZu4taG/gZCAZKSa4dxUL4W+JDEUmXMDxx/Rg
         qE3n/7pQ0MWdjPrL/tN0kWwaIuR7m+RojKVBbB1/IxqqODWu+NWC1SGmQDXEmNzbxNYt
         PP6HwVzeWSli2l2f0aXcTOT4dLiql1gLm/mkiteQ80fpUj3m6z/Cn3fMHMdvPXn0tEYc
         1L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778351522; x=1778956322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+38zmIFz3eJno/wNzaq+qElkGAgsWUuwwE51oF2p08A=;
        b=QLi/3dOzQj4cNRMucz+zrJ8xDO6oi8AAp9k/0/ydFdel6xYI0k1oNfHgSrHiodUPdx
         +9fSBEgRQDXJFroizpio3ySlBYIlBnFmqzLSGyPAfd/3jES94PA+z7cuGfkQ4aaCzQnW
         qg36ZdNLU5SKw605JZKVYyJ/mb4OjHYBxKxTLo+0PF+8tjtXhIkOk0GQNnIzRJnufYYY
         gLJ8JtLSawwVqG4Ki9mFVFPv3hy/GKtdXtC/bF1yk50sPTmQeMzATAwwQdb4EJU6MUEp
         nEJdglU+ckcxfFN6hl/1AmENPn9HiONL5RNsKdIcVOmejGenNe1/gL0Jzw34jjcns93l
         VDbg==
X-Forwarded-Encrypted: i=1; AFNElJ9UukNu/HATKxl1k1q/l8cwlI6tb+Wc049+rVU494SeZd4SU+hLMLo83NZdaYeHDsbWio8kXCPxrrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMlQm1kMFURqpJZRSaEq/i0QlOV2alvvz4FtZM9FfRqCgfxBd
	u3i0+7S8pHZlXj4fPJraRkhXwp4lX0i//HngED5eu+oygqfd3OcTcf5F
X-Gm-Gg: Acq92OHC8YJ81bxGYtH326vUUz0/6Zqqxqc2Ujoosk8wU3sGQcMhoxBRad++M26w3Ug
	zctRx2K+GO+uWNI1IIdOUMrtvDzaLXISJ9QP8p5ynHPKJIpRHEOzysI73V4xRkWYNs28yW96kSW
	tIzGMj0xaDiYn/6dVDXOqZ/Q+oG5/y0j5CTKHrVykbIGEEETQYuyTPpGlDUZmxkAI0dfkSANdNo
	LJw+9V7cJ4gYQuXgoNjJOeVGf8DzagXiC4RYtLF6Qs422C3LwEn36rhI1vadrsN1iZ65OqYvs2L
	A4yMAqQ+s1bQ74WiHOkBwtWzLaXXg4n2UmdT0CAykB3mlDVXg1IT7601HlowjHpn/8I8MaKm42V
	qxq0ahU8hxtrj5lG+HsmywNrgGg5B+j+L/jjVtgD6tuaoECMGDt4KHX8p5RIiBDWurBzNREdCBF
	meU8juuoDMYIOAx9mx6NI7c/ELqwv2fRxOzVq+VULaAMjLGbPkjnSbmnI=
X-Received: by 2002:a05:600c:3ba5:b0:48e:7a10:1f5e with SMTP id 5b1f17b1804b1-48e7a10204cmr1278585e9.2.1778351522435;
        Sat, 09 May 2026 11:32:02 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b071sm13157093f8f.14.2026.05.09.11.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 11:32:02 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: giorgitchankvetadze1997@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	m32285159@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: chemical: scd30: make command lookup table const
Date: Sat,  9 May 2026 16:16:33 +0500
Message-Id: <20260509111634.21700-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260508133915.22042-3-giorgitchankvetadze1997@gmail.com>
References: <20260508133915.22042-3-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scd30_i2c_cmd_lookup_tbl[] holds the fixed CMD_* opcodes and is only
ever read in scd30_i2c_command() (via put_unaligned_be16 of the looked
up entry). Marking it const matches how it is used and lets the table
land in .rodata.

Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>

Stepan
