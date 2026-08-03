Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC6401A08;
	Mon,  3 Aug 2026 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763677; cv=none; b=tIy6q9noK8NETAqY1lUlAvdVqLspKIcTF3KCUGF1CnvhJMgiiMdCosUppu9mjngA9Esxp2Tv9KeReGIFHZP+U2UxTNhLP1APSb4ZasOLWyBaz/Ym8QUAB7OcsQ5mlhP3xAM29BM8jkezXulbPs284OUGZ/QJvOTopREiub1i6wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763677; c=relaxed/simple;
	bh=hmzhvnb+lTuTYJKqxP7dqSkojtqBsyFM72dRiRfGGDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPf0f5Nt69LkffU2aRcSR8jyIF/R+rJ4vEFdrGFDF4E36W+1idPddeofT045CeKM8KslMAQJBAmecdJOV3EulvkXgqiUYddZZqdhJNYfqP+UjhXhW3jQdTla/cgDlynNxDXTieAG2FMEVRdB7UKdDtUGG9j8pN+D3Kwl7ACek9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B8P4Z5G+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B8P4Z5G+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8551F000E9;
	Mon,  3 Aug 2026 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785763673;
	bh=66OPy6ZmGT7I3HCbQchTZ3y6DhAHXvtjYNjQZN28ufI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B8P4Z5G+0gdjDE6kj7L8hPBHWXocyJ42EEtffpHu5+ujMyu7wR34EJbPkeu3tpClH
	 ZHkwMi9d7FWWCscXqzkYoPdh4C62/9cybU3B6jeD2RGPZa1oWOng/62HHCs1beBUZA
	 7ZZwaT2NEyBGLNt9M9oqHcM9awlzxNAF3ZoUQL6w=
Date: Mon, 3 Aug 2026 15:27:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, linux-staging@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] staging: iio: ad7816: Fix DMA from stack and race
 conditions
Message-ID: <2026080331-viselike-degraded-90c2@gregkh>
References: <0bde2343-8a70-44d4-9b27-8ce42c099309@baylibre.com>
 <20260803121520.6274-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803121520.6274-1-abdelnasserhussein11@gmail.com>

On Mon, Aug 03, 2026 at 03:15:18PM +0300, Abdelnasser Hussein wrote:
>  drivers/staging/iio/adc/ad7816.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> -- 
> 2.54.0
> 

Something went really wrong here :(
