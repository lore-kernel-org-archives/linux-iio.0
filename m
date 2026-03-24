Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254D3E9588;
	Tue, 24 Mar 2026 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353169; cv=none; b=JygvZ2DfLae2B9RmZh7XTU0D+wxJBOeOXziYN5YZkm1I2uVtJPdkcR2rv5HnXt9jwasP2ru5zHd95Oi7DPibLqrtAXLcx5B0Qad+1uJu5ycXknSxDKxVONy/RnEY24pzsCBuBzUq00idwecictcRsEtQ+UH+vPRQekex9EFlRJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353169; c=relaxed/simple;
	bh=ynXvcCupS3J2V6Hsp6xer64h2x9CP6ZMA6xWIxwuQ7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmmVTQjyzT0no+czzUlLq7PtvbHZcYKvpZcuyZBkvmv4doaLOY0mi4ITNdLiYtEmiZFhA+wY+U6pqN5p5ToB6kj1hyg3UcKNZi1K4iBi5r/bUc2ZQqVgTuKmmH4Ecq9K11zs1bAv9JuBybtCY1f24u4nEFVVeNUGOpwr02WyFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=guaerw+5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="guaerw+5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774353169; x=1805889169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ynXvcCupS3J2V6Hsp6xer64h2x9CP6ZMA6xWIxwuQ7k=;
  b=guaerw+5Ii3T6/NLfCCB4NMTYPOORO3XWprmKHePJAX3uf7T5vehGec9
   8oCsMBp4S1q6YLY0PMug7W2eU+qpg1sGdU7YN1pSlIhBR06DcK23ZPWqy
   j9rO3SvVeRXI/JynHWTyYhHR8L16ixq6Vudw85O1kRUbZWygS9O9CQ1rL
   ZVTna0DU/xiU5xIrBgq2RxeUzwHBl+3ADDphA7rdONIcZXfA6barzf8HU
   gKQ6xzu0E594Mrm2jrg7MlPo0dkpJ3lbY50FL6VxIoceBiGw9YmYzUOac
   evrq46UcZM+XVQRJh1vi5Ac1VQIIUG3rbsSHErqlngtlWf/GS7dVHN7jG
   A==;
X-CSE-ConnectionGUID: FpkdTwTDTni7rD3FcKQ9RQ==
X-CSE-MsgGUID: EwH/guXaTi+NJ6qpQXV6Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75556777"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75556777"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 04:52:48 -0700
X-CSE-ConnectionGUID: vkyGIRzcSgKL2Yjq+LImwA==
X-CSE-MsgGUID: v6bi1lpXRpqddsJGtxss9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="225974965"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 04:52:45 -0700
Date: Tue, 24 Mar 2026 13:52:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v8 2/6] iio: Replace 'sign' field with union in struct
 iio_scan_type
Message-ID: <acJ7C-RU8_p4EsuW@ashevche-desk.local>
References: <20260317150316.3878107-1-flavra@baylibre.com>
 <20260317150401.3878294-1-flavra@baylibre.com>
 <4723284d-1e18-4a13-9ec1-878220af257e@baylibre.com>
 <af2128c68d2a14e1eb664ce9dc075ed02b640407.camel@baylibre.com>
 <acFvHgTo-3cxH_UP@ashevche-desk.local>
 <5c780b1be8a64f7862a421db5a1f5be861cb197c.camel@baylibre.com>
 <acJv1RNLugS0aat9@ashevche-desk.local>
 <46a937ffd470d190b8e7da2bfc78dbbb7ecda94c.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46a937ffd470d190b8e7da2bfc78dbbb7ecda94c.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 24, 2026 at 12:42:19PM +0100, Francesco Lavra wrote:
> On Tue, 2026-03-24 at 13:04 +0200, Andy Shevchenko wrote:
> > On Mon, Mar 23, 2026 at 06:37:38PM +0100, Francesco Lavra wrote:
> > > On Mon, 2026-03-23 at 18:49 +0200, Andy Shevchenko wrote:
> > > > On Mon, Mar 23, 2026 at 05:04:10PM +0100, Francesco Lavra wrote:
> > > > > On Sat, 2026-03-21 at 12:22 -0500, David Lechner wrote:
> > > > > > On 3/17/26 10:04 AM, Francesco Lavra wrote:

...

> > > > > > > + * @IIO_SCAN_FORMAT_SIGNED_INT: Signed integer (two's
> > > > > > > complement).
> > > > > > > + * @IIO_SCAN_FORMAT_UNSIGNED_INT: Unsigned integer.
> > > > 
> > > > > > We could make this proper kernel doc format with one comment per
> > > > > > macro.
> > > > > 
> > > > > Actually, a set of related #defines can be documented with a single
> > > > > comment. I see a few examples doing that in
> > > > > include/linux/gfp_types.h
> > > > > and
> > > > > include/linux/fpga/fpga-mgr.h
> > > > > 
> > > > > > > +#define IIO_SCAN_FORMAT_SIGNED_INT     's'
> > > > > > > +#define IIO_SCAN_FORMAT_UNSIGNED_INT   'u'
> > > > 
> > > > ...or use enum
> > > > 
> > > > /**
> > > >  * ...kernel-doc for enum...
> > > >  */
> > > > enum {
> > > >         IIO_SCAN_FORMAT_SIGNED_INT = 's',
> > > >         IIO_SCAN_FORMAT_UNSIGNED_INT = 'u',
> > > > };
> > > 
> > > There is no standard kernel-doc format for anonymous enums.
> > 
> > What do you mean? We have such in kernel, for example,
> > drivers/pinctrl/intel/pinctrl-intel.c.
> 
> The kernel-doc guidelines at Documentation/doc-guide/kernel-doc.rst, in the
> section that describe structure, union, and enumeration documentation,
> include the name of the struct in the example, so I thought they wouldn't
> apply to anonymous types. But now I see that anonymous enum comments are
> processed just fine by the kernel-doc tool.
> Anyway, in v9 I switched to one comment per macro, as suggested by David.

WFM, thanks.

-- 
With Best Regards,
Andy Shevchenko


