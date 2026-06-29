Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A863358CA;
	Mon, 29 Jun 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754694; cv=none; b=S61jSTO7hBh65fV4jbdXxp57ogOFtZJi8d1Zjr39qtKY2P2ZQO9WrLE1+45CnhzS94Qcyi/Pexs1ryM23YZMfmaFWgyMtDE5jud3PG7X4Ls6J8Cm3g/eug0xRTfk0VJ89x4UI8l0O1ShinHcAfi/Ji26d8n/A0a2GJf6u7FCUrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754694; c=relaxed/simple;
	bh=Uvqp2waCHDrzlXU0QVPf22/NxsudQ01dIehVK+QNUqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udktknD+v9UVX+HrtqBWEOnAU0BIF3qCHQWEyX0a/GfKyRKig7XWTPcwaISbI/4mm9Vu8X20kBy7DdQCgw781sBu9lWCF5xpRDUFXQSGD7KXEoTo8lkeIJALJnodyfuJVeK6sHdgYVgFD3U9b4OnS2/SzfthGjC0uZ002agSjjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFDERMdc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFDERMdc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782754693; x=1814290693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uvqp2waCHDrzlXU0QVPf22/NxsudQ01dIehVK+QNUqM=;
  b=oFDERMdchxqIIAuWcYNALx4W7U6HWbtmwXgcmRHqmH93zPbwsc1N6ivB
   v0sJIHNFFnAPXLlkFLC3Fn04jptQs4IFfb9I/FUgp3ikXNrxutooSeBGR
   5rL/Zn1jMKPwQh2M4T8nTGCyQaARCZTwl8+Lqs8yJ25JIYF7XHNp+/JuY
   jQsIxI2bRKU1LxG3LTe+MZiHm3reotH0Y6zdLUKFmXjzyQqEbFZWEdHLs
   N7JH6MvhjkM3C6CfHU6NupbitFzfFSGjx1B0gzziZk6mElpPTW5z7FxZ4
   LP4o7cNLUJ+KiYKoKiSWuYIwZt0VoHesnES1pPpWDKXDqOIP3Vud59TTe
   w==;
X-CSE-ConnectionGUID: My9m6v43Tg2w2xs/ITAiZg==
X-CSE-MsgGUID: jaPVedoFSfKWIq85aOGpQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94949444"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="94949444"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:38:13 -0700
X-CSE-ConnectionGUID: J8KpsXNRRz+bGnB+1CPy8w==
X-CSE-MsgGUID: JQwSwp9ZSguu1bcxfsWy0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="250318417"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:38:10 -0700
Date: Mon, 29 Jun 2026 20:38:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, julianbraha@gmail.com
Subject: Re: [PATCH v4 3/4] iio: adc: ltc2378: Enable high-speed data capture
Message-ID: <akKtfzF2DtDJlKh8@ashevche-desk.local>
References: <cover.1782397418.git.marcelo.schmitt@analog.com>
 <7d91f48bb03a16e6876e7aeb05fe259e33ae625f.1782397418.git.marcelo.schmitt@analog.com>
 <akIHUgTtyZv44TWv@ashevche-desk.local>
 <akKqhwv4cbR-fL-g@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akKqhwv4cbR-fL-g@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 02:25:27PM -0300, Marcelo Schmitt wrote:
> > > +	/* Double check the minimum CNV high time is met */
> > > +	if (cnv_wf.duty_length_ns < LTC2378_TCNV_HIGH_NS)
> > > +		return -EIO;
> > 
> > Hmm... How is this IO issue?
> 
> Okay, what about EDOM for PWM setup failures? Any error code suggestion otherwise?
> Will follow the other suggestions.

Seems -EDOM is in use in some cases of PWM. I haven't checked those cases, and
if fits I have no objection.

"-EDOM if setting failed due to the exact waveform not being possible"
(from PWM code comments).

-- 
With Best Regards,
Andy Shevchenko


