Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C78350A02;
	Fri, 30 Jan 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769767617; cv=none; b=YnDsJw3vCWer95AeCMwq88zJFUBQbGcgHjdHLv6+18Rl/D4bOdif+QyQO3ZZHD1BTd3Ys9h1NkfD6j5O7l24yNaGA4uSZoDcLw2Dkko7aYn2io7YTRcAYsytwImml+s1UXHBT06aLEmJXg27Xt+WsAN2C97K8cxG+esbPId795g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769767617; c=relaxed/simple;
	bh=9p540ay1H47svX06lhpmRuFAR8//y1IqKzBTwHFPo1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FBhmDde7vkkBYxxg2ngb4z4GM7+99EV2Nf5dv4ZGAo899tG0XfrXhG55yOEJ6at7n/H1PRNzOTx7ueuGyzN4x5i9P0xKrufnFvXe0tOx8YiY9qAoW9hbwKabXm5pLIes4+Vk4QSBY6nY2e8I+QOkyUpD0xewTzgf+AM1GJxGT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgdHl2K+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgdHl2K+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FF68C2BCB0;
	Fri, 30 Jan 2026 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769767617;
	bh=9p540ay1H47svX06lhpmRuFAR8//y1IqKzBTwHFPo1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CgdHl2K+NvWxWiBvEZ4mi2V8IB+9WDFtSZDb0oAeRQ/1LQ2FggbyYBxCnAkpEi0jC
	 nLebdD9VeqOzSdJwDgOhdi+41rRadLFlXwlQiYDUkjstFyWBFtbx1XveuL47vqe7/p
	 1LlMq/CnyHgRh1BmTY8Pt4Xgccx0DOiVVZiOrejrUwJJgzo3pNC7M+1KBYWcoY6cvQ
	 MAkfJv+WJN8TVbE/1GjfjxMmHdj43DOLt4vu6yxSuuDUbtwBOK4an81XSuWaPG2RqT
	 gm6DIam1LDm04QOVoQBIHe+lxcTuZgQalTlD3PlZvnqL4LAxNFMrKqDuFSjvsIFchs
	 Qh6shSzGuyQfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FFDD49C76;
	Fri, 30 Jan 2026 10:06:57 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 30 Jan 2026 10:06:49 +0000
Subject: [PATCH v6 8/8] Documentation: ABI: testing: add common ABI file
 for iio/frequency
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-adf41513-iio-driver-v6-8-cf46239026bc@analog.com>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
In-Reply-To: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769767615; l=1731;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Oj2k9JgE/uUfO2+nYhc3ewqTCjVw0I0URGflu7fT+uM=;
 b=a84rk33IDvCU2RI1CyAHPceczS4wBg2aO6wVlKT6rKa0sOT/sPiFVFLJ1e5X3CH06Ga4+pNzI
 OQJb3x/LXQYDpqqpyzE40lc85DMZdCwMhIHA5eye78J70VjmHj1fsjE
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
index 0d9b7cf86aec..748eeb6f5bd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1639,6 +1639,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-frequency
 F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
 F:	Documentation/iio/adf41513.rst
 F:	drivers/iio/frequency/adf41513.c

-- 
2.43.0


