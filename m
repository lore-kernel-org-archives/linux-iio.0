Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32012FF69;
	Fri,  3 Jul 2026 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783104118; cv=none; b=qI1fQzrEtYU1+sTfcUDFCbgulNu00p6UK8GL5elJeqNYzPqdmohpeF52p/H5pUrIVrdRlcsCPM9jeRGpE9ARxOHxhmA0Kz7uO96264lpJivN37aQHtCaef44NaaaX0QCNPBt4QQ/bpsXcNtl3VPgJn3JAYpj/lbxxuObK0V+q3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783104118; c=relaxed/simple;
	bh=xW/xJdpvNFDjzamS07f5Pr/aBN8xtrwTunJB4cjTkcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drEaJiBlHgOoHd0+VHzcbeJe1xnUnmPmlnS4BM7ZOA8sT2rnpKQVSLcL2pgKxantzdl5yrRe2u/hscWvYGlYpLQVo94NjEsRWA3TV5CrdUJiqKjWdxHGB0YRpJAwiISNNX1vtynYoswPlNQ+hy7ChW5LhOsSYZyyf1j0ZEC2TJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oh3Ai+xT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh3Ai+xT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7811F000E9;
	Fri,  3 Jul 2026 18:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783104117;
	bh=SG03yF1BOcutsxwTb84hjMZI8cnbt1ZozwtSf2s3YKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Oh3Ai+xTcoH3I83JStlbDmMBkhty6Wxi365E+e45J9DEkvjmW2rQbR/bYYyvJc0Tu
	 i1tDn8eR/TOmAhaoiEuQa0U64BqMXwMPUIuWNTRz3eFRZEGSrm97Ra5e2CxWsfxw+k
	 steVetSW6URG8aaNa4OWPEvS9tYYiX7o1jCa1pFympauuXJEXowHj3JoaekDHXAncP
	 el+aBXhjgjmNp1VNMlQdItl6V8iIaaI1kN6OqlgBZ49sedkpu1F3d4dCtINIhNhCdx
	 2olOpV/C1pcY3kqN0q17g/Ki2FTRv8Xyv8i1catfMMOUiIzcdBSp/+GaBxpRI8G1dq
	 rh62PgPtqfQgA==
Date: Fri, 3 Jul 2026 19:41:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 m32285159@gmail.com, nuno.sa@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: chemical: sps30, scd30
Message-ID: <20260703194145.22376029@jic23-huawei>
In-Reply-To: <20260702191744.118898-1-tduszyns@gmail.com>
References: <20260702191744.118898-1-tduszyns@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Jul 2026 21:17:40 +0200
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> This series replaces old email addresses with a current one to
> make sure changes show up in my mailbox.
> 
> v3:
Series applied with some small tweaks to patch descriptions.

Thanks

Jonathan

> - move mailpatch changes to separate file
> - update binding file
> - Added Reviewed-by tag from Andy
> - Added Ack-by tag from Maxwell
> v2:
> - add missing mailmap entry
> 
> Tomasz Duszynski (4):
>   mailmap: add email mapping
>   iio: chemical: sps30: update email
>   iio: chemical: scd30: update email
>   dt-bindings: iio: scd30: update maintainers field
> 
>  .mailmap                                                      | 1 +
>  .../devicetree/bindings/iio/chemical/sensirion,scd30.yaml     | 1 +
>  MAINTAINERS                                                   | 1 +
>  drivers/iio/chemical/scd30_core.c                             | 4 ++--
>  drivers/iio/chemical/scd30_i2c.c                              | 4 ++--
>  drivers/iio/chemical/scd30_serial.c                           | 4 ++--
>  drivers/iio/chemical/sps30_i2c.c                              | 4 ++--
>  drivers/iio/chemical/sps30_serial.c                           | 4 ++--
>  8 files changed, 13 insertions(+), 10 deletions(-)
> 
> --
> 2.55.0
> 

