Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37847366545;
	Mon, 16 Mar 2026 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695677; cv=none; b=Sc9IN/qKG+n8OLhr8z/JsCbS8koFDCYmeXutZAZkIQz/ypb8V1MQiiqPBhROf0BcTPUFWdmVzHhiA83OH8ar7M+Woh4mAetuSXoBCCI6eb0vZY88vwtXTx4LSUQJuiiOevb4xj3TVf6MCTxov2uiQp1MMw6bIwqkg+aYMRWL/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695677; c=relaxed/simple;
	bh=jcd/GN93y2rBVk7GYIzWLuhb0heIRu8r6Z0+jGJy+1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DucBUQhvVvsiP/sPz+CzHgII+vH6Oxr9xl3J+1GWhgEdPzIPuWSsYdM2NRrbCCOq5WpjwM2NVBD0opmXJ2xikxeuNqpayX1/yOBKoeCqfPJMFpZ7NO+k6K2j64mDXKm28GR9eWMkV7p+qUfjJ9Kyyf29foZSGwlc5h2iuSsHMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiEfvPnr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiEfvPnr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773695673; x=1805231673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jcd/GN93y2rBVk7GYIzWLuhb0heIRu8r6Z0+jGJy+1s=;
  b=UiEfvPnrtL3CUk83ftLNZkuTsprU99B9jWhjvaHjGDgcPixHYKCeudJ6
   T1hOysblp3ZnMikWnH/psKtfhmXww/PIYqyk6dZIxvTe+DHRGKvxrBB1T
   Sj+KWiwm0RlCX07gxabj0vJOXhnHRyiZsmLvyCazZOzlGX5Zq/CJdxcXG
   ru2bS+Gua9oObf1KL9rVU1NFsB/Ry0rVslfqBfstDMGeJ52ZhRvlWvPCM
   yvcHSsbMB2O5Eyhm4/6hmu656c8G78kgkYLA0WqKKdrzDzu2O3mWOm6qC
   eemAH1GUgfBUCXwiSyLKQlTXF95pg+zLRxV1RBzb6J5Jg+VeG/1TFirHR
   g==;
X-CSE-ConnectionGUID: 6AI7F4CORfyw9CfEHGgk0Q==
X-CSE-MsgGUID: gCsmq9EuSVCMRA91vUhxUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74837796"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74837796"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 14:14:31 -0700
X-CSE-ConnectionGUID: l8mFQn7uQ+C0vaisftjsNA==
X-CSE-MsgGUID: oFXoz8IFTJKil0kkWX0XIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="245065408"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 14:14:28 -0700
Date: Mon, 16 Mar 2026 23:14:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Raymond Hackley <raymondhackley@protonmail.com>
Subject: Re: [PATCH v4 0/7] iio: light: vcnl4000: add regulator support
Message-ID: <abhysYYZj4VWhdtx@ashevche-desk.local>
References: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
 <abhhPnvQwpZozHPe@ashevche-desk.local>
 <ea623eb6-2f63-459d-a1c0-afffd2428426@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea623eb6-2f63-459d-a1c0-afffd2428426@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 10:20:54PM +0200, Erikas Bitovtas wrote:
> On 3/16/26 9:59 PM, Andy Shevchenko wrote:
> > On Mon, Mar 16, 2026 at 07:19:44PM +0200, Erikas Bitovtas wrote:

...

> >> One of the commits includes a Reported-by: tag without a Closes: tag -
> >> the report was done outside of LKML.
> > 
> > You mean outside of public web access?
> 
> The report was done in a Matrix channel. I could provide the link to the
> report for the Closes: tag, but it requires to sign-in to view it.

Okay, thanks for elaboration. In case of a new version, please mention this
in the cover letter.

-- 
With Best Regards,
Andy Shevchenko


