Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15D12DF136;
	Thu, 25 Jun 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370875; cv=none; b=itpMwpbXbT084pwQ77RKJLT4o+HUAqZGKSpdOIoK52+BIXOP65Tqpxk1WnGb1amNMDUjCnVDJw90UTayY6uM6tLx4fZKGeJfJqgbF1tTR413AWap7+NSvnR3Oq4McxZ3eWkDzAm4ZPjpgCauS4e5zED1gvC7lE+ZFXkQ9wbipeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370875; c=relaxed/simple;
	bh=KITChtIgEjv2Nukeu1pLMFzo8SdGiI3yLvinVmK1FM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7Ui4YpifZquGzhUKG33dhEYRPsxM0J0NZbHQD4/h7n1hzDsqBL1a8L9m/23gpZWDXr2i5eQeOM9jyWMpRZg/1tym6vzdK/I15J9SGZRN5tH39bRVITR5U55V+WsUmh08+FtMAnbh35IzuVdlrl3oA5nuqLP0xb+9wmMqkCaMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKg8Argp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKg8Argp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782370874; x=1813906874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KITChtIgEjv2Nukeu1pLMFzo8SdGiI3yLvinVmK1FM8=;
  b=aKg8ArgpqMH7p26M2nb+8NqeaFO4Z+M5mqfCrMNGXVCCkeUm6+6AUqFc
   McgckbDCSLnBgGNvQsWa1WAV4OLlvF1lHAGhchcf6o8m7i8Rapc8DHoQ8
   BP3ty/MaNSTIzCxJfcTZE4bGsvFRZfW3MJsvkFSsINw7yM6g1wl3aK/kx
   C2TefuUCmnkqgjxMvN9TIo9x6FzkzmV1DpP1Cccx7eaI2COY12mkB0Bk1
   OX/59xav2bI8Pj7wtsEcOkfbUysRdOl0swP4v1TwT20TaBHJCFCiUJDip
   wC88Cm3K/qxhyHZpHF7ShLtsjqkSFnbCeQ9ING9VZ6583vgzlcZ82ur5E
   A==;
X-CSE-ConnectionGUID: rVRyKm+QQOajWVtcXyCfLQ==
X-CSE-MsgGUID: 4OrSv/evRXWIk+QSjcbdww==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="105934996"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="105934996"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 00:01:14 -0700
X-CSE-ConnectionGUID: j5JL2kdDT/+ScQ+NsOmSug==
X-CSE-MsgGUID: FtzfCOSxTsuLfk2p+SzvPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="250536477"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 00:01:11 -0700
Date: Thu, 25 Jun 2026 10:01:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: light: al3xxx: add missing REGMAP_I2C to
 Kconfig entries
Message-ID: <ajzSNDKL8AHjRgm6@ashevche-desk.local>
References: <20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com>
 <ajzNmy3Vhh_Zl9Rs@ashevche-desk.local>
 <20260625085329.00007959@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625085329.00007959@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 08:53:29AM +0200, Joshua Crofts wrote:
> On Thu, 25 Jun 2026 09:41:31 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Thu, Jun 25, 2026 at 07:20:42AM +0200, Joshua Crofts wrote:
> > > This series adds REGMAP_I2C support to three AL3xxx ambient light
> > > sensors that were previously missing this dependency, causing build
> > > failures.  
> > 
> > There are two problems with the commit message:
> > - SELECT versus select (see the comment against patch 1)
> > - you mentioned build failures but haven't provided any evidence, please
> > provide a reasonable lines of build output to prove that

> Sure, I could elaborate a bit more.
> 
> Just run `make allnoconfig` and `make menuconfig` in which you select
> IIO, I2C and any AL3xxx sensor and `make .` will fail with errors such as
> 
> drivers/iio/light/al3010.c: In function ‘al3010_probe’:
> drivers/iio/light/al3010.c:185:24: error: implicit declaration of function ‘devm_regmap_init_i2c’ [-Wimplicit-function-declaration]
>   185 |         data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
>       |                        ^~~~~~~~~~~~~~~~~~~~
> drivers/iio/light/al3010.c:185:22: error: assignment to ‘struct regmap *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>   185 |         data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
>       |                      ^
> drivers/iio/light/al3010.c: At top level:
> drivers/iio/light/al3010.c:48:35: error: storage size of ‘al3010_regmap_config’ isn’t known
>    48 | static const struct regmap_config al3010_regmap_config = {
>       |                                   ^~~~~~~~~~~~~~~~~~~~
> 
> Hopefully this is enough.

Yes, put it into the cover letter of the v2.

-- 
With Best Regards,
Andy Shevchenko


