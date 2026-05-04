Received: from mail.kernel-space.org (v2202511311555398556.powersrv.de [46.38.245.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5F3E4C79;
	Mon,  4 May 2026 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.245.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915037; cv=none; b=FbHY/1/oRWj8aL/oR9ydOoa/hfQnwh3XREsnpnJ5k1PfQ/v0Kx9JzTIp3GCDIVGawLQmd1DITAspUVrrKEmcCM5F00mdZZch5St8+5fZ8fk/7O3ZUu/uyljxcvJuCcUWNQrA61+ZQKpfvZ967EuoAJ+4/YJfeVqpxokcvZQXV2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915037; c=relaxed/simple;
	bh=BTzMq5e9Ct1iS05RorpLyh1aN78tCIlpP86CvhH3+is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RnZGf6LHqhyzRqWzeE9I6p+PoynoDnR6L6HGLOpov19oNW27MIQ6iIAOS8iSp8qOIQICPTxNZG0VHmdc1nusL8lFpulLfJtBsLZ9PkO+n1RlJvA6TuHDZX2wut1WcxOSHJcuN7Q8zsIdkFWbxfRWRFMAtwiUujfTJ31kr8K/qpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=BF4e+y+F; arc=none smtp.client-ip=46.38.245.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="BF4e+y+F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1777915004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66sbIWl/UECZcngzqfN9gySpU5b7WSWy5FgqX8acPdE=;
	b=BF4e+y+FI93bmhmBDVYOS9Ywi3UsNwZ9B+nk/SFmHSkqT4n/jl++VpZSEEgYjk786kgiWq
	3+YgTbehRHNoNXXR+coeZLVsbMqaPAQgho3Tk1wlwOhIqHTt98tJRn/bWv9jMwYhFqs6/B
	dYJJVVEHO2P347vzmmkLM4ucda/T3u0=
Received: from [192.168.0.2] (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
	by oreshnik (OpenSMTPD) with ESMTPSA id 31d53e53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 May 2026 17:16:44 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
Date: Mon, 04 May 2026 19:16:43 +0200
Subject: [PATCH 05/10] m68k: add DAC modules base addresses
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-wip-stmark2-dac-v1-5-874c36a4910d@baylibre.com>
References: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
In-Reply-To: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
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

