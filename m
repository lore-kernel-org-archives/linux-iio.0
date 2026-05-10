Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435C383C6F;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416954; cv=none; b=tKlZDu42d84BgQHkuw9QpxcRNcZX/55Pmaimm9HRPeJkJDo0ejJ9d+XOg/AR/O4uAW0gr6MCsKDNgOtqsFnYH8R0SI6t4fjg08BxTM9FSV66+afdReOiIBV1VLLfsYAEVrLN/LBPHnYII2mG9QrOXm61OR6zxsuzQVJYWLIleQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416954; c=relaxed/simple;
	bh=+PnoWBfKnfV07TYFgJMKkg0KM9nPZ2plTh6bMfU0YFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9oJlZf5mLDoSFUFx+LZOA1XIBISzs03LShup1aKUIWrJI5Clj5xOIIYqTUrBV5BuXdlmyhQLqfm0N+mbHwVzN9Q1ZCLdqv29fILRMZGVsVtSsgbgUasc1tB3LumF3e2l8C5dMZMYLdiis94Oh8nBb9qDDbC1E01Vv/2V5CIp8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CADOoRhv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CADOoRhv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 921C7C2BD00;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778416954;
	bh=+PnoWBfKnfV07TYFgJMKkg0KM9nPZ2plTh6bMfU0YFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CADOoRhvl+Pv0EmzhIFdTshLnS33uIqnvqOneeKIS26vD0sPyEIone3ZYcwy6vnFs
	 /97fJINeRa10d6GWi/odb8bcUzszXUoP2acxHANJLp2/UIFx6LLzmHUwpCm2ld5tm/
	 E2qeWFzea2ZD3gM26rzse529qIFZQ2TqpM/mTQIPQN4uOuYTy9hGR1QhmP4p+EkkoN
	 ZuLL30bUfIXh716nb8ZsAdVPSH9kf/7Zl+zF3qccXx/mK+5cy5lxKdnQgSsuoB71du
	 l8S9yQ8yb+VqXUGpgdCYozOo5ZTiKwxhFS//CPtP+sWlVMwWt+GCzmuX521FitD8Gu
	 kDoaium250Yfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887E2CD37B9;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 10 May 2026 13:42:22 +0100
Subject: [PATCH v12 04/11] lib: math: div64: add div64_s64_rem()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-adf41513-iio-driver-v12-4-34af2ed2779f@analog.com>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
In-Reply-To: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778416952; l=2261;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=2v2lygWWRh+YYmi1idrGFbtPNUJ9kh0HFK3mhrgB4es=;
 b=Obnmp50ZQWezxAj2X2YmcBCr8h9+dYoJiKs4XQXSFdjOaw4J95Xy5Tl0ZYxFydaTvCNMNi+Mj
 8nsWkEIaReUALfLR/aIfRA1KUBZwhif+Q8tC9dxpqh0yRRncf3FKKBp
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


