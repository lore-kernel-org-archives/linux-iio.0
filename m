Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA03148D9;
	Tue,  7 Jul 2026 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433067; cv=none; b=A4AMc/lVrYmHelE/PmIn3FxzzvoWjQWIrVicRxqLKJCcIU4qEJX6u+TPMrOHOlkldqgzMe1ZGnL1ahqJWmnkH1Eah6eTSJJASCWhceujrZr0uNmNdbqcgeGtqebaI+c1ibqMZlT2c7kSBe3yjoITSLbvcEQAtjlKWOtjMOU9K/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433067; c=relaxed/simple;
	bh=UtKYoW5FDSxLKqqbjmW8abMzfHP00hnJo7tRGqvTRQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q8K2QrEI5eIdijNNq9UBeN1oeGHEwz6WcEWUGJKJwREgq7GwO6+iUe6KIEgnhrhY1e/G2eJIzi1nca/EzgZpCCXklbhAYpMSlgteJnNg2oZbZTP0vzYqP/1EmjtQ3Gk68W2JpKSTBPRODIWdPDFakjM0fZRUbskS7gAj1Ws42bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMvxoboD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMvxoboD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 834D2C2BCB9;
	Tue,  7 Jul 2026 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783433067;
	bh=UtKYoW5FDSxLKqqbjmW8abMzfHP00hnJo7tRGqvTRQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fMvxoboD/KZBW75BaYzNzg1BQb+xbaaJXvwXWkyidOF5RFTkW6gTEeX/WfKjVpOIx
	 tTFjSPD7x9XcssVSFXp4nJXrfShgoGUSK18mGwhyot/Axn89qUCP97xQHk1gPZmcuM
	 3oD1aXbWIDj6nyCqfoY5Uu2jYSHMpvmS1H4YtyMuK4jqdmRZ+ovomsEWa8FwrYKUZS
	 /Y/dCXS8cyXlS/ZzkZCQZahUl1OoryAr+pMQvddFe6PqTyqoi3ZJmz9XPLAoXyRTZ0
	 QAa8IqmTleQ8Vu9oztVabCkfSLaBsBWqdc3YmLKkg1Imwr5SBYihFEGBsXzQt/rxyQ
	 WWPnMKaF8X4rw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A77C43602;
	Tue,  7 Jul 2026 14:04:27 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 07 Jul 2026 15:04:22 +0100
Subject: [PATCH v7 01/17] iio: ABI: add attributes for altcurrent channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-ad9910-iio-driver-v7-1-a4ec30f63700@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783433065; l=3268;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=ZMU9cnovPYUzplaaXs4eCd0C1BPEa1nJaR4itGOwIM8=;
 b=ZNxDjlH6eVCzNXt3MyB1TC5leJSh+E5R9icIoZy8G0ES/GZCG5LPW8I2QyFj6dB7gotNhjWfE
 XZluTbaYUAmCNDlkhpfbIdU2q+IHhJi8+o1hD1W4i9yc7YbW6CGAOob
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
 Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5cc2e82c4997..90047189c3eb 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -478,6 +478,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_current_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_current_q_scale
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrent_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_peak_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_scale
@@ -799,6 +801,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrent_powerdown
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -809,6 +813,7 @@ Description:
 		together.
 
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_frequency
 KernelVersion:	3.4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -835,8 +840,10 @@ Description:
 		all the other channels, since it involves changing the VCO
 		fundamental output frequency.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_phase
 What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_i_phase
 What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_q_phase
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_phase
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_i_phase
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_q_phase
@@ -1736,6 +1743,8 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_raw
 KernelVersion:	3.17
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -2126,7 +2135,9 @@ Description:
 
 		Raw counter device counters direction for channel Y.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_label
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_label
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_label
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_label
 KernelVersion:	5.8
 Contact:	linux-iio@vger.kernel.org

-- 
2.43.0


