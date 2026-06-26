Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237993ACA4A;
	Fri, 26 Jun 2026 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466536; cv=none; b=mwIuKLtFZ0v4/X5o3J6wTzMUEcfKoANWC2hBLjOtAB+DBFF/l6ZGjdhz2bw/cSU3DVRwea9MSS/HtOeb2916cgl4hS5SEoWvlLbSazzBNsMtnVVfbjofiy19AGOSdWwqwOLRwa67Zp2X1kGzt7iO2/tOgVJcuDXS9AQH7hYasPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466536; c=relaxed/simple;
	bh=441g3ydaQSHbnwA/gzperALs5OtLqsgcZUuQFLjyrKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WkoBFN6CbDXZ3Rs0AqODFSyYfxIpEFdQj2fLLkCD3c5MRSGWN+1YY/0v5DkKubWMTxNytJHudUVrCiTLBt+qoGtGXqDFuRY+imV8SPnF+vVdOGWFGzxBz1FP9zDXboJYFqjYhm7NHMY6LYUEVnMGv8WsfwbWiHI+o3hJlVClnpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qF3JFb1m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qF3JFb1m"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94CB3C19425;
	Fri, 26 Jun 2026 09:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782466535;
	bh=441g3ydaQSHbnwA/gzperALs5OtLqsgcZUuQFLjyrKk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=qF3JFb1mbvM1WPBW1Hskxdfg2kjKE6Ox8ilMb8PsX4oxCAfsjlWxtEsFzXRnrifhc
	 u1SZFX7W8usFXsEr02hwA70iyaUWQGcwCk/bIh/Katj+LbZqrWWS6MXv39/tVIeWph
	 IoaoEZuB0iFtww9zIOBI7GN48S4N2Id5iTK1wJDp7Eqk5vvXOOvHfeyxT5eWkEh08O
	 ohzLX10rCbqjbvGBVsmnplY2p9QXSuW7t5pkBfxywP+BP/oTzLb8VXI37jWtlE8UGh
	 vvymgId8fiB/QQNB+dlsA7Vtt6cr7F1JUY87rCsos4V5awjVuAXE4GZ3HU7LLHpCcD
	 fdSdWl6pVPgKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECA7CDE012;
	Fri, 26 Jun 2026 09:35:35 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 26 Jun 2026 10:34:51 +0100
Subject: [PATCH] lib: kstrtox: missing parameter description doc fixup
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-b4-parse-integer-doc-fixup-v1-1-25cc495af36f@analog.com>
X-B4-Tracking: v=1; b=H4sIALpHPmoC/x2MSQqAMAwAvyI5G9CiFfyKeOgSNZdaUhVB/LvB4
 8zAPFBImAqM1QNCFxfek0JbVxA2l1ZCjspgGmMbayz6DrOToj4dtJJg3AMufJ8ZrTeuD3EYXOt
 BB1lIwz+f5vf9AItxv4FsAAAA
X-Change-ID: 20260626-b4-parse-integer-doc-fixup-6b2a5cd77a1b
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 kernel test robot <lkp@intel.com>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782466534; l=1254;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=0zsOBTI42P3g2kfdlM7nlhHBpm6s1YXvENs9QIOY8g8=;
 b=kK4WFPi/iswOySotpz3urFxegMNCrRexLGmrD0b1TnoVUK2JpJQSbSNrT+/enC8Ego6OAbOZM
 1JIyq+isd6AAIjJ+lhjv/rOrPS6SDPYl3RynfiOHPzNKjpiCKFaDufM
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add description string for 'init' parameter.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606250230.etPGuolf-lkp@intel.com/
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Recent change causing a build warning. This is to be a fixup
patch amended to:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=521b4ae3b5a47cf4ef5826016eecde08e8740bef
---
 lib/kstrtox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 17357c4ae52c..bac1c057e1b0 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -46,6 +46,7 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
  * @base: Radix
  * @p: Where to store result
  * @max_chars: Maximum amount of characters to convert
+ * @init: Initial value of the multiply-accumulate result
  *
  * Convert non-negative integer string representation in explicitly given
  * radix to an integer. If overflow occurs, value at @p is set to ULLONG_MAX.

---
base-commit: 7667a80340e99fd45357d0c90ae05813b01bbfef
change-id: 20260626-b4-parse-integer-doc-fixup-6b2a5cd77a1b

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


