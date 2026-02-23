Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0634CFCC;
	Mon, 23 Feb 2026 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771835764; cv=none; b=Fy//QqFQ8hC2v85JvUQ9sksqcBLToW2uPHgod7pzBQxFhF0MXb52V/Lr6Y1oHhTAGHS9UJHxVu5AG/GggqYittlMii+PL6GMUJiFXxOxLtBn4iUo1xtvyu1CyGeGo5PU9xoDZnihSq+tCybQoBFWyatkj1olued3KXrDESvs5pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771835764; c=relaxed/simple;
	bh=zdI746hFKumzKyVOv/2BGifp4dXFvUk9u9l1X6Xw7Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGICpoBN+UE1QKgNDtN1rYrDKQ3yDW81ZhdnUha284gQUCzFoCagoVNjse8D7wH7SpkfeCP7EU+fx+jv7T4+tpOE2TtxxZGQow3iLh9DJIeLBGMZM9JckXnQk9+Xpx8qZSTBHLHWVe/SLitEbJmvfE4l6asnq6X9oX5M59Jm0/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtTYu2F+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtTYu2F+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771835763; x=1803371763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zdI746hFKumzKyVOv/2BGifp4dXFvUk9u9l1X6Xw7Eo=;
  b=MtTYu2F+w4arBB0H/764CrVu8g2DLJQX3pQcVy4wXcBho8cM+1SFIAXB
   yvu8fnGg1dj+qC+BqCreIvaxVvtorVUYcACZNNg64VTV24hFHGDfzqjhl
   UEwWaU3sZIOYxt0iuMB7V6uQlG5Yb9/sJS2vRN/tM8D7EPA6U8jloA9oV
   8ogHx9A1zx5iakf1tlyxjvCxaiwY5B3BmiR/ETIEixUe+0p7UEEhsGBeq
   F/B5eIqRHcbLeZ8HR9EI6lezmGX6USVKg0W03gOjuEfWFaGG/pG8hv8k/
   t09e+6njN7KH28uaogxzvH3VoBCB6oK9HtxLcwZX8444XjI5GFkgD8lny
   w==;
X-CSE-ConnectionGUID: SeMCKhkqR66j/eel3A6Yvg==
X-CSE-MsgGUID: d9beKHumTRez7k1m8vmoJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="95442363"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="95442363"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:36:03 -0800
X-CSE-ConnectionGUID: fdAjjbsOQj6k2PG7A3G2Gw==
X-CSE-MsgGUID: 7/JA+J4BTVCLi8AzYbgDOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="215331249"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:35:59 -0800
Date: Mon, 23 Feb 2026 10:35:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rogue prince <rougueprince47@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iio: frequency: ad9523: fix checkpatch warnings
Message-ID: <aZwRbUyaILTZZvGH@smile.fi.intel.com>
References: <aZd2jAVnTIuz2o7h@smile.fi.intel.com>
 <20260219213549.59645-1-rougueprince47@gmail.com>
 <aZgLutMih65WdesN@smile.fi.intel.com>
 <20260222135054.2e2012aa@jic23-huawei>
 <20260222135836.3f8d7a38@jic23-huawei>
 <CAPC4XCQQcvsyNQKkU9vLdRaJSQRbVxa5DGExoBv5H1Vt4fChKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPC4XCQQcvsyNQKkU9vLdRaJSQRbVxa5DGExoBv5H1Vt4fChKQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 02:49:12AM +0530, Rogue prince wrote:
> On Sun, Feb 22, 2026 at 7:28 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sun, 22 Feb 2026 13:50:54 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:

...

> > Given short nature of your SoB and that this is (I think?) your
> > first upstream commit I just wanted to check that bhargav is
> > sufficient to meet this level.
> >
> > What counts for this varies a lot by culture or country so if
> > that is the right level of identification to use that that's
> > fine, just reply to let me know.

> Thank you for checking! Yes, this is my first patch.
> Actually "bhargav" is fine for me , but if you need my full name on
> signed-off (i.e Bhargav Joshi) then please let me if i need to send a
> v4 with updated signature or it is possible for you to amend the
> Signed-off-by line to "Bhargav Joshi " rougueprince47@gmail.com" on
> your end while applying.

Please, make sure you send patches with this SoB (using Bhargav Joshi).
Also make sure there are no double quotes. It's all documented, please
take your time to study Submitting Patches and Submitting Patches Checklist
documentation.


-- 
With Best Regards,
Andy Shevchenko


