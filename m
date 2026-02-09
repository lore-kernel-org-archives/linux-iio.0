Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73002264DC;
	Mon,  9 Feb 2026 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645356; cv=none; b=nnDmGOc3ZhU+N0Dt8N1Agb9+mwNNkMuaLMiYPcLsrlxFF2FoJtulgamHlm3NB8cU2q3OaqQsd42yXcGgcSTubgXqkXM71jujckv/tdKnVwTxnJX9Up5u7+OqnEfH8wLXZ/1QikkfOxaU9oUEqX500cI6kqb8T1ZrySEprNT5pp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645356; c=relaxed/simple;
	bh=40eXllJeonsbr0vCoc2PoswC9Qyj03cXSY/uXMSSb/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxGsUslGICWQ/PTdpkL+N0OPAxNMhEqAV/qrCP7nIjJSEMnBm8WMJgL3ocdBCqY77F3cOSEz5Rs5SUXvRgmQYgLuIljh6qprFtCIP3LygtlyLeeVw5JVPn7ZZHjniatzVYHa5jz9NceA+FOZyxJpqMiduJLZst5H21xLYjeWJHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ox5jgA+S; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ox5jgA+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770645356; x=1802181356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=40eXllJeonsbr0vCoc2PoswC9Qyj03cXSY/uXMSSb/g=;
  b=Ox5jgA+SVotpNh1XNxutJL3jyETrsk0IiVSxOQ1PefZHKo9pFfJkOeKj
   iHCvFb3ZoyR9fuQcbALqXI94WZVRtzu6JXh4s/NBMwgcylRR3hil5gCVp
   cr2yMrzhrBnDO/Cj9LKvD4Nc2TiVhoxo6w7Zf4+VcSLxU8lfICYfs1YpU
   Nrz8yDyx6XpC8ljWftAYM/LV+ZquJ+YLDByz7AO7vARjOXuRVDprRIjWU
   3o7BJiDl8SO+5wedWk/NW/MW4IVFMvpdKDyu4xVo2ppGMqJHn653p7fD7
   Qc28xwEcDhPVedEWFokS9zTehMZv0CKn1s0PRQhIbt0YZB1IoUBrG6Vti
   w==;
X-CSE-ConnectionGUID: 7QQttOugR4+dPugne8Vs7Q==
X-CSE-MsgGUID: yrKNh3OxSM60TkUfFyXCwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="70770420"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="70770420"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 05:54:49 -0800
X-CSE-ConnectionGUID: WWVW06YnSAyopf++U8bcHg==
X-CSE-MsgGUID: HJNuAbNLRHiMRHZtbucDCw==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.128])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 05:54:46 -0800
Date: Mon, 9 Feb 2026 15:54:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] iio: gyro: mpu3050: fix pm_runtime error handling
Message-ID: <aYnnJfZZAVGlBywd@smile.fi.intel.com>
References: <cover.1770636034.git.antoniu.miclaus@analog.com>
 <CY4PR03MB33997BF46685A6E43BF40EAA9B65A@CY4PR03MB3399.namprd03.prod.outlook.com>
 <aYnh1IjCfeZz7BH-@smile.fi.intel.com>
 <CY4PR03MB3399C98D6EB02F4C087534B59B65A@CY4PR03MB3399.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR03MB3399C98D6EB02F4C087534B59B65A@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 01:39:57PM +0000, Miclaus, Antoniu wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Monday, February 9, 2026 3:32 PM
> > On Mon, Feb 09, 2026 at 12:13:28PM +0000, Miclaus, Antoniu wrote:
> > > > -----Original Message-----
> > > > From: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > Sent: Monday, February 9, 2026 1:33 PM

...

> > > Sent by mistake, only the cover-letter. This patch can be ignored.
> > 
> > You lost me. Did you send the cover-letter by a mistake, or
> > the entire series? "This patch" is absent in the cover letter
> > and for the matter of fact, there are two patches in it.
> 
> I sent by mistake only the cover letter first.
> 
> Then I resent the entire patchseries properly (including cover letter).

Ah, okay, that explains me having two same mails for cover-letter.

-- 
With Best Regards,
Andy Shevchenko


