Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9864183AE
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544498; cv=none; b=gat/i66pR/HDCKtotUxgpQ2UTYqj2AQqHIfD27RzJZfi3z+wSFixV+ERms/ROj8LadsqSh3Fm2SYzfTs75skY6fFumg87oIauAi2ajFhkUGjuTnsnZU8vaKX7hj5BajAg9PIrLxZMjVvQF19+rz7DRt+as9cutRm5a1MvQDZMr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544498; c=relaxed/simple;
	bh=gZAVNAenNNe8ShNpW+y1uL8RlMk/a2pYRFQS9VthVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWGh8ySS4LoqeEkOnQpURcDfPrF1drWcUk3byli3XoHhBImAY6OLn1O9siGSquhK79foGVmCGBtc+dzwSPT0pSGUKkmXeq8j0Ofvs8e5SP9uL3Cgj5rlqx2PEnL/plXNMQ5nB3bSERPpWXZT6+dLyTM+t2MsjeyH5YKnBATBFX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foGZwCUj; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foGZwCUj"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e8f690f53aso425544a34.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781544496; x=1782149296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=foGZwCUjEc0RAu1czDpZu/lSpWcQbC84JqoT73ahAZHg55btwHwhZKt9F3fhXL2D8Q
         mkzpiGrVr7b6gVIbQmM8KPjOoGgvfdbWT3x6KTY7YSSHEJsGyYVx/KjAVAi+G7LxN7+K
         gYQTliU1WWmYZH0UjpypjntObJHBzTwMlAOafbh5tYVqXPEdC54Pec8NdWLgrS/QUmoA
         uNZg/ipznkS4OUWzeKjG3ni0wAjwFgavxgz43tuZBUfBfUWTUTLhtDPP3ZOIVK+SYEpV
         qicy4TfomBwdhUR6pIfOzEOCKVRSIij1NPoJsPre5az8TcnACmgA3mPiGl9tviqApioH
         DmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544496; x=1782149296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=h4/QQxl6gSOGqu8mEMKUS+6Lf5pVCqcxc8214eJ1shzbOT3JOBbaqPoCRoB8BneY0O
         F0MAe96wQjwpShupVZPJRIbO000AZS3Z8l7mrdZsIjS5L7Ugtb2CF3MChX4Z+Fn1SbKU
         NZIzJQ34J2oYeMSEyizPa0sZagtOzNvPoqJnAZEwKfnqFLTL9dHiZ2wTSQRJx8eQph9H
         v0iNUGFpDmC2rTwpZYkFhpmeCQj6khtOYW/DoVB1wkijFW0DG1wLvCbntHb53GYBGQbU
         slt5RqlvNWfV0xYmSBEPbsTtbk/3lFCJn4fsgrV/UhQpt6NZvtOPKLSJ8eIwdvg2fmjE
         oW8w==
X-Gm-Message-State: AOJu0YxvdciY0jSGQQFvuTa5/L00HUTn5xJXW3//ggwxx7EctaEpWn+4
	nA4tifxxvDHq5Ut5EAx7Ytgt3osJu70FZBetm3yTFKTWoPSIHx2b48G4uiaoLdM3
X-Gm-Gg: Acq92OFnUsu6B7Jd9udt1f1Bp8vISE5eW3hi/5tJHdwa2UvWeP6tYbwv6L1wX09XFQC
	Kld+TpsnnVEcsTt0XfWJ1zlOwU/vR3uJRB7yPmMAfXKo76w/YH4XV8X1yK/7Fy/vsVZVQB+OJwe
	v8bNEh/5Dakg4qpEOJJf/ysSD5F96awW7U49zU6kHdBZYVFHpurgHULq4k83a6JmeyiLS0180Kw
	FLThYbjItgc3Ual3kx3aAbJGNW1UG78C2ZXtiAkV6DdKMdd5oKox9DSWdPPI8hKq7jzrgyJi7HX
	U+vU177jELTPJmtqdBZnots6kLnfNYb9SLyN1T9xzflDbIYmVDMorrvjWwKHM8mXRi1TcTZNb3e
	1ljjgZ0PD8lLNjLsd5ccnLHbPblXYwJToAFlijoAIOYcRHAlM3cOFCUnusbYHFOEmdjy2eHvG9l
	Wo55zfCLoftsFT9ptH3NLgOQ==
X-Received: by 2002:a05:6830:230b:b0:7e5:b3f6:c6ad with SMTP id 46e09a7af769-7e78466e990mr10539475a34.4.1781544496051;
        Mon, 15 Jun 2026 10:28:16 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f451fe7sm4480033a34.0.2026.06.15.10.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:28:15 -0700 (PDT)
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
Subject: [PATCH V13 9/9] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Mon, 15 Jun 2026 12:25:52 -0500
Message-ID: <20260615172554.160910-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615172554.160910-1-macroalpha82@gmail.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
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

