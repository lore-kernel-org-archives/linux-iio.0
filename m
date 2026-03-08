Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100892459DC;
	Sun,  8 Mar 2026 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773001940; cv=none; b=TgWKCV5FT87bjRfzSuUwJ5eVk3bDiWjm5n2L9xtQ2EvJZarO/BoYg8crKYncQ/Fh1uQu4XYhR8hY2HtSQ5OD/zAr+I5v3nZmqtaETT8p9pj2mo93ZpqINezYDjq9XUW8/pHMWwQvN6sWrpS+3PEolNbvEUpKbKdrXpbxXjLffbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773001940; c=relaxed/simple;
	bh=a2+EwsR765fWM6MpBoKj/YKwgh8Gg9Vmd0gRgPLB1Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkvG0Z7/B2sfOqUF+PfOUhL7kDj2VAPPz4glqlaNlHqyjjp9iiI3No5Bl8o0QCBrfuM0JvDMhi3W7DVI/rrkg3iLeADLWsy915AFfk8TnphcGE5Wi2rgtQ6eyawkBUMYGOzdc4z5ixgLWb6rKkM+2YzpyVB8Y7JeiAc/e07LFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYAKE2i0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYAKE2i0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773001940; x=1804537940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a2+EwsR765fWM6MpBoKj/YKwgh8Gg9Vmd0gRgPLB1Fc=;
  b=OYAKE2i0gTukt9XMiILgM8Yuu40Vc+6dIX5OXgdcYkO3jdf8LVgZIhCW
   l/+nlN6SDS6EzwVEE1RD9p95S6DWYwl4sfqd4J79Aw9+TtGm3CFxqMQbq
   qbVaTv42pkkP0tL29BAdR8cACPVreCUYn6nksl4+ER8JjVX0RnrKoC6KB
   IfMK8SaKQ5nteZmDNQz1sudJfDoGdGLrAFMA1lCLBaa2pQuAOd7SB9Kj5
   B2jGV05NHeGM3YE2pzt5T94Yh3SfWWJNyqX1tlwHrpR3Z2r6fRaRBYj7p
   COZyM6yZNleYykr79kmWWCqRnjko7HP7zAMbvt8tTlGyTZ5Q0Iz0KeWOb
   g==;
X-CSE-ConnectionGUID: IEq5/dtiSBiTMaxQjWkI1Q==
X-CSE-MsgGUID: ofoNNJBjSXChMR+8rhuWRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84359204"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="84359204"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 13:32:19 -0700
X-CSE-ConnectionGUID: xaiR69b/Toe1ckBGEscZHA==
X-CSE-MsgGUID: hbh8bmjuSDeQdBG8KKBYlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219528367"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.83])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 13:32:15 -0700
Date: Sun, 8 Mar 2026 22:32:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 5/6] iio: adc: ti-ads7950: switch to using
 devm_regulator_get_enable_read_voltage()
Message-ID: <aa3czXB9tzLQgwha@ashevche-desk.local>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
 <20260305-ti-ads7950-facelift-v3-5-a23fdd1a079e@gmail.com>
 <20260307114947.0b946dfb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307114947.0b946dfb@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 07, 2026 at 11:49:47AM +0000, Jonathan Cameron wrote:
> On Thu, 05 Mar 2026 11:21:56 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

...

> I think this broke the ACPI case (where regulator isn't available).

Right, and I even have an HW to test (if required).

...

> > +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
> > +	if (ret < 0)
> 
> I think you need to check for -ENODEV and if you see than then
> see if the acpi route below applies.  Otherwise on ACPI this will fail
> and we'll fail the probe.

Yep, just make it default without even checking the fwnode type.
No need to bring the whole acpi.h into the mix.

-- 
With Best Regards,
Andy Shevchenko


