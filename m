Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175072;
	b=42+Hof4gnc8oY6mM0b2JI2qoB9eLFuZ+jfho856iSYCOrTRRQlWxmDo+97JKOuQq6pix
	 pRfmdPxoTSf8vRxMcFeGE9WHS/9LbmzflhvpcfRHq5bZcZAreT8EeWjTr+9vCiiDuyrlh
	 FTjeAwA/9L0tXejCz2LUNowWJH/Yj5mpNvadoAmKgsbFKaYbJAZrNtAPOX2bm3z9N9X3V
	 5W5lYXx8waengaFWxnVwsg1PmD33W7IsBJCET+T3jWqRMjf/cKvJd/3vujFVWaoCNPdUa
	 Lcqf1ibR3Md8p+ES+6SGqOGSElnERZXTCzwXJQKdLsp2CI4vHQl/vnvXUeWYMK6W32Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175072;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Ezbo+pip8MpAdiPPtGALw6EWfroPjVb4YVB/6Tn9BEI=;
	b=DDo9KJlk2MZ7hyptZrqYdst+9zv2f7oWCj1G8HAaijeR4YNc3RaGwOM8I1oGsL8+v/X8
	 2aPOgiQoHf5CA1xrS/2CIJzHcGZqoUL0qgkYnTJ/t+1GokRWtsa0zmrAQATmvygZY0hyJ
	 McibXDGphL8zsUahBpQsCh0O4Zg2uzDpHTfLpvY1SBiRblif8cJLhKEl7tJecuOFPlVFp
	 m5Y0cLj6dPO1nKG5/CLMcFLtv5+mwuQtRGHQCKPly2UnrVykL7MkrcZzV1nYoGzggjKrR
	 dg3Jk3x/Nt2+RiZZlcFzMwxPlEH+urir/CcWv58osqJEo52qL5lNth9yz8sm6BLKNvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J5y5ahUQ;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7800F606A31E;
	Wed, 28 Oct 2026 08:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7800F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J5y5ahUQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793175071; x=1824711071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XNHGGlQncV6bGlFLPBcvpXgxWjmtNHlsa6hAlwTLNMY=;
  b=J5y5ahUQFTxTwBFz8G2iLZ8dshzh3X+a7cnfhl5mUUrpDklcD0u5k6xS
   G6y82ruDXewqPbiO0aQTFNKLwsmGdMwU70gsC86MBbkzBwL8yVImiCv1p
   l8QmogRetzlMNoWmlsrD4qjCSDyaO8/GV6BuvYtNkYEqjVCT+8pYbVGFl
   IPjGolqOfhOvXT0yixW7a4xFsnIl8b4qa33WKbToXCToImGUIHZ5zYoPc
   eZkxalgxx8uUEj4AF0sgAB9V8Kdp1ylo/CZh+wLIgxFoA+DylUPeAvSTR
   L9G0g+Il9LhWOqfsrueVCV2Vx+c/IxxwmEnxN7Al2blKT8jFK8tmF12GY
   w==;
X-CSE-ConnectionGUID: LffTDLibTgKPTh8mO1Q0Og==
X-CSE-MsgGUID: zBKDzl5qQTSSiyE6j53pdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1981352"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1981352"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:11:10 -0700
X-CSE-ConnectionGUID: AsztMSEwQXawjPBf51w47g==
X-CSE-MsgGUID: FlBbW2MGSX2CO59dO8aYCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="6618184"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:11:07 -0700
Date: Wed, 28 Oct 2026 10:11:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	David Laight <David.Laight@aculab.com>
Cc: Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iio: prepare iio_format_value to handle
 higher-precision IIO_VAL_DECIMAL64_* formats
Message-ID: <auGuGfSqa-D9sceB@ashevche-desk.local>
References: <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
 <SN1PR12MB2528906BE220765FAF201080A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
 <25g6fr7y4bmd6bzomvlvoejtps7wzbnbuuxxipmcrnozujno2l@klcfyrmqsifd>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25g6fr7y4bmd6bzomvlvoejtps7wzbnbuuxxipmcrnozujno2l@klcfyrmqsifd>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 03:56:35PM -0300, Rodrigo Alencar wrote:
> On 26/10/26 11:51, Victor Chernyakin wrote:

+Cc: David Laight

...

> > +/*
> > + * Regular abs(LLONG_MIN) causes signed overflow, which is undefined
> > + * behavior. This variant avoids that by performing the computation in an
> > + * unsigned type, for which negation is always well-defined.
> > + */
> > +static inline u64 abs_s64_no_overflow(s64 x)
> > +{
> > +	return x < 0 ? -(u64)x : (u64)x;
> > +}
> 
> I think I've seen Andy doing mentions to a needed 'safe' abs() a couple of times.
> Don't we have something in the tree already? if not, Why not adding a
> 'unsigned' abs function to math.h? something like:

Or maybe something clever using the s64/u64 domain for all.
Let's gather David Laight's opinion.

> /**
>  * uabs - return absolute value of an argument as an unsigned type
>  * @x: the value.
>  *
>  * Unlike abs(), the result is well defined when @x is the minimum value of
>  * a signed type, since the negation is done in the unsigned domain.
>  *
>  * Return: an absolute value of @x, as the unsigned counterpart of its type.
>  */
> #define uabs(x)	__uabs_choose_expr(x, long long,			\
> 		__uabs_choose_expr(x, long,				\
> 		__uabs_choose_expr(x, int,				\
> 		__uabs_choose_expr(x, short,				\
> 		__uabs_choose_expr(x, char,				\
> 		__builtin_choose_expr(					\
> 			__builtin_types_compatible_p(typeof(x), char),	\
> 			({ signed char __x = (x);			\
> 			   (unsigned char)(__x < 0 ? -(unsigned char)__x :	\
> 						     (unsigned char)__x); }),	\
> 			((void)0)))))))
> 
> #define __uabs_choose_expr(x, type, other) __builtin_choose_expr(	\
> 	__builtin_types_compatible_p(typeof(x),   signed type) ||	\
> 	__builtin_types_compatible_p(typeof(x), unsigned type),		\
> 	({ signed type __x = (x);					\
> 	   (unsigned type)(__x < 0 ? -(unsigned type)__x :		\
> 				     (unsigned type)__x); }), other)

-- 
With Best Regards,
Andy Shevchenko


