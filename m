Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456071;
	b=AonVxsXba8MInuKDXfkUb6fgZH2G3p+lppkHO+rxkZsbU5WqwueeCCcyOW/VbA59bVYW
	 OsH64i7vaRRMofIyW7WesdJ9A+bUGvO9zQ4Rv/uWq9BGLiMihpkz96bCnMIILfGNnTcrB
	 MFplJaxkLZsfKYC2qXWcFuM0bmOYvGjxcAR6+LO0SuTHV/4YHzpnxwWmHK6KSYEzgsSVP
	 ZM4W3W9b8xXuZRq68yIGfYSOS1jUNF7EKqDnHPV+lpCbz/Y1YjXgdiQNM9Anplty7+lS/
	 M5JxIZvDWHeFlX3PEBJhhwKgQe/reQKpQosYij3rNNBAwQh8BKWI45g5V+huIx0ys0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=EyFKKviFKEdPA1/mTIAZMpdo9jg03KTsm1zg5y/5lIo=;
	b=Ki1KC+Rc83o6T/hrL/KP42HFQkQwMKGyYy3K8sUPVz6k1Wv/qwh1yGT+xl2CaVDzyHQR
	 KvH7PBR8PqhN9w6M/4ZbJFvIfPf6JZHobO+PmwEPgBGXVJ8/M7mcz8Rlxo6mHgsWfm3eZ
	 ZWMLRzTDcPupJrCD3oY68LDaKnq2dK/ycoDsheApiTC7UMQcN6WD9dMR8YOoeGJORCMHc
	 3AufgizAOcy8svUIxhaiyTXD6pRY0zPt61pcC53YxuvE2QmW4txMs183bRsnXvKo/21a1
	 Chdl4C5ED4iagjSMnepse1KU/jnt1wRfbbyF7aLi0JUkAFFoxIfCNNDukbNzY9aGRbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="k/THwyR0";
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A942606A33E
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 17:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A942606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=k/THwyR0
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-497614c95f0so1984569f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 09:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795456070; x=1796060870; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EyFKKviFKEdPA1/mTIAZMpdo9jg03KTsm1zg5y/5lIo=;
        b=k/THwyR0d/kYN8jVRNojARRFxxxiAO0kuqrAtLFFTSpwtPjuxlq/wBQyJQa31ZNuLT
         H6E69lTaU/KOobsWmEdX7ZgUyo+oCDtHwBBcSk0wwThIN1JbRTc9F2LuNBFTst+Fvh5T
         uK4lCNe1leRBVxygJGRawJOHy76JfYj+mXsbmy7lH+tszWJBwKxaTtYPxtHqYSc7mz7Y
         her70CVbo6pYPt9s8sB5UIJPE2UJ6sXRO1W6oDfwnF28e4PAHBlYI+0jPNfCmXhbj95o
         4TXIjElcCAOMoFZBRJeGqdKyWR9NYGgO/7DNxmyaLmOHp9CPrbgzoW4ptKTl47qz4dnu
         +q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456070; x=1796060870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EyFKKviFKEdPA1/mTIAZMpdo9jg03KTsm1zg5y/5lIo=;
        b=RMDySzkktMLMSFCK/aTQZui2T0B1TDtlfSJRxHmiDSoeQY+Ka3l53EuAHHYkEfhzCL
         DOlaO7ybiQnw+nS0flHg0U07DN795yHg6fIZHT5u8LlBLWAwXM4+37lnR0xAUpOeqSyV
         w15B55pCg4n0OjNg3+rqfZT7Sq9x4TUAXPjPdz7WACCNkA9qVpX4CFcK9Kv1KJSOiW1i
         ndhUaC5NOq3cSTWDSlfmdNMBaPrgB3IyPohCYDsCQQ+GqfNKlH4fDaCjCW31Eoe/new0
         XfqJlDTvYDDOxI4eJUqJxJ5OSvqMGroiSnSaUDeODJOKtCnhoBIu9IyD1OBLtGgePxar
         RFww==
X-Gm-Message-State: APuU4Z/9x5jeDsLAiM8uGDt2TRGaHUjIEK+CLniikK5HicndKgMpN9V4
	bsuOZTZH9QYf/ouqgbLv7bIfftwqqgWg9BFkRBew4RxtOSbw/Q20+/eoT7P9eHlGIgk=
X-Gm-Gg: AZFdTZdPfzuZ/vcRMFc7kLkt4CJINee6xoC2u02F4W3KmIZ3JJqDUIF1Flk1M5x8qw3
	RD9QeIJleeqzJ/PwS7iH7b9Y9NJGaj7ozuajOKxmQGLMr71YZLXbH7eTzMu85JbZEJVKmZ0LjXv
	Q9Uz3xMGkNNwLPt+jiB2m++KMm+HcgNUoh6R9N8/05+njjKJDlCtqBDiWYgpQY9nrHqjnC9RWum
	bPc55Ah4cj/PKQ4E1ZLWC0GSffvIRSn3vn450iNsKkPvyj6iE0rFDcnzlqjNnHw5bqRX3rflK86
	bVf2xWlfT+uesd7vfU6CtluSXSfpdEVLsTyZdvzD4hGDCLwSZNP8gjH35shktTi7LSpyzHbVimz
	1uPwx9F2Bjl9JOeoezqiJXYAbZ2llkF9Ld3uEYaCUCrl9gOM1ybESWLMOSpFoj99xD8hK+Jbzyp
	Fqm9BpFa3ZJRx1Ae86L7pshI8eHC+nSBY0a1UnvcAnigIW7DImHKZkPyoQKh5IE+OKyHCjPnhxR
	JWgECJ2zW6HRbJo5f9HG1kaH062GbTLYmP0YNvOoygeOr/Hso8InGMy17PjkO1tLGYr6+PuQFgB
	hQdp4jkP+pu5c8UG0NU2cjhKe8Dg11QzQqCHDblZ19Tl5jiKkE8=
X-Received: by 2002:a05:6000:3107:b0:4aa:1ae2:ff2a with SMTP id ffacd0b85a97d-4abaa977260mr29586809f8f.2.1795456069512;
        Mon, 23 Nov 2026 09:47:49 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm22961413f8f.47.2026.11.23.09.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:47:49 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 23 Nov 2026 18:47:45 +0100
Subject: [PATCH v7 2/3] unaligned: introduce be56 unaligned accessors
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-topic-sm8x50-iio-max34417-adc-v7-2-d8f87edc5086@linaro.org>
References: <20261123-topic-sm8x50-iio-max34417-adc-v7-0-d8f87edc5086@linaro.org>
In-Reply-To: <20261123-topic-sm8x50-iio-max34417-adc-v7-0-d8f87edc5086@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux@analog.com, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=VWjXeVXU6bySoahX+1zByOy26x+PcpghUtYIOiReO0U=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBrBHxCKVwROIzlOFhKTAItsb1EQoCQGdgdGttWwo7O
 zvU7RAyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCawR8QgAKCRB33NvayMhJ0TgBD/
 9KycuSjLlv5KmEbce9bO/wNf3KxVrhyzQMrEvhwhrAeChz7eZIdwsSnM4NB5Yj/fz9rzLKHrvVv7iw
 vEgi9gfVPy1CYJu4BLo8jOXJydH25WI043z2LmHlNEnVIUMVQ/lHHcX/3Vbd5lOMZZ80l9w+tJLCs6
 ofmMsIZFDjuvnQo//6TpUvIM6whhxfeJ+ZAUJOj/7cmLog/3yArX6nVrLpB9xvfS2WalcYRGKTQYap
 MvyLZRRaEtLulm41Eu0hmnnpodRhNVbnqj+w9FX+zamfmm3BdRwmJKmA+P6PfqBq/3LN1ACMXYKrqE
 ec7C7KNgcAaUqI1Lgm16fRfWMkk71iZrxa+IHTDA/k48EPZnhRDaMwk/G94lZPdoXiI/VrkgRsHNpl
 4EKIRgLE8KrQqTdQs4I+Rhmoscc2Szqa0yKXmhwfcoDlMK0KPjIdZUyOeWMKh0CHkgD3zvuH0y1Qjb
 zkLpStVbaGi/pO7bsn2ho85Zh4SZjNAKcpcwMfoj/H144pYK894GerchgtM94ofUQv16c+CoRymS8A
 rxZPpKSpnoqjTqZJ6Vn9ykZ3TlQoj18AUf2B3YH/zSxKc83R1cXlA3BcyxOKYXz8e+x+mNhHWolvyw
 EG3/GU94NxwO4M+vYDwoew10lthgjICcFnCrnlqlOQ0RjyVmnjpR+/ULT4+g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

From: Marius Cristea <marius.cristea@microchip.com>

The MAX34417, IIO driver, is using some unaligned 56-bit registers.
Provide some helper accessors in preparation for the new driver.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
[narmstrong: update commit message and move to include/linux/unaligned.h]
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/linux/unaligned.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/unaligned.h b/include/linux/unaligned.h
index 18c4b0c00e2a..d7937088b2af 100644
--- a/include/linux/unaligned.h
+++ b/include/linux/unaligned.h
@@ -142,4 +142,31 @@ static inline u64 get_unaligned_be48(const void *p)
 	return __get_unaligned_be48(p);
 }
 
+static inline void __put_unaligned_be56(const u64 val, u8 *p)
+{
+	*p++ = (val >> 48) & 0xff;
+	*p++ = (val >> 40) & 0xff;
+	*p++ = (val >> 32) & 0xff;
+	*p++ = (val >> 24) & 0xff;
+	*p++ = (val >> 16) & 0xff;
+	*p++ = (val >> 8) & 0xff;
+	*p++ = val & 0xff;
+}
+
+static inline void put_unaligned_be56(const u64 val, void *p)
+{
+	__put_unaligned_be56(val, p);
+}
+
+static inline u64 __get_unaligned_be56(const u8 *p)
+{
+	return (u64)p[0] << 48 | (u64)p[1] << 40 | (u64)p[2] << 32 |
+		(u64)p[3] << 24 | p[4] << 16 | p[5] << 8 | p[6];
+}
+
+static inline u64 get_unaligned_be56(const void *p)
+{
+	return __get_unaligned_be56(p);
+}
+
 #endif /* __LINUX_UNALIGNED_H */

-- 
2.34.1

