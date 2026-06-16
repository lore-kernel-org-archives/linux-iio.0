Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C20A3264E2;
	Tue, 16 Jun 2026 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599540; cv=none; b=Z8dS+JeSV+nt7lXYsV2wLqEEkC5VDH9iYv4Zb6U1ID1L6+J45KO8LiLC5150zCACD1UJBfxLMdg+JSCONjgKwjM+W2L1rgad5wnH7zWuZ2eueFVARYqRaVABOvtzlJ2oKgUnI41D0afB51utxYin6qAT+StT72dGaxAKfHzT77s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599540; c=relaxed/simple;
	bh=cjlMrtaL0KwbV11LDBn0q/6kpp/cbi2kH+6czRdknPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hcn68jmvOgUDcHOs0aFSZ69nRFvSUyLWfaLnCOG+jkYbaVmymOG5riRxB+GMvTLcCmVtqj4fympOTh5AmYV69qLxxWTim7OuPKp6qIE6rKxZK6RSCicXp0L62VPGD7T7Jg1vXoaVkL7ylByOQ4FdOB+S3ABmj6JgsFXdBvUKoz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qj4Fjg+Q; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qj4Fjg+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781599539; x=1813135539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cjlMrtaL0KwbV11LDBn0q/6kpp/cbi2kH+6czRdknPU=;
  b=Qj4Fjg+QeTNGhRHNsAWwNdxWhqqdLfeOdHoOlsni+S40z3Hso5zXp1ra
   nb0YnEoFP861W61KQls+yBKcRNVeURJtGtozsUnV8ufeuNoTl79UILiTL
   TvQLqqZ/BYqkQtc7eRMDlL5K+E+54oI3M8DKQR3yyBFTBqJvdEkDcoklY
   QcwTx6NnOgm+i/xK7w/jtN2nJ8kUpeXg9GeVHfa1UdvH6KKoQn0ZXEGVE
   dy7LmfiFEgTj1ILUpXsHbR5k8suseOsEeZkPs1CHyGnFiNrSQ9ILr9WLy
   d7y5rHWOov044a5IbktKd1pdLXFTJhQyCjxo835vE+8bsX2l2cFH8zDEE
   g==;
X-CSE-ConnectionGUID: p7SvLxFeT5GXgabiQ02MFw==
X-CSE-MsgGUID: ifCZ4Rr9TOKh8ReZmEmlfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="92918948"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="92918948"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:45:39 -0700
X-CSE-ConnectionGUID: hYsxnrGSRjKjcnVKTmOdPw==
X-CSE-MsgGUID: PXXVr1nDRe+Jk8EyEB92sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="243337608"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:45:36 -0700
Date: Tue, 16 Jun 2026 11:45:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, m32285159@gmail.com,
	jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: chemical: sps30, scd30
Message-ID: <ajENLm7tnjdtEhJS@ashevche-desk.local>
References: <20260615200459.8272-1-tduszyns@gmail.com>
 <50847348-5c67-4189-ad26-e41ed4ea1720@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50847348-5c67-4189-ad26-e41ed4ea1720@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 04:58:24PM -0500, David Lechner wrote:
> On 6/15/26 3:04 PM, Tomasz Duszynski wrote:
> > This series replaces old email addresses with a current on to
> > make sure changes show up in my mailbox.
> 
> Would be good to add a .mailmap entry too.

You beat me out to it, I was coming to comment the same.

-- 
With Best Regards,
Andy Shevchenko


