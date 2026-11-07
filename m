Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794023939;
	b=XVQBjR7OytizHK19ScclrQoo75ZJ2Jh24DNn+I//olxN21ihmql2q8w/1nlmftq8aWCf
	 2gZMCumUTHyGejPoeakmSMrkLxEEKU9N3UI0ib6qDpe5Nu9AscQL41gW60CT1pNgusQs1
	 +EV7L7k+Nci57w12ckf5XTyEXDUmjoH8dlVt0+zm061yrv4Dm2V5Snbu3eDF3EkHwOdy2
	 WsQuFLKmeOjr3h+H6pDePEGLuOgqrBkVbOPZvbBfU3wE3gyPUKIEB2llqBuA3t5OArAlI
	 jmVuTF9GxF3dJEaCONrtdqv4UaEYxDK1RvwUeTFvD6yn+RvSzf0/5Mp1sAc9QlWrBVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794023939;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dRexF36N57Z46Z1WRdsd2m/GPXEarnkSgvBnWou7EuA=;
	b=U683pZwpyGT0aTTKbxARwLOTMXWNj52geZGtElEOfHKmVux9C0RvN7OayMOG7iW9hRQ4
	 SjVNVwv82+7yVt9xAMJQP8MMc8BC7ScvGCMogVKDZhw15FCcKZJwNlLwhLWgJR9ul6tLA
	 cSxkeAXNBE4EgkEa6Be4PfyRJ1Wd2CCLcFyiozthCWNt/CxSKsaXsHfobSegpRGXBT/zz
	 UYx0iVoGHRwOr5+Yc9hA0cMoi3eJvSAPvWLZC0reLfcmNEW6WbuJoh7f7u531Xw0A1xw8
	 XeU9SKMd9XmaHLE1Iti7Y2eTLxBxXzYmMOR8WuCaLevjVKmiddV/Po+6JvjLPqR4wCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtZznDKI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF47F606A326;
	Sat,  7 Nov 2026 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtZznDKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A45C1F0089F;
	Sat,  7 Nov 2026 03:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794023938;
	bh=dRexF36N57Z46Z1WRdsd2m/GPXEarnkSgvBnWou7EuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DtZznDKISdnKZ0FGYvWYiT5NSn+rIogg1rCnMr8u6Z2eY2+D4VWOi7cEJN1+OcZEf
	 ltIqVeyCdy3Z0TWV6Dr2vfXfUBOdIQqcAWR+Z13aDYb1Wmd81QPIpQRfZOXu4pNIXc
	 PDSf9dLQA/voAgEe/589gopb5Sl25HwhZNXQA/AUFx9iaZ9gC9gI0jOYMbe2IdaiPg
	 W6CMADXkFe2P3SgkGMaxVZYd6FsGufDGiCQ7Q5mbQ4C8KrpzxinPEIK4VQWyXFFzpZ
	 oALunCcd2IEriAcRxIhF6v04rQ/yA4hP5iV9r68a9BvOWPQPlTck8iuJzF+xRSnm6o
	 j6M0CO69YXtcA==
Date: Sat, 7 Nov 2026 03:58:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Eugen Hristev
 <ehristev@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Haibo Chen <haibo.chen@nxp.com>, Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 00/10] iio: remove redundant
 pm_runtime_dont_use_autosuspend() calls
Message-ID: <20261107035851.0c8cb3e5@jic23-hlaptop>
In-Reply-To: <20261105121635.1612-1-crofts@kernel.org>
References: <20261105121635.1612-1-crofts@kernel.org>
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

On Thu,  5 Nov 2026 12:16:25 +0000
Joshua Crofts <crofts@kernel.org> wrote:

> Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
> driver core is now responsible for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
This sort of series I particularly like.

Applied!

Jonathan
