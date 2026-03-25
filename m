Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376436F426;
	Wed, 25 Mar 2026 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470036; cv=none; b=D3XS/cy1U3eFsPbDmdlFHSFjHDnb2lsSt45JMdGG8+22lx+bFvmLc1DFVRca6Y6GTzSiOT4PMdH2JAFTf/BBzG3GRkBoyw4kWUXYGULJzBmsseK29CVNb88J0GevCLOosfnKw8qShAVck/dHFITnUHB0+H+CDHW55XI5MRdULYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470036; c=relaxed/simple;
	bh=6soLpxJrfc7BSz9a8u6N3jE7UDlIxm6iBYdiexg+s30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AL4WZBwg0ENcONsakBJCHoE1uyb9326bZdXrCW3BaQ5MAUQxuvxHKBUp1RuKl73CeuHNsbaBupBtoy/PYI32eVaq1Mcer243qAXt0Oet6npGBE1K6kv9/nG2xltu35YD//Mlr2i7pI/sCUOmvCClbbROHzZZtjeeyzNNRq52byM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxhSU0Vv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxhSU0Vv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB52C2BCB2;
	Wed, 25 Mar 2026 20:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774470035;
	bh=6soLpxJrfc7BSz9a8u6N3jE7UDlIxm6iBYdiexg+s30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DxhSU0Vvp+mTGVsZi5+F5Skx57WRQXaDjEmD7sqFc3cQMQtWGterRtm/7dcb11day
	 +qyVDxuWihV2XzxR0j/aqABJFsSI1LE74zmpJ+13gZNspqclKFElEnRendqgfwJw3N
	 6QQNKKJM4HD/m1px/oQcAw0ALPSeB3dmRSWAjDlTNVT8tNKPC1Wrttrh47D6TPALzW
	 sSuenq0Kv962AxaKGkhULhk+P0bLg6tjT/0DRY4fcRdSycnc+bK69R/FV5kt4wnnPX
	 iqJj1zysG/7dCeR/COonGXYDi46mzlRp2Y7idUpAES6+3JaZhPlcKdnFMVQSNsCJEa
	 CQQiQ8TFvrkZg==
Date: Wed, 25 Mar 2026 20:20:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Neel Bullywon <neelb2403@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: frequency: adf4350: replace TODO with NOTE in
 adf4350_set_freq()
Message-ID: <20260325202029.40e3b2d2@jic23-huawei>
In-Reply-To: <acJ5Cx8iPv5WwyTi@ashevche-desk.local>
References: <20260323233316.40047-1-neelb2403@gmail.com>
	<acJ5Cx8iPv5WwyTi@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 13:44:11 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Mar 23, 2026 at 07:33:16PM -0400, Neel Bullywon wrote:
> > Replace the TODO comment in adf4350_set_freq() with a NOTE explaining
> > that a constant-time approach using fls_long() was attempted but deemed
> > more complex without meaningful benefit for initialization code.  
> 
> Good enough, thanks,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied.  Thanks,
