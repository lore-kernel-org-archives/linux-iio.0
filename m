Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC837DAAE;
	Tue, 14 Jul 2026 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026973; cv=none; b=K+KiRH69+1KlblA0tt2vV7j6mHAY5VNSk7/hcxxMUrzgKzPDVsZwRPUnogfRzR26msrDszfzk65qUuvj4sxwC4A4DdkJfdyYhTz+U6c9w33bTfjdtVfdW0rSMBsn+GZWh7JqaN8bNsJwVcxG+hNetPZTbvSOXITSmaF9khkAdpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026973; c=relaxed/simple;
	bh=UtKYoW5FDSxLKqqbjmW8abMzfHP00hnJo7tRGqvTRQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GF/+elbYqpwpWMm2YUCP9aBAsdwmXwTdSDJ33CqMLiwVYaAE8jPL4Ts+3MFOqVbP/NOt08FJhGvAFNUwuuwUMI9VHXp3YXYm57TKc00Y/TR/MXAD0lfDau4cEAr5rM94rQzUEKkTuXmu9CGJsseK0EZuqlc2i2kar/KDYzoREbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuRNftWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuRNftWH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4FF0C2BCB9;
	Tue, 14 Jul 2026 11:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784026972;
	bh=UtKYoW5FDSxLKqqbjmW8abMzfHP00hnJo7tRGqvTRQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TuRNftWHE2o0JZ2c+05yPnk7NsE8A4AOEjFOg8Ds/6PdHqXu7/P2W3c6MlkCp7Yx0
	 /c+qxc1tZbRLpUcXaAJ1DLRpTWTHIpdhAz4ZPFZCjG6BtjBWZAMzaZSP1oCcQEiV53
	 bmgA5vhNFZoUgSshqFWmEqqoEZ/w4xODsEtOLAZxqXMA6O/eEf8l7fEVVswAA0HB5v
	 JkmOCCdBAHGsnm0EwxsJWaP5w2V9nbkJ/14vXaljAeUpN4uSkJxthiwvgB9ZVLS9Cy
	 yYcJ8050UvAPxHW28X6g1V0gGUY4P74TC4+7xirY3jxFZSl3dTb4GfETYnGQSiMa/X
	 T4AqWxzXl2B7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804A2C44501;
	Tue, 14 Jul 2026 11:02:52 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 14 Jul 2026 12:02:41 +0100
Subject: [PATCH v8 01/17] iio: ABI: add attributes for altcurrent channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-ad9910-iio-driver-v8-1-36939c3c07d2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784026971; l=3268;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=ZMU9cnovPYUzplaaXs4eCd0C1BPEa1nJaR4itGOwIM8=;
 b=gJbb8BTSXDrN4L0kp6TPjco2CLWdGSBDoFVnknic2nfr0sN6my7Hifp9cl8VM+cCXkG7bELew
 ubpkoOCSVDeDfVtBO6s3EU/xZXxm3ZbKltzPBIEZFPLVraLMxz4fXFN
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


