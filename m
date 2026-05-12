Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F73ACF07;
	Tue, 12 May 2026 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584557; cv=none; b=U5IVNx2y9utzhoXJqejIQwM36fU17prwu9G5Qz6uBtv4j4xu9BPvIReBG3xV7DR6alB0w4IEFbA2A3KUiaAXYnWJ/a1VDNAMeyc3qSSfjPvcxC5e4lo3sPW/KbAy5fsA8wSxh/r5jwC98UpXKZb0KndNHXKsWU+o5GxsZVxxOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584557; c=relaxed/simple;
	bh=KGrx3K0tnW4S3jQwnFAI5wCrEHsOX8eFAIn+dIf7ino=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPE0+NX7PHsRg3cg1rlFStxlN1VrLf0dB01ZaY210/9RfyFpyENMk0OmiucPVoVnX04PJFlQzYLNlNKipCZOr94CF3URLn8dr/OpskGC5YghM8bmnD3nUIxF+zQJEiM4WrqOpQZMrPKMxoVy5pc93zgyEGXV0IjWZ0BwsCVQmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GEzk2z++; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GEzk2z++"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778584557; x=1810120557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KGrx3K0tnW4S3jQwnFAI5wCrEHsOX8eFAIn+dIf7ino=;
  b=GEzk2z++T0OU2gK9llUPFe69OsG3796EodKYQnG6Abp2w770TXHPdfhp
   aTXu09XCWO2ezFTYD8IFyAssXmBmvPD9mFmGbVZyQp+uk8yikiFaf8t7t
   Wz/5LYiTd2tkBpeiU4oZmVan8pZvwVjODhpa/YldgrfbTMeKqGV5sigej
   Lw9FyTep6uEYaEgG2hhOBUOFdNRaIk46ub0rBr5GdXVW2TgiyoM8m4588
   d3XeT+1rxsELIjAyR+CG1NJpu9XiZD9Ass0hXylU3zDhx4RqwmFKhOfYx
   MFOQFX8wx+/8a6n8mF1P7EnxWUWoyLPx2SxFca3aDIEx3DZROT8SLRo31
   A==;
X-CSE-ConnectionGUID: HPT7OBKvTX+lyfSj17GfAg==
X-CSE-MsgGUID: S5Rl7NgQRi6iNQSQ0TFITA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78636288"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78636288"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:15:56 -0700
X-CSE-ConnectionGUID: +tsUD/kfQ/+/5TTmNm0krQ==
X-CSE-MsgGUID: dNqxJl7URqeyG0b6cw2pVA==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:15:53 -0700
Date: Tue, 12 May 2026 14:15:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abinash Singh <abinashsinghlalotra@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Abinash Singh <abinashlalotra@gmail.com>
Subject: Re: [PATCH] staging: Documentation: dds: replace frequencyY with
 frequency
Message-ID: <agML51XAy3kSGhpa@ashevche-desk.local>
References: <20260511171255.9668-1-abinashsinghlalotra@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511171255.9668-1-abinashsinghlalotra@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 10:42:55PM +0530, Abinash Singh wrote:

> The documented frequencyY attribute naming is implementation

I'm lost here. What frequencyY? I don't see that in the patch.
I think this needs to be more specific. Can you rephrase?

> specific and differs from common IIO sysfs attribute
> conventions.
> 
> Replace the non-standard frequencyY attribute documentation with
> out_altvoltageX_frequency and document tuning word selection
> through out_altvoltageX_frequencysymbol

Missing space?

> This makes the documented ABI naming consistent with standard
> IIO sysfs attribute conventions and clarifies how tuning word
> registers are selected and programmed.
> 
> 

(A single blank line is enough.)

> Signed-off-by: Abinash Singh <abinashlalotra@gmail.com>
> ---
> 
> The out_altvoltageX_frequencysymbol and
> out_altvoltageX_frequency_scale attributes can be added
> through extended channel attributes (.ext_info in channel_spec struct of IIO)
> 
> Feedback on this approach would be appreciated, and if
> there is some other way in your mind. I would like to 
> work on that.
> 
> I am also interested in working on the sysfs-bus-iio-dds
> documentation and the ad9834 driver. I recently bought an
> AD9833 IC for experimentation and testing.

I didn't get is the current documentation wrong or is it that currently
used ABI is wrong?

-- 
With Best Regards,
Andy Shevchenko


