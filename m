Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52A3D1A97;
	Sun, 17 May 2026 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043097; cv=none; b=X2Uc6QXSkZ6vNnQfUaGNccDtOOCUX06vOXVWnmX3zQa8KdhJ0o1I4qsRbUdVvsHQbVNnVA6KwS8IF/QdyUZJM8TRY9enYZEY8AqoZWUPmcqSSx65qKuKLJVc1mARVRVsStOj8EuY96jRuDNwB/ffHvPPUBPP+MYOUTdYcJMlOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043097; c=relaxed/simple;
	bh=zU8kqOJYEyW48g2H5RnwB6TqD4QaQ1elueHqtC2b73A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vD8fwGcfZD3IPJIeVcvESvEKlSNgkeZjmk6WM+9ZpngfanvFF122PNpqIASQvODViC5LD3iNPbAjm7+KOvlRCzElhsRRqXbESQmbnAlZgr2iN1gKpijFXscRQmnMaSGXqTXiiwC7lMzB1fYHDz3uAT0Zm8/qQcdzlZbxi0JcCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLtBGikh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLtBGikh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4657C4AF65;
	Sun, 17 May 2026 18:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779043097;
	bh=zU8kqOJYEyW48g2H5RnwB6TqD4QaQ1elueHqtC2b73A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VLtBGikhkoxA+nsAZXgiu9YK3INa4puOoZNdhEWDJfDKk2MZcPtzhYvdBlBTvpq0q
	 PPAFkhhZNp2yJWzIxSJYiCK7OJiEVeVrS9/fJiO1xX2I4WNUnaC3W2zVnI7W8i+qc6
	 iWzccRDXJjomu50zj2LZh6bK+CYZyhb0la/NqdGeEMePn+K5RK86fCi7BOOsqt5T+W
	 8PSP92sFU4ODcXaAaIgHUZJ9KaFfVDV9DPEg1tNyGWsGLBQU08f8jU+Lz5V2wlgdXl
	 Xn44APBhUEkWlafacWsLZWoMsgHAuCDpLGpumDpumiRieCdNXSRlh0MYjg/NQ8Zshv
	 w1uNj62BnbBOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55EFCD4F54;
	Sun, 17 May 2026 18:38:16 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 17 May 2026 19:37:56 +0100
Subject: [PATCH v5 12/13] Documentation: ABI: testing: add docs for ad9910
 sysfs entries
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-ad9910-iio-driver-v5-12-31599c88314a@analog.com>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
In-Reply-To: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779043094; l=4308;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=vq/r4p3mHdAjM1JHWSiE7n5FYlIvuWbgRwIbdnmEcsk=;
 b=sHP674t9lVcpzbTlqajdKrXwjkrCKjGVrjxpSnSAawspN+mIOPtLFaWU6XQlZpYMIc/WDHpP9
 AJCXY5sqvJOAdWNWkaTHVvN1KyTSa/VCyVBebIhDP9kSD0dQWRDoQxg
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
 .../ABI/testing/sysfs-bus-iio-frequency-ad9910     | 76 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 77 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
new file mode 100644
index 000000000000..934e6e8f0595
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
@@ -0,0 +1,76 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_offset
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		For a channel that allows frequency control through buffers, this
+		represents the base frequency value in Hz. The actual output frequency
+		is derived from this offset combined with the processed buffer sample
+		value.
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
+		represents the base phase value in radians. The actual output phase	is
+		derived from this offset combined with the processed buffer sample
+		value.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_offset
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		For a channel that allows amplitude control through buffers, this
+		represents the value for a base amplitude scale. The actual output
+		amplitude scale is derived from this offset combined with the processed
+		buffer sample value.
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
index b2b7f54f5a24..c39affe4157a 100644
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


