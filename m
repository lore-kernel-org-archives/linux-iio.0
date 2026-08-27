Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3744E67D;
	Thu, 27 Aug 2026 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834910; cv=none; b=RmjJ3PSW03c4XekwjIHbbEyySa0mCb+IhyGHBykxgbkfzMGiBxzoyVZqhbltZPComdU/kX5+Nq8l05dJEXK2KopZHZGc6Pd9Wz1DHnKv4/4f5l5A7sTgaTt9aYPp3bcbJsBsqogloa5gL8wdhCKO0GvSFMVSRO9xBwF75ApWb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834910; c=relaxed/simple;
	bh=LSe4ClYHyzoUMjPQ2O2AIJo3kbtl9bxf0qFjcfWnhxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrcBN1Q4TEUMXrdD78pnmYtDOcWIb4yFmJDpWXjriVwVKTFmtXXA8KzONefcng6MgtnK7Mmeb3yFms9NzG9rVplxN4Dug4vjrCw3dLdaw8/wuuRTuRceceQCqTVgISnASQLziJG9raDB3d9yqGBH1HIxu2UjB+W+Jnt+a/3dBjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0en+QKU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0en+QKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787834892; x=1819370892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LSe4ClYHyzoUMjPQ2O2AIJo3kbtl9bxf0qFjcfWnhxI=;
  b=H0en+QKUMhnOmVWXKY7E3/GkeNWmuwbK9r2Qew8Hhj0gC3NQUxMMcTD8
   vxU1SoakSXjd/PsR79XsHUG04x4tbK3TrdKTFx+a2TJB0DEDHTTQBS1cH
   XMATIco6XqkOri0wQ7Bd8GDPH0+ppTUtHM5bXdE3KaKpAHvymc0T/roxS
   ZFPTT+jUjEh/jIZfnubQeLMHs4Ey4Uul6qT+85/vfzgyXcBxPv8WETxck
   DkYhMrGRBLN2rQWE+PYidwS1CzK5TVfke6FClhqMtEFleh7zMvaDepMJz
   X5OGsLg5FpBulPIYLGvQ635wR70vUscdxsN3dwNzjlMv9ZRV539AD9rbn
   w==;
X-CSE-ConnectionGUID: cCKBK2g0RQiIQntxRzc7+g==
X-CSE-MsgGUID: G8nVrgYfQMOQF148UCRGKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88189819"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88189819"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 05:48:07 -0700
X-CSE-ConnectionGUID: 5r8ZA7vORXinB4cAgEhcqQ==
X-CSE-MsgGUID: wbyizxAKSNCFhTkpZJP1mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="271386983"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 05:48:01 -0700
Date: Thu, 27 Aug 2026 15:47:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <jan.sun97@gmail.com>
Cc: Janani Sunil <janani.sunil@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 3/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <apAx_ZUDQ6G6XVuc@ashevche-desk.local>
References: <20260827-ad5529r-driver-v10-0-38f2be07b824@analog.com>
 <20260827-ad5529r-driver-v10-3-38f2be07b824@analog.com>
 <ao_z9QTJC_q8gH0v@ashevche-desk.local>
 <aed972ef-3776-4055-81aa-63255d072b8d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aed972ef-3776-4055-81aa-63255d072b8d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 27, 2026 at 01:17:13PM +0200, Janani Sunil wrote:
> On 8/27/26 10:23, Andy Shevchenko wrote:
> > On Thu, Aug 27, 2026 at 09:34:48AM +0200, Janani Sunil wrote:

...

> > > +	for (unsigned int i = 0; i < ARRAY_SIZE(ad5529r_vss_supply_names); i++) {
> > > +		ret = devm_regulator_get_enable_optional(dev,
> > > +							 ad5529r_vss_supply_names[i]);
> > > +		if (ret && ret != -ENODEV)
> > > +			return dev_err_probe(dev, ret,
> > > +					     "Failed to get and enable %s regulator\n",
> > > +					     ad5529r_vss_supply_names[i]);
> > > +	}
> > Hmm... Can we use bulk regulator approach here?
> 
> I don´t think the bulk helper fits here. Each VSS supply is independently
> optional, and there is currently no optional bulk get-enable regulator
> helper.

Ah, I see. Yeah, then we have to live with a for-loop...

-- 
With Best Regards,
Andy Shevchenko


