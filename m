Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A62F1FCA;
	Mon, 16 Feb 2026 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771227312; cv=none; b=WocD65aWKHpmMY2GwRbltyYu+RiYiWq5Dh77hFM2T0vh3lf+EJ4PTiiDTxUyPqLDKk8F9a3gnYozwozrJ4BCCS349dpwyi8SvO5BO9/Hhz2TpH6VaQ2zS3hVYPqm32dj3n5JdAgBxIFMt1k36Dxm0RodAxFxNi7w2C/+nMFp5xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771227312; c=relaxed/simple;
	bh=ieCocgSzOlNHPZjWVTp189qHBlXFBhXeTlQRdNOAbEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqxiZsxAHahzwnXFjFJmiy9+9bKkUeLrtHYqMYeUjJTookTzdsP7PbvtAleQ2kSg570xomJ1SdZKrjH9SSj0OY4xfaj97UFIBsMeuTCAaKUxDMkly/Ej6wxYBEsd8EDIIIuD/IiMGAGleDVBJnjxGEojaJM3buuJuMIc/Fb+EpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMxKjGE9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMxKjGE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771227312; x=1802763312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ieCocgSzOlNHPZjWVTp189qHBlXFBhXeTlQRdNOAbEs=;
  b=iMxKjGE9213F6zyuPXxMFSSTglhXnMoF2uoulB1MfQdfI8p/03Uv8gqo
   aIlN3Rr0/sK42ydIWqwLQ+JRmjKDOyOFZNyp/rPPbtS4ImtifYU2PRrR1
   2yVtBUThmUCfNBezzJ7iqEFj1Ajfys/Nb23tR8oicbRRrx1N8wujAIDxe
   YiZw1oKSyWXB0+67z7SMxA/bl5fE66xwRiwfmLYpoX7Alw/BvEnIBG7vX
   rPYonROj0BcYDF7BN8jbZbvw83gxqQQ/0sjByv99F6YHTKCNYRnftGppy
   5BwMhcNCJ5BnUOVCPJhweYFnHU6qwBM7aW/G5m1LHD+zdgGmDpHmy48t1
   g==;
X-CSE-ConnectionGUID: 7eBKPtNdRgu5UzN/hgeapg==
X-CSE-MsgGUID: rldzbBJISfWZNtRg9jsU6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="72476969"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="72476969"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:35:11 -0800
X-CSE-ConnectionGUID: hKu1DboWSXS/7xbsmEujww==
X-CSE-MsgGUID: 0H0lUgxvRG+uJo6n2jlu7Q==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:35:07 -0800
Date: Mon, 16 Feb 2026 09:35:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3] iio: adc: ad7768-1: Fix ERR_PTR dereference in
 ad7768_fill_scale_tbl
Message-ID: <aZLIqW1JN34xvQun@smile.fi.intel.com>
References: <20260214184637.16985-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214184637.16985-1-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 14, 2026 at 12:46:37PM -0600, Ethan Tidmore wrote:
> The function iio_get_current_scan_type() can return an error pointer,
> the return value scan_type is not checked for this and immediately
> dereferenced which can cause a kernel panic.
> 
> Add check for IS_ERR() and propagate the error back.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


