Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792499230;
	b=N+EAiOPerqBHBRGstgX4IhIZGshcT3HSonog8L2opnfvPzUvfE+2U65AHXPwOPUl1pvs
	 3PxXNV8gxB9tGgwMfKqxmdriUgZwzKkG18RZSXbVYCgUT4k3VlXH/znt7XEWeugatLOkH
	 lCIRdASn2j2D2p9H9F6i8y4KaVdnXCs1wj/RU7EBzTXt0qqlNpKWjUthk6YBfUbE4KWet
	 M7bY/BbO/6AvBMV8Zf6ljOKFIV8owc8ryLvrQABOd2dGng1ktjOEUBTGOmtbxQppqsBRJ
	 OXTW5GsJDLXWtK4aj9/MUVghJDq9im1vd+2/TgRHAPPVLl1duWxHmUI/n4SOiyJJJ/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499230;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sFW1NzZK4FfAm9AoDZzAS4SY1FXO32tfeNl+/AkoL34=;
	b=N9E8syqoi45TpgCvQEnugNvtN7xyq+PIHGqNdynV5TRqxxnBQYp7nBRfDkNszKU4J5wf
	 gEVi8LAUVVda3xnE0EMMHfxvgZd4PqdW78I/FN1vBCF9QdXON064t4jvrvo0slSdmitaw
	 dYmwzMiORgoPdVMe9PKdFm67M+ZY3F5WQgvk63U/SSm5Ko8Txw5NeWOG34SqLmxtnth+r
	 qP1s18QsA/jCacIyB2ANt9JbvNbLYjZ64NiQCPNM2dbqkjrOuJgd7XdOaiUT40x3WSKWV
	 3+Vhgo9HX6wbhBDjvkWnoxqRNKnLuWK9x1uCDM65Vovtj/nBVk0+LE3uorfXj2CnuBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvTcZ8iV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33239606A31F;
	Tue, 20 Oct 2026 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvTcZ8iV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792499229;
	b=G4mfhkmDSbo22EUSOix0B8x8TV6D+ImC2ZQgPbwtsk5s9eXU/uiRpohxVgAp80KRVsbn
	 oXBHSfY82nhl8eyDPz76YOrAvyBsPTHsCaqu+RkZjK3771rAUl3bp7mavwIQNw+UuRp69
	 DZtC4tRv1LUiENv0M/KltOTCNgfV0qoMJyvKTujiTtBLfjB4VXni7SvkSZ7axvluPTo5z
	 RxSRcyw/w0+sKRRgh4knlFs4/X5p7S2lpZnvPMYH+wvUkgMvRFDBCK4ystrXfCktOZB8W
	 ovh/8zbyogFKWfRX3rUwkQW02dzu+rC2uw9bjQgFYicyVh+2Ghimvs9e9MbXQOatooQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792499229;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sFW1NzZK4FfAm9AoDZzAS4SY1FXO32tfeNl+/AkoL34=;
	b=v4zdJEYmX1WeEDIdSuBrfMoALtssrtdoGFMI6A65GOfm+pV48iHVq/Bj2VTAt9XliWJr
	 vWs7UjtFEhWMbt3dfBZnqfABcu/PgGEQCPM/28gRrgh0rAjBwIrhemvFYjsW4qnz3wNJ9
	 H1Z9AEdLizzDRUV/75KHsT2wBf4PfByqpHPxgydXahl0dXZKMu0x9dobsyRySDB3madaa
	 Dtf4lqUwabCbvwlW91isnxNippzXo3T/BwVTRy5nyHlKb1sG4pzW7MjW+bOvaHyEcnMyi
	 NuAY8fknfF4t1ZE9hfU2XzlYBTPR5+nCR3Iwmmrl0FETlYKYONjzTZA7bUKKzB+aNhA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C9CD11F000CF;
	Tue, 20 Oct 2026 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792499229;
	bh=sFW1NzZK4FfAm9AoDZzAS4SY1FXO32tfeNl+/AkoL34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WvTcZ8iV82GzjPDKZlhA0KNCT27lM0QwMwiQ4NR+0cng2G2noQyDcbx1mMcuUSD7/
	 sNtLjztNk0qVVK7BJe+gw7+JgQHiY1+Km1i8AJc5OyKPOLUd8YENVjZikvOgiAslED
	 1wT0bBMTG+Vu3TNGjSVubcWTMT8UMd2UXfEz/SKHOY1uB+Lygm5XXeM2mps+OZ1ypR
	 hLNfUVEE7/un36RTUH4HGFSZR0ThNBuhOuwMcSAbfpru+m5j3pGq2L0Ou05ypqn6xD
	 +xL2pSqEX8XlQELl4IwftdaBTJ1rwl2hR7/h+ufvvLzHp/6Kh/NKorIiEcr3zkgAYv
	 nuWwAu8O2dwcA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 43BAD43131;
	Tue, 20 Oct 2026 12:27:08 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 20 Oct 2026 09:27:01 -0300
Subject: [PATCH RFC v3 3/5] lib: test-kstrtox: add E notation tests for
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
Message-Id: <20261020-e-notation-v3-3-fd385c0fbf65@analog.com>
References: <20261020-e-notation-v3-0-fd385c0fbf65@analog.com>
In-Reply-To: <20261020-e-notation-v3-0-fd385c0fbf65@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792499229; l=4166;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=XYfShfC/V/85n6Ho4OHa4bQCe6N9+lawE2+ZneUh2cs=;
 b=gxkqwtMPd4/z3i95BTodOl9cvJmoABORcJWAQ/DdX67PkfQp8pDBU5OzHPMCkQ5Dy7X2xkFQ+
 QtQl9uSGtaDACbyqmHNHYdXI8LTCicHIJxJJxBpi1kPeHtpxvsA26iB
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

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 lib/test-kstrtox.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/lib/test-kstrtox.c b/lib/test-kstrtox.c
index 1f176b232085..5365d020746d 100644
--- a/lib/test-kstrtox.c
+++ b/lib/test-kstrtox.c
@@ -780,7 +780,36 @@ static void __init test_kstrtoudec64_ok(void)
 		{"0.0000000000000000000012345",	23,	123},
 		/* rounding with many excess digits */
 		{"0.00000000000000000000000000000000423",	34,	42},
-		{"1.99999999999999999999999999999999999",	3,	2000},
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
 	};
 	TEST_OK(kstrtoudec64, u64, "%llu", test_udec64_ok);
 }
@@ -814,6 +843,17 @@ static void __init test_kstrtoudec64_fail(void)
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
 	};
 	TEST_FAIL(kstrtoudec64, u64, "%llu", test_udec64_fail);
 }
@@ -873,6 +913,27 @@ static void __init test_kstrtodec64_ok(void)
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
 	};
 	TEST_OK(kstrtodec64, s64, "%lld", test_dec64_ok);
 }
@@ -903,6 +964,16 @@ static void __init test_kstrtodec64_fail(void)
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
 	};
 	TEST_FAIL(kstrtodec64, s64, "%lld", test_dec64_fail);
 }

-- 
2.43.0


