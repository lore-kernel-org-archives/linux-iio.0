Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026687;
	b=23DsttCbaQAmiVvAPk5lc5O5XeaOAE41O4oFY+OgC0/Y3rNEcjCK1U8Xd6BWe2aXX+zR
	 V6sq9iDeXNqyHFAVc5QC+/UDANxj5YUg9+RNPtdx20ott0qYAqkzDrXZOZ8CeEsXMchUj
	 eL8Rt3d3kG7cGKm3KQthexa2HFqo66J4A/GElQlZa1Nai94gh36J4RiZ1PARF/YZJ0xLx
	 04841oUCPlAue5sV4WtSim+uJPVfkoXBN8Eu9GmYGPEkYBzwBPTnqkOjLMuXMhPezmUVq
	 5Bc37fYNwulCkDGtoWrhwMOmwVQURgZsFawKUscDE465d+AjSWJYKWigGUpFVHsAXNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026687;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=lje84BWe21Tj1NvuTbRaeQ2X0Rux0+ByrbBBp+HFFZk=;
	b=ZTtBEt7MF36VI0BsR29358MjK7n+un4mlcSyOPJhgbhyA7yDDlvS8X0zGS3nzHzrCq9e
	 V6VFnk+LXdm9jeRWGc+aTLFesWb/p/H1VucAkhTf0IjIU7fNqFSq7oML2o8Re02iloMdH
	 l3FLBx1LlqPL8y9tqZHKZjzkD9zNwlVyg9i7PcjS7uJWQVNii0bmcPfb5St9/ym7HfGHg
	 +cO7RCdUupPMitoMPWI3jDchxsi8zC7g7KbENH7qjGxH01Qs+Oq2FXq4UQIqgPT/xAtAQ
	 lqMoBUenmLJHPj7Q2Jp9/cFHQ6z/x88Zgcdg5ZBs82xDoaZZp3077lE9/HYn3g6ZTcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mUPGG7ua;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271BD606A31A;
	Mon, 26 Oct 2026 14:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 271BD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mUPGG7ua
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793026687; x=1824562687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aG9QzlWvgSkKozwKHzc5lnj1Bam3cJaHmyr/76VeC2k=;
  b=mUPGG7uahVdYmYg8rS+XUVIiu1JLVa9hdOYKVJdgL6ELAYWFGGBAYwh1
   UULfPSHex+OyNHSlNJ655xKggprbUkUGxjfnwk2xkdYdPlDqeCdtxqqT8
   zkLTepWTaC7QHtT9H8fQxHO86e0S8bxVZflijShjShv8Pu/wgMfh27mtd
   lVllkgRpKYOEYxxCk7Z66CHv9ttmk+WTbu7WkiAl1vtJUpnpSS+FtfQEl
   zP3RCpZmAzV7KF9GC9LDp+El+XRLb+MTVogza8bTAHPRcdyO2DCyVSSQZ
   6H9L0j0s3FO6lS+kcUUPWEOpgCsBqOn4oP3JVeJSe5e9JX9RCwy5FcjWT
   A==;
X-CSE-ConnectionGUID: Ej6xZNicTrGobzvIhv6Gdg==
X-CSE-MsgGUID: j0+Sj8BwRgivwmNCiD+zRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1597575"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1597575"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 07:58:06 -0700
X-CSE-ConnectionGUID: 7Eb8hMhoTK2AU568UVzomA==
X-CSE-MsgGUID: t5A82V5NST2e1pB1lbSwxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4195981"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 07:58:03 -0700
Date: Mon, 26 Oct 2026 16:58:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: proximity: sx9310: keep the IRQ balanced
 across suspend and resume
Message-ID: <at9qeIJbNOo832-w@ashevche-desk.local>
References: <20261026112342.65917-1-kapoorarnav43@gmail.com>
 <20261026112342.65917-2-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261026112342.65917-2-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:53:04PM +0530, Arnav Kapoor wrote:
> sx9310_suspend() disables the interrupt first and returns with it still
> disabled if a register access fails. Resume isn't called after a failed
> suspend, so the interrupt is never enabled again. sx9310_resume() also
> returns without enabling it on error. Without an interrupt line,
> client->irq is 0 and both callbacks act on IRQ 0, which the driver
> doesn't own.
> 
> Disable the interrupt only once the device is asleep, always enable it
> in resume, and skip both when there is no interrupt.

...

> +static int sx9310_wake_up(struct sx_common_data *data)
> +{
> +	int ret;
> +
> +	guard(mutex)(&data->mutex);

Add a blank line here.

*Yes, I saw other guard()() calls without blank lines in this file,
 but that can be addressed afterwards)

> +	ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 1);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
> +			    data->suspend_ctrl);

With

	struct regmap *map = data->regmap;

at the top of the function these become

	ret = regmap_write(map, SX9310_REG_PAUSE, 1);
	if (ret)
		return ret;

	return regmap_write(map, SX9310_REG_PROX_CTRL0, data->suspend_ctrl);

>  }

-- 
With Best Regards,
Andy Shevchenko


