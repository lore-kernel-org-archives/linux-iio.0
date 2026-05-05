Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0121638D;
	Tue,  5 May 2026 04:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957085; cv=none; b=j5k0+BHymYrL9xBsu2UPuE5tj01SlEr4jFemRgyZ+imvNOWOOLcW9F9+S6eSkpTqqbr7dS5iFaY+CN5aW5IQ97r/uS95TSFPbPF/g7YHqJ0VDRNWiC+ImUZBWGkZ9tX+CeKefTxpAt4clTmtq75phZeWvMUJEM7EpZ6908UT4Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957085; c=relaxed/simple;
	bh=ReCHqwJgVEBflobdQ5is1WY8ucZy5iEe3bC8qL1ofj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRMPBCQaV4BesM0WEqgCNkzqrMfcaD2qW7CtwAwFICnlP7sQJFGoshM9i0YWXSLjT2UGudGUbPHCOleG74ss1wQEJippMCtoVf8h9BCx3kzGQyGPsLgM2fqJz4zcyDqwXYjAgjoe5cziCZ6Ay3DCJMAj57BrZ8Fo7AEpJsss2gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcON1dxu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcON1dxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777957084; x=1809493084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ReCHqwJgVEBflobdQ5is1WY8ucZy5iEe3bC8qL1ofj4=;
  b=TcON1dxuVXkj+qvzMwvwti0ieBhHO6JS4rdFoRgxg1aKMbz9Yr//Vyga
   SVQQ3nRzKdkLLw2NHuvg9MoWY0IOz3ZlTP8wxda7rg3zjGPJ8BSYLZ1jN
   GMzaihtTIHY73/HrXJOBHQKsGFoKCkT6mOW9sfmWUgPOregzUzCMYmlcV
   DQDJ3tY7+WFXZ7b5ac26v/gtHPUfGH8cikudn1lMcFwURTS0tmHUQGSPe
   2/s+2rpHCY0ScdIScLXPF3PcZES1c6b0MIj+i0QMMftLYjUsvfqyuZeLH
   dFDP6bGik5GzV7R5HpWk5j4qzIzwmL4juqhzdkGrlFE3wy0D9vGysOGfC
   A==;
X-CSE-ConnectionGUID: kqanBWAZRXK09wOpiJIdxA==
X-CSE-MsgGUID: O45cMQRLStK7INVHAYTm4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89515637"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89515637"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:58:03 -0700
X-CSE-ConnectionGUID: n/I86xN/RGqqMVZAZT3/FA==
X-CSE-MsgGUID: GRiSEtdiTEWQYT3tYvP5MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="229224286"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:58:01 -0700
Date: Tue, 5 May 2026 07:57:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>,
	joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/17] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
Message-ID: <afl404iaPbSsK5XF@ashevche-desk.local>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
 <20260504-magnetometer-fixes-v4-6-a291c2a7c71a@gmail.com>
 <20260504160606.07f87f10@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504160606.07f87f10@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 04:06:06PM +0100, Jonathan Cameron wrote:
> On Mon, 04 May 2026 11:48:18 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

...

> One question inline on whether it is a good idea to be paranoid about
> gpiod_get_value() potentially returning < 0 to indicate an error.
> Right now that is treated as success.

> > +	ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val, val != 0,
> > +				 AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
> > +				 AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC);
> > +	if (ret)
> > +		return ret;
> 
> Should we check val as well?   It might be negative if gpiod_get_value()
> returned an error..  Obviously the original code didn't so this would be an
> improvement rather than maintaining what that was doing.

I agree that this would be a good addition, but since it's a behavioural change
I think the separate patch should be made (perhaps after readx_*() conversion
as it makes it easier to do).

-- 
With Best Regards,
Andy Shevchenko


