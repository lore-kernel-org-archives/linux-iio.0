Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C10367288;
	Thu,  1 Oct 2026 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868967; cv=none; b=i/ffMphgt8S2AAAAeGKDMPajB4GNA7vtmq20jKuwbZB9ONjrW4XUx69UBggDnoUXHPUS+1vHZYOEHZ2qN5sJXZArpiuqeHTnr/SRXDq5eqtYbpriG5k28UKD85Y+0wzkgbl5MuyV4pxltvG8KycQmmROYvsJP0nCM0bmbZRwvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868967; c=relaxed/simple;
	bh=37lrIpoYAxZAUCqJmdrsGZJQi3enj2Yb+EP0/OYenN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWeWdaiYI+LQ3ohKcPedfZ46d4A/J9RqkvZGfunrx9K2N8A3BcJn5eUepAk9s1yntAD5SX2SW7HlCQmQfDEX3dAMu/vYZDtttbfa33WGasETM1z0SZMUISt+phkHwrYwrL8fq/0NGhadh5pduDjYmIqatclOFp56LHss3Mbk88o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuybV9Y5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuybV9Y5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FCE2C4AF14;
	Thu,  1 Oct 2026 15:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790868967;
	bh=37lrIpoYAxZAUCqJmdrsGZJQi3enj2Yb+EP0/OYenN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DuybV9Y5bt74KmPjz2Gdx4XZmerIQhgUN7eVQhtSnGfLL7Hidj1TrrNHkwjfa8asD
	 bJ0fHPssL3/9xYcYeVA/KWFHELL4IoEH8/M7mz5LAStV0Sci/SaVkThMHhbB6Q5ROf
	 Kg0usykg5WEc1MN5k9KJ6iC8WaTpBKM5oO3u0s7X4VYKiGyjuiimgT6t/IspvB2PIb
	 u0Oowlm5aennnalUgK9PmD7fq5hBYSVE8FVrpckIS0FkkUowvUsr1s8J+Mrps0esgF
	 fCi+LHjXmI3h0cWrkBdWUjmHnECegk4lTNF8Wc4rDduQHVs5RKiJ4M6EsMYqSLwg3/
	 eW3MUZOCgudVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628B8CA5FD6;
	Thu,  1 Oct 2026 15:36:07 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 01 Oct 2026 12:34:57 -0300
Subject: [PATCH RFC 2/3] lib: test-kstrtox: add E notation tests for
 kstrto[u]dec64()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-e-notation-v1-2-75187bf06c10@analog.com>
References: <20261001-e-notation-v1-0-75187bf06c10@analog.com>
In-Reply-To: <20261001-e-notation-v1-0-75187bf06c10@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790868966; l=3418;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=srewDKtYgdW1z7x6ul18kfWxZ8z5yTDtOCBDUGrmJ00=;
 b=Xrg7Buuq/I8u6q10wc6/1MLtSpWQyjEGmkXF3WuAAHlisleizRxJQtzJj75ZamoQUZ8MCyHMh
 G2W3DjWNOBJBMiyAEkNx+bOpoSI0kcQYMOVIqNvdJYbwZMkH34CKQCn
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Cover E notation parsing in kstrtoudec64() and kstrtodec64(): positive,
zero and negative exponents, upper case 'E', an explicit '+' sign,
truncation of integer digits by negative exponents, large values, and
failures for overflowing or incomplete exponents.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 lib/test-kstrtox.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/lib/test-kstrtox.c b/lib/test-kstrtox.c
index 9255234752db..bfdb109752e9 100644
--- a/lib/test-kstrtox.c
+++ b/lib/test-kstrtox.c
@@ -769,6 +769,28 @@ static void __init test_kstrtoudec64_ok(void)
 		/* truncation with many excess digits */
 		{"0.00000000000000000000000000000000423",	34,	42},
 		{"1.99999999999999999999999999999999999",	3,	1999},
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
+		{"2.71828e-1",		3,	271ULL},
+		{"270e-2",		3,	2700ULL},
+		/* E notation: negative exponent that truncates integer digits */
+		{"27e-4",		3,	2ULL},
+		/* E notation: negative exponent below 1 ULP truncates to 0 */
+		{"1e-5",		3,	0ULL},
+		/* E notation: large value (27 GHz in micro Hz) */
+		{"2.7e10",		6,	27000000000000000ULL},
 	};
 	TEST_OK(kstrtoudec64, u64, "%llu", test_udec64_ok);
 }
@@ -801,6 +823,14 @@ static void __init test_kstrtoudec64_fail(void)
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
 	};
 	TEST_FAIL(kstrtoudec64, u64, "%llu", test_udec64_fail);
 }
@@ -853,6 +883,21 @@ static void __init test_kstrtodec64_ok(void)
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
+		/* E notation: negative exponent truncates to 0 */
+		{"1e-5",		3,	0LL},
+		{"-1e-5",		3,	0LL},
 	};
 	TEST_OK(kstrtodec64, s64, "%lld", test_dec64_ok);
 }
@@ -881,6 +926,13 @@ static void __init test_kstrtodec64_fail(void)
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
 	};
 	TEST_FAIL(kstrtodec64, s64, "%lld", test_dec64_fail);
 }

-- 
2.43.0


