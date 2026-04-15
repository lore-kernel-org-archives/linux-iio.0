Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829251F2380;
	Wed, 15 Apr 2026 04:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776228771; cv=none; b=GmA1XOvDphH0/JSYaXLLWZdXEluldsvSQYlKyQCxNFr++NLu8BOy63Eu/zHS0FxaX0LYeV19lNHiEniH592sYLKgx+AyNlRMMw86NpfjeO6as4g/o8aBdmVn7u+JZU1xq+hoMFTHxU80osV/TUp0P6aSeizdCyD6NMckyvYq72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776228771; c=relaxed/simple;
	bh=wE54XjqV/Mc+zVuNbW4dmvSFEl+O6H8mzJLili8gt8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFMjzKzVjgXTz7kNEAbvsW355A03q2mu7/MD25ZtUnl2sK4arGWlo0VovufUYnmU3FXmHhIc0In/HBuSh+zTaWhs+yZd0C7ttgCi8BQrw0Rq+N6zmq70+ICbi7CmDHHlmWBeGyNoiYObGeYFeNn+q+hWyVoZL+n9jJnwD9i4y5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B01rwa4w; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B01rwa4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776228770; x=1807764770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wE54XjqV/Mc+zVuNbW4dmvSFEl+O6H8mzJLili8gt8A=;
  b=B01rwa4wQSD7qkqcBQTSrjoZlxADXe/fIudzQaxv7lUzco6Az3xhiR92
   RH8p65fQaDmG6fxaU8g1o/eJebiNak2uQsiT+nF5ZY78FTrISFElZ3C/o
   uPJyRb4ojXPsEZO/n4FY+P5IgCYzyUKJ+PuPeiHYi6J7CmAODAsunkNFc
   MxV8ENPjB1i6Idd8t2GTB+SkImpnyy6jgSGrRTxb31L6IAkqefXDar77e
   QcQlR5GFloStmchQfzfa/lrdVGHNQVD9nMSCZgh673dOk7tI6CsZ1t2+x
   52dRuyYYfr6OU7lpNJEzAO0cZFS6ueO6sokdbJazWycZnXy/qwgtD0GGe
   A==;
X-CSE-ConnectionGUID: mY+Fqw5KTCKV5JojZHjxZw==
X-CSE-MsgGUID: 1ZVbRtdUSJ6nVgeFmC84uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88578476"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88578476"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 21:52:49 -0700
X-CSE-ConnectionGUID: OsfhTPXvR5uTKLN7asx5+w==
X-CSE-MsgGUID: 8xxbdzCjSCOYaFK3TnYcwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="225601433"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 21:52:47 -0700
Date: Wed, 15 Apr 2026 07:52:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <ad8ZnOZ_mmx5I6BZ@ashevche-desk.local>
References: <20260410-dev_ad5706r-v7-0-af93a4caa186@analog.com>
 <20260410-dev_ad5706r-v7-2-af93a4caa186@analog.com>
 <20260414195400.60d39158@jic23-huawei>
 <PH0PR03MB6351E875581B45ED279785D0F1222@PH0PR03MB6351.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR03MB6351E875581B45ED279785D0F1222@PH0PR03MB6351.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 01:10:09AM +0000, Torreno, Alexis Czezar wrote:

...

> > > +	case IIO_CHAN_INFO_RAW:
> > > +		if (!in_range(val, 0, AD5706R_DAC_MAX_CODE))
> > 
> > I'm not seeing a strong reason to use in_range() here (hopefully I didn't
> > suggest it in an earlier review ;)  It make sense when we have a  val >= base &&
> > val < base + length. With base as 0 and MAX_CODE not 'obviously' from it's
> > name being the length (it only is becauset he base is 0) this seems odd.
> > 
> > 		if (val < 0 || val >= AD5706R_DAC_MAX_CODE) Though see
> > above on MAX_CODE not being the maximum code...
> 
> I think around v3 Andy suggested the use of in_range, as the function itself helps
> document what the line does. Is this a style preference?

I believe it was me, who suggested that, but we can open code it. Indeed, it's
just a style preference in this case.

-- 
With Best Regards,
Andy Shevchenko


