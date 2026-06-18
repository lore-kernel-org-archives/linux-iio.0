Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E283D9DCA;
	Thu, 18 Jun 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789269; cv=none; b=Ms2F5vpimz2Av+ro6qvK17iaUW+anX958Xs2fM7qziZYj7qDFHJaPyO0uNEVSUq31C89ZZ9JTpCjUqhPrDrPW3TXxEmIFTelcm0HZtnCzb5A7op6LsXD8ayv4jvK4yc5kz50nYLjZcI+tEXF7LFRYnaIk2HafWtUrRwvLxQNN7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789269; c=relaxed/simple;
	bh=gOthTCmaN8MgWvmFINoiZtjdlR4EYR2HD3qQen2NgxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ne3Yv6FE0lRCNlO215RQ2TonXNfuEZxAk19w1sqUC4XkaMjTC6YIBKlaK+DZFdzruOvmvZhvPl6IYI7D2WQ2evHB58E4DoIyOCIA41YznKKQ1nRHJzj+64RgptOaB/A+CcWY2pfoy+DWp//XwBgBIN7AFyEW0bG5sHKIC+4BoNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGswxrjA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGswxrjA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F905C4AF0D;
	Thu, 18 Jun 2026 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781789269;
	bh=gOthTCmaN8MgWvmFINoiZtjdlR4EYR2HD3qQen2NgxM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uGswxrjAhCvfhabeOXhFB5JYF15rkkj6lDAfcqUSuw+OCDoZ5tPPL4OzyaAKJn3z6
	 VY4CQtQecyWLfJQpavcv60XmaMmrYRmgcuOFSScGhQxqoib5tkrJbNkBJi2RcKMX8I
	 sWl7ZvvamLbWwAD9TWo/+JSjYm1c0Z2ZyYzlq62mflR2EHEBuUGkJIDjH8pNlEZPWi
	 g32kxU0yU6RhpKNfdZTmU1shS3gPXlgs7PH3PEKHYRyFdkdtypIRnG8UxJJWvZ83N3
	 QG3cKCL5b+laE6kC2l7AOs3S/MYXa6viY3gkpiC7u9DwRLXtteh/sT5E1GDj6b0z3S
	 pc1E3Mda/91pA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FEECD98ED;
	Thu, 18 Jun 2026 13:27:49 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 18 Jun 2026 14:27:18 +0100
Subject: [PATCH v6 02/16] iio: ABI: scale and offset for frequency/phase
 channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ad9910-iio-driver-v6-2-79125ffbe430@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781789267; l=1866;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=7KsgsauGbGCdI/Pov6cgZztEKHr6MMfWt7SGfdBNJms=;
 b=whdHJtJBftAIxFQ8gWH50o8+yAADmc7bWh+vBm9c1aBV0j3uPIl4OtawNUubxp6Wjo3Qibkcf
 02X0ytQZh3JCsz2D8xR+fevSMjBiAC28Cr/4NdDLAWy5C0I3n+UbqbI
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Consider scale and offset attributes for frequency and phase channels.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f52db6abcf31..d9c4e3b53f29 100644
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

-- 
2.43.0


