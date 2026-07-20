Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BEB38C2A0;
	Mon, 20 Jul 2026 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576978; cv=none; b=lks+q5FHqV1n606zH4HSNrS1lGuXPxuOgdxQwB4y35T89OJO0p7e8zpEiG5P7jcDsK8nQsnvlGbEL7vnTYDWTct0Nj3qVn7ljK3qlwiedOvj94hMC8eg73PfS4Ws8D0SNjyChhBTc0EbQPNB8p1POD0+rxSokHYfmDu4LIuzEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576978; c=relaxed/simple;
	bh=dNUN/44PydGUzYznEj20eeejUoNDN/1RJxRB/ssMOjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNLVlq6fCJbBrfA4CXXRTBzwhinwMrlHrenID/8ITRFsr/HiEZlaD4Dw6mKjdANHzkCkRTCZRRy4mJEo/ucNqC99Z9go6KWtlrFtCgWbHWQ0Ad/N/0Zat3ATprmTc2zqdKizJJtA+kYgdvNtHc9wAKGyv8um4dEC4hBZYRa5cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HW/hanw8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HW/hanw8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784576975; x=1816112975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dNUN/44PydGUzYznEj20eeejUoNDN/1RJxRB/ssMOjk=;
  b=HW/hanw8y4ySte/JvNUFHW/J9MEmN2ftQMxHf2pAyKCIGcuiy8Kruhoc
   V+lEOsCepaR42hC/DmdeR3IvPfhy6bb8dH4lk5QLGHwY0OjghGj6l3JwL
   f9XeTJKc0yTQwuB3lE0m8hT/wcqyq5ZSHCVAlmcyr4lBX0GXwxgDb9Ayc
   SvYIV1zC9vg6liEdZA3HY925Wv/EpfIixdWr2DPhNs9UhiO5lb/g990H8
   WXWzHSNu7tbA9UrM+cOaHAP2/IIxYPya5gTogEIRK+kVtit6IVNlpAI0Z
   O8KrCk61sDGn5aPl0sfbyhLHo6r6BTk9ht5yQfbO/eKvyc2TpwbGLTEQ+
   Q==;
X-CSE-ConnectionGUID: K+3xui94Ta2wg5Q5+ccL1Q==
X-CSE-MsgGUID: s4GJ93LjRZ2KCQJB4c6gWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96679924"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="96679924"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:49:34 -0700
X-CSE-ConnectionGUID: DFV9qfQgTrKmILh+81SZMA==
X-CSE-MsgGUID: xRgaN6FzSBGQvuzRrXOJfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257601659"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:49:32 -0700
Date: Mon, 20 Jul 2026 22:49:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] iio: light: gp2ap002: Fix unbalanced runtime PM
 on repeated event writes
Message-ID: <al57yj3AQoHpef6I@ashevche-desk.local>
References: <20260720193911.74919-1-nikhilgtr@gmail.com>
 <20260720193911.74919-2-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720193911.74919-2-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 01:09:09AM +0530, Nikhil Gautam wrote:
> The IIO core does not filter duplicate writes to the event enable
> attribute, so writing the same value twice invokes
> write_event_config() twice. Enabling twice leaks a runtime PM
> reference, preventing the device from ever suspending again;
> disabling twice underflows the usage count and triggers a
> "Runtime PM usage count underflow" warning.
> 
> Bail out early when the requested state matches the current state.
> While at it, switch to pm_runtime_resume_and_get() so a failed
> resume is propagated to userspace instead of silently marking the
> event enabled.

> Fixes: 97d642e23037c ("iio: light: Add a driver for Sharp GP2AP002x00F")
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>

No blank lines in the tag block.

...

>  	} else {
>  		pm_runtime_mark_last_busy(gp2ap002->dev);

At some point consider dropping this dup call.

>  		pm_runtime_put_autosuspend(gp2ap002->dev);
> -		gp2ap002->enabled = false;
>  	}

-- 
With Best Regards,
Andy Shevchenko


