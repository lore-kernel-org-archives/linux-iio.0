Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371294;
	b=zm+QVmQJUov69gJPUSyOMJHmVXQE7x8xxeyIxOTwJfkDQ23gkI5hABoApaVa/ql+Ibfk
	 WxJ85/KEti9g8Tln3FK2wKFE1uzUExFUDzk5eTO3gm1jDN4T6fwlLOElyRhbMUpI342eo
	 I7j0hDYuC7sKJV90RzrRrkLb1g1TaPD4dch5KhOcl6BTMI5hSPmbx5pXVc4HgrysYsjLV
	 7WtU8oLyckmeFWv24M7FfEAkuYAvjN7iIn0IW/PFOGZ2U7NEwSuB442f/RMrk1c5mQ4u/
	 av8+QxJVqhLLOOk4TdoD+zz2m2kqPKGjOg0a5uYZHuWQya+UQMR0H4ZRvjoAwkWk0WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371294;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=iGt6RSK7yWWj55giIGgQVyqxXAu4XvXBM5uzKbjCTkI=;
	b=isLvWe1xj7B8sYWbzFIOmF3LoNN4fOPi3LyHqcYlAyREfaP8Yzxqwqi8k+asm78p0fpa
	 qVo8d/rBCWQQHxUoXtfNEHvQZa2Xul9/Pf5uHF104J3qN9op+oD5Kwn3euhgYoXJTy7hY
	 QESLTKQYJBhQaS4pmbq6epvWvfy6PTnhX27M9kqK21jauTJvXXfgV1u2IPUkIIin8DZYZ
	 yDKXtijvfMTRk4ZYjFH94vWs5M12QCqojkuwfQ2VXA+QrH2kv1RSSYimmH8WTj12uCSsA
	 9W1q8/BCOeeZMZe1LKcbbFHfjPpt3g2idM0tQ5ZknzPr9doVv7IGYPIsBPlq8h3zemw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JAYwn9tM;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA80606A31A;
	Fri, 30 Oct 2026 14:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EA80606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JAYwn9tM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793371293; x=1824907293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A8iFghOosTD4Zm3Vh31UnlE/E9aYofFplatSiUbIcZ8=;
  b=JAYwn9tMiXM8RczKU26WtzookRi3zp0yP7LTsqi6vk+yJeHVCsmCQHU3
   Lk8URCHEgrFzkm8M3N+LYiJLxtCMAd/gV/0LJk77EW4mtpTr1nYMslm3T
   WkbYGonjgU9LEJ8O1n00s3Mhv2KwtkemhwQ0+GBKG4gTAaoghsVRzAS55
   NJFykB9FlGk+F8MH0wCQVzBd7x5adxuiU8tco7FOoPEautKI87Q9BxsqR
   CnuExKS/QzknUihsI2MIsr6D5C7B4eBkiWEWHkJ7m6OVbwbA7KL6eQslU
   U8Cx6GACCA/4QXJQ623qS/q+VvrM4pJBiHar/hqne9l2i6afoBzVEoPaD
   g==;
X-CSE-ConnectionGUID: /MCn0M1fTcOzOf9B7C7a5A==
X-CSE-MsgGUID: tkVtFpoRSLG1376lsfriDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2036854"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2036854"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 07:41:33 -0700
X-CSE-ConnectionGUID: A7+PJm9qRr+DudHh8+7fug==
X-CSE-MsgGUID: 7XZUW5h2TvWNZj4iep0niw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5792399"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 07:41:30 -0700
Date: Fri, 30 Oct 2026 16:41:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: sergiu.cuciurean@analog.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, ukleinek@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: add LTC2387 and ADAQ2387x support
Message-ID: <auSsl5_xQNXCNphJ@ashevche-desk.local>
References: <auDJu8u85flQ9bjo@ashevche-desk.local>
 <20261030100808.217874-1-Nicolae-daniel.Deaconescu@analog.com>
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
In-Reply-To: <20261030100808.217874-1-Nicolae-daniel.Deaconescu@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 30, 2026 at 12:08:08PM +0200, Nicolae-Daniel Deaconescu wrote:
> On Tue, Oct 27, 2026 at 17:56:43 +0200, Andy Shevchenko wrote:
> > Why have you written a brand new driver?
> 
> ad7625 is the closest existing driver, and it shares the transport:
> CNV PWM, clk_gate PWM and the AXI ADC backend. The converters differ
> in a few ways though. For instance, the LTC2387 is DDR on one or two
> lanes. ad7625 is one bit per clock on one lane. Also, the ad7625
> clamps the period to 100 ns (10 MSPS). The LTC2387 runs at 15 MSPS.

But these difference doesn't explain why you need a brand new driver.
Is hard to configure this at run-time by choosing the respective driver
data based on the compatible string?

-- 
With Best Regards,
Andy Shevchenko


