Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD543B8413
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209723; cv=none; b=NWOXNotKXhcd1KSRn6sKg09MuzS4ljlZxRPdRzH79i8fMr13Y8F7yeQkrAaEy18ZspAUJl+hX4ZtKznssu9CeskSO0DCNO33eMvrxW9u3WIU9LSqkkKqokQHt/sUk+dwnVbWC4bchBpi5eahxaAgYWAZ4uy9PjpclG/urUXdCGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209723; c=relaxed/simple;
	bh=gZAVNAenNNe8ShNpW+y1uL8RlMk/a2pYRFQS9VthVm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkBT0Cs2+DAZJdoXulGLkT2/thqPHix1DgEf9mjei2/Ob/cxXhR1aF66ZVIdxWmNT4/JLFT7XcgJSC4NaBxLD+BpSXp+EeBvBpmxEvgEV9Yl3HOlQ4kVoytsIQ/lQYCXssepyZ7dLDL7zNAMsMPdOWfjn5Nx8MFg6bgDzpunUYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/sGt2Ej; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/sGt2Ej"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4414d76270cso234555fac.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 13:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781209721; x=1781814521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=c/sGt2Ej5tHKFhjwxLX7HJ1YGYbdypP9n683MSEHmFv9Wys/Y5xhQGZyHf7yAUBwev
         h4w7UpHiNJ1xGMMDwYHViPQz1N4kQDBrZxA5af1xOgyieDmBT/A5TjCKKAjvDKT845BW
         u304DGKZsgQ4UuMCvARL39AP1CPJB7oGmC6+nbjxxA3FE+5NHT2xDlWQGOxYUDzc8LlW
         NS7NwOB0wNttMkq3LF0FTv2Kb5jc0Cfru8tXcrOYwfCUkBwtmbzvTHIvURr1IQnkwMtP
         w79lH4sVPInvO0H7H6f4jlvZnM6IbMcTanYykCu0EL6NvbkQBtQW8GHdB0hCJxZZ2VIM
         yFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209721; x=1781814521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0mdfiM3qjdIeg57ItkPiqiLUsLGffK5s/s59dcT3jw=;
        b=XXCL/ebjna4hZh6Yb7ebZFUbJhWmGQQ0fpUPm5StRUZfQZDLMkPzK94wAFQsneQZ5R
         bFVw04nMrQXujZn1bDUTrHzFdJ6hM9vs8ua5oY0m7GoAXrexEWXuBGEyLgG/4tagmNnC
         H8s1J5XZHmqzTtmGcJyvUOFqRiM0DP4B53EkIlC7YQ7eM3YE8bv5vtbDu+0TCXaW2Q2A
         ps++WvfNQB+aR7R7ea0vHS42p5Oc0KPAexi/CtmceLb3SSOBm210Ou5tgwa6+pmyxBCs
         JealzQ+HCAg7JnBKTqYOrHjsGlFInKXzdp+7YiQHsr2xZcBaqqKIGWN1dxbAOlEmO/nd
         bjXA==
X-Gm-Message-State: AOJu0YyknlTQT962Hsjvi566e8l42R8/a0vf18nV16aIMpqaBWz1/CQN
	ugto//e9dhx6Xufyl1H0X71sfcoW8ZvMGrD5oMtRFZtssieOc2bnlsgLTV39x8r9
X-Gm-Gg: Acq92OGMDJneKtHO08RL6JRT9+5xnZIRju9or4DqgSHdHSqJvR40lSEY/3nSWM5FDid
	ZvwCt7cHwtvYtCMOuntHVx6EdJdLs8UUNaIm0cU5T6QQnyui8ejYHoAs5KUNmF65bG/0BBDpSoE
	/wtzUnCg/HZfLdGClY21qAgpxM5VIa5/m0j1JqXMIOH5e8nCmcmTWvB5HFrxegtD0AlIvowNpm/
	PRmOqVtq3OorR2BBIeDvLsF/uBks45sDUQS+ifbGUYd3s6je3BOu2OqwW4y40rRBRouWpFHIQg9
	noMt2fBYz3mv8XVXtdt8IMgjqDj/z/b/PhfGRwZxhJ7m3TUG9GoUVg+ZpAKTcXf+h2THy4i6J1n
	PcLFdvIc+l5xas6QnKv7kjYivCN7ljgsez32noP0jBeLc54qtpzEWYadH+YFjhR6uV2XB9zbHF2
	g0CL7hi4A2jkkn6HBsyw+CYw==
X-Received: by 2002:a05:6871:a1d2:b0:42f:b21f:22fa with SMTP id 586e51a60fabf-44241da3288mr2990319fac.30.1781209721191;
        Thu, 11 Jun 2026 13:28:41 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44244cd05c9sm1796134fac.18.2026.06.11.13.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:28:40 -0700 (PDT)
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
Subject: [PATCH V12 9/9] arm64: dts: rockchip: Add icm42607p IMU for RG-DS
Date: Thu, 11 Jun 2026 15:26:06 -0500
Message-ID: <20260611202607.85376-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611202607.85376-1-macroalpha82@gmail.com>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
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

