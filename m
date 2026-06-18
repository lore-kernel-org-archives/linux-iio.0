Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47013FBEC4;
	Thu, 18 Jun 2026 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789271; cv=none; b=JhZ2JBtP0fTXeTPqRJTcLX9tOWCenOKmCJHn9RQakcE+ErYFVH+WoqTxt9kH+Ann0ovaf8R9xe3SNk5Cllhf7ZkJafWN987S4/a55rwLUweuloHK3I151mPydpqq5iRv4XTSNXtcpu/K6yaDxdlV5pDx5wDFJtIdidaWxKIIOvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789271; c=relaxed/simple;
	bh=TvcJsvvaigww5PWGlnwsOVn78tFBfosRNvJALUF7z/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iIb65iS9B7lPSK2tXQCaFSs76kmM4jF7nW6KSz0AALoDJzF6dK3Ukc+wKucbugqyLvIfRVUnqTIU55ojdY2iQ+nKo4J7tDal8pnedIE+t/MeAHniaKGXHq/+SdwDV0GEpvBKc7KJR0u/qCM/H3r0lfbDOfURu4BydiOBNykA9hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+HpQ2KP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+HpQ2KP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0450C4AF0B;
	Thu, 18 Jun 2026 13:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781789270;
	bh=TvcJsvvaigww5PWGlnwsOVn78tFBfosRNvJALUF7z/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m+HpQ2KP1gn6Mc02QngiQTp9irX65JKhkeIPi0sp098jG22tAxmRQR8vs4BaQqqI0
	 FXsU4tAW3VKoZX2uGqP9kG6PQo6mYLupp+dTyMP7hK6kBItYgD3wKtW4bgs80eZHHl
	 zy5WXMum7foQs4330rr2BoJM1WhB54tmrUq8kHCoFzKmBXNexmd2pyUvRAnmKCM2FC
	 wYzgMNX3kLcLXSAOqCRAdgr9OMa9fkp4CxV6ph5a7dqbF3l7gqftBAAE/5zJx5tm+l
	 442s6QpRa5GGKnPoyJHqeSF3lRtpnV974SsRH9ndwH3u3DarOc5uh9WDvx5zJZvxiD
	 BJoK2xkgGA+rA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D04CD98ED;
	Thu, 18 Jun 2026 13:27:50 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 18 Jun 2026 14:27:31 +0100
Subject: [PATCH v6 15/16] iio: ABI: add docs for ad9910 sysfs entries
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ad9910-iio-driver-v6-15-79125ffbe430@analog.com>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
In-Reply-To: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781789267; l=2448;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Qx0Il4+U5HGLjGaisCVJ5kTA/vX8+mPuBjzgePK51fs=;
 b=zUHyLfseHuYKjLSNhxyTmuSV7alih/K2k+NXr4/KSK+8kXKB+2ophkBcnAbkTfAdSzCtYBlUG
 4FKywUxXX1ODMFTeF0EmpvHKMdBNSchSGSf1jLooWYSQsvmxbB5fOYY
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add custom ABI documentation file for the DDS AD9910 with sysfs entries to
control some parameters from the Digital Ramp Generator and OSK engine.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-frequency-ad9910     | 27 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 28 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
new file mode 100644
index 000000000000..a54afeb64302
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
@@ -0,0 +1,27 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_dwell_en
+KernelVersion:
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
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		For a channel that produces parametric sweeps, this attribute controls
+		the rate of change of the parameter in raw units per second (slope).
+		This value may be influenced by the channel sampling_frequency attribute
+		if available. Multiplying this value by the scale attribute of the
+		channel yields the rate of change in physical units per second.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_raw_roc_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Lists the available roc values for the channel. Values are
+		space-separated in ascending order.
diff --git a/MAINTAINERS b/MAINTAINERS
index 9b8cef7923ca..a76a15f02183 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1650,6 +1650,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
 F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
 F:	drivers/iio/frequency/ad9910.c
 

-- 
2.43.0


