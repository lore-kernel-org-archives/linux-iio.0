Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28183FF88D;
	Tue, 12 May 2026 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572685; cv=none; b=c2orWEpCC8kiS0OYqHeZNTtQG8COUe9dwIfKzC2bHZs4YnYyA8E6I3AXMM6VpV482cNQPuMcXAzdBPd69UTjh/CsMc3o5jgPtxrGt6M/Uvp0n0w0tiBpi1kDV7W3JQpu/qtkwxOLdNOWFyO9JKf9JYiiC1l0v2ujDVTjF6epYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572685; c=relaxed/simple;
	bh=kPfiMUw6CcOD6jb8gbhwJCrPhBCQjzipVLlBp6tq9Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flqh4gaS07QwK85URRJRCGPgdnQIQQAp1mqWluhcxkmoPS7G44xaLS9loUNHdy6JlfLE2U2CH5uvmUlHercacnDZwTNOpV81FAnNyfjwmYMmaoqMAoJjMPdx3WxvGPsCm45PnSXypv7zFMh2uil4l6K0+NWDzTqKBPH2TwwLxSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYVHo2PR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYVHo2PR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778572684; x=1810108684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kPfiMUw6CcOD6jb8gbhwJCrPhBCQjzipVLlBp6tq9Xo=;
  b=gYVHo2PRwi95YvtcC5H9pO24oEOEApZR6X51exOo6Sc6DeaN1pqVQQUJ
   oANNlH7we6gVy0IqsjaQ/97dCh3WTtyr2rq2mdXhpxljmKLJyKV7+twC4
   NAHQLFC3WhmqP9I1ePjEudjb9xcICfzBkp+r6+7lDptmsxK2GdEzqO3F/
   fUseojMicJ1LZWfh3/Y+XWEIfEnGclsLUGc9k/uPfy865Wtt1FBrtPvHR
   Q/G2hj9k1F38wpbgQTTOgPEm5Oij7WZylvEpfs/zXl9xuMMx7R/iPA4fX
   Kyvvk6Wts5zYUPn44xmARKcFo0/zZDbA6b2biRSEvzVg3Cc+jl7SzSmOV
   Q==;
X-CSE-ConnectionGUID: lUG/eMD2Qha1SuZUuU+gHg==
X-CSE-MsgGUID: a8af1rB1TUWCJkvd1xCLFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79458935"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79458935"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 00:58:04 -0700
X-CSE-ConnectionGUID: JXIqOijBQKiFAtBfeUGHPA==
X-CSE-MsgGUID: bV72gI0xSdeKEhhNSfz/tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="275815595"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 00:58:00 -0700
Date: Tue, 12 May 2026 10:57:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Stan, Liviu" <Liviu.Stan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Message-ID: <agLdhvre_WrLDP3Y@ashevche-desk.local>
References: <20260427132526.272716-1-liviu.stan@analog.com>
 <20260427132526.272716-3-liviu.stan@analog.com>
 <ae-pvxKhqmkWwXdX@ashevche-desk.local>
 <SA5PR03MB837776014440C2594B811BF7F63C2@SA5PR03MB8377.namprd03.prod.outlook.com>
 <af2UQ7ZLA2DL4FWY@ashevche-desk.local>
 <SA5PR03MB8377DB8F5136CC7BF9594B64F6392@SA5PR03MB8377.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA5PR03MB8377DB8F5136CC7BF9594B64F6392@SA5PR03MB8377.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 07:12:57AM +0000, Stan, Liviu wrote:
> On Mon, Apr 27, 2026 Andy Shevchenko wrote:

...

> > >  #define LTC2983_CHAN_START_ADDR(chan) \
> > >  			(((chan - 1) * 4) +
> > LTC2983_CHAN_ASSIGN_START_REG)
> > > -#define LTC2983_CHAN_RES_ADDR(chan) \
> > > -			(((chan - 1) * 4) + LTC2983_TEMP_RES_START_REG)
> > > +#define LTC2983_CHAN_RES_ADDR(chan, base) \
> > > +			((((chan) - 1) * 4) + (base))
> > 
> > For the sake of consistency I would see (base) also to be in the _START_ADDR()
> > macro.
> 
> I said I would change this in v2, but on second look, I think it would be better
> to keep LTC2983_CHAN_START_ADDR without a (base) parameter. The base
> parameter in LTC2983_CHAN_RES_ADDR exists because the ADT7604 adds a
> second result register bank, so the base genuinely varies. For channel assignment
> there is only one bank, so adding a base parameter would make the macro look
> configurable when it isn't and force callers to always pass
> LTC2983_CHAN_ASSIGN_START_REG.

Do the names of the definitions _START_ADDR and _RES_ADDR come directly from
the datasheet?  Also, given the above explanation I would see rather (bank)
than (base) there. With this it makes less attractive for a change that I
suggested earlier.

> Happy to change if you still prefer consistency.

With current names they sound like they are semantically tighten, when in
practice it's not so. There are options:
- move to (bank) and leave as currently done
- synchronise them and use (base) in both cases
- rename one or the other to be different by the name, so less confusion is
added

Your choice needs to be based on the datasheet explanation for these registers.

-- 
With Best Regards,
Andy Shevchenko


