Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405908;
	b=nrJ0w5HohaVP9FCgjFrWMsbrdiCakKP4tZEWnBKVjLivWKfdf7y3NMXP6xAYvHz/9qsR
	 vsopXJekuUr8WIfZTMK6tQbRrJM6muhr+gAeVjJerRyckiN+jRkyi2dHyC8IJ5uDsQ+HU
	 dLuEAQaz1js1aNfGO8XsbdakzgoHzAaQDCiXFZj8E3LWVmJZ6j+SwXzwHp+XuGhF4pVVv
	 YcHxkyucGvr2wx1k4ENNxJp2bGVbEZrnlSQn1jmjn50ARQz3ptJMahcRsfP34V9qXpnXy
	 oQgN/X8reXP4Plb4s0jI4/AT+PoW63leLRa1hawe6uvLYn6smcZ2Bi3zgiD4Kx1wELw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405908;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=dMVjouUzlrMgpNrx39+0TONjSPVxOpIOUimAbYCMEv8=;
	b=Unu0lJE5DUtIPOd5MRcE5ADkC+FZL+2MkUv25gHJ+O9bHVK/WmewvEwdpnZahVWmCOc5
	 uQ5NUEjZXBjq+FkjaiM/GxqZArNfhgB1aPbOw8rbT+9IIHX7V3oLCv8VFWTwixKUcwFqN
	 ctiFaIdNPBY9F3uZMBnDX5i808/wUJ1dk0NeSPz1KWYDXuyLa2skY5hYjbxVrrh2dcAfb
	 F7U+Xty6fHYsAzUdJuvAp0YXl6BFSuzz9TrDUxX2pjC98H5r0vdgtRnaghnvhlqCQNd7P
	 nzwRStzy0Uu3zNOWIhByLzuoqCpFG7hPWycId7nrz//+7ki68fcgXiruLiWHszPSLow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lGUb2FYK;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA70606A324;
	Wed, 11 Nov 2026 14:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADA70606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lGUb2FYK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794405908; x=1825941908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RjhR0GWgOac4DoIlu+EJPS0Wj64t3lFbbPAIZhDjKtU=;
  b=lGUb2FYKvqsGVpi2DVWMFwPsiJZIg2iJctkfNTXtn+dK41cH3MEFvbo+
   UA4rdNXUybt/aR41tc/4TE8OnjnOhLL9eMqfyxn1iVAMrTm5Mo6vhvzZI
   zowKAL0534UreBF9olICvO+6SJyCxLGxY+ZCnqepZ385bkjp87edxaIpo
   Aj9NzLBpFOj+hH0dUJKwofTYMfSgRI65Bg+MhgulAZGtnIg/5GuyqzA0X
   U8wemfH4hkLtQZbiAOiIDGwhxChBFq6dNvfrAordfi62syMedGHabTZbG
   IzEoRLV77EYtVeehyUc2zPFDc/6uWkZxt43v0jhLReazeOKA/Gu+6fon7
   w==;
X-CSE-ConnectionGUID: WRv9VspARS2HSxx64lzP+A==
X-CSE-MsgGUID: XuQ/ggAgQsCUQvdQShpAzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3077185"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3077185"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:05:08 -0800
X-CSE-ConnectionGUID: qlLm7GuhQQqzaOZ4ZNWGnQ==
X-CSE-MsgGUID: ySqjelIxTcy+TS5B6Q3oUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="10296625"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:05:03 -0800
Date: Wed, 11 Nov 2026 16:05:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: cwweng.linux@gmail.com, andy@kernel.org, conor+dt@kernel.org,
	cwweng@nuvoton.com, devicetree@vger.kernel.org,
	dlechner@baylibre.com, jic23@kernel.org, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, nuno.sa@analog.com, robh@kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
Message-ID: <avR2DaxSJJwpnWP9@ashevche-desk.local>
References: <20261104091136.151269-3-cwweng.linux@gmail.com>
 <SN1PR12MB2528F7F6F04801AB698A5A60A5712@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB2528F7F6F04801AB698A5A60A5712@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 08:08:03PM -0600, Victor Chernyakin wrote:

...

> > +	if (!num_channels)
> > +		return dev_err_probe(dev, -ENOENT, "no ADC channels configured\n");
> > +
> > +	if (num_channels > MA35D1_EADC_MAX_EXT_CHANNELS)
> > +		return dev_err_probe(dev, -ENOSPC, "too many ADC channels\n");
> > +
> > +	channels = devm_kcalloc(dev, size_add(num_channels, 1),
> > +				sizeof(*channels), GFP_KERNEL);
> 
> Couldn't size_add() just be regular +?
> (Question to Andy who originally suggested it)
> We've just checked that num_channels is small and won't overflow.

While that's true, the other aspect(s) of this is in play. Namely we want to
have the same pattern over the kernel that makes code robust (tomorrow some
cases can be modified unnoticed with opening such an issue again) along with
the potential of finding those patterns and update in case of mass-updates
of low-level API, and I have heard for the matter of fact that devm_*alloc*()
are in the plans to move to something like k*alloc_obj*() or k*alloc_flex().

-- 
With Best Regards,
Andy Shevchenko


