Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880984;
	b=dbTNsXpEqKwrjtIET6ieEZQs2hJBTK9PEQOKwNcq475kXJd0jWkkAyo1HZaqudVAp60V
	 5SvzpOs1CthxushaYDMrIWXxqUCO1jU47pAfC2PgBro1Kzf7Q5JEJdSpTxjnjCGce5yjI
	 1c41mP/rQt24jRMy4P0LPacaFYlJjS8Jr5o7/TQY1S/OKJ/e8qvAMz8+eTmPkzZucANhB
	 d0NvO04MDHrsaE8zvwQGj5+xKpUdfin90OhVZ/hgHblNLTzsC4/hFYMi0CIpyMNOu/ru8
	 mirquzoVnzzdz03pBrBkXXNzy0e4gSKAYhY5EeOKCpumIImQ/ftELfnPTyt3AeSKi9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880984;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=Rok9y466uiAnE7+/08y7ZZu4eo0bVUdHlL7+Y3vBUYM=;
	b=EMaQ3UzHtgP+BLAJFrWBMjumVPPn8o+IkVJ2Dfs0d11ZbONIGHZVziYSQNY2eDr6UISA
	 s/Nm4FERLe2B/46+rP9+HoFwWWZbuI66R5W99h9xYCAUD84IwmfNi57sZtCWu6IWt5TRF
	 4SmJkX1Uof1cF8bBCSCWM4ubCxdgbzhFDFIqZB51KXJOItXe0AODDQP8T2rrQpNG+VVkT
	 TpzmJXOevmUOZVUBQCz5Z62BrnsqTW/p2FikwDFRUlA8IKu9SoAeD/alttYLWHfCrgLSd
	 DX7qRW0lwf5LZcO/C5VJOirFx75sa7d380J3LzTbmhTua7YPlS/LgtMMrjQefUCrvtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IdxOm3st;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FBE606A329;
	Thu,  5 Nov 2026 12:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84FBE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IdxOm3st
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793880984; x=1825416984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=d3FPpE0PAVKvJcm9KCS0u8FKppycCkr6BvUrJr0nJvU=;
  b=IdxOm3stJwgVyx85vZc4zW7hwqmAyxcg8fOrt20FzMXNM7M7plqUydf8
   mJtlWD1Jd25gIZZhyGxjBeHIEqGndS9f1qp3HbN+ah8AqChG4LgvfRZzC
   yKWnh81n3FYYE6DNEE3i6XfnPRbsBfDU7BOYM4wZbe+OD8qDGWuZsxrGo
   uDyL4hU38yjdxLzDBV4+sAcYRbzot82GdPTvlGIE9WXwZDsImUIRzz+NL
   ukP31S+PnL4GqLZIAnYDJxvuIxeYb3H4cineSitcIl7cr3zcJnnw2IFY0
   FXNecH/xFnaB2ogZ/haaYPbEcRBcrJCfqqaQIUQu/hnSD3MQQpRgx9l85
   A==;
X-CSE-ConnectionGUID: Pa4mvpmYStS/BEF7Eqty9w==
X-CSE-MsgGUID: 9BmKnDdoTrqQTfkkOvLwNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2550359"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2550359"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 04:16:24 -0800
X-CSE-ConnectionGUID: ZKcPsXtrQtSIhU6MjnwIfw==
X-CSE-MsgGUID: nL1LzVOSQS6LI3AF41/kRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7320751"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 04:16:20 -0800
Date: Thu, 5 Nov 2026 14:16:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: jic23@kernel.org, Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad7405: Add support for
 ADuM7801/7802/7811/7812
Message-ID: <auxzkfpzV2Zr9QSo@ashevche-desk.local>
References: <20261105093531.7562-1-pop.ioan-daniel@analog.com>
 <20261105093531.7562-3-pop.ioan-daniel@analog.com>
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
In-Reply-To: <20261105093531.7562-3-pop.ioan-daniel@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 11:35:31AM +0200, Pop Ioan Daniel wrote:
> Add a chip information structure and a device tree match table entry
> for each of the ADuM7801, ADuM7802, ADuM7811 and ADuM7812. These parts
> are handled the same way as the existing ADuM770x devices and differ
> only in their full-scale input range: ±320 mV for the ADuM7801 and
> ADuM7811, and ±64 mV for the ADuM7802 and ADuM7812.
> 
> The device tree binding lists the ADuM7701 and ADuM7702 as fallback
> compatibles, so the driver can handle these parts through the fallback
> alone. The dedicated entries are added so that the IIO device reports
> the real part name instead of the name of the fallback part.
> 
> Rework the Kconfig help text to list one supported part per line, so
> that new parts can be added without rewrapping the text, and make the
> prompt generic instead of naming only the AD7405.

> -	tristate "Analog Devices AD7405 ADC Driver"
> +	tristate "Analog Devices AD7405 and similar isolated sigma-delta modulators driver"

Update the top comment of the driver along with MODULE_DESCRIPTION() so that
all three have the same (or quite similar text, like without word 'driver').

...

Otherwise LGTM.

-- 
With Best Regards,
Andy Shevchenko


