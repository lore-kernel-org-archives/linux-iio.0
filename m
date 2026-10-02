Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F04A2047;
	Fri,  2 Oct 2026 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947101; cv=none; b=qY9jxjljPLQJ0Kk7wHI9rOLxbBbFaemRFMMLzc3Y9SfZfIUbHAKWy7ndUiRLTf80S3seVFFdl4dAsHEf3Myknkz14Ivy2N62Md6Vnt323qCX2tzycVRHsxSAr+aCp//+4cjqeaYoU0oIlQAqcON6PpRSqr5/N/BLaqXzTnWBNLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947101; c=relaxed/simple;
	bh=8Em+JywnGV2v3UMj4eZhD/X5dnm53SlRF/7e/3Zguik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYZZMgxmUo88nEEeK4LxGhcFxXIYC3WEjCDnMKiX8cF7SuOKQjKuXMhBzmhoDVfXH+fH/v2a4MHzG/MbMXdv6gzvc9z3x05cLvtgepJA1QJVTc3AZV+i6p4/G0nNqoOKRl/qjfnRiDygEapiMmWqvmotwPKmTMhuGYJ6VH18tFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1jlDV3O; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1jlDV3O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790947099; x=1822483099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Em+JywnGV2v3UMj4eZhD/X5dnm53SlRF/7e/3Zguik=;
  b=G1jlDV3Oz/q20CEnDgmH1PJswwMK+99DVQa5oafB+g0yg4ofy5vw/H2O
   Bs9GTh5bjcEnXp6lcw72tE/tKYjKMpoVhCOwJ27cuaTNGCP4Z3BQm8PQy
   3blT6BeJsQfocrf8tM02KJ/3Qp7lc5UwpfhlXeo9K90IT6lrHKtwkDKig
   yY3OhorGhYinMo+2B7dIxNdDN8LWIm4rK22xaehHne5vExUf9jZkaIa8D
   /TnEdDcmkw5DpM3Dp2QgLVC1up22sFSS4G/KxNJBetqwSgESragUHPopp
   0T4fubObD5Zcyz+wOQDSdUXHNa9CnngTeG+addSFpFIECrHVRdn51XZY2
   A==;
X-CSE-ConnectionGUID: ZKXn686TSaSJyVRYN0E80w==
X-CSE-MsgGUID: tTkVmitHQ6mLo6x0lFAlsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="102286597"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="102286597"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:18:19 -0700
X-CSE-ConnectionGUID: +kquUBdfQweoFvkQ0U6M4A==
X-CSE-MsgGUID: RapThUHGRSOKNe4rVQmGsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="284307292"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:18:15 -0700
Date: Fri, 2 Oct 2026 16:18:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/6] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
Message-ID: <ar-vFLFy1JhquDga@ashevche-desk.local>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
 <20261002-b4-inv_icm42370p-v5-6-c65281b745c9@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-b4-inv_icm42370p-v5-6-c65281b745c9@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 01:54:30PM +0200, Kanak Shilledar wrote:
> Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
> registers are stored in MREG1. The calibration bias is written to
> OFFSET_USER4 to OFFSET_USER8 registers in MREG1. Reject the out of
> limit calibbias values instead of clamping it.
> 
> Note: The accelerometer functionality is tested with Invensense,
> ICM42370-P development board.

...

> +	case IIO_MOD_X:
> +	case IIO_MOD_Z:
> +		offset = sign_extend32(((lo_val & 0xF0) << 4) | hi_val, 11);
> +		break;
> +	case IIO_MOD_Y:
> +		offset = sign_extend32(((hi_val & 0x0F) << 8) | lo_val, 11);
> +		break;

Why do we have hi/lo and not proper __le16 or __be16 type for that to begin
with?

...

> +	val64 = (s64)offset * 5LL * 9806650LL;
> +	/* For rounding, add + or - divisor (10000) divided by 2 */
> +	if (val64 >= 0)
> +		val64 += 10000LL / 2LL;
> +	else
> +		val64 -= 10000LL / 2LL;
> +
> +	bias = div_s64(val64, 10000L);

We have DIV_S64_ROUND_CLOSEST().

...

Overall, the feeling is that this is cumbersome change and may be split to
smaller and more isolated logical updates.

-- 
With Best Regards,
Andy Shevchenko


