Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9D396B6A;
	Tue,  3 Feb 2026 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113017; cv=none; b=PtUuBHQgetdm1gVthaHHXzd1zPci0EyG+gQfyYHCWvYuJb0Z33u0Z2UxRCLJPtUwcvEujmGltrUCskFIhooW9eNjeADyQXAt6EbXcAvyHaORK/D1ANNxMtIm3J7NPz4sc5R0JbwhG6bigGYXyBCt1L6Jv5v15gNv2Q7I5ox3hm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113017; c=relaxed/simple;
	bh=6ZkV3ByHK7lbbphiAJiVTRBt4VdeKYBWGsshtVaY7K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud/WVj+HVufUJiYxkI/WA6ZHSpY7bA/obMs9cB8eI/rjHxQ7EZx20GezfxVzQ8PlFb9t4iaF4IPv7a5zAKWgvOcXt5bOMz7ujcl/WiwGQ8x65+ucsGUn1KeekMNYXTgQO3MLFZhJJYGjF43TeSY6VN+BiHGQKwUqcwH4kiK8qCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACqs4WtL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACqs4WtL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770113016; x=1801649016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ZkV3ByHK7lbbphiAJiVTRBt4VdeKYBWGsshtVaY7K8=;
  b=ACqs4WtLOnKY5LCNoTADtVy9GqU9WjGNYEL5oQgO16afQNrVvsoqbYUY
   n3ECawpphVfOGqvqWnpbKPwg5vTG+BeGeKqc8y110LEAf7RfO7SY6xL0n
   SYz3In1TqzMc/4Dx4dgzPRHz6qrjDNX7KZidr88G9mXab9boJc4YMHXMI
   frL2uPN/p4XDKKVUYdPnPBpKWcxYUOcYNyZ5OIRsx1YOwhQ5FqPVjpgFl
   iwovgEwfg18l+HHN79vr0A/dhkN7lE7LwzXuC2AFlMTC/mvw9UaXqDkYS
   iLuEJHlT2M/qQ8vAMMof8AzBOz1oUJycSsrFjEMNqv011ggvbdaEMB2Po
   A==;
X-CSE-ConnectionGUID: 9f3ZBAQ/Qoa05LThSOOY/A==
X-CSE-MsgGUID: Xmde7HO0SpWeZzC2vHHuSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="70297660"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="70297660"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 02:03:34 -0800
X-CSE-ConnectionGUID: hhpHB20mT6qV9BkswWv+ow==
X-CSE-MsgGUID: Yktz9S0wSqiTsYlcCgn0Fg==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 02:03:26 -0800
Date: Tue, 3 Feb 2026 12:03:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 06/13] iio: dac: ds4424: use device match data for
 chip info
Message-ID: <aYHH69gXyuwmQR03@smile.fi.intel.com>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
 <20260203093434.2548978-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203093434.2548978-7-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 10:34:26AM +0100, Oleksij Rempel wrote:
> Refactor the driver to use device match data instead of checking ID enums
> in a switch statement.
> 
> Define a `ds4424_chip_info` structure to hold variant-specific attributes
> (currently just the channel count) and attach it directly to the I2C and
> OF device ID tables.
> 
> Use `client->name` instead of `id->name` to decouple the probe function
> from the legacy `i2c_device_id` structure.
> 
> This simplifies the probe function and makes it easier to add support for
> new variants like DS4402/DS4404.

...

> -	indio_dev->name = id->name;

> +	indio_dev->name = client->name;

Isn't this an ABI breakage?

-- 
With Best Regards,
Andy Shevchenko


