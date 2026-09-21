Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FBD5013A6
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015516; cv=none; b=QZxws8tMoaOThL2ciZlDrzF0jb1Liq8tzOrUlfM3r7oINleEey0IBasUDfIaR1+EkVQVCTWSIEq9uadtBAYzTSnnaxy8xYUYuaM2GHd9I193Jn4LhUwM9ey5TDdy4H+lmTCzYZwxxqdUHAs+HVrJzOHXbZX4m9eWPuID+w4J9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015516; c=relaxed/simple;
	bh=LSoXDOkihoTe+1aeuwkzPsOIbGrXJATfUTeqR5S99lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUl1ospBW3M7PzCZPBATP1dMCjkIzjPNpNx3Sllnuwjr1szjwJQ+HUU+YOzXDLLSURDPCBDJfcNdN98FSqwnTlMMKlvX/euzfmQu1tqmAxwGR8keuJWboKlzxOd3Kg/sB3B/7i3g5hBvhN4492/g6OcOr/143KFct72+as2vDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bukcw5U2; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bukcw5U2"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5b6840edcso29269731fa.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015512; x=1790620312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pj32bFFZvi2cnsgj5gH1ddQyBwu2DGpSO+g4f8bX3TE=;
        b=bukcw5U2BMEzqddWjFZb4eCDOHSaUNJAW3Ez+KxEeIy9UzbyXV0ALMU+D3QuemEMOq
         cAYAB3ivTj6oEccm13sruXlx1P7pgisUaNGRD4M/4rAOKEbt/Eb5LYlh4379Ml3j6sMa
         4JMLTyefSFuWQ4J/b7JM9krGmpzgXX85aAPak0P6FpEWlLEGn3d4AMnUUIhnhQQ8iR9Q
         F+SEtqQ0iKoIlV2fAnEaoiPyUB3hWG++w+gDHSTitjBjVmcWm4B2Awcw3uCXwEkFNNRy
         b3x5zUGv6jor4NpuWO/NpshT03U6s1erTl5nv9Fs8piR4KKcpSoBrKuyTdOS2rzBWm2w
         ivzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015512; x=1790620312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pj32bFFZvi2cnsgj5gH1ddQyBwu2DGpSO+g4f8bX3TE=;
        b=ybYtSGx7D0SVQBzNUUPhAp4lVj1ai1q4EuyR1clVLQYoerkZwBRZX0IuCIJD9yPkt4
         Y44E2zGZoAJEa5PPBl6zJ1vzoJswQYe0RKhT2WYGAivp2+FJpzhQeBAwz033/Vwcozh/
         dLZcuBURUmoVDhPcJ3d/cmOKchitF5U3E09pcFyULnpEnWvSaMv10TUHB66PPgYZy12E
         Kse+nq/D7dU10UO84aH8OhIRV2mM9t/Lr5AgNK5YuxAWiabH+p98fL1FMjmtNYEnQ1Ge
         t16AJGBme38c558ubStv8E3hWMb6xTcUHumeeaDDwilRsL3GDAkyG/WgcE8380gVLVP8
         EwjQ==
X-Gm-Message-State: AFuF++lpLh+RHLJkrq0w4dVqknksitivdUijDhf8p23PB7e9grdo9yUU
	I1PaQ9MjaVD231Se+JBKGr+aetleWaoRjIXmhdQFHEm9wZHLLx5ce5Ey
X-Gm-Gg: AYBFou3xlS0zsBDXNRjkTuTtvethSNTBK4xDVHUAn/57PqTNP+Np5qD1vxmNFFf7+eq
	ZXUcQOL/5ZXGz6qM/Zkv6sIanfO2QGNJc9VOwtS/5H6F2KetV3grF0vFEPy53pKy7gV1EGFCVes
	9mBh71Mai4inXQxTRmXNlyn1q9JdxV4KvImHo/cCuhwPqVgTFqg56Q+Q4Ro/jb484mtK+7WmCkP
	NNLdYB+R66HaKGl0qDAuAHe/XzwYpP4L6pTwmkxakMXq+vogsVkblPPv4t1AuF/j62yOAf0kt+B
	2Enj2pmS4G/DhDFkXkzaNboBWtHOHlFN+ykdQex14gsPxITWJAOZDbqfdCN5OF0nL2IYU5m7rif
	qzHLOuaJS8eWeG94lL1gzcuh7Zoktgmmz8Yvp5M0f3YtL7oLxgaJGAe651cElPSBrAeWekU7Snu
	yn8dbvghq4aR1/c6s5Ysiq6jbYq0H+J7022FA3qYG/R0NcQ4uQzGfjc6IA8CpW85yk39fNsQASz
	hwze6QcksM0mYW7s57T1xrm/LpTq3WX2nlzg1k3bmCnWOUM4bJKXEe8nbNxDS6tr9xfTRiWupHi
	KnTM
X-Received: by 2002:a05:651c:a393:10b0:3a5:f06c:f897 with SMTP id 38308e7fff4ca-3a5fc0f47b3mr16606591fa.28.1790015512257;
        Mon, 21 Sep 2026 11:31:52 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60761e5d6sm24260141fa.29.2026.09.21.11.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:31:51 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v8 10/10] iio: pressure: dps310: check the lock markings with context analysis
Date: Mon, 21 Sep 2026 21:31:32 +0300
Message-ID: <20260921183132.233136-11-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921183132.233136-1-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__must_hold() markings added earlier in this series are only
documentation unless the file opts in, so switch the analysis on for
dps310.o.

Clean with clang 23.1.0 and CONFIG_WARN_CONTEXT_ANALYSIS=y. It does run:
dropping the lock around dps310_fifo_drain() warns rather than going
quietly.

Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index bc0d11a20acc..4b1a05f7a0bd 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -3,6 +3,8 @@
 # Makefile for industrial I/O pressure drivers
 #
 
+CONTEXT_ANALYSIS_dps310.o := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ABP060MG) += abp060mg.o
 obj-$(CONFIG_ABP2030PA) += abp2030pa.o
-- 
2.43.0

