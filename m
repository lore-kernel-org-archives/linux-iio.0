Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463442F57C;
	Tue,  3 Mar 2026 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544446; cv=none; b=gLAayRSfUq95Svjiu4wdTj9GgqH7XjpvKuL1rgDAjBOeAW9MluO3Tp2812r16NQqgEqrFGK/dEog1TmIK9sCGgPXVFFlW0JQvijh69T9N8nZ0g4kLlKRkVF3Wba5jfpJQBIv8guB1QhYZITPcyxlKdYIRPeBcMhDhJJxbw65RV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544446; c=relaxed/simple;
	bh=9B+csSwynGBtD47HQVlSlvUhKYSoSrYkjk2oqbGoZOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RPfG0neUYHHEEqSOYnvXwZ7HMxsoZfSnX557ZVltDMjQUzW3dQ7tYp1qdK+HvECmuijkj1jnsvEfYILiQBGPdpN7q0fsjlpJH3MdZbqtf6Kr4gQeZtKf6Gg+CWk4hG7h0Mz4bcIzBeACEhuLxvRDT/El+5KRTQ9SL6/z9nNmuM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0fv+2Wz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0fv+2Wz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2257FC116C6;
	Tue,  3 Mar 2026 13:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772544446;
	bh=9B+csSwynGBtD47HQVlSlvUhKYSoSrYkjk2oqbGoZOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=S0fv+2WzqWxTyNArHPad+WOkTTPcPbu+p9lwjrVPWg5YQp5JxsMKF58roAtrAusCn
	 tJbrWdKoPr33ZsdDvHaQh6yCZz3HD4hMfGcDN5E8FfAao52BQvSf8dAJO7IeZ63XzP
	 JXyeIhEUkc9fY/p9JfzEAoh4LxkufMoKoZd1CK2Vv0JGqRw2cJ9eXJV2HckXj8GygN
	 3od00yyJjBh9wHmYWuLafy9dIWmo56sGg8q59HRf+PlUvG7iVTiRiR1t0wTTSmjfNO
	 dYqGIXXG8CLirp0llDIpu4ObxdpcHcPmYHl3io+IJfz+CpT89vxLbWb6sHpBPc7Hzd
	 ZI/vTk3vORIWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E4DEC1442;
	Tue,  3 Mar 2026 13:27:26 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Mar 2026 13:27:15 +0000
Subject: [PATCH v8 10/10] Documentation: ABI: testing: add common ABI file
 for iio/frequency
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-adf41513-iio-driver-v8-10-8dd2417cc465@analog.com>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
In-Reply-To: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772544443; l=2210;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=OhPLAamt4hmbeCatH+/iPHehi/HIntujTnWeOacWI/A=;
 b=1HLrvBUl4XUjDp85NenVgpnUhF9QEWduuqFD2Ibkb5S42i6e1GK/T6kVS0Pho6X6PDuAu8UpT
 h4llzrCrJiIAOgExN2AZDiiy63XmKIkudONA9U2pdTRqGmyGsXz/VJh
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


