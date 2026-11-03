Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706639;
	b=i+rd+tsbaSxUMlCcZVEQE2LtGshjTV3b6eYIwftJPIP+6RYcPbXzuX/Ow2P7yJs7MZ69
	 VaXw8Jtmj3pE8zHLa8z25lJzK43F+NjNGfguFpYRlL4jXS23lsosA0wnQre5Ts7lxqtnG
	 INpojwq2qnjYuauDAth9MevBivk22gOx2s3VpD2CABrdH+sQDua96U/qkxTJ5XVkplD+v
	 vGHa+E1QZnM8SYBjIvNYVf6sLSWRT7ur31Zq2nVkGqTEtW5wTGQq9pLs7RG3fo6xw7x51
	 Soz30V71LbDsk20QrWW1L4XdFJOUAs6hVluECqtLANJNNtnjORmtNf452r1LSUluLwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706639;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=J5ylKNuin1LZMmgIF/8LPxT0Doar8l8mhrMQc1igFaU=;
	b=Ly5I2m+RP76JsaKceu4DTviW2eEgq/TPbcLwhIxoz2GSMdw5uluCmfZ4VGfTgdWRMavd
	 2TU/k9TWjE6PUaifUcl+TmoTFQHy7WmoTjwWhJm7tbB1BCxYEhsmxfSBvnOPXN0QEbWgE
	 SipoX3gk/jS3Q+WqW48SffzDJN65tGn0//cNDmES7xxUds3XqCBoKaGRKsPpDan2iypfu
	 WCiBf1Ovszo+XG0FIgKUb5cK4dhINWpQN8AypRQlXq55AEOhN5Z0D5M7dfHRFSwXWS8gh
	 4hd3aU3yRhk5sbzq99s17mm1tEtEZ6kYpjdSVk515pKH1WgU9sFwNGqaUU/ZegSruoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ypz6xYHo;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B6D606EEB3;
	Tue,  3 Nov 2026 11:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20B6D606EEB3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ypz6xYHo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793706638; x=1825242638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XPRQrHV8qvOW70VHhKROgx5AfILIuPwXUOs275wQqgA=;
  b=Ypz6xYHoL/SpkNYsG+LNnrtHjB7WMQfq/qEKO4j9pGI57/gU7YW8Sdkg
   0FhUMjxKtffEFFNH4RJ64njqkSCm4mQzOGMK2NLxqbMn13Om65ZZkQApV
   g3iXqVPhT0KtMvzhckGmoTy0jsXInIw1J14HzvkdbCPmgEDZDiugSvJbU
   VGd8uU1pI0dzX1ABSgfw6+Lqk1W4Su2N2xMbOej0+W7CYJRU7OV/9FlU6
   5d2Q38KUC/qI8OpWwpOGLj77yI33bmL9PrVzeko7ARBQlR6KXcgstDn9N
   70kSKCzDXnb+VojC4vscUg0FOUtmBYOZLHrLEx+H8SuvDLBlvSBb65WO1
   w==;
X-CSE-ConnectionGUID: r563xNCiSPSAlvTCjfBBww==
X-CSE-MsgGUID: cJ1Gc4FvSjayDwzYzBul0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2456262"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2456262"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:50:37 -0800
X-CSE-ConnectionGUID: JxUfLLtWS9OqqGK40Iv9DQ==
X-CSE-MsgGUID: C+QRoI2BSrCvkZJBPGsVzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6765508"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:50:35 -0800
Date: Tue, 3 Nov 2026 13:50:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: pac1934: validate the ACPI channel
 configuration
Message-ID: <aunKh9KH0-iZDWIl@ashevche-desk.local>
References: <20261103114100.74050-1-k.chen@smail.nju.edu.cn>
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
In-Reply-To: <20261103114100.74050-1-k.chen@smail.nju.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 07:41:00PM +0800, Kang Chen wrote:
> The four _DSM calls that describe the channel configuration trust the
> returned package.  The first one is walked in pairs and its count is
> used to index the four-element labels[], shunts[] and
> active_channels[] arrays; a longer package writes past them, and an odd
> count reads elements[i + 1] past the end.  Non-string or non-integer
> elements make the driver use union members that hold unrelated data,
> including a firmware-chosen pointer for devm_kmemdup().
> 
> Validate the object type, the package count, and the type of every
> element before using it.  Allocate the labels with devm_kzalloc() and
> reject an impossible allocation length, so the terminating NUL cannot
> be written out of bounds on 32-bit systems.  Reject milliohm values
> that would overflow the u32 micro-ohm fields, and micro-ohm values that
> do not fit in u32.  Also validate the single-element bipolar and
> sample-rate packages before reading them.

There was another patch with better alternative. Check it and test instead of
this one.


-- 
With Best Regards,
Andy Shevchenko


