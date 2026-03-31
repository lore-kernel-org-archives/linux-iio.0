Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED09194C98;
	Tue, 31 Mar 2026 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948251; cv=none; b=ltGUCPsOAUtbJyKpRUDNoU59pyOikTP0/geQ32oIrLGYJEWSxMY0QN5Wcv7vFo63+Hy7g4VQx/FHky0jEVH7q/c/TiQlKGsqAhWqDLc1tTrgT3EevIrNaEpgLe3emOp7nYfS0C4drLrHgfUacnq5irjDklxXoFGHg6jrPbz36EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948251; c=relaxed/simple;
	bh=scaUt0K8TozSM1R06C9MUsORg333k2YmBpapZWiqfzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEv4+6J0SsM6agLHNanqsIFh3s8St+GJ2pgqrE58Lsn/wlBkJnutqP4/j8A75BCsnmovntvxDqTbH7XmMPIxYH8Uc5MgVY7sBNbE4njE1VzXWMy39zdYGg8KDK4cH756Upcwy1gN9rsQPeAxvlSmu1jBzx8pkVSCGF8wY2mCM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cioKyDDV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cioKyDDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774948250; x=1806484250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=scaUt0K8TozSM1R06C9MUsORg333k2YmBpapZWiqfzY=;
  b=cioKyDDVtQLsubu6vW7GJknX2HPm2Txhppn8D2Q7x2XDEp/SsjboiVr2
   fnYBq2k4RFKjCWcS3VndU4Vhu8qRKuRpjh1xC106Gao/+ENkD3TuYrXR4
   5GfV5ryZeP+vzHTxR4k6yFbX0iuhtsFRV+Ei/fRf5zdGyuF8bTJIHF0q7
   nDl07x2yN71cCa58n+BdDQd5zdXrbXoXCX0ZgqoucTkzyEijFyxDEkqAU
   uq4RmmiNhxywCJtEkW23BsjNVE1a5PllEExqpUKzP/tKuKmSA8aUz8X4o
   9+pz3ScXIJhFZZr8TJhyzg15wXLp7eb3nw2A/vg40mnRZIe2dYgF04dr+
   w==;
X-CSE-ConnectionGUID: 6IpaU1NIT8iHuzbPD7oLKA==
X-CSE-MsgGUID: QygfIHedQWeHR5Rtukv3fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="86572023"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="86572023"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 02:10:50 -0700
X-CSE-ConnectionGUID: RDOnl4X8Qn+lGKuXdN+EJA==
X-CSE-MsgGUID: J25B2OaXTemGIFaM8A7TMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="225304898"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 02:10:47 -0700
Date: Tue, 31 Mar 2026 12:10:44 +0300
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
Subject: Re: [PATCH v4 4/4] staging: iio: adc: ad7816: use modern IIO
 attribute macros
Message-ID: <acuPlI8kh7iyWPXt@ashevche-desk.local>
References: <20260331072453.6530-1-mdmahmudulhasan1511@gmail.com>
 <20260331072453.6530-5-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331072453.6530-5-mdmahmudulhasan1511@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 31, 2026 at 01:24:53PM +0600, Md. Mahmudul Hasan Mabud wrote:
> Modernize the driver by using IIO_DEVICE_ATTR_RW and
> IIO_DEVICE_ATTR_RO macros. This involves renaming the callback
> functions to standard <name>_show and <name>_store formats, making
> the code cleaner and more maintainable.

Missed my comments about commit message changes and below about line lengths.


-- 
With Best Regards,
Andy Shevchenko


