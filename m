Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42443806D8;
	Mon, 27 Apr 2026 08:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278776; cv=none; b=BUKPWyRnTB/VgdQMG6zcdsDwfnaiCsQLslfUYXXYF9AXfsHhMe0YEzQ0a+c2s46BrrNmoCxFabpaD4pRMVhyijNCQjdS+iKeEHPhIoEwf+MwLnuvO0Ei9ZqOOms9HcVosiFSC2OeC1OPfaMp5G0EXRuIHnZfopJXy8gdd9ZYvYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278776; c=relaxed/simple;
	bh=YaYMCjalTMCbBQ72xseFkrZwEhXM/knhQ2GbQZO1G+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTJsoTjKFFDcDAO2hyGvNYqFXQfhfOIrTCELNk0iYNfx0hbMI+2xdnmnn/uJpzX1OOphtdk+cA4FnQdlVwobKvy1ui4C641AI9RdLrawoEkcUsd0sC5XHZVSUEchEKPTavFhJKzGiHZ9zBjd8G5yAss/ZdE+QHhOoiSH2KTBJ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grRNqWao; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grRNqWao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777278774; x=1808814774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YaYMCjalTMCbBQ72xseFkrZwEhXM/knhQ2GbQZO1G+4=;
  b=grRNqWaoa4oQhyPY5wve/dYKFlAPfpvvgamzLWNawgUXg6w3YxRWbgXv
   qUa/ZKMw1s2OURIl+czeHxPXRPc6Pi3HONSygIiYxiISexGHmBDOyCBYJ
   lpXH0Is460tfGnWHMSO9MKG2+vpr9sdP5Kgjq76aegBqI4vOkXdWavrp3
   1K5qwLGdAif0K5kk7ioYtAeVgP2zO3StULl9sNK2UEffhJDZViTJD7kFJ
   TNZaQQdyjFITNYQZbPXq+t2Fdp8FQQiNTqHxmDd/OrhiuBKZMKztpkBR5
   +eLBCZn0XGqhY5IO6264+3UBmBAlE7Ym2GQSYCdRugIWHewt4cy7XSnDb
   Q==;
X-CSE-ConnectionGUID: SO19IJD0RXG7FBC7tnssPQ==
X-CSE-MsgGUID: Uibx696RQoynoVIBjRYvKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="77319234"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="77319234"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:32:54 -0700
X-CSE-ConnectionGUID: YUe8OhUKQiy8gdLQyLHnug==
X-CSE-MsgGUID: CWY9Z7xFTBiPwWVYNVHoew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="233397694"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:32:52 -0700
Date: Mon, 27 Apr 2026 11:32:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: Add error handling to
 adt7316_spi_probe()
Message-ID: <ae8fMVgQ0ESPvwZl@ashevche-desk.local>
References: <20260426205039.125818-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426205039.125818-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 26, 2026 at 03:50:38PM -0500, Maxwell Doose wrote:
> Currently, the return values of the adt7316_spi_write() calls in
> adt7316_spi_probe() are unchecked. Add error handling to return early
> and pass on the error code if we receive an error from
> adt7316_spi_write().
> 
> While at it, move all three adt7316_spi_write() calls inside a for loop
> to condense the logic.

...

> -	adt7316_spi_write(spi_dev, 0, 0);
> -	adt7316_spi_write(spi_dev, 0, 0);
> -	adt7316_spi_write(spi_dev, 0, 0);
> +	for (i = 0; i < 3; i++) {

	for (unsigned int i = 0; i < 3; i++) {

The magic 3 has to be explained in the comment above.

> +		ret = adt7316_spi_write(spi_dev, 0, 0);
> +		/* Check for errors, if we get an error, return early */
> +		if (ret < 0)
> +			return ret;
> +	}

Are you sure that's fine to make those fatal? Have you read datasheet on this?
maybe it will return errors which we have to ignore?

-- 
With Best Regards,
Andy Shevchenko


