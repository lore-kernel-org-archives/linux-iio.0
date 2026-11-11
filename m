Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408772;
	b=r6c4TftQ6OO9FpiXWvrYW9mTM4E0f/pVD54k5Tl2QepUbwDp2oZ2+iZrC3xT7AWTAVEU
	 p9A+lf2f4fYO0LnP2H2NAnCJYCkRGhhxL+ccJuvwiIjMDtU2pg2XZO0ZFOdWGHZhnfhuW
	 lpReDYIyzjvRF0CmsRPclG1YNVanFXoMqcHcLqEsn4B5XwRZYBug+o/TMd/aQWLAlP07L
	 1XO3cEkzDS+w++bH1QwovHu190zKcdS17bPMqwlpMX+8GYhY/0VQE3ZS1H4z6CV9raVI/
	 Nwz90GRd3843crxEfNHLwGu2rEi0uKyrhD3zAdNKVib73is/fJQhJkAmOWSaLk9VV0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408772;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=8jv9+RQFim5380AcTWtyjfYgJClYtYqY7x8fuAP4Yf0=;
	b=bQIZz+3CNFZce9oyZWSvJX6ckX/AAVB3lrJomMTxpVPZrDCOB+tmTCR967eLj2eoSNGe
	 NbQegh3WwRKoJ8S1jU8MdMW8Tmi3JOus8/cuFWWOtdgsnB22umb+5ltbPc58evq6vcUi5
	 yXLcOzffblUT4ebyJV7N3uv2QptAnhiknypxObEPg5Kpm6Fj3slkHnri4yBxw6ao7bRkb
	 j9+yB+0IZwkwJtzDt9WAFIAcprdN4bWjOEA0WeqxhaK72WlvO9Da2c6U5IePyo2XrlIRI
	 7b51ByUYW4vYbS8HK+6E3I5HHnAisDaXf3jETc26bRDVuNa2MKJ4R7cSCeW3HfZQE7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D71CegSz;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A40606A321;
	Wed, 11 Nov 2026 14:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76A40606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D71CegSz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794408771; x=1825944771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=paAjwSZ79wD31wqMKdwmdBKZ45f79XyAox4TK1BiMHw=;
  b=D71CegSzxcU3kDq7tC6zo/ulC1KvvI0gWKw/cqwMoHX76tFamCiZkrpU
   uPm/pX0gonqE4OB+p3BkGRXjh9HaPSoqriJLO0YvOlSFvZ8dOzcdiwzD0
   fYD4RpMV0jP4C9pE/o0Ya8wlLriMY1YMjFUnjudjetwld1GBNbz3T+diu
   PFqbw/S0rIH0IhL76wVZQFWXBzRmTpwndeQRRvOGGl2s7SupmiBWZcAVr
   qLQ2u29NHq1YnM9wRhAuOoXAWWFwpHO1xFxq6ONnfY7N38aTfOHltOaUl
   R/dUzPw9N7j1ol4eO6HViycW/QdP/tKcKOyr0DrP4kawPYhIfT36ZEH+1
   g==;
X-CSE-ConnectionGUID: mqc5qIuhQ7SiHSbd29Cmxw==
X-CSE-MsgGUID: cTBdUPtwTIGy0vjc9QSguA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3075331"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3075331"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:52:51 -0800
X-CSE-ConnectionGUID: ynclrC+wQ9eAsO48Ukbi3A==
X-CSE-MsgGUID: 4Clvj8f3RwCyTz6WH/h38w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8866398"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:52:49 -0800
Date: Wed, 11 Nov 2026 16:52:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <avSBP7Ib1dYpu_Ek@ashevche-desk.local>
References: <MW2PR12MB25231C3FE75A17CEDACDB279A5712@MW2PR12MB2523.namprd12.prod.outlook.com>
 <avSBHTY3XJi7iV0a@ashevche-desk.local>
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
In-Reply-To: <avSBHTY3XJi7iV0a@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 11, 2026 at 04:52:17PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 11, 2026 at 08:23:53AM -0600, Victor Chernyakin wrote:

...

> > Changes in v9:
> > - Patch 4
> >   - Added comment explaining why we set use_single_read = true
> > 
> > - Link to v8: https://lore.kernel.org/SN1PR12MB2528F139EE6C0B4576C3A0CCA5722@SN1PR12MB2528.namprd12.prod.outlook.com
> 
> I think I gave a tag, why it's not here, please?

I meant for the patch 4/4.

-- 
With Best Regards,
Andy Shevchenko


