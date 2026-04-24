Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C631E85E
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022654; cv=none; b=jAQaoLOODeGktT2RlsEA8dBF+bfEtYIwhvGGTcddJg0eqAdhBnPWOyFnJK9pgugLdcHJeorTc1wwGFc6BhpFeFkLKsc2gehfTbMqATgTaDnHTs1KxJGUzmNj8f6z9OqmrcORMFfynF6u/iDRfCNtk049jDlGDhziKR5VMUD+SCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022654; c=relaxed/simple;
	bh=2P2Ii73nCNv6ahQCDh1zpL9WPET43mHzjnSFq0wEmZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdd31tGJV1OvlQekRBkmUYvEfL5H104tUjlojckDQafMOioc8Jxx4lJ2AXJvjTQj8Bjx4hzR7lKQAhWuJn0toer16t6Ursip2WebD9Slda4cj7R/YEtGCBE3Cy4eqal6Uw7Uiw42+hZiTqhsLeYpgzqfu2P8MRpa1Ulxs28gAzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIwlUtuo; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIwlUtuo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777022653; x=1808558653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2P2Ii73nCNv6ahQCDh1zpL9WPET43mHzjnSFq0wEmZc=;
  b=FIwlUtuoH93xYloKef1y8NgmcymXcZ4KsdSlFTAm5NOvLIsLFXXA0dgY
   bnlDwg35HSOczLD5lMi0rkdoHrONK2fQ8+EjYQVjCIJqKf6VW1Tt9rnGe
   qRJSO4ZUnd2Lm2NVc9wz7bDtGIdLQVcih31yh24Sg2YBbKXT2HwPBGy8a
   h0Q+378bFZ+8nlJFW+1Lhjr80QxDw1ceAYkey+SwRkVFTivqpDBMzY4Sz
   HQWTkW1znOeAbn9H/vA+2AdJu9FJiROieO7ZdHcO/wTKHmM75LjHbHclu
   iPsUmCdACcv+DsQk+UMeeai30gDcyKIJC/diQ/FQ0GSFPrZ/j6iWo7+sM
   Q==;
X-CSE-ConnectionGUID: i7xa8x7WRP+5JrO5HAQq1Q==
X-CSE-MsgGUID: LaOVos2SSgmGxETwpgsRtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="103464715"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="103464715"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:24:13 -0700
X-CSE-ConnectionGUID: yTyv6DHMQ5m7R6yJbaVyVw==
X-CSE-MsgGUID: sljSplgoTKC9xmh5VM1T2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="263304701"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:24:10 -0700
Date: Fri, 24 Apr 2026 12:24:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guilherme Dias <guilhermeabreu200105@usp.br>
Cc: nish.malpani25@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org,
	=?iso-8859-1?Q?Jo=E3o?= Paulo Menezes Linaris <jplinaris@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
Message-ID: <aes2tzgfXbuD6ccQ@ashevche-desk.local>
References: <20260423223958.100487-1-guilhermeabreu200105@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423223958.100487-1-guilhermeabreu200105@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 23, 2026 at 07:37:51PM -0300, Guilherme Dias wrote:
> Use guard(mutex) to automatically release the lock on scope exit,
> simplifying the error handling path and removing the need for
> explicit unlock and goto-based cleanup.

...

>  static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 cmd, int *val)
>  {
>  	struct adxrs290_state *st = iio_priv(indio_dev);
> -	int ret = 0;
>  	int temp;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);

+ blank line.

We usually consider guard()() as not semantically linked to any code above
or below

>  	temp = spi_w8r16(st->spi, cmd);
> -	if (temp < 0) {
> -		ret = temp;
> -		goto err_unlock;
> -	}
> +	if (temp < 0)
> +		return temp;
>  
>  	*val = sign_extend32(temp, 15);
> -
> -err_unlock:
> -	mutex_unlock(&st->lock);
> -	return ret;
> +	return 0;
>  }

Ditto for the similar cases below.

...

> static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)

>  	default:
>  		ret = -EINVAL;
> -		goto out_unlock;
> +		return ret;

Just return directly the given error code.

...

> static irqreturn_t adxrs290_trigger_handler(int irq, void *p)

> -	mutex_lock(&st->lock);
> +	scoped_guard(mutex, &st->lock){

No. Besides wrong style of this line, this has a very broken indentation now.

>  	/* exercise a bulk data capture starting from reg DATAX0... */
>  	ret = spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.channels,
>  				  sizeof(st->buffer.channels));
> -	if (ret < 0)
> -		goto out_unlock_notify;
> -
> -	iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
> +	if (ret >= 0)
> +		iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
>  					   pf->timestamp);
> +	}
>  
> -out_unlock_notify:
> -	mutex_unlock(&st->lock);

>  	iio_trigger_notify_done(indio_dev->trig);
> -
>  	return IRQ_HANDLED;

Stray change.

>  }

-- 
With Best Regards,
Andy Shevchenko


