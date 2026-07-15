Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C95921CC71;
	Wed, 15 Jul 2026 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098274; cv=none; b=cXeLWs06FibLKxuHyRdnWM6lJ4MIlzfP7+GNX7UBltzgEln/QI03FL+VVgWWCcJM4w2SyEdrRq8ZB1kWq/ZUDmOqCJ9aFkPFyMAzjrT1gnjhRnM7VP6gH8TRuMCRAOVVJzeG6UU8QvkbcPgfIlB7nFh4nPcJtwza83bfFugMmr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098274; c=relaxed/simple;
	bh=jm3Fp1OxVfLWQNXEgcghvnmtKSa9n+UQn9qCVN6+yc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzntDo8s1n/32HG14C18pLhWL7Tvi0pHPJhJTUD3Or4wyOSFRh477aL8rX+IQffnLwRQ92XSdnju1C6R+XZUHY/H8HD03EqlADBBSze3v4vtFdmFKkq4xYS/042dI5gn7Jt2+uLZe+XrjP8O4RDvhOxF+8CqZJUzPNQmEORkJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPchxVhL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPchxVhL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784098273; x=1815634273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jm3Fp1OxVfLWQNXEgcghvnmtKSa9n+UQn9qCVN6+yc8=;
  b=KPchxVhL7K0/2dJv8Yo9BOOR5vh/VRh1K5EtZ7tIstmXnK/+N+FXZbxq
   08tiVQyiO4f/iujCRgg27/ziKdSrjWXQgdvlf6i+2dtdhOFPRblqEV2Da
   ZgvUzmZxTGbaAsqqIm9KdCPB7ymi028XA4WWQs7oiSPiXgLXU5DbJ41ln
   T9GWzYMPKbUWPuQkXmxk/2VmJ50WU32mSLNpnj9jLFd1uYydzexGFRNnL
   CyN9reAiq4WpxurjQn1GcnaOLlKmtm2y3vn5y96a5vje6XlSb4WfeOjJE
   XN83We+Zy00qnYNtjDL064mrqPfTB90khBt2mSU9tm6+My7l8eiFbkq1W
   Q==;
X-CSE-ConnectionGUID: /lp2AuI7RKyZrhh5PXIEXg==
X-CSE-MsgGUID: LWnpeLBHQPyFcGJEdqNZCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84843826"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84843826"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:51:12 -0700
X-CSE-ConnectionGUID: FgmvN1u7Romd21DsaFUtUw==
X-CSE-MsgGUID: GMTfaPmVQuaB2s3PLm5nMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="286155256"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:51:08 -0700
Date: Wed, 15 Jul 2026 09:51:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Siratul Islam <siratul.islam@linux.dev>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <alct2kGoQAC8pNMd@ashevche-desk.local>
References: <20260715063652.368501-1-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715063652.368501-1-stefan.popa@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 09:36:15AM +0300, Stefan Popa wrote:
> This series adds support for the Maxim MAX40080, a bidirectional
> current-sense amplifier with an integrated 12-bit ADC and an I2C/SMBus
> interface. It measures the voltage across an external shunt resistor and
> the input bus voltage.
> 
> The driver operates in direct (INDIO_DIRECT_MODE) mode. Each raw read
> triggers a single on-demand conversion (SMBus Quick Command) and reads
> back the matched current/voltage pair, so results are always fresh. It
> exposes the current and voltage channels with raw and scale attributes,
> a configurable oversampling (digital averaging) ratio, and PEC-protected
> register access. The two selectable current-sense ranges are exposed
> through scale/scale_available; the current scale is derived from the
> shunt-resistor-micro-ohms device-tree property.
> 
> Tested on hardware with four MAX40080 devices on an I2C bus.
> 
> Regarding Andy's question about *iv being updated even on error in
> read_poll_timeout: yes, this is intentional. The poll loop must update
> *iv on each iteration to check the valid bit. On timeout (conversion
> never completes), *iv contains the last-read value with the valid bit
> still clear, but the caller always checks the return value first —
> "if (ret) return ret;" prevents any use of the stale data.

My point also is that we can do it only once. And since the above a comment is
a must. See more in the comment I'm going to give against individual piece of
code.

-- 
With Best Regards,
Andy Shevchenko


