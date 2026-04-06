Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2636639903E;
	Mon,  6 Apr 2026 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775505894; cv=none; b=ZXwilj2g2t2lUIUvnjWzHCcglraC4NBh1PjuIRqrxLeJYxU5LDPUSyEz2/PmfFIf0aSUabiy4Ux8BaT/t+hrRNILg4LFI9C5e0JGnA2scbN5UrWoMQqIOBTt9t7dNqE6svIJnBbVqR25DbZvhyydSOnTFDnV6iADGfMoDMsu0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775505894; c=relaxed/simple;
	bh=ojIHZDP+f5h9YZzJkoEFFrLIpPvoNKrQNngEZX64DCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+BEF7NAyzKR1e2Rb3BpgDk0641gtX5gkjrC3XOUeKrAHt1dCqhtfvIERzDLsJxUBoTwvQCMt20ucRGHYDbCN23qpCTq5TTEMQrIYPDVx/iHNxsTajqw54Oi7oaq96/v/9ge2tVpkyN9GBzttgB+J+v4GJvokQn/W+mh/JOw4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhpIKFb/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhpIKFb/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775505888; x=1807041888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ojIHZDP+f5h9YZzJkoEFFrLIpPvoNKrQNngEZX64DCw=;
  b=QhpIKFb/Gr36ykNodnWKd68CgUf+A0soKlrRXBx3kQukzBIVoiGVtfYt
   uh10BoHpbr6tI9qb6VlaAByv1R13AAQsbldUmn2pN93uSvyf0w/4WrNDq
   nv90Jx0Z0aquxbhy97VkzXSKzPdWi/Mn9zlgCI9IIxlsf9uCiKzI6vAU0
   IE4aV4m5pYqo03G4lyM9AZA7Rwr9sADEYSIIAV7WqLheCIj+u1Uf42zbD
   UhfW7ymP/5zu39qny4VWInbJ1M37Add8PkvGTQ1zWFDEmVSWcI4/Zc74r
   IeFB8WbtmtfnGlcXJoYVT4dbXgBDzYHaa/7+oFp1Y4xDr0sp8N549tT0A
   Q==;
X-CSE-ConnectionGUID: IavVigF8R42vBhNnPuUEFA==
X-CSE-MsgGUID: 0jOBsG5SQleazelgtlGcHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="99085757"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="99085757"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 13:04:46 -0700
X-CSE-ConnectionGUID: voTqQZCMRBmcM0iAxyHlmg==
X-CSE-MsgGUID: 6yjjFsngSoScEYIXMSEw4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="225211597"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 13:04:44 -0700
Date: Mon, 6 Apr 2026 23:04:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] iio: ssp_sensors: factor out pending list
 add/remove helpers
Message-ID: <adQR2ZKVOavHlJDt@ashevche-desk.local>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com>
 <20260406080852.2727453-4-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406080852.2727453-4-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 06, 2026 at 01:38:50PM +0530, Sanjay Chitroda wrote:

> The SSP SPI transfer path manipulates the pending message list in
> multiple places, each time open-coding the same locking and list
> operations.
> 
> Re-factor the pending list add and delete logic into small helper
> functions to avoid duplication and simplify transfer flow to follow.
> 
> No functional change intended.

Suggested-by?

...

> +static inline void ssp_pending_add(struct ssp_data *data,
> +				   struct ssp_msg *msg)

Make it rather:

static inline void ssp_pending_add(struct ssp_data *data, struct ssp_msg *msg)
{
	if (msg->length)
		return;
	...
}

> +{
> +	mutex_lock(&data->pending_lock);
> +	list_add_tail(&msg->list, &data->pending_list);
> +	mutex_unlock(&data->pending_lock);
> +}
> +
> +static inline void ssp_pending_del(struct ssp_data *data,
> +				   struct ssp_msg *msg)
> +{
> +	mutex_lock(&data->pending_lock);
> +	list_del(&msg->list);
> +	mutex_unlock(&data->pending_lock);
> +}

(in the same manner)

...

> -	if (!use_no_irq) {
> -		mutex_lock(&data->pending_lock);
> -		list_add_tail(&msg->list, &data->pending_list);
> -		mutex_unlock(&data->pending_lock);
> -	}
> +	if (!use_no_irq)
> +		ssp_pending_add(data, msg);

...and then it will become

	ssp_pending_add(data, msg);

>  	status = ssp_check_lines(data, true);
>  	if (status < 0) {
> -		if (!use_no_irq) {
> -			mutex_lock(&data->pending_lock);
> -			list_del(&msg->list);
> -			mutex_unlock(&data->pending_lock);
> -		}
> +		if (!use_no_irq)
> +			ssp_pending_del(data, msg);
>  		goto _error_locked;
>  	}

...

>  		if (wait_for_completion_timeout(done,
>  						msecs_to_jiffies(timeout)) ==
>  		    0) {
> -			mutex_lock(&data->pending_lock);
> -			list_del(&msg->list);
> -			mutex_unlock(&data->pending_lock);
> +			ssp_pending_del(data, msg);
>  
>  			data->timeout_cnt++;
>  			return -ETIMEDOUT;

Also rewrite this to follow the style (missing {}, better indentation):

	if (msg->length && done &&
	    !wait_for_completion_timeout(done, msecs_to_jiffies(timeout))) {
		ssp_pending_del(data, msg);

		data->timeout_cnt++;
		return -ETIMEDOUT;
	}

And kill that use_no_urq altogether. Move the comment rather to a helper(s).

-- 
With Best Regards,
Andy Shevchenko


