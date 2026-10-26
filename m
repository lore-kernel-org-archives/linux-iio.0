Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793015662;
	b=oVdrr5z+zRTSyZ20+SfIBeKbE1msQSeyTjDPZ7HNQ2aX25QB70Ktf1qBzrsqb9iCc8Ug
	 WoVoXEiwVysCqFhuwAAOx0hcK5AH+DNQw5xYh5baWU5SRqFYAxtwXSYJSClYcgPp89y10
	 mTddnJOULUV2pNJcYTXJXZecLj1Wun3AnR34Pus2bYE+4/RnZLMokHH8rLAUGu6LYYtc2
	 4AU6+q38dwC/R51mkxugPy6eeMyojdTwg5XfP1cFJgLC0M5E49KDQL6vV+jIgh9reeUWZ
	 h6xRkEM+KhMQ5cIpV/2GxNAVRqFNv7bwgxttHQVhDUEmO+7ZM9K0CBb8G4aW+A5Lmzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015662;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QS/H5MuVG1mDm/oVnzdU/HgobrfCyaM+IP/VlC8ns5Y=;
	b=h2HyTxlN4n2KFLA4hHLV0qKzIuVA4lj4MrI6163SqR/4804dOwf4AVJW18znmGfr0usW
	 IpWwV6H2cMDa032eUSMZP20i4KbXJuBFeGVnhJqQ0POFzSPqcRSNL7LzoUIb9xpj33TnP
	 d9oq4Vn2PvadAM+HWjnhY4pQPdlioyqRuNOBQqOF9Eu1ltXJtb/dtuwfdYGL7nhFPyQUQ
	 hh/YnaemBiUB+lbNHfFh0y0dJKsDNq4GV+7EIxSTaLk8+ZJe08kWkCoen9IGTTYdFIxQM
	 Wey1vQ5CcowzZAEKwjl3lW4mTp4CvE2D4wONOodWDx4KkClzAZeeEsAnGmq0lRGkfzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHIH+JSb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D38606A31A;
	Mon, 26 Oct 2026 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHIH+JSb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793015662;
	b=XQAnkPJLXhor6kNVSjbcrhJVSebmQCcnhsgxfiypI6YJPeHklMl/ZV4YnYUygleHID+i
	 KZ/fGwXyOiidwdcEH4rUwVzwg8yKVMMpaH4NEbdoSYi57aEa1x7fgXtewRdJsdOAVKbA/
	 QP18QFiUckbJ2TcgW2SZXUTJ05NKUQTd+CpSCzJvP2x268WQIV6A6B4n3M/hX6489dRw6
	 FVE/qEib/DC+GR8nOoX4JPhQMXdFhxGVQ+fRPNtSoVQq0UzPKIQ0mQOKLf8Em9tX+p7Uh
	 cykx/TJyjCyvf6gQXCGk6Z/epqrh6q98fE3NRojKxE77bQMSAPSmzIZAxz0V1YAD2PA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793015662;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QS/H5MuVG1mDm/oVnzdU/HgobrfCyaM+IP/VlC8ns5Y=;
	b=Kjby5neVUL4DWhu9C64xV4c8LV9RYEAf/i3o6zQikbFBTfP46cMWeYV+++IsfD5lkeTK
	 VQBcoIAus+2taxtJFRfKv4msSiZIC4gdlZLlJjH6XZwbpDpPH7fa5zf9qahHzlHT0WXaP
	 QCZ4MzzU/clLJkzkQFl7Qh8SeT/zcApSGwTe7cFMCQf5ybB33lKzHTmj6J6q2y/Yyz91w
	 H1gE231QtuT4iv8fIuKFPYN949A/q/rpzfJuXAS9hN/D5RCLPlWOVBtawj0UoONn/wZA1
	 0Kd9Ij+qxGm0t0jXOiP1mkgKI1x5lcv8COEl91osXrI3k1p2p9X4LwrT1BH5vqi5jbg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7A4521F031E4;
	Mon, 26 Oct 2026 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793015662;
	bh=QS/H5MuVG1mDm/oVnzdU/HgobrfCyaM+IP/VlC8ns5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VHIH+JSbeuaq7Ta6UEyrdpxAKAQYYIcKhHSMWKbhYToeqUfXPPZm4zOeKFusymZcG
	 uu/vXQcfDuvRAU2E0Wxx+RgjaeOpqS93fyML2w0DThmtD4jQskOluZ7OclwZ89+t/w
	 gaUb9nsAWjf4gZpojj8X03Mv7lxBlPjWvsIvux/mNCFeavCSfOvfs2p05YUl2psG6d
	 hcEbZJ9YVqrgJ7BYLvsvYewmNtSuRf1Nk+/irJtfhXP20kas+r6pstV3knQclCzD6y
	 duG4UNGqw69zw1ZSKtxr6znbf8CUWMhU1wbzW0BAFzd2IVwlXqjqq+CKZDOJfTKV9P
	 QGC6O8VmyWcSQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E003B44CD6;
	Mon, 26 Oct 2026 11:54:20 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 26 Oct 2026 08:54:05 -0300
Subject: [PATCH v4 1/6] lib: kstrtox: support E notation in kstrtoudec64()
 and kstrtodec64()
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-e-notation-v4-1-a366a6d14d57@analog.com>
References: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
In-Reply-To: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793015661; l=3027;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=wF/a33D3G0jiDP0HWeP+Ia8duTvTbru2jdlgQddbFsU=;
 b=a92MNNxdUiMYjEUOSW/ArrcC6fp2wJqFfQNOJ+L0EcSbPSHNGPjeC7ksS+2QABzV10iC5ep88
 TorwHD5+9xuBgT6woAAWDjXkzB1Z2yUde0Utz5C98QjsIRZvhjaM0wt
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Allow decimal strings to carry an exponent suffix, such as "2.7e10" or
"271828e-5", in kstrtoudec64() and kstrtodec64(). The exponent is added
to the requested scale to work out how many integer and fractional digits
are consumed. A negative effective exponent drops integer digits.

The digits are now scanned first and the string termination is checked
before any conversion. A missing or malformed exponent ("1e", "1e+")
returns -EINVAL. An exponent that overflows when added to the scale, or
that makes the result exceed 64 bits, returns -ERANGE.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 lib/kstrtox.c | 69 +++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index bac1c057e1b0..20d94a73f937 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -395,41 +395,68 @@ int kstrtobool(const char *s, bool *res)
 }
 EXPORT_SYMBOL(kstrtobool);
 
+static int skip_digits(const char **s)
+{
+	const char *start = *s;
+
+	while (isdigit(**s))
+		(*s)++;
+
+	return *s - start;
+}
+
 static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
 {
-	unsigned int rv_int, rv_frac;
+	const char *s_int, *s_frac;
+	int len_int, len_frac;
+	unsigned int rv;
 	u64 _res = 0;
+	int exp = 0;
+	int ret;
 
-	rv_int = _parse_integer(s, 10, &_res);
-	if (rv_int & KSTRTOX_OVERFLOW)
-		return -ERANGE;
-	s += rv_int;
+	s_int = s;
+	len_int = skip_digits(&s);
 
 	if (*s == '.')
 		s++; /* skip decimal point */
 
-	rv_frac = _parse_integer(s, 10, &_res, scale, _res);
-	if (rv_frac & KSTRTOX_OVERFLOW)
-		return -ERANGE;
-	s += rv_frac;
+	s_frac = s;
+	len_frac = skip_digits(&s);
 
-	/*
-	 * Check input beyond rv_int and rv_frac to cover cases like ".5" with
-	 * scale 0, which is considered a valid input, being parsed as 0.
-	 */
-	if (!rv_int && !rv_frac && !isdigit(*s))
+	if (!len_int && !len_frac)
 		return -EINVAL;
 
-	while (isdigit(*s)) /* truncate digits */
+	if (_tolower(*s) == 'e') { /* E Notation */
 		s++;
+		ret = kstrtoint(s, 10, &exp);
+		if (ret)
+			return ret;
+	} else { /* verify termination */
+		if (*s == '\n')
+			s++;
+		if (*s)
+			return -EINVAL;
+	}
 
-	if (*s == '\n')
-		s++;
-	if (*s)
-		return -EINVAL;
+	if (check_add_overflow(exp, (int)scale, &exp))
+		return -ERANGE;
+
+	if (exp < 0) {
+		len_int = max(len_int + exp, 0);
+		exp = 0;
+	}
+
+	rv = _parse_integer(s_int, 10, &_res, len_int);
+	if (rv & KSTRTOX_OVERFLOW)
+		return -ERANGE;
+
+	rv = _parse_integer(s_frac, 10, &_res, exp, _res);
+	if (rv & KSTRTOX_OVERFLOW)
+		return -ERANGE;
 
-	if (_res && ((scale - rv_frac) > 19 /* log10(2^64) = 19.26 */ ||
-		     check_mul_overflow(_res, int_pow(10, scale - rv_frac), &_res)))
+	exp -= rv;
+	if (_res && (exp > 19 /* log10(2^64) = 19.26 */ ||
+		     check_mul_overflow(_res, int_pow(10, exp), &_res)))
 		return -ERANGE;
 
 	*res = _res;

-- 
2.43.0


