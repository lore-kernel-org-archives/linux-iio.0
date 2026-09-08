Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539884A4986;
	Tue,  8 Sep 2026 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863570; cv=none; b=jHbUlJdslKC7c3kKiJSEfFvVCRYxptwdoME3wq5ArCBuMdrX0eGclrDudYvysKheh7njakefvtxcRu9vGckm8OlvYPSZrnO6d+LUjbPST63a4wjLBniS2yiYqxabJGKl2WYLoGvp2xBH3KxudL0XRswK3YaxiXEW7gWctWLzLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863570; c=relaxed/simple;
	bh=BYa4Q1INIJL04DCmHAqSdo/9ottjX6vvhxQyhuMLnmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGEs7JPu+JLDn0IFSwVZEN9JjnEPxDJOill65kzG01tbbzHhnRcGYW9fDAZORlXhVpa64hsUV6ctHyrU4SfuZKiUz4DlAYP+zBX958HcJurDr3a/mwTvmiEBeU5ZnV1a08s2wT5aXJSgHDLvQtShzHpv3IOtQa51CTj0lnZD3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWDSGpN7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWDSGpN7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788863569; x=1820399569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BYa4Q1INIJL04DCmHAqSdo/9ottjX6vvhxQyhuMLnmc=;
  b=jWDSGpN7EUzkR7cNe+/KLBszTLCKVhvLZLbVm+a41/JXpUqFkImDjBMT
   25JscAGSQHFpKuytgAv85Y46iiIx7KITt3/XeXqReXD/aVyjO6Q2yykLv
   vhjFAbmZ+FIUFSK9zECVfPxv17YGfgYRFjPBtz8KdT2PCjCIDMI7+dQxF
   8eF5QYdlQbvKb883WprSVk1w9T+12VhvcwDwZkBV2/YjBm+Aif9uqhxc1
   9qjF5T4EGEkfp90I7ddVFHh/RdSPizWPsus3xeEY2lRZQ1S+PepvFA3+r
   UB6Q1+wSbbWaYo08HF1DylqiTnjkSXSbihnJBzgfrNwsrJPSKY2ch6ONZ
   g==;
X-CSE-ConnectionGUID: uxquh3R5Q96Y0p6ZEsfoaw==
X-CSE-MsgGUID: mwXeqD+TQNCSUalx59MGGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="91772069"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="91772069"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:32:48 -0700
X-CSE-ConnectionGUID: 4KLeg5MIQou+0vP4RYY3Zg==
X-CSE-MsgGUID: dtr2K5aMRzSPyCQw+oeobg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="264755941"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:32:47 -0700
Date: Tue, 8 Sep 2026 13:32:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tsys02d: Fix state desynchronization
 on resolution write error
Message-ID: <ap_kTDGgJq1S8rVr@ashevche-desk.local>
References: <20260907085353.54477-1-salah.triki@gmail.com>
 <20260907165009.0000035c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907165009.0000035c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 07, 2026 at 04:50:09PM +0200, Joshua Crofts wrote:
> On Mon,  7 Sep 2026 09:53:53 +0100
> Salah Triki <salah.triki@gmail.com> wrote:

...

> >  		ret = ms_sensors_write_resolution(dev_data, i);
> > +		if (!ret)
> > +			dev_data->res_index = i;
> 
> + blank line
> 
> >  		mutex_unlock(&dev_data->lock);
> >  
> >  		return ret;
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Actually we prefer usual pattern — "check for error first".
This 'if (!ret)' is confusing.

-- 
With Best Regards,
Andy Shevchenko


