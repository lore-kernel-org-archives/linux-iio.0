Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3499D371891;
	Fri, 20 Mar 2026 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994514; cv=none; b=NqoGn4UAuaMUyJfcpp70w0D92tVxQHqgz15SJgmxwTqjuJ5xMRtEarGTlgO+UgGbn9z8KAW9smK9UJoZyR1nkdB2WRMiPdiBgyvpybuFhHh3sVT8XgZpX5RBRMlg9Yank5XX8flSNSSxKJEVtNH4Mo/03IMQqU24JOzLRKs+lNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994514; c=relaxed/simple;
	bh=J/EXr2g8Wtv7A5OElR48HzkyIMY15tXfQiLYngWo0qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIpAHxRpKSq5JihQUlxwLHm+WFwMhuhtKzi4eQSlDnzbEMjUnopokWcEyzJZyoz79vDr518noUlDh4+xOv73PtH46583dceBm/IgUuZ+2RSh8X5RhF6hdY04be0gm6zYhzXjg7jL+kJ+m1ujfZ90CJxM1tiTCIQlNUpFU/Z+u9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVJjaIuv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVJjaIuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994513; x=1805530513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J/EXr2g8Wtv7A5OElR48HzkyIMY15tXfQiLYngWo0qA=;
  b=DVJjaIuvNkXStb0Acb6BpF016DQKIxvf4nOU5NuyCJ5REzqVSuZtB4xZ
   PycpekI8K+GTN+Xvwhg3PVk/OUxb15KOXMKENQjaEOpEvXTcldD3FPf4b
   BcgWOS8hKBxKUPbozxAr/NpyN8u8ks5v4D7K+nT7OK/FxWdg7u3OpGKAj
   unUHSPDuQ1TughVXeFnvZQOXadZKFopPo4rFo7E6BlsSqX2OGLvhSo8uy
   oaIZh/mqobQRRonJXvt8bbPfWXsxmNZFwpKjv7NvMnYLI99dZFHj1dxEQ
   kxQDVFymkC7sjit9qIMe/Y9ZfXQNM9RM/r+dIIb/I4VW50PA4Yz0+poZk
   Q==;
X-CSE-ConnectionGUID: qWCZKdSKRfConmgJdbcb5A==
X-CSE-MsgGUID: d4UoWGBEQSa92i0/ZN+7/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="92650188"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="92650188"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:15:13 -0700
X-CSE-ConnectionGUID: RdppAK3aQsaOi2mH6A5aug==
X-CSE-MsgGUID: 2pdH1PfOTP+IPGJH4tVpHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222445688"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:15:10 -0700
Date: Fri, 20 Mar 2026 10:15:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gabriel Rondon <grondon@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: iio: ad9834: use sysfs_emit() in show
 functions
Message-ID: <ab0CCzsu_nuPhSx7@ashevche-desk.local>
References: <20260319225719.73587-1-grondon@gmail.com>
 <20260319225719.73587-4-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319225719.73587-4-grondon@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 19, 2026 at 10:57:19PM +0000, Gabriel Rondon wrote:
> Replace sprintf() with sysfs_emit() in sysfs attribute show functions.
> sysfs_emit() is the preferred API for sysfs callbacks as it is aware
> of the PAGE_SIZE buffer limit. No functional change.

...

>  	else
>  		str = "sine triangle";
>  
> -	return sprintf(buf, "%s\n", str);
> +	return sysfs_emit(buf, "%s\n", str);

Do more, drop these unneeded 'else' and return directly,

	if (st->devid == ID_AD9833 || st->devid == ID_AD9837)
		return sysfs_emit(buf, "sine triangle square\n");
	if (st->control & AD9834_OPBITEN)
		return sysfs_emit(buf, "sine\n");
	return sysfs_emit(buf, "sine triangle\n");

But again, check what is the modern ways of providing static _avail lists.

...

> -	return sprintf(buf, "%s\n", str);
> +	return sysfs_emit(buf, "%s\n", str);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


