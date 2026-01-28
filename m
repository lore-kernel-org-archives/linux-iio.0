Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C1313535;
	Wed, 28 Jan 2026 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605477; cv=none; b=c2ssxoBf7ypM1/02F2KdyRLqAwzToAqo3VEZW8PihWLqGmc4gU55mCy0b7XVUp8G5I18MpqT9nwBPFcgYBtF5nMITgIRWa2Egm6hm47Tet2gLPRbOO3v2uM2Fmq8TrfpKRHmOKoxhwsWDc4VYE4UKxu+8JFZ+C83fSiCBge39WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605477; c=relaxed/simple;
	bh=9g7MKyv+YMPSADkRHZSPgQS9EgPoF+uHewJscYmXc5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+e4ogkHYMMkQOA+SaFGL5/b/ZKrz9O/jtVOyFdX522T64Az0czpGRIZgp2hPsREMS17qquexVnctztGfyhGEBGt5QgQa5zR0YNl0GHOrsNb3E6e/OvOmv8x19nC04I44P809q8GielDo1NTRbztK03CCYGcKctsk6TRZz3QkGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ly6URt6t; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ly6URt6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769605475; x=1801141475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9g7MKyv+YMPSADkRHZSPgQS9EgPoF+uHewJscYmXc5I=;
  b=ly6URt6tqCWzKk9aW40HTzgnEknGUG+tfRoRSCC9jwlMjBd+dkUQ9tqT
   kFioyaoEspRX9kmc+vwv+x/5l4w8pxZC9AFw+yzPj2pKMeC/0Eozd+Nmc
   d3pJ/5lP6YKl4IlIiFewmU0KrFsdlUfE7vH0w47nPja7SagR0ZOFzXcha
   eWeWELVCB7Fw6s4tCIxQOUTkxssdiDLjdljHGWi/rM3pFCYElwRtwppzf
   d1MP2SquDgwKQfkwsWLTu4W+jB6Ke9ydVzI8YMsP2lXDSttpfWXoVQ2i/
   X4XA+9xwbin6mwejkayz8UgS1xw+W1pfwW/a1m9zMkh6QqsbMidXqJVUG
   w==;
X-CSE-ConnectionGUID: gcrvQgJYQTioVrMFhSUWKQ==
X-CSE-MsgGUID: O9IS46ErQsib/ajUkfHarw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70715844"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70715844"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:04:34 -0800
X-CSE-ConnectionGUID: vw9SGvMyQVOaxCbYc/5fAA==
X-CSE-MsgGUID: RTlhx+9dRYC4lBfiInDDbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208500978"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:04:32 -0800
Date: Wed, 28 Jan 2026 15:04:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 18/20] iio: magnetometer: Remove IRQF_ONESHOT
Message-ID: <aXoJXg5JFnFXZqUT@smile.fi.intel.com>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
 <20260128095540.863589-19-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128095540.863589-19-bigeasy@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 10:55:38AM +0100, Sebastian Andrzej Siewior wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> The force-threading functionality is required on PREEMPT_RT because the
> handler is using locks with can sleep on PREEMPT_RT.
> 
> Remove IRQF_ONESHOT from irqflags.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


