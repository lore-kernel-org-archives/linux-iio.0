Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793884731;
	b=HUIwsBJ34/7N7jpGauoq+iHH4aFINjX+Fzbn1nxuL2v+uGzV1yetxc+e9QSpBpBYEr9O
	 1GuwAR22qJa2YOs+FHF9r3pTBcPf8+7gEMjArI4MqS3oWhjiSLHdtxkeKQ2j4wm3PsBx8
	 pfLv28vBvhMXP6h/aBNOGO3Mul26uYwgogOhjOYd8Yq0nr5qkd2bFk3mfJsWXfvV8lVtI
	 Prluh45MEeze0++AqGum2LamIRMraALMOslesVs77NK7726YjgIRx/Cg42gS089bC55ND
	 Bc4Ukqqao2xOf5hxuM45YMccUH1J45OhwCGPW0x2/z/Ew36DFAHhCC+rfNFPu4cQ7XA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884731;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=13hjFRIfFZGAZdG/Aqlbh1CUAUCdnov0gVHSPvbUyXg=;
	b=fDtNguq0k4dmRcPjTDT8lqvsv2C095Wri3fXF+Cr0L0dXO/7CG7oSQx9oF7uJqFjucf4
	 9+7oy2o7zGehi5r/QN++Se4Kcc4e0/+csBKgEkMhqfMlyxOL3zTrUG/RiaoE8diR2IbJ7
	 yuN9HPKdrQTPlGksITB0688zxK8VlFZst6npNDB0vM3mW7fN5TjHKUe+AxWIdzvoI9xsi
	 hYXL4H7gG66vx8fF3LaAVlSvbRFWj/lQS+bk6fry94WGHxebzGwJHVsecB5atJyKKinJS
	 AuAvEfQtNUqqTcRcNU83hP+0F+SHgMIXgLuS9nKPeuuLUFQl9V4SElXuPjGzMN1fuIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2QCqMTA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E2606A32D;
	Thu,  5 Nov 2026 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2QCqMTA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793884731;
	b=aeIqB43fre2hepXmjEQv5DgOiaoECJJZdIIfjHt/MSQL7M0Hji4tSD8UjujWKW7kdM+W
	 rz9M3Yd8dX3C9sK0lZsX+hiUCsYEIvUJsgpBDXzaGtel9ySymISt6rQbLdydVQbBhTFLl
	 A111O4DnNdqdN9hdqsa7aRZsIOfIh4dxhTapfNtKil6q4XOUDZBcXK/nb136sFVsg18b+
	 LS2pb96/+0neqBqXiFIhciTLLtKdXafHG2VWNuHpDO09Ta99+VoWGuh0KolyjU7knhcd0
	 6Orqm6XSojxmZdc2CO/lAVMrzNQo1esHce0/ox/KLXsmv+UFg3qbJouHhjC6U/+pY5A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793884731;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=13hjFRIfFZGAZdG/Aqlbh1CUAUCdnov0gVHSPvbUyXg=;
	b=1xIFrOP2flJyWEFO1tWrI7sdreSJO4qSk7BUimZMASQ160qP9xb1uA7TsZy9zF4B354/
	 ZbjqiDZv99XKeT4mh59P5oMEl2hGTofCfFGtkr01Ciyz1s7JHwM+WftxSZbZ3dTcICiHl
	 1Iw9A8lG8Cp8H/fv5LtcLiXBpQNpJ3td1dGggkT++mBE3VlSl7UBSFVCVO8EECCUR1kD7
	 ruwZ45yeF80xgJ+4/LL9LW9tsJv8hfR0J5fs01NcWTRXsg8rpQ9rNzx6MY29cdLCuTKa3
	 4x4xXxkl7kghsHOVzOfrf8jBPMklVM625UOJy14KeI+rf1XYP8ZRZyHgXGv04MXZG7Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id CF14D1F0093A;
	Thu,  5 Nov 2026 13:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884731;
	bh=13hjFRIfFZGAZdG/Aqlbh1CUAUCdnov0gVHSPvbUyXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m2QCqMTAoIWTblRK2aWGupqzWcshXUj1DQlQZoKKoJ5qzSeU+ER4uOHc5pL1d+ZZk
	 XQrFTXPRis2Qgn2wbGBIb5oaF5o6RWBHfUPAwVdOhFyvHET+x6brlVyjYTu7IoydCd
	 /UcIj7tfxPK3FmFGLwewFBgfvZh3GaMD6+soHAMiokZSNQwNxzF2aGxeBoD7iCDgEJ
	 kqijtKdxppcxoYrvo9AgFEvpsh+Chw6BgC1w9DH7Pnk7L5CodzEv+X4yh92BNY9NnO
	 R2z/MlX897x6iJj+192sEwnaNZu2ThLjoDpZESXAEinN5GTjuTSpezP9MrLGznDDyn
	 VnTr6MZEo4w/g==
Date: Thu, 5 Nov 2026 14:18:46 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2] iio: adc: ad4134: Fix duplicate data_read mux state
 request
Message-ID: <20261105141846.00004e3a@kernel.org>
In-Reply-To: <20261105033120.387616-1-nichen@iscas.ac.cn>
References: <20261105033120.387616-1-nichen@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Thu,  5 Nov 2026 11:31:20 +0800
Chen Ni <nichen@iscas.ac.cn> wrote:

> devm_mux_state_get() is called twice in a row. The second call's result
> is stored directly into st->mux_st[AD4134_DOUT0_INPUT] without error
> checking, and then immediately overwritten by the first call's result.
> 
> Remove the duplicate call and check the return value before saving the
> state.
> 
> Fixes: f12ecb3e147b ("iio: adc: ad4134: Support SPI 4-wire mode")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Ideally your Signed-off-by tag should be the last one in the tag
block. No need to resend however, this can be tweaked when applying.

-- 
Kind regards,
Joshua Crofts
