Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD5030BBAE;
	Wed,  6 May 2026 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778049270; cv=none; b=E1LkOrZwlBTKNnAUW+d2V/WONb5cOioc6uLnvQX1WYEn8zu1AK9QrHDRqK/Mpk7un0t8op0/nkIZqqzIKPWD/B/A6aZyLThXuSuPAYRxlWddehUE84eywfgPhInOUzrUaW7lUGwPSXp74yyKWOKCnfT5ESzWn5YxkNz162Kq6is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778049270; c=relaxed/simple;
	bh=mGSTgaUsQQXXmdqRglcY4GoRJ6nM8+V3/umcy5tkuCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRFg4eCe9TonFKdzXOR5B85pTL7WPgKMr7FUbw7gDjYVrw11rsO1FltDQMkLxe0VGxL4ZmnqJNNKVjgo7xaxvDoZHTi1V/he+e4TJrEuqUjsIRlfqMuktPFKY2PmselHN+kxerGBzhtTKP+ewowZs+b3IhRA3ftREjWPlVV9JFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0Lvbk5Z; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0Lvbk5Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778049269; x=1809585269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mGSTgaUsQQXXmdqRglcY4GoRJ6nM8+V3/umcy5tkuCM=;
  b=m0Lvbk5ZZBfUhwNIE+wx43fmzkFwERzwWPns4jqpEgRLLrYZkAuy3HGn
   1IV1MAUZwNJ9vPibPqRFbwIOoWITziJBAASuMrKx8OL8wd+ggWcldvbeh
   yV0UC7jDWdVkCDW5wkgJWEY+YIcHVdxZONEJiKJOf/lQ0ERdjvmf/RgHW
   OmAWD5RlXfDue4BHyVBrCFxw91jx7NsCDbEw60x3sNTqK4vDj5/ZBLT7S
   MKgRAeb2n8wLCvPORra13hNu+cCB955Si2+M0TylXnXYWeK86BDEsc505
   vTXb4tljHyDGv5JeqqdKjIXWHh8ucnO/2PBmLRI7I8BNz7Z6bh0XUBYba
   Q==;
X-CSE-ConnectionGUID: vqsprvKnRWCHtMghdjuGCg==
X-CSE-MsgGUID: 4JgA+ZHCQVWjId9SQ5ciCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89537193"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="89537193"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:34:29 -0700
X-CSE-ConnectionGUID: bdcPTqHiQ66MOu+F6LF4kA==
X-CSE-MsgGUID: GDzLCRAPR+GS1nHpAyDuDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="231474207"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:34:27 -0700
Date: Wed, 6 May 2026 09:34:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/18] iio: magnetometer: ak8975: pass conversion
 timeouts as arguments
Message-ID: <afrg7uXqyKs9il1Z@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-6-831b9b5550fc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-magnetometer-fixes-v5-6-831b9b5550fc@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 01:46:02PM +0200, Joshua Crofts via B4 Relay wrote:

> Refactor wait_conversion_complete*_() helper function to accept poll

functions

> and timeout values directly as parameters. This improves the
> readability of the code and does not rely on hardcoded macros.
> 
> Besides that, fix the home grown and obviously wrong in some cases the
> jiffy-based timeout.

...

>  static int ak8975_start_read_axis(struct ak8975_data *data,
>  				  const struct i2c_client *client)
>  {
> -	/* Set up the device for taking a sample. */
> -	int ret = ak8975_set_mode(data, MODE_ONCE);
> +	int ret;
>  
> +	/* Set up the device for taking a sample. */
> +	ret = ak8975_set_mode(data, MODE_ONCE);

But this piece does not belong to the main scope of the patch.

>  	if (ret < 0) {
>  		dev_err(&client->dev, "Error in setting operating mode\n");
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko


