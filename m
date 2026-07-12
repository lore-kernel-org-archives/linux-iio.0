Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50750369D71;
	Sun, 12 Jul 2026 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783849893; cv=none; b=g97C+wdqks5mgnHZo7cB036mTusGcvG0eldW9l3A8tFDCyfPHWkrAZWbhX8KWU743OvGCgFEX5fbynmFSrLPGQGiC8n53wK6zhHrFyCh0TE2VnHgA/PJpwM5TYnXV5G5OXtr95wepP+AfgEMVoG87LjA4dxyvbf5mL2z1iFrsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783849893; c=relaxed/simple;
	bh=UUTPrVk9MPoWQl5qgG7RoPAhAuxqhxAdTplAK3yIO5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTTUnVfRtwv4wK11UjsOGWsYHZpD9U/UZ8GsxkxxlPYJoNxDOW3Xs3/pFkG3wlZbUC0+RV9PAtXRj8PjFZtjgailheWfUoUwcerE1H6OQcJu3Gy+Y9q0bAn+ZK5rUh0XmvuvFkHVUOrbHc+l4ZsF8UZ0tNAKWhMKriaEt07fytk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JS0rhk09; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JS0rhk09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783849893; x=1815385893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UUTPrVk9MPoWQl5qgG7RoPAhAuxqhxAdTplAK3yIO5w=;
  b=JS0rhk09rEP0g8PeFENFHx3DKgyiCioYM4n0A5y7csI34DdZM4B8yYlJ
   l1ect9rb2FNpZyDgNTEOIxKytvBM9e1MPRrJi1kWoT3aoarUwVCl8YIBD
   xIEUNaHcskyiY+agIYA2LrxHVMX2rFSGdiIcBEMUwUxeOhXjbHZsGGGdx
   2T0yfY5CuUtR0KD9KJyxcFy7pf7jYGkd87/LhsX/odAVleD0U3gXvfaLl
   PZK3SNWoLvUt7mnmaJ6DAUrXjM5iGhr0BlZ4DSxJ0G8M1Jy+xk55Cx23U
   FvJmKqYessBsI16vMY7lN0R/VrPyab536Oe75c4pKSdESs8ShIwHXxJYR
   w==;
X-CSE-ConnectionGUID: kr0RTc1KR9mwbfKh2OYA1A==
X-CSE-MsgGUID: Pd6RJHoaTnyKq61q987vhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88170047"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88170047"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 02:51:32 -0700
X-CSE-ConnectionGUID: bbqStwH/QtW4X7FAHnfr+w==
X-CSE-MsgGUID: FyBeK+vATgmoXHljqIdUMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251315259"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 02:51:29 -0700
Date: Sun, 12 Jul 2026 12:51:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Jinseob <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/5] iio: osf: add authenticated stream parser
Message-ID: <alNjnjAlLRr8Q23k@ashevche-desk.local>
References: <20260707014525.1015-1-kimjinseob88@gmail.com>
 <20260707014525.1015-5-kimjinseob88@gmail.com>
 <ak0cVeEUhNP1wTkQ@ashevche-desk.local>
 <CALMSewLACs7+QEq=3Pp=Wo6dvmEu0hFjmuOx8oe0AGoZHPmADw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMSewLACs7+QEq=3Pp=Wo6dvmEu0hFjmuOx8oe0AGoZHPmADw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 11, 2026 at 12:24:12AM +0900, Kim Jinseob wrote:

What happened to your email? Regular MUAs add the line to see the quoting legend,
and in your email it's gone?

...

> > Seems like reinvention of min() from minmax.h.
> 
> Agreed. The open-coded minimum calculations are now replaced with min().

You too eagerly removed the context... But okay, it seems you agreed on
the suggested changes.

-- 
With Best Regards,
Andy Shevchenko


