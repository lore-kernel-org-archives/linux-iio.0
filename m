Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613128;
	b=CrPkNJuBVIT1LCU6SrwXcUDUSjtmO0IwPImyK8TYNqxd9cOaZwzhIiMTGzk0rg6fs4Sd
	 asTyqM03kmNPf9oqxbXC1gvt71lz2a+GpNWeOMdUap39kMUr84fTNwWvejHF99ehFc3Cn
	 j/hOa1m7KWcX7KuFYYVd7Z+oh1tdrS8imY5kRmARzUj1MY1wmcqjMYhVCjaCsaRJOu0LR
	 utz01tGWg8N1JV/8LH2LSKiUxWi2QY5XEH7SYkbFakVSvxJZKN15+hn7IySHqL1F3vORw
	 TM64qGMO1Z+6NTQGOVQWQ3ek/npjqVuwqpbU8jdKnChYxjkKgH6AjeCrjiPYSiQPLrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613128;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=5U/mp5/J7rf6LX70zikAzH7TB74AYfK5GV/BpPX9uL0=;
	b=BD3uW9+DgNf2Fo+DE4GdkwZAy3L0VH7vSvdGMrkNcbjabo2FzPUna5iX17B/tWSLIA01
	 5dI7uOpNUWcdgI5zh5TxixdmfAO48+I6dOWW4dGHtx5zxk7WenUnsvbMmnbgzNXo152ys
	 T4fQEcD1EcufrxuJ3F7JwWz8x23YnQTTETlYfsjZmrH2jVkfA1UTMP5ARSAgf9fFlnC+p
	 ZhMjrFrz5+IGDV8RNKu/jK/dTCglf8Do8M3P9rnQXirHkc4jEIaUS5fq+pK6TijWTuq6b
	 UNOSDBRrlG0YRUKdR6CRNS0jhRkd3jYptucgAYoX0kzj7list/PQzrrTo65W3rUMTdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EqPz7M0C;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB50606A338;
	Wed, 25 Nov 2026 13:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB50606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EqPz7M0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795613128; x=1827149128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sbyp9Cexn5uiAeoq3vI339ckZZ4d+ijki69mJ+9LbDI=;
  b=EqPz7M0ClP2StPEby/K+/qSTnVl+nWW1U0kBiw7iVJTMIHgVyWx6GEMo
   ntj1COyX9cCtDcZFTzp1N4KkvEDj8K7Z5tZU5czkjrcLlGG1vrrlpxMKB
   2NW6UZ6m2cjoFHPyQO7XOGV9rvih5vtP8Ohh0xdMwcN0/9Ls+zUIHYqgb
   o4y3ETS4vEAoB4FjuXASq01t91q7KxSWnjzwKCFiIpToDY7XkJ6aRW/Zk
   Yhy690tbeBvJPWGh1yEMAIAKa+6IG042d+FX4Q2+9LFY1UN7yJulUwbWJ
   zl4Gsfpj453wL/Ea3UwiKBqvOS+miWjnKjZdHI/wmugpakA3rZrhmGHqO
   g==;
X-CSE-ConnectionGUID: xbB54m+6RCyMQtoPVWRMyA==
X-CSE-MsgGUID: rTedcj4TSmGih96LI39Q5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4550745"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4550745"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 05:25:27 -0800
X-CSE-ConnectionGUID: bhz0XBWYQGus/daFs/vtDg==
X-CSE-MsgGUID: E+U9n7IJRQuFe+9S/9Idbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11858296"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 05:25:24 -0800
Date: Wed, 25 Nov 2026 15:25:21 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raffaele.tranfaglia@gmail.com
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-sound@vger.kernel.org, Neo Chang <YLCHANG2@nuvoton.com>
Subject: Re: [PATCH v2 1/3] ASoC: codecs: nau8360: set val_bits to the widest
 register size
Message-ID: <awbhwVw52eSTTmiu@ashevche-desk.local>
References: <20261125-regmap-kunit-val-bits-v2-0-81db3b79cd3f@gmail.com>
 <20261125-regmap-kunit-val-bits-v2-1-81db3b79cd3f@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-regmap-kunit-val-bits-v2-1-81db3b79cd3f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 08:09:30AM +0000, Raffaele Tranfaglia via B4 Relay wrote:
> 
> The regmap is configured with val_bits = 16, but the two DSP registers
> are 32 bits wide: nau8360_reg_write() sends four bytes for them, and the
> DSP messages written with snd_soc_component_write() use all 32 bits.
> 
> This works because the driver provides its own reg_read() and
> reg_write() and regmap passes the value through unmodified. As regmap is
> going to mask values to val_bits, set it to 32, the size of the widest
> register. The size of each access is still selected in the driver's
> reg_read() and reg_write().

Hmm... While it works, it might be not the best approach. In cases like this
elsewhere we create two regmaps (one per each val_bits size) and choose them
based on the register offset.

-- 
With Best Regards,
Andy Shevchenko


