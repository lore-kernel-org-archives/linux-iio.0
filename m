Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F973FE64B
	for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490502; cv=none; b=ukJ6MHJrcQVJ6aE2DIrTPT4UphlQnha+/kefO0Td4WAAX0LR+ElbqHTl2xhKQmo5/LJ+7nPTx5B0H05QMkXg2pNVekod+Yglj+Q/WmYOFx7zwyl37i+Im7g/9FzgiH+QAMDhj3mfkCUTBQgRI97aITtxu+pf1AXwKpLLKfS5sSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490502; c=relaxed/simple;
	bh=gZAVNAenNNe8ShNpW+y1uL8RlMk/a2pYRFQS9VthVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htvyyJVgmslMyT1NV4UYHW/kxZ31ANjTHemkYpQqI4pR3p+oho47xCo+7XuxT5580l9Aw06rfzdycqBLYKyAaTlegEMsQLxXOmFWCDYpOh+tG/bb0FReIHiQ/qn/aajW8XHbrRfT6UCu49p8qiQadtGiYDP2XnV1VODmb47E7f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/nfFsvh; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/nfFsvh"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6b5c374e5so944643a34.0
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782490500; x=1783095300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=P/nfFsvhHSJsm+luF8ljtXU6tiFwt1oEiapyTWVgNOxdnWQLRa2sMFZ+UBw1xCs0cb
         lrkPQs1Ef5DolOLZOlktHJxWSc6Vo2uLg1lkWixHesmfNURVtZJQmRywGpddcDm7Om9T
         RCLKRC61kLt97LnhvQOotpItDe1BSDzlnV9M22tb7FMG1jC41/8V+KxcpJibYJfcvhWR
         i22LvO/nv/p/EpkS9J3dLxsHFNhj8DEGzS2D38YYOnj1nmCcjKiwijb9sX04MEncbCbZ
         n71ci12OljcG4fLUqbMIba1xDo2w+2iMWKLAYx1irdyfuz+3BfkD0VFUolivq2dEYmnZ
         5I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782490500; x=1783095300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=LwIzq7yRn/vFQl0UhUto/6P18TdADMlPq16rFi3Tq6rvwuSjZJwQINcnv7Yp2tOAAK
         L0iAx8nfBaO1ZSwMY24ktYttqAKAj5WQXwIjolYlIzFkzOOfLMD7gESJ7+iKtq19+LEL
         Edk5L3NzjzLFw2n6MgxLQnNnJaMTEvC1mt8Vc/Uco2aKl+DPDISDMRHEG2vLXqUBMEXe
         uK8r/QS2bKvel248r4IxzFbi25EXdEBW7c1b3F1M0bN3asRSDvW3wyHS6xsRP86cIhaP
         BALlB7k0lO3LHKmXyAGdTN7Zt11SiqWe2RFSuplFmBYJeANDfv9qwwqbl8cEbAvJ3MLo
         b35w==
X-Gm-Message-State: AOJu0YxyfQ0/7lK7WxGpzYG7X4pHU/U0IrU9arGbirxmdp5YLUEfeOPU
	EEIfgv04IlsyV2+Qc8+mnf5rcHkiImUZ+U04oCAbqTsEAk+99xmOpAj6fCyvE5mJ
X-Gm-Gg: AfdE7cnQJ4xHKEUIcpcPmLJ12ViJhfNigKe/f02/j9gG38uZA6rCqd1KY+YvjPw5GKw
	e2JUaKAWPcFH4qAVim2gwezFStvRRRfHPgqTZjcRiF6nXrpHjJQivhS4uCv/RM7Y6d7Gn8Uh48F
	dUs3uj379t6TrEHH83blwriEYmR3SlzXBKa+vnmkh7Ap0Y/nCdV0v25T6wdlETFjh03zOo0IEW9
	LVJKHuj1hNpIYu+ydCFGpnuJyBH0KxJ+GTmJm55gAfH17K+EzTiLUTl3mtKWJ5MEeb924DaQEvT
	IyUhtJ2pOKcPhXZ3BXTk2TgYIhSuLR96DUFG3Kgz+MJ1d7hQmjp+DXgiL8uwj5+BaHTnXI4sO2x
	TJi2qigAFG0f1kCScwxcE+IwyNRJCz6wtrHoJS8GLWOg4saJGzlK9DcP6qmcJFUvWODr5SoruqS
	llxGKgrLjDvA8=
X-Received: by 2002:a05:6830:3156:b0:7e7:24f9:55c8 with SMTP id 46e09a7af769-7e99c88bc00mr5453019a34.5.1782490500202;
        Fri, 26 Jun 2026 09:15:00 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa579235sm1970211a34.1.2026.06.26.09.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:14:59 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V15 9/9] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Fri, 26 Jun 2026 11:12:30 -0500
Message-ID: <20260626161230.93069-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626161230.93069-1-macroalpha82@gmail.com>
References: <20260626161230.93069-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the Invensense ICM42607P IMU for the Anbernic RG-DS. Mount-matrix
was tested with iio-sensor-proxy and reports correct orientation.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts b/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts
index 8d906ab02c5f..b770bfd5268d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-anbernic-rg-ds.dts
@@ -871,7 +871,13 @@ aw87391_pa_r: audio-codec@5b {
 		sound-name-prefix = "Right Amp";
 	};
 
-	/* invensense,icm42607p at 0x68 */
+	icm42607p: imu@68 {
+		compatible = "invensense,icm42607p";
+		reg = <0x68>;
+		mount-matrix = "-1", "0", "0",
+			       "0", "1", "0",
+			       "0", "0", "-1";
+	};
 };
 
 &i2c3 {
-- 
2.43.0

