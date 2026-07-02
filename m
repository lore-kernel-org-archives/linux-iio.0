Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FD32F7F1B;
	Thu,  2 Jul 2026 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976955; cv=none; b=jvfVHt1ZO6ubk8eLqZnz2QSZrVOlrozWxZZzLQk+xlxh6bby7IwD1/suPUNDCTNlvhkBeiaDZCxQUCMgSGa2KTNOy9/soQuj8HyYUq3gR3mP2E8hZG0yZqnwNHGmKWIJFGt2QYn09qsaj4VNio3BtEL4v0DnLR5hgYvJfoltZo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976955; c=relaxed/simple;
	bh=PF7Bpa/fqybm8F3ODWMMKwzG64BwhhuOuk8N5SY4YQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhtFw9AIc7/dLCohqrHgdXKc7LX0bOq4cRJ/eKkZvYiNHEB3ZpyzJcawZI1KOTiDVYmUvHrn6j7k3ddZm8fbRcMsZUZAFXifBEPHR+SdO9tNuMPiYNGdCmo/NtDpoIKr5KpvZjnXPyoC75NlY0vhMlRljjaTdnwqSN7SNSO/OVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLTXwyrg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLTXwyrg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782976953; x=1814512953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PF7Bpa/fqybm8F3ODWMMKwzG64BwhhuOuk8N5SY4YQs=;
  b=DLTXwyrge0IOmDqFOdHfojbLYO60RrNYujeL9NgqMyj44CHtNQDl4YNH
   NeV0auUhquoJNG7WPbrltjV8J6wP0uepwpZeaG7y1cZc8uzELTchCkBSc
   hcswswdid2Kf5ZM+kkHiFYeMaNX7BPPDx0ngFFFrPAUHk2yP0Rir8+rB+
   aJXHd6bDVBfllfjRHBxKgxjz1hprOT+1OIEjXndyJn4ack3irYhO/lvOL
   t5El4a0ehp4fvJwQX6ay5WEpxNOoG7qruC5W7OQKbREW/WPgtNf4GWcXV
   IyeKUsYS7ExqhT+yzW/1JrfOE56viTDA+C6ggEJTh2iC/Cpwh6oTwcm4y
   A==;
X-CSE-ConnectionGUID: M3IrJ474SCmxcn8De6BZGQ==
X-CSE-MsgGUID: H0h0mP+AQFiP8jJd7MxTgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="94321030"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="94321030"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 00:22:26 -0700
X-CSE-ConnectionGUID: fKr4bFQEQLCdWq3cd54zVw==
X-CSE-MsgGUID: RlosgVEbS9qZO8R3wnkDdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="252343063"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 00:22:24 -0700
Date: Thu, 2 Jul 2026 10:22:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Anas Khan <anxkhn28@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Remi Buisson <remi.buisson@tdk.com>,
	David Lechner <dlechner@baylibre.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: fix typos in comments
Message-ID: <akYRrY72qzPX4aH0@ashevche-desk.local>
References: <20260701151811.22130-1-anxkhn28@gmail.com>
 <20260701162659.43310-1-anxkhn28@gmail.com>
 <20260701184935.3f1029e3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701184935.3f1029e3@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 01, 2026 at 06:49:35PM +0100, Jonathan Cameron wrote:
> On Wed,  1 Jul 2026 21:56:59 +0530
> Anas Khan <anxkhn28@gmail.com> wrote:
> 
> > Fix several comment misspellings across drivers/iio/imu/, found with
> > codespell and manual review. The corrected words are coefficient,
> > temperature, sensitivity, access, chosen, and buses.
> > 
> > Signed-off-by: Anas Khan <anxkhn28@gmail.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Andy can confirm, but generally adding more typo fixes that Andy
> has not reviewed would be a reason to drop his RB tag.

Right, please don't add tags when the excessive changes been made.

> Changes look fine, but I'll wait on a reply from Andy to apply
> this.

...

Yeah, everything looks fine.

-- 
With Best Regards,
Andy Shevchenko


