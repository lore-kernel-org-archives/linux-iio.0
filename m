Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33C7389111
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484883; cv=none; b=Ma65T4G8cLyzPSE4ixgb9jD8C3YHd7doAkWe3H50RDhotc2JkkqHxOtW6po1Oqhq6O+esblMCRNgvJHonquYpNFQnZTb6p/pVnuzL6tXrCMcUH+epo3Qe4rpX0x1DbDsySovan272Ox3LUI3DWQJV7M3GOYg3PmkS6EHx66KDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484883; c=relaxed/simple;
	bh=0FPRuvNNSFiFkawKVCalHb3yLDUTC8vh4qdYQm7Z9t4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nfu9oeIrX1b4bRrIDDep5mEaJ6M69j5P1NMgbz+zAEP+2nb4xu3DKx3tPqYzQNSrkfN8B44GkJRGz2YuvFJeLD0Nafb7FQG47AcufvykY1YWd3LehGX+ULn6GyzwohmXXIsMQgZX0bnb5WgHa2IUcLfjZMBFXBmkC+QohiC/mf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZJOfEs9x; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZJOfEs9x"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so43262165e9.1
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779484880; x=1780089680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00ruy8kpQH+b21j+wCBZYocT5CVhNgJL2HRPgVpHHfE=;
        b=ZJOfEs9xNfTkiJB4uElnB0VGge9OXiCuEreU/Fv4Kf4JdBPJvv0x1tVtehE+ALXpcC
         ZJ5RGdiR+NA43TDtSjz63gGWlGJDro6dxFv/6JkcCJeXg1yUBPLM99iNBPYGkdsMCz27
         34UeatWwTnHBjzQVXp8eQqrjGkag7N5+qA09TljkMMwX8O5hHc8ze4vqRytjEXuAvbdT
         aoKw3maKiKhNmNQHRh6gjzyBkZHVKeRXWd8itE+j2ZaMRafMcbx6O2wcRIv7xcyhCwr3
         Z/bSfAtHBjBp2OALYFOV3cj7bDR63CGOlgjhyc5LIiTewTaQbnqyGfd2m9S+rv2Rw0ok
         mjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779484880; x=1780089680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00ruy8kpQH+b21j+wCBZYocT5CVhNgJL2HRPgVpHHfE=;
        b=mi0s2iKLrPZgnaVOcyZUbmw3Br23esPsxfq5JOewAQc7L3NVcjqqGR9xCAPmxBPs2t
         sNXFGOP44G1KKnQBnvAvPmR60hH0+Gdx4GpvJTvfXRE5Onlyzr38TZaiEy2RMjKwcg//
         IB4dVlDpEemVcGmdGcJ6P+MwkppNu8JeRkgICVbUQeXaw1Pemzp+numHQ9Wx+VJgh66g
         /cEjXcZ+Qfn92EWeDWfWRSwJIYxdZwL91cLomU/hnl5wLDd7vEyjBP7a8dIQc9p3Vwyd
         nyHn5VcmuM3eAvDVFqu1bdYtdSN/oDbb7Eq6GvCqk3rB3NYB2xZhBfduMFzmDJ2pbhIi
         hpVg==
X-Forwarded-Encrypted: i=1; AFNElJ8T81UvrwjowV0tT/kI/IRDsAKbxNWgOhTSIcW8DpOdYoy8AB8uDbwx+qeaFkP/bTu77pS5DXB11dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzLHRTTG7p03jRSW1JV92X52Mtr6y4NPkd1EYwmjjxIWwj2s8
	vz93G5ly9J9y3gqMFBExwpxV9PqZN9RC/kF1mC1DOeAN+XSf39ftm8EeugEWtZds7L0=
X-Gm-Gg: Acq92OG7udOOVGJUG5yvACbdUT0vQOmMiYDj2noGgku8RduEY0Qo3GgZ3VTjLs/rp+8
	lKNXeCrf4mI3Md27BnmqJ0+neJZq7VxA1vkUdG3Wz7X7MX6NbYuxq+R7/RRZ8zbMsBEChpIWzOV
	Xe6C3p1QxxB53D4fh/Hexplt2Hq4UfQBVRW9D/P7rrrt5bgLUYuUoDnj7Qdm9DfDBCYhzm8dsi8
	TC7RQ/cQANyCzbFLfaImzRuhPSypg8cW56ukOLCf2m4CzARAZadYV6+pQX4apNu9BWmrDt0UC5b
	g3j++60QfrCcbGTEG+FxrW2Zme3mJA0pXuGxZRalNGPr4uL7i7NeBgAbsAimcufLM1fx4VH+vHR
	suzHnmjnOOb+XmkmRRI25AVrQQnoCfitP8OeoMn4/qTC80wDS31GFvvpHywCh4zn8rv0ZwIYL+E
	VS1nRORKBr+WSRtsJzd8upl+YwGUmkz08=
X-Received: by 2002:a05:600c:a402:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-490426b0c92mr54271465e9.16.1779484880243;
        Fri, 22 May 2026 14:21:20 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm73312225e9.9.2026.05.22.14.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:21:19 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 22 May 2026 23:20:32 +0200
Subject: [PATCH v3 04/11] m68k: defconfig: update stmark2 defconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-wip-stmark2-dac-v3-4-16be0ad35a67@baylibre.com>
References: <20260522-wip-stmark2-dac-v3-0-16be0ad35a67@baylibre.com>
In-Reply-To: <20260522-wip-stmark2-dac-v3-0-16be0ad35a67@baylibre.com>
To: Greg Ungerer <gerg@linux-m68k.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, 
 Arnd Bergmann <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.15.2

From: Angelo Dureghello <adureghello@baylibre.com>

Update stmark2 defconfig enabling MCF5441X DACs.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 arch/m68k/configs/stmark2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/configs/stmark2_defconfig b/arch/m68k/configs/stmark2_defconfig
index b3fb95f73a95..3941113bc60b 100644
--- a/arch/m68k/configs/stmark2_defconfig
+++ b/arch/m68k/configs/stmark2_defconfig
@@ -76,6 +76,8 @@ CONFIG_DMADEVICES=y
 CONFIG_MCF_EDMA=y
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_VHOST_MENU is not set
+CONFIG_IIO=y
+CONFIG_MCF54415_DAC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y

-- 
2.54.0

