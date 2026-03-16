Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D41EA84;
	Mon, 16 Mar 2026 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670582; cv=none; b=P0ehC64iMokyi8taKW07M5oR6+Fr1lPcTmO95vWPan4PNWOl+du7B6zfRkrv+aA3Cl7eMcl+xP1U8CA/AgQt5HRk2ltqD2cmJnwOa1+EaSXXnBLr5kZbwEwrGhqtqAS3qKETFsP82NhsAz8+IjdbYSWL+jSOz2TVRoHCMU5vNK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670582; c=relaxed/simple;
	bh=3Hjo2MlecQsEGeH0hojUTgkE8q+MTxgcfe7/iPoRn8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cceiIgopQMdAgIDksp+I2M1XfamTLhOO9GxbQgStlDBL9PwSKituKWLnaW1sjD9KLrnYpH/4UbHf1d6S8fm65x1kWI3skQtQccFJ2F7Q2Sv6EF6I6sdxQtP84g9wWrymkRDiIqPUU5fjCNJiac8b/B4QFjuycrOch/YiLQ6FzY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hv0ODtDc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hv0ODtDc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773670581; x=1805206581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Hjo2MlecQsEGeH0hojUTgkE8q+MTxgcfe7/iPoRn8E=;
  b=hv0ODtDcYFr8Hn2u64IvP08MQHLncqXB5mz+TNKmsj1ZxBD1c9XpiB5Q
   P4IZbheRVzb120wj2KoB0XI7qYfL5glxOBKSGdY/mTwB+zLZ2kthjixtl
   CAmOXg1BV0ei0500xGtlmiX1q22P3WvENeUOskrj2Y5KrV+g04+F8n1e5
   NJmcsPf/ZdP1WpUfeCaYNLFMbnlILxZf0u4zpiDQLbUm+8Bfa3HibCpZV
   QQ4lH+1Yi6LRUHfLfNH/dh0TModCa0g7nWB8DK1RDkl8vX5JGKliY8V6G
   geCnsDLjPByeiwnzxhqLZI6FAFYObqbvb9JAvbC347uAy56MmqvSv9gfJ
   A==;
X-CSE-ConnectionGUID: ROycwCyITTeIqH0/X+WeSQ==
X-CSE-MsgGUID: Z1XW+0OWSY2rArql1Y+Ugw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="92252886"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="92252886"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:16:20 -0700
X-CSE-ConnectionGUID: zbLDzW3jQUOOB29LkC+iWw==
X-CSE-MsgGUID: xW6eNhA2QZ+qGvzF0he6uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="244956417"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:16:18 -0700
Date: Mon, 16 Mar 2026 16:16:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: iio-mux: use flexible array member
Message-ID: <abgQr6Ij_1Bpqb_R@ashevche-desk.local>
References: <20260315224509.48111-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315224509.48111-1-rosenp@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 15, 2026 at 03:45:09PM -0700, Rosen Penev wrote:
> Allows using struct_size to simplify allocation slightly.
> 
> Removes a pointer from the struct.

...

> -	sizeof_priv = sizeof(*mux);
> -	sizeof_priv += sizeof(*mux->child) * children;
> +	sizeof_priv = struct_size(mux, child, children);
>  	sizeof_priv += sizeof(*mux->chan) * children;

There are two arrays that are allocated at the end of the same object.
Why is mux better than the chan?


I rather would see two times array_size() than the above.

>  	sizeof_priv += sizeof_ext_info;

-- 
With Best Regards,
Andy Shevchenko


