Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702710;
	b=c/eo/WxGufn8JRtyVD9ZWLLBqm96ewnkYuakDvIrYMpQ9EhpJBI0OBL4zVO/ul8LGEGU
	 RCiaC/G0WT2RC7ussgj0cD+j5CMM6TxP7b4Cyj/9DFI8K7Ytr3Ah4ulVK4Ustbi3fKI8r
	 A9hc5HqC36BZCVpt+AQq6xMdBYVMpTDbI3OYiKhrjnp6R50MHg2CQ6EE10Z0i2BIMsbhU
	 x3N6RqE7Jx2gos0Nw1n3AdwpEiKlbGeemiAjyuE6F7MEJzmc0JZ920lufJlmUaesZDIKM
	 y0AnW0iNVUix546tEvLk4q+qjp2M3Qt+YHWsGjwJpZnAjYJwWvTmG3rK6Y2Fy4nujJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702710;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MuGlyWuHgt1+ModFh6dI+/+UPnwPpZ0FLEt4g6S4HO8=;
	b=XcA4+2iDJ7JbasAcpmJBggaEUlach02eAOWBMizvRHu6HpFTdQLMYrO8EWIA238mslZ+
	 Q+wAggUkIzF8RZcVjhcYk7q0DQ9Wzh4adVmcTFO4FZVmebwM7od8NwzPiVv3M9KmMzHuT
	 wWpgq9ULDbCdkWngxD9LPcsjV2Bq+sOKRNgsKZCtPEhE0FEOKuVAVuLUodF/SC38I3ajA
	 MN8wVvKX2t4yaefeZ2Iftx2WcemZpJ9o5AwqJOgAMfnDRmd4bRkM5GzQiW9qxzM5OlyJk
	 TjNl2gTXfgvFFT66BKdsDpZtITLy5h4cd09ODwr8/R/A18byUzjdNIn720w4pOEJnHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDZMk+Vg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213C606A323;
	Sun, 15 Nov 2026 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDZMk+Vg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527691F000C4;
	Sun, 15 Nov 2026 00:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702709;
	bh=MuGlyWuHgt1+ModFh6dI+/+UPnwPpZ0FLEt4g6S4HO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fDZMk+VgOSgiZzXp/yKlRM5qEUtKavpJDvvGCLlA701hnXzhO75g8bOpFUIJH0XyO
	 AjYQz9up2Rs2N11jp/0DzxHdI66Vb0vcn2enjFpkien+ikV5wmyf8XuK4/pIGmhJdU
	 Pe0Ow2FskxVeNJ4j1mpfO1YchiONUPASKaO42S/tsjpxwZhmAp7NCRV4BNWzBUG3Jr
	 M1pvMPpJCFVCnYPqXbVkQE8tCQamTAui+qczor0bzGIbAHMKgr54wMdRxM7LFqRqPB
	 7EbVkV7kryzBDiGW8vBzpJ2Yo1XXPyNgFdaf3UOrRbk17OGGWO8m/VWvtSS4KfDveQ
	 L6wDMTehW96Zw==
Date: Sun, 15 Nov 2026 00:31:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9324: reject reserved gain values on
 read
Message-ID: <20261115003143.44a65e15@jic23-hlaptop>
In-Reply-To: <20261107203508.30be5cf2@jic23-hlaptop>
References: <20261104175920.207384-1-kapoorarnav43@gmail.com>
	<20261105141504.000009b8@kernel.org>
	<20261107203508.30be5cf2@jic23-hlaptop>
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

On Sat, 7 Nov 2026 20:35:08 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 5 Nov 2026 14:15:04 +0100
> Joshua Crofts <crofts@kernel.org> wrote:
> 
> > On Wed,  4 Nov 2026 23:29:18 +0530
> > Arnav Kapoor <kapoorarnav43@gmail.com> wrote:
> >   
> > > sx9324_read_gain() is meant to return -EINVAL for the reserved
> > > PROX_CTRL0 gain codes, 0 and 5 to 7. But the range check sits in the
> > > else branch of "if (regval)", where regval is always 0, so codes 5 to 7
> > > are never caught and are reported as gains of 16, 32 and 64, which the
> > > sensor doesn't support and which write_raw() rejects.
> > > 
> > > Check both reserved ranges before converting the code to a gain.
> > > 
> > > Fixes: 108e4d4de2b5 ("iio:proximity:sx9324: Fix hardware gain read/write")
> > > Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> > > ---    
> > 
> > Makes sense. A stable tag is probably needed.
> > 
> > Reviewed-by: Joshua Crofts <crofts@kernel.org>
> >   
> Seems correct and I can add the stable tag.  I'll leave this on list
> for now so that perhaps Stephen has time to take a look.

Given nothing back from Stephen I'm going to apply this, but not
rush it in. So applied to the testing branch of iio.git which is lining
stuff up for the next merge cycle.

Thanks,

Jonathan
> 
> Thanks,
> 
> Jonathan
> 
> 

