Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548738236C;
	Sun, 31 May 2026 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780216298; cv=none; b=DCeMlIaKjn2KXaxVSvD0iAI1KvBtYhh7ZKk1z1QS2IgEXQZptP3msFQkLucXSijXAHsatiCDg0GceTAGUcK/pUadR54BuOmh12AbK1BNnQjWHKblXLJjSDIooI6GboALXiO5/bzMQzKLlBtYFro3+ovhX6bXX+gimVMg1Fr6yXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780216298; c=relaxed/simple;
	bh=0MiPE4pAGNIHkDMT5fwtfqtbshqWVCMkNClPirEcpH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sC1grZaJaacQtYqWIKyXjtfdS7Jho23ZTwZvOHQ/vrdbk6WMZMZvk5447bpQ38CwysySmypPXCuk5Me4w4EpQg0CiNaEcVBqjD9+MW4qUE4hZmVEh4/WhWTKu99o33FfV6Yc9IC61v8eLWPclKQG1rc4FmsJmTZ3ILqFohwaS6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhXm8qbG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhXm8qbG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 984E9C2BD04;
	Sun, 31 May 2026 08:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780216297;
	bh=0MiPE4pAGNIHkDMT5fwtfqtbshqWVCMkNClPirEcpH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UhXm8qbGrifoTwJMhmt2a5199nILgon7Kd+WUyovt3I2UO5kFWFBtCH2zPK2bRVWT
	 pJf3RMCbOwmvSharxvXx2pG73H7swi7GY2U3b06SPc/ZszO9DGpn8RqiVTJ29F0Yf6
	 D29kObCv4Ll6YQqE8Fr9W/PQ5jqY2LvsP/2PseI9ixJU1L8RW7ZpbjjqKkTfGETDva
	 nPYpFyy2Aj6V1I9FFAte+jIH8vGUxMwibLiK+HYdARzuZcL8KYdwNEZf3hxkwjNsMg
	 4+QbZJYNCuHjBObdd4mwPDQtOeGwEGqLCOycVvEtSAYE4i08m0Fk9s9wcNIRe/zOQc
	 95yQN7eMalU4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE89CD6E51;
	Sun, 31 May 2026 08:31:37 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 31 May 2026 09:30:48 +0100
Subject: [PATCH v15 05/12] lib: math: div64: add div64_s64_rem()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-adf41513-iio-driver-v15-5-da09adf1c0dd@analog.com>
References: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
In-Reply-To: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780216295; l=2327;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=ROKa5iAD0w5bgrXddKrko8IjoFXS2V0nXvPl5DFoZoI=;
 b=u4GF/O3+zSa2Mu4WqYowAXQE+UKKRPKLTlOfiui0x8zPY4HPEexK+jlaOE07IePmej7pP9SSM
 ehzHy4Qd1DWA4Up/V4WfVgb58UFUSrm1dpoV/4VB0De8KF3yUVSfWDw
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


