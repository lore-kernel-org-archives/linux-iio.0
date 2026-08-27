Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C847ACFA;
	Thu, 27 Aug 2026 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859277; cv=none; b=KlBy11Uc8ffrAI5tqbLdtdVpUe5+pJHG7PUF5qvOFQp3kax18h8/xInv+c/PqpkTzVlEG09vNrUpEJL+7X6UTi2gHKo90zrpGQB+bEu9tL1pQb8m502szQI6q8LqB5v53sdY5luF1eEelkEBr6jKuN8fN5lok9djLglfG93IlZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859277; c=relaxed/simple;
	bh=SC82EU3g8vvl6n+Q6umeXkJHZxNOmy5jEGlrfO9K3Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp4BL6QzyYCNPncFSTgE5Nr2spqoBm8IrTxgm3CcQfHp7nhNiCGOug7U84zFr5mHZ80cgOpc2a1x/4SJH3U5b2wi4+9yzv9nvShiA6vqqfDDrXK4dGbE+FkkeWPDXCdQwY2FP69WJUKtLyCXTHGyR4UBA7rpu23eBoQYoztQdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yz/4r1S5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yz/4r1S5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787859275; x=1819395275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SC82EU3g8vvl6n+Q6umeXkJHZxNOmy5jEGlrfO9K3Bo=;
  b=Yz/4r1S5P8E0/Cs2uCyybJ5YMqBH+B7iqn3wTtYfXCROQYUZBADNKal6
   NrR4t15Gj3yXwpMMWSpIrfWzgfX4iwhpcLYigTZTuS6Hj+EvdOiHkKLIH
   u2uxALwQXBOXITLnKK5fdkpeZVoCveDEyXOCTllzDWhvDb+8C+1cRx8/I
   TTf4FCse8f0V4sRfaUkuoMYKVnGIJzB2X31QSJAk+FiV/jQNpQD305l/V
   UKkeJvcD1Ib91CZ3Ss6nnR/pnp9lgxq8l6LBu/kZqiHLd3AYq6V0ncBmk
   pDUECAA4xYfkaSgL0rXWVI8DKBJF+C0nlVYbByICnulD0NXdNkXk9yI+I
   w==;
X-CSE-ConnectionGUID: rjUKYIW3RPGMPc3m2cmC+w==
X-CSE-MsgGUID: coNUab3ASTiezTBDC672jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88573288"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="88573288"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 12:34:35 -0700
X-CSE-ConnectionGUID: JtzZGL/hRiKBZZloT4kGxg==
X-CSE-MsgGUID: itJG9c+xQjSWwnsZXykS1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="267982382"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 12:34:32 -0700
Date: Thu, 27 Aug 2026 22:34:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] iio: adc: ti-ads1015: inline
 ads1015_set_conv_mode()
Message-ID: <apCRRiO9wUiLlQ3W@ashevche-desk.local>
References: <20260827172100.39176-1-architanant5@gmail.com>
 <20260827172100.39176-9-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827172100.39176-9-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 27, 2026 at 10:51:00PM +0530, Archit Anant wrote:
> The ads1015_set_conv_mode() helper function is a single-line wrapper
> around regmap_update_bits().
> 
> With the transition to the FIELD_PREP() macro, the raw register updates
> are now self-documenting and easy to read. Remove the wrapper function
> and inline the regmap calls directly at the call sites.
> 
> This also allows for the removal of the final custom shift macro,
> ADS1015_CFG_MOD_SHIFT.

Ah, this patch should be done before previous one, so that one will use 'map'.

-- 
With Best Regards,
Andy Shevchenko


