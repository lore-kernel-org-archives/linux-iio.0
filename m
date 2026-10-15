Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B091D63E4;
	Thu, 15 Oct 2026 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071165; cv=none; b=rbDqN7sCmk5gyMjQDdEtALRcyXHHK0ytNZb+1/pwlx2LBOZqLtWRyES8hSiTYp5pBKq5oOILtSN0ginejwm+ndzdwHHAk9kLfuZXgsrjtJeG22+4Oqmon1KxcdIih4Yz02gwKtYHzW5MpTgNDg2UZ7pbdByV4zX3ip8xHsBF+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071165; c=relaxed/simple;
	bh=GaY9nTD7rjLfIDii8ybCKnP1cAKGM1jIg8m7FGox+4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mP4HQtW5lEtZ83WcaWoWGloNJUUZSZ0nfq5THE0pOk8/vS9rTzuqoohMeiu1midhiDqy1bmAPWKv3HCayy1+3Em2Hmpd73caC0yYoaKn63RUOw5u3wIxXKu03euzwNECmyg5RWarp1f6bdbS0DROC3fqJ5KVRfmlDNCsOiOat4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfJaZ1Yv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfJaZ1Yv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792071164; x=1823607164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GaY9nTD7rjLfIDii8ybCKnP1cAKGM1jIg8m7FGox+4A=;
  b=HfJaZ1YvijJx4FQ3Q8b94JWXvP5eoV0sxCAgYsumY86LXuM7DEXfDUjt
   xUWk8wcRC903UUHJoO+sgJGISYEZwiqOn6oDWhFFltydKBfugRhSWEUjp
   x8Kny8Gbwevq5HuUV7wRtEoFmeVea9gnsEwqB8yNAnnTCedn1k38In2A/
   xKAMUy4AuGcHcj2yRfALwPi9/CwFga1raK7X08fqJXOi2XpRf03YAzFgN
   iWtD3LU10WyiizN/o9hfNQOoSwxEKHIFhbdSJt/wKesjTYhv2HZRhvfTW
   An+2+3jzVg+yN1Z6RvH/ZIum5wO/g8iRrHjHfSuKT+ptfcjCs1woEuat7
   A==;
X-CSE-ConnectionGUID: PPfcF+rPSMq/0jrAN9v17g==
X-CSE-MsgGUID: lBNDvtZRSZGyUZiicW3vEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="738886"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="738886"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 06:32:43 -0700
X-CSE-ConnectionGUID: Jjg7omm2R2+jiRA787xeQw==
X-CSE-MsgGUID: yMc6SDX2Q9uqTyijbyKgmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1789320"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 06:32:40 -0700
Date: Thu, 15 Oct 2026 16:32:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iio: pressure: dps310: add Zilltek ZTS8032
Message-ID: <atDV9RvEocWjlicZ@ashevche-desk.local>
References: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 15, 2026 at 01:49:40PM +0300, Paulius Zaleckas wrote:
> The Zilltek ZTS8032 is a register compatible DPS310 with two more
> pressure calibration coefficients (c31, c40) and a different TMP_CFG
> layout.
> 
> 1-2: Vendor prefix and the zilltek,zts8032 compatible.
> 3: Per-chip data in the I2C and ACPI match data, no functional change.
> 4: OF match table.
> 5: ZTS8032 chip data: the coefficient count, the TMP_CFG startup value,
>    and a Horner step each for c40 and c31.
> 
> Based on iio/testing, on top of a22dc7ebb21a ("iio: pressure: dps310:
> fix overflow in pressure compensation"). That fix replaces v2's patch 1,
> and patch 5 extends its Horner evaluation.
> 
> There is no public ZTS8032 datasheet.
> 
> Testing: ZTS8032 on an arm64 (MT7987) board, the series and a22dc7ebb21a
> backported to 6.12. in_pressure_input matches the datasheet formula
> evaluated from the raw and coefficient registers to within 1 Pa at every
> oversampling rate from 1 to 128, and TMP_CFG reads 0x00 after probe.
> Every patch builds without warnings with W=1 on x86_64 and i386,
> dt_binding_check passes. I have no DPS310, so patches 3-4 are untested
> on one.
> 
> An LLM coding assistant (Claude Code) was used for this series: it
> ported the ZTS8032 support from the vendor driver, wrote the code and
> changelogs and the hardware test scripts, under my direction. I
> reviewed and tested the result.

I have a single nit-pick (but two patches might be updated), otherwise
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
for the whole series.

-- 
With Best Regards,
Andy Shevchenko


