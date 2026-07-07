Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F04428841;
	Tue,  7 Jul 2026 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433068; cv=none; b=IRsagFJCnMDFsxFL526Pc7phKqCvr+oIK2UCKIFTehbLK0lK0LGBpKFds7NFs/xqeUxXvvsnHfFoILxvmfo2neYfIDJnsdA0vDUkYHwXHM6BonEWHba1qUeYu+Drej3PiEJSYrLLS1Lstx5xt3IM2HLHRBWiOh1OR3A10r6l0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433068; c=relaxed/simple;
	bh=6MPNpGEXip1RJ1vTLq1uiDziCPUjgnL5nGN6N0Pe5uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l8SvgbbAXFej2E6H/BC6/wbS/Xd66bGUr+Ge+/Df7tiRXX7aDpXvlx8aJpdvO1mf9YF/qpAJPw01Y4O+vHxO49CORdTT38PrWFvOBkKfWIEjO6Tow1p9RBOZR56NjFvBqK425tqxlZirhpjCY7YRw37kCJsSfnV6PKCAo5B2848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWMF1RBH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWMF1RBH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E9CBC2BCF6;
	Tue,  7 Jul 2026 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783433068;
	bh=6MPNpGEXip1RJ1vTLq1uiDziCPUjgnL5nGN6N0Pe5uk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UWMF1RBH86NT/k8VMLSvO1CvdvgyjZn51n7By7cp4ql8Mlbmjt7curke8db1D3KqJ
	 1Omfz9o3iAuHdi8XzWtB6yhKzC5HOv0k17T84eeEnLoqsKw/GKx1hU2GBdSQMYWUwe
	 dZUySEPRQmqFG6nJLbEB54ZTxDoYa8mkNbaILyTA30YS5nHgd/XFRvXMMvgmH6mk8Q
	 UJ3z57iUfFAU3T3OLWYj/HHgKS/ClaZj6jMJOkTAWi8zxadc4/IagvPTefst520mSu
	 A1Spr/jLv7Mr9FePonzhj1RCJMcVKgcgsv4QLIYKImYRo5DyuJxDX84LjwVNwrREMo
	 GyKX5bFls76FQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68737C43458;
	Tue,  7 Jul 2026 14:04:28 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 07 Jul 2026 15:04:37 +0100
Subject: [PATCH v7 16/17] iio: ABI: add docs for ad9910 sysfs and debugfs
 entries
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260707-ad9910-iio-driver-v7-16-a4ec30f63700@analog.com>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
In-Reply-To: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783433065; l=5856;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=GoKs9b4hkGJ5w4ngpHKHYorbZQWdlUxM8I/vrc/m5Xo=;
 b=aT7kPRtMTJQodmnsWVjaEnPoH1fr1hTCmeqNsCOMF8I0p3xm9pr52eNpLGbnDSCHY/CBTUHAt
 4vcZyAGfM3vDKis2fzU7kWpT4egZBvBtmpJSmPVKn0almsaOZFTrpYG
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add custom ABI documentation files for the DDS AD9910 with sysfs and
debugfs entries. The sysfs ones control parameters from the Digital Ramp
Generator and OSK engine. The debugfs attributes are read-only and
evalutate into source channel labels for each DDS core parameter.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/ABI/testing/debugfs-iio-ad9910       | 60 ++++++++++++++++++++++
 .../ABI/testing/sysfs-bus-iio-frequency-ad9910     | 31 +++++++++++
 MAINTAINERS                                        |  2 +
 3 files changed, 93 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-iio-ad9910 b/Documentation/ABI/testing/debugfs-iio-ad9910
new file mode 100644
index 000000000000..b4a125bc1007
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-iio-ad9910
@@ -0,0 +1,60 @@
+What:		/sys/kernel/debug/iio/iio:deviceX/frequency_source
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only. Reports the channel label that corresponds to which of the
+		on-chip signal generators is currently driving the output frequency.
+
+		Resolution order (first match wins):
+
+		- ``ram`` — RAM playback is enabled and its destination is
+		  frequency, phase (polar), amplitude, or polar.
+		- ``drg_frequency`` — the Digital Ramp Generator is enabled
+		  and its destination is frequency.
+		- ``parallel_frequency`` — the parallel data port is enabled
+		  and the frequency scan element is active.
+		- ``profileN`` (N = 0..7) — none of the above modulation
+		  sources are driving frequency, so the currently selected
+		  single-tone profile register is in effect.
+
+What:		/sys/kernel/debug/iio/iio:deviceX/phase_source
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only. Reports the channel label that corresponds to which of the
+		on-chip signal generators is currently driving the output phase.
+
+		Resolution order (first match wins):
+
+		- ``ram`` — RAM playback is enabled and its destination is
+		  phase or polar.
+		- ``drg_phase`` — the Digital Ramp Generator is enabled and
+		  its destination is phase.
+		- ``parallel_phase`` / ``parallel_polar_phase`` — the parallel
+		  data port is enabled and the corresponding phase scan
+		  element is active.
+		- ``profileN`` (N = 0..7) — none of the above modulation
+		  sources are driving phase, so the currently selected
+		  single-tone profile register is in effect.
+
+What:		/sys/kernel/debug/iio/iio:deviceX/amplitude_source
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only. Reports the channel label that corresponds to which of the
+		on-chip signal generators is currently driving the output amplitude.
+
+		Resolution order (first match wins):
+
+		- ``osk`` — the Output Shift Keying block is enabled and
+		  overrides other amplitude sources.
+		- ``ram`` — RAM playback is enabled and its destination is
+		  amplitude or polar.
+		- ``drg_amplitude`` — the Digital Ramp Generator is enabled
+		  and its destination is amplitude.
+		- ``parallel_amplitude`` / ``parallel_polar_amplitude`` — the
+		  parallel data port is enabled and the corresponding
+		  amplitude scan element is active.
+		- ``profileN`` (N = 0..7) — none of the above modulation
+		  sources are driving amplitude, so the currently selected
+		  single-tone profile register is in effect.
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
new file mode 100644
index 000000000000..4e25f538af4a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
@@ -0,0 +1,31 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_dwell_en
+What:		/sys/bus/iio/devices/iio:deviceX/out_frequencyY_dwell_en
+What:		/sys/bus/iio/devices/iio:deviceX/out_phaseY_dwell_en
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		For a channel that produces parametric sweeps, this attribute controls
+		the sweep behavior at the configured limit. It enables dwell mode at a
+		sweep limit when set to 1, i.e., after the sweep is complete the output
+		value stays at the limit. Otherwise (setting this value to 0), the sweep
+		may stop or restart from the initial position, or even continue by
+		reversing the sweep direction.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_raw_roc
+What:		/sys/bus/iio/devices/iio:deviceX/out_frequencyY_raw_roc
+What:		/sys/bus/iio/devices/iio:deviceX/out_phaseY_raw_roc
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		For a channel that produces parametric sweeps, this attribute controls
+		the rate of change of the parameter in raw units per second (slope).
+		This value may be influenced by the channel sampling_frequency attribute
+		if available. Multiplying this value by the scale attribute of the
+		channel yields the rate of change in physical units per second.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_raw_roc_available
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Lists the available roc values for the channel. Values are
+		space-separated in ascending order.
diff --git a/MAINTAINERS b/MAINTAINERS
index cca4304195cb..fd6119aaad8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1683,6 +1683,8 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/debugfs-iio-ad9910
+F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
 F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
 F:	drivers/iio/frequency/ad9910.c
 

-- 
2.43.0


