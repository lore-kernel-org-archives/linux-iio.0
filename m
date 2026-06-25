Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE519225416;
	Thu, 25 Jun 2026 06:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370661; cv=none; b=Ax43wivmHzJSSetd5w8wr/tPqdc8E5If1kY8K19SGyKHCaPO1d42SxdrtkwbsthRp+q3Y5bfEQJQebzFBCkQKgjpnn87IbbpWSqzWPLa33W1ue/0nX4inYAUWv5WsCyQ1YUW+lJKI1vrPokh4rJNRklJ4532w+gUbI/N4F4F1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370661; c=relaxed/simple;
	bh=mv788TDFJPDm/uU3dseDpoHfO3/duRJ7W+WxBCKGm1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snnwNSqQG2MdIJ1NKtgu9ibv9jp+hh6dgee7UxmxTsetctQ7YoFb512/t1em3pVpJ+wyhv0slHsH/qRTOc0wZ+M0q98LbDAWol6zXKFSezDSoARPk8d7SCTxyt+dvUyI9ktyKkSf3mtLVYazHSW4Bru8v+xfUCS/cH5BsZjR5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFHQCZF0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFHQCZF0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782370661; x=1813906661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mv788TDFJPDm/uU3dseDpoHfO3/duRJ7W+WxBCKGm1U=;
  b=UFHQCZF0jKbRxgGe6PLzJlNazzGc7E9AYhIgNuUIhjqYyf28wrvR/mrp
   BVOYrZ9sfWqPDgsRDbHAMUIcO5E53rSctGrUl2QrSs96+Mm4Ryd7XuigN
   n9PpdVggNfiwDjsY2DDkgnIFWFGFjLCVFeqSTM10897sYyfYB0p0d6OVX
   AiQ+5P/NRvNJmlm/UZvZ0hy0cOk1mSzGwnR8cWQQznpuYq3yM0FCJuIN8
   PYxh5SHDaq6+3TxLnWhm10ghIaTtih8TJjb2MCn1QeFIc0/XRq3oxf+5J
   QyQqqc28/6J4YibCpDNambOiRLujZ8JVtc2gUdGNMLD9Hj8+vD8+ZvLZa
   A==;
X-CSE-ConnectionGUID: TBa6DkWFRNWsO+BKGAN8Rg==
X-CSE-MsgGUID: P7+Lh9YwSyikCJ43tCuOoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="93499191"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="93499191"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:57:40 -0700
X-CSE-ConnectionGUID: kiSPF5UJTDCeuBFsl6Evgg==
X-CSE-MsgGUID: M/gAnjPxQqWA7ljU3ZCfFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="249406572"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:57:38 -0700
Date: Thu, 25 Jun 2026 09:57:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: imu: inv_icm42600: reorder includes for
 buffer module
Message-ID: <ajzRX7Zr7BzUJFNb@ashevche-desk.local>
References: <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v3-0-5d9a4c662f50@tdk.com>
 <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v3-1-5d9a4c662f50@tdk.com>
 <ajzPhi3ymeIBYHRr@ashevche-desk.local>
 <ajzQ_FUr--jTxYWr@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajzQ_FUr--jTxYWr@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 09:56:01AM +0300, Andy Shevchenko wrote:
> On Thu, Jun 25, 2026 at 09:49:47AM +0300, Andy Shevchenko wrote:
> > On Wed, Jun 24, 2026 at 06:21:18PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:
> > 
> > > Reorder includes following rules and delete unneeded kernel.h.
> > 
> > Actually it's needed as 'proxy' header. If you want to get rid of it, it should
> > be another patch to replace that with the used headers following IWYU
> > principle.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Also for the consistency's sake this should be done in all files in that
> folder. I see the same issue(s) in the _gyro and _accel and I assume the rest
> *.c and *.h also might be updated.

For the simplicity, just sort the each group of headers in all files. The IWYU
can be applied later on as it's not in the scope of your series.

-- 
With Best Regards,
Andy Shevchenko


