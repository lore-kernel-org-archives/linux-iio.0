Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746BD314D15;
	Sat,  4 Jul 2026 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783167149; cv=none; b=AGd9wp11+qKxhiXkWwljHBREtnxYh9wLYG07MF7vT4oIcBD8QsaZuj4qMsieyBA0PUlo+rPQT1yIUUpVAu9nH7G6V8hLLC2dWETAZI8Lz/bLaL8CxGEQ/japUr9fu03mgjeYTbviUeRdL102MloeqdrmzO7JzOdStkNcs76g4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783167149; c=relaxed/simple;
	bh=NkukZnOlmGh8u1Mdj1nDoy4Bft3Tm6q66arVWCJyH7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC+V7kbts9sD2lvAq179YggEu4VIi1zda12LNt8x1M7n4bCSxG7vdA/lFe8IZMciDpyftR2ZZSwA/tgby7j2S6CY1fi6NqM+hVbdlXicP9bYjDLXQEQdKCVlKWyY9RY7GpSfU4/SCSvvJ3g8vqo6YFVcPOW80Z2VRHTRdBJu97k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GofRuPO3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GofRuPO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783167147; x=1814703147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NkukZnOlmGh8u1Mdj1nDoy4Bft3Tm6q66arVWCJyH7k=;
  b=GofRuPO3+mDN5g8GEbnaM08YFdxJN17uXdU3FY5BVnzivigviEgd0Dha
   SldnUThm0vXClw0I39EVU3003QD2ljmRQYd+NW5HqSPG7jRP4/rc8xLUH
   iPGCPYUoE7LsuDLtLtANdMXjgLAaW+A8DszyIdfN1FgAQktsVY6Q/rZ03
   /lb8XeJpFmMvyo58jKJs0uGn/y5R+8CednittfTGAxB+BQhTsQu3rrikw
   5LUAJlYUfXW0IN0TEQYKh+2pliVAovIhVa05mIy9GI5uqzT7cfSoxotEK
   ao2SsYNVxWfhX7x2UE6SjlvGVN3UAbvGlyI4fRKVtEZq80cerWXu8P06r
   g==;
X-CSE-ConnectionGUID: lKJT2iSpS7+1emA8vgwNzQ==
X-CSE-MsgGUID: YMc8jfMjSuipN43M097t3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="106675351"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="106675351"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 05:12:27 -0700
X-CSE-ConnectionGUID: Tyi7M7CxT4eX4pbOKYj4lA==
X-CSE-MsgGUID: BtL0J7iNS8G7l+LL25k9AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="248847428"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 05:12:25 -0700
Date: Sat, 4 Jul 2026 15:12:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap002: Disable regulators on resume
 failure
Message-ID: <akj4pxF1qtdzWkMK@ashevche-desk.local>
References: <20260704083412.43145-1-acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704083412.43145-1-acharyalaxman8848@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 04, 2026 at 02:19:12PM +0545, Laxman Acharya Padhya wrote:
> If enabling VIO fails after VDD has been enabled, runtime resume
> returns without disabling VDD. Likewise, if device reinitialization
> fails, both supplies remain enabled. The runtime PM core keeps the
> device suspended when its resume callback fails, so the supplies must
> be restored to the suspended state.
> 
> Disable the supplies enabled by the callback before returning an error.

Sounds legit. However, I can't be fully sure. Let's wait for others to look at
this and comment.

-- 
With Best Regards,
Andy Shevchenko


