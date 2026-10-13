Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FAC3EA967;
	Tue, 13 Oct 2026 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899935; cv=none; b=JjEcFw+KcAVSZ6iCUHkyUpGpjSlbc8PqOoTW+gFE/dmB59nvkI26MMpwHI3gw6RBZAc/+s2xcGLurhwP1686dIjX9FW+lEZjodTy9vxV4WU4CD5UpKgwZ7WkY7jiuIU++HmnuySIYRw7JqmLH1Kdd656HOZO92YrcSiERcyw9Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899935; c=relaxed/simple;
	bh=baFHtlj2nIYozB3dAGHLmfTJPckQICOvlEpZq+8NlXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k18eZnAcoN2BSYdgIwzjGEImcwHurxUclZS5YS3I7LL/wmbaLsKjJ7uimVt5tGLHy1HLYJDp3DfMaxWUvHapw7aI02pVNIkCUENNnGIjDTbFUZgdFny64tCXcMRuSpgQw41Jwn4fug43G1iEHKZHcET1Prq/CCwvLR66e41X70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ar6g6upN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ar6g6upN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791899934; x=1823435934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=baFHtlj2nIYozB3dAGHLmfTJPckQICOvlEpZq+8NlXU=;
  b=Ar6g6upNtpfF03mk0a0EmHkGt4kllQKXNc3Qev9ye6QuxGsV+fXfP3de
   SsKBnvYVozb8WUD+2q4yx9ki60kHtyB/jNo+JrXMQL6JMv3nVJu3jm47N
   hDNfUr7Er1s5IxHhVQUH2zblhbEgwh6oo7lYGm4O2g3v9VvRB9rk922Sf
   Z2m0/myIjKeOfa2ZRsJf4wbPiJRX3H+ao26LbBOd++Hv7ZFY7p06Gdm1U
   nESSQBr9rB6mGYl0vjmPCKYBsuTd2nosxdkNfpYv16Zmjt8t1kFPgZy5n
   UGd8ZCSyhy6Zso/MT4GNKNt3J9LgJCx9JGf00/BjC34YZ9mZYHYE8J74V
   g==;
X-CSE-ConnectionGUID: PPbX94oUSgydubiZQrAp8g==
X-CSE-MsgGUID: 7zGVsBMNTzihxZ3T3xnM6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="728337"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="728337"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:58:53 -0700
X-CSE-ConnectionGUID: upHYerQ9Q826rwyLzGUOmQ==
X-CSE-MsgGUID: /hucUYkFQ72rtdQ5M+j57A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="2930776"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:58:50 -0700
Date: Tue, 13 Oct 2026 16:58:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Andrei Stancovici <andrei.stancovici@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] iio: adc: ltc2497: add LTC2493 support and
 line-frequency rejection
Message-ID: <as45F3tHGzTc6lMk@ashevche-desk.local>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
 <179189735509.1005940.16593087405634433360.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179189735509.1005940.16593087405634433360.b4-review@b4>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 02:15:55PM +0100, Nuno Sá wrote:
> On Fri, 09 Oct 2026 11:43:33 +0300, Andrei Stancovici <andrei.stancovici@analog.com> wrote:

[...]

> > - pyadi-iio hardware test suites: 41/41 on the LTC2493, 36/36 on the
> >   LTC2499.
> > 
> > The series was rebased onto the base commit below after those runs. The
> > rebase left all four touched files byte-identical, so the code posted
> > here is the code that was tested.
> 
> Not sure I agree with how you split the series. To me, patch 2, 3, 4 and
> 6 could be very well just one (adding support for the new chip). Patch 5
> becomes preliminary patch which is adding a new feature the new chip
> will also take advantage on.

But they are sound like a good feature-wise split. I would leave that as is
currently.

-- 
With Best Regards,
Andy Shevchenko


