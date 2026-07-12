Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25651F4611;
	Sun, 12 Jul 2026 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783866401; cv=none; b=PNUv1AxTKCdux7SdMYYRbQZOQZMBCP6puxcQjvnQ/ZAL9lFywYTac5AmXKyoMNeqdnUt2CkIsd0qVNh9GdnUnea9WyL8P5pHdd3q4k6KFDPc3frHrklDTYXkwSIIT5uaZhFMu5D7hD+tgxelgZ+h6tSIW6IQTLwpH5jtgAx9PpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783866401; c=relaxed/simple;
	bh=qM1bUE5yXyWkcSrfsMp3EXtx11bZAV0Pcksg3iBE6uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoRLV17jr/lC8N7S8jYW7XsSPtHzOvY4DIHe5iPapE7AZRIGedj2e6tWVijbk9KBHoz0sHEfu5mo3bBsUKzQQa0I0h+8nNQY1sfnJVsVJmY7QD9bDT2uG00yD0RdU3kgTCqEkWOrxzfStmqFCuaU4bPTxkanF4hLMYoFeLuTkBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dfqv22Pg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dfqv22Pg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015EC1F000E9;
	Sun, 12 Jul 2026 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783866399;
	bh=dUJ0dizpKYh4x0gMmsK0oxX6Pyyq1Rdc9ibR6F4VMag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dfqv22Pgyu3E1+pDSIYCRMD1M6y+op1vTWegegjOQ/vRT3N1vAeDht07ldc/CmfFx
	 l0J8ox66sI1K0JUEbIGze1Mn+WzoXlSYmKQFTKrxJ/IMtbbJAa0IuVtIpJ5xSFOsxQ
	 8cMYlQ52oCt3oK4HihsZikWzst77v43W/nTEo898=
Date: Sun, 12 Jul 2026 16:25:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dylan Liu <pxyforeverlove1314@gmail.com>
Cc: Dylan Liu <dylanliu050903@protonmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Signed-off-by: Dylan Liu <dylanliu050903@protonmail.com>
Message-ID: <2026071208-pox-washed-9fba@gregkh>
References: <20260712141928.559844-1-dylanliu050903@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712141928.559844-1-dylanliu050903@protonmail.com>

On Sun, Jul 12, 2026 at 10:19:20PM +0800, Dylan Liu wrote:
> staging: iio: adt7316: Fix CamelCase naming for sysfs attributes
> 
> Fix multiple checkpatch.pl warnings complaining about CamelCase
> variable and function names.
> 
> In order to comply with standard Linux coding style and IIO ABI
> conventions, convert all uppercase abbreviations (AIN, DAC, Vref)
> in the adt7316 driver to lowercase snake_case.
> 
> Note that this patch changes the sysfs ABI for this driver, as
> the device attributes exposed to userspace are now lowercase
> (e.g., from 'AIN_internal_Vref' to 'ain_internal_vref'). This is
> necessary to bring the staging driver in line with the official
> IIO ABI.
> 
> Signed-off-by: Dylan Liu <dylanliu050903@protonmail.com>
> ---
>  drivers/staging/iio/addac/adt7316.c | 228 ++++++++++++++--------------
>  1 file changed, 114 insertions(+), 114 deletions(-)

Very odd subject line :)

