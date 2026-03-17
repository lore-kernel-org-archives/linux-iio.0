Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604FE347505;
	Tue, 17 Mar 2026 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732483; cv=none; b=msHJWvC1phqZkkuA9skzx4K+kFyuFMSrwtmGjC4bLrkbAS5i70IcC1GZfZ/+SxR/Vqy6O5Rl3wqtcEYAttuBlgOmHaNnpbZnR8VWmUKmy0nKN79TkBcyPz5LRmq7gOUMHHhHX0GIfBFPctpIkvOgUF70lCxLyFEFPQNotlHWDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732483; c=relaxed/simple;
	bh=oDlpjZf0T/mXgeEvv8o6+6IVKVyTL8AMJ+HjBuaqnpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUwoxWzrRUHNYlXkaWAO+Ca1v5zFzdVVOe5SRpQumkb2RTXCo8fTP6uK5qAvnkzvyjSXZoh6K88sa+7maR4fEtiTiptRXz3DoT301NVlUWj9QW8Y8JVXsFP0s2KRrbPnzb1m8ADg0AZGeJtjd/5s+BDerfv1eiiD+W7MeOhPzOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Grw9cu88; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Grw9cu88"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773732481; x=1805268481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oDlpjZf0T/mXgeEvv8o6+6IVKVyTL8AMJ+HjBuaqnpQ=;
  b=Grw9cu886FrAFIv4NumJr5McMzm2oAamVUasK1UCEIRMpw6GOqxehseR
   FQ7uviYmohRSoMdp8wKnVYfflOGuwYa04gpWVlmTjkG3zCb/XgwEqXjtH
   ceKgMiv9tG1rXoEXOCb4EhHzLWZAcPjqpo9bf5ig0LPXtUwJ0i7OyfFp2
   srkW6F700kSVd1Dk6q15VafYlB3BINdPY/dVNB6vBgUmD1CE41RSfb5JD
   4sd1MO8UidiNDUznxD+tt/uJZ2apwZoFPw6tnUAEURRPvK02sLe9aqsS+
   vKCUEYqi93yCmxeCeuK/KG3396l8sGQGtBk0nbxLsQpE6xtRzv8gnW2Ft
   g==;
X-CSE-ConnectionGUID: pAHzzED8TYK5AXdtWpOyHg==
X-CSE-MsgGUID: mL3gg9xgR1W8mjzv8d9aKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74730663"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74730663"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 00:26:29 -0700
X-CSE-ConnectionGUID: DDO/JT9wSzeO/qzWPD+48A==
X-CSE-MsgGUID: YiWF1ruSQuiOjSRGAuS3bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="217913633"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 00:26:26 -0700
Date: Tue, 17 Mar 2026 09:26:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] iio: iio-mux: use flexible array member
Message-ID: <abkCIJ-u7s3OVhfm@ashevche-desk.local>
References: <20260316232942.46641-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316232942.46641-1-rosenp@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 04:29:42PM -0700, Rosen Penev wrote:
> Make it clear that there's trailing data
> 
> Removes a pointer from the struct.
> 
> Use array_size for the sizeof calculations. Slightly cleaner.

array_size()
sizeof()

This commit message is poorly written. Please, consult with
https://chris.beams.io/git-commit on how to write better commit
messages.

...

> struct mux {

>  	struct iio_channel *parent;
>  	struct iio_chan_spec *chan;
>  	struct iio_chan_spec_ext_info *ext_info;
> -	struct mux_child *child;
>  	u32 delay_us;
> +	struct mux_child child[];
>  };

What's the point now to make it VLA? Again, why this and not the other one?

...

>  	mux = iio_priv(indio_dev);
> -	mux->child = (struct mux_child *)(mux + 1);
>  	mux->chan = (struct iio_chan_spec *)(mux->child + children);

(This piece linked to the above comment.)

-- 
With Best Regards,
Andy Shevchenko


