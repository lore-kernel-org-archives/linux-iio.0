Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4884CCDFD;
	Sat,  5 Sep 2026 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788594017; cv=none; b=Rat+tYFHI28+wk/dcROSCShMsw6ziJUH3vGgwWgH412toG6Qy+NoEmNmaq+cdPf75RaNjCPWRVQ4ACJpHoF2Rz4c/t561ZeU8clgx6NPbOl0/UOCQck4NkjSZlp2t72C/tBjDxj3KglVOuI7emabHhJrHUfTzxEGQ/JsGd5OoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788594017; c=relaxed/simple;
	bh=x/A+MZz14friRoHCsWJHWWAB6I+96EUaty/rUP12mY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2Q8bupAH6a3j6ZuBbbSc7HV7/i/f8n/YF1uBtXt6dYpGlZKMyjfVJ2HIkP85/wk0bbjU+Otpuib10KQfwnX5Oht3jOkv3tp5O9jaDkAX9NuWC5uFf5q2VF8SoRYzuXlMfNknB2Y+fc81+j+N9v1sKInw9d3Fmrw2sE8RM094qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXfYmZ/J; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXfYmZ/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788594015; x=1820130015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x/A+MZz14friRoHCsWJHWWAB6I+96EUaty/rUP12mY8=;
  b=hXfYmZ/J1x0i5Ar53YDWczKUbaSaZEOcVeah//B3r3vhLRlS1XwLHIxH
   JYbB2qvZDLIn4JojzZbk7fw9nI+R5RKa+oPbUmV6+4bEOTZNbk9nozQFI
   5ytWUlopIiOC6ILE3ZsdxUFBbMDsa0ZwMOB8l0HYCVUmkPqP9wcl0tIVR
   wQc6KOnlCtkKT9DZtuEoGX5JhBYCxnxckfo1P1L4kZ78dpiRDZm6Ng3kZ
   y0TZyd7V6Ma2zcBJ6iziGZObG8xW8ITAw2YGNTYab+rHw4USci5KQW2GT
   mmms/QA0X433NE2lAlWQ/hnwieBrazVZvNt/kJLRVOahKC7iSpjcuuPXG
   Q==;
X-CSE-ConnectionGUID: 09vvhxzxRYmUa9l0OJGPuQ==
X-CSE-MsgGUID: EuFytHi0RQSiQHaIzcL9Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="99681687"
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="99681687"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 00:40:14 -0700
X-CSE-ConnectionGUID: 6ufdODcLRyifkg7hUgdXCA==
X-CSE-MsgGUID: 2q7LkCwxSaKrRhpf0EOS3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="295119163"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 00:40:10 -0700
Date: Sat, 5 Sep 2026 10:40:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
Subject: Re: [PATCH v1 01/13] iio: Fix typo in vendor name
Message-ID: <apvHWCXRp-s7rcut@ashevche-desk.local>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <e508718734a06f005704051b8bc3d3d7a1a3b48d.1788368334.git.marcelo.schmitt@analog.com>
 <apkSNlQuQkjdNKvx@ashevche-desk.local>
 <apse4gHE2pblXnN2@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apse4gHE2pblXnN2@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 04, 2026 at 04:41:22PM -0300, Marcelo Schmitt wrote:
> On 09/03, Andy Shevchenko wrote:
> > On Wed, Sep 02, 2026 at 02:21:34PM -0300, Marcelo Schmitt wrote:

...

> > > Now
> > > find drivers/iio/ -type f | xargs grep -i "Analog Device "
> > > finds no leftover occurrence of such typo.
> > > 
> > > Also,
> > > grep -nrIi drivers/iio/ -e "Analog Device" | wc -l
> > > and
> > > grep -nrIi drivers/iio/ -e "Analog Devices" | wc -l
> > > both count the same number of lines.
> > 
> > Why not `git grep ...`?
> > 
> Could be. I'm just more used to non-git grep.

The rationale here is that `grep` goes over filesystem (and files) while
`git grep` goes over index which requires much less resources to waste and
hence 10x faster or so). That said, I highly recommend using `git grep`
when it's applicable.

...

> Thanks for suggestions to other patches too. Will apply them for v2.

You're welcome!

-- 
With Best Regards,
Andy Shevchenko


