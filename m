Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605511;
	b=GoLp/UD2lORjRObV8K5LvZsgsUaKPU3rTN79ZvJrsi6+WmO8n+Frb5N7RR8Lcxrye+1m
	 1LxKGyRklTUb4IeBMn7Xgolv7EHfTm+Zy0TWOx8YSTG2E+/n7WC2RO6zKg/JTxDLw1A4J
	 H3Dc4gHmei/fQbgyjAF5xMkWfOJnkp8AvUjuAPg+MuMf+/yyxRs7AphTe5zQ9ytTI+Fwj
	 JhZ/zJtZmV1aFeKBA1FuHUAIolTg6te+yoGdh0m/h6bL3ot5tHAoNqIRFizXuggo2N9gG
	 CkU+OuDCUU0xyUWn939izm4411GI8C5Czn/1KSGR3jL0AoruKu57XZw28j0AJom/vNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605511;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=AnUA3yLSgJJ1Fx5OkSb9Yc89LoJrMBxd+X4QC+HsqIo=;
	b=NM7ElFv6QwKce5UwCnCkCLbE3VKviejAeBxATDaw0pByYhfltx88g215NXrHjw9nQ41X
	 X7vZkV/17bnRN9lnknucFset5XJnlxUYHaT3QCWTLFxuwNVNFSGYMaQd6C1VitleMCwRT
	 hx+E8MKlNEuwhlqkDW7myOqySM1BWsuI46jBVBVwuRaes5mBhemEij0M2FP62873cC7zc
	 f7oTIIQV8xz8xWMb6LFZ9+Wp/I1QFLHixtjcLuXXT55KNJaBnCpoe3CmMU0HQNI5zyjRt
	 kD1jvP0Ph0kCZP5LQ4Cu958uNVZqbXh2xyUA9tXpjvNmXyUvFKpak6maPtR/Anhz7wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZlV+dnJm;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A519606A31E;
	Wed, 25 Nov 2026 11:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A519606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZlV+dnJm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795605510; x=1827141510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I8QD6T/3tUNqz0NFMagJLrl2o0L2hn8M90Kc08uS81c=;
  b=ZlV+dnJmiCdXt9DVfh0J9AtCIc5lQ/D4yylGBxTtih0Wua3gdDCL9Y4C
   NLYolL4RQPmQx/CdO7sEC+0F2W14CwOS32unWrZyW0jcxYUukEBwSZuV4
   pVtcHv9SdM2t37r0fn16junQ27jjjRB7YZFwjAkLss+37/J8HXLMj3X5E
   UgtI9D2pvtrY9fmnQsCTsbGaU6iXZeu8NEfEtsL+hVYF7DS9zB5brp50W
   UdZI6UtIlGwuOrNUd3R8qvyobLvFHdkAeBhKltbgpnLMIzbAR+MEGqqHm
   0qkoGu9qHjejV5yFKqU713PAM/7Mr7dB4K8djtiUnVTQawitpSDFSfdlR
   Q==;
X-CSE-ConnectionGUID: RduSvEHOSxu71jRY0hI25w==
X-CSE-MsgGUID: 1zhhUbWZS56+KFD5QlxU6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4396766"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4396766"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 02:35:22 -0800
X-CSE-ConnectionGUID: 2kt/ocwaTnOlf2I5DpQp1w==
X-CSE-MsgGUID: Qhb1zdaUT3CST1PO8wSFUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11712095"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 02:35:19 -0800
Date: Wed, 25 Nov 2026 12:35:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@analog.com,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/6] iio: adc: ad7887: drop platform data support
Message-ID: <awa55IsQZJnkJ5lX@ashevche-desk.local>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <20261125-iio-adi-legacy-platdata-v1-2-54e4c8830b57@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261125-iio-adi-legacy-platdata-v1-2-54e4c8830b57@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 10:19:18AM +0000, Nuno Sá wrote:
> There are no in-tree users of struct ad7887_platform_data, and the
> driver works fine without it. Its only knob, en_dual, selects dual
> channel mode, where the AIN1/VREF pin is used as a second input.
> 
> Drop the platform data header and default to single channel mode, which
> is what the driver does when no platform data is given. The dual
> channel code is kept so it can be enabled again should someone need it
> and add a firmware property for it.

...

> +	/*
> +	 * Dual channel mode could only be enabled through platform data, which
> +	 * had no users. Keep the support around in case someone needs it and
> +	 * adds a firmware property for it.
> +	 */

This patch removed the platform_data, hence the first sentence in this comment
at least confusing. Just drop it?

> +	bool en_dual = false;

-- 
With Best Regards,
Andy Shevchenko


