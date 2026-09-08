Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A97C4A99D9;
	Tue,  8 Sep 2026 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861335; cv=none; b=D8WI4K8FAbZJnKfvLo0tJG3BT7USWdBN22BslafxNO+3PvTGiB8XDIDAGoBSD0nOLLawyinGxhill1Dp/jd/uXdfeQpjtGF90hGNBYJgVnTJBtSmrCtCMJeVacInu3Lt9sE4tYbDamx/RUO0+0M9YWUE/+CStnNHudVrYZ0rh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861335; c=relaxed/simple;
	bh=IOGVv3ITyGvJ/zbGEFcrtgARvG8cKrmVpMegaAILG5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xo7uwdwehVIvjEPscmh6EDy4HXEgn8Ugyq3s1GBkX+ge54QOa5MORMoaL93LeegGtlJ3EuIzI3s58ZmCpw2xcBMDSpLgqa8RB+7l+OS6ZhrJY6aiRCHGpiulRcxwJjKEfjtl9qdVIt5MligntWTZqSRYs8jUyFm2m4ra9MY7vyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hl7OZSk7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hl7OZSk7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788861334; x=1820397334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IOGVv3ITyGvJ/zbGEFcrtgARvG8cKrmVpMegaAILG5o=;
  b=hl7OZSk72l0aWnKWrUwZsPQSu7C+wNzqmlizT5SfHR/KHD9K9BfIenG+
   fPEuCDAL/9OsABfM7m7tOYTzbDwwGHdnbPoH9B3+pVZhRBDk4nwGPhMVr
   GvvqC7jWDesIbtPniN4XRoLr63CxsrLo36AA59xBlCnqbXFY0K0mviCIy
   tZ40vhnNGz+Sssod1nrL/TQeDl0zzvCq/HB4wiFCPP8wUVTJxeQNfUgaD
   bpbpkHd7DrcPLNxHi9T+YWjNIjcaHQUxc5sXog1JUcP0ALfNg81hIql4e
   OZ94KWuduSpQwUOC44aDv90FXuh66rAuTBYh6bGo3CHmtXaYs0cylU+tV
   Q==;
X-CSE-ConnectionGUID: G3++gP8KQSuxQ9vr8Gdm6g==
X-CSE-MsgGUID: qscoSn8tSdSTQ9xs2cgXVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89184381"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89184381"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 02:55:34 -0700
X-CSE-ConnectionGUID: iqqWacSYQKi/oeTE8yIm1Q==
X-CSE-MsgGUID: TK/jmu3qTV+AT6eL6jB0rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="294432507"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 02:55:31 -0700
Date: Tue, 8 Sep 2026 12:55:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "hpp.iscas" <hppiscas@163.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: Re: [PATCH] iio: accel: bma220: Publish the SPI driver's ACPI alias
Message-ID: <ap_bkdMOMw6HEgTn@ashevche-desk.local>
References: <20260905133901.66016-1-hppiscas@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905133901.66016-1-hppiscas@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Sep 05, 2026 at 09:39:01PM +0800, hpp.iscas wrote:
> The BMA220 SPI driver registers an ACPI match table containing BMA0220,
> but exports only its SPI and OF tables. SPI devices with an ACPI
> companion emit an ACPI modalias, which neither existing table covers.
> 
> Publish the ACPI table without changing either of the other matches.

...

> static const struct acpi_device_id bma220_acpi_id[] = {

>  	{ "BMA0220", 0 },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(acpi, bma220_acpi_id);

>  MODULE_DEVICE_TABLE(spi, bma220_spi_id);

Ouch! This one needs to be moved closer to the respective (SPI) ID table
definition.

>  static const struct of_device_id bma220_of_spi_match[] = {

-- 
With Best Regards,
Andy Shevchenko


