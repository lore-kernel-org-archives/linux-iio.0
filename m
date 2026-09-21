Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F381D483829
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015511; cv=none; b=tNakfLxz1UZIWn/zsZQiPQSSkx1b9v8GujfyHY9tX8IpMqIUZ795ScKVKMfFRfaJhi5Bs2ttzsxX3ucf4tABI3hgEkAkYXa6wpVQ3sSNb8v/a1Zagukg85+r8vv+S8L0/dnFQsQBsamvwcttTqlJoPoYYdxiSM2AFeQ+HwvWKaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015511; c=relaxed/simple;
	bh=LqBSm3USoMc1NhaRdGxHYrJshaTcBLFmk+HruTyC934=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k70qwUBMmJeHqbCzMxffcLvDwnYSj00WCzNhrPaHNk5S1/mfsDjoGLuzqtz64eBspaf/OjOcjWQzpGRtQTLMR3fDU2DrDTWRfjgHhcd+nKFJECp+5lXetozawbJ8KnJQg+mIrGDeh2KK6YI2d089BbNZ6VAmS0xcrH21YmqA+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/MhIEfV; arc=none smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/MhIEfV"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a612404718so17709921fa.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015506; x=1790620306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tl5FK/P0IILzUPHeJ1tB9KQK9WXKF1I6DTxx+ou/T/Q=;
        b=Q/MhIEfVEAIBX+g61CMiTtWi+lHAdEnDOqHgS7D+Xe8W9lYBCAE6M91qFWwmXO/d6B
         KOPvAHozhSMjr5Ue8YNGrvl+w6xy4jBVelsBnOdrLlVK8FcOjmAyat+d53FfX7DBBcUE
         dKzXdyXNxdkhV2TESa5iMD1P93j7L6Txxb3R5EvZrcBuAd2FGHXwRwvsFsCAXwehjDxy
         cJKWUWw/Pjar3F8mOOKfXatvYTsZRBn5T4IjFNik4mCJVxKD1taV8B4Atxa1tqA6wBuR
         fKBv8Nvj5iBolNL2/5kMr6p4kTX+iQaCRlo/QfWTSbuy1hXBHCj+cBG06k4sWK0eNNOV
         dcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015506; x=1790620306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tl5FK/P0IILzUPHeJ1tB9KQK9WXKF1I6DTxx+ou/T/Q=;
        b=fLD++grYGAbP2PFXSBWNosU1U3DzlNkUs16Xpaxl2cjr6d2O049crjPxEmeOMRKnMU
         UN7JbcMv1VDhNGpnuaXbSkoWjPfNZ25gMvK5TYFbKwTbG4ymn9QXYIo+CGzLXkQGVLbq
         VTESzsY63KHldZYZlnqlOfeD4YoBGqsZBdVLCqH35YDNGWa4Al8yjiOQF/RizbCwjznd
         sdb43p76Zw2QVFKDHNbvZl09wutgjqENWf5pAdDhnmuc8BZI2Uns2FoJcyDovDuQ0Gwr
         IAfdPsNUpi/4/aIJfI4r/krS5QfgH6j7j/CzEt+gNfZOIQGTpwnEjyUU3RHo9m07aESu
         4saw==
X-Gm-Message-State: AFuF++m/R6NEerhCbd4WDbHjkXsJGee+xti0+aogkZcioh1KgfJUJ71i
	GhKoys1aj36Z+yKGhMYhnY5BxlRe8ShpD8WZMiebeyKXTnZnZFp1KVF9
X-Gm-Gg: AYBFou04CNQm6Jn9OiVcmzFnhyD0JKXUjzIhyQv58mRqcavGYFGoezzdI0xSodeH5P6
	1p3aDV3wMp2WHpfqwXNnXPexLgPllo72dZcz4NXCca7YPCfs6bgN/8ZZw1HGpSDK3Bjg0zDo+M6
	Q9qbNcIEXbMN7aFm2OrV9I7Z7qK2Tdh+OH+i78jba9aHU0iYwFCBI/F1yFKuTM2I1j+F9JKD9T8
	w39s81OCBICuo81eWS1vUbQKl1USgxfW35yY/RENDNlBGGkDeUX0uUmXbyv3lANli0dC/Qycgdw
	P0gYASQ50MMQSHkUaoY1F3NeC0CqKEakXSc7/ptGER0ZhNc/IpztQGqEFxsBClla8mVxZ6oE7wz
	gZbtsM1WSgB4A211iwW3BZOuNPPsIR1xOG3kQnabyEFKG+pnrHDxErbgTtVSH1yd5K+OhDRaaqf
	lpWA3rfhJdKbsg08Idn0F+HpYVHOYGEZlzLTW/dX0uY8Nau7f79gbTPx5RI0Eh+/rjXxzv5Hw3j
	htQ741w+TkeRMrk6Y0lnqZc6VzxHjgXxBopJ4PCpx1Qm8CnaGW47fUfp9Y2+66rOapg6Q==
X-Received: by 2002:a2e:b889:0:b0:3a2:f233:5c6e with SMTP id 38308e7fff4ca-3a5fbe31949mr26986631fa.6.1790015505618;
        Mon, 21 Sep 2026 11:31:45 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60761e5d6sm24260141fa.29.2026.09.21.11.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:31:45 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v8 06/10] iio: core: add an accessor for scan_timestamp
Date: Mon, 21 Sep 2026 21:31:28 +0300
Message-ID: <20260921183132.233136-7-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921183132.233136-1-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

indio_dev->scan_timestamp is __private, so a driver has no way to ask
whether the timestamp channel is in the current scan. Hide the
ACCESS_PRIVATE() behind a read-only helper, the way iio_get_masklength()
already does.

The dps310 FIFO patch later in this series is the first user: that
hardware does not timestamp entries, so it refuses a buffer with the
timestamp channel enabled.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 include/linux/iio/iio.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 989c1db8fb36..a893e36be988 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -1083,6 +1083,15 @@ static inline unsigned int iio_get_masklength(const struct iio_dev *indio_dev)
 	return ACCESS_PRIVATE(indio_dev, masklength);
 }
 
+/**
+ * iio_scan_timestamp_enabled - Is the timestamp channel in the current scan
+ * @indio_dev: the IIO device to check
+ */
+static inline bool iio_scan_timestamp_enabled(const struct iio_dev *indio_dev)
+{
+	return ACCESS_PRIVATE(indio_dev, scan_timestamp);
+}
+
 int iio_active_scan_mask_index(struct iio_dev *indio_dev);
 
 /**
-- 
2.43.0

