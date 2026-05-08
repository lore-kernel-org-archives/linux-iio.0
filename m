Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D41410D37;
	Fri,  8 May 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259635; cv=none; b=Qn7JutJr5Kbi1bpvDWgsm7zoEMptnsE7nayq9XBcGhOO67K8PMzJqGCBt3LQj0xVfLpP7qJAI3ZFRYclLNMrlgdsm+B6aviNtEOBIBVh7QDmBAersZtFI4eS+hFFD8ZvMFQdQ8lUZNRNMNtC7V41OmVPHV13aANaydrL1g53Rww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259635; c=relaxed/simple;
	bh=hkJbFyKdkMRZbGONZc/TYAEOzLpBIAbUhp0ZKra8VvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BVTVJDZOERSsQ+gI9R6UJyYS4PXPswQfSknuoARcjg43AUaJJ7FBwZZoN0Ntyr17TfWX06EbqSNd/GIM79Rq7uQ5Ioj8yhIY4lIiAjzX7QRZkuYEu8LHWzyVhx25JVE+vQXtGo9BsB9/C5K61ZZH9Sqc2S4WoktHubqKEsj+LNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFZApktL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFZApktL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05F60C2BCC9;
	Fri,  8 May 2026 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778259635;
	bh=hkJbFyKdkMRZbGONZc/TYAEOzLpBIAbUhp0ZKra8VvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BFZApktLP9iEwsOBW/2ZMFYrwiMYvafiTVsCOo48Y3gvWGK1CkcPfnyjx0VC2kIOK
	 8Iorb1Tdq9TB4Aw3MgjEkvqW+txdcQ4GXKjeuPP+YhR9UWlj9n/r9b3dpRHGrPDWv9
	 CxuSyd44pwJ6aXhKd7T1mPol9s/JpkuGK6jkNXdPd66CCLncq1w7huBsPOWFVGVL0A
	 Gy5/0q3t5KBoTdfIU+7CNVfuXCK1T3+f7M9CfybWNM0bMIrjedQA0L3pFjiAjY8sw8
	 mbfwFvUF4vAPMis1tzbf1MHHEMy0t8sbRUyA69KIt6kj+m9ndIenZdy0F0tilU3Xh0
	 It0W5p6JAdQKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE332CD3445;
	Fri,  8 May 2026 17:00:34 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 08 May 2026 18:00:25 +0100
Subject: [PATCH RFC v4 09/10] Documentation: ABI: testing: add docs for
 ad9910 sysfs entries
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-ad9910-iio-driver-v4-9-d26bfd20ee3d@analog.com>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
In-Reply-To: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778259632; l=4185;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=dE4RjDJ3jXYz/rWtGJ4gRTQISFMbwtkVtOgifyBJx3Y=;
 b=Gn0rPCIlonlfYr1Xkw5LmC1wDnq4KqUWvtJG7BfXNEiXnU+G1GR5/iVvKM9+kiUf4qOaNVMAG
 tJ0RkiKfT/XCFxMpnqlIw/z49llpyZX07mT481ogIrTNGKlMDY0HLGJ
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add custom ABI documentation file for the DDS AD9910 with sysfs entries to
control Parallel Port, Digital Ramp Generator and OSK parameters.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-frequency-ad9910     | 73 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 74 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
new file mode 100644
index 000000000000..eb0ff96a6e10
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
@@ -0,0 +1,73 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_offset
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		For a channel that allows frequency control through buffers, this
+		represents the base frequency value in Hz. The actual output frequency
+		is a result with the sum of this value.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_scale
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		For a channel that allows frequency control through buffers, this
+		represents the frequency modulation gain. This value multiplies the
+		buffer input sample value before it is added to a frequency offset.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase_offset
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		For a channel that allows phase control through buffers, this
+		represents the base phase value in radians. The actual output phase
+		is a result with the sum of this value.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_offset
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		For a channel that allows amplitude control through buffers, this
+		represents the value for a base amplitude scale. The actual output
+		amplitude scale is a result with the sum of this value.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_dwell_en
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		For a channel that produces parametric sweeps, this attribute controls
+		the sweep behavior at the configured limits. It enables dwell mode at a
+		sweep limit when set to 1. Otherwise, the sweep may stop at the initial
+		position or restart from that initial position or continue by reversing
+		its direction.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_roc
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Frequency rate of change in Hz/s for channels that produce linear
+		frequency sweeps. This value may be influenced by the channel's
+		sampling_frequency setting.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase_roc
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Phase rate of change in rad/s for channels that produce linear
+		phase sweeps. This value may be influenced by the channel's
+		sampling_frequency setting.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_roc
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Amplitude scale rate of change in 1/s for channels that ramp
+		amplitude. This value may be influenced by the channel's
+		sampling_frequency setting.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_roc_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Lists the available scale_roc values for the channel based on
+		the current sampling_frequency. Values are space-separated in
+		ascending order.
diff --git a/MAINTAINERS b/MAINTAINERS
index 6a53b202a84d..b52c0aae96b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1643,6 +1643,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
 F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
 F:	drivers/iio/frequency/ad9910.c
 

-- 
2.43.0


