Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA93803D9;
	Sun, 31 May 2026 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780216297; cv=none; b=Hfb+Vj10MdLhdqhlqVhL94wSQiVXrLWUDCKYUqtjjTq9nKgfI+qplDJS249WB433pubuzWSvKGQ0vW0OWrvqdZEDSIzo/rMj4X+jChoB6+Rj8XdDXhjTYAZQsUwcFk4tP5Iyj/FYI27A6xUjMYMEG9BxmBdWXQRo6QAWeJsMfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780216297; c=relaxed/simple;
	bh=fEpQ52qwEX2E5hNxyn7ssHZ/AkOROrSM19L+xOMsKpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KXLG7CDCpdbiW3kpnRhRD1edkum5cBmEjxwLD/O85JlnuI4EG987OyPS87M8fRh8lfx6w4znjbB+Q8JK74pYciGry5q6OZ8shVErUJIKrZUhvVDiznsixqsPUXy6AWOn/ZlimlfSWd85xTuNe4KXcig6kJgPOt9gJjgX0Btx4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNDPyqJF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNDPyqJF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75DBAC2BCF5;
	Sun, 31 May 2026 08:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780216297;
	bh=fEpQ52qwEX2E5hNxyn7ssHZ/AkOROrSM19L+xOMsKpE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mNDPyqJFArvlueRvf0OWIp/ku5W+3UtlcQHn6tpTMbA7mHKzNGsXbTUQ42kKE73oL
	 ogaHoqdvmOZpGY0XvqfRaFHVgtWbsNxLqOs+byqNqFIdqhMKvwbYcKp5G+wwydGqs+
	 JoCQjgfjs983NYyDDDD8OXMA+pgJ20PN+fRgI3QdskGIKsHZg05BHqDaspiOj74ggk
	 YC2IwuxkvQkQfl6+bhJdlovBzL4jI/4Ua7ZyeRjkVcGnhuC0VM+bwy7wXzjwQbR4oF
	 nEZEBieeWNrzm2/ghSIFGWM5/zDyTiqPoES344HXBN8fsHaO/mulScUMDPDHOkjMmz
	 N+cZnyFH+3hLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60008CD6E56;
	Sun, 31 May 2026 08:31:37 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 31 May 2026 09:30:45 +0100
Subject: [PATCH v15 02/12] lib: kstrtox: add local
 _parse_integer_limit_init() helper
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-adf41513-iio-driver-v15-2-da09adf1c0dd@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780216295; l=2791;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=UxUL9EGcYZLlZrE68BZiyyEJoU0744KsS7KUqiWM08U=;
 b=1ytkAhFyHcDWhCacp0X2jnb+eXABcj+bScjyt/3sz+aQBpFGAc3Sgc1EQfCbLmGmCoguo5ntP
 nzlsm5rUYSTD8JxRRkDfnG7ddFHPYQcs0fJrTkFDiSvgbqBDRdY1y0S
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


