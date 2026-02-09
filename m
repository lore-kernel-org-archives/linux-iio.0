Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A72F325719;
	Mon,  9 Feb 2026 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627047; cv=none; b=CESjJp5EL0Z11Gi+4A/g7V6+m7bDRpSV5Oy+kt9BPrzYPHrHE2AR8hyvKdqg72jAR7Wu+8vASfxgb0czfxVNZXH7e3NAg6Zs5qoY29f16es1oHfYwghr3XYzIBOKA27aoaCWpU7EJw2WjqBuBd+xAOlFLu44IBDOBaq0lFxqJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627047; c=relaxed/simple;
	bh=lj6W1szQUTDXezIAILgDU/w7Of5smisYy6l7lA/tDR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxRdlS1rw5vsKzCJQHyNMbbEVZi97iixWkClMc0KGDLKW/E4QdNB/pUTxqxG3pV8cNVPOf9//1+aNNasR95m1+O9lycZMRRkSRiNgyNHoJP7mOygI4zVnQ22aUCRGX8WIYTvaRdDYE+EsSYNsZDYBmrJwOqjt6q/1CNZRCo1wq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cXVXoTuu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXVXoTuu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770627047; x=1802163047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lj6W1szQUTDXezIAILgDU/w7Of5smisYy6l7lA/tDR4=;
  b=cXVXoTuuBMT8J/UILYFNoDQ7I4Sa8baJA9F5Q5athKZvAH1r/pQTUZMv
   3vbtcvFBU7V0YClSlo+uUYbTi1eYbtd4VyQuBaIFt532NIlSDNnksOaIc
   0JSYz3Nz7XvriATe9Y14hDKKrPU92v7RcMS4/ksaCwyR37gFItOAXprut
   olODWyKpttwxbrxCFmMIjOXtVvVdJb2Q5HlCuXxCIIfhgDzBjABCEmINl
   3y+Jj5p9s/eDUXWYODt/kLKgvzzopXIsAWHMqLJFFgzpm3AIGf6nfKvcC
   XOEp6X7VFx5n0IG27fbehQFHfNtkCS1SbfMHabKFpsCzyZmMbxlwjKHtP
   g==;
X-CSE-ConnectionGUID: GmsTvolIRI6Xd4SqqCJ4hA==
X-CSE-MsgGUID: b/6ovBD1Q6epWKEO9DC9Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="75581944"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="75581944"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:50:46 -0800
X-CSE-ConnectionGUID: aXbEPP7CRPuRIWP/LrkjwQ==
X-CSE-MsgGUID: zxAzCHH1TeyvXPQV8UIUrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="211586481"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.128])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:50:42 -0800
Date: Mon, 9 Feb 2026 10:50:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: proximity: hx9023s: support firmware-name
 property
Message-ID: <aYmf4MtCBmwZBuAV@smile.fi.intel.com>
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
 <20260209-upstream-20260219-v1-3-2b4d74e309d1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209-upstream-20260219-v1-3-2b4d74e309d1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 11:37:04AM +0800, Yasin Lee wrote:
> Add an optional firmware-name property to specify the firmware file.
> If not provided, the driver falls back to the default firmware name.

...

>  	struct device *dev = &client->dev;
>  	struct iio_dev *indio_dev;
>  	struct hx9023s_data *data;

> +	const char *fw_name = "hx9023s.bin";

Preserve reversed xmas tree order.
And looking at the usage, please split the definition and assignment.

>  	int ret;

...

> +	ret = device_property_read_string(dev, "firmware-name", &fw_name);
> +	if (ret && ret != -EINVAL)

Why is this special error code check?

> +		return dev_err_probe(dev, ret, "failed to read firmware-name\n");

	fw_name = "...";
	device_property_read_string(dev, "firmware-name", &fw_name);

I believe if wondering one can get a debug information from
request_firmware_nowait() on what firmware file has been actually used.

-- 
With Best Regards,
Andy Shevchenko


