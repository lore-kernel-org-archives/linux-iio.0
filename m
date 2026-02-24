Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5C0374757;
	Tue, 24 Feb 2026 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927690; cv=none; b=PZmtUwb+bpXaNObpx06+xWZ/5gRnpL1s1U8O6v0snWMTrGsD+DGqIfkOK3rVPnxaPQ0a1TRlrKK08xlRHDFKQZdKYldGBITxZygVDvf7NGB70t2YsPizxkNfzyGP+jpkXsZi1zPDAPLNE+qGSMPHOymT1JbtuRlkP012DhulokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927690; c=relaxed/simple;
	bh=KXOUVL3hX9ON5zHYvStt/BJwFczI1Uh4aRQu6YNLw4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZCAlY7uh8TyDBWxo65T7Nxi7bgao9rWEkNP9qpOzeqSbgMxnPzzGYhvgIP5c0Jog+HQNqGvW4muYUkg1HqQQnTORJp7LIs2QaXrPOoslvsSoLWRYv/vM3N89uayIZcUag9bcNlgaG/vQjewLAzGgFPGi+/N+60clNYvT0ogmJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVfRV3Gb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVfRV3Gb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771927689; x=1803463689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KXOUVL3hX9ON5zHYvStt/BJwFczI1Uh4aRQu6YNLw4M=;
  b=eVfRV3GbDTXF2xmibNESqbgh6VLnq3Ldj4pmJj9AN1BfAs3KuZupi8ZW
   5AKICGmtpPd4di7VVdnFyeJS2NMHcBueNF8SyzNEZ0LsZRklglVJ+WKAt
   T21ZnU07Tjb6gZJy0xmeqKNrs116jatGzw3xe3jHz0dlnHrSqZKnbcyki
   aSnIPNoQKUWqJlsmkCGKhDEfyA04UBfhOzVfgaSHaZZLRrWS7H0KfrbKs
   QMLE9NDTacnB8oCv+2JxHQlFfg91rYh3fatQw7uIHGqpB1hz6vG++1aTS
   byjjf6eA4BTUPHfS2Fk/mwfWJjL1uNV8+oP39Y7CG+UWT+qUIRMTO/Vm1
   A==;
X-CSE-ConnectionGUID: 85tOtVFiRdaOhH2yNz+trQ==
X-CSE-MsgGUID: IzOwwEmISgmOIn4MUcTurw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="76799333"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="76799333"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:08:08 -0800
X-CSE-ConnectionGUID: RCaAtVl5QFCIDBWRUQTixg==
X-CSE-MsgGUID: KsPO6bG9Qgi16Pm8FrGWSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="220427569"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:08:06 -0800
Date: Tue, 24 Feb 2026 12:08:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Multiple bug fixes
Message-ID: <aZ14hOnF_EKa8MSc@smile.fi.intel.com>
References: <20260224023511.274038-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224023511.274038-1-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 08:35:07PM -0600, Ethan Tidmore wrote:
> This series fixes 4 bugs:
> - Patch 1: Fix free_irq() being called with wrong handler.
> - Patch 2: Added missing free_irq() in an error path.
> - Patch 3: Moved iio_device_register() to end of probe function, in
>   doing so had to implement correct error cleanups and place
>   iio_device_unregister in beginning of remove callback.
> - Patch 4: free_irq() is after called iio_triggered_buffer_cleanup()
>   which breaks LIFO, place it before it.

All good, except one stray change and some work needed in the commit messages.

> I plan on doing a proper devm_ conversion of this driver, but went ahead
> and did these fixes so they could be backported.

This would be nice!

-- 
With Best Regards,
Andy Shevchenko


