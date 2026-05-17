Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F333CEB0
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779037288; cv=none; b=EDtZLjB8nhwpjqPIsyqEtxhDlxlxItuqy1to5FQUGVrbbMne6kICTXE2vdfh6YQyo1gXDZpNsZdSi5DgL+XcBpjbS8hCxP4z6u9O6+asQMg77SCZ4IOZ1OjPq4HZWQru8YM8RNWbEVWC+QL3WJPAJFc5M3dLcf03OQylIvJxC5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779037288; c=relaxed/simple;
	bh=BpW60eJv0fL6GdVE3Gar7ckj0g6dXq6LA91Qn92V3WU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMTbBGkZJz8hUa8oW+/QMJQ1dVaygrECrbYD9p7Cw0McN6X/yz4RM1IF7nwm3QRxrs2/h/SAPFTzJ+36kHRsVZtIL54wntP64x+bKRYJMEbAcCcN+OtHf6v5p/1RhzXHDH50Wt3EPCaeS7jnVVJJdD/FcaHMBy5W4sSmScmLe+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=cX2HbsGi; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="cX2HbsGi"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dca4debedaso1695077a34.2
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779037284; x=1779642084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r79DP20S4eJlOwLlgpzbF12xTrAdDeOW63vUv/XJhlo=;
        b=cX2HbsGiYVlNNAL4BMSqI1ssdFJ5xF6vrM1dA9O9VEAzuGiEM/OABe/Yb8U9pli5zs
         9M6NhVeUctNOsb3Jz5F1lejxgGTEmOTK3NZMFpaXQJk7dSDNV4XrgZEGqP6iOyee3QSK
         usC2InVh41/Clm0MgdkzZPIosnC1i3a2cJqqFQLeju449rLH1zVKcA4rfC4InBwIhOrR
         AB2rYoUPYPo1oUSnMVpmrZAWtbPVhrbkW6GHk8lMIMDXT69qakyMGu+J0hoyzR4bH5mR
         5Q712jWvIXEWbsmDemoTB3LQSFY6wGs+bLZATXr/dLFeSrqALXFXYNFo4AKzlFf/y2TZ
         Ayjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779037284; x=1779642084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r79DP20S4eJlOwLlgpzbF12xTrAdDeOW63vUv/XJhlo=;
        b=rGjLiOazRwhklDpc0aKOBInBbuVVt9cB26IjGnrWUK+p+ODbJS34/bQzzwrxlMFDtU
         m1JHtoPWNaCh3/Cy4tFb2GNiVOopBLpWlES29pFwELdoVzM9Mt7ru1A28YBTzVEF4pyE
         LX2TPSaxk6esoiDWKSBtg/An9L5bvjY2PhdAtx5o7yeAq4/W7gQMe+eRT+RGc4r/6oJs
         cZQW1g13Dlc+ONZldk+0Y9cw8EtNjKswzv1mMHDsKrIOFDacZ+M3Oi+jYaffFkEh/mpN
         Bin7QeKIzojT1puRlCrJWeslTvZvBnrGMS+9MkgULiy6/3z2qm32UEmCpA3uaFnySDKB
         +9eQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rKfaRiJeCmmpckhfZeQID3U5jGyanpQ23QKnjYYiKOPw+L4sBTQtMtJOE0Z8wanmnynXj1BOYxrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Go8Wq3hft0ijQgSpvfxJYHcgCOdyZupzpE8UvBqOTSJbCMy6
	S8y4ULhU1KdWlZLURx2VFv7QM/iqzcrtUcru8rLXWluxS4n142dZHu4Pf0ZV89vHR+O7LG/XRET
	OpVljB7o=
X-Gm-Gg: Acq92OHtW894FEU+t3hy+0IQYqOnhNzAtBLfCNUZ/AJ+i8AgtjLbxkNtY5kBZw0qn48
	NZgdCGg/RsMb7836+NMkTzKCp42EPamP6U8MFH2SofDIbWKbENuAdnLerTF990RpX7+08HnKrg2
	wWer6q9ZZJT3peXPDS4F+xpKVzg4Mcfz6kLuK6llk6h4Q8aiF/nSMclkDu1RXPiPEQ2bfEeZwM1
	7cfbc0/beO0Jprm4OlELSCemhCUamcnv5LT3G4ECbdSXGuqitCi7pp/ZUd/DCn0kcWhF6FeAyNA
	ROQ5g+0Jd5nMIQXAYIclAKRYmkNzPESsCTSRs4QX8FMKzQ4QHDCpFdClG9Ou59irdva4IeFKbZk
	JK6eFIv0hX2Nmzi5UWPKGuJnJIzzro3OPxpdDfz3lSW7gLZ8iiUji8PdljphWvnqtZumXBSeApC
	qFlFhnAjXeMnK8t4E/Hn9BxTKxzOZm09yMrtJ6nA==
X-Received: by 2002:a05:6830:3903:b0:7e3:a897:5160 with SMTP id 46e09a7af769-7e4f2b78c7emr8070817a34.13.1779037283702;
        Sun, 17 May 2026 10:01:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b7c68d6sm5890859a34.3.2026.05.17.10.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:01:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 May 2026 12:00:59 -0500
Subject: [PATCH 2/2] docs: iio: triggered-buffers: use new helpers in
 example
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-iio-doc-triggered-buffer-update-helpers-v1-2-7f00d4188f6f@baylibre.com>
References: <20260517-iio-doc-triggered-buffer-update-helpers-v1-0-7f00d4188f6f@baylibre.com>
In-Reply-To: <20260517-iio-doc-triggered-buffer-update-helpers-v1-0-7f00d4188f6f@baylibre.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=BpW60eJv0fL6GdVE3Gar7ckj0g6dXq6LA91Qn92V3WU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqCfRa1i3PbWnYF1YyiOQe30PaIIx5EZ28Pmkhg
 JYSeNetQOeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagn0WgAKCRDCzCAB/wGP
 wA7rB/9HxCCaPKq0t/bCBX2T6rcqzWzCOy50/eZS/lA9ysfZoFtg/IIuIY2ci6rTiHkh0x9GnK5
 kbLBk+nGohywghzEa2wK9bDMzSNWgznvjsEr8Zra7ZE4JEKZUvdJDtHtLr2eBLuGQzWBDf68SCc
 Sxk1PBADS9ejp1rQuW05ZRkCP1EHrtMkMzejiNsliNnS1tXDBt7l5mBJD2co9bk+GcY+ZzoAPJ6
 pAOjcAJ0HkEpWbH/i69ajx3b2lV11VseneIQO9Ds6o73x8MlBdCLw8zNJCgvg/hyN16ZbGEZhWF
 zB1vpMhoo+8hkKDlRPBvYKKQER8rGG0Nq1NfW0NXpX6KrMVU
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Update the "typical" triggered buffer example to use various new helpers
that have been added in the last year or so. This reflects current
expectations of how similar code should be written.

Also zero-initialize the buffer so we don't leak stack data. And fix a
missing semicolon while we're at it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/driver-api/iio/triggered-buffers.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/iio/triggered-buffers.rst b/Documentation/driver-api/iio/triggered-buffers.rst
index 23b82357eba6..23762b06fdc6 100644
--- a/Documentation/driver-api/iio/triggered-buffers.rst
+++ b/Documentation/driver-api/iio/triggered-buffers.rst
@@ -29,14 +29,14 @@ A typical triggered buffer setup looks like this::
 
     irqreturn_t sensor_trigger_handler(int irq, void *p)
     {
-        u16 buf[8];
+        IIO_DECLARE_BUFFER_WITH_TS(u16, buf, 3) = { };
         int i = 0;
 
         /* read data for each active channel */
-        for_each_set_bit(bit, active_scan_mask, masklength)
-            buf[i++] = sensor_get_data(bit)
+        iio_for_each_active_channel(indio_dev, bit)
+            buf[i++] = sensor_get_data(bit);
 
-        iio_push_to_buffers_with_timestamp(indio_dev, buf, timestamp);
+        iio_push_to_buffers_with_ts(indio_dev, buf, sizeof(buf), timestamp);
 
         iio_trigger_notify_done(trigger);
         return IRQ_HANDLED;

-- 
2.43.0

