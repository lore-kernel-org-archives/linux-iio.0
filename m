Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D853CCFCC;
	Mon, 11 May 2026 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494769; cv=none; b=BxD3Wdn8t8/d0ny2KnOGEdGu7xxIS55l8bG06jO58ptQ9CC+34tAwRDqJDQJ3bgTyANJvTGiL8IW1kfMcGuqJNzcp8pZFW1SqIXFsall59+6ozkU4g+xZ9/qI6AcoFX8pZZPqUF3jiV814kvIcAiKEJ5VREpQDAguKmomZ9/hfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494769; c=relaxed/simple;
	bh=ND9zYMmDY2uylW+7v4Wq6EyRj2ozvhX8+Ea4+9+aEHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FO+wKRHdh2OL/aqVETe3fvb0XRttW/OmIWwhmxxEQGViA8zn6IwMz5NfoRGMN1Yuld+uHRf16re33N5clSuvuRWurpblg+tP6vsG+kAq+Q+3ClEzJYlHZNr1gKmy6sddsDrL9su3GM6UXEvYPLwxHjRLN3oox8CRU0V0yPneBYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6aorcYF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6aorcYF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778494768; x=1810030768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ND9zYMmDY2uylW+7v4Wq6EyRj2ozvhX8+Ea4+9+aEHQ=;
  b=b6aorcYFvBe0IWGn3uR00ItehBHtyTjclB1HKBmkWOAv9gtSGokfb/gT
   Z0DoRqhSNFbcEhvGrdSgWFO3DQaz4/gO5UNiXrRAOHbyAIygI/21wNM6D
   aMkmfniL1wg5/qBr50X5QvlgixRmkIRAHw8wyBloML63b7HwD6Cf2/CwP
   twHut+LE53+W4N9epPFxNL08yYgc0+Pok3fyNahZIqljDNYJILYTqRbcs
   XPFIEFhOJtjjL7he7+Zxm5wQgxkgW6yOuj5keKHtMGJhSdlzz5xaHEGLX
   55ELprrbbhn7Zc8gFIZPqpk980pEvKf1DZf5LyShRDPuH7qy0D7kigmQY
   Q==;
X-CSE-ConnectionGUID: zzSFf7LyR1q9sKWihBpe2w==
X-CSE-MsgGUID: IMYVVXM8RlOq6BtUr4tEWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="78522317"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="78522317"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 03:19:27 -0700
X-CSE-ConnectionGUID: QgUHizbjQsuO2FP2hd1FaQ==
X-CSE-MsgGUID: slIiH5+LTt6t8uBBSnKttw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="275549028"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 03:19:24 -0700
Date: Mon, 11 May 2026 13:19:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, m32285159@gmail.com,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: addac: adt7316: document SPI interface
 switching sequence
Message-ID: <agGtKQs0V679s6Kx@ashevche-desk.local>
References: <20260511023127.86113-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511023127.86113-1-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 02:31:27AM +0000, Hungyu Lin wrote:
> The device powers up in I2C mode. Switching to SPI mode
> requires sending a sequence of SPI writes as described in
> the datasheet.
> 
> During this sequence, the device may still be in I2C mode,
> so SPI transactions may not be recognized and can fail.
> Such errors are expected and are ignored.
> 
> Add a comment to clarify this behavior.
> 
> Datasheet: https://www.analog.com/en/products/adt7316.html
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Thanks, almost there!
Please, address the below and feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
to your v4 of this patch.

Also I think we don't need "staging" in the Subject, as we can deduce that,
in any case it's up to Jonathan (and yes, I see the common use of the pattern
in the Git history).

...

> Changes in v3:
> - Add Datasheet tag
> - Use datasheet name in code comment

...

> +	/*
> +	 * The device powers up in I2C mode. Switching to SPI mode
> +	 * requires sending a sequence of SPI writes as described in
> +	 * the datasheet "ADT7316/ADT7317/ADT7318", Rev. B.

Yeah, but you dropped the section title...

	 * the datasheet "ADT7316/ADT7317/ADT7318", Rev. B in
	 * the section "...".

> +	 * During this sequence, the device may still be in I2C mode,
> +	 * so SPI transactions may not be recognized and can fail.
> +	 * Such errors are expected and are ignored.
> +	 *
> +	 * TL;DR: Do not change this!
> +	 */

-- 
With Best Regards,
Andy Shevchenko


