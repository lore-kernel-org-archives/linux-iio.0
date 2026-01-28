Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A12F3C37;
	Wed, 28 Jan 2026 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603962; cv=none; b=HmWlXpPAqQjPXryGbBw8rZdbYQwy2W6DE9Q8CC+OFw/RFEHoIava3J2GqadqiFgWTEgBOCE3hlC6T4P5uINC3DueHy/+0Uocw74U/QuC01hiBJ0ok4BzjtsXLdSHDUNSXq8K4Bq4Y+ms8EG8wMfBdwxtrH5ln+AJyevBDZa5o5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603962; c=relaxed/simple;
	bh=yWX5/7NGeA3zYy+tdh5keqO2yBz6egc8UlA2eq7HUto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzI3lGN+5WOuvprD0BW+RH3qm/BDm62uH1malg6wO6iIQnxF6ndM08qMo3Cn8AUdwUMrgRnPZAzbB/8CrmsStH89nS4knmBbWITgCVhIQymHDt7Yis8fh4rZZKt1weVmOqLORWti1xhP3KVaZI8QjIn3TPji+7hEwQtZGDyFd4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOsX+3Q3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOsX+3Q3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769603961; x=1801139961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yWX5/7NGeA3zYy+tdh5keqO2yBz6egc8UlA2eq7HUto=;
  b=lOsX+3Q3gI+Ie58WSgFgl3sntoWeE/TNuchlbHmioVKAqDEgZQmc+UrF
   mjOIH+qi15VlgNoUzB5vO1H1HjOr8tFI7gU6FvK/hb9MwmX4r9XMBUrX5
   jxBPgcqYibkSBzFIpciT9am5gwUhz0Cc7IXr9FCvE7D08VZnjgwIpSPll
   95M4Gcvq3K+kBF+mNTejBMXSTWojcYOfA8HJNhrVGk6a4Vx6Y6F/ow3K7
   LoKFlt79+WyFZILg4Ok9XDM9klIIqynNkVMntUkH8GTO2GTDu7/ZEmW6a
   Y3AQWcJOaED35ebj+LFiT4duSyezw35OuY86f/y30rRKk3pb/qr3WlyQw
   w==;
X-CSE-ConnectionGUID: YJ6EPqotRbuUPL1q5egVxA==
X-CSE-MsgGUID: vbJ8bMknTNaAW4okQ7xhqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="69829760"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="69829760"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 04:39:20 -0800
X-CSE-ConnectionGUID: e8hvzBX7SfWvZXG+/IZQQw==
X-CSE-MsgGUID: 3o9MNqQIRV2qpZa/LkowMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212808370"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 04:39:16 -0800
Date: Wed, 28 Jan 2026 14:39:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 4/6] iio: amplifiers: ad8366: add device tree support
Message-ID: <aXoDckvvaqnaA3vc@smile.fi.intel.com>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
 <20260126-iio-ad8366-update-v2-4-c9a4d31aeb01@analog.com>
 <aXksSjsyNn6if3eQ@smile.fi.intel.com>
 <b6pzhwmfranyhuetv65movfqzubvbjasl6ruxiym2ehuch2hov@r56lgzgf4us5>
 <aXngRcVMj18tryGT@smile.fi.intel.com>
 <knzaphyzfuh4fihlftzh3jhjxbjrdjqezqsd7rc33pmtc4anxi@2uhqhizyfsed>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <knzaphyzfuh4fihlftzh3jhjxbjrdjqezqsd7rc33pmtc4anxi@2uhqhizyfsed>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 10:23:58AM +0000, Rodrigo Alencar wrote:
> On 26/01/28 12:09PM, Andy Shevchenko wrote:
> > On Wed, Jan 28, 2026 at 09:55:16AM +0000, Rodrigo Alencar wrote:

...

> > So, something like
> > 
> > 	put_unaligned_be16((ch_b << 6) | ch_a, &st->deta[0]);
> > 
> > should be better, no? (Note, you would need linux/unaligned.h).
> 
> ok, ch_b would have to be u16 and ch_a could be too (for consistency)

Why? u8 should suffice.

-- 
With Best Regards,
Andy Shevchenko


