Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B542518156;
	Tue, 13 Oct 2026 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898615; cv=none; b=n+6YLZHgLzxUJ2P+v4p/gj3CzZzpK+vc3Z05QMTTGxnZd3yv1ArKcKjyAZVMeE+8DJQ7edelBZgmxzn09UWQh4H5i0RnE2kh8lx3BOlVOUmREbSqjcGzOG2IZB62eX5DSL73p7TT0urIlGFzxaBEYuXP5zIFmNGlKLxDBEKoWTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898615; c=relaxed/simple;
	bh=gIFFqm/D+noZWdFIof2v0drJdE+pmryGOCSZvScOQ8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dC924FqTUJpz+MTFPqTQjHAs6SMdHUKADr6vzslUkHe8iil5iMa8A8Jm446HnmZ7srOE9WS3DEb1cWWLxG3AenbwFiqomIS/oeRqEMseI4I+2riNKek8hvWtz6OLABAG/prSD/ta1FQYKR24I8Hn39skW/XdqHuJ6tSeVFL6jiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIhc3B35; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIhc3B35"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30FDDC2BCFD;
	Tue, 13 Oct 2026 13:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791898615;
	bh=gIFFqm/D+noZWdFIof2v0drJdE+pmryGOCSZvScOQ8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qIhc3B3567ERxb06PT1Me0MREG0x93SNfvTqDRqGaoIdg+TdxyC+HWe7qmy5t2px+
	 rxuczp49JUP1C5Qkuox/aFN3EgtEkPbbOhXkli+nYL1sKa4BxzCmxC+TGDLC47QsPv
	 xskyD8bT9coHm5tcJMqAz349eajhtdooVAWiMEYMg3MIIdgZYE8JtvCinX1YvO4JhN
	 K+ZFZyftSKR4tyLbQVEQuK6u5b9HEZrOQ3wRcDGP8VqMkNGVFdduCbbFi0oyQMbaH2
	 OO0lAdq4L+OoArQMYrcqkFFx+t3QUBSj3MDdQJHSotBYdDdjcTNml4J/6GWYsViyh1
	 U2IKlnPQm4B1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D55CC6B14;
	Tue, 13 Oct 2026 13:36:55 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 13 Oct 2026 10:36:45 -0300
Subject: [PATCH RFC v2 2/4] lib: test-kstrtox: add E notation tests for
 kstrto[u]dec64()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-e-notation-v2-2-d4adb5e193fc@analog.com>
References: <20261013-e-notation-v2-0-d4adb5e193fc@analog.com>
In-Reply-To: <20261013-e-notation-v2-0-d4adb5e193fc@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791898614; l=3656;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=rzm6uxEz8IPmN2aa0hSMxqOA9+DKXAtlnD62lXnmQZs=;
 b=o4nlDyKEq54mOPkJxtrRbjJDWYmmI1odBKv/Ujc6Il0xJCdMDV00arWTcJdZ1GPfnSfQ3UyX1
 2e4Q0L/PnrFANlyOXEr5iD6UfElyeqMG12NznX1uCE3XW2WeHXtp7NI
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
failures for overflowing and invalid inputs.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 lib/test-kstrtox.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/lib/test-kstrtox.c b/lib/test-kstrtox.c
index 9255234752db..02f42a12647e 100644
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
@@ -801,6 +823,17 @@ static void __init test_kstrtoudec64_fail(void)
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
@@ -853,6 +886,21 @@ static void __init test_kstrtodec64_ok(void)
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
@@ -881,6 +929,16 @@ static void __init test_kstrtodec64_fail(void)
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


