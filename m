Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD89391E49;
	Sun, 24 May 2026 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779618940; cv=none; b=UszUPaIxHa6bq5b0ReqB0qSfELIhGIFzkI9k97lbg1H/s3fyHVz/wQoyhadF2IxrcJzhOAxWPeWq2DwscQkzSGuQrYVyPBfcgzcErnhn46MvX9qCsePWQfD83qjj+rLPScYDYr/FMJ7+PaT8cvptVgjUV1pJrXQ8bDnDlghB7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779618940; c=relaxed/simple;
	bh=0MiPE4pAGNIHkDMT5fwtfqtbshqWVCMkNClPirEcpH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jhht3wja8lQFPSIhSYGLFqatFHyeilXGjRZXQNjZ3KXGyQoRxVFT0VEFPZvHGz0jDK+5GlVk1f5xU1kMs6yuiItFAAgQUxT90X6bTCylv5hvfmCLg5DQYdEN5M/T7BnI258ZUSQX0304pjDmbFkmYNFXBM29d/jK45zwihXb1X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkLJDzTU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkLJDzTU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5550C2BCFD;
	Sun, 24 May 2026 10:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779618939;
	bh=0MiPE4pAGNIHkDMT5fwtfqtbshqWVCMkNClPirEcpH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jkLJDzTUL+gBGYOIaiFjuI0yhqHTKco6TPkNF+rAH6gbzFhR62u/nG/RrcXYIoZaV
	 Yt0vP4m/9IYC/KzTqr/K7H2xSoOEcVuaHXlJzvNjtxq9WpEoTjpT5q2SA9gndpp1Hh
	 sLyJNpSkA+qPMyItHzzDj8pa/x088Aonv23TAO1v7Pm0U3YYzVMaI+Uscr3KquGCX9
	 h85Z5j9PcSmvgSIKjUiScVP5aX6yQHgEljLFUJdZNIkACUtJQ/QFNokTUyQT7pyNJr
	 29qpq5i4a9bVCn/MXtk3dY+xH36StjmkRFb5y9CR7g8tPKIFGr1viPZ1MFAngSHnuZ
	 6fIP+w27cXOBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23FDCD5BCA;
	Sun, 24 May 2026 10:35:39 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 24 May 2026 11:35:22 +0100
Subject: [PATCH v14 05/12] lib: math: div64: add div64_s64_rem()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-adf41513-iio-driver-v14-5-06824d9c15f4@analog.com>
References: <20260524-adf41513-iio-driver-v14-0-06824d9c15f4@analog.com>
In-Reply-To: <20260524-adf41513-iio-driver-v14-0-06824d9c15f4@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779618938; l=2327;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=ROKa5iAD0w5bgrXddKrko8IjoFXS2V0nXvPl5DFoZoI=;
 b=TTPDdayI072fUDtInDbn7l1LhIxuC1ll5ixSwLmS7xwzjbRdggfd09rwzTvGCmHWFZAhNODSl
 lJdQ3/nfsVmBmaDbnWI6dpR1GRTTWVsg7XsduFgysWUD1547NJ+wkio
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add div64_s64_rem() function, with 32-bit implementation that uses
div64_u64_rem() and a branchless approach to resolve the sign of the
remainder and quotient (negation in two's complement).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 include/linux/math64.h | 18 ++++++++++++++++++
 lib/math/div64.c       | 15 +++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index cc305206d89f..99189410d4bb 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -57,6 +57,20 @@ static inline u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
 	return dividend / divisor;
 }
 
+/**
+ * div64_s64_rem - signed 64bit divide with 64bit divisor and remainder
+ * @dividend: signed 64bit dividend
+ * @divisor: signed 64bit divisor
+ * @remainder: pointer to signed 64bit remainder
+ *
+ * Return: sets ``*remainder``, then returns dividend / divisor
+ */
+static inline s64 div64_s64_rem(s64 dividend, s64 divisor, s64 *remainder)
+{
+	*remainder = dividend % divisor;
+	return dividend / divisor;
+}
+
 /**
  * div64_u64 - unsigned 64bit divide with 64bit divisor
  * @dividend: unsigned 64bit dividend
@@ -102,6 +116,10 @@ extern s64 div_s64_rem(s64 dividend, s32 divisor, s32 *remainder);
 extern u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder);
 #endif
 
+#ifndef div64_s64_rem
+extern s64 div64_s64_rem(s64 dividend, s64 divisor, s64 *remainder);
+#endif
+
 #ifndef div64_u64
 extern u64 div64_u64(u64 dividend, u64 divisor);
 #endif
diff --git a/lib/math/div64.c b/lib/math/div64.c
index d1e92ea24fce..0b10ded09a9b 100644
--- a/lib/math/div64.c
+++ b/lib/math/div64.c
@@ -158,6 +158,21 @@ u64 div64_u64(u64 dividend, u64 divisor)
 EXPORT_SYMBOL(div64_u64);
 #endif
 
+#ifndef div64_s64_rem
+s64 div64_s64_rem(s64 dividend, s64 divisor, s64 *remainder)
+{
+	s64 quot, t, rem;
+
+	quot = div64_u64_rem(abs(dividend), abs(divisor), (u64 *)&rem);
+	t = dividend >> 63;
+	*remainder = (rem ^ t) - t;
+	t = (dividend ^ divisor) >> 63;
+
+	return (quot ^ t) - t;
+}
+EXPORT_SYMBOL(div64_s64_rem);
+#endif
+
 #ifndef div64_s64
 s64 div64_s64(s64 dividend, s64 divisor)
 {

-- 
2.43.0


