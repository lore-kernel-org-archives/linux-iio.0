Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D043CED2;
	Wed, 29 Jul 2026 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313629; cv=none; b=NuyS7pzKGEhsM+gjUJJ31nym9a9Lik4dszFdevb/emGOAmwKFVexrfkfiTTB8CT9TE0+fpEll4ASwX/IpZI3cZY9ypEYXiPb9dKdWpX1URqxy7uuCrcsq5iF/UCr/TR6dxPZx8q/uvBtP8L9nZv14iJyW+48eaVWV0ZULc8U8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313629; c=relaxed/simple;
	bh=8V9+BsSVbTHZfLGi06PqZVikcnksNRPWkUmpnuxzJzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SHtOoHUZp0lSg7T62JnU96cp2B8GOlh9ErlVMbGd8eclkf/LIjXUg1UQV6fuBgakkjN1Ekh2y+QlnlVK0mtWSYGGGoanj/lARqjEYYN1CwjZm1cUBJ0KqOPJQm6MHKi/9ryjUQyiHFCdgx99DpTMua7/UmlEi9q0WPcwaz9C5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi5apmkG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi5apmkG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4A52C4AF0E;
	Wed, 29 Jul 2026 08:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785313628;
	bh=8V9+BsSVbTHZfLGi06PqZVikcnksNRPWkUmpnuxzJzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Vi5apmkGusBMGcCDyo3FAxMx09nhlCwm3w+gyzow1Vv+uxNrFjettnsWaCdefrCDK
	 7KJZlByV57TaWAbJcvpPY3AqLkW45EOH5J87P2mTQhYEj58GuHQr17/o0jr5b8s538
	 QeMUi/j0xL6Re3VjJGNn6+cWDRskYZmaOImOieL5hudvHEp//2zSyrJ1rVEx/x+Ved
	 Y5ww9UQb52dNLwLmaQ286KQjnFi0e48NFbcVRsRQLDQGeOiciXpi2Gs+rYNBZceTCR
	 rHo/Jc0wsA+xn7OfaMmmVnzB1sB/XtKR2aH1Gs/SGa8FePB/xFvBchhh+cff5DOnVC
	 oRuHLQ7zHkxHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7572C54F51;
	Wed, 29 Jul 2026 08:27:08 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Jul 2026 09:25:30 +0100
Subject: [PATCH v10 03/17] iio: ABI: add parent entry for iio channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-ad9910-iio-driver-v10-3-aa1f6167729e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785313627; l=2407;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=KME4lbAmZLS+7H2VW8Y9DEQOx4E1scOeHoVVhQsAaYw=;
 b=71mA8FcGgXe8BfcN6NKdo9L/aTzwwGtxBhBCstWFdW3wmxa2OEWcjlzrWZVj8qbfXAZ4th3i4
 QY28DPaguV7CMd2EzacHipKJoyQSe5bsxnYfB+BTkEYOfnRo4GLbvBr
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


