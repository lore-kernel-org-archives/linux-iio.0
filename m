Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433897;
	b=lytEAYFmcbuLB1dmxd6vZ3opkMuF9ge/hcWW3dF0hKBnEZMHqrApZDg/ln5zPExdt0eH
	 Fz8xzpNyw7qRXUXW88jA10p/X3QtXe8+4q9tFdf8C6muO5ZUqvC55PY1QEswRhZVTiS/A
	 9Avn8rIGD6+SMR2R5sWoQqa0rESvzm1O/fndiPlyL6YaQM6jQXP2BAwnBstLeB/GpSxdf
	 Txrf7BpUmEnToj0NVe2ADHqfTBZkRotgZGt7fk+RD1uGkKdyXSzCWDuRONj6ozLGQvJAX
	 FjO+GZk1v4igaxAg3jHte4U1NQlekvhDk+CefC5MnLGPsvhjUHoTSEvgHdDStS7fWrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NxNZWpxJZ312FfsXfTrSW/vQmMkh0MVWaFRbIlwW5IE=;
	b=aOX1kocztRPHcCeExBR52UR7BcBxg5vuxcacAaGGeYmvf/fSHc3uhyd38F8qNUNj92Wu
	 uvMLxxVCtLGMG1fSwZHxvaMfBYgC3NyGKR04gAfCB9yyrjpcu66PaUEW+trYpqTHpgIsC
	 gtj0NxoOCkg/7HTJu9ShlanaGKF8IGdfej4g/ROnSfMg3udP91IkkeSCl0we0zbqG2ThJ
	 nlZbnv3xuYNTVf5nFvWBMprKlTKYtTgpKHiz+ssDCAknDR9XOmVcJO6UDWSYLRUe+FHR+
	 63TuPJA9mXV0oHxJA9klnAlDZtZrEDTB9AFVKWqicFAdj7F2vhRGoKiSEWvZhvcN4lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fG+IFkil;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A255606A321
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 11:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A255606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fG+IFkil
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb628232d2so1725325a12.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 03:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795433896; x=1796038696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NxNZWpxJZ312FfsXfTrSW/vQmMkh0MVWaFRbIlwW5IE=;
        b=fG+IFkilVhSgMPY3zBEvk6ihKTl85EQl2ZoU6FNnB0nVWZwBnAgAbYWJUcSoAIYQoe
         sJHnIIj1eR2NNGVfRtmEOun93SG+SblUh8Y1Ukgzv0LnkSKOSC9mzRonEUq/T+atLWFb
         uOH077SZIKELKZDDTxL1JoWNR8oXur5dYHv70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795433896; x=1796038696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NxNZWpxJZ312FfsXfTrSW/vQmMkh0MVWaFRbIlwW5IE=;
        b=M4Rr4GvSjbCXwST9kcG7PJuC7+7c4bizFYTFGMjsMDKIIQ9j2ETi6MnRbpi+yoeHRP
         YDB/zSlyWNRuOhNM7Og51vYxS8SwzGyhPBXIZQMmthG8mZMC2BLd5hJhqkZ1rO6Du+MU
         FJ9v7xRc3jG7T9jAAoZfUwGLYdnCAJQf81XZqc9Usx+tQkli4rd9c85zF/m5f2pAO8q9
         Gd5GaM71OR2iytHemy51rpr4Auiy2Sv2NJKZpMuoTTOPYYgyaQBfmz0ddIQSfgGp1ur/
         h94vJfsMkY0hx3wqdmREaL1jzoflV7cq+ooPRaonBmTdF0h0RVqMEBZkF8NSjvUPPCJd
         F4AQ==
X-Forwarded-Encrypted: i=1; AL+hErFatMknItWNi/M3rKlnSJ0VZjnbO4cpa/eVY60CU07P+GmKsy6YUWmyduX1gvync73R7IBq6NmV7S8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+G1NyiRjNphHEyk9LC+eaZvA2LKNLTlB5vRCClwl6yQ0mwWK/e
	mpG8F2AMg13SbRP5fCHadn6nrlL3+2ui+63jszNZp8RLXKsFzRBoBpqXHGtSa10E1g==
X-Gm-Gg: AZFdTZcH73X5aQvd3ZVy0LcWyzgALFLFq2alniGIa5ltfpxa2gkVFKL5z/CnY6LvU0P
	ODmzGIBcD+Dh607r3AkDzOQWaawygfIO9jABEwMK8mhRJ8fPsN+8ACgDxZbZNWBqttShjmYPBFk
	63Vm2/F6vAgLvO5n86ygtOPdaHfZknATBchLW8xnwDhYoDIGltY+/xqGAOgx/zYQGws6lgUNc+6
	rFVigTsEEl91mReg1s6cc1TMFjHE/N3iVauthFXK0gGLzZKLLxUJYXPg6O78fshfjAqAc8Qtzj7
	//p/J/aBJ+H1DVyC2WpMhf0r6N2lp8l49PKBcHch8I/n2ZhJ8pXr8YiTs6ZL51wcuMMSw0EBRhb
	NhmZSksJm4GPBXepfnSSi6T9bjZerPpihKDzB9KKAMh1lzKn8dvSe2tC9gWIvwVNxMUV4yZpmMI
	salJtq3BPP+FKlBxIFe61InXMv6MHQCrbwz1hahDY53XRrxjYiHk69PItGC2QBTPy5aGYFJfraK
	VvwDT8dxhmBw3Pukjj8fUwYwuJamd8Mb85qKXrZBE54aMwBffByFoee6tRyDvtXW4EPwWACLyPy
	2ASbGRlgwsm4DekRYPZSRjwIr5wqqOF7kFwwS820Y1Hu/t3hKrAjKysGh46F
X-Received: by 2002:a05:6a20:748b:b0:3f8:c7b1:688b with SMTP id adf61e73a8af0-4014d4579b7mr11406956637.34.1795433896023;
        Mon, 23 Nov 2026 03:38:16 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:ceb5:5e59:832f:d16b])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cde6cea770asm5097982a12.3.2026.11.23.03.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 03:38:15 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] iio: adc: rzt2h: depend on POWER_SEQUENCING instead of selecting it
Date: Mon, 23 Nov 2026 19:37:54 +0800
Message-ID: <20261123113755.3033436-3-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123113755.3033436-1-wenst@chromium.org>
References: <20261123113755.3033436-1-wenst@chromium.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit bdfc454e8567 ("iio: adc: rzt2h: Add support for RZ/V2H(P) SoC")
recently added usage of the power sequencing API to the rzt2h_adc
driver, and directly selects POWER_SEQUENCING.

This new Kconfig select causes a recursive dependency when combined with
the in-flight power sequencing integration into the USB core:

	error: recursive dependency detected!
		symbol USB depends on POWER_SEQUENCING
		symbol POWER_SEQUENCING is selected by RZT2H_ADC
		symbol RZT2H_ADC depends on IIO
		symbol IIO is implied by HID_MCP2221
		symbol HID_MCP2221 depends on USB_HID
		symbol USB_HID depends on USB

Power sequencing is not needed for RZ/T2H and RZ/N2H, whereas RZ/V2H(P)
and RZ/V2N do need it. But it is not a strict build time requirement
for the driver. Change it to an optional depends on.

This also requires a change to the pwrseq stub functions so that the
pwrseq_{enable,disable}() calls in the driver still work without a
power sequencing descriptor with POWER_SEQUENCING=n.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1d6ed49041ab..7874d0e78e9e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1631,7 +1631,7 @@ config RZT2H_ADC
 	select IIO_ADC_HELPER
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
-	select POWER_SEQUENCING
+	depends on POWER_SEQUENCING if POWER_SEQUENCING
 	help
 	  Say yes here to build support for the ADC found in Renesas SoCs:
 	  - RZ/N2H
-- 
2.56.1.831.g720f3f5937-goog

