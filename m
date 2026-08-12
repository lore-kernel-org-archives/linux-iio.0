Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A919141A510;
	Wed, 12 Aug 2026 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528209; cv=none; b=jahMVkjWe2z80KiNiFS/60dv1qlzbd91rbTu+iACmi8FxFlLi/+6A0tCfNm3M4gp0KjUPVGoI0RpJBe9V2sbKtlvMPxyejC+EDVo9TDqvlbbLvIlcYdqa0aigz6Dvw4yC/9rUqadfEDr2eoGbmUZKZIYBciXxdat78B2l8JdwU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528209; c=relaxed/simple;
	bh=Msskqh8ObQy2KQ1PBQ9GocClOuog/IpqErosuX3AsOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3JiSs7oU0dwcu16x5voiyj3wWQTgXV+u07K5Dm5cyWO0WK1QaOJB747PDMJw3UhukiNZETIBWWYqbZ9UMxOVkOaMbXP9VF8enqsaK5+2To/pABATdCDIQGV9XtWbLDvcA+zi2aXet3waRJ+sI7TStPmc25N+hbQ81AclgckQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQGxFFOB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQGxFFOB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786528208; x=1818064208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Msskqh8ObQy2KQ1PBQ9GocClOuog/IpqErosuX3AsOY=;
  b=UQGxFFOBtvLe3b71tmyE0zTuwCqhPX6xZm634WYgEEIwfMJqnjXQ6MlH
   HNQb2gcL5uLtTRFkvQdZeQF1N1vjsnkpSLDD2wtztTm6ie3fk9bFgpjuV
   COCdYi5ZmKhhpclISpU4H4xmNbQ0oZRjeKVkM0wkyEN1F4mUQIQtM3tJB
   mSRrw5gYB9E1UwBwTEypaKfaP65R9+MXasHg6T1R5CFIoTmUJFjp5gWDH
   fdy3DdTFxJl6cpdcG0zhKRbTKqSoAnrENaWVte2osX/36SHqmyqGRIBM4
   CezEwtHSMl+WKr4BkL8oUMYuigFYuLlg3IixnbChuuuKRyMU3UkSr6l5H
   w==;
X-CSE-ConnectionGUID: BHaGw8o6RVmW59mGjDeh7Q==
X-CSE-MsgGUID: w/kXVdBVSJ2qBT3LV4pJWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="89601884"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="89601884"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:50:08 -0700
X-CSE-ConnectionGUID: LP92OZbASPCGucgwedcPig==
X-CSE-MsgGUID: GLmDxWo5QtaFCImrIfj41Q==
X-ExtLoop1: 1
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.92])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:50:06 -0700
Date: Wed, 12 Aug 2026 12:50:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	linux-iio@vger.kernel.org, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <anxBy9NHJQVvXsIQ@ashevche-desk.local>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
 <20260810-dmaengine-support-wider-dma-masks-v2-1-1f7b798d035f@analog.com>
 <anoHMANpRU744hPp@ashevche-desk.local>
 <anrgDskNdV7PG-T-@nsa>
 <antirKIhG8iaMqNv@vaman>
 <anwwrvNLP2OujnWd@nsa>
 <anw7veoAfnBrmKc7@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anw7veoAfnBrmKc7@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 10:38:57AM +0100, Nuno Sá wrote:
> On Wed, Aug 12, 2026 at 10:08:34AM +0100, Nuno Sá wrote:
> > On Tue, Aug 11, 2026 at 11:28:04PM +0530, Vinod Koul wrote:

...

> > Just remembered that bitmap.h is already included in dmaengine.h anyways. bitops.h
> > is because of __set/clear_bit().
> 
> So, simpler thing would be to move __dma_cap_zero() in dmaengine.c. But
> all other related things are inline APIs and we would be moving this one
> just because of something that live in dmaengine.h for a long time now.
> We could think about some dma-caps.h but that's honestly just out of
> scope for the current series and nothing I can really commit in doing.
> 
> Likely do the same for the bus_width API though I think the split
> header might also work. The one place where the new API will be almost
> always used is in the producer side (so drivers/dma).
> 
> But again, honestly, I'm just tempted in saying, let's leave it as-is.
> bitmap.h is already part of dmaengine.h anyways.

See my previous reply (I made it before reading this message).

-- 
With Best Regards,
Andy Shevchenko


