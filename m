Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4895345EAE;
	Mon, 19 Oct 2026 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405312; cv=none; b=OUdkqGxemUJUUjjzcRH2PJmCnc6vx08D64fT7lGVHl5NgKr1NQ58ooCe2A0nZjxl2RRiL3dQFqKopf8QtP/5sCXGW227gmByAavwpsdpky8CKL3qmrDFQUUuk0FQwSwYEO8AHSYeAPrphpKqXnU6ygcjEp9TkHeS3/5qhg2d2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405312; c=relaxed/simple;
	bh=/8sdXr96818rrnjhdoc5gRdsoTMSEQuo1OnEZBJvK+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIYuDFRy5vjtixWNgsQVzZED8Ks0DEExyKapkCZu5j1xlqshqyVZ+gWess7FhjwtkgLnrxsrP82S3TCAoKtaG1ua74ME/RXNn8NeDyaiuQbtnVO+ICnijd1AG0ItHwqKZxaZh8izjSAn8jhiTkOKfMpZUcrJV56zQy+Pf6pbyeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLt6q0An; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLt6q0An"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792405310; x=1823941310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/8sdXr96818rrnjhdoc5gRdsoTMSEQuo1OnEZBJvK+o=;
  b=KLt6q0An4qqb94Wmo4hvFwaxt0Md92LfxY6GajOif6tiuqWmBNvF8JV+
   Uo36GirsWPsBLR5GVCHMK9Sv1ndwY2wGI37Y5TiuTLKJNMDBuKr8IaHIf
   vs/6xy7c6Ts7c6ycxWLjSGCOcQsoLxuOis4yHO4UZOybn6pKJ/BOI+v7Y
   bRSbTOGnluIqzc8TPu5h80HeuhVUxIPjTOgGoMlccu60mFRKOzKErE80T
   DMXWGBciIIuunsb55cycWczQdpb4/yThA/N3FtwkLmbxxxhGYMl1Ix6nJ
   /qUNX5GcgY37S0pSxByCQwLc0BoDObGQCYMkacogyWhb5d8aHS3VGB4y8
   g==;
X-CSE-ConnectionGUID: IGIEMVU4ShmiiUsn5O+Rgg==
X-CSE-MsgGUID: as1EbOeDTECnqg9RDdv5XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="970759"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="970759"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:21:50 -0700
X-CSE-ConnectionGUID: EhWXvNBuSQWTeKHV/8HcUA==
X-CSE-MsgGUID: csp3bXKkRbqKLMa5tQ0s7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2970616"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:21:46 -0700
Date: Mon, 19 Oct 2026 13:21:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: berringtoni36@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] iio: accel: adxl345: update period cache after
 successful write
Message-ID: <atXvOA40_3qE2HA-@ashevche-desk.local>
References: <20261018-adxl345-period-cache-v2-resend-1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018-adxl345-period-cache-v2-resend-1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 18, 2026 at 09:42:00PM +0800, Wenqiang Zhao via B4 Relay wrote:

> The ADXL345 event-period read path returns st->inact_time_ms. The setters
> for inactivity, free-fall and the ODR-derived default currently update
> this cache before writing TIME_INACT or TIME_FF. If the regmap write
> fails, the sysfs write reports an error but a subsequent read returns
> the requested period even though it was not programmed.
> 
> Update the cached period only after the corresponding regmap write
> succeeds.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Assuming that my comments may lead to a separate cleanup patch later on.

-- 
With Best Regards,
Andy Shevchenko


