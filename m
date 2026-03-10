Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF5C279DCA;
	Tue, 10 Mar 2026 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176850; cv=none; b=ZNxV85JoPSvW52WJBVEiAwuoHuTjoZ4JgycyJx0IMTY1P+/eYRAv90Lz/PDVM8G/Fe+t+mbnOtw6RSY1AA5VMz/bXhpKUMC9vvM7A2BNL9tTUqPGjuxtGnSXnhz9iXLpnCxbxS1ZcXU8NirDDVTuSNoKoXyfUR2eRj5csctlgdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176850; c=relaxed/simple;
	bh=QD0ocCLo29LGXqoE2UpeJgKKNEmmXUqDI3RgU/UG4UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh0DHB1baTQ2TXOhmAb6siiRsTIMniXX6tntRhVnkprMYVWgGNpChLghT3kfQjJDOU0wci0IzZ8p65swnqIWrkdIoSySXOGS7jtXFpf/YgymrAcp+1K1ShIKsXwvZaKx0KPsf4QA3QzOwi4lW192Pd3EmK16DRYEoM7lmV9qlX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oH955PFc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oH955PFc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773176849; x=1804712849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QD0ocCLo29LGXqoE2UpeJgKKNEmmXUqDI3RgU/UG4UM=;
  b=oH955PFc4YfGQoq7aYFG3uEcOiPXc1UJFxKtvi22nijzmdFlavrCaH5F
   Lae4H2qB+wuJC2aOihCWnBm6W3Np6r8lRoXZ6LdPKkSFbX8uTVNul9zmD
   Kebsz2M6yM5SdamYIrfJpUg0wOK4cfWtjfHbz09GO8XMEx16RVx3H+8cZ
   ZgRpRXW24Q6urHqE4K9jG+l1VWmzVoeMSLMsFjGDQSeTkbdyp6R8ShLkM
   lCRaJY8STRxL4KT1EKLQRAM+kLXaiJJIz8T02mTFaeAx26VmCBZxHScVe
   AC2n/5UOBCgP8Nu+QlEEnAde1XzZ7GZRVNmaYPphLBnDE0X/kh9soKe5N
   Q==;
X-CSE-ConnectionGUID: 2qep1djwQmu5kaOwjUpV6g==
X-CSE-MsgGUID: XrVoSt2jR5eioqDU9wSiAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="84867487"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="84867487"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:07:28 -0700
X-CSE-ConnectionGUID: uZWVu9RWRJeylP2ReXAurA==
X-CSE-MsgGUID: MPB2+mqHR0uif6GIR6yszg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="216978035"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:07:19 -0700
Date: Tue, 10 Mar 2026 23:07:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, m.tretter@pengutronix.de, mchehab@kernel.org,
	p.zabel@pengutronix.de, tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
	pure.logic@nexus-software.ie, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, kernel@pengutronix.de,
	kees@kernel.org, nabijaczleweli@nabijaczleweli.xyz,
	marcelo.schmitt1@gmail.com, maudspierings@gocontroll.com,
	hverkuil+cisco@kernel.org, ribalda@chromium.org,
	straube.linux@gmail.com, dan.carpenter@linaro.org,
	lukagejak5@gmail.com, ethantidmore06@gmail.com,
	samasth.norway.ananda@oracle.com, karanja99erick@gmail.com,
	s9430939@naver.com, tglx@kernel.org, mingo@kernel.org,
	sun.jian.kdev@gmail.com, weibu@redadmin.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH 1/7] staging: greybus: simplify cleanup using __free
Message-ID: <abCIBPZzZBfMoOtm@ashevche-desk.local>
References: <20260310200513.2162018-1-sanjayembedded@gmail.com>
 <20260310200513.2162018-2-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310200513.2162018-2-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 11, 2026 at 01:35:07AM +0530, Sanjay Chitroda wrote:

> Replace manual cleanup logic with __free attribute from cleanup.h. This
> removes explicit kfree() calls and simplifies the error handling paths.
> 
> No functional change intended for kmalloc().

...

> +	struct gb_camera_configure_streams_request *req __free(kfree) =
> +	    kmalloc(req_size, GFP_KERNEL);
> +	struct gb_camera_configure_streams_response *resp __free(kfree) =
> +	    kmalloc(resp_size, GFP_KERNEL);
>  	if (!req || !resp) {

Now this check should be done in a better way.

> -		kfree(req);
> -		kfree(resp);
>  		return -ENOMEM;
>  	}
>  

>  done_skip_pm_put:
>  	mutex_unlock(&gcam->mutex);

To complete this, one may add a prerequisite to use guard()() first.

> -	kfree(req);
> -	kfree(resp);
>  	return ret;
>  }


-- 
With Best Regards,
Andy Shevchenko


