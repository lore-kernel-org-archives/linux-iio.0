Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87FB32470E;
	Tue, 16 Jun 2026 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606640; cv=none; b=CJSXBc9j1+0oQswV6D9g0GLbUUNxGn6XqD4ftasbCRXStD7T6VT6gPjgQn/C8MReCXwq5si9JoAmTP7HMeK24vcN+NMjFq0EV85nA7nT+IusT5Sz5lnJ6Unm5bKhx6U/YaneHDKtioDPF54J4Aqj2JOohgk/gb67hxDkeW0B8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606640; c=relaxed/simple;
	bh=or6ka08HTdTIL7tQrOrGRK1iNdKlRkBhHzeGjcqAPX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=relE9/vUMi7UeC54jNyI1EqO/DQZ1CSJD19y18jVsZ9ea2eIIr+IWAWaplx9roXkIYbAUz7a2WPdNrba90WgRhJr3ARCAEOvBfaBB28GROz0cD68Y3U4UPHRCEikV5cg/TyJbXdgMUmFaYogwb07SJK06G1A2FjfL8ldxb2ReRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCqbdkQg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCqbdkQg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781606639; x=1813142639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=or6ka08HTdTIL7tQrOrGRK1iNdKlRkBhHzeGjcqAPX8=;
  b=cCqbdkQg4kMg+hofgI5P0TKwpuj1Y6fkHSp34AJy6TwnqUaXXF06HhSN
   /xL6oDtuaC3zyytcHC0LFThG29LZh4lH4Aq9Y7UXGjr/OLA58QgV+F2zE
   7z3cfq217Wp8/B7m/QkYgNywVTrJxqs1xn63b5OboRgow3lU+tfCFNfPj
   doPeA896jtnWC6oZTblXsUieaEBCoYf0Wu2z7wH4kS9MZGvfsDKEJBFvq
   +YaA6rd7F6lwfMdRzxNa3t6on97eI2taGeXsrAKIeEHRsH2WaY3Bm6w+z
   J1UvydJUi91+bVJ2/gp7pgZN671jCnWzIbBKKGQfmpG6S6gR7NWzIdgL7
   w==;
X-CSE-ConnectionGUID: Q7V2vDugQwWS/spH0m1jkQ==
X-CSE-MsgGUID: G8OmHLdlTGiJKsIVqU1eQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="84932254"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="84932254"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:43:57 -0700
X-CSE-ConnectionGUID: gwpn4hzLR+2ySJ4i/93kZQ==
X-CSE-MsgGUID: Li1AE4dwQgOWqMCWM2iznQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247802515"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:43:52 -0700
Date: Tue, 16 Jun 2026 13:43:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v3 11/12] iio: dac: ad5686: read_raw/write_raw: use
 guard(mutex)()
Message-ID: <ajEo5pOp3ElX4cP7@ashevche-desk.local>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-11-f829fb7e9262@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-ad5686-new-features-v3-11-f829fb7e9262@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 09:21:17AM +0100, Rodrigo Alencar via B4 Relay wrote:

> Use guarded mutex lock to facilitate code review when adding new
> attributes. This will allow for early returns, avoiding error-prone
> locking and unlocking in error paths. This also adds missing include
> linux/cleanup.h. Gain-control support will allow the scale attribute
> to be configurable.

What about interrupt handler? You just added yet another mutex lock/unlock
there. Perhaps this patch should be done before the previous one?

-- 
With Best Regards,
Andy Shevchenko


