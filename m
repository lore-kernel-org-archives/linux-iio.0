Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB09381C4;
	Mon, 16 Feb 2026 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771226527; cv=none; b=dO7KA8CRkp0PDMrcAZzcAqoVp6vk3x34JshDhVw1WDjJtX5hg4tMaQSNt8YqO2Di6jl7KTLcZdeSJMRIw9uS7c2NKvRq+dbZz7BUvJ374Kyhd7rA+O6XEMZ5L8wBQkxc06KAkzkELVQCXvvX9JUGT87AWe8bsSi0/Lh4I8X7ykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771226527; c=relaxed/simple;
	bh=Nb4Y2Owg+oPm3X2J5pjWGTxhA6QRDx3KxXgrNhZlQJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImTdAz7jMMAiKJ+PXDgUjOB3F6OT5YOzPAQtH7jgTuhQkNppV2pTYk7f+sSErqrQEQj34t8ZqJWD5itxguxH6soSQA36jiIFkg46Kr/piXfNW6BZrN34ckHpg9WOcTwusC1NwdHCAhKUEMrDuRIruDb8ksh5Rpg3eWdXFKmm5rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=inomXu9L; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="inomXu9L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771226527; x=1802762527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nb4Y2Owg+oPm3X2J5pjWGTxhA6QRDx3KxXgrNhZlQJw=;
  b=inomXu9Lbn89ITKmvkYHfvXkoUe1nOGNVpUCPmwix14zq4OgKV4yW/iQ
   UCN2Golyh9FNaxfFAo9tlQ96/wa2qb9hD/nm3FCPhf4K0cVRz2oZN5Cs+
   09bYtORNFWidnBkczASbiynlKlGMGr7ERYZAIuMnvJejb5chaCv0jxorQ
   xOrJ3NZf78R1RXweh5rYjWWvze720pQsMOHJbjdAP2XAutHneWqtm8N1a
   S3r2msLHYZ6bi9F46CjJ+G03dD9R8iF0tdZ93kPl3UWcyahRbKdVb2Dky
   XsZV4qnK5AEKJREXWZeQiMqeB5sJl1yvXTeaujrJvxnEeXkKKqQ8rvt00
   g==;
X-CSE-ConnectionGUID: CGiQQnliTtm/wk5gET2QWQ==
X-CSE-MsgGUID: vqoKXCUdTSKoQmDJSEZzJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="89715662"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="89715662"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:22:06 -0800
X-CSE-ConnectionGUID: w5v6uKX1QJWBC5A7UwSRiA==
X-CSE-MsgGUID: 8BgrnQS+TUeKRf5yIUJo6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="218499365"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:22:01 -0800
Date: Mon, 16 Feb 2026 09:21:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Taha Ed-Dafili <0rayn.dev@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mentees@lists.linuxfoundation.org, me@brighamcampbell.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v1 2/2] iio: dac: ad5504: use adi,output-range-volts for
 scale calculation
Message-ID: <aZLFl5YmByDTqjmL@smile.fi.intel.com>
References: <20260212181955.42724-1-0rayn.dev@gmail.com>
 <20260212181955.42724-3-0rayn.dev@gmail.com>
 <aY40-0v9tbXC4tPY@smile.fi.intel.com>
 <20260215180538.36f536aa@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215180538.36f536aa@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 15, 2026 at 06:05:38PM +0000, Jonathan Cameron wrote:
> On Thu, 12 Feb 2026 22:15:55 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Thu, Feb 12, 2026 at 07:19:55PM +0100, Taha Ed-Dafili wrote:

...

> > > +	ret = device_property_read_u32(&spi->dev, "adi,output-range-volts", &val);  
> > 
> > You can pack this into 80 limit with help of
> > 
> > 	struct device *dev = &spi->dev;
> > 
> > being defined in the top of the function.
> > 
> > > +	if (ret)
> > > +		val = 60;  
> > 
> > Also this seems an optional, so
> > 
> > 	val = 60;
> > 	device_property_read_u32(dev, "adi,output-range-volts", &val);
> > 
> > would be enough.
> > 
> > ...
> > 
> > > +	if (val == 60)
> > > +		st->vref_mv = 60000;  
> > 
> > 60 * MILLI;
> 
> val * MILLI
> given it only takes the values 30 and 60 I think. If you want to protect
> against other values, then check it explicitly rather than everything than
> isn't 60 being assumed to be 30.

With comment on DT in mind I think this multiplication will gone
(as IIUC the DT units is microvolts or so).

> > > +	else
> > > +		st->vref_mv = 30000;  
> > 
> > 30 * MILLI;
> > 
> > Needs units.h.

-- 
With Best Regards,
Andy Shevchenko


