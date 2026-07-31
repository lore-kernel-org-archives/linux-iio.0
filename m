Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351D3F65EB
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497819; cv=none; b=pQoJk2fh1u6w5R3+vsA1IC18rkLOjDhnV1aQVDDrCxZY80TRR9kN4kw/+w9lbyFoIArgdYVtWCAq5NXNfD/LtAx2hkQdq5oPc7UGwGfdwxcv3sP3lvGumwoeiLTaCj94mvyJ4ehYp3SrCqFPVYWrcmogncFyKzOghwvFhiLC1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497819; c=relaxed/simple;
	bh=g/XAR49fFVzuq467Ik799+2FdWOn/LGc0r4Y6IP8+yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBw8FY79rw0p3fPvdyUHq4reEDODMr9LXFnn5NbOvYU8wCkY25mBYbMgB77/f1EkjxTAIfkSkMfr5Wd/ZOWjX+SggMAHXbhHn9WHykUseOzaTX1vCNxF5bTf8iMKGGUvepJvTL9Hn3Ywz5ZYF6GR80VjJ4CX6Ge1FTk330DkZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKpOp00x; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKpOp00x"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f703a9d05so553435f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497816; x=1786102616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WwovEeXaCAdfULQBEy/htRRSiSsUVEDD/fWA6pMEZ8M=;
        b=JKpOp00xbHR7rgB47Jl7J41iv5z2u2EC8zhFUCf8B+w9o1MW9puL5S/tT9EXAf6So1
         e6Rr3dwT0r/PFnYbUUsnIIm/48oqLM1K3MU2aoqU89ilDZuMGpLOVE6l0dJzHnxZnxU7
         GNvNbqFOzhFmH5HCRZhBU+MOd3qEMNogXeJKwHbVlV5ntE4PQRX2RFRYqQkr8rnsD+Qd
         VogE+ByHBBTTNIZaHzUabxnwFeTt6tQYCiDKHoyc7hz3LpfipXVCr6ArMdka5BfDcHfE
         sHeiIbYAnbA3mUJ4bH1qA9RS2awOtMI+wGl1jD4ziHvjlBFmXz52VIJ4oZPDlOg3a9Fa
         Wfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497816; x=1786102616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WwovEeXaCAdfULQBEy/htRRSiSsUVEDD/fWA6pMEZ8M=;
        b=sLeF7lFX5TNzvxkSCJw7qCivyv4pueuo6OqsfW6ulcgXcO5486HdFHwh+hgQAtYm+n
         0TVXX1MjZPs24G43YLYDdRI5peda23DeLuSCDbPcfpqioQuDQ9UoXnat5fkdFn9neGIx
         GeWkWmH/Vd8PwMT1+NFUFH8ehsI1kCN0/mCDesDJqBBqMIi6EqTn+OCtqZ1pyxBRqOHY
         +Q2tKjpIhlhBvyQvoUVLUl9sI8+z62kUqBA1Qpl65M+nbMHsMgmYUhdDMJ4tSzIcxuXB
         SkSgVmqvDWHsDFFSf7keGSgQ+OX6g4oU8xvnm/yo16qGs2I/iuXW5AT+BhWFFp6Zy2nl
         zhAg==
X-Forwarded-Encrypted: i=1; AHgh+RoFC4uGSIMCwrQ1Khm7VXveBzMc45TWlnO04lDUPTxAp0pG7S/hWYL1zcQGtvwzsiEadf3NuK/NS60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVnhYUZfHNVMBSHEmcu8aF5yVsFvi3VyhirrD+jl0MKii6VXIL
	vZVUL0BVGZyHSZk6mIVOX5pS0AaZYCa4tIKbxzqectRsla0dgmW3pEwD
X-Gm-Gg: AR+sD13JWTIGvrduIJGoiKmRdKOrV5PxwaIov+qPNuYylwo2mdl4bpR59sozW9dslEv
	YvZcDaaPf+VV+TCHsKMa49vDW4W3MAgVX+5j+dWZfO24lEHhzscLSdpXM4NA9Sdi5hRoUB4yTBx
	ucoUuw8q7ZIp09+c08AUBCBLPdNcANmkzn5Sz9qcblCkjN0PKzukhDLsztSDvc3PfeXj8zhHkK0
	Zpx4Dvajh+UZTCVfLQJnLhw4/2lUyGfrYr1QQbnddxLbaZS8kbAFmyKSZ/CbwX4diqAsUtH3otX
	2+OIcdRSoauKJXZ1Ke2qpBr+SyfBbP7DGbsOV7OTHog0Mz2eBJHsQQovZ7Nj3b+V3b0azHEprt5
	3+xUfQaFwpBbfmsl4MkqYCZMK1k1Iv+Qzc3dVjuC0XsWlpgz+UDhSstQ62FVe3HrAvs29qVeu0k
	wixrR1/NVP5xIpQgsPiMaUNO0nl3YRGuHUTMh1e921Ve+EeNAQXx7wW/OQKROWp6BNUgMwdyR2D
	iXzTFXfxQ==
X-Received: by 2002:a05:6000:41c9:b0:47f:86af:8fdd with SMTP id ffacd0b85a97d-47fd2abad19mr3920947f8f.3.1785497815591;
        Fri, 31 Jul 2026 04:36:55 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:36:53 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v6 03/14] mfd: lm3533: Remove extern from shared functions in the header
Date: Fri, 31 Jul 2026 14:36:21 +0300
Message-ID: <20260731113632.158440-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using 'extern' is not required, drop them.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 include/linux/mfd/lm3533.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index 3463b164d0c17..c4c38876c09bb 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -82,13 +82,13 @@ struct lm3533_platform_data {
 	int num_leds;
 };
 
-extern int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
-extern int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
-
-extern int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u32 val);
-extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
-extern int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u32 imax);
-extern int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u32 val);
-extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
+int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
+int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
+
+int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u32 val);
+int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
+int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u32 imax);
+int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u32 val);
+int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
 
 #endif	/* __LINUX_MFD_LM3533_H */
-- 
2.53.0

