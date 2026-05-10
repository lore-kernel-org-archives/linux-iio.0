Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5818A19067C;
	Sun, 10 May 2026 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778397134; cv=none; b=M9Vu4SUFxJvBfuSoEkROlnOIqxt9i3kxyZY4ar2Sxj92Wbed8g7u8fnU/OuCRfEQ1ugHbMYDpQjp7sy/fkNAwC5BWRaES/znYCqbWHYOxj7J2ffyb7CcTDeiQqT+Rb+65I9srCC5NkDKrW5xRkJVXfVEACiTLx9Gst0E2kpJv68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778397134; c=relaxed/simple;
	bh=EdKN1iJ0uONPpFGCPQX4f6SAqODmUE2IBp0NHAgn/ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6mug8hBdZF9mJDRXmee+1051BrvISkR/tWhWofGY1vSOFHoIS0lLq6BCvYV59yDVDrtxfmao3SN4VLclEaEb7NA6mUofPbTWgKovlNeGVEfmAQ80gd0AOhf92DbXN7RZ0yRIkvceNF5JKQR61sIpZhNkCblrLhH4rFVkyHlb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUtnnT0C; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUtnnT0C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778397133; x=1809933133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EdKN1iJ0uONPpFGCPQX4f6SAqODmUE2IBp0NHAgn/ok=;
  b=fUtnnT0CXSANCqomQb0/VEFqGmGfVm2BmgErdj4zjaxvIf27rqZCzJyU
   hprIrjjaZWx8zjfX8+haR/9g2DJu5wDcDsxOsHQjmma5JJfoMXpeflm8t
   4dmKF84Zl/D88GHKQa4UZc7A57biTO5Ua20KBbgX88mDRHuoUFDv/dZAY
   WpWrVRXxVMIy0maAAJOdAu9tyZv/gh0+Cp2lgtAxqUhE3YoKJKihNWagO
   aa/Aw35JVRTgk3B3T+5H0SF7ULVUdEahCN0Ia590VLtUpteCoebssya4R
   lUVhj+Rbyx8RnZJJV8/smIavPjKVrmfhZE2AdeNnpk6f7337Z6bNKaNYV
   w==;
X-CSE-ConnectionGUID: 6KvT1KbhSfaQEbmR6cuf+w==
X-CSE-MsgGUID: ZE7PxEi+T4ukWbbbWL/vZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="104773291"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="104773291"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 00:12:13 -0700
X-CSE-ConnectionGUID: onAgApP7TrGIUw4vA3GN2w==
X-CSE-MsgGUID: 3jNtao7hQo6AucHY5F54bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="236198473"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 00:12:11 -0700
Date: Sun, 10 May 2026 10:12:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"open list:PNI RM3100 IIO DRIVER" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, tduszyns@gmail.com
Subject: Re: [RFC] Maintenance status of SPS30 driver and related Tomasz
 Duszynski entries
Message-ID: <agAvydze87mMLaVC@ashevche-desk.local>
References: <CAKqfh0GxasvVEMVySviw5vB1QmbNF-RKBjuoMD9ffEtnQjDkJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKqfh0GxasvVEMVySviw5vB1QmbNF-RKBjuoMD9ffEtnQjDkJQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 09, 2026 at 07:14:35PM -0500, Maxwell Doose wrote:

> I was preparing some other patches for the sps30 and scd30 and
> realized that Tomasz Duszynski (whom we've already considered
> inactive) is still listed as maintainer of the sps30 and some other
> drivers under a different email. I sent a patch for the sps30 and
> while his email didn't bounce, I still have reason to believe he's
> inactive as according to git log --author="Tomasz Duszynski", he
> hasn't had a commit in a little over 3 years, which means the drivers
> he's maintaining are essentially orphans. I'd be willing to maintain
> them but I just wanted your input before we consider anything.

If email is not bouncing, let give him time to response. If there is no
response in a reasonable time (usually up to month in the summer time
due to people usually have long vacations), then we can act accordingly.

-- 
With Best Regards,
Andy Shevchenko


