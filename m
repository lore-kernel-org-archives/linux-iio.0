Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508E7392C34;
	Sun, 24 May 2026 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779618940; cv=none; b=KMZyje6eXGdwS3gV1OBhDpAPhIrW2WBWc0Qi05H3clKhNAOnDn1/DOpM+XsauKxA6GwtrpKDWDKv3fUZhnXgsszfa0DTQvV4o2K4/meka80XRQ3oQnEkk3kXa8H8LHl0uBgUYv0707oa3DLupTEbxucucSJycMhgl9+P6p2b8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779618940; c=relaxed/simple;
	bh=aM5yeD8D0EpZb33GZB7QNZJF6fH7o1iaBw8tXcjXvyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxEghq+cOrl34wQ2bQc03qohIjcAjFaLty1o5LmXfg1Sp4JSW2yQkvLGQnHhD1TZ73N6j9Buy/iGUSWsl27/1itnbI2BKavVWfu8WHvqzTq1TAJDFZ0pKuZwyPyaM434gyhLtEXjlctLJuj1PfzTGuY4nIZnxzVNd5mib5M4KJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/OO9VH0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/OO9VH0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BBF6C2BCC7;
	Sun, 24 May 2026 10:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779618940;
	bh=aM5yeD8D0EpZb33GZB7QNZJF6fH7o1iaBw8tXcjXvyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I/OO9VH01hnG+df/CbCh+eNo5mwiSV8Oczyq5l5I73XljFCIdMm74qQzvm8z/MMkN
	 CE8x4/WncGSfDBjJz4MYeT4lii1f4GALyfyt4cWqcZuvQ/bqdg4MDce5uOAD6Ki4Zp
	 BshnwwUzu6AV3KwiEVLcBZWmWj59sqz0+HwMJTbhSYHqz8Ouu+2dvb2M1SwKEc4HaU
	 JGJArZmKLIBI05ti6hahFjCr9Q7d6M2ITL6gLjhH2XhRpMLfbXoXf5+HWaDEoxqCQh
	 0V94KLYyUXM8+q13qxAAcyiorVQvuxVgs1To8ZBHUtxyeDmrgysth6Ug2dzisnO4M7
	 AjBIwOzUfwoyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14052CD5BB1;
	Sun, 24 May 2026 10:35:40 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 24 May 2026 11:35:29 +0100
Subject: [PATCH v14 12/12] Documentation: ABI: testing: add common ABI file
 for iio/frequency
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-adf41513-iio-driver-v14-12-06824d9c15f4@analog.com>
References: <20260524-adf41513-iio-driver-v14-0-06824d9c15f4@analog.com>
In-Reply-To: <20260524-adf41513-iio-driver-v14-0-06824d9c15f4@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
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
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779618938; l=2211;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=swStfLGThUgetsoO5JlOQerjXKGwa5yLnNDxX9LhxH8=;
 b=vcNBy1bbe4a9BDWIKJQ0HpKtDNpgXoM6XodHmx5mFs3MzE+jc57d3CUJv+WNKxZDrB5LUvf6B
 DpPs4zj9mBoC4h2ePxmy15sMDi+vjUbeUyqA2lA4qjX1voW7PMYRDPa
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add ABI documentation file for PLL/DDS devices with frequency_resolution
sysfs entry attribute used by both ADF4350 and ADF41513.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-frequency         | 11 +++++++++++
 Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350 | 10 ----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency b/Documentation/ABI/testing/sysfs-bus-iio-frequency
new file mode 100644
index 000000000000..5af31b5b3a19
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
+		frequency. It is assumed that the algorithm that is used to compute
+		the various dividers, is able to generate proper values for multiples
+		of channel spacing.
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


