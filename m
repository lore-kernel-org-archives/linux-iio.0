Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A43EFD38;
	Fri, 15 May 2026 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830636; cv=none; b=HGJ+r4znaN3VbMvCZRoGt+pdQdkMNY7Ko5mbkLhog45vyIXllf2ZOu2J5pSAGTcFS4vrk6QDAqrlg1jAEJp4Af3ZdoDoF/pwqHeIz2R9eoPU0Tu9JTdOlaxkgsWveTnCDRVufw6uDgvYh6IBHhfRjog1peG78lInrIkjF0FM3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830636; c=relaxed/simple;
	bh=vNeDJZqrvT2j2rRlp/BEtuA+HNSXejvJ2vRYm+fgkOU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rThJMibhdte9Wb1Y6rjm8LXdKkggdaZ2OgQcmBYgCcfAyGhoj23g7EnqZuazszMAd++NzcEVdkE6NEOG13tEdinqZeO+Q2QK24pfEl9+sPg9A33sSIISw1Wdrsse6rDz12L+wBNoolDww1sZaMqs+xMUo+wsFcOdYw24KlcKI78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zz5Yv92p; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zz5Yv92p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778830634; x=1810366634;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=vNeDJZqrvT2j2rRlp/BEtuA+HNSXejvJ2vRYm+fgkOU=;
  b=Zz5Yv92pJ1VImpCOU1n0wC7HJDJjvpH3sje8kh5X5iKeA3PCdD9TYZiz
   nCvsBb/FEtxzL4jdk10KWrqkt2xyvOZsb2B0x31nwvYOQsd6J2avRfBlF
   3YRV+SlhRh2E/bDP1b2YyvxK4ttDpa1a0KM8IzT1SdLeoPBs/UYCKC60I
   q5qKxoIRlLoszJ4fLxZo1RyvIvPg10Moa/nl2tLQS+joQkoo6SxLn49EZ
   wASJxhdCa16R4Dtbb9ZUFbU3pvTQiGbQIrnKnZ+TXcR/lyuS1oOEUS7xM
   8Ci22fMyr4X0CxYvFbXPDJ1JAr333becLvf15N10fC/fvI3REHVjdZx63
   g==;
X-CSE-ConnectionGUID: 6cEAAuGvTXyMH+CP7mnbEA==
X-CSE-MsgGUID: buQnnOidQ8GMLxleNTxcrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="97212640"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="97212640"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 00:37:13 -0700
X-CSE-ConnectionGUID: nFREjJbdTEKf9kDYhKUDQQ==
X-CSE-MsgGUID: ZIy/Yzj7Ta+BOv/Jd0QFew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="268965588"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.33])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 00:37:10 -0700
Date: Fri, 15 May 2026 10:37:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 08/11] m68k: stmark2: add mcf5441x DAC platform devices
Message-ID: <agbNIye6ZfERYeHD@ashevche-desk.local>
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
 <20260513-wip-stmark2-dac-v2-8-fcdae50cf51a@baylibre.com>
 <agTcEECgJvBydhe2@ashevche-desk.local>
 <y4zg2d5zghoz3miqevutiin5swfnx5y2zew2zlv4jklxsyly5g@sxeyvth2tkrk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y4zg2d5zghoz3miqevutiin5swfnx5y2zew2zlv4jklxsyly5g@sxeyvth2tkrk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 14, 2026 at 09:15:09AM +0200, Angelo Dureghello wrote:
> On 13.05.2026 23:16, Andy Shevchenko wrote:
> > On Wed, May 13, 2026 at 11:14:32AM +0200, Angelo Dureghello wrote:

...

> > Same for the rest. But I haven't seen the followups and don't know if those
> > structures are going to be expanded. The commit message doesn't say anything
> > about that. So I assume my suggestion valid.
> 
> no. They are not going to be expanded, anyway, is there a real gain
> using an hardcoded 1 there ?

The 1 is a side-effect the whole point is to avoid array of 1 element.

> Would not reissue a v3 for this honestly.

Seems you will need to have a v3 based on other comments. Indeed, for its own
it's not needed to reissue a new version.

-- 
With Best Regards,
Andy Shevchenko


