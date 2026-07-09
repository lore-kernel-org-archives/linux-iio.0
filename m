Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F71E3AFD08;
	Thu,  9 Jul 2026 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592365; cv=none; b=Blz3a3icZutWcqS5TL4D7ft8QkveQpTlOHcKYvCr7rbVLthSGEt06JTOvLfJttrN9FY6MaULSep3iRJ2xhiE8bfCd7Mid56uCB88wD6oPLpbHihecLbRISFK5ynj1bEvV6rHm2E1BOLHj0C9WChwOepV7epS1yorxMkuPmArlO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592365; c=relaxed/simple;
	bh=C6Zr3JPMN5tTq60ktTOM2vy0OVuEMSsWu+hbALmvEZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INepMwYrF8Us7aqtZ8n8uLB2l+zBjYg3ZOvUqdBZpvep/jwq5+cPefMFzftzgoq0W9ERHLGIMLxMx5klcvFwXJ9irTWth7mEG1p1q0POMSwENIP/6bmvAv7KSHQ7u9Fxz40TWheEfZxMEr+rmIyHDb1BsepgCqp1wE49Qigb5WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WICtewaP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WICtewaP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783592364; x=1815128364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C6Zr3JPMN5tTq60ktTOM2vy0OVuEMSsWu+hbALmvEZU=;
  b=WICtewaPuv6xrsqD/8iFgRXzbioAcnzSqJfX6l+Hy1zXgb/Z7dT5pD9R
   Wpdygd679sO2PQjxqTM1glaXxQn2iIrQrEDwdZw8vh7o8FfppsRhwwKW3
   34WG36XgxTVkGOWuyRfWtuyCmU9ydQwN8DJfKuPZTwahfKJCyTV4d2+m5
   2W/bkzOm5nketbBDo6j4bgs3QnihPLU4k5XuvAW8XEJT89/i4xCgpKk8m
   itpDQ7iz+pAUe5ewW10qjJhL6gLuy+czm24NejnzwoF+fuo/XdunRbaGx
   mh99NlOCj811dmApT5hteQ9HhTvqs/C7N1DCkqAL3+b43mFaqkGx0kke9
   Q==;
X-CSE-ConnectionGUID: bdjMnXNsSk6sUXb5bENmzg==
X-CSE-MsgGUID: hINaXRUATbmwyAfEL8axZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84049145"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84049145"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:19:23 -0700
X-CSE-ConnectionGUID: xdmAXBAHSk+RrTuLQSFiZw==
X-CSE-MsgGUID: tbqOnLjfTia+tCAFPlXeEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="277774860"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:19:21 -0700
Date: Thu, 9 Jul 2026 13:19:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lukas <lukas.metz@gmx.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <ak91pq1suFO2k76v@ashevche-desk.local>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
 <20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net>
 <ak41MZNHFvVzeq6Z@ashevche-desk.local>
 <ak9x4iKf7yR1rMWN@berta-MS-7693>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak9x4iKf7yR1rMWN@berta-MS-7693>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 12:03:14PM +0200, Lukas wrote:
> On Wed, Jul 08, 2026 at 02:32:01PM +0300, Andy Shevchenko wrote:

...

> > At the first glance it seems I already commented on the issues in this driver.
> > Yes, I see that I commented
> > 
> >   "Leave trailing commas in the non-terminator entries here and there."
> > 
> > and in several places in this version it has not been addressed.
> > Taking into account this I don't want to go through and check what
> > else is missing, so please go again to v1 and carefully read *all*
> > the comments and either address them, or explain why it's not done.
> 
> You are right, i forgot to change that in several places. I think i got
> lost a little bit due to the amount of changes.

The advice here is to slow down, and be not in a hurry, just take your time
for what needs to be done.

> I will make sure to carefully check that i didnt miss anything before sending
> v3.  

> Thanks for taking the time.

You're welcome!

-- 
With Best Regards,
Andy Shevchenko


