Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CCF3ED11D;
	Wed,  6 May 2026 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060782; cv=none; b=qAZEzQtWpZ+sTbISMD3YpUj7ysxYqISMw4JC/Feajc0JoNCPfBuS5yY++dyV4oZ645nEhainPUK7uNBGfAmCLfqSPXzPUhPLYzk1GhrMTY8m0ff5Xh+ax0T0GjavY+tqVZkBd9k4D4eXedPHBLnEINy+2JPkWRG/mVlnb3yGnW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060782; c=relaxed/simple;
	bh=QqC8LEVpTz3pg3OMGwsxsauMkDSynDr1adzKGcqXssc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cdcz6jaJbT5HrqF0bKoVPcX2flc/60JWfwdmmXRhAHHdHUYaby0wcvuCezVMW0JynFHmSzw7b/Nc+ci61zOZsqWKjdjJGyBLm8ucsjSBs2KRT/lre5vWsT9mJirpEHpJ49ovspwr4L3dSPFBXneqxQ5xqjhXlbQvhE7YXvPSrr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxZa091X; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxZa091X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778060780; x=1809596780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QqC8LEVpTz3pg3OMGwsxsauMkDSynDr1adzKGcqXssc=;
  b=kxZa091XJpAxumDb/X6m8+q2bYTXwJeJSAcjSq9h67BWj0XTqddTD6q+
   QiJddKa3vQ7xooFY6FeUJOkUj1rv/wJSwZnxaO49fU6HRDR0qwcQENS8Z
   yMyuZz9fqdh++9sbrPTFMUd2EODwlHg+4pxKwQ33Ru/+wdamnQRkNoli4
   LLGcJU4bP+KLHQs6l47zBK9m+5xiZU87WH7eDXh4gy3N1ve0LM/BRwb4v
   GmvZfJIUCfiaZi0zwykvQdDZX+viRNYVzD/ihfDwFlhNmonGBECaOPUVn
   34f2yI68jGHDQMuOMpThvA4LWyXAg6IghZOjBE/D7CQqQhK7tvHDqXSt2
   Q==;
X-CSE-ConnectionGUID: gnGnT+X3TXmBVR0/MYyknA==
X-CSE-MsgGUID: SK4UcReURiWaRU3215DkGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78876718"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78876718"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:46:19 -0700
X-CSE-ConnectionGUID: GBn2OqRIQ06I7QihOKbmzA==
X-CSE-MsgGUID: UI/SSZDBT1WsLmscqDrjQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="235984982"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:46:16 -0700
Date: Wed, 6 May 2026 12:46:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com, martink@posteo.de,
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/10] iio: accel: mma8452: use guard() to release
 mutexes
Message-ID: <afsN5vIeYqteoZIs@ashevche-desk.local>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
 <20260505174640.3998281-11-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505174640.3998281-11-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 11:16:40PM +0530, Sanjay Chitroda wrote:

> Replace explicit mutex_lock() and mutex_unlock() with the guard() and
> scoped_guard() macro for cleaner and safer mutex handling.

...

> static int mma8452_read_raw(struct iio_dev *indio_dev,

>  		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>  		if (IIO_DEV_ACQUIRE_FAILED(claim))
>  			return -EBUSY;

+ Blank line here.

> +		guard(mutex)(&data->lock);
>  
> -		mutex_lock(&data->lock);
>  		ret = mma8452_read(data, buffer);
> -		mutex_unlock(&data->lock);

Perhaps okay, also scoped_guard() can be used, but I have no strong opinion.

>  		if (ret < 0)
>  			return ret;


-- 
With Best Regards,
Andy Shevchenko


