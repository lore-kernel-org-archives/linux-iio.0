Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F9F43DA49;
	Wed, 29 Jul 2026 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313631; cv=none; b=Rx/jmI2M/oLSd/U3IWVY1qu4ZZg0eh0n9haxo/jeb9jtHov8t+M3M+928ydG2DpCthmkPozlhGRvJv/5EN9zW6ZDrK/68RZ9rN8f5IDeKjo2sstUmJXq6rAL7qM7ZxIEakItRt+gM7nrgR7NH/MWB96kZVHuiN894qYCik/cgF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313631; c=relaxed/simple;
	bh=gUe9z9eeno/NKDkm6/191gj6dt3Tu4dKrv8Wd5lfPp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGdowU+apWL8gJQDymLNWrYmODyOb+0JC0sQySmb50CWmENGELxUBam9aL3D8zCfLGkEBAoZR1oouqZ++emiNMX15xFDVoIZ1RLfD0LXlqQeqtsSnpsfP5abKzZrP9rt9QejURfF+MawPQXRAwTgVu38GQUqEH1v5pdu/0BSGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbST348B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbST348B"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC76EC32782;
	Wed, 29 Jul 2026 08:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785313629;
	bh=gUe9z9eeno/NKDkm6/191gj6dt3Tu4dKrv8Wd5lfPp0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WbST348BS8fxEkvnmIdsYmyySKq9tYlw5BYVIa6DbLXOy4zjfcvCzS6ph2vsnd9Ab
	 BH84HAGDkJV72awOUfMzVwXJxrrlu41cJBfiFPsmBUa7s+fwXMENg9WkDZpF1kw8Gb
	 rzJp5Ekeh06nD0CkJFbY7HZUrfWGiAy6R/UjI9gLJGY8Y9ET85+pBcRHu2/wpR9DIx
	 Dzbw/oelJr6q0gQiomy8qE/e/bP5Uobo7VAaDq+KqGHZgS/87i746VEmyR0indZv8r
	 Be+QnwtPpVEi0ueN5sAoDazxBM0b1gFqEibh2H72xh3rxwqnN7o47ODUGB++on5ODH
	 S88SzUGDRnAfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C330C54FCD;
	Wed, 29 Jul 2026 08:27:09 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Jul 2026 09:25:43 +0100
Subject: [PATCH v10 16/17] iio: ABI: add docs for ad9910 sysfs and debugfs
 entries
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-ad9910-iio-driver-v10-16-aa1f6167729e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785313627; l=4219;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=RWkt+CZ/atJCmJFD35sIYFcjBZDuLrdT2GnoWo+bZpY=;
 b=FfzXN59V7p+T79jqAZPD1XTAB1mwsZTor48mMGJFMN+i6Na3scwJwRkgAhqAVzclOF7VXMZFJ
 Fn/bXH7pe2FB6fjYfs/bxdboEIR3Hp6g/Hw/ED/izG3ycpnlj7+PkP8
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
evaluate into source channel labels for each DDS core parameter.

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
index 816ccfaa88ca..d671c1ff71d5 100644
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


