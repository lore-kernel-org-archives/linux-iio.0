Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019412475E3;
	Mon, 16 Feb 2026 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771225734; cv=none; b=bdoBdKbNHnPiPVKAN/dfNFkFVJsO0hMaNMWnEprMaNWV4ouhkxk50B+vCL0r8513EE4Gk23+Jkdd/OFrQJsFt2+s+Gef5pM052o9zm3UgmngHDBnXd3BjvRW/A3g+37/L2CaaK+DjdRPOY4V116VGdWGXGTmBzaVKCpccwx+b7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771225734; c=relaxed/simple;
	bh=JL3ykH7IcR2KoMNMNvAtEtQ/B6QqzgxTm7FFKlzLUCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ip0d43f4rd7Zvg8WytlAAOJEATcKK4idMqeJkA5TLTE3e3HS7Na1tSF8RiDssXx/4s3brm4Ax173Zqu35vF8MSM2VqZ8I1ziLNbetSNxXdFczbLYQ9qudnqVtgTdhlnKsLY/osgEcxxmdOGdR1w+JoL+c/hdYrAnAE31CBA+y+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoQcctTW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoQcctTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771225733; x=1802761733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JL3ykH7IcR2KoMNMNvAtEtQ/B6QqzgxTm7FFKlzLUCk=;
  b=hoQcctTWIGa+DqVAqHq20AZtXpqzE2ZtIODWU2yze9Zds7680BqeFyws
   XGbZeufU5fZDLFKC5zjoaGroUiRbnMbu8Q34eQhUZOpL2xqf+SLzdjl53
   ZF5S8IXO2q19hwWaWs2uA0aZQA4P/uxGvEYk93+GdfiN39TcLMYPo0HMv
   zpP29lVIBwZ9wLxaxSoA5QptYEHQjxZnr8LDEx94c6oQs971nW9KHENsM
   RGs1qz+23iXmdhrELAPBYdth3DmtmdMoHwFRuqGn9m5c0ZY/qJuZlEUBa
   Dq0AGMEbj8HqbEalhBirIwUXQuwNklht/0iyeajErZFP+vMWXc1v17+Jq
   w==;
X-CSE-ConnectionGUID: EWLmzWwjSAWjG74sdV384Q==
X-CSE-MsgGUID: qQ0nOjMoR6Gn/J+PQ5HOlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="89715024"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="89715024"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:08:47 -0800
X-CSE-ConnectionGUID: 0HsviaQAS9WfH9d8uoVc4A==
X-CSE-MsgGUID: 5rwT76a3TjOZGyBuPzMdog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="212762812"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:08:45 -0800
Date: Mon, 16 Feb 2026 09:08:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: light: gp2ap020a00f: simplify locking with
 guard()
Message-ID: <aZLCe_5C8e82EMGO@smile.fi.intel.com>
References: <20260216005317.11763-1-ethantidmore06@gmail.com>
 <20260216005317.11763-2-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216005317.11763-2-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 15, 2026 at 06:53:16PM -0600, Ethan Tidmore wrote:
> Use the guard() cleanup handler to manage the device lock.
> This simplifies the code by removing the need for manual unlocking
> and goto error handling paths.

...

>  	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
>  	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);

>  

Also drop this blank line, it will be aligned with the similar style in the
next patch.

> -	if (thresh_val_id > GP2AP020A00F_THRESH_PH) {
> -		err = -EINVAL;
> -		goto error_unlock;
> -	}
> +	if (thresh_val_id > GP2AP020A00F_THRESH_PH)
> +		return -EINVAL;

...

>  	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);

>  

Ditto.

> -	if (thresh_reg_l > GP2AP020A00F_PH_L_REG) {
> -		err = -EINVAL;
> -		goto error_unlock;
> -	}
> +	if (thresh_reg_l > GP2AP020A00F_PH_L_REG)
> +		return -EINVAL;

...

>  	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
>  	if (!data->buffer)

>  		err = -ENOMEM;

Now simply

		return -ENOMEM;

> -error_unlock:
> -	mutex_unlock(&data->lock);
> -
>  	return err;

And with the above I believe this becomes

	return 0;

>  }

...

>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>  	int i, err = 0;

Would you need the err assignment now?

> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	iio_for_each_active_channel(indio_dev, i) {
>  		switch (i) {

...

>  	if (err == 0)
>  		kfree(data->buffer);

With the guard()() in place this can be inverted to have something
(I haven't seen the full context, though) like

	if (err)
		return err;

	kfree(...);

> -	mutex_unlock(&data->lock);
> -
>  	return err;

Ideally this should become

	return 0;

-- 
With Best Regards,
Andy Shevchenko


