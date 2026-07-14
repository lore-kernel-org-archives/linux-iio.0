Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81F37A856;
	Tue, 14 Jul 2026 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026973; cv=none; b=OjWDi1IkzH+WT3dh2hFK/ma2EJtas/LE1wUhLbNiuMJH9Bf6LltDC9aQbw78fHIF8/V+CdGWeHXwW2r7rFWAQs1tIjy8bc22PMgLXS19D3ThBVinZl4dw4LroPlw75VStClcFxfYgP+LGFPzwT/R7E4p01LP5dYaUWa4KEh7f+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026973; c=relaxed/simple;
	bh=dR1AV8RzdBbRxhwpqT/7HpEbkG0q6lG9Y4EeHP7f4R0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYtCCypkTbB/M9ujtE9e11WxNkvf4knrLZ44mruGdve3b8PoTTCnZdolwj8uuFhivsF9Z5iIhdNY9aiQIzk615IQl8ef7Ru2nN+4MW+GFHGNpUcuMyCB3+7GWCtw8ETxxqFq9lgJMTvvFxfsHJvCqLddGxrMkIa3BakVroB+9cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmrKhnRw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmrKhnRw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7D5AC2BCC9;
	Tue, 14 Jul 2026 11:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784026972;
	bh=dR1AV8RzdBbRxhwpqT/7HpEbkG0q6lG9Y4EeHP7f4R0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NmrKhnRwMIjQLpd9VXFKEQ+5bfsmJUV+HLm8g0n+r4vUIIBhvMftyADm4Ym9yZHaO
	 JcFnj3VE7jy3j4Uq4NNYSgE3DpqzzsErR1AwWOBpZlLh+8CQdZpPWmO+9qW36m6w3V
	 Ahs8rDFWQOvEDPElfkMfiJBAUpS5I0Bqd8hn/teDcs42fI1nPzCahCQ2t1dXei4eXz
	 CUiTeCm6qT1oKEbDjTbj0FiOG5QyypQHoWKr6Nse98iGsHgNh9hP96yKCcUJTcXqoX
	 gcY7ouCwATlxzBWcyjvRK0HuIQFAt+aBeNvOUk8mXVvbNO8oTpSUDEN7/68IS36dEA
	 FXjcUSOQQwJYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9262BC44507;
	Tue, 14 Jul 2026 11:02:52 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 14 Jul 2026 12:02:42 +0100
Subject: [PATCH v8 02/17] iio: ABI: raw, scale and offset for
 frequency/phase channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-ad9910-iio-driver-v8-2-36939c3c07d2@analog.com>
References: <20260714-ad9910-iio-driver-v8-0-36939c3c07d2@analog.com>
In-Reply-To: <20260714-ad9910-iio-driver-v8-0-36939c3c07d2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784026971; l=2654;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=WbFwCkkJVUsU+INjO/fRC/McrYPJtkf/NCh+2X6x1A8=;
 b=An2muswWCP9b/2a57tZTiLHelYlOSP1bFOiZEjf9M9dc7447EOuKkdWUlcGI24k2VL6jkZb0x
 ctYKpqLf7BuAag712N2BWDBmHwKp0fSd50UMRCe3APd/DT2c4iTed7t
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
 Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 90047189c3eb..7ef0db8dad40 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -441,6 +441,10 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_current_offset
+What:		/sys/bus/iio/devices/iio:deviceX/out_phaseY_offset
+What:		/sys/bus/iio/devices/iio:deviceX/out_phase_offset
+What:		/sys/bus/iio/devices/iio:deviceX/out_frequencyY_offset
+What:		/sys/bus/iio/devices/iio:deviceX/out_frequency_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
@@ -474,6 +478,10 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_scale
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/out_phaseY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/out_phase_scale
+What:		/sys/bus/iio/devices/iio:deviceX/out_frequencyY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/out_frequency_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_current_scale
@@ -2147,7 +2155,16 @@ Description:
 		specific attributes. This is useful for userspace to be able to
 		better identify an individual channel.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_frequencyY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_frequencyY_raw
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled) frequency reading from channel Y.
+		Units after application of scale and offset are Hz.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_phaseY_raw
 KernelVersion:	4.18
 Contact:	linux-iio@vger.kernel.org
 Description:

-- 
2.43.0


