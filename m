Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5BC349CDA;
	Wed, 13 May 2026 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691589; cv=none; b=gGWuC/OrHKPglaR5oHVF6mSapzFX7oxuFLvfPITFaltZ9dd9iYlLEK7wyrg/ZGtIHc19c0K4CS2qjhDWyk5mwNqeFcUYlgcOMJv6L1+qFPHojvRTqybYmX+DuXpQlmoP8FIjy7IY3AHpVZ8EtU8pXd23cg6ur1olSv5gtzpBAMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691589; c=relaxed/simple;
	bh=WvoyIvOk2I6jTRMYgM+t6lyvZMyHYp3i/8rYeuXzJh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8tDhMaMT6QMqkdZdlCPyE3rWLmfNDlcQ4Bd42IN12CSodl9JJ6LxcQ3KGefw9MjvUvWwg10gwMS0dB7uaUOOjafKuvdT7Su4jbVnstMOwtNmeqQP2iClHlLL/vM53H0FDLChEDAnZGkWmQN8J1O1Caj+LrADXI4iG0WhoECkx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PwWB22TR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwWB22TR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778691588; x=1810227588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WvoyIvOk2I6jTRMYgM+t6lyvZMyHYp3i/8rYeuXzJh4=;
  b=PwWB22TRSpkkc8+PSgdtEmY3I/u7NIAUb13AisVCDBrCq+P/+N1kaV4d
   GI5UMBAdZUXbtgWW+PREbAt9TLSbWJEL0SGMIyjbMpoT3gJoc4alLPaXl
   4HBv56KYqm25vSicTUhwkRA3w0CDgutVt0jtDE0K3cO3RdsZWcJL+sIL2
   tIl7MKlKSL4O1qD9CZdvmMJ7OuVngwLi19w3/Kma+ez2QP4odDmysOcWU
   7kpPGZLbJK8Bz7vVVPu7QwvwPO9XyeGZK5uOSMuzr/ysVUgtIVGnGt+AM
   YDbEjgxY0OJSyYEKJtqUi6TkwnsozGwAIHtN+rGACcwO7zXxTodhb9nuX
   w==;
X-CSE-ConnectionGUID: rTp5ZaprRFe7rdDOx4ccXQ==
X-CSE-MsgGUID: leaBmHARQuW7aqezcmVf8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79741141"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79741141"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 09:59:47 -0700
X-CSE-ConnectionGUID: 92hetl0/TfWYZNoADDnoTQ==
X-CSE-MsgGUID: 70UpMXGpSyart68UmyA8xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="231743389"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 09:59:43 -0700
Date: Wed, 13 May 2026 19:59:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: light: veml6030: remove unnecessary read of
 IT index
Message-ID: <agSt_TGpyujxqrZc@ashevche-desk.local>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-1-4703ca661a1d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-veml6031x00-v2-1-4703ca661a1d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 05:49:41PM +1300, Javier Carrasco wrote:
> This is dead code as the IT index is not used by gts to set the new scale.
> In its current form, the value is read but not used afterward. Remove
> the dead code.

Does it have any side-effects on the HW side? Exempli gratia, flushing FIFO,
R1C (read to clear 1) bits?

> Fixes: 22eaca4283b2 ("iio: light: veml6030: fix scale to conform to ABI")

Not sure it fixes anything. But it might regress, see above why.

...

If no side-effects, the code wise looks good.

-- 
With Best Regards,
Andy Shevchenko


