Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780149;
	b=G+W/Kmhp3wDC1zF2Crlx3EArCebUvGR6GAexoErQB135Be92AIh7h/uRucCPD8e8u5LU
	 GjqnXP7MPtlNTI1Z4r2YXT/lVjX017mrtSKZB4NCnwaURN3QMB28MVDqJEdUva10SqzYj
	 Oa+0MClrZmW/RYXtWXF0gqJLBfWkzfoKruabyvCGZsbqE0SdMkvywDYdoFxCoglfTXsJz
	 AEqjvFoNkF5pXv1Lr/OlliJng9R71+CMURZo43IVY+Ee/Rs16cgDXBSBNMukvCVph4liX
	 E/kUUxUwxYpw66JiBZ09dkaqAyt45kE/I9htUB/yxFEP846XvBF61h30+uNUiAICC6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780149;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=LHjds6ciTHOu6s5j7BpqtZ+KJ92VAdObR2G5YzE16cg=;
	b=YczUd1esk2vi6oW1a6/bscC6yJT3DoNv9s7gP4O6v4gyi07goWHtCG68pxEbac0ZCt0H
	 8q0/O0mDd+q2YHVFbhNr1esXygcxail7yWpfWY284DjyKy+54lhpeh6dvj+Tat/PKDeEV
	 eOBfdkpIJsqpUJ5PFmGcvLLe07gQNNx9ZeFmgfYjKr4HE2dWN1IAp0Px0L5Kgo7Xtrspg
	 0vG+hE82TLLoMBEfibuQje0tTJu4Nj6UpiuJQxMNRL4g7vNoXf0gFOT+QF4rVC/gG18ED
	 nEvcNzE66L9c6TxwoV8Jktfw7tubcQORQDx2/+A54A6jJWs2OIyPJyBM7z71TE14DTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PvWbOBlM;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F143606A32D;
	Fri, 27 Nov 2026 11:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F143606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PvWbOBlM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795780148; x=1827316148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XzHVhYO5Bak9DTZPT1IGDE74DbrcFKazihZbhV2Hdag=;
  b=PvWbOBlMAtdbir9JQui5Ffqc3wg7js0d46d3JoU/FZzOqG/QRHXj+vTo
   5b0u+cNoGnwxZeJrvw1WTgQnmStjniVBZG+17E1BmoNi3AsyQFuAMmchO
   jzTeUEsjhwtAXO0U4348OEwYuhPFZcln8xyt9xqNZAdp4sE4mfY/WzzaA
   QhvNzHdsZ+aP4XuiOYONkyMT+cQ61RGR10SGd/JiEFnbqVyM84MJvcY+l
   C3vCSvLmqZyKJSTG/lgC41Ja2XpaXWNqY+2GIWFXptbsWbYFSZnZ5tCBN
   dufo9cY8rMfgxHQhydX+WmKL9ToS9XjZNZUDpKC+TJsnD9UC5lkrgbUjA
   A==;
X-CSE-ConnectionGUID: CGeDpdKySC6zKh+ZUnEhyA==
X-CSE-MsgGUID: i3CAUZzTStCReuita6VBGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4689337"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4689337"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:49:08 -0800
X-CSE-ConnectionGUID: JYW6xWC5QziaeZB7uvjkeA==
X-CSE-MsgGUID: XbTyXrfQSQWOGM+FJxjZKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12292067"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:49:05 -0800
Date: Fri, 27 Nov 2026 13:49:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain TISSERAND <romain.tisserand@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 0/4] iio: adc: Add the Miyoo A30 and PocketGo S30 analog
 stick MCUs
Message-ID: <awluLgvMt9BN1Aj8@ashevche-desk.local>
References: <20261127012612.1589039-1-romain.tisserand@gmail.com>
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
In-Reply-To: <20261127012612.1589039-1-romain.tisserand@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 27, 2026 at 02:26:08AM +0100, Romain TISSERAND wrote:
> The Miyoo A30 and the PocketGo S30 are two Allwinner A33 handhelds
> whose analog stick is read by a small microcontroller: the MCU samples
> the stick potentiometers and hands the raw 8-bit readings to the SoC,
> on a UART (A30, a stream of frames at 9600 baud) or over I2C (S30, a
> four-byte read with complements). Neither MCU takes commands.

Why a brand new driver for each of the cases?

> Both drivers expose the readings as raw IIO channels for the existing
> adc-joystick driver. The A30 MCU pushes its frames on its own, so its
> driver also feeds a software IIO buffer and adc-joystick takes the stick
> from it without polling. The S30 MCU only answers when read and has no
> data-ready line, so adc-joystick polls it, as on the Anbernic RGxx3
> boards where the stick is behind a SARADC. There is no scale: the
> readings are raw ADC codes of the MCU.

> Patches 1 and 2 add the A30 binding and driver, patches 3 and 4 the S30
> ones. Both use the existing "miyoo" vendor prefix (the PocketGo S30 is
> a Miyoo/Bittboy product). The board devicetrees will be sent to the
> sunxi tree.
> 
> Testing: each patch built with W=1 for arm (multi_v7_defconfig, both
> drivers =y and =m) and arm64 (defconfig, =m), no warnings;
> dt_binding_check clean for both bindings; the board devicetrees pass
> dtbs_check with these bindings.
> 
> On a PocketGo S30 on 7.3.1: about one single read in four fails an exact
> complement check (the value and its complement differ by a count or two
> at rest, up to about thirty while the stick moves fast); with the +-2
> tolerance and up to three tries, polling as adc-joystick does (two reads
> every 10 ms), no read failed over 2 x 6000 reads at rest and moving, and
> under 2% needed a second try (exact check: about 4% failed). The in-tree
> adc-joystick driver on the S30 channels reported 365 and 374 events over
> 15 s of full circles, 42..231 and 24..246.
> 
> On a Miyoo A30 on 7.3.1: rest 136/123; reading the channels from sysfs,
> full circles 22..248 (X) and 11..221 (Y). The in-tree adc-joystick
> driver, without poll-interval, takes the stick from the IIO buffer: 826
> and 852 events over 15 s of full circles (the MCU sends about 67 frames
> a second), 37..246 and 11..220.
> 
> Retested with this version on the A30 (7.3.1): with only one channel
> enabled in the buffer, each channel gives its own axis (stick held
> right: ch0 alone 141..242, ch1 alone 116..119); three unbind/bind rounds
> with adc-joystick bound: no warning, the readings and the adc-joystick
> device come back; at rest 139/118, +-1 over 50 sysfs reads.
> On the S30 (7.3.1): at rest 152/126, no failed read; adc-joystick 1213
> events over 15 s of full circles; three unbind/bind rounds: no warning,
> readings and adc-joystick back.

-- 
With Best Regards,
Andy Shevchenko


