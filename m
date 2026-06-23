Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E83A3A960F;
	Tue, 23 Jun 2026 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782197564; cv=none; b=EdP97NdJlZnnaG0Eatq5S4mOSo3LzPiT0oZdCnYLiqIgo7VsLL1ojRynUHc6qb7ytMdXvu4hf03+6wB4uPH8+npBFPb0QBeXQdAwEX3IP1K0fct6QR1F4M4ljiSq6Zytuq6m8m+3YjPislMPXcwyJKSPdZ2AWNYAJuVV6zwOP9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782197564; c=relaxed/simple;
	bh=M5C03jwMOVPk3qADcuqWCbvD9inoDB6D4PE8mc9m/iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXWTvNfLyJeYDD+y4XLODTG9bdbi4id5KkNWLhhcCDkHRQ40S3NXQAXZqDPTUYd68q9nNbYKGEBfrkN6MwRUtzMZTlF8dfM7RmjDwa38HXSpgihQfeTw9kfmN2tqisQQv5EI9t42iiluxyYEHcez+AETxjG2OTet7+CYP4rf/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4x6XwGt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4x6XwGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782197563; x=1813733563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M5C03jwMOVPk3qADcuqWCbvD9inoDB6D4PE8mc9m/iM=;
  b=a4x6XwGtb1HFSMq8HyCXAvsAXL3FktvrmyzLMsV11GVbRJsPBWpZAho0
   8XGpiOC9kdxemxf6zz1YLRifM6wXQpHXNm72lrWXpHbLOyd/6pwgn7Qaq
   eqwhBt/j4VYY8xmkotJWcK2X1hcwPBwQ6v/Jq5tbwaIBpflsPVH59JqIn
   Vh/mwxf/pbwvzEcsMBDpY0TT55hWyVjW+wTS2Gngurde8XnrD11CI4jDG
   diTJ9TZtl9pjGg57tbDfGQCqkhGM/aTaFrp3Wrmzr/4zGEsbsBWJY6k/N
   HezcTvm8qU8vuzt2kOnecF8yd2O/getWdKPlE6SxJHbLWnDkmE4f/OCfh
   g==;
X-CSE-ConnectionGUID: jJJmeD8XRhGhUk1w87QgMQ==
X-CSE-MsgGUID: /YkrHp1fTmqn0cqGEOtKuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="94322747"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="94322747"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:52:42 -0700
X-CSE-ConnectionGUID: ljiDnSQ9TuKBoxJEyKJ3Iw==
X-CSE-MsgGUID: 0pnfVr1AR7mw7a/zjgqOXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="254417836"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:52:39 -0700
Date: Tue, 23 Jun 2026 09:52:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH V13 8/9] iio: imu: inv_icm42607: Add Gyroscope to icm42607
Message-ID: <ajotNPhg8fR3tLZp@ashevche-desk.local>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
 <20260615172554.160910-9-macroalpha82@gmail.com>
 <ajEhr0JIQwzRgoZa@ashevche-desk.local>
 <PH0PR19MB997338E86152468CE26F60953FA5E42@PH0PR19MB997338.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR19MB997338E86152468CE26F60953FA5E42@PH0PR19MB997338.namprd19.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 17, 2026 at 04:10:49PM -0500, Chris Morgan wrote:
> On Tue, Jun 16, 2026 at 01:13:03PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 15, 2026 at 12:25:51PM -0500, Chris Morgan wrote:

...

> > Can be some of the code deduplicated between gyro and accel?
> 
> Probably a fair amount, but the deduplication will likely need to be
> undone somewhat if we get buffer, WoM or apex support added back
> (I don't have any devices with such functionality, so if anyone will
> do it then it won't be me). I can refactor more if you want, or we
> can keep it split like this to make it easy if someone else wants to
> tackle the buffers/IRQs stuff later? Your call.

Just asking. Jonathan, David, Nuno, what's your opinion on this?
Personal opinion is to avoid solving the issues that do not exist.
If you are not committing into those features, let's not prepare
driver for them right now.

-- 
With Best Regards,
Andy Shevchenko


