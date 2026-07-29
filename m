Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8013D43C7AE;
	Wed, 29 Jul 2026 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313629; cv=none; b=K1jZIOcV3i60bbnclnFFhUgutIUea6ukHQaPqeulm4fkhBEIzEPbpdfDyKa7zSaJepd/VG6Fin1HeqSaCxhRn3Ln7whqZ509vJiHob5O2tfA6rHu5nOJd8wIfZ03JAQIf4zmc8emip6f5k3JJDwrX2kftEq+XgnuaxTXaX0kRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313629; c=relaxed/simple;
	bh=y5y1Pex3r0tEmIZ3ma1DZMuFnuVLNzcCNOrpynmqk7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bylBaN2RDxxFDX3HIF7aGn+oBS1L5P1uOKf+slAOnmOZtUS7CNMEhTXLOBzL7OlhNfaLIns1JSkRoC8GHQ+yMyXHEcanlwaxCCEtAo9pe7yTTexdd7jq4MMC39J7bWVWSsFy68paCMlXmJYeu+XiTqWtCSp7oyWbAHrMbqOhD+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIaEBsoU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIaEBsoU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C770AC2BCF7;
	Wed, 29 Jul 2026 08:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785313628;
	bh=y5y1Pex3r0tEmIZ3ma1DZMuFnuVLNzcCNOrpynmqk7Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oIaEBsoUVF0dj3ehhFcjjxFg7Qxz9qxobJ3A4Oh0LjbsuQ1AdrfxrFej9XOxj+GFV
	 jiCTvmGyzpFWX1Wa+qJa1c7/IK7qXHhwZJUdAWaMSmA96z5H5mMfxvWzGaG971R08e
	 dtbGYVLbaCzO0GfNExze33Y/izq3TnvCZ9rKNbdeXX3BjPPIv+zfbFsXpghfDBgVYO
	 ucclwqsS8V3jYMM7eWXwJJAeY3buGmuuSqa9z3T5//ea1mQhyhTzmPlfIdgzDHRfxQ
	 kZXndqxBfvY/h6jDoWN2r4smm6VG9XSZ1Y+h8Ikb0rwr0hMx3C3wRhbSL/3kt6HmKF
	 GaXGEddOFpyWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80B7C54F5C;
	Wed, 29 Jul 2026 08:27:08 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Jul 2026 09:25:29 +0100
Subject: [PATCH v10 02/17] iio: ABI: raw, scale and offset for
 frequency/phase channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-ad9910-iio-driver-v10-2-aa1f6167729e@analog.com>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
In-Reply-To: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785313627; l=4117;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=b0wjZEHLLiPjjpYzkara2Qcj+Q0dyqXjAs1Abo131jY=;
 b=IbPxfpd4pdPmGX1M/WffY5Auc4uTjhUku8+sEWdhkkxuljCS2nXikHgaxv62zhz8bmJlztiyz
 Tby5ajt6W5eCyDbWi2T9xNelypSClviEtbezuxOqorxDCHIdrLrRfk5
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Consider scale and offset attributes for frequency and phase channels.
Frequency channels are going to be introduced later alongside a DDS device
driver which is going to leverage those new attributes.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3e75ce1c97c6..24712b5bd110 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -441,6 +441,14 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_current_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_phase_offset
+What:		/sys/bus/iio/devices/iio:deviceX/out_phaseY_offset
+What:		/sys/bus/iio/devices/iio:deviceX/out_phase_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_frequencyY_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_frequency_offset
+What:		/sys/bus/iio/devices/iio:deviceX/out_frequencyY_offset
+What:		/sys/bus/iio/devices/iio:deviceX/out_frequency_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
@@ -474,6 +482,14 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_scale
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_phase_scale
+What:		/sys/bus/iio/devices/iio:deviceX/out_phaseY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/out_phase_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_frequencyY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_frequency_scale
+What:		/sys/bus/iio/devices/iio:deviceX/out_frequencyY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/out_frequency_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_current_scale
@@ -2149,6 +2165,22 @@ Description:
 		specific attributes. This is useful for userspace to be able to
 		better identify an individual channel.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_frequencyY_raw
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) frequency reading from channel Y.
+		Units after application of scale and offset are Hz.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_frequencyY_raw
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled, no bias etc.) output frequency for channel Y.
+		The number must always be specified and unique if the output
+		corresponds to a single channel. Units after application of
+		scale and offset are Hz.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
 KernelVersion:	4.18
 Contact:	linux-iio@vger.kernel.org
@@ -2156,6 +2188,15 @@ Description:
 		Raw (unscaled) phase difference reading from channel Y.
 		Units after application of scale and offset are radians.
 
+What:		/sys/bus/iio/devices/iio:deviceX/out_phaseY_raw
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled, no bias etc.) output phase for channel Y.
+		The number must always be specified and unique if the output
+		corresponds to a single channel. Units after application of
+		scale and offset are radians.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm1_input
 What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm1_input
 What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm2p5_input

-- 
2.43.0


