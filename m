Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB63D7D8D;
	Fri, 17 Jul 2026 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284251; cv=none; b=nMBj4RE7z7k+H0sFxvHwQv0Pn35YKBS1SGspAJut0v42T4mDyqay2oaGHPV3dESAUhePXRAnL3Jz0RLZDaAu1rJkkJlDkBymAuvSjDML/AdBKyMVAWzoUsuPq6JAL8esmqBVkkvr89mQTCZE9BXig9Wg9lpHXPZBvYqV2q3P4Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284251; c=relaxed/simple;
	bh=YBnXw/GRsUiXIQas/2eaJkgwXKv5sJhNxhJDePs9anM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ewk83ZWpx9V76THlsreOiiqh5jWlWnQYUpw7KZYicpLMCiO22FhjQrjQszs3hI7852g3xJY7BTl2soCwTIsOyqabULkt+9RBvlxktz3kqjd6C0eGFXIQttgv71TETQloNlEiH+uLXKMrrt4jOLeLmDlX6zzkOYbXml4pTYqbeYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsQn0e/x; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsQn0e/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784284250; x=1815820250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YBnXw/GRsUiXIQas/2eaJkgwXKv5sJhNxhJDePs9anM=;
  b=CsQn0e/xbJAzqtz0vYts1yM/q93VObxNKnjkn9BYOQzGv5uB4JXfyFWX
   NM/kKI36WG5KsMGb91UaRZBUTVNaSRygmV7GBEN5x3tYuRyTL2d45CHm3
   HXwOtAYRoqSvFz1p6danN1Zne3C4N/mHdDEzYoH+GT9qEMRs7AjL2ZrBh
   68jpbr8amFA/YjOdhlIYE5ies9MJ5r9bTe7e6C26oqOTwSDHS1Pfwjtyu
   UZ+lE94z7+/oDe8bchA0aEYNt1yABFjskU7Rle+iFsxOO2kZNykA4O+IX
   cgJbNDHObwhTSK5nAvbOpnA5HAkRYfEwAbyB09/MzoegAi7uPo6lYWCG9
   g==;
X-CSE-ConnectionGUID: MOqV52CxS7ierJHZuCJ6aQ==
X-CSE-MsgGUID: Nx993GN2QYGz3C+ChvsH6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="96088579"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="96088579"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 03:30:49 -0700
X-CSE-ConnectionGUID: Z8tEGanXScmH7LhaOMNjQg==
X-CSE-MsgGUID: HgoM0G2nQIWFYA3n9fFa7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="256831875"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 03:30:36 -0700
Date: Fri, 17 Jul 2026 13:30:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Linus Walleij <linusw@kernel.org>,
	Anshul Dalal <anshulusr@gmail.com>,
	Song Qiang <songqiang1304521@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Siratul Islam <email@sirat.me>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>, Miao Li <limiao@kylinos.cn>,
	Andrew Davis <afd@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Shrikant Raskar <raskar.shree97@gmail.com>,
	Chu Guangqing <chuguangqing@inspur.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Felipe Khoury Dayoub <felipedayoub@usp.br>,
	"Rafael G. Dias" <rafael.guimaraes.dias@usp.br>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Salah Triki <salah.triki@gmail.com>,
	David Carlier <devnexen@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yash Suthar <yashsuthar983@gmail.com>,
	Achim Gratz <Achim.Gratz@stromeko.de>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	"open list:ANALOG DEVICES INC IIO DRIVERS" <linux@analog.com>,
	"open list:ADXL355 THREE-AXIS DIGITAL ACCELEROMETER DRIVER" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] iio: Remove redundant error messages on IRQ
 request failure
Message-ID: <aloESr1dVkAh784F@ashevche-desk.local>
References: <20260717094408.509583-1-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717094408.509583-1-panchuang@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 05:42:23PM +0800, Pan Chuang wrote:
> Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()") added automatic error logging to
> devm_request_threaded_irq() and devm_request_any_context_irq()
> via the new devm_request_result() helper, which prints device
> name, IRQ number, handler functions, and error code on failure.
> 
> Since devm_request_irq() is a static inline wrapper around
> devm_request_threaded_irq(), it also benefits from this
> automatic logging.
> 
> Remove the now-redundant dev_err() and dev_err_probe() calls
> in iio drivers that follow these devm_request_*_irq()
> functions, as the core now provides more detailed diagnostic
> information on failure.

Same comment as per your other series.

While at it drop all these ' != 0' and ' < 0' noise in the conditionals.
With that being done, feel free to add my
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


