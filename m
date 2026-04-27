Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3788225F99F;
	Mon, 27 Apr 2026 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277125; cv=none; b=JWXf9EcCLgvBnHYdvrLHORw4KMHjrh/lwVIGEBya/JsJoCyekow3h9k7rHkNgwQC14s7iHFAytFlgnVSTLlkmeET0cJMtYRf0yWi0FEdHlIGDT7Y/J55sOQHWJgC+eVPUx2ZlWuvX7OGUgrjLYv/P1Y1WolMVJ02jO+KiuyseDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277125; c=relaxed/simple;
	bh=q5tLXjU7WIhA2qSk4UxmNbJVg9Ld6cYKAni8QnnAvOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG4VBY7TXTLX+a9+5QWF9ggZ2dtrdGsXVcBfRgL72hJgulLMwS5Qagu7JtwL3S6ib8vM9AQyuwAem5YeoOgb9vpv41euRZGUDkwoaTBQa5tI9/pDoHNG44OclU047YeyxLakAp2zHK4rL0/G+Lwrxd9jnr6AmGPOMZoXok24x1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGH2ohi0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGH2ohi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777277123; x=1808813123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q5tLXjU7WIhA2qSk4UxmNbJVg9Ld6cYKAni8QnnAvOo=;
  b=YGH2ohi0lKwNUtCnLvWzztS+21c8puNvNz6lcBso/4T8nVOM2hLDMdOV
   H+U/hYo1cmLxxuvBC8Ouwt2tMoQIUgGl3mcGzg48Yzigck4NMnS1/0ql1
   GXn2FlKLMFU9H/tZCNIEImaMcqsoxZCJh0DqvJF9xKv6cpK18IaYiyBr6
   23uf93JH1yFEomm07zHHDr6D1NG+gSorxIUF9uYz4RhF5+5OOxMyZhHRh
   lGjh+i9UoFoP9X7oCHM8Gv1FNbfnd9kvwfpQlkW5q8TU3HsLvZNqZwVmy
   Fj7Td1T3/vh+A1/fbQvdqnnV9YI0PF3xEDQ0fZV6udT7CDvsRJfMPBjBc
   w==;
X-CSE-ConnectionGUID: T3xk12XpQPOrybC3tEIZvQ==
X-CSE-MsgGUID: L8AtL4Q/TdGyk6bP6eRUlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78048890"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78048890"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:05:23 -0700
X-CSE-ConnectionGUID: Pe5Vrv34SX2EPUBtKZubbA==
X-CSE-MsgGUID: DN27PKeTS8OYxX5xA9yA3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="229007670"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:05:20 -0700
Date: Mon, 27 Apr 2026 11:05:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, mingo@kernel.org,
	christophe.jaillet@wanadoo.fr, nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org, kyungmin.park@samsung.com, k.wrona@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/9] iio: ssp_sensors: factor out pending list
 add/remove helper(s)
Message-ID: <ae8YveYx8hYFWORk@ashevche-desk.local>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
 <20260426091710.3722035-3-sanjayembedded@gmail.com>
 <20260426150830.7ab41ad3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426150830.7ab41ad3@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 26, 2026 at 03:08:30PM +0100, Jonathan Cameron wrote:
> On Sun, 26 Apr 2026 14:47:03 +0530
> Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

...

> > +static inline void ssp_pending_add(struct ssp_data *data, struct ssp_msg *msg)
> > +{
> > +	/*
> > +	 * Check if this is a short one way message or the whole transfer has
> > +	 * second part after an interrupt.
> > +	 */
> > +	if (msg->length == 0)
> > +		return;
> 
> I know Andy suggested your bring these into the helpers, but to me
> it's obscuring flow as it looks at the caller like it was added
> to the pending list when it wasn't..  And we end up with multiple
> checks on msg_length where we had one before.
> 
> One option would be to have it return a bool to indicate whether
> it was added to the pending list or not.
> 
> Andy, would that work for you?

Sure.
I have looked at the proposed use and have no objections on the approach.

> > +	mutex_lock(&data->pending_lock);
> > +	list_add_tail(&msg->list, &data->pending_list);
> > +	mutex_unlock(&data->pending_lock);
> > +}

-- 
With Best Regards,
Andy Shevchenko


