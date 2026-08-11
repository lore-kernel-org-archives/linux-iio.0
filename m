Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BEF40A92F;
	Tue, 11 Aug 2026 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433947; cv=none; b=R3f0nGYSch23qcwDSCsw9W30TuTRcZXnOwwOzUdTDh27A9B1syw9lPhEg2By35svTLLoc8Uo/F8urxDduFbn9808hm7cR+d98vE00QMOFiNEk1D6wMEQbawuvFZkSAnFtASA132CuWo9SciP9Rw0GcryUJ3Y9OoRUDXk6KELR8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433947; c=relaxed/simple;
	bh=dPsnrMcc1aAfVcX7pPCkaHuQc/FAoCMVVi/8857l/AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIt+DNIfYA96DKEyadHmNjQeTPHzXRWv2LU0BVexhwgdhiWOYEk9dzhrYloPztiI2AKoF612keBIJlXfY+x7NScKt2gdyULIQZXDFhOPG3yPjAO1z+PE3Uxn79TayvGo133i9ZxazEg0XTQtHnjb2TqJkXmsRlwI++cai808gw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUTbjCWB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUTbjCWB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786433945; x=1817969945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dPsnrMcc1aAfVcX7pPCkaHuQc/FAoCMVVi/8857l/AI=;
  b=IUTbjCWBgrGF9YNNgakACR8l43o32iR2+rxuPhJyr+Ut/TOWjGUnZXqL
   Qw+yIZ5Hau81nrKcezMB7mX+d8DhHkBYOPkmqS4FLTXNTXjQpit3+2rjH
   3X1Oy1zXCtW1zk0vLLDMajMQHBzGLADbAepe1FZBLnFtHFNbaJchVus3I
   RXiP6Y1lR3CK18zveVZQRkcdsl9bx9IukyTk4uESyctS6erTTawaITfNt
   FyuQaH3DP7s4hMmntJffg5VyKfRnCvuSF/8KEYjrzbg9xcIHkm6RNEIe9
   9k5RFfry/zzVduL9dwD2/iQzR/NI5Ro7ZomiVLkM3u37XMnXlZVDQd/92
   Q==;
X-CSE-ConnectionGUID: S2AAY8XcT468sZw5HE+8gQ==
X-CSE-MsgGUID: IhmHoclASiWejpKlt3pW9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="98317311"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="98317311"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 00:39:04 -0700
X-CSE-ConnectionGUID: 5UnREwKTQAiH0/cjUW7SVg==
X-CSE-MsgGUID: 6SYDTbm9TqSMr3KwMhqP1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="286679318"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 00:39:00 -0700
Date: Tue, 11 Aug 2026 10:38:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: =?iso-8859-1?Q?Nicol=E1s?= Antinori <nico.antinori.7@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	David Lechner <dlechner@baylibre.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] iio: humidity: am2315: add am2320 to i2c_device_id
 table
Message-ID: <anrRkty6ugdJUGmE@ashevche-desk.local>
References: <20260810183337.451812-1-nico.antinori.7@gmail.com>
 <anqKwJOkl_cxzCT6@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anqKwJOkl_cxzCT6@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 11:36:48PM -0300, Marcelo Schmitt wrote:
> On 08/10, Nicolás Antinori wrote:

...

> David's comment about the IIO device name sounds appropriate.
> The am2315 driver might use a chip_info struct to hold the name of each specific design.
> There are many drivers in IIO that already have such things.
> drivers/iio/accel/adxl372_i2c.c is one example.
> 
> An alternative might be to use the device id.
> 
> 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> 	...
> 
> 	indio_dev->name = id->name;
> 
> Not sure if the second option works well for both i2c and dt (probably not), so
> I'd suggest the chip_info approach if you intend to add a device tree id table.

Indeed, we suggest chip_info for the more robust approach when name is provided
via string literals independently on the ID tables (as there maybe same ID in
the tables for the slightly different devices that may be autodetected runtime,
or different IDs for the same or fully compatible component; the chip_info works
for the latter case).

-- 
With Best Regards,
Andy Shevchenko


