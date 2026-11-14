Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794665401;
	b=gePsNKWO0RC/vIaSkWRCtBPnaiTMt5e321fAqK1BbfHP385e0FpasozXRD1nvQR57Ea1
	 fF9jC7LPo7lRTJFKHE+dI7bFMOwpr0ygLEPj4yr1EZUZzLYaMSjQDp9Sp+Vtb/w+D9Lhv
	 8Unm3tyQ/T62u1+PdwsBIHUBdaGWgkJnCn3hOs8SEL6ShlyUzYs3dwc3zWrVCHJdK+u2R
	 gOoeOmGfh7D5TtlIfGugBE7aOgG/hyzU1i58E0uJB/+tAXzWTszZEkJeKBTwR8S4+VEhn
	 rfp++9f58wKbCIggnm2duj3Ldjt96j+f6xg8vpwS01STeKz7uY0nesf35X6HFG34rYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665401;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CipV1t0eocxxwfanxEu8865oFbhvGc/cqHWI0m8LGZA=;
	b=sl9fJ+uner8hotBqf7qgbu/tQfpKNgzndp1knszAQoeilgY4QTR0AJIGyTUu6WU+kuII
	 Bca3ST4qd67kndM7opy6TbhD4Up+6vAE/hguKUJHRqHYPyG7l1LIrREyDJzCEC/hsg952
	 +mtTg9Y6TLxfCMqnx1gNEP4hDTlevK1MkShqFTNNRaDSdb/ryYhJQpb0kNZpdp/Qt5AGY
	 mZpBidjs4CPZyLNj0Mz7t86PrtzOhlqcCHuOwCmMG6Txxxt0ccDBd8020m5YdWLUWAf9y
	 45IyaPMqqt8QnLxzju51isgPAUSbo+074Eg/2VGydMZnNKfdTwEy8hfniUgKMo2neHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F97Y2bSV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30A606A33E;
	Sat, 14 Nov 2026 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F97Y2bSV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794665401;
	b=UyHZbzXtnmmwsnnPSNYpVm5/lu9jz1AY0Ll+7lfiKvZQWAbh9bDNmVeHBXg2jfx889Aw
	 If4yHY3/qIbe+chL0O7RAbjg8Ek0zrgNY19S1ziqM4BqP6ytNICUELFW5cbKwXoPPXUwX
	 aMeQqNHFHqyt9kJz0vNqmqnCfmRl/we+MMj/Vabql5fyl0fUZHjUWltzqpLJmDa2+TMLb
	 p+dFiohkD7grlEljBT8IC4T+DF52KfIHykOoedxo2p6ncuNVDbKoo8OTgOMxfmlRAbK1s
	 iewPH7+cMr7QKT37TF/RgADNBfU5ZDcW29SKrlpHZ72GXtI/jldHWWsKZUYvFnEQy8A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794665401;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CipV1t0eocxxwfanxEu8865oFbhvGc/cqHWI0m8LGZA=;
	b=UYpb/FE0RbahinoQHB7sFGH/ldWRZaQ1gEeRPWSD/oidPxjvlJZM6pDEibVB/hkX26LR
	 dhS/Bd7ClnZlq5ZUcMCDLVqeSJ/MWlu3BEeKAUTjhq2GtYwqXqwncro9rHsYrP8opatcb
	 MvwqgKC9UOmQQwHU+FdbEZM9YsdEhXxQbDMfRPX1a1yQZMwVveqHdxF2k1Lq/PpljefyI
	 d3+l/16Pdwm1XhObuMo9yjiksTvxxsKWtuH2QUkFrz/a6XAsgdhR6e+jUOVNy9Py/5wjV
	 E8zUj1hdeg2SsTWAlJSdNDrF8939dpIU/snEFkdGLA9G47EOgYNDIVGUKd4fARhStoA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 42BB71F000C8;
	Sat, 14 Nov 2026 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794665401;
	bh=CipV1t0eocxxwfanxEu8865oFbhvGc/cqHWI0m8LGZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=F97Y2bSVI0alVEfmhw+vfmi7n3kkJMbTA3p0dDxnzjWKTPlADvwI//9AqORyEUs/w
	 84/5ZDVnDV5eKja9LnHv2dbLqYnI1RWtppAuMHjE1IoKozty4xaJd4926uOrPihtzl
	 EO7eEXhAZGP8CAjA3+93esx38tmS3Hor2AsB5VitObT9ClcKxNDGtlos1viDDqwxrt
	 HStXrBqDogyddqDCGXz09zewOqj+/IL1LMyrBfIJhCZATSQXlc0HKLbtZdzZCdsHRa
	 NZaOy5DDgHqTrg/E0D9MdNWqPKreTIl+KClLxyU67eQYy3W1eneUnYVEzXhKhbFpUj
	 Z33EUjF89guXQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BDC3C49DF4;
	Sat, 14 Nov 2026 14:09:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sat, 14 Nov 2026 14:09:56 +0000
Subject: [PATCH v6 4/7] lib: test-kstrtox: add E notation tests for
 kstrto[u]dec64()
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
Message-Id: <20261114-e-notation-v6-4-205ca9a1438a@analog.com>
References: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
In-Reply-To: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794665398; l=5466;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=nIiIP9SD5omcIoOm+2iP0/q9S4xqAXZkU/Z/buM2wZ0=;
 b=VkOTOuXz0nxKn5VpktoYwOINW1pIXzhI+kWLas5QlSpmVZ4OgMdFnHr4UYv1/4cOKT8ByueVh
 haywaM/2GhwC/+YbNjM0eha9CZqRSVqKPyBJJ1WJv0byjvI38jO6FLj
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Cover E notation parsing in kstrtoudec64() and kstrtodec64(): positive,
zero and negative exponents, upper case 'E', an explicit '+' sign,
rounding (ties to even) of integer digits dropped by negative exponents,
large values, and failures for overflowing and invalid inputs.

Also cover big exponents, up to the limits of int, either alone or
offset by an opposite scale, and exponents that overflow when added to
the scale.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 lib/test-kstrtox.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/lib/test-kstrtox.c b/lib/test-kstrtox.c
index 8ba0f23bb8ef..a5b3fdc6e9b9 100644
--- a/lib/test-kstrtox.c
+++ b/lib/test-kstrtox.c
@@ -838,6 +838,45 @@ static void __init test_kstrtoudec64_ok(void)
 		/* rounding with many excess digits */
 		{"0.00000000000000000000000000000000423",	34,	42},
 		{"1.99999999999999999999999999999999999",	3,	2000},
+		/* E notation: positive exponent, no fraction */
+		{"1e3",			3,	1000000ULL},
+		{"42e2",		3,	4200000ULL},
+		/* E notation: positive exponent with fraction */
+		{"2.718e3",		3,	2718000ULL},
+		{"1.5e2",		1,	1500ULL},
+		/* E notation: uppercase E */
+		{"1E3",			3,	1000000ULL},
+		/* E notation: explicit positive exponent sign */
+		{"1e+3",		3,	1000000ULL},
+		/* E notation: zero exponent */
+		{"1.5e0",		1,	15ULL},
+		/* E notation: negative exponent shifts decimal left */
+		{"271828e-5",		3,	2718ULL},
+		{"2.71828e-1",		3,	272ULL},
+		{"270e-2",		3,	2700ULL},
+		/* E notation: negative exponent that rounds integer digits */
+		{"27e-4",		3,	3ULL},
+		{"19e-1",		0,	2ULL},
+		/* E notation: ties to even on integer digits */
+		{"125e-1",		0,	12ULL},
+		{"135e-1",		0,	14ULL},
+		{"25.0001e-1",		0,	3ULL},
+		/* E notation: negative exponent below 1 ULP rounds to 0 */
+		{"1e-5",		3,	0ULL},
+		{"5e-1",		0,	0ULL},
+		{"5e-2",		0,	0ULL},
+		{"6e-1",		0,	1ULL},
+		/* E notation: large value (27 GHz in micro Hz) */
+		{"2.7e10",		6,	27000000000000000ULL},
+		/* E notation: big exponents */
+		{"1e19",		0,	10000000000000000000ULL},
+		{"1.8446744073709551615e19",	0,	ULLONG_MAX},
+		{"18446744073709551615e-20",	20,	ULLONG_MAX},
+		{"123456789012345678901234567890e-29",	0,	1ULL},
+		{"0e2147483647",	0,	0ULL},
+		{"1e-2147483648",	0,	0ULL},
+		{"1e2147483647",	-2147483647,	1ULL},
+		{"1e-2147483647",	2147483647,	1ULL},
 		/* negative scale: drops integer digits */
 		{"12345",		-2,	123ULL},
 		{"12355",		-2,	124ULL},
@@ -883,6 +922,24 @@ static void __init test_kstrtoudec64_fail(void)
 		{"0.2",				20},
 		{"0.18446744073709551616",	20},
 		{"1",				20},
+		/* E notation: exponent causes overflow */
+		{"1e21",			1},
+		{"2e20",			1},
+		/* E notation: no digits after exponent marker */
+		{"1e",			3},
+		/* E notation: sign only after exponent marker */
+		{"1e+",			3},
+		{"1e-",			3},
+		/* E notation: misc */
+		{"1ee",			3}, /* double 'e' */
+		{"1e+0b",		3}, /* hex character after exponent */
+		/* E notation: big exponents */
+		{"1e20",			0},
+		{"1.8446744073709551616e19",	0},
+		{"1e2147483647",		0},
+		{"1e2147483647",		1}, /* exponent + scale overflow */
+		{"1e2147483648",		0}, /* exponent beyond int */
+		{"1e-2147483649",		0},
 		/* negative scale: rounds up past the limit */
 		{"18446744073709551615500",	-3},
 		/* negative scale: exponent overflows when added to it */
@@ -946,6 +1003,32 @@ static void __init test_kstrtodec64_ok(void)
 		{"-0.00000000000000000001",	20,	-1},
 		{"0.009223372036854775807",	21,	LLONG_MAX},
 		{"-0.009223372036854775808",	21,	LLONG_MIN},
+		/* E notation: positive number */
+		{"1e3",			3,	1000000LL},
+		{"2.7e3",		3,	2700000LL},
+		{"1.5e0",		1,	15LL},
+		/* E notation: negative number with positive exponent */
+		{"-1e3",		3,	-1000000LL},
+		{"-2.7e3",		3,	-2700000LL},
+		/* E notation: negative exponent */
+		{"27e-1",		3,	2700LL},
+		{"-27e-1",		3,	-2700LL},
+		{"2.7e-1",		3,	270LL},
+		{"-2.7e-1",		3,	-270LL},
+		/* E notation: negative exponent rounds integer digits */
+		{"-27e-4",		3,	-3LL},
+		{"-125e-1",		0,	-12LL},
+		{"-135e-1",		0,	-14LL},
+		/* E notation: negative exponent below 1 ULP rounds to 0 */
+		{"1e-5",		3,	0LL},
+		{"-1e-5",		3,	0LL},
+		{"-5e-1",		0,	0LL},
+		{"-6e-1",		0,	-1LL},
+		/* E notation: big exponents */
+		{"9.223372036854775807e18",	0,	LLONG_MAX},
+		{"-9.223372036854775808e18",	0,	LLONG_MIN},
+		{"-1e-2147483648",	0,	0LL},
+		{"-1e2147483647",	-2147483647,	-1LL},
 		/* negative scale: drops integer digits */
 		{"-12345",		-2,	-123LL},
 		{"-12355",		-2,	-124LL},
@@ -983,6 +1066,20 @@ static void __init test_kstrtodec64_fail(void)
 		{"-0.1",			20},
 		{"0.09223372036854775808",	20},
 		{"-0.09223372036854775809",	20},
+		/* E notation: exponent causes overflow */
+		{"1e21",		1},
+		{"-1e21",		1},
+		/* E notation: no digits after exponent marker */
+		{"1e",			3},
+		{"1e+",			3},
+		{"1e-",			3},
+		/* E notation: misc */
+		{"1Ee+3",		3}, /* double 'e' with mixed case */
+		{"1e+0xa",		3}, /* hex number exponent */
+		/* E notation: big exponents */
+		{"9.223372036854775808e18",	0},
+		{"-1e2147483647",		0},
+		{"1e2147483648",		0}, /* exponent beyond int */
 		/* negative scale: rounds up past the limit */
 		{"9223372036854775807500",	-3},
 		{"-9223372036854775808501",	-3},

-- 
2.43.0


