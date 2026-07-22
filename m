Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045F4746B1;
	Wed, 22 Jul 2026 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735458; cv=none; b=n9Un8JpFhVyV4aC/kq3JymW+FWSTv2jWWlIlTkrKSGg8FRA9dfi6vNCrXeXqYsJGXi7UkqM/FJoB5ZP1tXRJHRLgH4EuNgw//HWMf+3cJunrk5/hu6U4XjlwmfbCr2DE0d7FvPT9jviUSsxpvAUnhkCh/r9/Iwzxtn0Em9apDqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735458; c=relaxed/simple;
	bh=c2p5L1q6zxv7wWh9EpdRkFyHFnzsFh472s+WmtKCZhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LLebX7Fhd5bR8NkTrm3kgZq4dThLVzJIOK6iald0Km2zGmN5F5E3N7lgsOWmybtmfMPrqBh1zACFUJR35F1xpTisqmbnlzkzc813jIN9C7uXSe+4D0hdNEsCU9lGGG1rE6VSY2Liau1Q/mFF+Jms1+HJE5FqkeUkxityddba+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvn3pqSK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvn3pqSK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAE89C2BCFC;
	Wed, 22 Jul 2026 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784735457;
	bh=c2p5L1q6zxv7wWh9EpdRkFyHFnzsFh472s+WmtKCZhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tvn3pqSKsFHfok9BwBydRARoJ1m04vciW0OyO6b0h7ckcA9Xm1aH5IGh8Z8HmLnQM
	 B31TAP/xN7RdQEXO8OwYG4nX4DM1WzxupMKDhLfOzFXqfLc9cjJFmfesi116aBAW4D
	 TMrCwSaTnyEhziLauGlXxCXHxI8UL8tdppAbopOPYpUf7yQT3m7mrTx1sSgsSHyAne
	 Q76x8SsxvZGK1JU+KxoqbrWegp7xgqb8b9fnfnu+nMe50vSRfrLxJHHYg/Im3IV5+e
	 Kk7KFgHIL6YVxnTkebD1ZlUqKrv0e/0SWxILq0m44yALY4Vr6T8Ay2fTir6VZvU0wC
	 PoIF5EsYOPv0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963CEC44536;
	Wed, 22 Jul 2026 15:50:57 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Jul 2026 16:50:10 +0100
Subject: [PATCH v9 01/17] iio: ABI: add attributes for altcurrent channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ad9910-iio-driver-v9-1-459d1df5ac56@analog.com>
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
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784735456; l=3588;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=NMyQtwKnhP7ghLAaLd8Vv8Yqv0bWLLVXShCmZ6SK4qg=;
 b=jPE8V/mOW+rnINhBGXR8IHAvefsCXxeDvnqDh09fTspG4Od13kNyaJoKFtwFkGmUg8VIAHUUK
 FZ/kycpkdxFB1R80n7cHDkDMfV0PIpEvufvs11lh/g+7kn/fFMryqqe
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add attributes applicable to altcurrent channels, e.g., frequency, phase,
scale, raw, label and powerdown. Those are going to be used by a DDS
device to be introduced shortly.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5cc2e82c4997..3e75ce1c97c6 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -478,6 +478,10 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_current_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_current_q_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrent_scale
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrent_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_peak_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_scale
@@ -799,6 +803,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrent_powerdown
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -809,6 +815,7 @@ Description:
 		together.
 
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_frequency
 KernelVersion:	3.4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -835,8 +842,10 @@ Description:
 		all the other channels, since it involves changing the VCO
 		fundamental output frequency.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_phase
 What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_i_phase
 What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_q_phase
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_phase
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_i_phase
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_q_phase
@@ -850,6 +859,7 @@ Description:
 		channel.
 
 What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_raw
 Date:		May 2012
 KernelVersion:	3.5
 Contact:	Johan Hovold <jhovold@gmail.com>
@@ -1736,6 +1746,7 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_raw
 KernelVersion:	3.17
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -2126,7 +2137,9 @@ Description:
 
 		Raw counter device counters direction for channel Y.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_label
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_label
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_label
 KernelVersion:	5.8
 Contact:	linux-iio@vger.kernel.org

-- 
2.43.0


