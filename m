Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205D3793BA;
	Tue,  1 Sep 2026 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245633; cv=none; b=kNkKPBHJ47QmEigUTIYQePzKwDVpMEAy8Einf4IBO4F5ieJYq287Cq/EF13PQKYBsRT24Wt2TYlzGllXRPw8glOQ8G/tvmzYtWONwYo+NJYhRD6Z5sXWxZsMO9VId+GGUOGmpucddj/7KafeXyQD0TURclkZaAspPWjD4DJ5qtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245633; c=relaxed/simple;
	bh=qWOIbmszkzuR1a0og8IWMKHS3TR9Yu5Tcd7+sIOvJBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7L7Q6C3vzNZNqQ0ZTmhEUqxG8nBXPNNxQ1LV1/6+tetWhJ1Aos7Xm6xXEe1UfNzgKr+xTRcNMaJ1MjsgUptFOtj4vD8hAjAxPzOSuEq+d1jBH+vZkWB5s0fuRGqYIpc+wGXkNyy05+9fZ1suLyTE4094HqHVw+jx1QU/3Z8wh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lewrj4LE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lewrj4LE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788245632; x=1819781632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qWOIbmszkzuR1a0og8IWMKHS3TR9Yu5Tcd7+sIOvJBE=;
  b=lewrj4LEawbZnYahBbDTstj4x9xpqcpytPJAi1JEVHZbsZe6+DM9QKHg
   8dW4vMkxg4yQ+ucsOfhtXquy3R7otXlH5gi1v1wqQbEfMT5c12kDtknjz
   8VneGUyCE7RzYyVES0KV2sar7KXPlJvCcPnv2LZGBMc6KbxMmpcZqhboJ
   NnT2Jgt488CLYspbz1NFhfUGxUXZqj35OfS4FAeeNET9akRQLo2J8geHM
   scRDPPI/SVBJuEj6VyCvlwHQjpU+nBt7t1B0X4DQrvCMEmDMmi1GXxFTR
   zVR5aaEVrjhOiWFh0H68Osoed+KgjA9ix4vg+kqt6G/HdB8cbeTbFFhai
   A==;
X-CSE-ConnectionGUID: jghXupBVTUWaVwu2Zv57nQ==
X-CSE-MsgGUID: qxcB13gJR/W/x18DqacvvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="106037393"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="106037393"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:53:51 -0700
X-CSE-ConnectionGUID: Rpo8VkT3Q56lZcqKLWA5WA==
X-CSE-MsgGUID: y8L70CF4TEyW9adF6dKJAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="267687698"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:53:47 -0700
Date: Tue, 1 Sep 2026 09:53:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Yang Zi <2959243019@qq.com>, lorenzo@kernel.org,
	linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hts221: fix division by zero in
 calibration data parsing
Message-ID: <apZ2eL1-wctBl0eC@ashevche-desk.local>
References: <tencent_0F43B1BC41CE4066DA52B7B25FBC04C41A09@qq.com>
 <ao7zrbXG6f-pPxIB@ashevche-desk.local>
 <20260831010021.67cbf4c1@jic23-huawei>
 <apUnohaFf1HaqWN9@ashevche-desk.local>
 <20260901023544.0f65a55d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901023544.0f65a55d@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 01, 2026 at 02:35:44AM +0100, Jonathan Cameron wrote:
> On Mon, 31 Aug 2026 10:05:06 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Aug 31, 2026 at 01:00:21AM +0100, Jonathan Cameron wrote:
> > > On Wed, 26 Aug 2026 17:09:49 +0300
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > > On Tue, Aug 25, 2026 at 05:21:10PM +0800, Yang Zi wrote:  

...

> > > > Do you have HW to test? Any fault injection perhaps?
> > > > The problem with div-by-0 is that it's implementation defined, meaning
> > > > that it's how compiler decides. Now, the question is, what will compiler
> > > > do in the current code (no patch applied)?
> > > >   
> > > Whilst all this is true, the code shouldn't be relying on any particular
> > > behavior.  So do we need to know?  
> > 
> > That's my point. If code relies on that, it should be spelled clearly in
> > the commit message. Then we will deliberately break that (nasty and wrong)
> > behaviour.
> 
> Ah. Got you. So a statement that the condition (probably) never occurs in practice
> should do the job here by side stepping that question.

Yep!

> > > Reality is the hardware is almost certainly never returning values where this
> > > is true.  

-- 
With Best Regards,
Andy Shevchenko


