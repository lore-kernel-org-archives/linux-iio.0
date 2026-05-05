Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5A3BE141;
	Tue,  5 May 2026 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777963788; cv=none; b=bpyMoekKEwIMfJAGPIn2FU42AqL6DH7AFbawCUS7PPhqh1J/p4tqORDFUKzTKKddUGTmYdXhMellhbg76JDAMCY2KszSlYQbKPgQtXt4ZDv2ukikBLJspD1cR+eCguyODXjrVBKj5cQxh3XEPbT2tzi2/4uPU+426uNrnGZ/KAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777963788; c=relaxed/simple;
	bh=rPTexkrcLOcOnvaCMJkVd+3x6ACIVY0+lX5+DEokGhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4nAkI4euSVhhRFzdv28DmuPcKH5agJnLgExUAxG4BqEu9OtJ1ftrx7LaYCa7yXiYGIz0K4YstS/w8ocefDl3htAcUi6DtUOn4flHzLGc6R8URZldbHEgmOzEtHI7af5jV4rZ8Ov38okH7NkKepKtReGObzDiyk6tZ89jQ9f9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlFnEeQh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlFnEeQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777963787; x=1809499787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rPTexkrcLOcOnvaCMJkVd+3x6ACIVY0+lX5+DEokGhs=;
  b=OlFnEeQh6mqN/rCMlQWZT+FgyF21RUTavjT7kDq0KltuvPb7jhFNAE2y
   dJqQ8xdlYyj5ZgNNy+ARSjbueASza8OyJy0rHPSKrmttMQ2fxj1nKTBbW
   6zpeGtlljW1QQsT2g7BSI5nEQF4D06EVeGkwX/ZyoqedGlThhcc/YEaCZ
   U8RAQhscrSuNI/XJOPVeN5g9SEKK9VHOD7I+neIRd09LrGv/crheW4qB1
   yeJxpmh3y4hBP7ImzF3am5bzGzdQUXil9eBnD4dXbqnE6eP59bEEefNBv
   6lSAXUMgNmkWZuGACSaWfeVb/qriq3FVkbUxAK+hHaW9ajpcKKwzd1Bnx
   A==;
X-CSE-ConnectionGUID: FdqiM6ZDQMeXOgEsBNHzDw==
X-CSE-MsgGUID: VxkdSVBWSISMCs2H2wq9+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78688590"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78688590"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 23:49:46 -0700
X-CSE-ConnectionGUID: 7O/bqMP2QgqDaTHLudSrHQ==
X-CSE-MsgGUID: 76DFuyoFS2up9E/c/wgpKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="273880021"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 23:49:43 -0700
Date: Tue, 5 May 2026 09:49:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, waqar.hameed@axis.com, dixitparmar19@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH v4 3/3] iio: light: stk3310: Use sizeof() for
 regmap_bulk_read/write count parameter
Message-ID: <afmTBZSUpVrS5AP0@ashevche-desk.local>
References: <20260504030408.105762-1-limiao870622@163.com>
 <20260504030408.105762-4-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504030408.105762-4-limiao870622@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 11:04:08AM +0800, Miao Li wrote:

> Convert the hardcoded count parameter to sizeof(buf) for all
> regmap_bulk_write() and regmap_bulk_read() calls in this driver
> to improve code maintainability. For details, see [1].

> [1] https://lore.kernel.org/all/20260428192213.7c5c80e5@jic23-huawei/
> 

Make these two lines a formal Link tag,

Link: $URL [1]

Perhaps even Suggested-by tag is also good to add.

> Signed-off-by: Miao Li <limiao@kylinos.cn>

-- 
With Best Regards,
Andy Shevchenko


