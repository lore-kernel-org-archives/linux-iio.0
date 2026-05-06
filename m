Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318B23A9BD;
	Wed,  6 May 2026 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056753; cv=none; b=aiVeAALq/IraTQXTBvnF9uCpkLuBXkeicLn8tPjVF44jOJdfLfvu2oHS6f7tEsdiRAqi2GpvXBnaW0V2qvnTaBq1dB7Hvi8myjeAn8l/slRLgrNrd2tZMkE3Wt6tZecpS8N1M/vaIVuapjoWI2aFcKtL9jZAkK7APiAxzPdekrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056753; c=relaxed/simple;
	bh=p1iObnHvds7CfqMcXEugA3tWbqV3BbZrA9Epcv5ZCtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRf9DP2+d6pSwKqvxXpmmiCdOZFQi4Onf/qvpz0jvd7Dhj6kDJMt6QQcsE3MBBKlddpmiPyzwzAI1B0iaTuohgN/i3tDOWgfjywsM2vV071TAhvmPv3rbegTospvurlGcXwwUi7bIanNPc2mn17BIAj4I24GSTixuF7+ySZMYO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZ9je++e; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZ9je++e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778056752; x=1809592752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p1iObnHvds7CfqMcXEugA3tWbqV3BbZrA9Epcv5ZCtM=;
  b=aZ9je++eQIJnw8Pgv0XwwtxPiUdCENznONZC5MpenwSVhWGOU7k8tbkU
   MAbYWmUrOm0UxVkWN0BllIolOYnTAXJ1Es4IN2QtbwUl2RIPH8g6TZKSH
   zElz1BUkyHbwNLLfPqhb8mF6UPFkNDblAOlcKGbEvP8ifdMLyvanllULv
   cAfIkYeJ1/lhN3q1puecXlAWoSdwrmOodF3poHyxvBtxxBPkLXvE0r2D2
   uVH73AydLxcoUfuVG8rZwjHlhzaocNuWEXqnvU9gzJwKMA1PaHPNFIaVb
   QX9G11TrmyFAUcNPPynrsuXhqJlpOj7eGykRSiJ1eL4SsO59P8+CrPzqo
   w==;
X-CSE-ConnectionGUID: MkuxMj1VQW2JXL8RPaX6fQ==
X-CSE-MsgGUID: 6fP51bIiSomUTHt2dnu5Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89680424"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="89680424"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:39:11 -0700
X-CSE-ConnectionGUID: jHBss+WtTImJPHedRZop5w==
X-CSE-MsgGUID: zCMBSyADRI2s6NEcgmXgGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="240411201"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:39:09 -0700
Date: Wed, 6 May 2026 11:39:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: humidity: ens210: Fix missing I2C functionality
 checks
Message-ID: <afr-KvM756ZAn2hh@ashevche-desk.local>
References: <20260505174943.94093-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505174943.94093-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 06:49:43PM +0100, Salah Triki wrote:
> The ENS210 driver uses SMBus transactions (such as byte, word, and block
> data reads/writes) during the probe and measurement phases. However, the
> initial functionality check only validated a subset of these capabilities,
> which could lead to loading failures on adapters requiring SMBus
> emulation or native-only controllers.
> 
> To ensure compatibility across a wide range of I2C adapters, modify the
> functionality check to verify if the adapter supports the required native
> operations or, failing that, supports the SMBus emulation layer.

...

> ---
> Changes since v2:
> - Fixed the alignment and indentation of the I2C functionality check
>   per Maxime's review.

???

...

>  	if (!i2c_check_functionality(client->adapter,
> -				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> -				     I2C_FUNC_SMBUS_WRITE_BYTE |
> -				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +				I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +				I2C_FUNC_SMBUS_WRITE_BYTE |
> +				I2C_FUNC_SMBUS_READ_BYTE_DATA |
> +				I2C_FUNC_SMBUS_READ_WORD_DATA |
> +				I2C_FUNC_SMBUS_READ_I2C_BLOCK) &&

The above was the correct one.

> +				!i2c_check_functionality(client->adapter,
> +					I2C_FUNC_SMBUS_EMUL)) {

This one is now wrong.


-- 
With Best Regards,
Andy Shevchenko


