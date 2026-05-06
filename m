Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283633E3D8B;
	Wed,  6 May 2026 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056793; cv=none; b=Gri39DYW/fCJu4dnKELYgxgZglCqVoQ5WVoz1v9zYkL4iWNKh3Jai5rHholygQ3SC6LfBA3LF+cWy47NYjDAwYsrIjVSWrQc2dhqzPM6ENYZiyJZC+0JbzP0p3qcgs2euvMEZ4M7i4nsv4ObLK8Vw2HQ+sYWB0nbdcfXJ3P5oJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056793; c=relaxed/simple;
	bh=Fz5iq7aGWo2VvwVsnwbB4SYoUS5Je9iCbW9rqu6w9T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZOHGpdBR1Tt8czcCu5MF/7CAGcYTrhsYlnfseghR5/c26MzE5GFk+zLnikDqgAsD6E2Dp6dXE/X+hKbiwZ+RY3MLGk6xIzkCq7C8QPEl4w0eECRh2urYOGE/FuksiF4fQ+4RI3l6E/gr5TNhsU0vya03mdj5Lbx0AfsSaMvU4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxPrAhUE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxPrAhUE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778056791; x=1809592791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fz5iq7aGWo2VvwVsnwbB4SYoUS5Je9iCbW9rqu6w9T8=;
  b=HxPrAhUEMyTaOoAP5NFz1kSNH4nR/kGl4KuBLHTD25MN9fDjcKWakQjH
   28FJUCWQDlQyvr4JYCDAxKBxoNPsj9uB4zc3dJFbz/rVClizTTGLlsCea
   NGWyhEgS/Vaj6XpANlM20ItPK7YhOgAtnDkzYR2XaI/XmUlkPDJiUuA13
   1/Pj2sQC7VqfdRkyoBjIoMGZZ2d5TA+jnQLhmCu9E7ZvyVvplOctsPY0q
   V/H8/XbQMTjCahcpjCgwURN5Cm76MRmOGeskjD8JYMtUX9p7uJrMm2eVy
   A9HI1TaZivDvshd7oEXttb6VPqhSPLoUBw2l+wuQGBkACUfEfW/fUCM93
   Q==;
X-CSE-ConnectionGUID: rqr0MHLpT2CBPirl1uzp8Q==
X-CSE-MsgGUID: 6rQF/JHUTnS7J/SUP0kWrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="79028176"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="79028176"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:39:50 -0700
X-CSE-ConnectionGUID: 7YVRzWasQzus9rd7ozlz9w==
X-CSE-MsgGUID: muWblokiSz+ImtWX7xFRug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="231702139"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:39:49 -0700
Date: Wed, 6 May 2026 11:39:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: humidity: ens210: Fix missing I2C functionality
 checks
Message-ID: <afr-UujhzuwZWzhT@ashevche-desk.local>
References: <20260505174943.94093-1-salah.triki@gmail.com>
 <afr-KvM756ZAn2hh@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afr-KvM756ZAn2hh@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 11:39:11AM +0300, Andy Shevchenko wrote:
> On Tue, May 05, 2026 at 06:49:43PM +0100, Salah Triki wrote:

...

> > +				!i2c_check_functionality(client->adapter,
> > +					I2C_FUNC_SMBUS_EMUL)) {
> 
> This one is now wrong.

I meant this *indentation* is now wrong.

-- 
With Best Regards,
Andy Shevchenko


