Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1F29346F;
	Wed, 15 Jul 2026 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122343; cv=none; b=djJtkQgDmUKcLQwbTZ8WhaDlFazNAO7ewemJs/wbWfCYIYtaMSzZ4Fhtc4q1ZDYoLvJ7Xd1MA/mjtldF0qc7IYZbCtDxghX4/HdG2ZyVp0byHs/Q6Oy0P29hCSaGED86FQE32SkWtV1pOKIsLUf9hL/cbtIjSEVrSq2vMNT6OWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122343; c=relaxed/simple;
	bh=WGlM4JqQL8TUdhN8LBBDI0ECBKsAhEkQMZo1bJpXoAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay54sefjQSeFBTWJLOM3f/kwBFAWgYGeum9Rc+pEfUpqzotutvcrWG1DfpZji+F3M7mvAgC2uttHY5K8t4NpQZQsovdAJoZVgsPFE+ESGzeydaHVzxyv640yxgKOEj+3l0qfDbG+d4g8ce2D1Sw7vy69+p0nTKEmLAZR7maK8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpe/sW5V; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpe/sW5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784122340; x=1815658340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WGlM4JqQL8TUdhN8LBBDI0ECBKsAhEkQMZo1bJpXoAY=;
  b=fpe/sW5VBVAbMz2KcPpZvlLaJnxiZp8CSdQowOdcsnHjLdrmO1HuLTed
   ZIU0FrZQ3Cfn65kZIprtNcfnFmzXH9dkVqaGpoMeCYBGVgw0TPXIiA6U+
   L/DYL1maoteXzMa/1a2OWrdbXum5ZP2P3Xdyy9n5XW30KtbofAuzYKR1k
   Oaaz/FeQMfM2a8y/yNpLYrEX/Ydu50XYCEOFVaj4SIpXatObeC3eZn/xm
   q6FV8rHcxfKoNB2pAm8Vn7absrMwk9KLodvgPUPQ5QwbPAthivQMyGn8y
   +ci7W1FXioHvoOXOyhr4YZazRB4uHyI7DfBMn8+iZVzDqm539Zpq6cJJM
   g==;
X-CSE-ConnectionGUID: WwK3Hvh3QtKCwlVKwVFI2A==
X-CSE-MsgGUID: WLQeipmeR5y47PwHKF+MdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84641350"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84641350"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 06:32:14 -0700
X-CSE-ConnectionGUID: 846/XhuaRa6YxXJ+d2cpJA==
X-CSE-MsgGUID: AZu/ghMvSvuUzl/Lkl0gpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="252227320"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 06:32:12 -0700
Date: Wed, 15 Jul 2026 16:32:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: adc: make read-only const array config static
Message-ID: <aleL2gmDZDJRhjVo@ashevche-desk.local>
References: <20260714165012.184651-1-colin.i.king@gmail.com>
 <alZs-uLJug_rnRnq@ashevche-desk.local>
 <aldfaM2aks7qOz2C@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aldfaM2aks7qOz2C@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 01:22:32PM +0300, Dan Carpenter wrote:
> On Tue, Jul 14, 2026 at 08:08:10PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 14, 2026 at 05:50:12PM +0100, Colin Ian King wrote:

...

> > In all patches like this it's always a bikeshedding possible of moving static
> > data outside of a function. I have no strong opinion in these cases (when the
> > data solely used by a single function), but in general it might give different
> > readability experience (it's harder to notice static data in the local function
> > definition block). So I leave this exercise to the maintainers of the respective
> > pieces of the code.
> > 
> 
> It's an interesting point...
> 
> At one point Smatch didn't track static variables and it used to
> generate occasional false positives.  And it's like you say, those
> little "static" qualifiers are hard to spot in a wall of declaration
> text.  I've never considered moving the declarations out of the
> function scope but it might be a good idea?

Maybe, as I said, I have no strong opinion here. I am all ears to hear
what others think.

> But in this case since this data is const, the static vs not-static
> doesn't affect flow analysis or readability.

It doesn't affect flow analysis, but we also have David's point about
amount of data to be static may affect the code generation.

...

The main point I have is that stumbling over the 'static' in the definition
block might rise some additional questions and slow down the understanding of
the code (by reading).

-- 
With Best Regards,
Andy Shevchenko


