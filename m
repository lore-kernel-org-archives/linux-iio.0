Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F80741C307;
	Wed, 29 Apr 2026 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486940; cv=none; b=lWrxbOWkSeiOu+1zhLLCviFJTFCShcixj06eFxrjxmnBvRjKEVbxomvwU5WNz5XLUNiAOOLziRvi1+af5tH4QLYqRkloCti/q9NvQdc0pbfKbSmt2osuBP8TtdK5UzE+9etupXSN97XOnWVkGg3ynLH8SshrK1Naje5jZheptHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486940; c=relaxed/simple;
	bh=J+vn6VAsTSr5lxDvR7fTxCiAUrqqvOaaaJJ0F/yX+mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aO72qw84NyaFUkfRncn2ReLBYccWSWk4EGyfdQkycL335zTlMemE0fb5xGqsT5vbtLNbVwR8hzs3dGIwmKc2wB+oUkn+eaSPfo0gfRGfDoY030KzynhhL1p/ePLP5NlHQOBMExm1pu+BcqSeNitpPfUdq0yuFfYCVkCQdzbuv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipzQUIdy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipzQUIdy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777486939; x=1809022939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J+vn6VAsTSr5lxDvR7fTxCiAUrqqvOaaaJJ0F/yX+mM=;
  b=ipzQUIdyzdJs0oSQ/3mIT3FzVcs482hF03Ha+Gx0z3+zZ+VecdYLj9yV
   9BcF0x5pEoLnLhzoKXNsDIbGlzLCGo2TkhcOz24cAjx5YTkNFfL8In9Xm
   LTtDI5ZP257Kz/VtZ3DSxOviYLYkAB78PI7g5wMDE3iKWXPzSq5EV6kGX
   WRFttwnqBJECy63SXbaePV9d7LQHtJtv2josCVjcSqNH28yGhpzbF6fGB
   kG9RNj8dNlIHvDCAOehJuwXBeDGIUjqek6Ktp4EaaxPRUH14tYONwtLNz
   oJRQvu4kFD0wYjn0g7sU/NIk89+j0SNiDEpjK4jN967/Zjr/RsxM0Zda2
   Q==;
X-CSE-ConnectionGUID: K951Ht2TSs6E3/gbFsnF9g==
X-CSE-MsgGUID: 9VapLlKgQHKX9Kr1gOu8uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="95990352"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="95990352"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:22:19 -0700
X-CSE-ConnectionGUID: FTQtZtRCTn+LuWrzYfa8Ig==
X-CSE-MsgGUID: UMtYu+XHThmRcVBuxtwlGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="231203293"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:22:16 -0700
Date: Wed, 29 Apr 2026 21:22:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
Message-ID: <afJMVuDFzziD4PYu@ashevche-desk.local>
References: <20260428222600.91322-1-m32285159@gmail.com>
 <afHLYbjUjE-kQGer@ashevche-desk.local>
 <CAKqfh0EXYOjzyLcXfRB7RdBVfcNOkjpoL8H+7t124H0n17UKXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0EXYOjzyLcXfRB7RdBVfcNOkjpoL8H+7t124H0n17UKXg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 09:26:53AM -0500, Maxwell Doose wrote:
> On Wed, Apr 29, 2026 at 4:12 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:

...

> > > + * rm3100_guarded_regmap_bulk_read() - Wrapper around regmap_bulk_read() with a mutex

And perhaps make the name shorter

rm3100_regmap_bulk_read_locked() // also use more standard pattern with suffix(es).

-- 
With Best Regards,
Andy Shevchenko


