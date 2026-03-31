Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF30194C98;
	Tue, 31 Mar 2026 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948204; cv=none; b=rajRs1dM0e3MynL9mqTcJAWN7j1obSH4F+ewgXKDieJ6yLp7pkgMHx4SdQ+uo4dEw+9EITBufMFOBtkgvaLw5wj20cLsQAZL6VOCvEyAIKcuo5rAwndDX65rH5tqhZv85k2Jrqz56487QJxfW+IHzJnWHggD75KLfFjCytCA56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948204; c=relaxed/simple;
	bh=LFoQaYjgOUr1o2liNFhFQe9ivjy20eIVgNSiUkMzVQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uypuExZ1KkIvaBd9npgVjo0EplNCKgm+S/yBPRgMfDaONOlPIfSSra8StGlvtTFD7wvL5utTDwJA5/LWAhXbqV/qlLFdjdjnMgnMU/VdS9/zXyxDcgy8ncmkPQh3ms8fVzfQzd6Mdbod+chiX3+rC9hkCR35BqtvVcj8CGBnvuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0qQBYCV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0qQBYCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774948203; x=1806484203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LFoQaYjgOUr1o2liNFhFQe9ivjy20eIVgNSiUkMzVQA=;
  b=U0qQBYCV2IqNe8+BWaZBJrH2tqGfWrjT8WYXuKxpYn82i1usn/LO0huw
   P29mWo5J+KgLsL+uNFZ8D+M+xLpcOKUcApSd4QFkxrvBV3yxE5ZSDO4fA
   6P1qpzOmDQnkuey3bZ6qvl7+q258UUw9qugmXJmogwGDj6n+a5dX5X1y5
   LIBPYUTNQVqppv+K20n6mmU7d5NOUEW+YUecLAKe828Z0tU/NDXafuvra
   l9gKo2khPNcAqaMT0/4NLfk20YkAFdWwMM9enH0IkQWIcjYs8e6wXskuu
   P3Ezsz7QZJSWZKmgYmwiqUL9A+HLQRrpIWyOd39UPJ22cgobPa0Nybdzl
   g==;
X-CSE-ConnectionGUID: XaicN5wnQPGIHbrBB2iHXg==
X-CSE-MsgGUID: 4+99UA9fQHqnuSv3x/XWtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="78548137"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="78548137"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 02:10:02 -0700
X-CSE-ConnectionGUID: 8xhX5J2aRDS3x+KHMAzI/g==
X-CSE-MsgGUID: F+1U3fHQSqCbjhxKz1JCLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="223427753"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 02:10:00 -0700
Date: Tue, 31 Mar 2026 12:09:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] staging: iio: adc: ad7816: replace sprintf() with
 sysfs_emit()
Message-ID: <acuPZWdWfwRBjOOp@ashevche-desk.local>
References: <20260331072453.6530-1-mdmahmudulhasan1511@gmail.com>
 <20260331072453.6530-4-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331072453.6530-4-mdmahmudulhasan1511@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 31, 2026 at 01:24:52PM +0600, Md. Mahmudul Hasan Mabud wrote:
> Replace sprintf() with sysfs_emit() in all show attributes.
> sysfs_emit() is the preferred way to return values in sysfs
> callbacks as it is safer and handles page boundary checks
> automatically.

...

> static ssize_t ad7816_show_available_modes(struct device *dev,
>  					   struct device_attribute *attr,
>  					   char *buf)
>  {
> -	return sprintf(buf, "full\npower-save\n");
> +	return sysfs_emit(buf, "full\npower-save\n");

Missed a comment. This needs to be converted to a for-loop with use of
sysfs_emit_at().

>  }

-- 
With Best Regards,
Andy Shevchenko


