Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995125;
	b=lR+GMc+sOSJVtG8J/7dNHGlUJiL26gOObOLHKYmi1CMm8159H9pdu+tvkhhO63JIL0E6
	 nf2RvyJ8Njlfm4lZeqY7djnEo0g/htmOTc8YzW7Yco5Q/2Z11kh7HugNhV+WeznU2WeMp
	 NurQQwp2gTegmfb2/D0QiNGIyz0q36d2nagFDU5PzxWUgBz9FUPPafKUTEQYQ0+u/o1zA
	 9G5NIs3HETuXSLg9NXgIOOaxgPYWkrZO7/NrMh/aSkALZnTeq5l91YCtmDSvfOvvCxyx5
	 nOtHpIJuNe/hEtIDKCv088d4uzB908pRT0iNQUD5y+ibvXW1I6cRJLeAwfYJEExMsOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995125;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=WQQ0tzprAAKvqFubA0t3AqCTiMwa+uYsBg7xwAuuzeE=;
	b=pK8i31jh43Gv8+j06oelHJZKmVYx6aVFZzQVUOo7dm70/lonSdVLlvO5yY+6XvFys1Ts
	 tGpj1MmLyUD9lMDLSh3bMzYR1CM+byxrAZXFMiwIal/NK1PRiDvbJwCogA2ebkE8NLO7S
	 o75lPoKIm4IqVW/64b2AZhsMVb5he+sf/TppNYJ7qAZNFLhYcD3SfIyiLGwWa88zIfDIe
	 dU5ZFnlOQUrx7UBj3otFgxoGYRbg25MhOijmvevsOj2TIgNlC1Dm/SllRuWuZVSjBGzkc
	 mt9EwvxCsh53ZiMaHVahr9VxwKWy7I5lwht6FTg1leHMVHW1MB1PuL+gMnO0DTvymew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hab0Cbvh;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C6606A31C;
	Wed, 18 Nov 2026 09:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 408C6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hab0Cbvh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794995124; x=1826531124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TwxffKkwFJ/M5OSAde1DVAuae3LIyyCRilabg8pcE3U=;
  b=Hab0CbvhVJuVVpEGyaO5sWb7q4VL2oU/MXKXGk3kxcLpUjZeTzQn2LG3
   LxAunPKDB6YHazt1r0MJ0IAr4DGmcnOQfhlVDjYE6kx/kKambvxqPXNH9
   4IVSlzDDKaj2XYC0jdsnv42gAUCaGIhAwTe9WECxpd2UUlw+cTB6Guw9J
   WiOgTqEMmaS/G2kK22aG15lzjLrGAOf/yQpDHYdtQDMNVJGMT6suEJz5k
   u3heEuTfmwpj1ZQNvhLJJZuPiqcly02EUGajB1QefETZRdoqhb8SBRYr2
   IDFJftAB3/VjlGV5djLDHwx8Bkpfj8OZaIYyBFvtv6Xad4682N5arkK3L
   Q==;
X-CSE-ConnectionGUID: n/JXpnS/QAKT0dF0iwlrnA==
X-CSE-MsgGUID: r+mSiAC9SdOCGeH9nGWOxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3790017"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3790017"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 01:45:24 -0800
X-CSE-ConnectionGUID: 7iwL4fZ2SW2Au5888q7FfQ==
X-CSE-MsgGUID: AAKEm4mDT26os3njbehwlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="12041261"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 01:45:21 -0800
Date: Wed, 18 Nov 2026 11:45:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/3] math.h: Add mult_fract() that takes struct
 __Txx_fract as argument
Message-ID: <av1zrjobIT3KRfiP@ashevche-desk.local>
References: <20261117091638.1463621-1-andriy.shevchenko@linux.intel.com>
 <20261117091638.1463621-2-andriy.shevchenko@linux.intel.com>
 <20261118092229.000025fb@kernel.org>
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
In-Reply-To: <20261118092229.000025fb@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 09:22:29AM +0100, Joshua Crofts wrote:
> On Tue, 17 Nov 2026 10:14:40 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Add mult_fract() that takes struct __Txx_fract as argument and
> > calls do_div() instead of plain divisions.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  include/linux/math.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/include/linux/math.h b/include/linux/math.h
> > index 1e8fb3efbc8c..ded258df50df 100644
> > --- a/include/linux/math.h
> > +++ b/include/linux/math.h
> > @@ -128,6 +128,10 @@ __STRUCT_FRACT(u32)
> >  	q * n_ + r * n_ / d_;	\
> >  })
> >  
> > +/* Same as above but for a struct __Txx_fract fraction */
> > +#define mult_fract(x, f) 				\
> > +	mult_frac(x, (f)->numerator, (f)->denominator)
> > +
> >  #define sector_div(a, b) do_div(a, b)
> 
> Sashiko has some remarks.

Strange that I have got no email on that...

> https://sashiko.dev/#/patchset/20261117091638.1463621-1-andriy.shevchenko%40linux.intel.com

Ah, yes, the commit message is stale, I need to make it up to date.

-- 
With Best Regards,
Andy Shevchenko


