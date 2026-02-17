Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC2134CF;
	Tue, 17 Feb 2026 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314346; cv=none; b=J5h2WPARFGFGDW0uogJWIIXn58NcAh4ruvu5w95V5FNUo1yI0J70TVI2hJrWW8qsi6/CwfcFvgk78ZJsF6KfZXQS0y3J3QGMgnKgvckBreufxeB7HzFpPsEB+zNXFuIf7lMkLipnQTvVD6Gz9oS8m3OM76tXs5T4X+cELanPvm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314346; c=relaxed/simple;
	bh=KT4R3+dQ/+s1qRbkm5fwajt/CKP/UWZLygHnEURbo0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTDOjyyEKdcKEfW1js8Lz9g0Unss/VoCBYYPQZyppkZhieU5RgSG5pYEfDSlX+oU+z911zhaWL9YpY3BA6b+iPexODesdrrYmVik7b4K/hkZlkHCHmnsrmu33Pf/m3coQP4ZyNs0NRERrhgYR+mY5Iil22FGZN5ta7MdZLwZhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwhdCT/3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwhdCT/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771314345; x=1802850345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KT4R3+dQ/+s1qRbkm5fwajt/CKP/UWZLygHnEURbo0I=;
  b=KwhdCT/3TKyFMBzPplp5iitQf1grGoPm5Kv7hDBc8imVf5Z9S19CsYya
   ApTXvka7lGLY8/ZPgUgbilmEsBwv/yuelh3is4Nmv7rFTkSSlC3HRLIWr
   M7qzr73w6v8xf7P1tg0j5MPzvDNhD9hcxxh9y9hSfsctbFxvU9ygu6mTh
   p7/ovwzHWWzSzNR7LU6XMao+qpiw/wmU0ATQs0/SSihxn9LNsfDspdPVE
   FpHDPvxhmNknXt2pgvnjXA/HLlwGhYTxlujM2p7L/6cWyvYl97Qx9NZjC
   Q2Q4Ntk+TH3MfRQYhdYQX8vzewV5y5geQdLm00kOdUkB2yAwnapEeFpGL
   w==;
X-CSE-ConnectionGUID: xybsna5BRHK5HnbFoPTiZw==
X-CSE-MsgGUID: EVC2YiT1R4mwuO+4AAkG6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83101715"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="83101715"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 23:45:44 -0800
X-CSE-ConnectionGUID: r75+d6CEQ2GDPrYsEYk5nQ==
X-CSE-MsgGUID: i6GYj8hwRDu6DK3CRL79xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="213640462"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO localhost) ([10.124.220.245])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 23:45:42 -0800
Date: Tue, 17 Feb 2026 09:45:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: core: Simplify IIO core managed APIs
Message-ID: <aZQcpJV2GQ8vWnA_@smile.fi.intel.com>
References: <20260216081412.1118599-1-andriy.shevchenko@linux.intel.com>
 <525a30ed9127b689549bfaedc086638e2e3b5670.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <525a30ed9127b689549bfaedc086638e2e3b5670.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 16, 2026 at 02:31:57PM +0000, Nuno Sá wrote:
> On Mon, 2026-02-16 at 09:14 +0100, Andy Shevchenko wrote:
> > Use devm_add_action_or_reset() instead of devres_alloc() and
> > devres_add(), which works the same. This will simplify the
> > code. There is no functional changes.

> LGTM. Just one minor "complain". Anyways:

My answer below.

> Reviewed-by: Nuno Sá <nuno.sa@analog.com>

Thanks!

...

> > -	if (!buffer)
> > -		return -ENOMEM;
> > +	if (IS_ERR(buffer))
> > +		return PTR_ERR(buffer);
> 
> Subtle change that could have been mentioned in the commit message.

Actually not really a change. Currently the error code is shadowed to -ENOMEM,
but again currently the callee can't return anything else. So, it's just a use
of the regular pattern. TL;DR: there is no functional change currently. If
anything in the future comes returning different error codes here, that will
bring the difference.

Anyways, if Jonathan asks to elaborate and send a new version, I will do for
sure.

-- 
With Best Regards,
Andy Shevchenko


