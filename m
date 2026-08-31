Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514553B71A1;
	Mon, 31 Aug 2026 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160080; cv=none; b=EojIWiUjK/0iZ4l/lKikl/nSH4gfAqdPoeRbJenzl+CzgdIdcGoLAu7066fSJhnl9nDsVn9nuDos0s9nV91bn3EQhgt0/OSleRogsvZc8LAPl+ey6lGDFZbk7ln123Nz7OfFwoFl4JHrJeZJG26mYHgg0J+8AZyq6i0iQzR7OsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160080; c=relaxed/simple;
	bh=LQ+4OhaYzUwnVEtdYOy2ARxZkEO72ficOARdW/upaNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMC+roK3Kvc2CAbZ9DfitZ4fq6gO22WKRcS+/67pO6V326GL8vPnRPQtjRGKKgXhsQrlyBsaahMRVjbd689jl74CQ+gDIUmjkOewPFYodkKtPh/KAyU6wcXo9M4l8cv9twfD49aHKte12ytNwWDyiT6hDXAPIdPvhKwQjBVd5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9yX6yi0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9yX6yi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788160078; x=1819696078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LQ+4OhaYzUwnVEtdYOy2ARxZkEO72ficOARdW/upaNw=;
  b=Q9yX6yi0wj3MS4Spqt1tSqB05ccv+jc8bXdyUkm+8OjUxp4J4wJSTJan
   bvP6uX038G0bwCO0srZd0vQPRdLGyuiqJWGLDJfs7tv9iS159QMWlWScL
   uG4dV0WTJnokWlp3CltFRQsJt4R19ocutsXxoMQt+Uv2lnvFQaj92fhLV
   lz9CF5TcBPYHwX2yG6zwvSdMbT1V69Bb0QyatxjYinICJb3Hn3oCr/sKG
   18WUzlzq1gMp+91J85Wm1/pk9EO6muHttgA07qHoSWawizimZeMFabZee
   ZF7fGrKgjBF1dpghoXxJ9s3yVNUOgcoc1UnQd60Yuet7h5QC1vfb7LYdN
   w==;
X-CSE-ConnectionGUID: YgJMu+oOT6yHcHwz0/21HQ==
X-CSE-MsgGUID: YAIFptOJRKel1fcmWa9TVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="114095635"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="114095635"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:07:56 -0700
X-CSE-ConnectionGUID: RzGgLUw9S4WC57mjag1C5Q==
X-CSE-MsgGUID: uvPRPilMRKOYRHBD2StDqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="266141700"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:07:53 -0700
Date: Mon, 31 Aug 2026 10:07:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, andy@kernel.org, dlechner@baylibre.com,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] staging: iio: adc: ad7816: Use modern IIO attribute
 macros
Message-ID: <apUoR0ngw-sfkakJ@ashevche-desk.local>
References: <20260827214721.19395-1-mdmahmudulhasan1511@gmail.com>
 <20260831000954.634dc435@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831000954.634dc435@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 12:09:54AM +0100, Jonathan Cameron wrote:
> On Fri, 28 Aug 2026 03:47:21 +0600
> "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com> wrote:
> 
> > Replace the legacy IIO_DEVICE_ATTR() macros with the modern
> > IIO_DEVICE_ATTR_RW() and IIO_DEVICE_ATTR_RO() macros.
> > 
> > This includes renaming driver-specific callback functions to
> > standard <name>_show() and <name>_store() formats.
> > 
> > Signed-off-by: Md. Mahmudul Hasan Mabud <mdmahmudulhasan1511@gmail.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> How did we end up even looking at these?  This is converting attributes
> that would most likely go away in any attempt to bring this driver out of staging.
> I'd much rather see the major surgery needed than tidying up around the edges.
> 
> I'm not particularly keen on any effort being expended in this direction
> without substantially more justification. 

Even though, I would consider this as a good cleanup from two perspectives:
- reducing the current code base, id est makes easier to get current state
of affairs
- educating people to use better alternatives (in case that's unavoidable)
in their code

> So as this stands I'm going to ignore this one.

This is fine!

-- 
With Best Regards,
Andy Shevchenko


