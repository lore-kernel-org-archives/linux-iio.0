Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CED3612F3;
	Sun, 10 May 2026 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778397722; cv=none; b=P844wI9ndDcKRXRYX8UpMiVH497V25c2s19v58NecNTkOumazZxYbKciFeGB/1B66B8YW3oDOB7vjuWiHLxMzLEinp6FUeBtsqFU7acckT3iblq8M3t72WxsWEn55C6AOJ7NFG3CcBDHLG80mnIDZ33JL35W4iddy57YsJxsNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778397722; c=relaxed/simple;
	bh=X6Ohwci+7bA9dzyD49jTbWZDKvjfbxH5eZ+bW64MAiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmZdMgvxossionYH3PkIV1iJmas1rr3b06SNd7svr/1NzccD6VT20E5WDSX94Lwl0uncmYRPtwf622NcLuDu0oVzP7aQgBuOzJMcrLvB9Noc3ESUKPFHYaZ0zyea7wPRvXGlQo6xubEZKMa8yI+N7g9/PI1AGKoEWHXJZO8JUvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2W6OA4p; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2W6OA4p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778397721; x=1809933721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X6Ohwci+7bA9dzyD49jTbWZDKvjfbxH5eZ+bW64MAiE=;
  b=b2W6OA4pCKvCW8+X5XnG3dtAHoZ9SwWqC3MZ8JdeAf+qnebMooSWt+5G
   zZfBtKa1BKI6fR31CkQ4nkkPYE7TpW3ZqvLgqWvYdRg5+zCjbEHlegXZz
   uQVzSsEJFv41ZfM6IzK/CA3D1fmejffrQgLPqIAw3iYTMUpRqiJQUyb/F
   wJXldvaDwbCvAmFeFSKD9YJUmfUOgI/JFQHKnjMeDeGaa5nii3OYTFN4O
   sLHnCH7PIoM5Q+MfGv+smkiVUX11l+Bo0vOiIHwprO7mQoD3Zi+qua2tE
   gT7w9CpXfOzXXQbNmljZ1cOWA2tGdZGYC0fBkU8DDyK5AGp/jDP2jIfN6
   A==;
X-CSE-ConnectionGUID: bbpIl2mIRC6oiHWu8cB3Fg==
X-CSE-MsgGUID: r0ArOajSQB2bPOm5IgiX5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="78455049"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="78455049"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 00:22:00 -0700
X-CSE-ConnectionGUID: tTvJ6Q6aQgaCnKz/gtEHUQ==
X-CSE-MsgGUID: egebsdvJRdKi15ZtCSuchg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="241143924"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 00:21:58 -0700
Date: Sun, 10 May 2026 10:21:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: giorgitchankvetadze1997@gmail.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	m32285159@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: chemical: scd30: make command lookup table const
Message-ID: <agAyE9IsNM6DJuwr@ashevche-desk.local>
References: <20260508133915.22042-3-giorgitchankvetadze1997@gmail.com>
 <20260509111634.21700-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509111634.21700-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 09, 2026 at 04:16:33PM +0500, Stepan Ionichev wrote:
> scd30_i2c_cmd_lookup_tbl[] holds the fixed CMD_* opcodes and is only
> ever read in scd30_i2c_command() (via put_unaligned_be16 of the looked
> up entry). Marking it const matches how it is used and lets the table
> land in .rodata.

I believe the above is the suggestion on the correction of the commit message?
Please, make it clear!

> Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>

-- 
With Best Regards,
Andy Shevchenko


