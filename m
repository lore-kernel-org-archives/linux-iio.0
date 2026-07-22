Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93F4746C5;
	Wed, 22 Jul 2026 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735458; cv=none; b=I69UKA3JfMhXtAPCVFNBLviTT+VRF8Mc8jO8qAc5kj/+CadC9ldPWZjvdUsJevTfE7oWqVWNVP35/HKJjvQ9pLXcXYSspwCruORe4nRP0x81MbYIMys2yPVYBVEMYD0jGaaJsa7l7ScsJFEU7LEWUx6sISHCr/55Y0blgSvtF+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735458; c=relaxed/simple;
	bh=8V9+BsSVbTHZfLGi06PqZVikcnksNRPWkUmpnuxzJzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jVhcfB8CD+H0wsAagCqAUqK2tWslSN3RpT1BiJXZb+k1zWqzUJxklHcDCz9OM1y0MLfnP7WCHOMnvruGsEyckMUxF8SlRH6DyyZWcBY2N0boe3pcBw/X8DAAbaZk1ciaxJIH9bV3pJi37uVDgWmQrUxQj6Z0qeqp5vwiRQ0MAXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pn4JAYna; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn4JAYna"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDA01C2BCB3;
	Wed, 22 Jul 2026 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784735458;
	bh=8V9+BsSVbTHZfLGi06PqZVikcnksNRPWkUmpnuxzJzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Pn4JAYna8q+ncOjlZ0hH8qNZrdTt9fqF42S9CYCnMkUkJJtON5ncMJqlbGNcNNNQF
	 L0xguONGhWmTqHnIBikAG+R9yGqxOnkhYLxuFiRNIYKyJeCLWdRQtVvbLeasPhzwqg
	 oLzYOK6trKX54KVhvBk35SO/lZsKhi757Uy8hkZ8PDllI5riI67bIHbHFKMxXzB1xT
	 FIC5d/6xh48WJx33RVaS6yhNV8ifx0UyIB/Ig2PxaETT0nlhsEW8+kgQp8Pph1R0w5
	 5ChiqYUVxYxTmdOKnibvnPGaL2gtZ4KMPOYVkEZ4jJuNBSS2Gk3i/eeaxxAendSvGF
	 8gS0NpZqCy1Bg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C115BC44532;
	Wed, 22 Jul 2026 15:50:57 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Jul 2026 16:50:12 +0100
Subject: [PATCH v9 03/17] iio: ABI: add parent entry for iio channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ad9910-iio-driver-v9-3-459d1df5ac56@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784735456; l=2407;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=KME4lbAmZLS+7H2VW8Y9DEQOx4E1scOeHoVVhQsAaYw=;
 b=L04fTjudyOWSMvXiDXgK71k2VGi0FnOVgiweMpQUpSHbEUeQToW/3UYcDpctqTRyUIT669FS4
 ve7if/K2EeiBjUKoxdxVxAqD9EFha6WYkGg3BtCmXQjlccQfAdrxcN1
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add documentation for a read-only sysfs attribute that allows to expose
parent-child relationships between IIO channels.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 24712b5bd110..851887e85cb2 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2165,6 +2165,34 @@ Description:
 		specific attributes. This is useful for userspace to be able to
 		better identify an individual channel.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_parent
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_parent
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_parent
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_parent
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_parent
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_parent
+What:		/sys/bus/iio/devices/iio:deviceX/in_altcurrentY_parent
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_parent
+KernelVersion:	7.3
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute containing the sysfs name prefix of the parent
+		channel for hierarchical channel relationships (e.g. "out_altvoltage0").
+		The prefix uniquely identifies the parent channel and can be used by
+		userspace to organize channels in tree-like structures that reflects
+		virtual or logical relationships between them.
+
+		For example, an IIO device may expose a primary output channel as
+		"out_voltage0" together with a set of profile-based or mode-based
+		subchannels used to configure or compose the output signal. These
+		subchannels may carry common attributes such as frequency, phase, etc.
+		They do not represent physical outputs, but rather logical/virtual
+		channels grouping configurations that affect the primary output.
+		Each subchannel exposes a <dir>_<type>[Y]_parent attribute reading
+		"out_voltage0", allowing userspace to group controls under the output
+		channel they belong to rather than treating them as unrelated top-level
+		channels.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_frequencyY_raw
 KernelVersion:	7.3
 Contact:	linux-iio@vger.kernel.org

-- 
2.43.0


