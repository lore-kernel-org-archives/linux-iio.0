Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F7409125;
	Mon, 15 Jun 2026 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538700; cv=none; b=p7h0b8TJcYcGARg/x7Q72hoybhLJq7fdbkalpx+37ad0YCMrR0d7OIB1ROeTBQ8g5RqXMnewcZTh0Uctf0UNeGZXQ8pwgJ7ze/IdDcbyrvw2hTgUsSbe9UiX8H8L4NOQm9ztHTXSHy6Rx+4GKMk45e1t5x2Mksf+qGar+3NONzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538700; c=relaxed/simple;
	bh=o9y10VnM93lPRoLx9FOVkBiBv6zDdDSbwvJZagAvICQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NLtlV5pT3rApw+LNjnXdnmJe+U5TVBbM+mSUtBpnvaJv5oOBRnwifnibulNnOLUi7oY0jCq1OFpbDz1GMan9JzOpI7kygz/hROaKkHhaRuJ/gldXAjJA9kkrKDt+TVpOvNPbLFM8dbfGcamZC7DXUQgaeLqsBp7VaW64ehOxEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMnyYyY2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMnyYyY2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFEC3C2BCB4;
	Mon, 15 Jun 2026 15:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781538700;
	bh=o9y10VnM93lPRoLx9FOVkBiBv6zDdDSbwvJZagAvICQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=sMnyYyY2Pp8PblqtsoclarHLbQolxXvWyPUGsUR1t5Jntqac57l1M7Lz6kipY1tCd
	 SRNCvIsRMbyFk2X7A/LPMuL3xzC4wFCl3nWtLTINcLZfF0rS0H08PULHSZiPIGSBOC
	 pZWzZAlRmB0zwEWRUvp6QMxAPByw0YfdAosNY9dZummJtV21DDXuEMhO7XsRwI38HN
	 xkz5P9LPifBPlS0PyPJyWjCiMLX3epqfIDOjtml4yoaF+cmz8QzNi/xmcc3EF9fxRX
	 bLYT2avETZ2WFC6tUshrlWpNIsSlU67J6jpV9KYaljg+wNdy7dhGCzbkoThTWPzsgt
	 oRmB3FzHCCp6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CB0CD98DA;
	Mon, 15 Jun 2026 15:51:39 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 15 Jun 2026 16:51:15 +0100
Subject: [PATCH] lib: math: test_mul_u64_u64_div_u64: define div64_s64_rem
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-test-mul-div-u64-fixup-v1-1-ea186d825745@analog.com>
X-B4-Tracking: v=1; b=H4sIAHIfMGoC/x2MWwqAIBAArxL73YKG2uMq0UePrRbKQjMC6e5Jn
 8MwE8GTY/LQZBEc3ez5sAlknsG49nYh5CkxFKIwwkiNF/kL97DhxDcGo3DmJ5yohdS1Il1Wg4I
 Un46S+Mdt974ffzi4kGgAAAA=
X-Change-ID: 20260615-test-mul-div-u64-fixup-501594e578b4
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 kernel test robot <lkp@intel.com>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781538698; l=1290;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=3SgBmMM2VffDRtuuezVRLfHjFVAyTOp0L7/XpgDfV7g=;
 b=9HkwyBphFaKPg7JgRsEPuVVqwzST1uKecopMKi4R7lg35cwA9c7HttRox6AXpByqGLpGr6qKm
 v+llbLZna0OAy4owfzHATkmHksIg5G223yKqQYiOlwWUAAiIzVmO174
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Define div64_s64_rem to avoid multiple definition or exports.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606152154.P6pwbjhp-lkp@intel.com/
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Recently added div64_s64_rem() is causing issues in a the
test build. This could be a fixup patch amended to:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=adebf76278116a06166d0b5f8b4112ad5dd6389a
---
 lib/math/test_mul_u64_u64_div_u64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/math/test_mul_u64_u64_div_u64.c b/lib/math/test_mul_u64_u64_div_u64.c
index 338d014f0c73..d12dc05938fb 100644
--- a/lib/math/test_mul_u64_u64_div_u64.c
+++ b/lib/math/test_mul_u64_u64_div_u64.c
@@ -157,6 +157,7 @@ static void __exit test_exit(void)
 #define __div64_32 __div64_32
 #define div_s64_rem div_s64_rem
 #define div64_u64_rem div64_u64_rem
+#define div64_s64_rem div64_s64_rem
 #define div64_u64 div64_u64
 #define div64_s64 div64_s64
 #define iter_div_u64_rem iter_div_u64_rem

---
base-commit: a50909aa46dec46de3c73235fc15a7d6f763d996
change-id: 20260615-test-mul-div-u64-fixup-501594e578b4

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


