Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793015664;
	b=tyX++fkIqI3xGjwHJqc0s/ob4F9WR7mdmt8ofFwOZt8z+Z8W9ZvLHG049TaqTG7jwAu+
	 sg7v1B0OqeF4WTmRmkZWlkhpKgwpZpaf4+6IJqQISJi/ftyn22FI4pHHYO4ngXaeq4CiH
	 JH14CGdP6W9aoFJ8S0rNkhJvXJXgbKAZRi8ky+RysUFdhdFOtxxP3gbOiTJ7CRyQ8Vf85
	 KngYLXa6UBe5uieDyXlPsPp3zrIXtmF6k8mdp00w77HA2We9pIoJJOrER2yRYEA7tbgB0
	 kiI1/tFoSSaBe2CProuSrHLqC9GP1CTO7vUqwffIsf+5dHG690W4ikhGsEU4I5wo9Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015664;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ktRNZesHRccRHBwF09JygqhYIl4AJYtuEVC88nwGDxI=;
	b=4PiY4mWwDOklucNZ8fLWSpoQxtbtSqsxMeLe7LTF9k3rWspG/hEQltANU4QA5ikQTWOO
	 Hw+/oanQ5blWDTZr0Bxism/SoFxVQ0BCXkPBAe54sbVwzr8S9NPZMYAHztdR+xDgtqugz
	 fbJQkL/2UzkVXBmNIweNpc/qfeFwOaY7MJ3Y4x87qu/vQwr08jwWODHcS3LTGkwbXrBQm
	 +8ZDsVYC2PDHznlgKk+9JKhu8JCiz1qhIB6OMj+JZTd1A+28RUUmSPiyzsXtv5VPPagJj
	 XU1Kz8bmiU+VXWtD6vCIgH6KfKHV/SsgVkSq6Q/CVHpt96kO7YQei0yjv63UH5yTm/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OE3YuWON;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8208260A261D;
	Mon, 26 Oct 2026 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OE3YuWON
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793015664;
	b=1ZS6kA+W/VjT3NYK2X4o6QMPTbK7pPWtL3VF6racAJgJLFJpmZDGh95bCHcGQYF4zkhj
	 O7wa9lBbVP43bvF6eu0pw6+DzJAU83rE60q3IN8350SB/5AOltZyxCziLvFxKwNL05vfq
	 yizsUz9+zPbwExAOrsN+n5odrDMC+Jf6eZ5uTMmFAKyUSnIUvl02vj4Idq74grMEtKxge
	 eE0Wt23egdeN7OgFzZ8zbXVhtwelA13uVfZvAHeJtWEVuh4zrAoTWROPjc650Ot7m/c6g
	 5n/FqT0F2eGhUlas68SAF6+RPGAy7v7jNqY8Sd20ealBazGoJWkD/VyIYXTD5HhlM8g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793015664;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ktRNZesHRccRHBwF09JygqhYIl4AJYtuEVC88nwGDxI=;
	b=CRFsG5V41D8wArDk4OiQRo4FjV5GMcDzsEVUQ+TLr2F6yKlgBZLqVk6ptR8s+0RF7uZL
	 0OKkykEzTFRo7bqCr9KOor4YmI3FgNkemFkN/w/QVOcT3mHulmG6pIuoDDUBo/RQgGCny
	 S95bKtHzRkHIBM8VNzc052Z8U0ZvAKjN1BOfeFiqwjndKOOlWjFzGwC4r1gmIc2F07dGw
	 dKNnvnmxAjSPVFCC6DGvnFV8bUxpSN1MwuUsEZBiMH1nN/jUPJtLs5FJvkT/a+b7v5GyL
	 PLGKtMNm5zbjWv9Ap+npxZk4+SVJqFmDv4zfOQhOc8tBBao7Mc0Pgb0tiuiIjJ3U3pw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7A50C1F031E5;
	Mon, 26 Oct 2026 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793015664;
	bh=ktRNZesHRccRHBwF09JygqhYIl4AJYtuEVC88nwGDxI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OE3YuWONuCS/C6+SqjDFc+YgVSGY7ibSVEsDOK3huzmwgWHMFFIqZRoyehVsCdcd1
	 g8V7D0tR1uHZ+3ywHvYVRoiy2vLPcC0tQc0NFcjHJPYaVgl5oent0SlvbW6Ti5EPVy
	 7wNivr75ve7ugJotlAWVBk6v8lj48CaUHfY8qPeCPig6BGKifRGTYBR457Fvbm3Rr5
	 5CFYtd9eIMXJIUPOajNHgJhJTcrp1muJ5nktWMVi2oMpTfXAreCx2jEhvweMyXNju4
	 McMGu3lrKVZhg3GLYIcBvHtsqfCQ6BO9B6fuwGmFQFs6lf6mpinxU2XVIiP+8Vq7x3
	 VgVEF1FYS9vPQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F306744CEE;
	Mon, 26 Oct 2026 11:54:20 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 26 Oct 2026 08:54:07 -0300
Subject: [PATCH v4 3/6] lib: test-kstrtox: add E notation tests for
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
Message-Id: <20261026-e-notation-v4-3-a366a6d14d57@analog.com>
References: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
In-Reply-To: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793015661; l=4105;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=AplilCw0/lgZtXwyKRUjI6JAbU6gbrQk+IIYLQb21T4=;
 b=34D9hB0iVYW1857tWE1NPi1VxrCzJ5TPLBL0PjZyg/FuJdSMTQdj3043SWfISMraC6L6gNbVY
 kbAdN7XZqpCBA2CE/mHUbwE4/9l9P63BDB0X1IqqvCXpM3t8iQpO9Ju
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
 lib/test-kstrtox.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/lib/test-kstrtox.c b/lib/test-kstrtox.c
index 1f176b232085..a0c1e4286fd4 100644
--- a/lib/test-kstrtox.c
+++ b/lib/test-kstrtox.c
@@ -781,6 +781,36 @@ static void __init test_kstrtoudec64_ok(void)
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
 	};
 	TEST_OK(kstrtoudec64, u64, "%llu", test_udec64_ok);
 }
@@ -814,6 +844,17 @@ static void __init test_kstrtoudec64_fail(void)
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
@@ -873,6 +914,27 @@ static void __init test_kstrtodec64_ok(void)
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
@@ -903,6 +965,16 @@ static void __init test_kstrtodec64_fail(void)
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


