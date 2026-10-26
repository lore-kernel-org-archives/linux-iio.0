Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007998;
	b=YX11G6BWgTpmf/SENDYbU+UZ9jiiwdD3L4vH6EkMOyf2wT1c807nXtdCj6B5G/Y4RaOP
	 RQif0zvXVY5OHtymlMTIX8IYTqZbeHQeqe09cuv19pxzwaONWyRBgIsa/TuhHeTSMgMbM
	 U2nGnCT9fWjnqtndPIIlBW5dfyirtBUf+2Cr8nKDWmURL9RQO911cHSswx9+LrPUJY0cn
	 sPO5dpAMz4UxiWB8q5LcMFWT8B5zT54Y1+gduNEvBIhV+YcS9+0/ksyFE2spgyy7PtB40
	 A2j/mfeso0s1ZXp3gj70S6L29viW2YR9SPIQaGEl4XfFUn71y9BYgGwC3zf70sXBk1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007998;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=+HCP5cVApizecRY7oPhlhJPDI0I0Wrv7Vu4PopXVwig=;
	b=Upyk2GtR1m6yR4MU9v2qj5lAZrzOxyiPOllHS/Wl1KiiV2qe6UaCwlau97yz3KubCN63
	 ybs2k0zQcEfub9ecFycuOZKpMAK1KAvyUWD3PH2BSNaHDL96hphqTPBJdJ73+3BSAyB+o
	 xsU7dOTBxSh2V2eKJP9fVHveY2hWS0qFLaKblJSAEw7WJ1TxSmmer0cbE/OodKJS18Mir
	 oznfqQcNueHvn5A7lV76y5vyhM3rVke2unf/mxEgp3fLCPEgL8x5/fbh+NDuf5XGeaf1m
	 ENX1k6BZ5HL/zDAxNbk8MRQppOo3xsl7rrlk09mYwmCKJ7KT3wteqZXiJyP45wElqlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=neXoiB+N;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14B2606A31A;
	Mon, 26 Oct 2026 09:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F14B2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=neXoiB+N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793007997; x=1824543997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hj+yqI6P50EVPgUi1HgHjbGUrze1zNl4Nit1GUNutzs=;
  b=neXoiB+N75a5Mv1lVy1qMO5VIkLgnckqbiiLFVYsOtXIp9lbYNqTOIJ9
   CvaiwxjWOlTleMJ+kZPT48sz3OwIOdkPDgK/0RpLM9bHaAKvm/1PWjgBM
   ra8ph2BzG6w3P52p4dkdg3RTGnfgoRVhP0mu3WJhnimyB/5Mj2P8yFzYG
   Hdedf0Z1Ol7jjQfKtiXV4cNAgvh1ca9NC2StYaVGm+8Y1mNj/z0yYgbzV
   lcsubUZQhJQFwbprNh5pS35fMUIn/HK5cAAzTsgrXeZFaLxuRL3LflPE4
   CU9RWg2wVtVE1FCIZ8yLpSBNSWO/RlgX28m4zot0qagAxw9KD53oajuZx
   A==;
X-CSE-ConnectionGUID: Mmxg5uHXRSW+6BizGVHjBA==
X-CSE-MsgGUID: wLIVZOp3S/6lD2ApyyJ4XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1558812"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1558812"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:46:36 -0700
X-CSE-ConnectionGUID: sAd/7mwJT6CQVzpy8KCo7A==
X-CSE-MsgGUID: N2k6eNjQSWmhnENFtSRzoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4725417"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:46:32 -0700
Date: Mon, 26 Oct 2026 11:46:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Prabhakar <prabhakar.csengg@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
Message-ID: <at8hdY1eUdxCUAzU@ashevche-desk.local>
References: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261023175919.160103-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <atyKo0pTYZyt5XJc@ashevche-desk.local>
 <20261025234850.41bc8f15@jic23-hlaptop>
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
In-Reply-To: <20261025234850.41bc8f15@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 11:48:50PM +0000, Jonathan Cameron wrote:
> On Sat, 24 Oct 2026 13:38:27 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Fri, Oct 23, 2026 at 06:59:19PM +0100, Prabhakar wrote:

...

> > > +	req_scale = mul_u32_u32(val, NANO) + val2;  
> > 
> > But what's wrong with the simple 1ULL * val * NANO?
> > 
> > > +	for (i = 0; i < chan->num_ext_scan_type; i++) {
> > > +		scale = mul_u32_u32(RZT2H_ADC_VREF_mV, NANO) >>  
> > 
> > Similar Q.
> 
> Patch on top please - I might squash it with original.

Prabhakar, can you cook the patch?

-- 
With Best Regards,
Andy Shevchenko


