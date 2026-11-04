Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813476;
	b=Lr44da7jEqYInw7K3z8KSe2uVfhZRMsW9Hov6gENVmDhz1qk493+lJBMtqr7twalZUHC
	 2ZRcs5ZSzgWGhN20X2pXErmVKrveM+DQuqhhMa1KSa9bNaZ4ueP2lNvI9Txppje0zuVmu
	 PHruoLPoPIu7UaOUmgD0DXUNJXhEyd5qjhh/YF+xMKRermSz27HFog+KX3kr0nnGXt83+
	 DEvN0wytgaZ9Gtjx933xqF79rtFP46fRmYUVcuvj2mW51XgqYl641HdWQ5f5irdK1fd4h
	 +if+PfqVFHk95beS/dixnYOwbjZGqZa9EqYOEnqg646Xye3zOTSLKeCT15aIdEEzqAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813476;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=eEMB8r0budUtj3uGulxJe7mBeA6S1msIwjb4rAySSVk=;
	b=hbS8THPCuK1pJQSG7ALX5kFlsV83YvkvN2zV3MFUvx6MNara0w4RecuWWoQPSnJAyZL8
	 FJglRCLxRhE0Ovs5y+dQhLpZ+u1J7GImKUVgV2Rw5rAAr47+eJNhO9w8/NnpkdBq/doac
	 1H7Jv0GcTV143NeSbvfv2b/6GBecRslNXdHvcOg8/+yltKxpwnJm4DhrQR0peJeCA8+zo
	 pPUJ2YjkQnBoxJG5lkjgCmbtaD/UwYcFdYYY7AnWoM7nWuyD5Dir3G8D8FeYgthqHTfaN
	 Q29+kakMvXMVPUOJwMLVHTwiPKr71R4UoHaKFoXIHLiX9P4wl9sT4sTMn/DQhhe7XAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MgBZ7EdZ;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6E60700E7;
	Wed,  4 Nov 2026 17:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20F6E60700E7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MgBZ7EdZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793813474; x=1825349474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m4SPikyWXZLxiPSXE01IVVLmm0cbn4Cy/WXBcIsyOMs=;
  b=MgBZ7EdZQVySHNUPLqQ7+dMLmPbfqyBXcWaeE33tm/dAcO8UoL70fiJ9
   OvznilhRW1f8MIi3poIFOErr94ehUdhBm7u6EvxJmkgEw+JKHigtSBeHQ
   CgN0b8Y+NO0ObFjzDTGQid/l7tJ9AaPD4kVUak1jyvULxxW2SX3xSpAay
   PhVG8EI1hS0Bmu75XjtO9iDqy2D8e7YTs7Fgv9NjvhJatunYLcABQwQvg
   3GYhfu3s/Lmitkp77JWdqE+OSijOY72Rxhs/FmIJX6l1hxqmTnlEkLQX/
   LsO3tidV4FDnUoivgb7h+lwFDJfmq/ct7nq43IbiXqzV+KrdnvqxJgkva
   g==;
X-CSE-ConnectionGUID: YTXjr7k0QS2SWzHb6s/CQQ==
X-CSE-MsgGUID: ZD88bbL7RDueOOcwVIv4jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2458172"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2458172"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 09:31:13 -0800
X-CSE-ConnectionGUID: l5z61l+QSJ2Zl7Xes/bhZw==
X-CSE-MsgGUID: U8j/Qh3jQ3G6t95yNbxQew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6676151"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 09:31:11 -0800
Date: Wed, 4 Nov 2026 19:31:08 +0200
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
Subject: Re: [PATCH v4 2/3] iio: light: gp2ap002: add led power supply
Message-ID: <autr3DH6UZLY_ys4@ashevche-desk.local>
References: <20261104-iio-light-gp2ap002-v4-0-fa1cbaad2ce5@rudorff.com>
 <20261104-iio-light-gp2ap002-v4-2-fa1cbaad2ce5@rudorff.com>
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
In-Reply-To: <20261104-iio-light-gp2ap002-v4-2-fa1cbaad2ce5@rudorff.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 02:02:28PM +0100, Christoph Rudorff wrote:
> Problem: no irq received. Not working.
> 
> According to datasheet page 8 "Recommended external circuit",
> it got tree pins to supply: vio, vdd and vled->leda.
> 
> We were missing to power the led (pin leda)
> 
> * add leda regulator
> * use regulator_bulk_*()
> * pretty up set voltages
> 
> Tested on samsung-j5 (msm8916)
> 
> Signed-off-by: Christoph Rudorff <chris@rudorff.com>
> 

Missing '---' cutter line which makes this patch invalid and it may not be
applied (your SoB should be a tag and it should be last in the chain; you may
conduct an experiment, take the message ID of this email, run on a clean Linux
kernel Git repository something like `b4 am -s $MSG_ID; git am ...` followed by
`git log`, you will see the issue).

> v2: Use regulator bulk api.
> v3: pretty up, rename vled to leda
> v4: add namespace "GP2AP002", use separate value for setting vdd,
>     moved static supply-data back to global, more readable imho
> ---

...

>  	int num_chan;
>  	const char *compat;
>  	u8 val;
> -	int ret;
> +	int ret, vdd_volt;

Don't mix semantically different variables on the same line.
Try to keep reversed xmas tree order.

...

>  	if (ret) {
> -		dev_err(dev, "failed to sett VDD voltage\n");
> +		dev_err(dev, "failed to set VDD voltage\n");
>  		return ret;

Unrelated change.

>  	}
> -

Stray change.

...

I stopped here.

-- 
With Best Regards,
Andy Shevchenko


