Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59522318B8B;
	Fri, 23 Jan 2026 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166410; cv=none; b=LUA0duRaXy57z1cwnuzCqF6dAqjYUUo0fFApCboQsQh23VEqLkY2L7TSbFgbP5Fq36A71F5CvL0yJtS52m1r/qsotEb0U70w/itD9sRC+9zbYXMYz29D9sbSXxDplCeQm5Cu+4J1Gou4TZfVWcgZ8effjkPPBZbVdXuWrBxXUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166410; c=relaxed/simple;
	bh=wEBFOPlEb6tVHg7AKJlceKdy9ehHisOvis+YDfqEPJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZMeegjg9VnZ5eo7YWv9Y+1Q9JF7ZD693Bj6TzjBGmlpufP0Jo1yEiW1RBpXjgCANxdY8QNJO5i7c7vUqrkwKxDuK7M6yquVkJFccj+1d9fCXbGGgWr1BreXHByGj3Bwo+AuUMUKb+E8nMdXF/+UvVl8/UHouN1OhoCJ0pE9xYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKI57H0e; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKI57H0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769166409; x=1800702409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wEBFOPlEb6tVHg7AKJlceKdy9ehHisOvis+YDfqEPJQ=;
  b=EKI57H0e0LQ9NdYCvf6NYRkag5AXv3O8BUU2sVsSZUiC+Nkghco7/lgm
   x5rJXEf/jvASFR7usRI//J1/+cG5JgfpI58J1XNLBjJ+9pKmWYs7pMDlW
   OqbqSOtRxRPizYwrPgGswu5sUDL5tY00qVwq7s7fCl4pdjxau81j7lVpJ
   04OAT53xJUqrRzxUln51gJw/d7Tk7Rl3YVbiAVx7WSsg1xhEo1qjIS/FW
   CqKB7cvUQ5tOppMQibZPp+v7cyHgZkbOCfa7k1EBRxwLkk+wa1XD0ppr2
   D5c74NzVPIRWEgTa11pH1U2kLHTLfXoY0ForrK7NqXydAUO9nR3La5sO+
   A==;
X-CSE-ConnectionGUID: I4tCULeBS6Gd186BXMckbQ==
X-CSE-MsgGUID: orC/+NoaRsmznzPKzK3ejw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74050636"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="74050636"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:06:48 -0800
X-CSE-ConnectionGUID: z44kutv0QYuwlvfJqxpDyA==
X-CSE-MsgGUID: 3UtHFZtaRma8MZOlNl7vOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211869212"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:06:46 -0800
Date: Fri, 23 Jan 2026 13:06:43 +0200
From: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	SeungJu Cheon <suunj1331@gmail.com>,
	"lars@metafoo.de" <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	"andy@kernel.org" <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>
Subject: Re: [PATCH v2] iio:frequency:adf4377: Fix duplicated soft reset mask
Message-ID: <aXNWQ-ocutEQoPJz@smile.fi.intel.com>
References: <20251230123609.210454-1-suunj1331@gmail.com>
 <20251230132126.217802-1-suunj1331@gmail.com>
 <CAHp75VdOX_h1Ksm4MbYyipiSpGrTp84GTkUAO9L_0o3auR3Xkg@mail.gmail.com>
 <20260111120857.5087e396@jic23-huawei>
 <20260123094409.111e971b@jic23-huawei>
 <CY4PR03MB3399B1BF1A562DD3FBDF43179B94A@CY4PR03MB3399.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR03MB3399B1BF1A562DD3FBDF43179B94A@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 10:08:54AM +0000, Miclaus, Antoniu wrote:
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Friday, January 23, 2026 11:44 AM
> > On Sun, 11 Jan 2026 12:09:25 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Wed, 31 Dec 2025 13:19:46 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Tue, Dec 30, 2025 at 3:21 PM SeungJu Cheon
> > <suunj1331@gmail.com> wrote:

...

> > > > May I ask how you tested this? Logically from the code it sounds
> > > > correct, but I haven't read the datasheet yet, so I can't tell if this
> > > > is the expected value to read or not.
> > > >
> > > >
> > > > >         return regmap_read_poll_timeout(st->regmap, 0x0, read_val,
> > > > > -                                       !(read_val & (ADF4377_0000_SOFT_RESET_R_MSK
> > |
> > > > > +                                       !(read_val & (ADF4377_0000_SOFT_RESET_MSK |
> > > > >                                         ADF4377_0000_SOFT_RESET_R_MSK)), 200, 200 *
> > 100);
> > > >
> > > > Okay, I opened the datasheet, and the below is what I read there. The
> > > > code first sets the SOFT_RESET_R and SOFT_RESET bits to "1", and waits
> > > > for them to be cleared. But the Table 43 does not mention that
> > > > SOFT_RESET_R is auto cleaned, and actually I don't see with a brief
> > > > look what the "repeat of" term means.
> > > >
> > > > And for normal operation they needs to be 0ed as per:
> > > >   "SOFT_RESET, SOFT_RESET_R, RST_SYS, and ADC_ST_CNV are the only
> > > > remaining RW bit fields not mentioned yet, and must also be set to
> > > > their POR state (see Table 34)."
> > > >
> > > > With that said, I would wait for AD people to clarify the programming
> > > > workflow here.
> > >
> > > Small kernel development process thing as well. Please don't send a v2 in
> > reply to a v1.
> > > It can become very confusing if we end up with a larger number of versions.
> > > Much better to just post a new thread for each version, and include
> > > a link back to the lore archive of the previous version in your cover letter.
> > >
> > > Also from a practical point of view, it ends up pages up in people's inboxes
> > and
> > > so is is less likely to get reviewed!
> > >
> > ADI folk. This is waiting for one of you to take a look at the questions Andy
> > raised.
> 
> Yep, it's a straightforward copy-paste typo - SOFT_RESET_R_MSK is OR'd with
> itself, so we're only checking BIT(7). Since we set both bits before polling,
> we should be waiting for both to clear.

Can you clarify more on this, please? Datasheet is unclear about the second bit
to be self-cleared.

And are you going to fix documentation (Datasheet)?

-- 
With Best Regards,
Andy Shevchenko


