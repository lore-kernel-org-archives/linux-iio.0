Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623078;
	b=h/ln+BDB/TSIVISekgONlSWT5XftXkS6Vgtq436wksIexYFygmhEV6/Goz3nIHZpQAVc
	 sWP2GFijLnPROVbd6xlUvnz3l2wdANl4D2Q2M+Ut7ZrbxUKR0ieJvYF/uQy+hTJigDDL8
	 uGcfvDCS/+ORM89xx0t9Re8jvx2ch8qWIh5pOQVdspLYgLgKt4OKs7lRQkB3Rc5LZKiZM
	 31kxpnwvJlg8xSH4wtdW5ZPNFnjrBD+MIfaZj3EmJbnl2DbnG5dfKwgz3mHVnTVZtvlUK
	 U4NcMFsGENz3ltFf28a+7sQV5/zCIySRxVOmsH6VZaVapX+GezHfIrdCLKY3AaNVWRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623078;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=1MBma5a+psPLLCKXTMOwm17DkE6+4sXPC6Ddt73b2kw=;
	b=QTESKFqoG0GO3Tr1euMatqO9dIOVd+aolqG3gqCIyEp2miz1z+fyAyTC5FziGAZRSskk
	 tgi1OuUDB3uTh5ynBtd0FIEenjM5SVr5TF7+a89zjW2gakm52ZgbW7E96PDN2R0A40ZP+
	 jCHhTf5BZ3o6JJLeOfhKPOkDMcxN1FWFXsARqs8OqiWOlWCyCKI5ysqHBsmzJcEn7Qc35
	 3Fad/7gwWJnDwYd3srQa8UmLyEPhAglnnYxQp/+xPJJQ4gYq7n0Cevk+nGwHHrGxP5hmJ
	 /MWrlj+q2iGZzzlZ4thtJB7w5lU6HC8RBK4Jkt+9l0plpllKVa9tCpm1Ji27DiA/D8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QnFG4FIR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D73606A324;
	Mon,  2 Nov 2026 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QnFG4FIR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68D91F00A17;
	Mon,  2 Nov 2026 12:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623077;
	bh=1MBma5a+psPLLCKXTMOwm17DkE6+4sXPC6Ddt73b2kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QnFG4FIR9tIM/YF7jC+v+gO2i8jIkTvtGdft55wKsMq/mLuFEtMj7e7IW4kbxBgdL
	 r6lk5IB1USVIGpylp5G+NRRg3YVzDoy4vaP9lP9csT5lTjT+AgDL6k6i1JJbqw2Nrq
	 GMPV3R11sIHgPo4mHWm0pI0iEmrnrRBTiX874BKdMj9HWg//gkf9BqVx+GLsbOyF+x
	 HrJcGP6dPuNDxBIeJ0PLhNzK3pVOh81zT86crFOH0w4jhQG3tQTYfGkeZY55rRKxyB
	 JDdr30ML1YROGP6USJ7XcGNmnGeyEKIm6mB8XcauYCVQ4Ae+tRqjNi6b5GVE8lbDUR
	 izw47jVdlNJfw==
Date: Mon, 2 Nov 2026 13:37:51 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: jic23@kernel.org, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dragos Bogdan <dragos.bogdan@analog.com>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad7405: Add support for
 ADuM7801/7802/7811/7812
Message-ID: <j6m3rx5freowub2b5bbqveyc67gz5rte2kmnzjskonb4y6ijfm@xtg6wgau7erj>
References: <20261102121352.23741-1-pop.ioan-daniel@analog.com>
 <20261102121352.23741-3-pop.ioan-daniel@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261102121352.23741-3-pop.ioan-daniel@analog.com>

On 2026-11-02 14:13, Pop Ioan Daniel wrote:
> Add a chip information structure and a device tree match table entry
> for each of the ADuM7801, ADuM7802, ADuM7811 and ADuM7812. These parts
> are handled the same way as the existing ADuM770x devices and differ
> only in their full-scale input range: ±320 mV for the ADuM7801 and
> ADuM7811, and ±64 mV for the ADuM7802 and ADuM7812.
> 
> Also list the new parts in the Kconfig help text.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

--
Kind regards,
Joshua Crofts
