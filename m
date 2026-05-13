Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B24D3E63BE
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663689; cv=none; b=DtZXFUIf8NBTTncPeoRdCslENsiW56c38LW/V5EziAn1TfLUem8jXLKAYhz5gokAv21/Y2/d/rJP3KlKoHDhurkoH6uPf42YvUcJgp+PyNbro+ZdcGueQsvMXtb9MV9pqvgEiI+eUQcyKLrUwMA3Hhm9BXD0LhlAfydY4vy0yDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663689; c=relaxed/simple;
	bh=BTzMq5e9Ct1iS05RorpLyh1aN78tCIlpP86CvhH3+is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dmwj8yJ+GwU3Cudhf4qO9+p94j2PgOahex8gzrxFeJVnON/cIjHFg+mkphf3LuYZZfRMFUKhnu3W112zQAcevPUgc67kARuK6UHB1jA6nz4Oe99bkwO5fs0oPzrgRPiyMQGeKTrIS+PUC3HO++kLPqKkkgSxWKGDfAqmd4DXxLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=vVFqomTK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="vVFqomTK"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44e1860558fso4190711f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778663686; x=1779268486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66sbIWl/UECZcngzqfN9gySpU5b7WSWy5FgqX8acPdE=;
        b=vVFqomTKL9FyaG37P9iuvc5cfQPTVDsDiv07kwbCLR0uRbJAMOdwTtiomddv9/dPOe
         mZ20uBXQ98GmORUduHAZ72l1Cyxu8dpfdHHFQKbvMTdVy/7CbczK7m7IWu0W3ziqntoo
         FpmC+hdmM28UiWLXCCwmoYjFZJLIZ3Kx19xoUokn1nGitNcA8f4V29HreCnMB1f6m+sM
         vyahOtmAMBX7z5fgJ+aImENC23ebqC8GrmOv0SPGvJZ5qy/yXAr/m8jnQkpxac6f/zN4
         +wg5EtxfAUrOktHj95Wnd9oLSz0sUBJIu6opQ+8xuhHFpH0Rx/eQIZcUTR+SZ4osbmWO
         Nc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663686; x=1779268486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66sbIWl/UECZcngzqfN9gySpU5b7WSWy5FgqX8acPdE=;
        b=eoNXz9RaSKPMNsS68OX2NlHuyVPFNsBXJHlktWtBGRtPZ1cW48V7CrA6IEhEtrMRmn
         m6jheB9AClaHSsaTSa7BDUzFgWFG2k9uQJqYBTMXzcN2dPWdlW8hlv73kbKkGYyRru51
         AwvXvEfhqHiIWBeKOu1xF22Utu8r6/GOPzQSj5fGEnbEOM4v+yaKwgLgczmEUBsoyeSY
         0MeV/rI5xXY+lrVGgu/Kj5p8BtddDyvNE/bzz9t9egFNwitN1N3Dn6jYX222pTUASLuz
         Stg38dJCKBj/wUyLNOKx6L3fjf+XXiHoiuJ0UOGE4u4DpuyYGTrHTz2FzAKnaMSJWG/s
         2nWg==
X-Forwarded-Encrypted: i=1; AFNElJ+oTX63Li28cPuaJrCvgxa/yCGXuaGF80bTXgqNua5USxc9hg+sqgm1XjfKxWtWHUvFuid0wlbzQDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzw8fbzlt6iuGrLzTiMWhnGzLn7GA1L264GRhcEUVxlR9z6uhf
	cdUCKE2QFjPXZqI8KOpWz5ppFaASSlDgoEfmtyxQqRf+d/sZSlbHEu9BTWHMW4oumVk=
X-Gm-Gg: Acq92OE/EyHwv4a0oaZyfkOQDkOQ76+0zDzeAFWQPLqz2Mi2sUFpwdOk6c6vyDPgVBI
	tkLTRwjPdOcwdhu88cEg5kLHESva3ej10ys8FaPLnM6as265qCCuP4gFFL6U4gRPtkxzaEj7gzM
	UisJkPpTkLz9fc7V/bBcRyiFoYhuBu7LofESnwCPebDqA+aJ2Glao8z7pycPjLNBIDkW6rU0Iag
	ssiAlolJ4mSNYN+6NGN6rybyBs8/krCdX9C8xPp1TQWPTaiKkvTYj0fMu7W13kKZcz9ESERT80X
	V+tsLNcLfnyrRApZIHMoBwxM74E/a8BZLdhdOw/AC3GPztq4MkhIWa/bOE4IDLWg1UyxjP0Quui
	ilJUjE4hMJskJO7rgGG9aKARzEOs7ITS0F+SWVBaItYz76L/rMKy+SCkMRJAShpcjhMCVHs97Qd
	NfCpIypCUEmf2YPBinlr6heG/Cg5THz6U=
X-Received: by 2002:a05:6000:26c2:b0:43c:fdd:ea96 with SMTP id ffacd0b85a97d-45c59cd1579mr3756642f8f.26.1778663685719;
        Wed, 13 May 2026 02:14:45 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm34590821f8f.4.2026.05.13.02.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:14:45 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 13 May 2026 11:14:29 +0200
Subject: [PATCH v2 05/11] m68k: add DAC modules base addresses
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-wip-stmark2-dac-v2-5-fcdae50cf51a@baylibre.com>
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

Add DAC controller 0 and 1 base addresses.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 arch/m68k/include/asm/m5441xsim.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
index f48cf63bd782..f5acc962bb95 100644
--- a/arch/m68k/include/asm/m5441xsim.h
+++ b/arch/m68k/include/asm/m5441xsim.h
@@ -191,6 +191,11 @@
 #define MCFEPORT_EPPAR		0xfc090000
 #define MCFEPORT_EPIER		0xfc090003
 #define MCFEPORT_EPFR		0xfc090006
+/*
+ * DAC Modules.
+ */
+#define MCFDAC_BASE0		0xfc098000
+#define MCFDAC_BASE1		0xfc09c000
 /*
  *  RTC Module.
  */

-- 
2.54.0

