Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB9C35F16C;
	Wed, 22 Apr 2026 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841296; cv=none; b=Co9OsWBwGnse6UYX1AhTe3c1Z1U2bue7stuEg2sUDYDniEfeu0Uv1qyHQJvVQdTCUWcH7RSEiwOupKqOiCY2nrvq04QBHxpeyXhpSr8ydQ08AbHLjwl9jyWjYxZdSIkWJfTsCYqszYA10YaSrwGtsRCHGxT3Z/AtYxFPB08bKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841296; c=relaxed/simple;
	bh=Eq07V+zfWqVRa6RmbAXl5Dd0AvrZkfOyaIk7w4zBwPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baz1XLtUdg4lIAAZx4elNgndzGqgxGQRuYBSxDC4FyIQxKUfd/ZSfl80dm246RPoGrW5KXdYVXdsSfvsCPXYu3h1wMmH8fRjVw4pChSDf6W2myc5MhvMPmJlBtSVqltnjP54S+yWFmjCDlm0grwUnE7sG8VZAgeUf7aBI/PJBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XoNS0o7Q; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XoNS0o7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776841296; x=1808377296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Eq07V+zfWqVRa6RmbAXl5Dd0AvrZkfOyaIk7w4zBwPQ=;
  b=XoNS0o7Q0rbmUId0sOYxn+AudiHC28a7GukqWvpPNmu8Jg2QWD7U8U2m
   Xn/1+v50r0cs6ogPW1CVo7jVZSZXicwAO7RP+Q3evZUcPdYQ2fS4uG3r1
   crOZkVwzgyWKfJZRiFLXcPUhMHhUZPUeiTvSbPdxkgDkpX6o8xTx8wM00
   QD9WLjeafMgR2SZlidFJnjE1NWI7x0wQ/0ffWQyhOn9Eik7wgTMuN7dqK
   vSO0l8Bb0GkqDHfhkg0ZpmwrcxWXnI0MWhJ5o9D5epN4dGMovTUvxtuVK
   y+Ni63pBIJrxLZyuVikwMnlZT2pB4AS59wFHlUE9ICPrnrp0EkO5QyQl2
   g==;
X-CSE-ConnectionGUID: B7XrFmmURUmZ3548l5FrZw==
X-CSE-MsgGUID: naThqLWjQvuE9qm8iha6fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77769805"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77769805"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:01:35 -0700
X-CSE-ConnectionGUID: d7YVjXZKTUSKgKbKot8f0Q==
X-CSE-MsgGUID: GDtE1WoUSXu11Wy8yxCoUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="237310268"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:01:33 -0700
Date: Wed, 22 Apr 2026 10:01:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: proximity: srf08: Replace sprintf() with
 sysfs_emit()
Message-ID: <aehySuvx9XLW0FoT@ashevche-desk.local>
References: <20260421213526.14867-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421213526.14867-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 04:35:26PM -0500, Maxwell Doose wrote:
> Replace sprintf() function calls with sysfs_emit() and
> sysfs_emit_at(). While the current code is fine, sysfs_emit() is
> preferred over sprintf(), and will help modernize the driver.

...

>  - Changed sysfs_emit() call in function srf08_show_range()
>    to be on one line to resolve issues around indentation
>    alignment.

Wrong. We assume 80 character limits unless this makes readability suffer.

...

>  	for (i = 0; i < data->chip_info->num_sensitivity_avail; i++)
>  		if (data->chip_info->sensitivity_avail[i])
> -			len += sprintf(buf + len, "%d ",
> +			len += sysfs_emit_at(buf, len, "%d ",
>  				data->chip_info->sensitivity_avail[i]);

Still the same issue as per v3.

-- 
With Best Regards,
Andy Shevchenko


