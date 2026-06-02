Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F813A3E98;
	Tue,  2 Jun 2026 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428023; cv=none; b=sp1dhvjTz6EKjV8DqZgKOPIXo2Qs7uPpjPgpFvTefllURYjTopa2C8EhGecj2J1rVoCyWeKxkmuBdAEtZNyG0WcBHldQMGEpF3FxqBWjz6QK9Wnx7OaLedX+5Om3nrKJ9D89HS41BIu1f1cPYXqgs3zF9SWxoVlqQHV8Zw/i+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428023; c=relaxed/simple;
	bh=3Oik8/6wlJ8nANZPQZ/zclha0jX90ArP0XgyL4YgAj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWaMyn3BEa2cRXqVcmJdQtmtDXA5v51NZT2mXSXBmL10kp0lF4KBw2C9X9H1b2LEx5FbZT2KPVPy8ti/TZq191tKm5iT40rmzcIRJCfz8REZ4Y7aMBiNIQuPc1ErTUJcDvJN58zhYHxwzUIihFZ4W3Ly/QXcnTXmyTO4Odaudl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGfv10t/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGfv10t/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780428022; x=1811964022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Oik8/6wlJ8nANZPQZ/zclha0jX90ArP0XgyL4YgAj8=;
  b=NGfv10t/DRJEhYRgKoDd7aSnpQMuzHyReoXOJrSixETTI8nsG/VZSB2r
   U6t2+LQYx5CspfjoFAGYudBhMLBvfwsbQnXEHk5rLCBOJa1zBsfsxmZBA
   ZzQTWFgCBP+lnXoBELvyRt8TAnFjDGiP8nxiFXc+jRadWjudios/RPK66
   48UKIER9rK4vlusDJIrsPB2EQJVIVjTAmSOIGt9kbhCwrAXKDQb9nbNQf
   fLzp85zCCob6xRtChbeJk5NB+ClX+5XnKZbMzofuNa6C314QVlnC94zhH
   SdotUQzNFFZ+CoF/W9YArfPX9vwPqnGenmsG8lXLXdMr6fECzBtFrci5q
   A==;
X-CSE-ConnectionGUID: T2MWF2kVTGGJ55OirCqEDw==
X-CSE-MsgGUID: ABTzOGHlSHSKObNpkoKAmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="85080859"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="85080859"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:20:22 -0700
X-CSE-ConnectionGUID: LC8TOjOJRm+xCBDRey0eDg==
X-CSE-MsgGUID: XoyiKCgUTP+u3uVU6yw1iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="241016841"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:20:18 -0700
Date: Tue, 2 Jun 2026 22:20:16 +0300
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
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 11/12] iio: dac: ad5686: write_raw: use guard(mutex)()
Message-ID: <ah8s8J4H0LcS2ZFs@ashevche-desk.local>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-11-691e01883d27@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-ad5686-new-features-v1-11-691e01883d27@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 05:33:58PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> Use guarded mutex lock to facilitate code review when adding new
> attributes. This will allow for early returns, avoiding error-prone
> locking and unlocking in error paths. Gain-control support will add
> the scale attribute.

You just added one in the previous patch.

-- 
With Best Regards,
Andy Shevchenko


