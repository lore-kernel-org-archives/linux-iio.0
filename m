Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229E53DD523;
	Mon, 18 May 2026 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089872; cv=none; b=gSr7d8pk29M7e+hAUCryFbeTJSNVHyVEOxroIcTqkdDr3QnWKD4ATh0F9EL0EA/Aoom3JhLjSYMJfhCmx4FupRNB2I+WBJlmhfqFUJ0yjNpYa3HPvrnJVv5jZfNLUzAg08wpdhzv5M9BONdYcvybi8mRCP7nWS+iu+H382ArKTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089872; c=relaxed/simple;
	bh=eQ1ZMIkS0xQan/x2LSkxNV1KTXQCt2q5sq4HgKDY/A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DW9ApYOPXYbcZbwzOnfQ/QXEa5Umxocnv25k0Xo0pl83IY6h95fHoiEmRmabdRGDYPE4EMTimDgRj6zoSSSPc4FCwwcvJDMS89HAmoq7rmY9CuFnfbzCstIlATZ+ugZ/U1Pl7ECXhRnbJ/nHvECN8eP/w3orf4ttw9UC6LPOfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mv0XHyqq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mv0XHyqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779089871; x=1810625871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eQ1ZMIkS0xQan/x2LSkxNV1KTXQCt2q5sq4HgKDY/A8=;
  b=mv0XHyqq6kZ+wIZ2to9vGG6ZwB8bh63oPaTuUxkUSkGwvXILe3qdg/jk
   kxG5m8h6bazmyQ7oIGsukakpy6u73zY/39Vy7dKh4+BxmCFa3U3De168k
   VHLrpKQDQdLmlWK9fR5jaLoLBAgzIkmoXFvM9jQGCnLZdYU7X/qHYgBzR
   KDCOMD2cl3uscEfBBzR6PB1UvVnCgTnsc4YEwn2+Uim3v5gLQdXdgW8Yh
   kL3TNEo6+NcZVg7GtHM8HhCq6agF92//cdJJHnxKUIW81pkquUPVZdfFX
   yS5LGT00SQtoWu0aV6E6pUopx178OJVMrYYznScrzXdVBH6CKTEbWOjwe
   A==;
X-CSE-ConnectionGUID: Az51fSmXQV++4+Uze8FJOQ==
X-CSE-MsgGUID: iCMC6L8yRbqCFgv06lyFGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79916406"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79916406"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:37:51 -0700
X-CSE-ConnectionGUID: 0I4ZaCiyQ4qwsBQst95XRg==
X-CSE-MsgGUID: JF2vwdIETbqTHxCv22ttWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="235114883"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:37:48 -0700
Date: Mon, 18 May 2026 10:37:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, hcazarim@yahoo.com, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: tsl2591: return actual error from probe IRQ
 failure
Message-ID: <agrBycM8s0Uy9LJQ@ashevche-desk.local>
References: <20260517181042.668-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517181042.668-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 17, 2026 at 11:10:42PM +0500, Stepan Ionichev wrote:
> When devm_request_threaded_irq() fails, probe calls dev_err_probe()
> but then returns -EINVAL, dropping the real error code and breaking
> the deferred-probe flow that dev_err_probe() handles for -EPROBE_DEFER.
> 
> Return the value from dev_err_probe() instead.

...

> -		if (ret) {
> -			dev_err_probe(&client->dev, ret, "IRQ request error\n");
> -			return -EINVAL;
> -		}
> +		if (ret)
> +			return dev_err_probe(&client->dev, ret, "IRQ request error\n");

Also remove dup message, at the end it should be

		if (ret)
			return ret;

-- 
With Best Regards,
Andy Shevchenko


