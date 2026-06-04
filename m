Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174E73FFACF;
	Thu,  4 Jun 2026 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567184; cv=none; b=Pp1NjYBtZIFpayS4+RA5OnMj5e6LxWOsBfliJPSzSbr7r80e/nI9PdYx5unUGncFUk1BsjJwr4aLqfk2YJZ48OZUYB77P0bN2vUbxV0IcdK1okD3JKtUL6QyRH2G8GsjCwa7l6akRvZ6sABtABlX1wYh4xfCuUEa/ezc+Ju6DfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567184; c=relaxed/simple;
	bh=ohJeTMjeku8t5K1ttdN8gNNUHwPn/uHTPp9sLxXmVtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mqErJZaoD0wncSEZDo8pvEheQU6x/KCr8p0MrW+xu+OTHdbudGy3xgU6deYGaZ6n94wAniSp1bhh3WuWpgLtqW/xx9Ey0KnSfCL7mA4s5CWqJ+jOkuSNHcQFv4D5LARhqt5ikFJUEEkxP3Zje1aSJSZyKPSuVzihb1bRwZTPGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmpneUHW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmpneUHW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8C49C2BCF5;
	Thu,  4 Jun 2026 09:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780567184;
	bh=ohJeTMjeku8t5K1ttdN8gNNUHwPn/uHTPp9sLxXmVtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZmpneUHWJFdRqZjUpBQ3Ocp7ks5Yuc+aQVHAIEeQD/J0ZPJHtlr4G7XpsWZl9kClC
	 3WGSrhb4vwP3wTNef/DKcA6J7bkRfzQ5DxC0W6bf0cP5S8js95+UBw9yjRQmicsFlB
	 6Tbu2sfC79E+pg83aGnHwmer9jUCz81AeQ6VzelhymuYCLfi9wPflX5vPytLUFiS6K
	 72HQazdLQJua+4OZH1/LAHChW161UjFJYYuInh9OLj7BJzegvkGm/Jk0SERBZQwCNx
	 gJG8zte7+7WcxMeu/PX5Xt/QznEqdA0M3sNTxFp1zjnlQqT2jwoavXCIYDzr3SxYAF
	 pCDj3ynQNGLFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25F8CD6E4A;
	Thu,  4 Jun 2026 09:59:43 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 04 Jun 2026 10:59:08 +0100
Subject: [PATCH v16 14/14] Documentation: ABI: testing: add common ABI file
 for iio/frequency
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-adf41513-iio-driver-v16-14-1a7d09143bc2@analog.com>
References: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
In-Reply-To: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Randy Dunlap <rdunlap@infradead.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780567181; l=2255;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=nzu7TWbUWAeg5jcOBjag0rSTFAMHqoxs8t5VMBJbick=;
 b=M4nvx4k1Rb125zc36f8u4baelRx9CUDtvLssQK5aNQhlzyYeA5VeY8rVfoXWD6FYwSs8qzF/1
 m8BWzlSWZAqCkwMgpNNF9/cn6ercQZ5FRQiNdOSCffdDtdvgMjOR7sg
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add ABI documentation file for PLL/DDS devices with frequency_resolution
sysfs entry attribute used by both ADF4350 and ADF41513.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-frequency         | 11 +++++++++++
 Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350 | 10 ----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency b/Documentation/ABI/testing/sysfs-bus-iio-frequency
new file mode 100644
index 000000000000..46075aee7804
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency
@@ -0,0 +1,11 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
+KernelVersion:	3.4.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Stores channel Y frequency resolution/channel spacing in Hz for PLL
+		devices. The given value directly influences the operating mode when
+		fractional-N synthesis is required, as it derives values for
+		configurable modulus parameters used in the calculation of the output
+		frequency. It is assumed that the algorithm used to compute the various
+		dividers is able to generate proper values for multiples of the channel
+		spacing.
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
index 1254457a726e..76987a119feb 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
@@ -1,13 +1,3 @@
-What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
-KernelVersion:	3.4.0
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Stores channel Y frequency resolution/channel spacing in Hz.
-		The value given directly influences the MODULUS used by
-		the fractional-N PLL. It is assumed that the algorithm
-		that is used to compute the various dividers, is able to
-		generate proper values for multiples of channel spacing.
-
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_refin_frequency
 KernelVersion:	3.4.0
 Contact:	linux-iio@vger.kernel.org

-- 
2.43.0


