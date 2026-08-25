Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A73C3F4F;
	Tue, 25 Aug 2026 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649341; cv=none; b=DCDo7m/ts38mE5szDkUWfWHFtarUawVADagvNQTGk1JFxQtfDuT4SNbrBqJak2JPkAYCf58NsCP9SatkMJa+25AzXuU8ilZ5yRKlajMxRLDUCHSZIDT4XBH8sC2BkDOnsEHwAOsvGtmlyMH4F6Hf3ZFtlGutDVSpch45NTjQm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649341; c=relaxed/simple;
	bh=dSq6DscDPtommE3+vdvnVdTgj7SgpisyhbX/9sVAI3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueeFoyzziZVBEsAF98nskPRJcXvtZtpIiUDJhqkdSBXsBKAYGi1QLCx9lcKWCz7YYwn1vSC+W8/RuZKG/ED6TaC8ycbNtTamRUAqbSD3h8g5TsjeHCzAxyrWrCAqk/5645mEmOzm0jz8MGvL6h42uoFiMn2NR2qOKBAAEKAvXLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmeXYTKU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmeXYTKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787649339; x=1819185339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dSq6DscDPtommE3+vdvnVdTgj7SgpisyhbX/9sVAI3w=;
  b=YmeXYTKUu9CZBAT/hhYHr8LZk8akmwKDJfLX7piBdeUHgkJXGsQ5U2CU
   H7ZBYMKyL/TAoymM7prwHFRLiMMEEMjqPeolHNnlVy9SdQFOGy+Qtk6pS
   1vqTo3LFMAlEOHqDvecD9giVEv255IpKqMhtA8aKPXxTgS/j8NLyPR3Tz
   gHlG3fMiHDKcRfGrMS8lyr78gaIXKabf6fUkaojYnprUYSTAea4SWejUk
   /mkaUj5AsamNPqJN/lCMfF4nUnkxBiwR4m8Z+/fI/BGjC0U4OcsYG1eMd
   hp5z+eTQrDdmtbUEdM6+saBj1b/PucJydkGovH8mFnu7uGjtsV6ggLOo3
   w==;
X-CSE-ConnectionGUID: OdDpXXMnRtWg9pAebhUNuA==
X-CSE-MsgGUID: ErjlY3+0TA+KyOHTF/gNFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99458627"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="99458627"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 02:15:39 -0700
X-CSE-ConnectionGUID: HXglNIiKQ+yyyBR1us6MJg==
X-CSE-MsgGUID: sjSuxlviSjShVoh1zNKIkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="270700987"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 02:15:36 -0700
Date: Tue, 25 Aug 2026 12:15:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: tzungbi@kernel.org, andy@kernel.org, bleung@chromium.org,
	chrome-platform@lists.linux.dev, dlechner@baylibre.com,
	groeck@chromium.org, jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v2] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <ao1dNcjFaiIfKp2i@ashevche-desk.local>
References: <aoz1VN62zEuKPePl@google.com>
 <20260825023216.43373-1-triet.hoang@datalogic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825023216.43373-1-triet.hoang@datalogic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 25, 2026 at 09:32:16AM +0700, Triet Hoang wrote:
> On Tue, 25 Aug 2026 01:52:20 +0000, Tzung-Bi Shih wrote:
> 
> > This needs to update accordingly: SIMPLE_DEV_PM_OPS() + EXPORT_SYMBOL_GPL()
> > -> EXPORT_GPL_SIMPLE_DEV_PM_OPS().
> > 
> > > This lets us drop the __maybe_unused annotations from the resume callbacks,
> > > and reduces kernel size when CONFIG_PM or CONFIG_PM_SLEEP is disabled.
> > 
> > With a nit in the commit message,
> > Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> 
> Thanks for your review. Should I send the v3 to update this?
> Or maintainer will 'amend' the commit message when apply patch.

Taking into account that I gave also comments (and we have plenty of time),
please v3.

-- 
With Best Regards,
Andy Shevchenko


