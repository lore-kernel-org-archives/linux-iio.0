Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41226B2CE;
	Fri,  6 Mar 2026 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799372; cv=none; b=LNOXLEnchFgmFhsG26gMb3DlCTd8RuJfJ9fEjKokSJADrHwn68dNEwKsP9bfjicG0LDE8ZLMltdI6MUb3oGsAVd2YICnxXHkxx9G9PYU/MPvYpgaK2k/e+UqaMqBIPkA3vIkNcQPSMqOpBjFviruooIxkE6noC9ji8BaLwq6PqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799372; c=relaxed/simple;
	bh=3jjumFtShjLylI3IaQ9V+LM1tQVGq6axCHWL1aCsZyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX+dBv3XvTBznrwXci/xP/jljvABR+tKklyPzYILqTuMAp0LW4decPijDCtcGPNpVP1OsXR/PpiFXoLIXxwFUgYJPBRulj4cIBbfs2hk/C2p9SL+7IsoXy+DkA9KO/vGRZEaYDyb6LgRCnHvW1qmL46H6/jECgsvh6x8WJ5MViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrDnrKCB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrDnrKCB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772799371; x=1804335371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3jjumFtShjLylI3IaQ9V+LM1tQVGq6axCHWL1aCsZyg=;
  b=HrDnrKCBm1I5wgz04W86qk8oIm1ic4SIxqdhbXSbsO/Mr9nR2ULFNkYw
   lS9RfXfoTLeIhl80PjnNVoDSsPONaxyKDVmv4vAQuB12auQAwWjNo+Z3o
   YeAyFti2c6UKKWk+YVSuvPf043SRiyS5Z7dU+th8+PXNISspbJrO1pb6N
   CG2UN417oV5Bf27aH62frgxSBq5SThI2P6d5uqYD6qJMhsvoAsSZGWUQh
   G5icOwkxL9xRZT6FtCRpKB1sqzoM7tgK41S4AyVmKS6MoIPkr+AOPDqRh
   TO7uk/N/Idp6FvO0QbgdzHyYqklWp+AZmQDxGN2rAvwCsr89pBCuF61AD
   A==;
X-CSE-ConnectionGUID: x9b6fBBNT6SAM6kKIEiNnw==
X-CSE-MsgGUID: AvJLoaUlTrevp2LJiZ0Nhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84616449"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="84616449"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:16:10 -0800
X-CSE-ConnectionGUID: oR9dHS38SBugEi6PzXzw1A==
X-CSE-MsgGUID: 8xZu2IkPTnKG9CcMEtsFDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="218942309"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:16:08 -0800
Date: Fri, 6 Mar 2026 14:16:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: marcelo.schmitt@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, mazziesaccount@gmail.com,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org
Subject: Re: [PATCH] iio: adc: fix spelling in comments
Message-ID: <aarFhdivR6XAhbAm@ashevche-desk.local>
References: <20260306062107.51886-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306062107.51886-1-i.shihao.999@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 06, 2026 at 11:51:07AM +0530, Shi Hao wrote:
> Fix incorrect spellings in comments.
> 
> - informations -> information
> - specifc -> specific
> - avalable -> available
> - Digial -> Digital

Also this misses necessary tags. Please, take your time to study Submitting
Patches documentation.

-- 
With Best Regards,
Andy Shevchenko


