Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011562;
	b=RhKB1fHvo4F6p+xfC5dp5ROZi133GUF6EawnL01/eo8/QuFWp6O8Qxl1O+uijr5cgWmg
	 dDs0wd2GqmulL3f8dUMlzbfXE0ATGDbUdeRPucVBnKpFbJaBXHcXOkMrfaB7eBzjtpjcf
	 QnIE74ff8kVCt0fAeRy9vn8T9asRzhatiZdPQRwxieKLjG0LoWCS54EMREqcpc85G6hrI
	 nHoGc/MkiyLvWuWEvCLoVge+FFQt369M0RhF2k5an7oWmF/KYICpQ3e53J7ttXliMucCE
	 Nh7TkzXDXFYKXjLHnGWJCCwMw1kDJG9CNB92NrydYtUNG6xGaTMpDjsozaucg+DaXbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011562;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Z/+BSSsJQrIyQ8YNqN67tPw2DWIueYxIGw+TSGw629U=;
	b=vcTLDVmPs0a7U/8DVBfQpUuuPvLwyAgAaD5cYatCTXeYMZakYn1KWHEBtL9veXt85Ncs
	 h4y2qTt7BvfCtSYqgbFnxQ1cjc1uC5i+sr2JB/k65vGvjAewaTbVkSKTuCfDx/Uz9KrZt
	 6zItEZeKDSBVmNFDYah2PBtDLTb/Lg4uKYkU4GLzm9l4YDw7TaJzteXvGLBclThDKhSOS
	 9O5IA+ndDU9tDV20kPFc3stG77TbqMas1O+FIAuGWTRmb4zSyzH/CGlfnhVI6taL2PVhu
	 KhlyWG5X6d6Ub5H3hgf3WJhZiwSGDmWEcxtDYAxIDEz3q6Cky3vnSOq/9tOhIMELwkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IsaBZ0zZ;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B3606A31A;
	Mon, 26 Oct 2026 10:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 711B3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IsaBZ0zZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793011560; x=1824547560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M2VFrPq4/MfSAT20rFUarjC9aKHdAC0wHe0XpbqQ9FA=;
  b=IsaBZ0zZjTSts4QoziFnLt+MORDHTcFU4my1JVsOgqC0wrYSm+dOFgGn
   gun4ihrGjYeZ8zn56++SS3s9g4aFXNEzYn8Ag4lmBnZMtsXL1P5j9h9ps
   BF9Z/YS94pALKETUlhu6rBQW339bp6iST7ltNZwtHTd7PWpZxEvnc0jFN
   NFo5bHm6MVM8V/1c4FEzgL0XqkJYs/MQpLe+MA0ByXVPoA1SD4lNYHphs
   2oKasZ2YfJmcrgFfB+4gg6sDd35yAE4frpGVvFwSY0drBP+500ZeGMwaU
   kCI3x/gD8iJg9obskFm4Oxqf5iqNLMXbG67YqWYb4GRul3RGh+BDV9bI9
   A==;
X-CSE-ConnectionGUID: SBu9JFtGQOaeik1QDiabfQ==
X-CSE-MsgGUID: /1MopfOdS+q5kR9lXhK2XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1569468"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1569468"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:46:00 -0700
X-CSE-ConnectionGUID: QNWgz009S+OW4Hpc+IqPxQ==
X-CSE-MsgGUID: DLP5wdGQSJ6JHtUHvDk6Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4620684"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:45:58 -0700
Date: Mon, 26 Oct 2026 12:45:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9310: keep the IRQ balanced across
 suspend and resume
Message-ID: <at8vYzORcVJY7syV@ashevche-desk.local>
References: <20261026100322.16720-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261026100322.16720-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 03:33:19PM +0530, Arnav Kapoor wrote:
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

> static int sx9310_resume(struct device *dev)

>  	scoped_guard(mutex, &data->mutex) {
>  		ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 1);
> -		if (ret)
> -			return ret;
> -
> -		ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
> -				   data->suspend_ctrl);
> -		if (ret)
> -			return ret;
> +		if (!ret)

Can't we rather move to guard()() and use normal sequence here? It might
require to have this be moved to another helper function.

> +			ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
> +					   data->suspend_ctrl);
>  	}
>  
> -	enable_irq(data->client->irq);
> -	return 0;
> +	/* Balance the suspend even if the device couldn't be woken up. */
> +	if (data->client->irq)
> +		enable_irq(data->client->irq);
> +
> +	return ret;
>  }

-- 
With Best Regards,
Andy Shevchenko


