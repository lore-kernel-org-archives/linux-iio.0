Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6293101A2;
	Fri, 23 Jan 2026 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183639; cv=none; b=b9iiKBjcp/uSqS9mt5PLW1S9ajTdxc6p+EtlPciWl1/gTCFxzoL0Rph4GRxzPzWJ8yKLjdxbfsNlcZtxBaQqF3A64Xg+Bjw0Ly0VroG9R4X7Iu6D4P6uCgp1Dq+WyrKuPULc9iNnRSrose6Wqwkj8o3i6B1jc/yiqmDwGBIdzY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183639; c=relaxed/simple;
	bh=kYnBn0hPZJrXUXTU31Ix0gevpfaNxn8AINHbROFMUOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FR+9DIkgW8iY7ic8D6lmbDH/a75c/VPNcSKo3wOJRn9fInfhOlzOPO/SWilT7vNfDTuVojm69WhynWITXTnLPYxbBP6d9zeb7vS0bjgA/eGj+EYl0TFKJMYvlqpe/dq8MtqdNguu8iqvNXX4o7MOqN2ONZfeu1AFEmSDCfN1lu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7vr+Fos; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7vr+Fos"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D54C3C19423;
	Fri, 23 Jan 2026 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769183638;
	bh=kYnBn0hPZJrXUXTU31Ix0gevpfaNxn8AINHbROFMUOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t7vr+FosHSGaXpKKxi/Mi2wHHwSGguT/fFQzm376tC8YoAPs/pVJoT2nMfLF+++sZ
	 nkFiwOtW1wO2mHmvNyCyn6PFCB6gctMFHQ1JvCtjgYK6q198G+HjVJl1eKXKPNHjBx
	 HdQqFWoPKZzlLHPKPWPW42HQEoSfh6Sq9BvGEBagWt4BTWmCBRnWFZxDTIrBvcHWBl
	 NJyFn4uOVNyI93C3/RSxijva8P8PR3srXOrQTOaGExp3KG5Abz+v/v6Ug5v2zbHKuf
	 QklzMqa81bE0tQovHgF6qy/U2iAs18Uyycu4YWXXR6OcLzwmxRDIGJMYNRbrf5uhy8
	 inC5xF0M1rI2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA09FD74EED;
	Fri, 23 Jan 2026 15:53:58 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 23 Jan 2026 15:53:13 +0000
Subject: [PATCH v5 8/8] Documentation: ABI: testing: add common ABI file
 for iio/frequency
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-adf41513-iio-driver-v5-8-2dce812a2dda@analog.com>
References: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
In-Reply-To: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769183636; l=1731;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=67mGOWaw3wet6Ddy/uiN+nSBqKV1DJFYXkAQQXBO/tY=;
 b=sY9hFkMvphekFdXeCxn6OC+rdNYYSYMjqKaoJPGl1x4jhVrFUJsz0W+oMP63vw6d6PqprB0o4
 VRiABngTpexAYGbjNOkFOC4fD1ydbzYxtZdrOAv7b/QQwqrvHKDkWSC
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add ABI documentation file for PLL/DDS devices with frequency_resolution
sysfs entry attribute used by ADF4350 and ADF41513.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-frequency | 11 +++++++++++
 MAINTAINERS                                       |  1 +
 2 files changed, 12 insertions(+)

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
diff --git a/MAINTAINERS b/MAINTAINERS
index b9cc8ddcd624..ed39a275b7f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1623,6 +1623,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-frequency
 F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
 F:	Documentation/iio/adf41513.rst
 F:	drivers/iio/frequency/adf41513.c

-- 
2.43.0


