Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E830C37E;
	Tue,  2 Jun 2026 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438703; cv=none; b=raI+TmaAvmsKtyjucLm64dBUh1t0wGvp0c/9r71O3S/BftTyx3b0it2dELm27W1nbS5PZsa887VHdSjMljZEoEwoKhNMplqeTnvqRAHYKm9AmFvwmYsQtvh5T/neeiKZJYHRKNzzo9rzampHBvxLoE+hBsp+o684GQYdbQ2gvY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438703; c=relaxed/simple;
	bh=gIpcuuz1TvSWfM4qo7VGbvDQcZHOe3mcgzP1HjPAdCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow4F3OY2lGsYE6rpWsoOQJbap6vOvldn4dmiFvFD4bpAHmozyHuZZxhcnpi7U2M6jCxeQV45qx/c4PF5P75b2l6ev64LEaUGsyv7txofvKBCIv7KExM0wURRf3eDNeTARhm2/RzMBhl10obUDDxqz8tOkUJpIPN2NRW8zNAMJCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCoWmDyw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCoWmDyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780438702; x=1811974702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gIpcuuz1TvSWfM4qo7VGbvDQcZHOe3mcgzP1HjPAdCg=;
  b=CCoWmDyw7SQCIZoqxfbxIx5dS3En+1p2GF4aUOWRgBHDirOXQGv1zQOm
   9/Eo726RM+cL/3qZ7O8/7kveshWzbJDE3k12nlAJBmV4SlnLrsmvr6cdJ
   KEqVj8SouGyNsMkMN1xc+xixkNUOoselku/rr7qAd346Xbv0WtxMxe1Dv
   Pc64x4nb6q6i3btzLwsVGR2iPvh5ME8IZnZIJIRbX0HHA3bfWowO/KGBp
   DdcQinXs8ImUv85TRqybvhDnaJ6nP1qMJAMv0EGsaz8I+84Nj2hZXOmUj
   2xF+ur+Rx21Azk2EvEakLQ/xxlxGWuOmJS42mMPonA/BBrzEIHLk/ZqVU
   Q==;
X-CSE-ConnectionGUID: A1XhtX6jTeeCPK2nbH7R2A==
X-CSE-MsgGUID: dBBeLdbySF6rRScVGUpb3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="84862868"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="84862868"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:18:21 -0700
X-CSE-ConnectionGUID: uOzPg9KvQaq+nKWVVHhyvw==
X-CSE-MsgGUID: IJ3xC0usSnmliVFJciDmVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="249117643"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:18:19 -0700
Date: Wed, 3 Jun 2026 01:18:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Maxwell Doose <m32285159@gmail.com>,
	Stepan Ionichev <sozdayvek@gmail.com>, andrea.merello@iit.it,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	hcazarim@yahoo.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bno055: terminate dev_err() strings with a
 newline
Message-ID: <ah9WqIztidPlaZoA@ashevche-desk.local>
References: <20260520190851.11390-1-sozdayvek@gmail.com>
 <CAKqfh0EPXX1zh3ScPCyBWhSq70wL3MpnUW9TV0Btn5LSF2EGuA@mail.gmail.com>
 <20260522155948.47c100c5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522155948.47c100c5@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 22, 2026 at 03:59:48PM +0100, Jonathan Cameron wrote:
> On Wed, 20 May 2026 15:13:41 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:

...

> Applied. 

Hmm... It's probably too late to tweak the commit message, okay, not a big deal
here.

-- 
With Best Regards,
Andy Shevchenko


