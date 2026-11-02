Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616086;
	b=vkXXSPY2LfRcWYNzkmYKeBIIk5+5m2F2J72nPO9oQZcZ+uh7vGbXYyfDVOX3ycMcB9SS
	 Moxkro4yUotLSqMTEIkr92X6eQpK0jtyYZFfoe4hFcY47ga1DPnZuArebleLxryZRfXZq
	 2KyfMw3wK4L9Q4YzP8s+N1ucIIz9JFKUvXdTviTkTvx65nx4iwrQtRTCEXvDcO4CE0qBl
	 swLRA1xTg881hHvEnI6c6qob/bip3z9/znU6qNb3dXZlqVqIpq2Otr0eKKSzwto/f1VuO
	 dQCuoTqK8sgu2mDh5oD6gi95oTOlwQNNehV3s1uHWCROwBDk+MFUQ7qJrW4AiIzOEWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616086;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CipV1t0eocxxwfanxEu8865oFbhvGc/cqHWI0m8LGZA=;
	b=4wUeU7P7egAPtxNq2MwJvWLCUUMJdpeB8Ex5eQV9o4Nu93KBFNTLC/Y9YiqxmPe5gPtr
	 cl0udkeZ1l5Xvb4ioIWO+/nTcp3t0qPL6I5fEct6V3/m1HzQiXhyqJXgUExModd3bVIf6
	 zgTXxvGkwTSND3cUePhT4ur+yuWJYZYbcB4abA9vuX5uekKJRJZ/QwvVO+GX0reojOqTp
	 VeaErv9AOL2KF7reMGv9eY821nWBKdTQjlzS/LTd2qxVFq8pIjWG+56RTwJtE6hNtLkqB
	 f16hBsA0GXjPpuJ3CJ7AnQJLbmybr7J9lcMAME+1e3xozb0nthwylIu8JNRqGEJI+AQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dL4xT/vU";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB3606A335;
	Mon,  2 Nov 2026 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dL4xT/vU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793616085;
	b=dLjQr2rjZtNQRk5hoWmlj0P2yCubS2Z79ru1RAWtZ348Pyftvhe8LAOi8ZubE4nkcVjH
	 wSFcQTCQamBl1OOoB9l6s58noHIyZVa/zu0amoIEgc8CsXOg7k13/PMs2BviiD5j71AmZ
	 KSCStDiRVws1FHX4VdbzQHaM6w+7UlrUZUyWwnODiZH67aPa4j20H+Pl/YUzyI1bmQ4zl
	 ziwxMNsCf866hzYxaaeC0xl05jHqK+Z687LuT0jI7BaoovRmfj2ryv+iUR5vE5dILxNCO
	 r+H5fvOt5CcUe5DGZV+yqYjBQzkdshmNyZmVNKBM5gu+bDsyL6mCMtGbasef5ph4oMw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616085;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CipV1t0eocxxwfanxEu8865oFbhvGc/cqHWI0m8LGZA=;
	b=IlnlhOE2dAtzbqYsmzTUKaSK5yPpCyD+6IC+6blPJY54OxLime3TbCguy+mLryjl4A0I
	 cf4uxfX4DIN3Ru8AvePKdqx+pXuPUfezUnVLdE5ycKeeSDZg48+sJpsU8U/1QuzFPBAj9
	 JgSrX6y9Rr3lokEOd8LoiSKp3DUsXB9onCyN6/4skih9qUl5dPLk9RosSBddtwIRckh8L
	 O3DMHEgv4VTJwPdB8Vg0Og9eMbXc2daa5/32N2nofAHkgrlMN0cnYfemOzfZcy/UCCOI0
	 r4Djk8Li8SgzalFn0D3lT4Oviz2h7W5oLRHw0XL58s3H+p1zgRtu5t+PeK9+fO0lVjg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3D05A1F00A15;
	Mon,  2 Nov 2026 10:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793616085;
	bh=CipV1t0eocxxwfanxEu8865oFbhvGc/cqHWI0m8LGZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dL4xT/vUpF1GhD0FAK4xYHtSfg1G78olc6YTUShaEJkq+QkZc2lBwsx0V3gdVP/12
	 egKpRV9GNWNt/Mt0lRIwhPkLqtwinztZlGyr7G1WOy7mxta+R/KTZVeMNhzV/4OgZp
	 1gpNpug+gyWWYzBP49PYFCAb/a3WwqeLmY8z1bpPYRHUoAij6Fevlv/9VkC+PaM0sn
	 JSywXInxaC4F60sm+9TogDPShecZg7UgVy6otQugVtSoUtSzs2/+89OMlZpm2gZOxB
	 xlix/RsR3BF3He5zM2nos1bnA7PM1VTa3ESQjqRB1s4adkjwPLcRcUOFr9DOrjAg3C
	 4tBnM3GbzohXg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BCBC14648C;
	Mon,  2 Nov 2026 10:41:23 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 02 Nov 2026 07:41:02 -0300
Subject: [PATCH v5 4/7] lib: test-kstrtox: add E notation tests for
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
Message-Id: <20261102-e-notation-v5-4-d399e544a982@analog.com>
References: <20261102-e-notation-v5-0-d399e544a982@analog.com>
In-Reply-To: <20261102-e-notation-v5-0-d399e544a982@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793616082; l=5466;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=nIiIP9SD5omcIoOm+2iP0/q9S4xqAXZkU/Z/buM2wZ0=;
 b=CbmtYAXM33XYtsh+CPxE2b1NJ7TOTjeXWtYnoBPGlei2UYXYKodVayEQyEPTA5BG2jXZ0xO++
 PsrH+yczN2tDzku+1SW+dNneiKQI8jLp6aoytRlAJzbI3pfg/WiDIk6
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


