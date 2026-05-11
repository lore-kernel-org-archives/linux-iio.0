Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6AF364038;
	Mon, 11 May 2026 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497764; cv=none; b=Bsak8wOR686Fgj8bhpXRGjZGvvJ4vdB6JeiX4vrxBM8pBxCsJ9K55eOpPsBc6WjCwReZ46oAt/MRQ4aI+OlNveTd8ZcXlMNG0iDBqp+6AAWgD1sXvG37vniAp5ZuNE9QmllaCiiGsuJyocBi9Ou5HgsFoM9XZzuydOD8CHaXH+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497764; c=relaxed/simple;
	bh=ufPDhFgVEa4fi1w43KhwzUx2ycixoZKkgKZgh9K3pG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9tyUkZ228ZbxG05wSISoSmyPhTv3LJSF0nQyVybl8xaI66UfLAkwCFY7dXnEM67PL6E99p1h7WUHbpnrc+gE4xxOPD8lFWuzispcgE8A+oLE5gZCBoIN8D246nGGaL/Hmb9nIEdyCp6ObkTGpcdKzR/cx9gutGQAzEgiUJ5DVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRmLS7Dl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRmLS7Dl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778497763; x=1810033763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ufPDhFgVEa4fi1w43KhwzUx2ycixoZKkgKZgh9K3pG0=;
  b=jRmLS7Dl808vrOU/ixEiiWhn7LS0TcEzCnUo4LdDb1i6VVbDz3yk0cJt
   TvVq1XtnrnXjYL/GlRPO1+U+CmZ0a+ao5D4AiF38sE2iXOr0VBTdJCSJH
   /Hw7jmzdPHYuMfm9BYTNoqhfGiLfirQwoWd03VUUzYmz7o6E9WNVI7Cw/
   jzm7df5yLQccIVuwWT6NJlDarqx2kU/wQkEml8JDJV/G5TfCbYZ5UMmLf
   7yahkB7nueOt+/LGKqsCA6FQLT2plVp3R8US+/uTUtvVxbNlg1vmvNZPk
   Arcsods7Qj/Uf50+CgYH8NhfKone/Pho7O45ZMM9xzu16Hd/0yMRiNVUB
   Q==;
X-CSE-ConnectionGUID: 0wTT+KCfSnqnWHHLoY19uQ==
X-CSE-MsgGUID: aip7WFG2RkOFk/A85c7o8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79482542"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="79482542"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:09:22 -0700
X-CSE-ConnectionGUID: bKDKw40aQcecxLksPPGO8g==
X-CSE-MsgGUID: h6QjXXr4SNKLkoSkC0qcUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="234757776"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:09:20 -0700
Date: Mon, 11 May 2026 14:09:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] iio: light: opt3001: localize for loop iterator
Message-ID: <agG43jX7yvBt4b6j@ashevche-desk.local>
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
 <20260511-opt3001-cleanup-v1-5-f7879dc3455c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-opt3001-cleanup-v1-5-f7879dc3455c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 12:04:10PM +0200, Joshua Crofts via B4 Relay wrote:

> Localize loop iterator to tighten scope and fix checkpatch.pl error.

Strictly speaking you do not fixing anything here related to checkpatch.pl,
you fix the code to *address* the pointed out issue.

Yeah, I know this language style issue is present in tons of the commits...

> No functional change.

...

> -	int i;
> -	for (i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {
> +	for (int i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {

Maybe make it unsigned as well?


-- 
With Best Regards,
Andy Shevchenko


