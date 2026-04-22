Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA951F151C;
	Wed, 22 Apr 2026 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776844440; cv=none; b=mCdotMReQ0EFbMUT3FiaViwXLxqb2gmmwNdW5vpe19taSod3wabBDZuQw7mLbxw8fGZPsUzwY9ppu4xmCX2HUUM3lkZAjwfyJH2NbK51xCVspRuZeSgwQs7tJ7GT4kjXhxgWSRLqyAB9foJqFAYBnWX7dnHbGFHux9wlUyCiYdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776844440; c=relaxed/simple;
	bh=oi0UDUUN6vvSYlHGf/6u9OZRwO6C9LdpXUOXyj9Mz/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM+vlrJ7c44Meeu228XHeqaErKvLKpC7rlPnPebkRfXaNEARKcgZPro8qGsbpVNYl95gqqUzZC06m3+cCZ9gPyhKtRySF6JGli6mnjRfEojk+rPcMA3WN/TMoPm7fNXtoWkGaRA/I5tkUm7C8ezJUcpmZ6ufsJXvfsWl8vYsc9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtL54JS/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtL54JS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776844438; x=1808380438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oi0UDUUN6vvSYlHGf/6u9OZRwO6C9LdpXUOXyj9Mz/M=;
  b=jtL54JS//ZPvDAjca7CGO5KyvuOiowpmxMboxsk4YfYEyt4e/0sOfGDA
   z7pcnFf9LgTbpeHhGHyNSzpp3kLu1KVNy8TEXuRnRNc3W0wg0UBVBeG4L
   lhhZRFdUTLx51595rBMxCpwplVieNIFJ9CRgHGJckJ59IKkPv/INKpHVx
   XeBZl5x6f6mD4NnjDzEadQp9JDN0G4cP+Gvp5efIgT+unT6RnDrkcy62C
   BzbuVcaLQe7dR5J+WLTAUlu13Zx0oCPl9FznoJIgofntqbpI4Pkf2Vu6K
   2OfxaSF1/5tKnE+8FyZrtAK1In0vgKU8GFc/01ayx4p2WJ3jAChPTylLW
   A==;
X-CSE-ConnectionGUID: rjXbQOPAQZm1crMrNF+XiQ==
X-CSE-MsgGUID: DSwZiEY2R9m1MsTOqtLoQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="95352982"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="95352982"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:53:57 -0700
X-CSE-ConnectionGUID: is+bu6kzRBySpOBsjsVd1g==
X-CSE-MsgGUID: SxoJl+N8Q+euxNojdpyfgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="270384827"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:53:55 -0700
Date: Wed, 22 Apr 2026 10:53:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, gye976@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH v5] iio: buffer: fix warning in requesting threaded irq
Message-ID: <aeh-kV-XNSaWhohW@ashevche-desk.local>
References: <20260423014426.1999735-1-junxiao.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423014426.1999735-1-junxiao.chang@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 23, 2026 at 09:44:26AM +0800, Junxiao Chang wrote:
> IRQF_ONESHOT is for threaded IRQ. If there is no threaded IRQ
> handler, this flag should not be set.
> 
> This change fixes a warning during booting with kernel v7.0-rc3.
> Hardware: ARLs(Ultra 9 285) desktop
> Software: Ubuntu 24.04 + v7.0-rc3 kernel.
> 
> WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x1639/0x2510, CPU#3: iio-sensor-prox/974
> Call Trace:
> request_threaded_irq+0x2c7/0x490
> iio_trigger_attach_poll_func+0x353/0x6b0
> __iio_update_buffers+0x2420/0x2c70
> enable_store+0x183/0x270
> dev_attr_store+0x5e/0x90
> 
> There is no threaded handler in thiggered buffer setup, e.g. vf610_adc

A typo here: triggered.

> and hid-sensor. They might introduce this warning.

But you see them IRL, right? Can you just add a point to the above list:

Hardware platform: ...
Hardware sensor in use: ... <— this to be added
Software stack (OS): ...

?

With that you may drop or rephrase that to

  "There is no threaded handler in triggered buffer setup in other drivers,
   e.g. vf610_adc and hid-sensor. They might introduce this warning."

> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> ---

...

> V3/V4: https://lore.kernel.org/linux-iio/20260421103807.7ca935e9@jic23-huawei/T/#t

('T/#t' part is not needed)

> V2: https://lore.kernel.org/linux-iio/20260418002334.3643504-1-junxiao.chang@intel.com/T/#mc0803722dce6585bbc8c9e0ec8289bd96afe99aa
> V1: https://lore.kernel.org/linux-iio/20260418002334.3643504-1-junxiao.chang@intel.com/T/#mf0eba6c23049d15c2b43ea5528b5f5a47e216c58

Click there on the permalink to get the proper link to the mail, now it's an
indirect form of the links.

-- 
With Best Regards,
Andy Shevchenko


