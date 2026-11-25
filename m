Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634672;
	b=Ad7y3AvG1BLdcI7WFxni7OJiEGX9finHwqwca4Yna9hMVnNNC9elZ12JMq2/syA4dmlm
	 zIt1dmxNQhpo8VAAl3sHoLXNYMfBFr6TmKOBznc9Ye6esceFBH98VPmbp75XJsissArH0
	 18OVcdyIePHaCTVi+5mxHM1HJZ3kD9GupgLtkipBGZBoFhLumy79co7sDTOjJNSC+2oo5
	 Y8HXdatC7HPDJ6V94hMN7WpvRdmEDdsLuuIhonYTykGBaW/PZ4I2HKfEgpCHE4WVpc54k
	 FubyzDq47Vqx9uOjAjPrqIBZfhQQUxhLM3faJGmzbZXxLT9T/Sfd0m/7gPk/E9Dc1uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634672;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dQbWlvbH3b3NzDRhv0YEUu//Nq4bfBJezW3vKPLjjVI=;
	b=RR3BpGcp27EZtjl0POxRh709xwAOLrq2W2NlbgYjl5F3Jr5kJUeFZB6i01FEIjcBraTe
	 1D5i9UHf8VvdXTv2eWzo5Fe4Om2tVhHPneDsVacVhELwWLhUwnOyOmMHi4S606gbjmRaK
	 jodpajq2Gg7ZTbKBA9b3R8NstighutzwBaD+39PRjA7XKAG+riiQt3Dx8jplY/mIx6dky
	 x3DwvZF6lJPtcoTrQDVPPpRZdB1UETnzzBDe2CqePqTktOjoDgSiFIpDlACUYu7BjKKT3
	 Tj0OGjsJFyIoWg+slA5O3F9NozIynk3eOnpQ5cPj/4mber4q3s1othJCHCwKi3QH2iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMp8Ft3S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27DE60A380A;
	Wed, 25 Nov 2026 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMp8Ft3S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CB01F0157A;
	Wed, 25 Nov 2026 19:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634671;
	bh=dQbWlvbH3b3NzDRhv0YEUu//Nq4bfBJezW3vKPLjjVI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PMp8Ft3SLxuIY+dcqNlbWcf/VSXYTaUFpbXWCEnvAPTSb7xa7vUkMdFAJ9l6ez0Of
	 ykSK8UfYv989KxXIKkTp/KRRqZFBkxvVBsYWg0f0Ty9Z/OqvgkeIJUy2J1NSZMtyxx
	 NIh5Tb05JTQ+4MgKFgPYsQMM5KDFQVWG3fuHnYaQgl3zsGM2fEbJ4I3diCR4qrox0B
	 OkPUAfl1Bb1LPgUK5Vu2D8qvYz3b3fvPZHG/DvNYA6tdxYovlqlO+WOdggndn+l4ZW
	 NAFHsWCMHAS9Y55J+Kuyp2tv2QoNFiDA2PfcJrRZhYGr1ES4Gyrg4evU+4pF5yik+i
	 kiFVnOIp4jmSw==
From: Joshua Crofts <crofts@kernel.org>
Date: Wed, 25 Nov 2026 20:24:06 +0100
Subject: [PATCH 5/9] iio: gyro: adis16260: apply iwyu principle
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-gyro-kernel-header-removal-v1-5-969b3e668d35@kernel.org>
References: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
In-Reply-To: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nishant Malpani <nish.malpani25@gmail.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795634652; l=891;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=SPceEcQ3n9KU9S4gmalPVXrRDxWUwLiiWAb5PjgwFNI=;
 b=OeLLSnvwWLcovVyBTiqGVKtileWCro3IsSAj9gTAq21jzTEkWC7XPUtlpEnJMZ5xDnG3vn9iB
 hsy26MUf8OqARma0LM4zitlHOzlshW6B+Wn4fnEXB8CwOawGBkk5hfP
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch all kernel.h header and add/remove the remaining
headers in accordance with the IWYU principle.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/gyro/adis16260.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index a79a8edf4c98..a7deccd6e55f 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -5,10 +5,13 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/spi/spi.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/imu/adis.h>

-- 
2.56.0

