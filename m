Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911382F8EB5
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 05:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364850; cv=none; b=ub2x0ziJcVps2opgDLpe+5m0gATSXzjLYfiyDopsXMEHhBirS5nkNWxJ5f1ZGfzkg/D0Oa/06OzNocCM42nTX7+EBqg6n3gy0+WWoGkILPAdb6F4+wy2xT2xp6vWr+N+Av+4XBTPxJBsgU8v7/N7ID6P+X9NxxuZKurREAxEC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364850; c=relaxed/simple;
	bh=gW0oh4HxQGoi/ZcaN/+jIpeEgWS+PIJPIv7GDt2UP2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T4hDrdF/ni7wwQuVv4d6kDaJ1fy0RFxTj26Cay5l8buUtLA7ItnNBaj1DnjyjvqTPrGMSmAopJi2AYATShemNbTXq1gLUqtkz/e5gS0hrNsYZaLkVxabA05h8KPSj9lFZiUz4L1CpBZ0z7K3x0g2HmUaFmu0kd5S83+Kfw3qbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUT1Iq0M; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUT1Iq0M"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso18050575e9.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 22:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782364847; x=1782969647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqgS0jlCW4TDOS9pY3BMgWLVi8NWOTSUc74AzTrH8ug=;
        b=fUT1Iq0MhaGqJb6WRo/waCQp5pDPe79diM+zBtZBXfDhd/lt3KiJI+A96BQvGN2HTJ
         KvrE5J7N+pw/wuOj1K5rNjuG1ADEKjRqlj2MiDBMDh0XTyLESaZpSkBJbqYlbr2Idid7
         ZYdT0QMY9N9iazSWVX+yOwSjTy9t7UBz560skkLyyG0GD1GlcV64sWdB0EU+3tZGpMVv
         mSRaOncA4eFqgfXlBEmLaNBcy8YqLj0vFKrIUF32S6bLN1vXtGTJdWmOlMYapgTj2dIZ
         0QNtyHRBVE2VeULapo+ftnvw0avLKMckohaZ+FiIlhi15nNO5DPC7g7eeI0XDIlL1Gcy
         3uGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782364847; x=1782969647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xqgS0jlCW4TDOS9pY3BMgWLVi8NWOTSUc74AzTrH8ug=;
        b=VQLb7YokLlXkIpuvosRGFkqffmpanKO+I/OubCY8oYVTZYg7fkAmrAX14BU6fTtnDb
         RCI+keHU92UE1yiuCF5gVytP+5PjKTCZ2IfkpOT5CK7VKnrFB1Ecz/NJE+XOqBNEYY0/
         JhuBTg/HBu6fPbchKy3u+06CeUY6zXVc01HJRUfmw/QjO7E8X39cC7HgmFEksaM5BjM3
         Dry5K7wb/kSMOUuUa6pt2acDtzw/L38h3zRSvNOMABAPdJdda++0WYUNOSvsDKch/rRt
         R3/u2YL6D3MtCwLEggExe0tIjiHEot0zxA1+GQndypnMjxH9EUmGCg81v/LcrJI+Yed3
         dM0A==
X-Gm-Message-State: AOJu0Yzh73h8AxFxmoqD3EVNtnP7abq/+GJNFhQSbGIZOhA64xTo1+rH
	zgfmrb9Fzuuy6u+VE7AaLtlBK+PLsk+GJPpSmyBxQHb0a0cU75PAfcqL
X-Gm-Gg: AfdE7cmUG2PYUeedC11MjNiLqUuE5QIs0CpRUEx/lm5n+s5qSSdQcp5BgjJhrZk6CJf
	+xNJ0iJiw54M4+IwdLrjPB2Wi3xe1juj26GKq8UW4+4rbF2r2C2stXZYQMCSxtgBnCFYDttbJo/
	7sB9pGsV/etkDKkgp/2KVIr1eEA+SrlVuNi+YZiDMQ+cBo6ZMNSUungydUW/9ImUaCWZrGeJVai
	SipYgEdtW4IgGX067OkJWcsgT+aUtjrIoU/ZC1yJbqVQ6h6uawvVd5AbgThHFpehjJiIlM6X/Ip
	o0w4lZYmI/DmjUa/gBps7UbwoQSc3jLY2ScjuuUjJ0j3EM9sh94K967jTpsMx5zpGuZacB4QWJZ
	N3PhPtw9xi+HRe3CmesifNgv356dhdigM3nZqaE8urYI2MVlQyvYNmK6Ys8YIJI31K/5xroRHfU
	MPpxY6vz0urpfjQjf7B0I4sffu4T4w7FZfTImLIlp56kT8hTdzfA4ibEo+pCdrs7S5yBr+Fpk6p
	W1ZQ29rmqT9wvC3MEzxtNmmjb9lEGjqpJWsIV7JNVJ5+lZw12Q7xZHUeVIWfZKCXBmZq+YuVt7y
	YMdsRprKDg==
X-Received: by 2002:a05:600d:8445:10b0:492:649d:9b96 with SMTP id 5b1f17b1804b1-4926683fb58mr7066745e9.9.1782364847067;
        Wed, 24 Jun 2026 22:20:47 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660a32ddsm24966165e9.1.2026.06.24.22.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 22:20:46 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 25 Jun 2026 07:20:44 +0200
Subject: [PATCH 2/3] iio: light: al3010: add missing REGMAP_I2C to Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-fix-al3xxx-kconfig-v1-2-d41cbc0c3cf4@gmail.com>
References: <20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com>
In-Reply-To: <20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782364844; l=700;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=gW0oh4HxQGoi/ZcaN/+jIpeEgWS+PIJPIv7GDt2UP2o=;
 b=wgTM9e3xqcOG+uOxNQQ1Q5FnfNbEOjShkIpLjXZ/KrJ7wAsubaHukuuLJ5124OHgbwnKavLoj
 tnXO+rxNgtLCTIFRdjnx+FXEWp5DK79j/P+MNGy4FA20uobHDGGDmKX
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The KConfig entry for the AL3010 is missing a `SELECT REGMAP_I2C`,
causing build failures.

Fixes: 0e5e21e23dd6 ("iio: light: al3010: Implement regmap support")
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index a33920568904..4ba3151ebea7 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -56,6 +56,7 @@ config AL3000A
 
 config AL3010
 	tristate "AL3010 ambient light sensor"
+	select REGMAP_I2C
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Dyna Image AL3010

-- 
2.54.0

