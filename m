Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD68420E6E2;
	Sat, 18 Jul 2026 06:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784356248; cv=none; b=EcwxermvLD73DiCfE0WJ6nh2OkUlEGVfAfeJJBzfRRlXaWfbOjW+GNMOkH/G9Ui+uz6ybFXBI1g5mY29HR1l8nrlFYbzM+ANEtZ+2Bj0YBxsPoDJddJ1DflPixCM9R8XiQyqpgwVZENwrejoa6Bt3Tt2y9l8AhhbqDzNx5rDUAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784356248; c=relaxed/simple;
	bh=rchuGNLPskUiIOKT2Xps7hbTJdPgyyv9BWLy5bQy7GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y73drqIZ+jHx9RS03ixCHFuWZaRiWROVhAGCUWh5Qb/AXLW/RgSOjPou2OTHAVeeluuMbG7zvGY6yurcTkry8w06sY1ZzRqBv0IvPg2/s8y+tAj5wkuu2vhDs43MuXfFTVlOnOQ1vdUl2L+erBdfel/vbnEDEOBiw+SW/+XVkHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/FgvpV0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/FgvpV0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784356247; x=1815892247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rchuGNLPskUiIOKT2Xps7hbTJdPgyyv9BWLy5bQy7GY=;
  b=E/FgvpV0eRgqe7dnN2vpQvZ2oJE+jC8ywK8sEdUOXAy6A/hIBv7OqRQ5
   uhtES7hZsc1jdQHflTd6PGGvlK22s9kDqnEcXPfce46ydHIUzK9iLdb7x
   JlmrnzuOPdJ15Kj89Xk3u/UtsXgGvCSyz/5xSjstC7VVYk25CuHXGPF7o
   ut7zjDQrtqdP89YCo0948PlWBMqqo6lSjAyOaOx0LesNzJaBJr2vplEez
   o+fKfu04X3gGzpO5aKn/VbPJ7pc6sCPrnnAr1EECuL4hQKKDpzyiSV4Ac
   Li4sfFIVJ8dMD2/i4gJVipDDl3cCBa+2NkxdDd3OYXBYvWIk/OENY/5S6
   g==;
X-CSE-ConnectionGUID: VOjD1TdYQri1qhXp1tercQ==
X-CSE-MsgGUID: 4lEic08UQwaSrtmMu6j4nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="95373818"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="95373818"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 23:30:46 -0700
X-CSE-ConnectionGUID: 2s1BDf2BTlGFps1S+ll5NA==
X-CSE-MsgGUID: Tt03wpK2QwiqQWMUvpH3uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="257052371"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 23:30:40 -0700
Date: Sat, 18 Jul 2026 09:30:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Pan Chuang <panchuang@vivo.com>, Puranjay Mohan <puranjay@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Danilo Krummrich <dakr@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Siratul Islam <email@sirat.me>, Bjorn Helgaas <bhelgaas@google.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dixit Parmar <dixitparmar19@gmail.com>, Miao Li <limiao@kylinos.cn>,
	"open list:ADXL355 THREE-AXIS DIGITAL ACCELEROMETER DRIVER" <linux-iio@vger.kernel.org>,
	"open list:ANALOG DEVICES INC IIO DRIVERS" <linux@analog.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/13] iio: accel: Remove redundant
 dev_err()/dev_err_probe()
Message-ID: <alsdjkj1nlDhwr3j@ashevche-desk.local>
References: <20260717094408.509583-1-panchuang@vivo.com>
 <20260717094408.509583-2-panchuang@vivo.com>
 <20260718002039.45096da8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718002039.45096da8@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 18, 2026 at 12:21:12AM +0100, Jonathan Cameron wrote:
> On Fri, 17 Jul 2026 17:42:24 +0800
> Pan Chuang <panchuang@vivo.com> wrote:
> 
> > Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> > devm_request_*_irq()"),
> 
> Please rewrap in a fashion that keeps the commit description on one line.
> One option would be:
> 
> Since commit
> 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
> 
> Idea being to make it easy to grep for.

One should really start maintainer-iio.rst!

(checkpatch is taught to check the wrapped versions of the lines, so I think
 your comment is for making this easier for humans.)

-- 
With Best Regards,
Andy Shevchenko


