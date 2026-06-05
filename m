Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C442128725B;
	Fri,  5 Jun 2026 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682919; cv=none; b=XJ4/jKO/Sx10TwaLSX7ZcibZqYbcHJZl66H9n29HAH7c9JVlOFZLVLvjgMjiFRgqnL2tl+8DVFNX3sFJhGOi8kVHVJjYX5ezSKa98O//dtADj0r9DhIpvzU/WvG4ZdDF2c9Z0NMSfMfc/z+BiI5DK52JJJsytpUrBsziVxKbkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682919; c=relaxed/simple;
	bh=2+brnzUx990MOInGWsL6ZxNrK90ERrXAKzKSiSYXsPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6Yu9a5cbZZWhxMax+LJyvFD7G4RYWsLRMoAvwYbArvuKA2Vpufmtw4jnKLdwcWxeyQU4lnBuIQiv5WNtsuu2pW0AlDQmmdRnnX3E9LOzEkQNCkTTNtKl+OPBNwXiffR9lRzmXtRM7/q9Kjwap2+KmA4hJb13+WI8trEolB6riM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGmG13yi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGmG13yi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780682918; x=1812218918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2+brnzUx990MOInGWsL6ZxNrK90ERrXAKzKSiSYXsPw=;
  b=SGmG13yi5ICaHrNhVW0XS4A+9VKTqsLLt9t5aOEl0J+xMNH+FXj6RXT2
   4PFKxagC40PygNd4w1KRBF+/naQfpdm2K9O8Axo7iQXMRsMDqLETtM4sk
   qkSK0OZ3H4DLS7BW0yTSDDrfqb2T5oOZgIze7DNF/qFxsy1PMmyavW83P
   4GN3ETqSibUSNXvlRWBtDfYZpQfkxzyr4DfChJluLu9HwHgJVD8QNR0z1
   bI9Oyhz5HaXloYx1PSpe2XMUQzQTTKDji0Jb9qfQcutc75ZfdjRIMjqiR
   RSYCetZocdKsOe4NfywFLsY4JzhG6vIxWQ8n1/OBQGJcVC8L+2uM+XZUh
   w==;
X-CSE-ConnectionGUID: o9PSHtK3S36Ym5axgKn9+Q==
X-CSE-MsgGUID: GE54KMuDTbyT/HzsWrXVgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="80555507"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="80555507"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:08:37 -0700
X-CSE-ConnectionGUID: VodKQM33QyCJKHA7Nq4egQ==
X-CSE-MsgGUID: DA8IULWcTiShoZurc3E7Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="268590591"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:08:34 -0700
Date: Fri, 5 Jun 2026 21:08:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <aiMQoKociwhOUDvJ@ashevche-desk.local>
References: <20260524-veml6031x00-v3-0-29165609b2b5@gmail.com>
 <20260524-veml6031x00-v3-2-29165609b2b5@gmail.com>
 <20260526185933.0084679f@jic23-huawei>
 <aiMPJ9Qqcg7XTJt0@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiMPJ9Qqcg7XTJt0@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 09:02:22PM +0300, Andy Shevchenko wrote:
> On Tue, May 26, 2026 at 06:59:33PM +0100, Jonathan Cameron wrote:
> > On Sun, 24 May 2026 23:53:56 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

...

> I have a déjà vu that I have given already same comments.
> Why are they not addressed?

Okay, it's v3, I reviewed already v4.

-- 
With Best Regards,
Andy Shevchenko


