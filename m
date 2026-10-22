Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677845;
	b=0Dkt9SyiON9KzFLD23sVYFZ/bxeYsT0Obof7vk/jNqOuSj14kCP1k1sWwz66QN6hx0M5
	 1QkycaNgG8IWcfGfzBc4jbn+uCqPVYrNz0TyLv3YbVsnyfLT3vfHT5dFmn1V8TuYaj33r
	 pRSvPkRczJejnQrR6SoAuwhcc1Obcq3iln7oq/dHfjSdHDgDLzetA1w8yw7VTsymCv0kM
	 enlnuyEHHL/nidrmJvMd8vKePCwOYOzXiiXEGpFeC5YWXM8c9aY4OGARy1oSma9Y64rB6
	 OIpFB9MllQeBjH1dqCXdhlKHqPxnGbuu9xHzrK/sQMqvU2PXr56GV2LWuf4tw+M1nlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ycKvX8Drm1ZvoMRZEoe3zfF22B1tSstY8gdfVXXNT2o=;
	b=DhJLnO1h9jf0EgIFAA3WvAg0X8eWMTGPZ4cc541N6RNrjE0g1W5shDB2KoSitm2N3Thb
	 BM3SyvT7cjSiiBWt3FxAdHeGMJF60fZFJ3Vvd2ZJ5pQiBcPXhp9Wj6nnTQsUdpm2Tcdx2
	 G3DgK4qXd9aLb62Njrk5LOtT4C7sZbldUVpyhCC/8X+WjqAHVTqDnLf4l1pSqxI2hPZxM
	 qRWrdzNp3P+ledqQXN+tSewjG/MBMzmyTScIU6cHdGiWDdmzm/uL5H8dwjzPxKvtp1yEM
	 Fk/XuJxc7c2uADF+g2AmTxj6lfSwYnSRFOiMqaIX2Yta4lHe2k/jr5lGxrtHuwW79bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q95dGijh;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83146606A320
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 14:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83146606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q95dGijh
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3535a54bed9so2735904eec.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792677844; x=1793282644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ycKvX8Drm1ZvoMRZEoe3zfF22B1tSstY8gdfVXXNT2o=;
        b=q95dGijhUGm9T1dwFklOpJTx/iF0HiZFgjud+cS4Sg5sFeT9+W8vWya5hwChqSXB75
         z/WQRL9/6FST/rhq442VSSKNP4p+OetPB2VySobRXniMJHPeC5sG+5Q5+VW2F/foSfpC
         UosSq6a+hv0qxeuGz9eXy5LyWThJdsOolklkXIjApMXk6xDFPnD3LOrY+iaPMRl1LNEF
         /QBQXOKE6o/+6utD6/7AjAjzDdzK60vnGLjQ0LB52D/TWKUThJeqhex/Dec51e8INJJ/
         9OqMY1Zj8MmqqyuCSIEBBxZ1FE/ygnVPlTOKQ/UQ/S26xzkroyURc0ieJjIVaONN3bDP
         oDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792677844; x=1793282644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ycKvX8Drm1ZvoMRZEoe3zfF22B1tSstY8gdfVXXNT2o=;
        b=iK3u9rmtpojbKxkOMSEpEbOk5qw9yFMKdU6LYF3gNs2f92DmBt7WMryQPnGUxNtW/F
         KCGMkbWHqlnaJj1B4jg6P/Yh61Q6cIkMFE0zU08XgKPPKvNE9JLW5jNwTQwq8WXpY56V
         NjE4jdRlKmQuuXDCX1CaNt6jIwJ2nDdnWpYRYmSU36wfgMoBfdKdbQwqIk6bOdhnjs/W
         5ggAuyT2xor6Ye4UVK51AbPjUQ8alqVTia9FqSTl9y97xg93o58dWDKryii3ynk5lm4t
         uWjFhj/KhRXvsQd1d2+F15Deye7pYFIr0B7mUKZ8YK2j1DU2r11UTUBWqkayue6U+Ojz
         f2PA==
X-Forwarded-Encrypted: i=1; AKwUvBzRQZ4d7mdOHeDW2C0mWFcW1zqA4RgxsmlHHuy9FgRP4Orh2zbfQN4NT8AN7XDtengVf0E61yeDDvo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJerHIAw/pDBOX7405w+rCEjSSmfP3YPhCmuxVdjaDT1eADNyZv
	dcM+yXpjSAoh6KN28Rs07WlzgIql3fzgNSEu3tlaEaAI9rFxL8kbWhCL
X-Gm-Gg: AYBFou37kLoz97SgfphfUiVw4mBF28CWyxaYkz1FgSHsHyuq6oWHmtehF6Iv+2dwelc
	NMJD4uKXHLo5J1JyufnmoR98reQQrHO3zgff+kfiBFnJT+yHmp/0zKUlphZcRHVNsUkqmSDddEq
	cXGgB1JjD77N3+7yHEZsb7q2gPU4OE1zO/JiERKMlaAhFfWVgOhgRdqUdGZMIFujkLWYn/pS+Fq
	OHC88kxT6Hlfo7kPYl++82yccaEtFpku1lDgDToXYkq5iCo8SylH4n345VKTj/XpPeZ2xVRM+78
	zRocyEw9/CsVn0NK88HqCkEJyXBAFKPmb1z4TgXV8WQfiG7gQcURdIBWkEG/4R/k6fks82upfcm
	ughLeF07vwNspUA9SrbeTH8auJovpGHARrYWhGpouK47xZkFsP1inS1q5jLwg/HXKwwL9A+X8eo
	Z6zaqnjLkWVmTT/ATYm5ZfMN1BiIuy0uGnT+G01xVnhHt9jFnqf6796QKrpt8GuYHnywN7Ef4Dk
	KHB/tsexS8adfkCQ38QKZRnHrgvytvpYo7wkf4X0E6p3Zr1oqHNu+bulWKKDtpwsyZiEeg1C5HE
	CwZHQog7lw+P8zQygXJvliTbsDeXSKzzZcBJ1O9MPP83FG+GuwrC5oagp1fNKQNRYU14mPfTGJ1
	u9cvuWSwRMo8=
X-Received: by 2002:a05:693c:8399:10b0:35e:f1a5:9ba6 with SMTP id 5a478bee46e88-3674a40738emr7987837eec.5.1792677843191;
        Thu, 22 Oct 2026 07:04:03 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1d8sm24668097eec.24.2026.10.22.07.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:04:02 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rodrigo Alencar <rodrigo.alencar@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2] iio: core: fix signed integer overflow in iio_str_to_fixpoint()
Date: Thu, 22 Oct 2026 19:33:51 +0530
Message-ID: <20261022140353.24213-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__iio_str_to_fixpoint() accumulates the integer part of the parsed number
into an int. Feeding it a string with more digits than an int can hold
overflows that variable, which is undefined behaviour.

The parser is reachable from userspace via the writable IIO channel
attributes, for example the "sampling_frequency" or "in_voltage_scale"
ones, and via the exported iio_str_to_fixpoint() helper used by a
number of IIO drivers. A user writing a long enough string therefore
triggers a signed integer overflow.

Use check_mul_overflow() and check_add_overflow() to accumulate the
integer part and return -ERANGE when it does not fit into an int. The
sign is applied while accumulating, so INT_MIN can still be parsed.

Fixes: 6807d7211327 ("iio: Factor out fixed point number parsing into its own function")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Changes in v2:
- Use check_mul_overflow()/check_add_overflow() instead of open-coded
  s64 accumulation and limits (Andy)
- Apply the sign while accumulating so INT_MIN needs no special case
- Drop the unrelated parenthesis change and the explicit casts (Andy)
- Add Fixes tag (Andy)
- Fix the truncated subject line
- No KUnit tests for the current parser, as it is replaced by the
  E notation series (Rodrigo)

The fractional part is left as is: with the fract_mult values used in
tree (at most 10^8) it cannot exceed 999999999.

Tested with a userspace harness built with -fsanitize=undefined on
inputs including "2147483647", "2147483648", "-2147483648",
"-2147483649", "99999999999999999999", "-0.5" and "12.345\n".
All inputs that fit into an int parse exactly as before. Compile-tested
in tree with W=1. Applies to both togreg and fixes-togreg.

v1: https://lore.kernel.org/all/20261021225306.623361-1-kapoorarnav43@gmail.com/

 drivers/iio/industrialio-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d73f2541375f..f3bf17c13cea 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -25,6 +25,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/sched.h>
@@ -1027,7 +1028,12 @@ static int __iio_str_to_fixpoint(const char *str, int fract_mult,
 	while (*str) {
 		if ('0' <= *str && *str <= '9') {
 			if (integer_part) {
-				i = i * 10 + *str - '0';
+				int digit = *str - '0';
+
+				/* Accumulate with the sign applied so INT_MIN fits */
+				if (check_mul_overflow(i, 10, &i) ||
+				    check_add_overflow(i, negative ? -digit : digit, &i))
+					return -ERANGE;
 			} else {
 				f += fract_mult * (*str - '0');
 				fract_mult /= 10;
@@ -1052,12 +1058,8 @@ static int __iio_str_to_fixpoint(const char *str, int fract_mult,
 		str++;
 	}
 
-	if (negative) {
-		if (i)
-			i = -i;
-		else
-			f = -f;
-	}
+	if (negative && !i)
+		f = -f;
 
 	*integer = i;
 	*fract = f;

base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.53.0

