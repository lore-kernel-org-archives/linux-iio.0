Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795307880;
	b=v+8+t5xlyk+as3h6GWWMAQOG9MUMZPRiwiMAk7Q/kDRXMGF50X5diomuqZCicQmT34g1
	 iFHnUTN8SkpBkp+B7gI301crfJrrArowHLdU4dez++mXk9BlzUe4stFRHjEeTRWnpJ6RR
	 ZtoausBdc5TTOT4ChDV62IocUzaQbUpQPRd8x2TGgPARudY1ViVzG1K1E28Cp+kb9PMKw
	 XAiszxjXb4gJJEK2RKTjW2hP71TFM2XdedwegOQQf/AzgzV4cAm2cr9dw7NBeGMfPFXSa
	 HuhfRtg5A6o1/H6HBjLMudyi03QSPWZks+kzPd9SaDdsN2RaSCh54xLnfFeu+8tSwgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795307880;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JyWoZacLLrIbSlrpM6tBSTWhe8smh1FELYakcJcB1Ok=;
	b=ndRM8O5a42rBa+g35SR0r+7PzSnEwe3S/YKM2OUojUXPzNCc9FQOkuyqCp20yKN/KbXS
	 YnqIAk4VOQwTlSIJDt9LMwSj7V/dSao5Mf7DcwZB3+oSPuAnO/goh5x4B6nYtb6BJarsX
	 Atc17GkLHblDAN4SWsPEAKlkF0h4pTfr1uO9ez6/OeNZEN3Dix8hkPxe7f4boiwEhBlf1
	 2nKVHkO0fyb+Nu9LKO/tqu4qYEaNiAgVY+yNPUNdEQ9ZOpAvjeyVUv2mH5/uNiXn9URAP
	 X69/U1iKgEhYjpcXphMVbVGb2W/TNr+zn/8zkDl5pvTcJXHsPgvZubOn4bFg9ftTmFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGV218Rc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E7606A320
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 00:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGV218Rc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D103C1F000C0;
	Sun, 22 Nov 2026 00:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795307879;
	bh=JyWoZacLLrIbSlrpM6tBSTWhe8smh1FELYakcJcB1Ok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QGV218RcZqVh90sTxOJxlhqrim9ITbhIKGlxJA+CDysGKO4NwjN9hzu2eO/Nqm/I2
	 Xut8FDJ4VlUDpGw0XMbZmuUSHsQ2k7ZGkAlIj5xJC6lv9h2I5fMP5HkXSBRK2WtGWO
	 6inVbhiRvyh7E0aLeg4lLpWx5uXE3pbmU4SglTN1iuPTYuYvbUXXajQiA/HG6N3teq
	 T/KtdvfSfMDAmO+Sv6B6c+rT8Y/albJ2fyqjUFd3zhaQg6/8DvMYbX6e10C8ZRpCVN
	 toXdAWRxrO0ae3GZe+KCmWu1HfttoO9h9X69ku+L7lQpR1QjddZLpaH9oYGu8AHCbI
	 22on+uWtC+UVw==
Date: Sun, 22 Nov 2026 00:37:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, Peter Rosin <peda@lysator.liu.se>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: afe: rescale: Don't use ULL(1) << x instead
 of BIT(x)
Message-ID: <20261122003754.66fa693c@jic23-hlaptop>
In-Reply-To: <20261118092812.000014b3@kernel.org>
References: <20261117101216.1486231-1-andriy.shevchenko@linux.intel.com>
	<20261118092812.000014b3@kernel.org>
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

On Wed, 18 Nov 2026 09:28:12 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On Tue, 17 Nov 2026 11:12:16 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > ULL(1) << x is just an open-coded implementation of BIT_ULL().
> > Replace the former by the latter.
> > 
> > Note, the rest of the code properly uses BIT()/BIT_ULL() already.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---  
> 
> This file could get IWYU'd as well at some point.
> 
> Reviewed-by: Joshua Crofts <crofts@kernel.org>
> 
Applied with title tweaked to mention BIT_ULL(x)


