Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF771E7C23;
	Thu, 13 Aug 2026 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606228; cv=none; b=FH+QHMrdHMyq2k0UwR0L7/1gfzFhkGEtsflULqG9Jv2D7JjMIXGyZ6hcp22vLdr+XkXFePkfOEp5QolcZhGUMNS1LyMkapm+cZEcYF+Jx5I150RzNkN/QI2zTI+/8BZRB1heZCWmXZGBYbx56EUAHJ2rlfdJh2GSiBu3j4yt7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606228; c=relaxed/simple;
	bh=jf2IfUApHGvdbmJA06t9qyqnD2qv8LNuq8BYVRnww5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxVk0zBzJsCEUqnA2324bQS5Y8fFVAEAd7ViVlXVQvvzpQcQLkAI1cEfRKUEGuupH9M6vmbu+IBkvEeXkH6gK5REeGTJzWJUjryXrZ/YmcTreTSPv9Wnqaeb7Gc7mEzgx+4ZPVyVNo4Ow3hqXYb32CfAB/63EtOxB36SWb3SAMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OG2O0jAW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OG2O0jAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786606227; x=1818142227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jf2IfUApHGvdbmJA06t9qyqnD2qv8LNuq8BYVRnww5Q=;
  b=OG2O0jAW+NTC6efFJD2tdtc6ZOcN6/ecoADXRztnwIoPz4MUQ4nWQj6m
   9kRatCiEU+W5q1XrQWg2en731QZOAMxHGTt5E/2nimy899CCy9qlDO2oX
   nn8vP6Hqy3bGoDw6536EejPcYmu+q6S9EZALdNxfX/LSZ78WZ1BpoQGuO
   Z9tjhkJ92t23ZEOde62/L607NBJ3vZI2TtE0vWdSNUgRinml6Lv0C9vwv
   F+oJWgpEE//fQvmexmAmjOWiF+Wp7GMq7YrsKhK3eHeM9ks+pDqAADl/e
   UX3q8cQlDjlJN7EhFH6IiIPBrm9RqqWGuxact5fCmIG9BjXaoESq4hgNN
   w==;
X-CSE-ConnectionGUID: cEk8LkpYTSaJt1yXM4ON7w==
X-CSE-MsgGUID: 6Qlmeki6TC2HfXIbty3v4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="91048423"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="91048423"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 00:30:26 -0700
X-CSE-ConnectionGUID: GDI09hSDSFCUwpt4vA2mlg==
X-CSE-MsgGUID: 2UdiuCVaQfS/AydBlV4ZpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="287307686"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 00:30:22 -0700
Date: Thu, 13 Aug 2026 10:30:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <an1yjHnXyfXeCaWX@ashevche-desk.local>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
 <20260812-veml6031x00-v6-2-7eef6e4ce290@gmail.com>
 <20260813020429.54031688@jic23-huawei>
 <20260813022715.19d15cbf@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813022715.19d15cbf@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 02:27:15AM +0100, Jonathan Cameron wrote:
> On Thu, 13 Aug 2026 02:04:29 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On Wed, 12 Aug 2026 22:27:41 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> > > +	}  
> > 
> > Trailing comma.  Maybe we'll add more after this and they will fit on one line.
> > Yeah it's a stretch but generally always add comma unless it is a specific
> > terminating entry.

Which is correct suggestion.

> Ah. Not such a stretch. I'd forgotten timestamp channels.  This creates
> unnecessary noise in the very next patch!

Exactly, so trailing comma here saves us from unneeded churn in the next patch.

-- 
With Best Regards,
Andy Shevchenko


