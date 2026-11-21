Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795271067;
	b=KzJpLX34d2hngBH/ruH14o0MhoSXTsWlkKTuakW8NVOZd/Nuy2p59hiKyiNhPN0kdF6e
	 wLo+qB9doMEjxUk21qv8bHLCj9IizUdYCBt843rQ2KBm0ZNu/0+uB1Mef+y8Y8Ljbl/Gd
	 l4D2krD+RwlAGTmWhGrXQbZio3xpxxstiHaL3Iv12zNQOk1qS4/eTaitY/bdv/r/a6+sV
	 3anfdMP5LA5Xoi/ApiYrl0/NOTVAfq8jA37+Fg7AMcBTDWLBUT5YeqsgDOaymHON+wEB4
	 +p88nM58+Ij/fuyo/1+2Del0BfH9BgcFM77Ez+zeyjmdJUUd9wuEuuazbftI2teCmXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795271067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pbq9ad/wy8JJ/OA5Lm5R7yWbFD2ZmkTstQrt1ypXOLs=;
	b=qQudQTPOFGILzBUTRIoZA+YSZV0RTKoCHCVVjHKudLs1EgpxMxlc044+H2KexBuprtTV
	 LRMuvw2xQqkNyfdhSyKLDfji+6ZqduaIRKoB8gPBHnZhrxJBwwiGKlIlFsrb0nJONGwNw
	 6lRiPpj60H3a25/hcP1zNOulNIJ2OYK+cbV7rpYsVE/EkXaziIehS85WXvWOlylYOtpaP
	 MYRvaZxqG/ild17khTsuvyZ+190wOSVnhrDf7C//GYHOp43h7qrhX9j0/20M4W8tZdG55
	 uGXsBlAgOr9wcOo0IKBLvhoqB8evHjYSPfObI/Dw4XznZlMmzSwqOQDXS+bQ+rgCNaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SucTGv36;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A335606A320
	for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 14:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A335606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SucTGv36
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b43d30822fso674569a91.3
        for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 06:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795271066; x=1795875866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pbq9ad/wy8JJ/OA5Lm5R7yWbFD2ZmkTstQrt1ypXOLs=;
        b=SucTGv36H7i+Df1r8sViXX/sodVDdSjj6qn+EQ2THcSe/Or1R9Pm9Lx/yTDI+PFrmW
         kMO3jbOJImbj7QLhcNHC7q76e795sbNdUG4zEmxRUpJOhPUlxR2Xi7Keq3+OFPm3tRps
         pBeSbXrAqoUtkXKWR9pV8RRpSILxFT0dHoPpk4rTnlfp9KurZHl+dUb1GqJo9IQFuf6a
         792fCrVkBCt3xfJUEdKgFgoNVXH5k6O5+yil0Xzq8Dxhn84lYs8qtN4wYK09MBDKcOvH
         pkzrfiabZPJfTzjk36DycoqLEDpvjqXU6ecBXd+pnBL5YCTfaN+owA8PMiAIEx/vZPCV
         YmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795271066; x=1795875866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pbq9ad/wy8JJ/OA5Lm5R7yWbFD2ZmkTstQrt1ypXOLs=;
        b=vIRBX07SdS1pyp2x+zmQHl5AwIcG8pa76Oe3vICbqmO4ngJOyJYpLqQ4+EqPVu4ElX
         9mgrq3gysKnyi7ij1jnsCNlE+TcoA1CIsMdKJwh3WRyiHXqB0NMc0Hj8Q8Rl5d6vefpg
         gbvrJ3S2pyN0c4rWZ4RY33FVNdigzsyJhedTHYycolQYBRsKv/clJ1mw8JqGSNaIMpAa
         QbQRalGEjGZNYyqjQVwHz1SwMoTQvj6MJqpSDkugdIQv800m2UQlcfnirlO7r2ed8EW7
         OvzyTbXEt7ViJIekKT2TrNgbkxQS1IqkQwfJwAHg9t34r/u/odC0D4p0mny7UsWdHHcq
         4vYA==
X-Gm-Message-State: APuU4Z/K8Yuv0W2z9X/Vfsv/xROZJac/X8jt0yVDXiVco2F4OuTaC1JV
	ARaWBpiRQ2EjbVHvbTqikiXLn2bYYwoTGob8U7VW89MXxY+D2+7iCIXE
X-Gm-Gg: AZFdTZffwINw1apb8ONYk8TYvKtDULEwLkuaM3HJA625XgoD1VqdqH2p6G1VFSZAGSO
	rUvUyZhdblbppGDuXSIhNPVTTSBT8FL1MkqPlhL6I33x3CR7HEawtG5x/cVxmmgEQippg5Cmuw4
	FQLbifGD923GSTGUs0gNfqWWHsKJbYwXy3GayKXw1qBatE4tsbpb+vYHkOom3z+byUKj/Ag8/dQ
	d7vad6c6Td4CgyG+6UZqfFPm+LeyazOMS9h5MNrJerDFX7FL/fFPzSTYKqWwEZTcFs8H1k+gG+T
	Bz/ZqcvjZqYBFXm1OhcJbCnwJuag93UFX5R/6GX74djCb3LIGXPRhfE+YKNdgfmsW6jMtSseW1x
	v/iBA4UIWknuFqDcqHeeo1+QgUaOoGmh0KFHDYLm7+ibnRNSEyW+oCqT9LZLUzemtTc/C1jbAla
	vq+mVpJvJ48sI01pgslqoA8m0a2IDE/yP6Uj9MdWdrcoH3H8CND4lo8HSAU0CVZhkJN5BHY3kFd
	oQ+dPCmLssYb8FdBi13pdtt8xIUHh6u19iDOAS5c5sLo8uzhfDuu7NMDOW6SCeOxDyx7ib9QBDD
	bfHd3WyW9p+SCjgK1ps+PS94G01PJb2b1CnLdFS9HHc7pxT7bIPFTqHp9HxX9fO1/6L/jA==
X-Received: by 2002:a17:90b:55c4:b0:3b0:a970:caad with SMTP id 98e67ed59e1d1-3b41c92ce42mr5730008a91.28.1795271066314;
        Sat, 21 Nov 2026 06:24:26 -0800 (PST)
Received: from APAC-DNT-664.sew.in ([106.219.164.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm8692654a91.4.2026.11.21.06.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 06:24:25 -0800 (PST)
From: Himanshu Bhardwaj <bhardwajhimanshu2515@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	kapoorarnav43@gmail.com,
	Himanshu Bhardwaj <bhardwajhimanshu2515@gmail.com>
Subject: [PATCH v2] tools: iio: Prefer channel-specific scale and offset values
Date: Sat, 21 Nov 2026 19:54:16 +0530
Message-ID: <20261121142417.1538-1-bhardwajhimanshu2515@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.2
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

iioutils_get_param_float() stops at the first directory entry matching
either the channel-specific attribute or its generic counterpart. If
the generic attribute is returned first, a more specific value is ignored.

For example, the MAX31855 driver exposes in_temp_scale as 250 and
in_temp_ambient_scale as 62.5. Reading the ambient scale can therefore
return 250, making the converted ambient temperature four times too
large. The offset lookup uses the same helper.

Continue searching after reading a generic attribute, and stop when the
channel-specific attribute is found. Free the temporary filename before
continuing to avoid leaking it when both attributes are present.

Reproduced with temporary attribute files containing the MAX31855 scale
values and both directory enumeration orders. The fixed helper passes
14 parameter lookup tests, including generic fallback and malformed
values. All three IIO tools build with -Wall -Werror.

Fixes: e58537ccce73 ("staging: iio: update example application.")
Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Himanshu Bhardwaj <bhardwajhimanshu2515@gmail.com>
---
v2:
- Move the tool-assistance note below the --- line (Andy)
- Collect Reviewed-by tags; no code change

Found, implemented and tested with assistance from OpenAI Codex;
independently reviewed and re-tested with Anthropic Claude. No physical
sensor hardware was used.

 tools/iio/iio_utils.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index e274a0d..5df2c76 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -265,7 +265,12 @@ int iioutils_get_param_float(float *output, const char *param_name,
 				ret = errno ? -errno : -ENODATA;
 
 			fclose(sysfsfp);
-			break;
+			/* Prefer the channel-specific value over the generic one. */
+			if (strcmp(builtname, ent->d_name) == 0)
+				break;
+
+			free(filename);
+			filename = NULL;
 		}
 error_free_filename:
 	if (filename)

base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.43.0
