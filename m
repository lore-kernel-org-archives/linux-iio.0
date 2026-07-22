Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D14F7998;
	Wed, 22 Jul 2026 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735459; cv=none; b=SG5PPXL9NFrZ8d63VnOM20uwrFX81poWbHgbEO8R8L9gxTpdqtNbk2fpIVXAQG7/8Aa0NVgBvVPlyMxL4vm36p+eNjkh8zwKfMW0S35+wBXclXHeIs4CqcFXl2HYJR8FTxlZ6rNVhaQQaeAcehWAKGuG0DZx0JSt8vsKCKHgGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735459; c=relaxed/simple;
	bh=5+f9zGuJaDqs3Qd5BGYpu7W0XnuOiVpM1LuzsifS1ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/u4XgJkxjjTacplqcMAtkHT14PJOBQwDL7C7Izx8U3F/okDRxi3oUzSGSdjOMgwvr2eNQ/gq7dXOIQ3zvlOjVymLdpSFwy7oT30sxztSnEoiDIOwdporFG6BkPJEwI7SZL0rq2L5VVEw6SjoJIWycSxJc3UllNoH/MLv8qO4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKun//7n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKun//7n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCD86C4AF11;
	Wed, 22 Jul 2026 15:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784735458;
	bh=5+f9zGuJaDqs3Qd5BGYpu7W0XnuOiVpM1LuzsifS1ag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EKun//7ny5WZhFLxu1Ern4r7/NaKX/gr/EfhP/aQn/7mznOkB1wbyYAmZZzRPTNYu
	 Wcu8/PqicCu2K/gqLEpblh3IsR3/5KK0sjt5mG1N/rWHkQAzsDr/ob3Kc8MNB160Eg
	 +CbQ4EEDD5lyKQ/NojCovp5UbiW6QbtXWIUiCGMvGuWzOwadPNq7ezXoqHFylIO4zM
	 1S7lWIoJCLmyAqYw2uB32VGqrZgkNFA2JQObe+1/BGUQopq6UZQ06Ek+5m3PjdxjQ5
	 WZPvNdxl5HqK531W/RGYg7tVrTj+eviZLWWEQQANr98/K4uESBqvSWzdE+FyKBrATg
	 U/+VCo0As8hhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99CFC4453E;
	Wed, 22 Jul 2026 15:50:58 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Jul 2026 16:50:25 +0100
Subject: [PATCH v9 16/17] iio: ABI: add docs for ad9910 sysfs and debugfs
 entries
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ad9910-iio-driver-v9-16-459d1df5ac56@analog.com>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
In-Reply-To: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784735456; l=4220;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=ODvLxJPODA5YQ+w5a0lwK7q83k4NXyONagfc42uDQZ8=;
 b=jN4Kxsc4z+pToJcmX5xQ0n1lmnChabpn46djbYi5EJiKfcildlt9aqqpBZy7T+enlRoreOJ21
 cLEoD/zVVwgB8FbFOTA3hzLK68kVD4U+myYyiKIMDethOi4dKoDhn5e
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
 Documentation/ABI/testing/debugfs-iio-ad9910       | 23 ++++++++++++++++
 .../ABI/testing/sysfs-bus-iio-frequency-ad9910     | 31 ++++++++++++++++++++++
 MAINTAINERS                                        |  2 ++
 3 files changed, 56 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-iio-ad9910 b/Documentation/ABI/testing/debugfs-iio-ad9910
new file mode 100644
index 000000000000..7083a20d5a40
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-iio-ad9910
@@ -0,0 +1,23 @@
+What:		/sys/kernel/debug/iio/iio:deviceX/frequency_source
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only. Reports the channel label that is read from the
+		<dir>_<type>[Y]_label attribute, which corresponds to the on-chip
+		signal generator that is currently driving the output frequency.
+
+What:		/sys/kernel/debug/iio/iio:deviceX/phase_source
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only. Reports the channel label that is read from the
+		<dir>_<type>[Y]_label attribute, which corresponds to the on-chip
+		signal generator that is currently driving the output phase.
+
+What:		/sys/kernel/debug/iio/iio:deviceX/amplitude_source
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only. Reports the channel label that is read from the
+		<dir>_<type>[Y]_label attribute, which corresponds to the on-chip
+		signal generator that is currently driving the output amplitude.
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
index 83342b577aa6..182f7db0010a 100644
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


