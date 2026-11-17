Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903598;
	b=nYL0veqh22bvGVuheyRi89TO9eiisUMNHoU6sG3mgNkvoLSQtAz3RDYxwuj+1iPabCfl
	 7kEmBHL+DEM42JnY1wXfhCZtI6THqOmRHpa7l+SIGCwZ9HPjgR7V7J9JfKEB83oY/w4QD
	 wifZ5r60/kk5QkTjApzzkBTwAMovK4qbrOrmBiV8bcf4efd7Q89GByLEnffcLjhCeBiD3
	 t2+xypccu/jIbecA3ozGGHiNh4/GQn7Sq8qDUeCnZLlaX/xXkvncN52+wZzAIJpVjZc6y
	 JzeEm9wEik1nOwbB8dxTz33hCyaSyMdbow1XkYsQLdmVNcagpu2liKMUgulUujRczdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903598;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=I3Fkl9XyeBJ93i7we3bJ3zegOituPdovXvhT1Oiv6l4=;
	b=qpHvn4W8sIPs7qFRjG2GyIzRiAshio7Udnj1j3prksal+zstYQxAEZatbK09rP8Okgji
	 fdWujzwx6n7a6ZCbY/C8PBrnS8V+5YfejRRGhNinm2v2y/Ag8jo90M2skB8L1kYWXKiUl
	 FhNRK6Vc5lcFLnmzZb1VOeKJ1QAQBCKlhzHZA6iKHPeddKbwhhiSBBJM1HifRBc5RdsvE
	 sUaVbdJ6MOGA1+9+do1QBerjk1llF/CoSgYUHzs/eQCsVLR7PsBW9Cv7Ybai8HYYiSGlv
	 AleAx5dGFwgK480OASzHq54a3HnW4cZUqDLqCFuE39lr5aNB58dFAqxR05tb+fwncYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i7y+9rDn;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F20606A31C;
	Tue, 17 Nov 2026 08:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F20606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i7y+9rDn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794903597; x=1826439597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DOlTHnyUnnAelhHtUudZM11kzmmgyaQhPXcXCXIAF+k=;
  b=i7y+9rDnK6VPLXqYgCoARYac67/tchHd3BmVjZe9TAsTM1cgUi495iYN
   nqsOnJRWBw9M2WqEY25j/qm+BrqGEBk5qWhbJVi9g2pSC3j/ApkFpd82c
   1i3s1MGxvBKrIwDZukSrnndkpaNCzG9MNUpXXIj3mh3gdGq6UXbSR+kwF
   f5JRCjqGdanbfDJB5quyQQdL0BOq/b4B9LCuZZNbBpnOxCHw5BjFeilW4
   Y+eXnqshQcHA9pwkVNPlU+bOKIizb7bg2zDCwN4FawHCFPudp7hOL0kNh
   Q/W3KSCrIEIeFNMCbirisPW/Kxih5aWj7OBX22eZWR25pjC4O7o47OoCY
   Q==;
X-CSE-ConnectionGUID: 7g/bQgUyQqmsUkoX+VqdHw==
X-CSE-MsgGUID: WC2ch5NFQLuGdAgg4WJ3Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3675968"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3675968"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 00:16:29 -0800
X-CSE-ConnectionGUID: b9k/il8sRMGH0E3V6Vysag==
X-CSE-MsgGUID: j9iOPpV3RBSvNCi32ETp4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10125478"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 00:16:26 -0800
Date: Tue, 17 Nov 2026 10:16:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joseph Telaak <joseph@telaak.dev>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: potentiometer: mcp4018: Turn on the vdd supply
Message-ID: <avwNWJnsOQaZSWi8@ashevche-desk.local>
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
 <20261116-iio-ad5246-v1-4-ef6b7c06d4b0@telaak.dev>
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
In-Reply-To: <20261116-iio-ad5246-v1-4-ef6b7c06d4b0@telaak.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 16, 2026 at 05:59:53PM -0500, Joseph Telaak wrote:
> Get and enable the vdd supply at probe, so a board that switches the
> potentiometer's supply gets it powered before the wiper is used. On
> boards that describe no supply, this gets the dummy regulator.


+ dev_printk.h // dev_err*()

>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
>  #include <linux/property.h>
> +#include <linux/regulator/consumer.h>

-- 
With Best Regards,
Andy Shevchenko


