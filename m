Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384653E5A2E
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663687; cv=none; b=un4I/jQoz3C2SK0gpwq13F2oJGE1FJPksVZJ0D4RA6OhjX2eWygJKgH8lCcybZuqHHvFsY1T1ObV0pcVF/XvYEyq04Z2s3wfeHJ0p6E/3VIpffu7Y0M+u391fnf0AQJyDwsQSBmTzwE9a28agf7jjq4Fmt8BAb/B+c7+7CWyidQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663687; c=relaxed/simple;
	bh=0FPRuvNNSFiFkawKVCalHb3yLDUTC8vh4qdYQm7Z9t4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2R5dUDkCYjS3XSZ0q8BJOin9tU+ea1/H6nUUcxGT4n5VD9l9atoRp8tRCjjg1HuFED5gBBmYGYKudJi+WMGKuFFtvmqvpwUQDzEhyRS7fYmHHpyqqEtwBAXpVW/ls6eBDp/mA2jD1twJrU+a7ZG92WN8+Ly9l8WHgRC7v97sjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=e3bhR8mK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="e3bhR8mK"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44c350a5b87so4070694f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778663685; x=1779268485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00ruy8kpQH+b21j+wCBZYocT5CVhNgJL2HRPgVpHHfE=;
        b=e3bhR8mKfCZDM+wTcQ4G6y6C2t4o2Qu62kPLQR1w/I/JsdvIgxiukIrjUPsEBVgGGw
         MeVtgEsyniBM+zir6OpU7HFtXF9v1m8CoGs3MxpYyHzPOn/IsWSRaX1/gcKRG8ngsVQk
         bCdys2lSwlUPS55goJ8UEOVgZx71Lku6Bk78EGJLJYAClRqwG3Qsml7UD1h1r3vlr93J
         Ae1OgN6dpJ57fAt4ukoBNWxuK9KrZtDXvM0pWq2vN/6HCDXXLvxGfbTSIEwqiwiUc4aa
         XJltCDZaGNgBL09IpQYxJ8idE5vopEepNe8jDV4enNLdDeQvgxKlJ9OII0ninM0c2bgy
         pU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663685; x=1779268485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00ruy8kpQH+b21j+wCBZYocT5CVhNgJL2HRPgVpHHfE=;
        b=MG6EWqPY9y+3lWgwe1V4sNDL3XbleegmlogfyyKqtn6fxKwcQXM5Dq1zr2OHCD+KgK
         fLvDXziJzZbRg/ruZZWjBRAbWvNx0WoyBC9VLuMx0ijTavOzaC6Q0TpkwVxrfvlmiujw
         g/YB8jGR2ELnuAKdJm7pUXl0jcHfqS32F4LhQLHzsFWwPzJgQbfQ/c1PWdU4jOW3jVoW
         JD4N69wZWkiBO/A1zU1vB5BYaLYWtG9tvmIVUQk39FJabWDNrigrktXD6XdciLGRT6UO
         EcgqDRZkWzG8NWhI08myadiCIcwczHz9KgyqtDPc/sAyx9fINEdFxf+/Kc5QmmAv2hKp
         c5pQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gVJg8htsX+yZq3nZL5SZZVdRkvzQvBo5+S+RahgDxM9wVQAB6A36oav4UKxyULNmz8F9rQ3NoSLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNpd9FPqvdTpUlJ502TRCvbYM1EJn9aU+DnJtEzqcq6kc1u4GT
	IvbR147V2d78VNZ6pfkX/g19Y9egJG38AHv8jqn4nVZWFKKFDiTEhVf3cK1SxPso+KM=
X-Gm-Gg: Acq92OFsnysfA5jc8Mvei5w23W3ExEEZ7lQCfpUa6BcxqRvAWwm86YFzrvbDhAF0Rya
	dEvylnFwib96TlgYgbNNlMQg7cxuffrVBD1kqcCi5tdkqpymRr8xVRX+I3EkSVPQe8HePTXMZZ9
	rBdylv08Z327mgdpSf3edNgh0YuXwF+HCVIJ+tqKgFX5BOrD9bjO7olLk4jD8Z+3aIPhx0WfVzB
	Sjrb6zY0Mw1jbDLjWsNnq6Vwfu5OXc7mB+WMzHEakHJRQM+K/JjE3QxOw8DnkAC7/NXzpDRblty
	pL7SR62P2VV4zXp7z7nE6sJIsSzgiD+FkXv3Um//QkHuhRI9vcJpcCi8VjUaTQnJpqDBqNT2yZy
	HqwRzKKYGNtq/6NzB0U6QOMjoNyrHBw9nhCTagxHYLx1r1r/3dOs96XEdhB4FFEpD/jH5QK4O4+
	6C+WrZrfxKLM6TusgxvaFW/K1SYhTI4a8=
X-Received: by 2002:a05:6000:605:b0:45c:3f0b:be08 with SMTP id ffacd0b85a97d-45c599ebe6fmr3537011f8f.23.1778663684744;
        Wed, 13 May 2026 02:14:44 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm34590821f8f.4.2026.05.13.02.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:14:44 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 13 May 2026 11:14:28 +0200
Subject: [PATCH v2 04/11] m68k: defconfig: update stmark2 defconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-wip-stmark2-dac-v2-4-fcdae50cf51a@baylibre.com>
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
In-Reply-To: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
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

