Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CBB457E66;
	Thu,  1 Oct 2026 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868967; cv=none; b=eaa/+DO3P5LChk0mmyD62r1szUqC6FtOQAkBZBY+Rb7T8yGqe/7ijcoqwxoBeOaNQWjFDn+4IDDxld5G/6BW5/mLXtAq6ZBI22p2tZLiksJo7FXa28iudk7a1W0YlERig6iW3cPJDpWWtV+tvvm0VApt/kVxmm6zmgEH8Lb331U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868967; c=relaxed/simple;
	bh=owDy0B8FZ5HCRWilDEUp0cPxvkk0Pp4esgAFgMo1Rz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SSbovZ9s5dVzVMmEuUJU0YGjA2KFx4MkgEB1F9hgh8VPSG03OBkmlcmDna9Bcw/oXuy7yWbDQutDUA4nLri0CDhm+I1Yirwt5nj+jMEhtPmmozFgXDqP92mkw4/rGdVq2yMs1uyjTQpWBM+HeN6rn4zvQVwvsYrca9+9xGOJgco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePX0QBmn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePX0QBmn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70034C4AF12;
	Thu,  1 Oct 2026 15:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790868967;
	bh=owDy0B8FZ5HCRWilDEUp0cPxvkk0Pp4esgAFgMo1Rz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ePX0QBmn5M4kmQpZV6JDcmn4edEuRDT/p3FKnsaTWZiC5HMwpISMq1okKHjsQ6rKj
	 h9AvrH76ZhoAXQ1AFCx0Z7xDLTlw6D/Yvi/MYRnnhvBJJZ/N/3BeappiPynNtykhum
	 wxebIdV5nPDzDvHcWMZT2M9N8iyCf7d2N6i2ix45VA9nWe7lrr1dwCy1S2r9p6kHhG
	 IUY32MmO5iWXulICUCGDWd1IfRTXEkCm1kdSy+24sk2/65oPkNpqJVumJLsHhIlu5W
	 b1HNRr2AoRhR4a2KUgl7yJleYSfT5on0qsE05LhG4sK1f4hXJTSHf8kNzoFic/bjoN
	 FOKlEBdogCKTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504C5CA5FD2;
	Thu,  1 Oct 2026 15:36:07 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 01 Oct 2026 12:34:56 -0300
Subject: [PATCH RFC 1/3] lib: kstrtox: support E notation in kstrtoudec64()
 and kstrtodec64()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-e-notation-v1-1-75187bf06c10@analog.com>
References: <20261001-e-notation-v1-0-75187bf06c10@analog.com>
In-Reply-To: <20261001-e-notation-v1-0-75187bf06c10@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790868966; l=2928;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=3fLsUR5b5WZAVfLhBMXZfjqcJYDq5+HP2L3agWEZDXg=;
 b=21y+NtKfrRmrFRreWvUlhsbm9h8g/Hd3XuuBtem14VnfXY+E24eHKe1H/cwRPk5pBfQHC4qfC
 xVcIPVCLRldBR8cC47TESAG9flIQJk8pDkGeeTAYLfrEGYpa3cRXV0h
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Allow decimal strings to carry an exponent suffix, such as "2.7e10" or
"271828e-5", in kstrtoudec64() and kstrtodec64(). The exponent is added
to the requested scale to work out how many integer and fractional digits
are consumed. A negative effective exponent drops integer digits. Digits
beyond the resulting precision are truncated, as before.

The digits are now scanned first and the string termination is checked
before any conversion. A missing or malformed exponent ("1e", "1e+")
returns -EINVAL. An exponent that overflows when added to the scale, or
that makes the result exceed 64 bits, returns -ERANGE.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 lib/kstrtox.c | 64 +++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index bac1c057e1b0..4755fc78a62c 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -397,39 +397,59 @@ EXPORT_SYMBOL(kstrtobool);
 
 static int _kstrtoudec64(const char *s, unsigned int scale, u64 *res)
 {
-	unsigned int rv_int, rv_frac;
+	const char *s_int, *s_frac;
+	int exp = 0, len_int = 0;
+	unsigned int rv;
 	u64 _res = 0;
+	int ret;
 
-	rv_int = _parse_integer(s, 10, &_res);
-	if (rv_int & KSTRTOX_OVERFLOW)
-		return -ERANGE;
-	s += rv_int;
+	s_int = s;
+	while (isdigit(*s)) {
+		s++;
+		len_int++;
+	}
 
 	if (*s == '.')
 		s++; /* skip decimal point */
 
-	rv_frac = _parse_integer(s, 10, &_res, scale, _res);
-	if (rv_frac & KSTRTOX_OVERFLOW)
+	s_frac = s;
+	while (isdigit(*s))
+		s++;
+
+	if (!len_int && s_frac == s)
+		return -EINVAL;
+
+	if (*s == 'e' || *s == 'E') { /* E Notation */
+		s++;
+		ret = kstrtoint(s, 10, &exp);
+		if (ret)
+			return ret;
+	} else { /* verify termination */
+		if (*s == '\n')
+			s++;
+		if (*s)
+			return -EINVAL;
+	}
+
+	if (check_add_overflow(exp, (int)scale, &exp))
 		return -ERANGE;
-	s += rv_frac;
 
-	/*
-	 * Check input beyond rv_int and rv_frac to cover cases like ".5" with
-	 * scale 0, which is considered a valid input, being parsed as 0.
-	 */
-	if (!rv_int && !rv_frac && !isdigit(*s))
-		return -EINVAL;
+	if (exp < 0) {
+		len_int = max(len_int + exp, 0);
+		exp = 0;
+	}
 
-	while (isdigit(*s)) /* truncate digits */
-		s++;
+	rv = _parse_integer(s_int, 10, &_res, len_int);
+	if (rv & KSTRTOX_OVERFLOW)
+		return -ERANGE;
 
-	if (*s == '\n')
-		s++;
-	if (*s)
-		return -EINVAL;
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


