Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EE63BE632;
	Tue, 10 Mar 2026 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178972; cv=none; b=qChrFiqwgeJAIa9R+RD9mruoD3ybnBdz60qfjR0rhzy2mQ/MypWJ4Lm/AT6yuKLWtMM2N0aLbE1m6zICChH7IiNarnPedyd1gfWaH3pNIp49iR0AllC+9eouwhCCXoH1gvfSNIz2QOZrc43K+wcO9x9hREOZ2coQ43Hw7DfvLf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178972; c=relaxed/simple;
	bh=y91edeQ8o1/X5XSGLJZITFd+JTr6VrnoUG18G8144I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5AcJPqyKf5Tr6KnouPuk7V8D3a/5Uhv0Ke2SkubN/gBPhd8F25zCQWTL9jOCsQ2WRstW0CnUY08Fb2k+UiUk+l3qVy/ncRrMpVqixzLZqMqYK4FXXfyl2vZ/VfjnAj0C9HjtCcU8zNNP5sjWs8R7Mbg5FDp7EGjxuPrOeP1z/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HwIp2Gov; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HwIp2Gov"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2f8R5GEyxkZQIaf64bF4zBHCOUbaQ3TEBtHbXujsVTs=; b=HwIp2Gov4Vq8cd4o8z42qkD5qX
	m94Yotc3CL7E1pNYm9Ix9lffgY3gHInitMQayEaOhwQMZcMFc/PgBVjgi2gpyAcEg90EgwigfbEsA
	+C6sb/M7WpXY2IfRQkDu22vPgylEym7pQhl+IyUq2X7g4cgU7nzhax5STJ3biRzAQ9xo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w04qH-00B5j1-QZ; Tue, 10 Mar 2026 22:42:17 +0100
Date: Tue, 10 Mar 2026 22:42:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, m.tretter@pengutronix.de, mchehab@kernel.org,
	p.zabel@pengutronix.de, tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
	pure.logic@nexus-software.ie, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, kernel@pengutronix.de,
	kees@kernel.org, nabijaczleweli@nabijaczleweli.xyz,
	marcelo.schmitt1@gmail.com, maudspierings@gocontroll.com,
	hverkuil+cisco@kernel.org, ribalda@chromium.org,
	straube.linux@gmail.com, dan.carpenter@linaro.org,
	lukagejak5@gmail.com, ethantidmore06@gmail.com,
	samasth.norway.ananda@oracle.com, karanja99erick@gmail.com,
	s9430939@naver.com, tglx@kernel.org, mingo@kernel.org,
	sun.jian.kdev@gmail.com, weibu@redadmin.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH 7/7] staging: rtl8723bs: simplify cleanup using __free
Message-ID: <02b2587c-c885-48b0-90af-0b8d65a3a593@lunn.ch>
References: <20260310200513.2162018-1-sanjayembedded@gmail.com>
 <20260310200513.2162018-8-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310200513.2162018-8-sanjayembedded@gmail.com>

On Wed, Mar 11, 2026 at 01:35:13AM +0530, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Replace manual cleanup logic with __free attribute from cleanup.h. This
> removes explicit kfree() calls and simplifies the error handling paths.
> 
> No functional change intended for kmalloc().
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 13 ++-----
>  drivers/staging/rtl8723bs/hal/sdio_ops.c      | 37 ++++---------------
>  2 files changed, 11 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> index 8d259820f103..2badf7d1aec4 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c

rtl8723bs is a networking device.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

says:

Low level cleanup constructs (such as __free()) can be used when
building APIs and helpers, especially scoped iterators. However,
direct use of __free() within networking core and drivers is
discouraged.

Please drop this patch.

You might also want to check other subsystems and see if they have
similar policies for these magic operators.

	Andrew
