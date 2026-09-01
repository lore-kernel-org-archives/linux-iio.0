Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3542DA5B;
	Tue,  1 Sep 2026 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247177; cv=none; b=XTjp25JYK+OfjIfA9oGJVdUYF6b2BaY//+cFu/HCdmwOgTuS1Weu9HKBeav7aaGkM75u8IAVPiMmoImHE0vnZRDIV45ltGy8ru2+KmwxGN6p6tM/8/He1XCBlHMsKrkQ7XQZSukLGOy+QbMrsM0Qv67HCodufGXxSiuwmvIHMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247177; c=relaxed/simple;
	bh=Zu24pMlaY4E313bRYquaYaNFWRLE81YRhF5c0OnVNEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GynspgBXPxoWdMF354AqPZBKd+vrK6B6eyZqFbUc/KOcJ0pUo3RoQPJJwBRk5l3+cukwaoCsBuhpWL5KNJ+yp83A9JLGqk0j9V05tsPF8XbQ3NZcprgdr3aNSeZnsKPuFm/6lIcwwq+rK2Gk/KENvK26xVQIejiDTy8uPYsWiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPDBE9p+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPDBE9p+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788247175; x=1819783175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Zu24pMlaY4E313bRYquaYaNFWRLE81YRhF5c0OnVNEY=;
  b=PPDBE9p+4gUyprd5QRvKWfu4eXDqseSwntUfLvvIwMYrlbC7AVPwTsm5
   BYnuV33cE1u+k8P8E0TfQlF1lPLuMrhTv0X6cxwkPBJOwTrLIQlkWkVvg
   yTkKWlXZXlBQ+oT4qDduEL5fPgRy5+yXQ/21wi+Q8lOmlpFYTYM7sfh8b
   gdS9BDdqrzp50RdFGXAAlcVS8/qtiSfZNuhPHfkqZ+DVmlHRzkJhxYtYr
   KN7a/JCqP5IKpBHG8y1Ppfve3DEQFu6y5iib5csffVBfh5p45xUUEwvKV
   2cJUhMhEDrFbXIjiPyT37iFvzPZUOsqn5jc4rWAJkh4lHED2aoMpPf6wx
   A==;
X-CSE-ConnectionGUID: GUVjwYvDR9CsLHY8uPM4UA==
X-CSE-MsgGUID: ve7mOAOYR0G+9Kw13Ew8wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88690999"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88690999"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:19:33 -0700
X-CSE-ConnectionGUID: B3MU0I/8Qe6mcsREQCBEuQ==
X-CSE-MsgGUID: 6sVixS13RAKAx1y52EsupA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="272801263"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:19:28 -0700
Date: Tue, 1 Sep 2026 10:19:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <jananisunil.dev@gmail.com>
Cc: Janani Sunil <janani.sunil@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v5 05/20] iio: adc: Add AD7768 and AD7768-4 core support
Message-ID: <apZ8fac_5DLlFKbN@ashevche-desk.local>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
 <20260828-ad7768-driver-v5-5-e33ca6f841a2@analog.com>
 <apVDm1O_NtD07-rw@ashevche-desk.local>
 <b2f430a4-a43c-409f-9bdf-ffb0f70b1538@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2f430a4-a43c-409f-9bdf-ffb0f70b1538@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 05:20:04PM +0200, Janani Sunil wrote:
> On 8/31/26 11:04, Andy Shevchenko wrote:
> > On Fri, Aug 28, 2026 at 05:30:28PM +0200, Janani Sunil wrote:

...

> > +	dclk_div = 8 * st->datalines / st->chip_info->num_channels;
> > Does 8 represent BITS_PER_BYTE? Can BITS_TO_BYTES() be used?
> 
> 8 is not BITS_PER_BYTE.
> With fast mode (fMOD = MCLK / 4) and ×64 decimation, this gives:
> MCLK / DCLK = (4 × 64 / 32) × data lines / channels
> Therefore, the factor is 8. I will add a comment explaining this.

Yes, please do. This will clarify the magic number.

-- 
With Best Regards,
Andy Shevchenko


