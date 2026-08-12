Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A21401486;
	Wed, 12 Aug 2026 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535292; cv=none; b=ChVIN2s878F2erIgbE2I5zPPofwEUx6zzCuzmxwM1SOQB5cuGBhEzlfItBCzYOlKyf2ff7gBTPypPtAVT8YCafnwR3HiU0ZZ4Ee6yQIS0ehU5w+XPPW/pw8F/ZylgrJs/NVu0CA2f3nM8mFtxapjRJRdEwmTebQFoyx7ZQfV3eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535292; c=relaxed/simple;
	bh=69jHvWKqaD338NvJaBWD7J0BdMgiDRMyQzKwO6sN6IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC3MbZ6kyGrIdm+r5VWBOx8u7eFXqoPJg7PgZTdv6qYUpcH46mducYGCW5KwoW+YeQ1258VKBTO0IfeR++TJ3Id900Rzl+jmRryzzY5x7BaPT1i6Fg4gFb4sSnMrxHwOIDrOzYttPAcD2UqMIUL0GrIBhVST5g4EJX1f1hboQ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTExtQBF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTExtQBF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786535290; x=1818071290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=69jHvWKqaD338NvJaBWD7J0BdMgiDRMyQzKwO6sN6IQ=;
  b=ZTExtQBFZueQEsNjI6umsDG5gYOMK1oTt4BMvJTQPTQVSzBdWgNtMGfA
   QBrKiGN6e999PGIjHqEdavU4gAx6ovAHef054rWrFVih7+VhohDIogA6i
   1+JZwWAmpc7hC2rISxdnm8l0ExXnOMYJMFL6wxLR9EuZc9KDsYbCqFpZt
   c0z5Wo9Q6qU7Ry9rqFEf860tWGL4xrC7un15D3HSBa7imwgMDrQQswj96
   nVo1r8gUekHgQJq5k42lvjxyRqOkHimQq6rBNYRkyMbw43auOQ+nt62DK
   0UDXtJbtdyuXOPT1gT1y4zrQMYaXL49LCFZFWhCD/3HfPKoHwvPHJ5bx3
   w==;
X-CSE-ConnectionGUID: IY+C7BRKS8+1gNvEt32QYA==
X-CSE-MsgGUID: EeXuM2mBRlaOEdCkk2X5VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="90764734"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="90764734"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 04:47:57 -0700
X-CSE-ConnectionGUID: 8van8gNvSYi+UYUQlUounA==
X-CSE-MsgGUID: 7G6gIuRVSCGHu2OLUcOCJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="301868270"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.245.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 04:47:54 -0700
Date: Wed, 12 Aug 2026 13:47:46 +0200
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Matti Vaittinen <matti.vaittinen@linux.dev>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kalle Niemi <kaleposti@gmail.com>, Topi =?utf-8?Q?Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 11/12] iio: accel: kionix-kx022a: Prevent memory leak and
 fix statey
Message-ID: <anxcithfWakkARl8@mdjait-mobl>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <85e6bd3998863e0247c52dcf0c1486b2cddff567.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85e6bd3998863e0247c52dcf0c1486b2cddff567.1786347811.git.mazziesaccount@gmail.com>

Hi Matti,

Thank you for the patch!

On Mon, Aug 10, 2026 at 10:55:03AM +0300, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The driver allocates memory for samples at buffer enable path. If regmap
> operation fails in the kx022a_fifo_enable() at the buffer enable path, the
> allocated memory is never freed. Furthermore, the state information and
> previous hardware configuration(s) aren't undone, potentially leaving
> WMI interrupts and buffers enabled, or driver state flags wrong.
> 
> Free the memory and revert the hardware configuration and state flags on
> error path.

Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: e7123a4dfcd7 ("iio: accel: kionix-kx022a: Refactor driver and add chip_info structure")
> ---
>  drivers/iio/accel/kionix-kx022a.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 8a13f78aeab0..49e8b4b943da 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -980,26 +980,43 @@ static int kx022a_fifo_enable(struct kx022a_data *data)

Do you think this error handling should also be done for kx022a_fifo_disable():
in case __kx022a_turn_on_off() or one of the regmap_clear_bits() fails before
we free the fifo_buffer ?

--
Kind Regards
Mehdi Djait
