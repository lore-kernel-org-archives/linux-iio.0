Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDCC3164B4;
	Tue,  7 Jul 2026 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433067; cv=none; b=V5Y1HAYfzQ1GMtPny3OiOAZmmyo4X+RoJT3QtYjsuycVmxeXX3VwPQxKi7sShwq/ZSaZUiovmAp1z6UBidOk3oakGwaKAdtqC84RYmKVEwRubI0VlqDIrC7KKTEFZimhhEf4LRJ4ITEJvX97EWEzHx0twlCRuyVZ2havS9jlrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433067; c=relaxed/simple;
	bh=aov2nUaUONt70zcf6hBxV/T70QbH5i+7HmbGKY7aRE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U45qu0DEUtKjls8bP3izgThqUSux1e3rAXIZcgaah5Fr51Xi/pkL/LUQrfvnp19rA7I39Fy/8eXbU4IoEW6mVm43mY3v5NK2yrE6+XK1KM0bVqbUwtUWmtNoSGZ3zHxAXk2j9CbiGu8ugXgyy5XauDx4KSYpE8MiujX28r5S488=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTbtyTm7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTbtyTm7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6766C2BD01;
	Tue,  7 Jul 2026 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783433067;
	bh=aov2nUaUONt70zcf6hBxV/T70QbH5i+7HmbGKY7aRE4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cTbtyTm7OfFMZufgWiYx+QPefbbsQYZBcBdh6E04KjH7kNtwj9PVnWoiK+Cn3zR2F
	 6z0TS5sIHGfyR+Fl/DjcP2EFGu/JskwM8Vwb5aEImGTeHIdk13oiKC2ZLPsYtjxFlG
	 Z5M8GYFMOGyP9g0LvwXMP84HwlhKThkMn1fglk5o25NODhmJlAz27LCTEQtzgxJTGe
	 5dxyfUx3/dO0rU7at9kMQhz/QWhZdIytgVtGIcrHJKdBfW5aNVviDJQOE+s73CfT7Q
	 LuSFzebYDg7HiVRCSgkGBgJDqKwR4iMzC/dqqJ7YU1E9Lopymo6rie3CmHJylU9cp/
	 OPJ4lj3eQ+1sg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8224AC44502;
	Tue,  7 Jul 2026 14:04:27 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 07 Jul 2026 15:04:24 +0100
Subject: [PATCH v7 03/17] iio: ABI: add parent entry for iio channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-ad9910-iio-driver-v7-3-a4ec30f63700@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783433065; l=2385;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=DY+STjkTnnoAGyxIibkG9JOtvUkXatKsExLxx5u1emQ=;
 b=XsIC93HmljKwM4u833zlB8qcE7H4jvsspl3jHJ7cT+cQtnYlDteD2W1ZfPiw7qYFK/V2fUXU5
 ZLEVLYKhdVaA/kwI5hpHr/u+rpzZbqbWtgq5/xvK0heGenTb3qHJLYh
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
 Documentation/ABI/testing/sysfs-bus-iio | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3037b8b79fba..623167355d71 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2155,6 +2155,33 @@ Description:
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
+KernelVersion:	7.2
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
+		Each subchannel exposes a *_parent attribute reading "out_voltage0",
+		allowing userspace to group controls under the output channel they
+		belong to rather than treating them as unrelated top-level channels.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
 KernelVersion:	4.18
 Contact:	linux-iio@vger.kernel.org

-- 
2.43.0


