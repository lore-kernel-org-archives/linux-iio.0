Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDFDDDA9;
	Sun,  2 Aug 2026 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785674691; cv=none; b=hPNqk91qMHNSV7j/GaAusdJaBUhZ2vP25wUlGT6o+CChWQrMdYj+w7M4xmZ7KNWL2mcYOpdF/luvXZ4rWoxjMkEvil0JkKJF9JB0TjcUO1HU7qz41QavJDZN+n7fT03xgkRCLNSNyRl/Rt4/4VI+dZAXknE78L6UtHAebDEylVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785674691; c=relaxed/simple;
	bh=m6k+jbAYow2oYDHeB9oDQ7K3y7QjCL/E51HzfRPyYVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlY/PtWC5iTBOo0SG4sKADRe4ImUO0gkmE9miLlzP7I1V605H0gU3IfDVROMOzC1ojmeaGf4mXZs5S1rcSsoUay36c8F5HFralf1NxCtrpe9c50j5RXPVUo+QUTrkEKusSBOlJE17s9jM2xIUbAwzsUqiXwcYHg+JuzB884o6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFZMu0QQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFZMu0QQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15DF1F000E9;
	Sun,  2 Aug 2026 12:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785674690;
	bh=wIgY+IMYJBLWoIJQunkjMT26i2eXWjAiHggq3CCm8wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lFZMu0QQXsZFP2E4DZe/wDPcZTBokID55KNR65R3vOUvSrvETjuZiGbPX3KKu5H+2
	 s6J2RQXRO0cafFKdaLMByN0oKj+LeOJTv36L8cQFl+hMYgD+P/e1tGQjwFtX36o12I
	 NMu9a/kkCgU6HViPhjoReM1r7B5l7Wo8XiNTlF8wN+YAo9OuA6XTCNmdiLd6dEAWkN
	 wfqm/YvcckDXj4YO6GlqeAG7YrFo677KnOUi+v+40oDYP07ZdGGt86x91mLNl8sqw6
	 kqBN9QMaGLTM96e9iOZ7/wko4SXaL30DlExU0G1bJHD6yKqwta4kmNrzxLQpP0f7e3
	 dHypnth62L99w==
From: William Breathitt Gray <wbg@kernel.org>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] counter: microchip-tcb-capture: Fix DT channel validation
Date: Sun,  2 Aug 2026 21:44:40 +0900
Message-ID: <178567458124.1423913.11797126534465463278.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714042910.7-1-bbnpreetsingh@gmail.com>
References: <20260714042910.7-1-bbnpreetsingh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=wbg@kernel.org; h=from:subject:message-id; bh=0S4lXB13dHTIa2w5VuqTQh0fZHhgzlprGNYaCmPYFMk=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFn51pvu//3FqvhQdUJKMlvevmmza9+usUpd/qW4N/BQ8 IVNVR8Wd5SyMIhxMciKKbL0mp+9++CSqsaPF/O3wcxhZQIZwsDFKQATEVzK8Fe4/d+JZQzFLRf3 qKod+13Rulxu3sK/zkkxa6O+fu2bk2vC8E/rTp7cGlUN5qUfHFXWNc5N/T75FJPnmh2F+RLXJe6 HZPEBAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Tue, 14 Jul 2026 04:29:10 +0000, Babanpreet Singh wrote:
> mchp_tc_probe() reads the devicetree "reg" cell - a u32, per the API
> contract of of_property_read_u32_index() - into a signed int, so the
> bounds check "channel > 2" fails to reject cell values at or above
> 0x80000000: reinterpreted as a negative int, they compare below 2 and
> pass validation.
> 
> A malformed devicetree can therefore drive a negative channel into the
> ATMEL_TC_REG() offset arithmetic, making the driver access syscon
> regmap offsets outside the TC block's register window, and into the
> "t%d_clk" clock-name formatting, where it truncates clk_name (sized
> for "t0_clk".."t2_clk").
> 
> [...]

Applied, thanks!

[1/1] counter: microchip-tcb-capture: Fix DT channel validation
      commit: f1a3a9946aab611dd2200c01ff122f64b033dad2

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>
