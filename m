Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616085;
	b=nhrqQ+VRp4owxPxG7vlRCEaivW3PiVC+4TopK9hWg+75brKGWVdxttNfnoU9/Z6HxXLN
	 Sap50Iej7uJMY72wR6Tn+muMUBJsixt54z+km35jgDr1iBLxX+U+3N3YiXl9NNCT0Hn2a
	 Uw2PNlUCS/o+cGUgJUZejlQgN4tG/Olo3ifSIP0m5jTBBhS91lJitWelkaA1iqK4igPAw
	 rCjc7SZYDSj/VxjVIfMWKpFpGDZ1vVE166Lmi16SEuPtdD2bcNL1/hvPEvCYokMvq9+9g
	 +bC8W/wJTlZacEJK0adDIdVMvRMpQdnqrfhBEXhO/qTXl0XsVUSYGEu9DIjkOzshFoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616085;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aPpG0cJP4cL1m3NU3veLqjgf5cgIpCx3ZYA9b+d71Rc=;
	b=ggJVJENyeJX9ddlgWSSa3D6GfHITpSLXPaaNJ/Oo2ulfG2ZuJVvombf2jzSetYHm219T
	 L8X1MsKEhwj7m/nmsEsaoyyRPvoEAED1zoMqeV3o2XNOdPXolRguL9Bthl5jOwouy8YDN
	 ljSGRS/ar57S3Krb39lwkIqev0Gsxs3Zhp/t4dyttiLPlZN1CgQbQc9kdV3h7/UwD6v2J
	 az84hC7R623kWzOkD3DiV3HQxBHBZeQKhxWwhz5jzytM2aoC5gRShea+EqxNLx1s+8sAG
	 fjgKR2HKxn56irbyKc776n+HOUPkDLb1TAIVHb6opyiAttwp5wzPDUgzss5oZKo6TQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhDmoQqI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D98606A324;
	Mon,  2 Nov 2026 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhDmoQqI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793616084;
	b=wagIb/rCBURCQ3RIUs5XNnIFlvwt16IQwfVya188qg+aSQnDZFM8sAm1SFR41tsKbk44
	 K/GitnxbO0JwqY8OBNWVNvuT3B2jQUNjpvVUNtL0Fa54hJ/C9tyWBP77fFwIecfz+hsmW
	 MBI8PIYG+RNx+d0AryVK78XIvodwd0k6oy6n3eyPtOJ0Pzge+EFVj6XxEIhMPeEwZlp2C
	 FTUYtprUuW02r293d4Yula0MctbFqNOco02gqk6TSBR+7i90t2yTPaSjyzg5XYh2DUdjE
	 P+1gXpgevKUnw1e3Y9oQav2+QebYP0/eCySc0I+3fPYf0Q8sUHNmhmGej1TRbL0lLRg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616084;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aPpG0cJP4cL1m3NU3veLqjgf5cgIpCx3ZYA9b+d71Rc=;
	b=i9IIFZk5dumApMaXm3AV46OjmXVdkbdqwi74Lis9FGRwzY7nX9wB5eFWgssOQsF41A2i
	 aJYtYv71MG/iB6d7puU9hAVkDETCh8AQ4h9f9XMAmIxfzgdfb1lQdzamKVMx9h6WyTG7x
	 Nh9Xj6bxPH0i2cor8tRt5lr/5Z96FSguTO5Kx9MU3lUN+UQ/ALKR2QBbpemDzjB+2hyrw
	 HjUQcG+RTMSf6LKgFknS5AAfv4BZnj0lhnOysYq+VoZjlgneqQYQsztrxqf+Co+TsbQ3H
	 H1aBTHU6a2Pk3uMiCX/rPNRin43CfyaKK1FfsYtHVc3t7dWyWXMsPYo9tYvSlyg0Naw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 319AF1F00919;
	Mon,  2 Nov 2026 10:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793616084;
	bh=aPpG0cJP4cL1m3NU3veLqjgf5cgIpCx3ZYA9b+d71Rc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GhDmoQqIZJHuoCgBsJ0lhri2mfksKUYfgsOCGYSC61wue6qYVQYjMuL7CnCuLV1kz
	 YMXvVDOmjy33Q+ItqT+80/xLFaOrMCMeJdBdZwvnRWS4ZJHY1JGMPXZCnglwgBPmXb
	 Y5OSOt5HXpIBX2hXCkZu0FFXpv1jsPjIT8+NLbmrGn8up/KuWftPrQa3Mb9HeTW+Gs
	 GQARR3IqblvMD89+DrcjIQtO7Yh/rxI2NP2wskh1R0KYlrz3qtHOIj3M/zEBXGAql8
	 tkoroPh364b6x3CApXB65eSEHbyV7glfygYPfUACxErwRF8k6F6As3j6utrvEcONcU
	 9p4UfHORaj6GQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 97ACC46461;
	Mon,  2 Nov 2026 10:41:23 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 02 Nov 2026 07:40:59 -0300
Subject: [PATCH v5 1/7] lib: kstrtox: support E notation in kstrtoudec64()
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
Message-Id: <20261102-e-notation-v5-1-d399e544a982@analog.com>
References: <20261102-e-notation-v5-0-d399e544a982@analog.com>
In-Reply-To: <20261102-e-notation-v5-0-d399e544a982@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793616082; l=3022;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=ZFrp/Yq7l//slmYaYIz9SzmuWKV15eT4mVooRD3b6KQ=;
 b=E8cO0I8vlgu29Ecu1Os6xOke+5hJcOsixwWE6Xgor7KRk0puiWUigRqpf5sbzPaE0KJhX0QEE
 UVCKjUE5FsHCFghFumdJBDcrY8G1fkhXk3GFwms/mTyBnNiM3gMrJu3
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
index 1b3f0d3fff37..94f3399b3a9b 100644
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
+	if (check_add_overflow(exp, scale, &exp))
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


