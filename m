Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571362;
	b=hUJJrWZA1jH/7MgXBbd/9Q3Bmgwb+9DzcVh0LoCpKmqBmnijpzs8gZ/41hCklWuIrp+B
	 vVGDdo/gBlxmYV6uiJGYodfFtHlYPAItfkC5LsPwvzd5hyjKeRQ2qdf/b5wqijnxyVX4V
	 2GTb/5fRy10OZrplZVYY+3jDr4Qh7l2TVbHoSnEuCExwtkf+O+v7ncSyYAis1IJzn5xVW
	 aVEZVohWuLaSqRYRP1WitoPWjKDHT/Sowrv9tzBta43VWH47f/Y6tfxcd4JA6QCiAdc4p
	 oevWOdCCN9lPFiKSVFpcKA4EuHFvEju8I62mRgnwIPb7NpqLeH4R1xFmtZiDhaXyPwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571362;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=yx0qSyV+UGtbzKdEks876ij6X9lfTK+X0d1nDhdR9wA=;
	b=axU/MCVSMetKiyed+BdBUKtbnzBy31BOz1SzXH4XjrY2Bi0MTBquIQjOiEj79MhG8KvB
	 QSywEW6aJLyLn1QjQvr+IOZ804bgj6xvu6E9xz4s9qttvQkYzlY9QHf7Llz5mBXPs6UOQ
	 K5n8MnYJSu+oOH2do5YrSMELNNtyVdPB9k0W23iWwfc5ab7Zm5VD1VBMYzojbNDO9zxRi
	 5LqhRAxkHeSFmgXTCNx8R3qAtttAGGxSgyWyPZ441Mr1jkW/kHZm9m5WcFvU0wbf5ygt0
	 I6E0o0UO/rjkxoWfHntv1eMHf87S7183qr5fignORS6cGvBYZE8XQlmXmlVtS98gIgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n+Up00cc;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D4606A31C;
	Wed, 21 Oct 2026 08:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 037D4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n+Up00cc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792571361; x=1824107361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jIjJRpSnJMk59B7h2RdoIG5jUOyefVhts5QEtquzHY8=;
  b=n+Up00cctZZzD/OzHEpjTp9i7O4bHYWhfI1JQ5TfG0CYEFQ748ANWe/r
   xy5lpxHvsN1hlOZ7cebXcQDZj0+9nA1vCNpA9MenRoWSxmCxJU/uKuz3N
   WZ0nqCD0a4yl9TM1bSwqknm0OBPay50lTuJazxynImBqvG8wb/wPjwh9a
   PDW98/eqap1Y6OyXu7UIayHk2cfGirbuiniS//OKZNZP29ClJGwbXRvwn
   sQ2VYgzjvvON7aR2iH7fedr9cSMUAGwgIvV2SfbmIZBC3DyK3qwqrCPna
   tBaNojurjd6XrS53usWngIuK5Z6b8VvpTu995krMLoZvXEZ1fy3TQbceD
   g==;
X-CSE-ConnectionGUID: NcPGT15wSLu31agNQgR2uA==
X-CSE-MsgGUID: VVdV2eNMRMiS8VirztY9PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1177194"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1177194"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 01:29:20 -0700
X-CSE-ConnectionGUID: cd8Ivp2bT9qzasT4o4yXhA==
X-CSE-MsgGUID: TRhdMaHMThiybE4TlUwOKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3093643"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 01:29:17 -0700
Date: Wed, 21 Oct 2026 11:29:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Christoph Rudorff <chris@rudorff.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: light: gp2ap002: add led power supply
Message-ID: <ath32oZkOYl2UwqX@ashevche-desk.local>
References: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com>
 <20261020-iio-light-gp2ap002-v3-2-b7e0946c9e79@rudorff.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-iio-light-gp2ap002-v3-2-b7e0946c9e79@rudorff.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 01:35:39PM +0200, Christoph Rudorff wrote:

> tested on samsung-j5
> 
> v2: Use regulator bulk api.
> v3: pretty up, rename vled to leda

The comment and changelog area is...

> Signed-off-by: Christoph Rudorff <chris@rudorff.com>
> ---

...here, but the commit message is effectively missing. We may not accept such
a change, so please provide a commit message and move unnecessary bits to the
comment and changelog area.

...

> +enum {
> +	SUPPLY_VIO,
> +	SUPPLY_VDD,
> +	SUPPLY_LEDA,
> +	NUM_SUPPLIES

Not critical, but the naming is too broad, better to have namespaced variants

	GP2AP002_SUPPLY_VIO,

et cetera.

> +};

>  	struct regmap *regmap;
>  	int num_chan;
>  	const char *compat;
> +	static const char *const gp2ap002_supply_names[NUM_SUPPLIES] = {
> +		[SUPPLY_VIO] = "vio",
> +		[SUPPLY_VDD] = "vdd",
> +		[SUPPLY_LEDA] = "leda",
> +	};

Can be moved out of the function to see the static data (that's effectively
global anyway).

>  	u8 val;
>  	int ret;

...

> +	ret = devm_regulator_bulk_get(dev, NUM_SUPPLIES, gp2ap002->supplies);

> +

Redundant blank line.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get regulators\n");

...

> +	ret = regulator_set_voltage(gp2ap002->supplies[SUPPLY_VDD].consumer, 2400000, 3600000);

> -	ret = regulator_get_voltage(gp2ap002->vdd);
> +	ret = regulator_get_voltage(gp2ap002->supplies[SUPPLY_VDD].consumer);

> -	ret = regulator_set_voltage(gp2ap002->vio, 1650000, ret);
> +	ret = regulator_set_voltage(gp2ap002->supplies[SUPPLY_VIO].consumer, 1650000, ret);

To make these lines shorter you can introduce a temporary variable (or reuse
"compat" if it's feasible, might require to rename the variable, though)

	rname = gp2ap002->supplies[SUPPLY_VDD].consumer;
	ret = regulator_set_voltage(rname, 2400000, 3600000);
	...
	rname = gp2ap002->supplies[SUPPLY_VIO].consumer;
	ret = regulator_set_voltage(rname, 1650000, ret);

(Side note: This ret = foo(ret) doesn't sound good, the rule of thumb to have a separate
 variable for the 'ret', so you will have ret = foo($VAR) in the code.)

...

>  	ret = gp2ap002_init(gp2ap002);
>  	if (ret) {
>  		dev_err(dev, "initialization failed\n");
> -		goto out_disable_vio;
> +		goto out_disable_power;
>  	}
>  	pm_runtime_get_noresume(dev);
>  	pm_runtime_set_active(dev);
> @@ -616,10 +619,8 @@ static int gp2ap002_probe(struct i2c_client *client)
>  	pm_runtime_put_noidle(dev);
>  out_disable_pm:
>  	pm_runtime_disable(dev);
> -out_disable_vio:
> -	regulator_disable(gp2ap002->vio);
> -out_disable_vdd:
> -	regulator_disable(gp2ap002->vdd);
> +out_disable_power:
> +	regulator_bulk_disable(NUM_SUPPLIES, gp2ap002->supplies);
>  	return ret;

Wondering if we can use managed resources to disable regulators.

-- 
With Best Regards,
Andy Shevchenko


