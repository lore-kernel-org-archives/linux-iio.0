Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D0371895;
	Sun, 12 Jul 2026 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783840349; cv=none; b=omH42MRYf7FNU7UUaQD4APVIo+9B6ZT1iPgqIq/C2EMGQT3oUl0cUcQ3x+h9cQ9SL2SP9H/BLLH0Z+WZFAsRnUWXO9nipXHkQn6/EkUOrhrQf2qLGfKt8g/+FA7czwds2OyYqh9/L0kVkMHR7kFmdiYVb6Y9T4tVxcjwhf8OGtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783840349; c=relaxed/simple;
	bh=HUvbhQSI2pkACRRnDTQtQx3sRVTCfAi0f6riIbBvnwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIq6ADOnmMww76y/kGGp68CNcKDfh/9T+srSLiH2uOIyur0e9iV/g+f6IIJfCd0y7GTDLgg8pX/cu43aIJteMv6NRFNqvCYmBm1eWENQFb7WSJWOmetrKRXyCiEhp6HOJib/urJBPVjQo6r9zVH6uZ8rdg3m8bPhMyeCN2NCFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzJT9XhQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzJT9XhQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783840348; x=1815376348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HUvbhQSI2pkACRRnDTQtQx3sRVTCfAi0f6riIbBvnwo=;
  b=YzJT9XhQRF5evrQIXEYkzSwa28Gxfzr91CkoCIL6uiOp9lfGrKTQ2wvE
   1RNwPwIG6KURJ7XWklqG/izvkH65GZJAs4ZOhtSWpwZycDUzYu+qcEnvn
   Jg3rjVyWV1ZgbYPwcxAjkaXSnNXEpZs1De5KXky94GKa3GsO9zg/Qiuvk
   xcKdhxoQDlAlCnor/RdK7mVAL4KSWLepkJ4m25a8PtAPlarOxza1me71h
   tpx4gJRmW1fu1q/N8wIwykhfXPMtnQxszP2JX0acp8BopXyOjUAtauyJk
   /kXxh8oOwoRHeb/tMzv88r6gFdeZITTFbzpFeeAvzJVguTZf3/nxIrY5m
   g==;
X-CSE-ConnectionGUID: 0tCoMyUzQ3GgAEHARgTkBw==
X-CSE-MsgGUID: Slh7eB54RZyb+hfspH07Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="107283556"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="107283556"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 00:12:27 -0700
X-CSE-ConnectionGUID: JsnhjSUkT3WmxdOwcyDYJg==
X-CSE-MsgGUID: k2sw0wAwR82aTNc/4BI7Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250846745"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 00:12:23 -0700
Date: Sun, 12 Jul 2026 10:12:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
	linux@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v7 5/7] iio: dac: ad5686: read_raw/write_raw: use
 guard(mutex)()
Message-ID: <alM-Vcg3Dg-c5KdW@ashevche-desk.local>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
 <20260710-ad5686-new-features-v7-5-1bcc8c280e4d@analog.com>
 <0b513d21-31e5-497a-9332-7efc3fd3e010@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b513d21-31e5-497a-9332-7efc3fd3e010@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 11, 2026 at 10:09:51AM -0500, David Lechner wrote:
> On 7/10/26 6:20 AM, Rodrigo Alencar via B4 Relay wrote:

> > Use guarded mutex lock to facilitate code review when adding new
> > attributes. This will allow for early returns, avoiding error-prone
> > locking and unlocking in error paths. This also adds missing include
> > linux/cleanup.h. Gain-control support will allow the scale attribute
> > to be configurable.

...

> > +	guard(mutex)(&st->lock);
> 
> The commit message should explain why the location we are taking the lock
> has moved. Although, I don't see a reason to move it.

As I understand it's a compromise between simplicity and extra expressions that
are appear under the lock. Since it's mutex and not a spinlock, and the code is
not an utterly hotpath (something like very core kernel stuff), I think this
is okay. And IIRC there was even Jonathan's suggestion to go this way (maybe not
in this series, but semantically the same situation).

So, for the sake of simplicity, I am fine with this
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


