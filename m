Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C83E1231;
	Tue, 28 Apr 2026 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364859; cv=none; b=AZCYdjkDYEtwubtCnjqdciC/+2w+0RAdj2N5VhW/3z9Aj8eWLahjB6XUPYM+E25CwhUkM2wmFHGZVPdHu8WncVGC08vavRmI5MTsyg30Qy+tfOPM85ksiRazNsP3DdEZsQw4rvCw8L4jLKkwsfMvOmLahMe4pdqGuSahCTtjLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364859; c=relaxed/simple;
	bh=8nyqR3t0jgkRDQ/VDqHOngniAk4FeA+XDZXuygps7i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVDchrynpeGH2NyQ2m8JCltTpiTk/FGQb9HiXDpmBT9LB4D9xe8qp+syr5/DiRgA4HIelmaTDedhWqVoMGh9PQSzwQqKb9E1L619CAGYitpsQXuuaGHbSN0yLPihPDDb+B336p8tc+aRNOLFfFsKZ5j7wxRylomZyZEA9H6qkXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQrcI9di; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQrcI9di"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777364858; x=1808900858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8nyqR3t0jgkRDQ/VDqHOngniAk4FeA+XDZXuygps7i4=;
  b=WQrcI9dipWIjjH3RY/OOfOcV32oGeba6jebeF5nuPaBUF+7BP/8ixu1l
   oijvEtxd7bauTGbOLaP+VjChjbLG8ub7Q52dkMwe9mrc5qcpTmNuPCeUv
   k7a8+Wrl7pSJwgHN3u2DJDWJ8S1izIn71vWeWa3oRdW15MPRPm14/CATV
   MlWqPWkSKt+nmkVY947JEpRWcf1skjRaGsx5g2HbvdAIHmop6bNMYvfUr
   P7t/d1HvjRkm7eE9sss5XYRn8h5vlL3W1nQcXe1Gr03tDAdNWFA030QHr
   JlbOWiWYXfAWx2lo55RdSTQOZOd8Ngv28GPZ1WzZj29fzSm+O1qFiMZIq
   g==;
X-CSE-ConnectionGUID: /NHK9+CCSuGhFaO6uAMQrQ==
X-CSE-MsgGUID: ROEUGNH8SACbs3bKAB7Zwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88962964"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="88962964"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:27:37 -0700
X-CSE-ConnectionGUID: NHcRYQPYTS2JMpDaKlfzLQ==
X-CSE-MsgGUID: jBhbpa85SG216KGNFhhIXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="257418564"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:27:34 -0700
Date: Tue, 28 Apr 2026 11:27:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: magnetometer: rm3100: Use scoped_guard() in
 rm3100_read_mag()
Message-ID: <afBvdGstR5aIAmxg@ashevche-desk.local>
References: <20260428024339.45109-1-m32285159@gmail.com>
 <20260428024339.45109-2-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428024339.45109-2-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 09:43:36PM -0500, Maxwell Doose wrote:
> Replace mutex_lock() and mutex_unlock() calls in rm3100_read_mag() with
> the more modern scoped_guard(). This will help modernize the driver and
> bring it up-to-date with modern available macros/functions.
> 
> While at it, remove the now unnecessary "unlock_return" goto and
> directly return in if statements.

...

> +	scoped_guard(mutex, &data->lock) {

> +	}

While this is strictly correct change, I would prefer to see guard()() for the
sake of less unneeded noise in the change.

>  	*val = sign_extend32(get_unaligned_be24(&buffer[0]), 23);

Yep, this will become part of the critical section, but taking into account
the size of the rest (and how much CPU cycles it might take at run-time)
I do not believe this piece of memory access with sign extension algo will
anyhow affect the duration of execution of the critical section.

>  	return IIO_VAL_INT;

-- 
With Best Regards,
Andy Shevchenko


