Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0484E2BEC55;
	Mon,  9 Feb 2026 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652202; cv=none; b=JodHJ5W+It26IWERIzgOXgTeJwb+7gnkrdpxlbH5u/aUnlb6aZ6UoqSHd2Wr+UB/BeGBLOoVc43PzyxN6ivNAWoGrTGGIanbH1q0/twrJi4vACNT2aErEznpPmTZ/XTccuksTb6/R5peum4gjVi2Bf1CQA/pbh8sxC3pXcp3XTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652202; c=relaxed/simple;
	bh=vDq+j7s8pXIuY3vStz+3sTq2vM/V+muJnmG0jZ6xh/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zxve8p3zUd7TSnRCdQjpB1m9QBG8SQTbFCUvpeRCdUsWm8MVmnrYtrQvRpe6n8Km/VtRmbcs3+Zupc4ykYXRKnZE3iuwywyJVDRz2jS7jLdwt2m/N+KCV7KVcyFGscfbiFuBwZCCoHEZp9BF5wZ31yuDQqCPR7amPsSlHVdD9hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYYOvKVr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYYOvKVr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770652202; x=1802188202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vDq+j7s8pXIuY3vStz+3sTq2vM/V+muJnmG0jZ6xh/o=;
  b=IYYOvKVrI2rwZD4bj/1ZqICVY2tN+zr9gkLEc22ht6YGcbf6EMaezO7j
   px8holUbHQwFFk6q3qJOfiuWUhQ6R0/TB+wiT9iZEw2baHgjQE8zbDvt3
   e5BfoSrvweRWKwAoHKv+Qu8LOlR9Pgyykm5btqqZrox4hQF+92nslR/87
   pKJB53JmaVUCxUWPouvnXx3Fg/+ko5uhvu/1n1KXF2JPUfpSEdsaTV3tj
   9s61EFtwnAyyM7eZatP603Kkg0d322lZQzBE9G0wFv0NLTHzW5YeGED4P
   KBVaFIHcqCDqCXaepf0qo/TYXaWhWmJk5KocwgpwSDIND7W1GZ1++1k9u
   w==;
X-CSE-ConnectionGUID: F7B8ubsXS4+89tqADvlogw==
X-CSE-MsgGUID: sr3TBT/QT6mo1iYq4rgpng==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75613123"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="75613123"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 07:50:02 -0800
X-CSE-ConnectionGUID: S/DrPbkWSqK6IY/rSdAIiw==
X-CSE-MsgGUID: lEW3Y0aTS6iKhmQVCmbnKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="242239437"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.128])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 07:49:58 -0800
Date: Mon, 9 Feb 2026 17:49:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Tsai <ktsai@capellamicro.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: light: Add support for Capella cm36686 and
 cm36672p sensors
Message-ID: <aYoCJMlaaPO8auIm@smile.fi.intel.com>
References: <20260209-cm36686-v2-0-a48126d2b124@gmail.com>
 <aYoBwFW4ZDFhmlvy@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYoBwFW4ZDFhmlvy@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 05:48:22PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 09, 2026 at 04:23:40PM +0200, Erikas Bitovtas wrote:
> > This patch series adds support for Capella cm36686 and cm36672p ambient
> > light and proximity sensors.
> > 
> > Capella cm36686 is a combined ambient light and proximity sensor with
> > adjustable integration time, interrupt and hysteresis support. It has
> > the slave address of 0x60. cm36672p is fully compatible with cm36686,
> > except that it is a proximity-only sensor.
> 
> So, can we share the code (assuming there is a driver and it already
> uses or may be converted to regmap APIs)?

Ah, it's being added with the same driver... So, have you checked if there is
any similar HW with the available driver in upstream?

-- 
With Best Regards,
Andy Shevchenko


