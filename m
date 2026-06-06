Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70B3B27C1
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777637; cv=none; b=HW2LvK+oOS3S7qUQqHO6G3JnnCLkK8auNujYKbQunagKQ1nbRhcMn0xU72uW6gq2izgaF09Q+cJ9/mBcIX7tC/Y5mtr7oRo8RIlaNV9VDjQE9Pibu4/PvITTA1enbSJXbK+FUVYvum8xRIerjIbyKuJcK7Ac0y9Aq04tZF44DUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777637; c=relaxed/simple;
	bh=eglQ29KjcUyUoliSnqiToaYBZpFLE5z4uWFZFX36uNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XSmg3ZR6RMAyjaI5g+FtRd+S2/uOyYnp6ySNFc7NTBSj3eYiiIwYoaA7w5RH9Ewx85JTA0fVvtLQlCRq697s7SyWM9nEV6Z4aVQn7yKj7WF7DMhTfVVK0QU2nQCM1MUigkjtx/7YawBSk6FEj1Rzn5uskTslMpVpqgvvgOSKEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=br9IzOQ7; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="br9IzOQ7"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbq-007NPt-Pv; Sat, 06 Jun 2026 22:27:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=VzDFyAWA7ipw3/Qre8CPNMhpRDVhgAkhx4KXGyrUHmo=; b=br9IzO
	Q7si0GGllE+m+9fp5xvFu5MjQusZyQ0BbqBMmOJJhf9h1lxwMniqTZlKPKr76oOUf4OfPq8PYNXiP
	35WrQCLVGvjhxcvgNUI2gMy9GoNehqQdapYTmGVo6BDVMtJLndhISRcmBxY1SI2GlFmfn0y4tT5xn
	HtaGGyAjejgMXwlXplH1GTuIxO5m0/QO65AOOBb6KI+J8WZdXXUPjd52aesnOMvt/c3BCJSbvGpxz
	1G9VKV47y5dQShJTC7ngH74HohfODvlHR5In4kMwfvV6bxgbZt3gr+lwKvq63M3IKlBK6/99kz4tK
	NCE8RdR0OP8RWHpsMgT3/C0HySpA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbq-0000t6-FT; Sat, 06 Jun 2026 22:27:10 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbo-006V18-AX;
	Sat, 06 Jun 2026 22:27:08 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/iio/test: Use strscpy() to copy the test description
Date: Sat,  6 Jun 2026 21:26:31 +0100
Message-Id: <20260606202633.5018-37-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The buffer length is known to be KUNIT_PARAM_DESC_SIZE

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/iio/test/iio-test-rescale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
index ac6942cf1e44..bcd4a607be19 100644
--- a/drivers/iio/test/iio-test-rescale.c
+++ b/drivers/iio/test/iio-test-rescale.c
@@ -575,7 +575,7 @@ static const struct rescale_tc_data offset_cases[] = {
 
 static void case_to_desc(const struct rescale_tc_data *t, char *desc)
 {
-	strcpy(desc, t->name);
+	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
 }
 
 KUNIT_ARRAY_PARAM(iio_rescale_scale, scale_cases, case_to_desc);
-- 
2.39.5

