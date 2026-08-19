Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EBE3B95F0;
	Wed, 19 Aug 2026 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149131; cv=none; b=WwsRv/QVMJq6arVIq4e4D8/6nJpc+VQqPhBhnCuRTu00d74d+QYOuFl0m/Dul0bBxl1imx50ntcadH95GYMqqPHTKa9t+zHOQ+D0OdfLGdhDrio5BmTZTWJtvO9driegMXk9KZy1AEr16ZsXg1H1Yo+b51vNYEB26d+6eDohlpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149131; c=relaxed/simple;
	bh=pmh1nnq9HjTcr6HEKDAQB/0aNjk0F/Cufq3j6UTM0w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe73rzY88MtUCLc68KVglBnywf1SBZSk+DBAqgKHBkxISuL2WrIH8uBUMR1JiexQ675Uynx8fZdl9R1Q+8C/3J43UeBkEnijIRWMASamLTXcdRfh8gkUCSKHMKNqkFWCqrr+VFrv14vhzrcatM87EhI9ImIFmYWzIAOOg8q4kEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kilKFhhi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kilKFhhi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787149129; x=1818685129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pmh1nnq9HjTcr6HEKDAQB/0aNjk0F/Cufq3j6UTM0w8=;
  b=kilKFhhizx0+gbm9l/Xu4dmN0IX6fHWHMADZYJXfVC1cTXBoA6W6aqTf
   2DxCQH3UYziVUCVdHgs28imHGW4HYVoGmjKZr8HQhMVBQibsBcZL5coQV
   OrXp+5C6mtpFW0TZNUWBUwgnS9xl0f/GSrxGJgV5nnHumMbprW5nU9vEa
   fU3bc+UTUcTLuRdm67FuklQ5dt7OAOadf0mYzDcFPy2uTscC80odgaJtp
   Q0ea+XjHd6avXBLHQPyAsLZe1hDhniZhpGLmz1/2denjWhcfdYJD/ZbVO
   SYKBt0naIAMuF1s+XAD02JV1EMlyZlP8LmHdlIM4mLUkGiX8MKuT+ynWD
   A==;
X-CSE-ConnectionGUID: 7elixjXsRaeG1uHycXC6rQ==
X-CSE-MsgGUID: qUtox73pQICOIrrXJ0x64Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="86621416"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="86621416"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 07:18:48 -0700
X-CSE-ConnectionGUID: YOGs7/MwQTObsl73yx4NJg==
X-CSE-MsgGUID: gK0JzvzrSIKgizjSLxuucQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="289076265"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 07:18:45 -0700
Date: Wed, 19 Aug 2026 17:18:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/9] iio: dac: mcp47feb02: correct false state case in
 store_eeprom_store
Message-ID: <aoW7Qjfn6EaBBLGw@ashevche-desk.local>
References: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
 <20260819-mcp47feb02_refactor-v4-3-beb2aa3bfd09@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-mcp47feb02_refactor-v4-3-beb2aa3bfd09@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 03:41:07PM +0300, Ariana Lazar wrote:
> Return len also when the state is false instead of 0.

Why? The main problem with your commit messages is that they answer to the Q
"what?" and not "why?". The latter is more important.

-- 
With Best Regards,
Andy Shevchenko


