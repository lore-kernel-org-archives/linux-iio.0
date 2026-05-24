Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8FA38F658;
	Sun, 24 May 2026 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779618939; cv=none; b=F4haujFaVjG/vCTbKjbWaqKPNo6SLWYxaCxgIzJXUboRSSyF7NBPvLTBpmnPGDb71LciaMOr7e24pRlG7bqiX1pZyN6U8uFyhG/yjmox1n5CAUaE1o7a2ZBrVrjrU4Lc6zN7REteqNjWLUq9UrXDQ12+VRISEBl17edzQ87Ko4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779618939; c=relaxed/simple;
	bh=fEpQ52qwEX2E5hNxyn7ssHZ/AkOROrSM19L+xOMsKpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tGzHmY4nvDXXuxSQMHf7yVfeOCJnXaMVGeVKhExEUeyKwq1j3eEpzIcj0Q2CiQX7+LLPAr4dHIreaPMDnDvUHmZe/bQMXECBuc+NM9vFGsB8u6PfZgy+OqxfVF6m4qPRJqTTZ3MVLCe1cmHUq/2aLfLqX4mJ1wj0ldEMJrrBre4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQepbM3O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQepbM3O"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A8CBC2BCC7;
	Sun, 24 May 2026 10:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779618939;
	bh=fEpQ52qwEX2E5hNxyn7ssHZ/AkOROrSM19L+xOMsKpE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZQepbM3O0ZgBRhWr6X/n0TfT9/1QcA2vDVhAQLpxFlGhA7w/ffTXBNiR5O3pe+GeI
	 cyZ4L9JlPakyXEDrY+mKG4rVHFUhIoWOBRDRRIgS36rO/Z1HxojwpzPN8m9I62jBxZ
	 3eGgRtbxW1MQ2xs11ZOVTFEQsHZpWcijR8XI3G6t/BsJeH8c2ryBFcshvUAw0FbD/N
	 ZEbjBcZh3ve3J5j3rH1s4v/RHpGOB9yWU8k4MPWM5oDJDUFiUa3Dd1tXK3M/jdiORQ
	 F3jeNQu6uNSHXH+E2p1hzgj8uJVISk79WDyfAasvbrZaTRN0AY8p+5GzpfYfe4HsaC
	 VeSudqOKzdO4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758F4CD5BB1;
	Sun, 24 May 2026 10:35:39 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 24 May 2026 11:35:19 +0100
Subject: [PATCH v14 02/12] lib: kstrtox: add local
 _parse_integer_limit_init() helper
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-adf41513-iio-driver-v14-2-06824d9c15f4@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779618938; l=2791;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=UxUL9EGcYZLlZrE68BZiyyEJoU0744KsS7KUqiWM08U=;
 b=XEe/ZsJtxx7p3Xh8mIq6R0eAnYwC+N5/ll9mzNpjifP1PQhy+bPzRMs61Dtkk+7biiIUSP0x0
 KgtKG9yxHeNCh+zB2XJF+7knAW1xDp3jrzXBWoEh8DoCuEAr62+cgCx
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add parsing helper that accepts an initial value for the accumulated
result when parsing an 64-bit integer. It reuses current implementation
for _parse_integer_limit(), which now consumes the new function with
init = 0. The diff algorithm would have the documentation header and
prototype of _parse_integer_limit() moved around so it is adjusted
according to guidelines.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 lib/kstrtox.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 97be2a39f537..bd63c55b8490 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -39,23 +39,15 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
 	return s;
 }
 
-/*
- * Convert non-negative integer string representation in explicitly given radix
- * to an integer. A maximum of max_chars characters will be converted.
- *
- * Return number of characters consumed maybe or-ed with overflow bit.
- * If overflow occurs, result integer (incorrect) is still returned.
- *
- * Don't you dare use this function.
- */
-noinline
-unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
-				  size_t max_chars)
+static unsigned int _parse_integer_limit_init(const char *s, unsigned int base,
+					      unsigned long long init,
+					      unsigned long long *p,
+					      size_t max_chars)
 {
 	unsigned long long res;
 	unsigned int rv;
 
-	res = 0;
+	res = init;
 	rv = 0;
 	while (max_chars--) {
 		unsigned int c = *s;
@@ -87,6 +79,29 @@ unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned lon
 	return rv;
 }
 
+/**
+ * _parse_integer_limit() - Convert integer string representation to an integer
+ *			    limiting the number of characters parsed.
+ * @s: The start of the string.
+ * @base: The number base to use.
+ * @p: Where to write the result of the conversion.
+ * @max_chars: Maximum amount of characters to consume.
+ *
+ * Convert non-negative integer string representation in explicitly given radix
+ * to an integer. A maximum of max_chars characters will be converted.
+ *
+ * Avoid using this function directly, consider kstrto*() functions instead.
+ *
+ * Return: Number of characters consumed maybe or-ed with overflow bit.
+ *	   If overflow occurs, result integer (incorrect) is still returned.
+ */
+noinline
+unsigned int _parse_integer_limit(const char *s, unsigned int base,
+				  unsigned long long *p, size_t max_chars)
+{
+	return _parse_integer_limit_init(s, base, 0, p, max_chars);
+}
+
 noinline
 unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
 {

-- 
2.43.0


