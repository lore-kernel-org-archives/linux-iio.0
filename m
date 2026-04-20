Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2A303A0A;
	Mon, 20 Apr 2026 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674503; cv=none; b=tbJ14Rbs6w/Cn5D/ZK6GPJW0aJpIjaB6Qyi4bwYWJ84FD/YDVM1s4lnaykjGr8tR2y+qGFA415aqCNhWVX24X6VjBwq6CjcpLVWSOmYhqL49MzA4K8Gm8rmTkjx0Ozk+sJq15ZEfGIGHPKwL27tM2pR06KaODygLhJNxTVuswZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674503; c=relaxed/simple;
	bh=hqFLWvMnHtD7k5CCC1+CJvhLbI1x/FBeWUF2UPXFIq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzcpRCrMk3Hiy/SmiKRcYl6wM411VL5lCDyk6mtp48UKDxhVxWrnITWKdJeQUC0V8N0Ln70vdIS8pQa6aoxuVgWZW5fq+OsWk3hI1vGqLWCpFKM29VVXCVbtPVz+TlJOQAnI4KYmGAU4y5/Hzy/IL7L2qmtnw6zZsvGSPMjcKBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7l+dm49; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7l+dm49"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776674501; x=1808210501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hqFLWvMnHtD7k5CCC1+CJvhLbI1x/FBeWUF2UPXFIq4=;
  b=V7l+dm49YKkrcs1m7v4yb7fy1IMoTPRua13GrHbUyF9Vm2uIMAxBDfp8
   37jhw7rsqdeC3PGqcGHaZo/6Y//+guFRs144/UNNU18aZ68Y7AXzoG3Ls
   jju6NzPDM5CDvaxbM66nuSTYPZVN03UmWXLjxAobW/XXdZltclvM9LpbE
   4kQXBPJWp0SaHFXkPK1JN2oBUkB8ooTHQ7i35w7QdqD8fZLe73/g57cQ3
   9pLs1ln/fixCHXhKlvF0XRzbMBirVQUnr3dTPU6lfWN2MO6tBLBrfcqwE
   lsGHUKYebZxYKsSkNVcenHp9kvUp3z/C+vHNuDZ048wNCMIzNVoFHCqXB
   Q==;
X-CSE-ConnectionGUID: E9zqP4diQB6pdHz5Rr14ig==
X-CSE-MsgGUID: KaIThdOAT0SpLTKJDwKpmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95146091"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="95146091"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 01:41:40 -0700
X-CSE-ConnectionGUID: 6GLblZMtQBK7Gn0XuQpwMQ==
X-CSE-MsgGUID: SP+ZPJ94Sse0CHR/p0kEUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="231574172"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 01:41:36 -0700
Date: Mon, 20 Apr 2026 11:41:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] misc: Remove old APDS990x driver
Message-ID: <aeXmvaFIbTlxqNO0@ashevche-desk.local>
References: <20260419083125.35572-1-clamor95@gmail.com>
 <20260419083125.35572-4-clamor95@gmail.com>
 <20260419143346.45ed78c2@jic23-huawei>
 <CAPVz0n1qrSYr16zSSqRHuTWVkRfdC+c9w+mxAhtzgfHzL41XFw@mail.gmail.com>
 <20260419172216.3cf10e51@jic23-huawei>
 <aeXh7j410AxESy4U@ashevche-desk.local>
 <68c671b4-6754-49df-9fdb-2b3382033fb3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68c671b4-6754-49df-9fdb-2b3382033fb3@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 10:33:22AM +0200, Arnd Bergmann wrote:
> On Mon, Apr 20, 2026, at 10:21, Andy Shevchenko wrote:
> > On Sun, Apr 19, 2026 at 05:22:16PM +0100, Jonathan Cameron wrote:
> >> On Sun, 19 Apr 2026 16:41:24 +0300 Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> >> > нд, 19 квіт. 2026 р. о 16:33 Jonathan Cameron <jic23@kernel.org> пише:
> 
> >> Their userspace will be broken by dropping it.  The lack of upstream users
> >> makes this less critical but it can be argued it's still a possible regression.
> >
> > Usual recommendation is to google, and check Debian code search engine.
> > I randomly chose a couple of sysfs nodes and only kernel code refers to them.
> > So, at least there is a good sign that it likely not in use. But one has
> > to perform more checks (all attributes, more sources of information) and
> > summarise that in the commit message.
> 
> I think in this case it's sufficient to point out that there is no
> devicetree support in the driver, and no pre-DT board file ever
> declared a platform_device with apds990x_platform_data in mainline
> kernels. The ambient light sensor drivers in drivers/misc/ were
> all added in before the change from boardfile to DT, and from custom
> ABI to drivers/iio.

Works for me. I am all for removing old and legacy (especially non-FW node
compatible) code.

-- 
With Best Regards,
Andy Shevchenko


