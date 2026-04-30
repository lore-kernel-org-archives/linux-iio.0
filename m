Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BE026A08F
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 06:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529497; cv=none; b=SdjB6Hjedxboq0mbF+p/dpD+4X562zX6f9prvFK3M9PqP+IhZLHPj+4w4BxXRUzviwNf0a13qDs4NYcBJRnmg/zdKoracjVuNnqS38gd81xos4Nq5uI8Y+fvHxxoskIk879MZgN0oME59jxeUhVxsTbpaIYZhOQq8lFGs/PhL2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529497; c=relaxed/simple;
	bh=8YqUw5rwqE7Auha+zRr9HiGqGyGqRXBNZI8fpXNnFBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKZA8aveab0e9tBx+TEcFKuSHGunOorn0MtcSeTF2KUjbtQ+Z//5RLz5FHobpsip4N3qRU73yDJDzrJNno8EuzzkNL672rGMgUrbUPAcA/KS6G7s7aDXdVwVy4zwHUQoTmMaVHGrPJVlvCtlh+LZL3hE6eMiPz2HSSyrp/3H0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPiM2Xzd; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPiM2Xzd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777529496; x=1809065496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8YqUw5rwqE7Auha+zRr9HiGqGyGqRXBNZI8fpXNnFBI=;
  b=lPiM2XzdwPC6K3/n7/2ebIxcqfO1toILZsI/5Rrk35e/+Qhy56o9CnbA
   S42/orSfPdxgcuezTgCwkMspRl9j8NudlwVJUPWn//4IQzNdna9y2rhlP
   Uv8HftXK/yKU5/kCrU1sK9VfSwBxckjRrQv3tPYwfNOs6VMKObAD5+uvR
   Ndg+BWi3YnKLKy/gAzBCWNOMrYIbZjQPNLT9/bnea5dmSgYHHNSZ0jjeA
   13CyRVGBNHO1h45tXY/Jt1vHlMDu3dWs/IkYlbNYgn0dmUgG2kAXXiEGx
   OKZ2lmJDGfbKHELzAoBK7yhiiAYAyMsiMXZ6eB+ucwFr18DEHAbbgfZLF
   A==;
X-CSE-ConnectionGUID: 4Nr2RnhwRY+GJD+7yfRJrw==
X-CSE-MsgGUID: odNAq6rLT323vX09P8FS6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="77498087"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="77498087"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 23:11:36 -0700
X-CSE-ConnectionGUID: molH91g/TF2Rum7u6v4nVA==
X-CSE-MsgGUID: +FqjtL0vTTW6jLW4lIXHNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="264859727"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.244.42])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 23:11:34 -0700
Date: Thu, 30 Apr 2026 09:11:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Machado Lage <marcelomlage@usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	nuno.sa@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: adc: mcp3422: apply bit manipulation macros
Message-ID: <afLyk-kNyZkr_drR@ashevche-desk.local>
References: <20260429224401.11818-1-marcelomlage@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429224401.11818-1-marcelomlage@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 07:43:59PM -0300, Marcelo Machado Lage wrote:
> This patch set rewrites several open-coded bit manipulation parts of
> the MCP3421/2/3/4/5/6/7/8 driver code using bits.h and bitfield.h
> macros.

Both LGTM now
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


