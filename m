Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17FC34A765;
	Mon, 23 Feb 2026 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848325; cv=none; b=OQZ0PdQmIWLMLJjNlmxR3yTv+BTedOZDZYndpU6mBdBqKuITfqY7qeiyAEnljaPCAog4/86IVakfLmmik1tXnTVWrf56Ozi4bJnTQ9hy7Z4q8rMiP6lSoD7itK2mKuGOMUXBl3Ioc9qqJaWP2NbQwOWDGu7qELz/06RsTblSKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848325; c=relaxed/simple;
	bh=YjNOQ6e6/v9t5w3cexW5Wu45hANV2MglrcN98NJ8Cy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0OnN3aVUJSDIXLTtS4n7BEl/nNaeeXu8Zp3oftqBYGfp85KrGXvSFlArnAuxdoVyniD1uhQlx7OYUapXaYxCuzjuU97UOLZJinz1bTpnDjDw92j7+xuMIaRjTmNZHQ15n3N5empjcf6Qh3iJWIdS37CSG+bcG3/fRET9E9yWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lsTHiYde; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsTHiYde"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771848323; x=1803384323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YjNOQ6e6/v9t5w3cexW5Wu45hANV2MglrcN98NJ8Cy4=;
  b=lsTHiYde1GlQFDhgasNtIUv3V6vIb3tRP3xtqJagt0TIFob4nbE1eaeW
   VOxECob+SBuMtvRNNJ4SDHNJ6sRlWywrkDHdA0ALGr3J3VAA3u3j6Xzq7
   pvsUGIJXZgT1+onjrvHauFR6eQhCK7KbDvxjmhXcmrr4QuQXfwDLD/LjB
   3cRwF7afmMFeeX8Q0VGw2Imn2aO2LYQhg5/TpO6hGTHxPt9adPsD4bIQB
   d4RAAMi+c+ubXHmO6ZzKpAxOOaesIbvRmuOkCqzYMmTcWZk5EtPKvwh14
   22UCPwZJIaGOXPaubIH1A+uB3UBaq9DeNCBfqveyWwFeb3qLe6MZcZDnK
   A==;
X-CSE-ConnectionGUID: +tom7JEhSUK7PWuD+qGUkw==
X-CSE-MsgGUID: y3Klze6BRqeJOIMidqDcUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="73017939"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="73017939"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 04:05:23 -0800
X-CSE-ConnectionGUID: fwfIQbYNQz6RV/GDH3JUKQ==
X-CSE-MsgGUID: OC6fGy6BTwaebSGRmlHpHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="246147235"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 04:05:21 -0800
Date: Mon, 23 Feb 2026 14:05:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/10] iio: light: gp2ap020a00f: Fix possible error
 swallow
Message-ID: <aZxCf3zD7m3nxaH5@smile.fi.intel.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
 <20260223034020.27625-6-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223034020.27625-6-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 22, 2026 at 09:40:15PM -0600, Ethan Tidmore wrote:
> Move error check into for loop in gp2ap020a00f_buffer_postenable() and
> gp2ap020a00f_buffer_predisable(), this fixes a possible error swallow.

...

> -	int i, err = 0;
> +	int i, err;

I believe we can't do that without introducing a 'default' case.

>  	guard(mutex)(&data->lock);
>  
> @@ -1366,11 +1366,10 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
>  					GP2AP020A00F_CMD_TRIGGER_PROX_EN);
>  			break;
>  		}
> +		if (err)
> +			return err;
>  	}
>  
> -	if (err < 0)
> -		return err;

(Also you might want to mention dropping '< 0' for making the style consistent
 taking into account that those functions won't return any positive values.)

>  	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
>  	if (!data->buffer)
>  		return -ENOMEM;
> @@ -1381,7 +1380,7 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
>  static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> -	int i, err = 0;
> +	int i, err;

Ditto.

>  	guard(mutex)(&data->lock);
>  
> @@ -1400,11 +1399,10 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
>  					GP2AP020A00F_CMD_TRIGGER_PROX_DIS);
>  			break;
>  		}
> +		if (err)
> +			return err;
>  	}
>  
> -	if (err)
> -		return err;
> -
>  	kfree(data->buffer);
>  	return 0;
>  }

-- 
With Best Regards,
Andy Shevchenko


