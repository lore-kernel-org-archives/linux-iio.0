Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D782B4EC64E
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734332; cv=none; b=APe7GXGcoVpGKpCB53r5uw2+j6MneP5kNV3HqXZeUsIubzvF+LrEUSzM1422Pk5ZQJJTrpgmlc3e8WxfBRLPjOOzhjwhPEnHGnqHy7RbPc8jsnl8L3FNjBy1xSovlARZpRGFJ2jDfJhUN6A64jdCeUySuVnKOIjEHG/CSm+zFZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734332; c=relaxed/simple;
	bh=LqBSm3USoMc1NhaRdGxHYrJshaTcBLFmk+HruTyC934=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mvr/nFaKlJeX+lgzzm1YKnzckKZaMt/LQN0xbMNJ4/Ql92ACPxdVdpVAWN0zyJ74MMj6ltew9YnWOm/o3/cpbc8YpOw8fJV0keR05EaAgHz6urWJCKOPTXB6VxKewvGKCMkdq2wwNP3P+eoxgRtHgHFJvq7ojqe7lEMIAca8Png=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMelwOQV; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMelwOQV"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f13d7aso870791e87.1
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789734325; x=1790339125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tl5FK/P0IILzUPHeJ1tB9KQK9WXKF1I6DTxx+ou/T/Q=;
        b=dMelwOQVFF66kAG3ertbmXXbtBZLfsljfipx08+1qZ27yikuLRt5jGLMSz7F0BOKvF
         zxnImRUGYLq3OZkICJbYmzAGYa7J3UUNttj5dwMjx0Malmhzr9ywqho+gYEiljj7uOkI
         i2kVQaLqFaxF8YivVzhNIQ/3t0vv5wLqmjDw2g89xhWkvkPNivdbwRj0Z9sCH8gpfnm/
         1ND5pcY9U/20DOSWg+6tZfhbb+g8g3co+r0i3H2jy//Fz1iX094sA5x8F3cfXwdIe9fv
         supH57sNicCN732A89506kw/lCQ3FWzOhpAJzOzwSb2B+jbU1zsBQQroetKWrjIfaFDl
         8pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789734325; x=1790339125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tl5FK/P0IILzUPHeJ1tB9KQK9WXKF1I6DTxx+ou/T/Q=;
        b=tQT6/6G9Ap0LxoRsnEm3WIETQ398brCvZWHz3yNRCbr2GFM2r+eBT/MYwtRWU+aCtl
         dMuuQSHKr/FjzubM2XMCX4ouGsXbVndYpqrr3Lz/hSdWMakWdnjq/aw6vcX8RCCVFOAq
         0UWklDmCBXzbcHMXI1E+GfQsLFJQsF6h0RMuKXUJ8hpf1aJVTgx+y9Nw6Rjm9SJSJgd8
         i+8oLLi4b4X6ASzRbqXuVpW7JsmM94O2/PuqRNExZegSv8+6zyBYuT34xiLX9CIuj5yX
         zuedKUi9NqV0sUmMetk4A43rYAkIBggdpas9Wm9ZQ3J5ruzy/Oh4m84A8b33jpXpLHxK
         eDFg==
X-Gm-Message-State: AFuF++l47MJ5u0k4KuQPCJjisb4a1Ts9cfFK88460jjV1Tg4+lKyIZ+w
	9jvUa2sRu0V0Q3c2uJ+aCkHAQCKQobCXlKRon35g0LQMYx1ZVxYiUvY6
X-Gm-Gg: AYBFou2ZEM34BhKCPHlNMjbBET5cYha3Rqx4Cm24BgRBhu9x1EDHXC5cbFu9gzaYmQS
	q45t5lOabcvoSL7A9fBNhtiKroBme4Oe3OoxfNNkVOa7OybFDygbgsgZg1Yjk43vRAn50iEykvK
	u8+JPgTSpd5kkLj0U1Mx/yo07uvzQ2/NAEx2HxGmABy8q8XYyDci/cwa2fQuWQezWW6uKUxdf6T
	JVYdWUCViC6IJ1qGzV5K5OTiGAeh98lIhtdHD5DTE9eJeJoHqa41fb8L4WsEJdMyQoHGV/lXm1E
	0wzVq1DVrS7xpLfSYiT8woSPB9ca9TNdFYDPa51lZ1J7SdjoPmbU0fMeuFvGAGojVEqadlIlc8n
	MTgrtJlgjLjtN5TfeeW3z2XjM+FvQyuvvhp+BhYtFXHcW1xCCBt087WdrEATplk3Kze0k/Is65j
	bAf21C5exM3VlarEmK3uR0L51KIxqlnMt1hZc9TR+iG58Hp8Nrez0fmrodSSk56Q07msqikvlKg
	T454VTpf4GdPv9CqXvWVomqWdBoDtz5abvtYFU1XmmeE0UsbNYgnnEDXjnqmbTzIf7pWBpzWLE8
	edGL
X-Received: by 2002:a05:6512:6894:20b0:5b8:b331:19b8 with SMTP id 2adb3069b0e04-5b8c184e382mr435418e87.38.1789734325210;
        Fri, 18 Sep 2026 05:25:25 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8c270ea53sm398549e87.12.2026.09.18.05.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:25:24 -0700 (PDT)
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
Subject: [PATCH v7 06/10] iio: core: add an accessor for scan_timestamp
Date: Fri, 18 Sep 2026 15:25:13 +0300
Message-ID: <20260918122517.377565-7-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918122517.377565-1-zoone.rupert@gmail.com>
References: <20260918122517.377565-1-zoone.rupert@gmail.com>
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

