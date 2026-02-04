Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26038F244;
	Wed,  4 Feb 2026 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195838; cv=none; b=LvAPmYpyokf8h85cJKun0bmwEZReWYa8UXUkvbUxA5J3Fis08MrCZX4JOxr3569AAznDva0XnYOlETTXK+DDsYkzdLUJGF0h26nhbqNJoLQcio5qn/yB5pnn+S0uqptN5tiE5xWWTlc1AIDzm24mBtGZ0By3m6AuHNQZ8ouTaU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195838; c=relaxed/simple;
	bh=vD0IqnUSnxdU70kZhm7OGyJ3hWcmG3J2VGFCoEGs8v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAIQxfU+ea4K2ftnQkCRB7Z1O8eBxMwQwRLOjPyosBtvN9+pwLFOWZDQJvUJF23rrf6kFpBLO53uG2Ahk0xP9EEO7D97N9zDelge2IxGNLA2AWredXfo7oAlteUJ8tbNOJN1fiQWx872VzRguG62B3+zY8ucND0xOwXZ1AxctqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPDhSbiP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPDhSbiP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770195838; x=1801731838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vD0IqnUSnxdU70kZhm7OGyJ3hWcmG3J2VGFCoEGs8v0=;
  b=bPDhSbiP/PyARTZ91uxEDzW1eP5uABpngvHcdrcwjJ9mv/Juv9qAvqrv
   ByMu6H2iMNC1gs1yYW9YeYbXHW3NRiqqOvRJ5S503iLVAWWYN2+4pFBA0
   6oJh/Ye7bawgoWK0Z4fL7u5+3XcwdoqRVjZpzYgP0EXXXUj/yK7xU+m8D
   4EA2sBE7OPTeWjHKDjil9Sz0lk1LeuWw54LUXoMDgFoO6ZXPJNrgMl9Rq
   HjDDMQkdn4xllit88HJmI6+TZZPz6R3w9vhydKRWP65XTXl/sIr9JqC7v
   6nksHNdUOlFLWBs5YsbSh01a8cz4N7d52/PY+ebzuDE+nFbEc7P2n6/4Y
   Q==;
X-CSE-ConnectionGUID: vfBjdyP5SJa5gDPKnvtSJg==
X-CSE-MsgGUID: MMLbuNR3RFGtW+SO7Y3N6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="73980850"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="73980850"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:03:57 -0800
X-CSE-ConnectionGUID: DmhnYj/3QaSskQ9oe17lRA==
X-CSE-MsgGUID: OZ/llYVzTkywrd9y8hJFVQ==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:03:54 -0800
Date: Wed, 4 Feb 2026 11:03:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH v4 next 3/6] iio: sca3000: make stop_all_interrupts()
 return void
Message-ID: <aYMLeAaQm35-4Sgl@smile.fi.intel.com>
References: <20260204061219.791037-1-harshit.m.mogalapalli@oracle.com>
 <20260204061219.791037-4-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204061219.791037-4-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 10:11:58PM -0800, Harshit Mogalapalli wrote:
> sca3000_stop_all_interrupts() is called only from the driver remove
> path and its return value is discarded, so convert the helper to return
> void.
> 
> No functional change.

Yeah, as I just replied, the prerequisite for this should be move upper in the
code where you are going to use it in the future.

...

>  	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
>  	if (ret)
> -		goto error_ret;

> -error_ret:
> +		goto out_unlock;

> +out_unlock:

While this is correct change semantically, it's not needed as very soon
the other patch drops this for good, hence leave the label name unmodified.

-- 
With Best Regards,
Andy Shevchenko


