Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835F3E92AD;
	Wed,  6 May 2026 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057617; cv=none; b=nUzYb0juoQf/2Ij+pn3+ZkXu3+QXH7DmPXAzR+57EQPdv61gZr0jB0otPjM/59txhOSjwbH+VNFp2Hz+hZZihrDbjTz+9vOa9dZci/ZkJiL3GtiHFGRCD0ioi7TaGM0l4oKHBM+vLS5aPo8CTyuNIEKIMdsBZDLWpX6/zwr2tmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057617; c=relaxed/simple;
	bh=GCwDptr9zcJYgIo1E1xiUctedw02EdYvlC2nCBm8qBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7cetH3JRBM9Q1w/zyVRuC7tPQqVBXOwL9Kd0JJzVUUrMxHombAQKRqevS9cCX3OkQFHeza+NXrL+vIu7N2KG0ha0sXi9TWoxJK062AQdzf8U4gStb0uxcN+bcdbDD9Rp09RELct7D3C/if8f1o3nC0i/Dxrx7f9iQaMGGBvEE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bS1Suog1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bS1Suog1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778057616; x=1809593616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GCwDptr9zcJYgIo1E1xiUctedw02EdYvlC2nCBm8qBM=;
  b=bS1Suog1ZkT8qkGShqRoJ2l8WpJrxeqbcx7PQzjjO0RZntRjEk4ZHRVv
   O9Guarh+KdamLV6aXMgZ87dvLPw7Jr3hm7fboPZXEOjuHZs3jrRrGzYA5
   oPIKWNTuC3NBJBzxUqBQhrz0eMEvEdhbm5P2zqqBpiVeXZ3QXQdX9e0bU
   MGtxSeO75clQVniw0r4PbR8ZpmZiibnqxzAWTw8e/jP5/eC1loqIPn4zJ
   TEGZcfy2/q7jUPAUhvQnbn7HNVXVBCzagZFJmSOtDjJjYe60BGTJ7WDGc
   2faN/xV9Rs8FTKcPajVHp7uNuLCJ7bFxferIaT14MP8RLPdJ3Q53wieQg
   Q==;
X-CSE-ConnectionGUID: T82bTWZXTIKAbrGTPr9Yrw==
X-CSE-MsgGUID: HQ9E0WERRM6QiAdDaYSx2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90438532"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="90438532"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:53:34 -0700
X-CSE-ConnectionGUID: JD3AfRWuQnuZJMAzXPsixw==
X-CSE-MsgGUID: SVz1HPZoSoqW5inpL9Bt+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="240065162"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:53:31 -0700
Date: Wed, 6 May 2026 11:53:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: humidity: ens210: Fix missing I2C functionality
 checks
Message-ID: <afsBieJ3u2onJVyp@ashevche-desk.local>
References: <20260505172246.90892-1-salah.triki@gmail.com>
 <DIAX965B07NK.16AH0B7XEZSUN@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIAX965B07NK.16AH0B7XEZSUN@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 12:33:36PM -0500, Maxwell Doose wrote:
> On Tue May 5, 2026 at 12:22 PM CDT, Salah Triki wrote:

> [snip]

> >  	if (!i2c_check_functionality(client->adapter,
> > -				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> > -				     I2C_FUNC_SMBUS_WRITE_BYTE |
> > -				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> > +				I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> > +				I2C_FUNC_SMBUS_WRITE_BYTE |
> > +				I2C_FUNC_SMBUS_READ_BYTE_DATA |
> > +				I2C_FUNC_SMBUS_READ_WORD_DATA |
> > +				I2C_FUNC_SMBUS_READ_I2C_BLOCK) &&
> > +			!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_EMUL)) {
> >  		return dev_err_probe(&client->dev, -EOPNOTSUPP,
> >  			"adapter does not support some i2c transactions\n");
> >  	}
> 
> This alignment doesn't look right. Probably should be something like:

However the end result is wrong, this one...

>   	if (!i2c_check_functionality(client->adapter,
> 				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> 				     I2C_FUNC_SMBUS_WRITE_BYTE |
> 				     I2C_FUNC_SMBUS_READ_BYTE_DATA |
> 				     I2C_FUNC_SMBUS_READ_WORD_DATA |
> 				     I2C_FUNC_SMBUS_READ_I2C_BLOCK) &&
>  			             !i2c_check_functionality(client->adapter, 
> 							      I2C_FUNC_SMBUS_EMUL)) {

...is also wrong.

if (!i2c_check_functionality(client->adapter,
			     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
			     I2C_FUNC_SMBUS_WRITE_BYTE |
			     I2C_FUNC_SMBUS_READ_BYTE_DATA |
			     I2C_FUNC_SMBUS_READ_WORD_DATA |
			     I2C_FUNC_SMBUS_READ_I2C_BLOCK) &&
    !i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_EMUL)) {

-- 
With Best Regards,
Andy Shevchenko


