Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D350258EDA;
	Thu, 18 Jun 2026 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781805218; cv=none; b=E64CgxhrHxiB+/GyO8wHJzu1Qxcyg0ORKTPj2aksuj3NvCWTZxTpgjKSpACIRaJ04cvO+5KhNAF5W5jAvoeemBcSKq0DBEPs0M7bMY+BlTW+e/9WzASl576GiMJiJSt7yjVObPb+3PjpXnfvr9M74diT7+eD9hLxzf5HnNISC7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781805218; c=relaxed/simple;
	bh=REREQ8rqadpi9R5D1wjPGX/7CIe3s5C1ebpZWoeXEPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myxJIgperqSLe5A3ic13/QtaERGRMacDJF6sB51cbutHf7Ut30bpCldo3UPo5JgG0FBSmMnB2PDWxEIklwyi3TM9cie+XKqzK1ZOI3AnNmNZQkKAVdeOfAXLSMyzATAYFa0Kcr/GwSMl2TIfMz3FYVCkC+MaAt+yKCblghat+Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwYd+6xI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwYd+6xI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781805217; x=1813341217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=REREQ8rqadpi9R5D1wjPGX/7CIe3s5C1ebpZWoeXEPk=;
  b=mwYd+6xIzJVMAQV9tNFI9kTXPPkWE6ephRRarVLv0wkD20VQfpmqjWYZ
   sfHobtl5qfefYKkUvvjFwjc03qBQn1R8ez01Wh8AW71vxeXjm2HCgpW4K
   aQTWXTtYGOxEsre0Kf8Yq2o/u7ZkjVnkKTLAoi6Vmpbw3lDavYn3Gy63y
   hM8QHhs/PcsmgkhCMADQfFbrhETXfcrxChQ9nLuqK/ja+zsLCa2X28jLD
   AUVHvPTEj9zqaAoQ+3UbbEvB63mx8ISV+s1uQY9bguUKYJTvpk6hFWT9F
   wIk/UkByX1X7fIi18AJJY1bLN7zEKHfp5N/n7H0aRShop5hcpiUvruQco
   Q==;
X-CSE-ConnectionGUID: ItVRdEQ/Rm2IiPwjcIFR+A==
X-CSE-MsgGUID: Jdqb47PhT/mQGqVLvx+9Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82654054"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82654054"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 10:53:37 -0700
X-CSE-ConnectionGUID: PaLwyNZ4SqWgcNhOzPNmKw==
X-CSE-MsgGUID: FviU7My3QqGaq3kzmDnfBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248492703"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.10])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 10:53:34 -0700
Date: Thu, 18 Jun 2026 20:53:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	m32285159@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v2 1/2] iio: chemical: sps30: update email
Message-ID: <ajQwm5PKc0UJ1o9U@ashevche-desk.local>
References: <ajOXKKDWrTURPpro@ashevche-desk.local>
 <20260618162139.124562-1-tduszyns@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618162139.124562-1-tduszyns@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 18, 2026 at 06:21:39PM +0200, Tomasz Duszynski wrote:
> > On Wed, Jun 17, 2026 at 07:27:15PM +0200, Tomasz Duszynski wrote:

...

> > >  .mailmap                            | 1 +
> > >  drivers/iio/chemical/sps30_i2c.c    | 4 ++--
> > >  drivers/iio/chemical/sps30_serial.c | 4 ++--
> >
> > I don't care much, but the cleaner approach is to have a separate patch
> > for .mailmap and put it at the end of the series. Otherwise it's confusing
> > that it's related to a certain driver, while changes are applied across
> > the whole tree.
> 
> No strong opinions on the change itself, maybe except patch ordering.
> I'd rather see mail mapping update placed before driver changes to make
> sure it is visible if bisect ends up in the middle of the series.

Works for me as well. Just make it separate.

-- 
With Best Regards,
Andy Shevchenko


