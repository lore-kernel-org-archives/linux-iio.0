Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADA3382F17;
	Sun, 31 May 2026 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780216298; cv=none; b=t/nriy7vWCSAXDr37GyhDvdCIGJP87xZfiC52AWFbON2Q2QJb+fjwU1uXnvzKjs+AZohlmL31aCseM3lKUmUZnIXW2g8RgM/2JxZ0C/KQgzwizyDEPTdh6EOHp3nS06tRVMgkqP3oCsMJO+bMHl4OW3lWf1GXB7Z2w3gtDeRPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780216298; c=relaxed/simple;
	bh=aM5yeD8D0EpZb33GZB7QNZJF6fH7o1iaBw8tXcjXvyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nk4sVrZ0jSU82beyLHRCT9kcf50b1us/jKgGLoCsLmDDx1ZNYa6WgxylhYrdN6T73PrhDG+VPF4Ri0nqIer1ztB2H+IYqnXQJd4ofaUPW38rzPVJeIZPeLoBGYdwRk6JGNvMks6rnuPyZ8Ob053o/rTfVqQVAPTwFRlpOGRBVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Imi2NoGy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Imi2NoGy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BFD7C2BD00;
	Sun, 31 May 2026 08:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780216298;
	bh=aM5yeD8D0EpZb33GZB7QNZJF6fH7o1iaBw8tXcjXvyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Imi2NoGyptEm6AUAD4Y7WGYoRVM36TAKAIKc9w8E4h+nPYv4u4hYjs/whcXez+nT+
	 OgnTnOKtVtghF/Gocz2RxQ2tXAQeAO+AL/scnB4dgEj+gk2FuQKTY+QxTTyIyyOGI9
	 +B91mJZ4E9uyMPQQhqUMbdMiL9q5VqZ/5aBSZW25LVP3D1oabDlKqaH7hDDzm9ZkCw
	 j2IiKWcl4xFsiTFQs+7qAVsHFWnPOUnK2Ry1gvxZjgiD9HluzptCctnKr/D6ST3JjZ
	 TXTqDiiccnmrgrZ4Hpjf6MuDbSQA10+scuHvjctx6tEO3Pa2v9DimNint+uJOp2DsV
	 Ie2s/90d6QVBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3584ACD6E56;
	Sun, 31 May 2026 08:31:38 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 31 May 2026 09:30:55 +0100
Subject: [PATCH v15 12/12] Documentation: ABI: testing: add common ABI file
 for iio/frequency
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-adf41513-iio-driver-v15-12-da09adf1c0dd@analog.com>
References: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
In-Reply-To: <20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780216295; l=2211;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=swStfLGThUgetsoO5JlOQerjXKGwa5yLnNDxX9LhxH8=;
 b=de0z8neivuKOvRMhxA4AMSelLOg/TZ59JbdehhZ3s4UNhNotpzc2ApIQoe6mRHhJisJEcPqyT
 3XqerNxsNV9AX7p3iiTsoGDbSXanHgTTVB42KmTqzB6faugh3MeeGfz
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


