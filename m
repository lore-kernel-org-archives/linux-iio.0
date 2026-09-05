Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79399344DAD;
	Sat,  5 Sep 2026 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788594090; cv=none; b=tqCphtKXAXCM/Tc2H0csMrDB60d8iiSSywR1gO4ruZSfc9zF9gTh6ZxY8XkIJhruo8cevFaDClD7CEMzKP4nDXh61RHuq5puBZYgLCEon1cKS4sdHEhYwdy3zsr6zXuWsTG9FsCP0BaHzpPs3gmVZucNvezf+5liTTRiHMShL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788594090; c=relaxed/simple;
	bh=fhMZ8Ksx5t6CnoJvQgXvkp1NCb4RYmtUZbECXQ0gwCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA4d7FkOR7P01VevK5HHzIx2T3dUALz136MdakUvHC0Qzkkt3Rie1Kd02nRquht7J6d1IPyMeWfrroIhD0Wv+ddmD/XaUOWDM9XvYFYLXEplrkfGUXp6YvD3x7ocVJvOzC1pZdjOIimfA7kKZDBWQ13VmobPHJR9dB3TaZrQFK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXXriwFF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXXriwFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788594089; x=1820130089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fhMZ8Ksx5t6CnoJvQgXvkp1NCb4RYmtUZbECXQ0gwCo=;
  b=ZXXriwFFarCXNa8tdV8pba0O/mfI5p6hXYspaBu/XDVORohtJPsNgGjI
   PmvFwkgz9H+G3V1Exye+K/SWpCYozu3Ol28kMqn23wCX3qFAE8rF/FEMi
   F4PCgMp7gMjwl7AlThljJJx53mTTxl8JJkTa9bLHjW9ahKBe/hNDp/1bY
   aK1ynSczMDOD6PKzpvujLX7rK/KowL7vKc2WMewCiyXbx71PnUUkgfWiX
   H2tjfJhHXFs4hMUBJpZqpKwNv9dmpteXoM3x7bNQiGkc8vQHHyi/eaIhE
   03otMUoEomuTDQ6DjL4NT2bFf2A0aysnvhWOMeUozc/AwYFS2rcZZL9w/
   Q==;
X-CSE-ConnectionGUID: rZtooL1/TAWFQoeXmndnkw==
X-CSE-MsgGUID: emGGBZ1bRkW5O6rI+L7A2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="111862286"
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="111862286"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 00:41:28 -0700
X-CSE-ConnectionGUID: kW8K0IEZRDOw8nT6ZZREgQ==
X-CSE-MsgGUID: S4YYYeLxSfSe8nUWM+E1lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="273782066"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.105])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 00:41:25 -0700
Date: Sat, 5 Sep 2026 10:41:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
Subject: Re: [PATCH v1 01/13] iio: Fix typo in vendor name
Message-ID: <apvHoaG3wzm06XOp@ashevche-desk.local>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <e508718734a06f005704051b8bc3d3d7a1a3b48d.1788368334.git.marcelo.schmitt@analog.com>
 <apkSNlQuQkjdNKvx@ashevche-desk.local>
 <apse4gHE2pblXnN2@debian-BULLSEYE-live-builder-AMD64>
 <apvHWCXRp-s7rcut@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apvHWCXRp-s7rcut@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Sep 05, 2026 at 10:40:13AM +0300, Andy Shevchenko wrote:
> On Fri, Sep 04, 2026 at 04:41:22PM -0300, Marcelo Schmitt wrote:
> > On 09/03, Andy Shevchenko wrote:
> > > On Wed, Sep 02, 2026 at 02:21:34PM -0300, Marcelo Schmitt wrote:

...

> > > > Now
> > > > find drivers/iio/ -type f | xargs grep -i "Analog Device "
> > > > finds no leftover occurrence of such typo.
> > > > 
> > > > Also,
> > > > grep -nrIi drivers/iio/ -e "Analog Device" | wc -l
> > > > and
> > > > grep -nrIi drivers/iio/ -e "Analog Devices" | wc -l
> > > > both count the same number of lines.
> > > 
> > > Why not `git grep ...`?
> > > 
> > Could be. I'm just more used to non-git grep.
> 
> The rationale here is that `grep` goes over filesystem (and files) while
> `git grep` goes over index which requires much less resources to waste and
> hence 10x faster or so). That said, I highly recommend using `git grep`
> when it's applicable.

One more important thing, it skips ignored or temporary files, while `grep`
goes over all of them.

...

> > Thanks for suggestions to other patches too. Will apply them for v2.
> 
> You're welcome!

-- 
With Best Regards,
Andy Shevchenko


