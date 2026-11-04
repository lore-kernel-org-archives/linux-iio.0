Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758080;
	b=DrPjPuAhUoU9cymyjWSUwjoJ552Q79qYIlR3PbVJXaj/vTggPRqF3iZYLG7zFtei8DRV
	 NAdtI2oIzQpy8YLYx0TRSAbSZQQMVZX2x4CHWGxvPgKeDIutg1y9EyQAd0DuooGGJRxKn
	 IhwMg5lmb0a3TSRP6e062DWnf3cH9mqO+dS5VdWNRdNXeMOcLg3sIMGAPk8R7cCIwMsHM
	 pO4nw5YfyzPtiLfhdr6XsI0WGyUOT3HJjF3yL0675CQVgJAI5r3zdbSDrETmK4pR8Fd8G
	 Qf89fLBuJtCKG+qADghhLLnDOAGjZBp+MkhrikxeZ6FvSGFaydqL7tf6dMjL0Agz/OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758080;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fDVhLMuiku86DHiqPQ9whwOdau0RLv7fIK2bdbK2q6Q=;
	b=hfTvv7KA68ECCoKW5MIM0iyEZ+78tw2QEbBPwBlrO9Pn2ZFHqCeaa3zjyUhuJYbLVIcJ
	 tMHfDovQtzKJGm4oCIVyhzDObeq6hLhtSOTzi5fqUWXFmDXH31UWlxZ4YVhZMqP7s8VND
	 uTrw2v3Q5QxHwCcgQFfOucg4EyPFdJqsJbVMyXynbr/dIUHQ1oKJzP3N9iAVRsLAL8P2Q
	 GTKyoUJRj2kr919qZw4OJnaEI4/a1M5FljiwkPTkdpvhuScOSazIUXImBI3OskH1yb6mv
	 8Gr0vXHloHsVDZY1Q3e5sdXgiSrqnFlC5bgKPzerKLJIFyWIhdy5a8PfKtmycXiQWoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G/5VxXfq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA81606A31B;
	Wed,  4 Nov 2026 02:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/5VxXfq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120171F000C1;
	Wed,  4 Nov 2026 02:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793758079;
	bh=fDVhLMuiku86DHiqPQ9whwOdau0RLv7fIK2bdbK2q6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G/5VxXfqZ7dUwQ2BqLdiKSksgemsWxcKYzVba92K9ITd7seECvzGkMTCsggnyuzrF
	 qhvgJ9/uad47m42ZIiaGLzrYk10SkkBMqk2O+YIEPlRF6mqyAYdTKBEemBbp6VeaA7
	 wAJhSoKsU6tXHunaJIQK5xQpZuVTdG7ghWG+dCkgHRTDZ3/PJv9KHf0KDkq17y7pWr
	 nTZzJ5bneFpaP+x62rTc5FVD+HBdiCOUg9SgOgp4/gkuPumzxdcPeLr0hWnsF0l/wN
	 1E3k6PyBFM8BuW20XBwzV131sY1SAe8bw3ssZuevlA+uzZg/Ux5CtrKkqiokkS0w8u
	 cTxaWPK0yWITg==
Date: Wed, 4 Nov 2026 02:07:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Eugen Hristev <ehristev@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Stepan Ionichev <sozdayvek@gmail.com>, Felix Gu <ustc.gu@gmail.com>, Frank
 Li <Frank.Li@nxp.com>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable
 Hub)" <u.kleine-koenig@baylibre.com>, Shuvam Pandey
 <shuvampandey1@gmail.com>, Piyush Patle <piyushpatle228@gmail.com>, Fabrice
 Gasnier <fabrice.gasnier@foss.st.com>, Cheick Traore
 <cheick.traore-ext@st.com>, Giorgi Tchankvetadze
 <giorgitchankvetadze1997@gmail.com>, Vinod Koul <vkoul@kernel.org>, "Rob
 Herring (Arm)" <robh@kernel.org>, Shi Hao <i.shihao.999@gmail.com>, Kees
 Cook <kees+treewide@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, linux-iio@vger.kernel.org (open
 list:MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91)
 SoC support), linux-kernel@vger.kernel.org (open list),
 linux-renesas-soc@vger.kernel.org (open list:RENESAS RZ/T2H / RZ/N2H A/D
 DRIVER), linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
 ARCHITECTURE), imx@lists.linux.dev
Subject: Re: [PATCH 1/1] iio: use dmaengine_desc_set_callback()
Message-ID: <20261104020750.47a3d04a@jic23-hlaptop>
In-Reply-To: <20261102170911.3867389-1-Frank.Li@oss.nxp.com>
References: <20261102170911.3867389-1-Frank.Li@oss.nxp.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Nov 2026 12:08:47 -0500
Frank.Li@oss.nxp.com wrote:

> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper.
> 
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
Given this is obviously a like for like replacement I'll jump
the gun on everyone seeing it and pick it up immediately.

Obviously more reviews always welcome and I might still add
more tags anyone sends.

Applied to the testing branch of iio.git.

Thanks,

Jonathan
