Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B863531B81B;
	Mon, 16 Feb 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254153; cv=none; b=q4Ng80UPiqhzustBW14peSmveho4O0I7mHTM2Pb4JCp6FcTTsElPA9sHXguX/cwGL8s6pCmuqm/9+T/Uad3GVpN2vnCi63IuKoU8L5cnhSFz2wPAHunCLjAVYpP+EiDmrIeris3uGlA4/cQIX9YcEvyig/kU3HJoyUgQP8k/mF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254153; c=relaxed/simple;
	bh=9B+csSwynGBtD47HQVlSlvUhKYSoSrYkjk2oqbGoZOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5CfxMZzjOTmR3emtHsIR0KTSa6MPAToyID9P/MHg4rx4u/96uENKUe0jV//sYAJW/h9JJZ7pbN2dZeowa0/kh9DNAfLkD3rCd8KTZbmf7aSWbrLfNRCWT2aBGmazcYlr8kBn45SrKwQhR1jgw8lbE7Jo9wRAMSDQl103sM/9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewNkusdc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewNkusdc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81C67C4AF0C;
	Mon, 16 Feb 2026 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771254153;
	bh=9B+csSwynGBtD47HQVlSlvUhKYSoSrYkjk2oqbGoZOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ewNkusdcYdMIJYeq1FaOW/JBZNQx+dZNkrpIaRd161LolyglI1Dy95Xu6kmF0zs65
	 4m0gF3RTPwDnlfq+k0gkszCg1QSRA6e2/FR26mGQxFOFI6z380IkqFjLzCymkwhsUm
	 WD/3T8iJ/l3ZgTIi3I8aCovcSAvQ4F95/TxTr3AM99/k6s458zvhwiYm2ZAPiX2fKl
	 yJzejl6NdyuaFT9cYMuLNdgnMIyjnk9K0seaSjevseHjOIn4JaryGfc/NCAmF4FrDO
	 iquzT+SYDVyVmQW51S/ZbHXuecVG1R/l8wsGXuSIevgT7GGzA12ZvOQDxPKezaQ/eJ
	 iRsZFIx1VOTHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D38E81A34;
	Mon, 16 Feb 2026 15:02:33 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Feb 2026 15:02:23 +0000
Subject: [PATCH v7 8/8] Documentation: ABI: testing: add common ABI file
 for iio/frequency
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-adf41513-iio-driver-v7-8-b0ed387ab559@analog.com>
References: <20260216-adf41513-iio-driver-v7-0-b0ed387ab559@analog.com>
In-Reply-To: <20260216-adf41513-iio-driver-v7-0-b0ed387ab559@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771254149; l=2210;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=OhPLAamt4hmbeCatH+/iPHehi/HIntujTnWeOacWI/A=;
 b=zMWov313jJAPxJoLTV3cqUJZR5Qs0cN3C8o16gQHmNa44YhZENc6CUOLaya9XdzoG9Zr1PO2x
 HDSkg8wirb+AV5wA1dKJKRD80KQZreeW2vUu06S+l3yI1JsUXWsqMDs
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


