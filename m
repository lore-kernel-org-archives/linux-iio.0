Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804B3815D3;
	Sun, 10 May 2026 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778414173; cv=none; b=dA7v66vajuOJZ7IX9b/Cp5YOisBlvyZjSl8D+SFy/ekYFwB0HBMsCT1EG3u9pWDj2RUmAE+AqUpppVfv9iAL7+9tCWZNT0otZ55Hq5kDZzDrcNzoWLARiVf3roD61c56y7lNNrJ/3e/6cB3OFW17GSi2LlfA2P2VNKr11FDMdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778414173; c=relaxed/simple;
	bh=kxYY+k3pTfGxuyAEHWIO012CogjeDGjaYTeKhqgHZw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZNJqKVQlGJPRh9cZL2LP4ooWrA+PX6j9759BzxctX2WnbIqhEnc5intxbKMxOvlNfP3LijkDG9FVXzgyRxxwGWLcgjMhreO0aKJ1E+MxSbIZDakabNh3TFzxteMrqvaA5do8ZGpSzc7M4OYNqrA0HscAh9vrh1gJxtRUoChVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISNXP1uU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISNXP1uU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778414171; x=1809950171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kxYY+k3pTfGxuyAEHWIO012CogjeDGjaYTeKhqgHZw4=;
  b=ISNXP1uU/n9Eo43C2rUiqrcg+YaiGtUW4MMLqsOci+fJZZeS2huhU0kO
   mHXoNVmN5LhnP9zcVDC86pGBixtCaxU7hGUY+MbSnGplAXLJMVNx8yaGF
   Sa2+V8Vq5G0QAR7BriYa7biXrEQRqrgAGm4TxTi2FZ/tvZxlB1CNEgfRS
   cRVVxC9t0sXpCU3ecvo6Qw7/JNuZnDqTqr9k6TAJuOJIn8+t2Ke3nmEo6
   yDSx0V3lxXPaEBri1VvaWHNenBdMubXUGDtibH3g8b6+1tjmWVIEO6C3B
   hcMkY+0FxaXo7S2usGv7XsJ+Bf9SYFu0fjHzE+4VJXGsFObX1/0yTUK8r
   g==;
X-CSE-ConnectionGUID: GTacoAzZTQaj23LmXOd9ww==
X-CSE-MsgGUID: yj++eA/MTT+MjzKu17NTvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79176828"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="79176828"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 04:56:10 -0700
X-CSE-ConnectionGUID: aZ/nfBJATU6M+s0Mgtgp/g==
X-CSE-MsgGUID: OXxGSmM3Q/ujG8K9wkQmvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="234542648"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 04:56:07 -0700
Date: Sun, 10 May 2026 14:56:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: andy@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, gregkh@linuxfoundation.org, hcazarim@yahoo.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: bmg160: bail out when bandwidth/filter is not
 in table
Message-ID: <agByVSgm5LdXR6qf@ashevche-desk.local>
References: <20260510023500.61036-1-sozdayvek@gmail.com>
 <20260510030647.2225-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510030647.2225-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 08:06:47AM +0500, Stepan Ionichev wrote:
> I checked patchwork for bmg160 -- no prior post for this fix. If you
> remember the thread, point me to it.

Okay, thanks for confirming!

> Same pattern (loop with 'i' used after no-break) appears in other iio
> drivers too. Maybe that is what you saw.

-- 
With Best Regards,
Andy Shevchenko


