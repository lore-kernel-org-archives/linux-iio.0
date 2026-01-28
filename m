Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FCD227BA4;
	Wed, 28 Jan 2026 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769593271; cv=none; b=ewyDCg87FW8JvFpcOBP4e2VwQ2LY6o2m1wNPlmdrsIej4w7bG0TEVxwoA2eOZYQGP1zHv9Sl1OX2FdeZzDnjoiF3Ex8r/6vtUt/q3BzOwDe6GLz8XiyIKFCXge87KU17GI0O8DEaXDa91HGnOvnVYXmi3xL/dxQ9UPaGzf+irjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769593271; c=relaxed/simple;
	bh=3aFCGd7StjVIKX8KXTmPyBz3+5Mdsx/dUN5nwd0vLkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ub+HCy+/wo73KsTXDHUagSYzlzB7Hloe2yyS7Ao+rnZpNlWoSKkUOaWUbHuddGfM+fdzqWKJbMufuCMBeRJHvRjLnTipgZkWBcEcsB3O3YM4/0qSZTVEMCwxqdgaKoS/GO+ma81UVMYOr9Am+Rkb2gdp/RDwa+dLTd40o78hTKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R96rdVlm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R96rdVlm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769593270; x=1801129270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3aFCGd7StjVIKX8KXTmPyBz3+5Mdsx/dUN5nwd0vLkc=;
  b=R96rdVlmwPFNlgHQkusJu4sO3xdWNysBJ3kg4jkb6D9njoeyYg5gBCpd
   kYhFG/5oVDp4TpUtU2NKsD0RfmYnGBaSs8lIjcuhlk8ukNDh7Znc5vtIU
   rqb+ec8oA6HlexkKv2qgafTfkwz28e0GNcHCh51eEnv3wfSeWpNRI4HGd
   EXemN0MyACh0dhu+3lgthBIfJbtTWOo8BuOcPBmdrLdp4fWIXS+mx7W6z
   /5OF0npmEt+/N/PSFUCozMeuX9U774pHG8p+B86NBG1tEQR6A/ZUjETet
   J0lbVRG8xzATC0lwIBtnlFl0ouFlM6A1oClusQ5B/t52TTlP41U1ffOzu
   Q==;
X-CSE-ConnectionGUID: m9Tlh2/8S+KdZEABWUiq4w==
X-CSE-MsgGUID: cibJml+aSYCCVD9KA9ls0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81524237"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81524237"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:41:09 -0800
X-CSE-ConnectionGUID: j5fzAlgdRkeLci32uUsE+w==
X-CSE-MsgGUID: cMM1N3DJQfulGwFgtaq5uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212324985"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:41:06 -0800
Date: Wed, 28 Jan 2026 11:41:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, lars@metafoo.de,
	Michael.Hennerich@analog.com, cosmin.tanislav@analog.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: addac: ad74115: Add missing check for
 device_property_read_u32_array
Message-ID: <aXnZsCD01-LUVNGx@smile.fi.intel.com>
References: <20260128043040.2260887-1-nichen@iscas.ac.cn>
 <5b0471519e4fdefd41c5d951401483cde3e49f19.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b0471519e4fdefd41c5d951401483cde3e49f19.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 09:34:18AM +0000, Nuno Sá wrote:
> On Wed, 2026-01-28 at 12:30 +0800, Chen Ni wrote:
> > Add check for the return value of device_property_read_u32_array() and
> > return the error if it fails in order to catch the error.

...

> > -	device_property_read_u32_array(dev, prop_name, vals, 2);
> > +	ret = device_property_read_u32_array(dev, prop_name, vals, 2);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to read %s prop\n",
> > +				     prop_name);
> 
> Thanks for the patch but this is intentional. Not a mandatory property.

No need for further actions. NAK to the change. We don't want to have a monster
with the custom error checking.

P.S. The author also must answer if this was found by some static analyser
tool. If so, the stream from this "tool" should be blocked for now.

-- 
With Best Regards,
Andy Shevchenko


