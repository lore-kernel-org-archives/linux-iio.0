Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE3E38E5C4;
	Fri, 25 Sep 2026 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360319; cv=none; b=OS5tclBiXgLLqRK09ZGdREbvVRUJT9vJqZqSKpD8veNfSBy5nFZbuZZaqu+ViQrh10bqEI0pTNxQWoX/xzW5OALCGHeUAExMRKo4QvG8GoxBMptEZ4SGeqAtzqs1FcgPD3pFQoaMHMaahzqk8heHYFi5oh4HopwTGEmGSmHfMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360319; c=relaxed/simple;
	bh=H9etVj5WdgpPyOp9Nu8T59dDLS1oUz129NmwsgXLdCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJLDxyRGmTwluH0RDFzmVE/CCofoINGnL82lHwG3OPoNDIdMWZbz1/9pOfLSUmLrNIxmYXTt1F8/uNDHdrTxh/hboH9mHRnJIEbVeF3Muz46cZcIQIPOR4uucQkZm7uVCi4TTP6uNU1GFqAUXZ8KbzjjMbTKrrg0w+v9lLYpD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLe0FxJt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLe0FxJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790360318; x=1821896318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H9etVj5WdgpPyOp9Nu8T59dDLS1oUz129NmwsgXLdCQ=;
  b=KLe0FxJtk04N6MPr7+VXoTxEB5hKSMvaQbx9PV/ERFXRrfq5ru2RCI03
   YM+daIQzYtdJldl3aPpOZfUSrNOMbgCPox3sRIg9x67nifbNkVS+rkmpa
   N74JAwBBi8MmK8Hnxn4Upx0sWLT4aHPB4zWuHgl6Dp8vqhf+XzjfCrnj7
   geDCnLFMDyVXbbX+Pve9JimffF/mt8psS6SvXj7CTgskA6rdSs9ynCdi5
   n8j1PHeBltiiQqIUiqXCvmLKRCHj3G9ofqJb1PTHWRJwum0D5uQ1CXQu7
   Cgr+bQy2BYs7OVNXjhha/gFb3FrxChDXpF0ppdsWvOit5oiVznLbS0cbq
   Q==;
X-CSE-ConnectionGUID: JCinjHKtS2+2aZQWZeQebw==
X-CSE-MsgGUID: TqLgX2yJT+WI0pNVJ8ML8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="91254769"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="91254769"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 11:18:37 -0700
X-CSE-ConnectionGUID: kKDxy0U8RQ27igTeePLXAA==
X-CSE-MsgGUID: QZOtGkINTXupOF2drhHWKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="303905116"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 11:18:34 -0700
Date: Fri, 25 Sep 2026 21:18:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: jic23@kernel.org, Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v7 09/10] iio: pressure: dps310: implement
 .hwfifo_flush_to_buffer()
Message-ID: <ara694wYo2qwBo5j@ashevche-desk.local>
References: <20260918122517.377565-1-zoone.rupert@gmail.com>
 <20260918122517.377565-10-zoone.rupert@gmail.com>
 <178992913316.706584.1446996024286841775.b4-review@b4>
 <20260921183106.231972-1-zoone.rupert@gmail.com>
 <20260922005347.069c490e@jic23-hlaptop>
 <20260925175816.75842-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925175816.75842-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 08:58:16PM +0300, Rupesh Majhi wrote:
> On Tue, 22 Sep 2026 00:53:47 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Adding the guard is fine - we kicked that back a while ago simply
> > due to lack of users. Is there a path to annotating the non
> > ACQUIRE.. functions to expose the right information to clang?
> 
> Yes, with the change below. dps310 then builds clean using
> iio_device_try_claim_buffer_mode() and iio_device_release_buffer_mode(),
> and clang warns on a missing or unbalanced release.
> 
> context_lock_struct() is needed because clang rejects the existing
> __acquires(indio_dev) on a type that is not a lock. The header
> suppression list hides that today.

But why you can't supply the full lock to the __acquires()? If
to_iio_dev_opaque() is a macro it should all work.

-- 
With Best Regards,
Andy Shevchenko


