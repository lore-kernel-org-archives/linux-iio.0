Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747B4481257;
	Wed,  6 May 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076530; cv=none; b=KQ2c0B3dNyTWrCs3E7ntjtkCaaisqmgDmRg8RH2e0KuQWr8D2ohgZFu+YrusUjprEDjoN9IJ+o4kG48UuTS0YdS3egXgwahcXCZzCDSlMu8XIPDCHSFxFK/WaZgcWzijPpJVbptA/UNUqa4y2thK2cvZexjeQfWZynqIegfMh+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076530; c=relaxed/simple;
	bh=9B+csSwynGBtD47HQVlSlvUhKYSoSrYkjk2oqbGoZOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L0ZDlGguDeGd6b/o7EaHO+JP1N48iPqHzstIhBbDsQkXr5xLk8Y0pbVU/5LDULiNA7qQbfzVx11N+ObKDkZsF/ki2qvEF++EHAPvCQMN/lI2KHYxB5J+FfXq7pI+oWfbIZ0t/JsiT2+F2JF9kEG1bc65jhxSOO2g+qYWl+XX/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZGa5BjG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZGa5BjG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50F84C2BCC7;
	Wed,  6 May 2026 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778076530;
	bh=9B+csSwynGBtD47HQVlSlvUhKYSoSrYkjk2oqbGoZOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uZGa5BjGg5OKldx8lpIXozgiH2nZyb0hQjb1GNukJVNoWMn+DKB1asq+jSNfdVVur
	 GuXAId/5k7pIIb8b7d/sQuNQ//34SzKjd4uqxGxTifNcWMlg2XQ4WmmipCHk/IE9H5
	 YKpFJwR3kyGSAjGMZfyFmMZghwMX7IrkPrKgxIHvz/gB0P3OjsmSS6lwAWsaQt/sUC
	 fh37oErnFlzxmrj3FDwSnAKk1cpyUhzr0N5H2XPQZ1679yJN73uS7F3HYZRuOreUt6
	 PLCaELpDhxe+yvNlUHULuyGGReD2L7bqpfHIyyHMsHVHYDZuVjY0uVhDDWq6KzFsdX
	 VAOhNKOIVUB3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A03CD3440;
	Wed,  6 May 2026 14:08:50 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 06 May 2026 15:08:55 +0100
Subject: [PATCH v11 11/11] Documentation: ABI: testing: add common ABI file
 for iio/frequency
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-adf41513-iio-driver-v11-11-2b7e99cfe8f2@analog.com>
References: <20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com>
In-Reply-To: <20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778076527; l=2210;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=OhPLAamt4hmbeCatH+/iPHehi/HIntujTnWeOacWI/A=;
 b=kTTbMUiAf49pPUCmIBPzENiDCKmGO9NF4lK5Ghus5FmWNZTYmdW8kgGvTdMUfrfWT4iAm8GaS
 t67HmhZKt5jB3kEC3RmnIYGuAV1g/GOrorygpdNrdrvx/JXpVrXst15
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
index 000000000000..1ce8ae578fd6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency
@@ -0,0 +1,11 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
+KernelVersion:	6.20
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


