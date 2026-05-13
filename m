Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4BB44CF2C;
	Wed, 13 May 2026 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690275; cv=none; b=CnJevKUHNdEKgQJ9lANpw0YZofPPyPy4CdbxOZYCMegAHloCjaxV0T3W+/LfBLy12itMxGmelo3ufNP92mphxWqNJik1QXwCcdO0iGP0gG8DPuq3fJJINzCBggd8wnpbNT99RXcfVOMqyorooSB8fdbtzdMk01g4rX+PnMbjaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690275; c=relaxed/simple;
	bh=ghTCuOTegEZWSbC9lHtycD0EmboRN9oSMAdioTFb7tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SO58l8jG+mbJBYCmjoIITVVU5JIfhTAPbbSFvY1jL49QwN/Fi9Gx3IXTsRu6S8Yj1r3hap7Q7urcBFSsh5X4moga7l+n8jLqMcpLLZbzTd+V3NfbURNormAghWmCICOa9aPyNvlV7wFbEeI9iQz8qqRQr/nenO+O1jz3rXDSW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjg0ItsQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjg0ItsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778690274; x=1810226274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ghTCuOTegEZWSbC9lHtycD0EmboRN9oSMAdioTFb7tM=;
  b=mjg0ItsQDJgxPmHr9y4kwv2uRBOtTreExR+Hq1z1pRCMOA/n+iLkR0b2
   DL6odxskt/miS0SvOn6ZI1f25JUauaP6DqcL70aj2Sw2oAIszbeG6ubEx
   dL3PAgvMnaEnNvi7VhjDeHmL/bOncW1EpnfodbokMCv5ASqCHpGbOAZn8
   kMJE/NvBTzjhK4oLKpU8Yiur8/C9LzXvdiShgDIzDD0BjOnGUWF749znR
   qEaw6DyrI7EL7qwFA6zixPBhxKcIPL4KtzAkNQl9ndS2QH6TpKHfvZO0U
   trdd602NzzuyHSr3GxNWYhjXTAPNpa+hqOvZYHvrhraPZYSbjTBEoIIE9
   w==;
X-CSE-ConnectionGUID: AA+x5rhbTH+AP40tyRyaCA==
X-CSE-MsgGUID: Tf5tA/RmQQSVmHz82Mz94w==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79655764"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79655764"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 09:37:54 -0700
X-CSE-ConnectionGUID: lwL01TGRTIK//6gpp5g5KA==
X-CSE-MsgGUID: jDOvssuWTua2fM6pl9Uv/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="243088657"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 09:37:50 -0700
Date: Wed, 13 May 2026 19:37:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <agSo3FPFlM3fXNhY@ashevche-desk.local>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-4-4703ca661a1d@gmail.com>
 <690B63AD-4429-4045-B413-29911ED7DA3D@gmail.com>
 <agSokBtQ5R_6p5Zs@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agSokBtQ5R_6p5Zs@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 07:36:38PM +0300, Andy Shevchenko wrote:
> On Wed, May 13, 2026 at 05:28:35PM +0530, Sanjay Chitroda wrote:
> > On 13 May 2026 10:19:44 am IST, Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> > >These sensors provide two light channels (ALS and IR), I2C communication
> > >and a multiplexed interrupt line to signal data ready and configurable
> > >threshold alarms.
> 
> > Thank you for new driver support.
> > 
> > It would be good to add blank line after this to have iio and common header group separate.
> > 
> > Also, header should be in order.
> 
> Something went so wrong with your email. You answered with something like 5
> lines of text in the messages of almost 2000 lines... (It seems your message
> have the full text of the original one + HTML crap on top.)

1 <no description>                 [multipa/alternativ, 7bit, 84K]
2 ├─><no description>              [text/plain, quoted, utf-8, 36K]
3 └─><no description>              [text/html, quoted, utf-8, 47K]

> Can you avoid doing that in the future, please?
> Thanks!

-- 
With Best Regards,
Andy Shevchenko


