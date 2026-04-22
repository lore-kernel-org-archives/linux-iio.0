Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3482B1C84BB
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776890171; cv=none; b=cXRCErq3OiiGCWxlmoulh4SZctvvco3851E4UkYJUR5nUWFNNEEX4FKaenAfz74ls5I3A7OJnoTKH6JuR4BFSYhHI/m0qeHh8thW/Rz6kNyeC/K02zZHb6E5yRGTwZfHewlmFRXRsPPBt1mwZxepdCwm5Cu4KkCEkfj1B8za/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776890171; c=relaxed/simple;
	bh=wckvNe25x0Dv6dJR3W/vTdAMyEM25C2vWhaxJcg7Quc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsfxcRrPER6oSFZSlNg5Zg40sB2XhXkAHWzzNc8+6Ji5yi108CB3d6up+yx7GaQDZeDIRfOs30dFbv4g2/L43QK5oYpizyWydjTQ51DjRuufjaX/dkOmvpAuKE+JbnU2kjcciajrV6kaW1VBsP+KnefXcYXQhSPk2CGtdvqOSLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5Fdq1AX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5Fdq1AX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776890170; x=1808426170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wckvNe25x0Dv6dJR3W/vTdAMyEM25C2vWhaxJcg7Quc=;
  b=b5Fdq1AXP+exHvKt/OzQCRWMwJaQZWu8kjkrNubcP4+c+sKCUTxRZRno
   ekr/F99yyHiI6H9a1Ed8uXoo+8G2Z3dZpiRrP9x6hCDfIXC5ZRM1rhdRB
   L/3+9DXF9VMKNCd97jWGCTo10DE5J2rVBckrrNDYmeZwAQ7dmjuULdw8S
   szDXYtiTlbeb8bUw1JrEhdNrDflecfqWa1O6qIZfRg6JcyM/uPRPVzEIa
   YZeulG6vVEhrtR/Fay8BYErflSSejwmOpWdlgZYdWs6Oj3NnSoOs9yaZk
   QxCUPt62lbISW8SuqG4vUI6q9Xyz1l1WA1+eVnFavLtVjTgxvXG17/jZi
   g==;
X-CSE-ConnectionGUID: zDRGvUXMQg+YWef4Tjy/Jw==
X-CSE-MsgGUID: vzfNQgU7TIWFarKaxs9zWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77557136"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="77557136"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:36:10 -0700
X-CSE-ConnectionGUID: Obov1TtHSQmQeA/rVISWHw==
X-CSE-MsgGUID: bFUDyiuERgGjcrmmWzjvAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="227882535"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:36:07 -0700
Date: Wed, 22 Apr 2026 23:36:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guilherme Dias <guilhermeabreu200105@usp.br>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nish.malpani25@gmail.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org,
	=?iso-8859-1?Q?Jo=E3o?= Paulo Menezes Linaris <jplinaris@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: adxrs290: Use guard(mutex) in lieu of manual
 lock+unlock
Message-ID: <aekxNBLWOXqkqXi_@ashevche-desk.local>
References: <20260422192521.7472-1-guilhermeabreu200105@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422192521.7472-1-guilhermeabreu200105@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 04:24:36PM -0300, Guilherme Dias wrote:
> Use guard(mutex) to clean up adxrs290's error+unlock handling.

...

>  static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 cmd, int *val)
>  {
>  	struct adxrs290_state *st = iio_priv(indio_dev);
> -	int ret = 0;
>  	int temp;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  	temp = spi_w8r16(st->spi, cmd);
>  	if (temp < 0) {
> -		ret = temp;
> -		goto err_unlock;
> +		return temp;
>  	}

Now this breaks Coding Style. We do not use {} for single statements.

>  	*val = sign_extend32(temp, 15);
> -
> -err_unlock:
> -	mutex_unlock(&st->lock);
> -	return ret;
>  }

Ditto for the rest.

...

>  	ret = adxrs290_spi_write_reg(st->spi, ADXRS290_REG_POWER_CTL, val);
>  	if (ret < 0) {
>  		dev_err(&st->spi->dev, "unable to set mode: %d\n", ret);
> -		goto out_unlock;
> +		return ret;
>  	}
>  
>  	/* update cached mode */
>  	st->mode = mode;
> -
> -out_unlock:
> -	mutex_unlock(&st->lock);

> -	return ret;

Have you even compiled this?

>  }

-- 
With Best Regards,
Andy Shevchenko


