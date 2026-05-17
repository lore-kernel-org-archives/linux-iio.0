Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D841726F29C;
	Sun, 17 May 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014196; cv=none; b=GGQDqkfdDho/J6g4E9ZI+xWgIYUCfE1eeh/KqSxt+9Yugdl4w9diYYO30LI8lbbiORiFfQ0XTWy7e0s2xpD92UX87gFINM3qAsBQ5PGOQTtJe3NdlQ1m27Cyh1Hu6X8RKzxu8GHJrO1J280V2Fpb906z1EKuzsi4hAOj7SvSPxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014196; c=relaxed/simple;
	bh=RPZZndSFb5I8R8yJeeqAVXWjHGK74vPHt2Zil7DyU/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2NDHOf2NcCNY9EVJFIkDLV3NoGwI/wcY34+JCdsCffxSfY7w1Lbfr5LJAseJeL30xTSQlKJkm0cIKeD+l998bxh2g+v0omU1oypaAQ1EJkp23Z7oLQsPcwpkp1qxyZL0p3sGG9s1RuxpRiRy3F/B+yV7VmfhsYcuZXJ6gOMtYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmfj09Up; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmfj09Up"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779014195; x=1810550195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RPZZndSFb5I8R8yJeeqAVXWjHGK74vPHt2Zil7DyU/I=;
  b=jmfj09UpktENpb4uYxaCgKwELoes2WIm5w/CFf+EnxUSvZYI+qL4TrOr
   72tmebVnoK32HB+XU31c/pBiTIZ5CGnS0zEF8qd4ZIB5+CtArJbE5kaJG
   Qfx5P9JJH4VIv03yMMWIF3yM/FHGmc9u5mETw8b6IBHce1nlKga0Jn20f
   bLhtQreoj2HZTHmn3gRFvqvAWQkg/z6zUdXdk6lUkxjMg0pLCtwXNuJQE
   S4AvlyIsTYPsv8G6EMZXlzM8FXkmYdHGK8tRlYe4PzzJ5lsQp8Q6CRBa5
   EgbchCRiLjq+Qtuh4Vb/iQRwtaSEJcRJU8uawMcp1DhbvHtNx+AQeZZYE
   g==;
X-CSE-ConnectionGUID: MdD3XFHoS3Ox/WIxF7tqmw==
X-CSE-MsgGUID: zpGwB78oQxq2PBNRdCLqEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="67422153"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="67422153"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 03:36:34 -0700
X-CSE-ConnectionGUID: lIWJozhRQna49TVCspoUmQ==
X-CSE-MsgGUID: FfAwN3DdQp+pXzLKt2m9vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="277250855"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 03:36:31 -0700
Date: Sun, 17 May 2026 13:36:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, tglx@kernel.org, christophe.jaillet@wanadoo.fr,
	mingo@kernel.org, kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz, kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/12] iio: ssp_sensors: factor out pending list
 add/remove helpers
Message-ID: <agmaLOc4FTCskcfA@ashevche-desk.local>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
 <20260515174017.3962168-3-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515174017.3962168-3-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 15, 2026 at 11:10:07PM +0530, Sanjay Chitroda wrote:

> The SSP SPI transfer path manipulates the pending message list in
> multiple places, open-coding the same locking and list operations.
> 
> Refactor the pending list add and remove logic into helper functions.
> This reduces duplication and simplifies the transfer flow by
> centralizing the pending list handling.
> 
> No functional change intended.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +	if (!use_no_irq && done &&
> +	    !wait_for_completion_timeout(done, msecs_to_jiffies(timeout))) {

Better to have logical split:

	if (!use_no_irq &&
	    done && !wait_for_completion_timeout(done, msecs_to_jiffies(timeout))) {

but this will go 84 characters. Perhaps the proposed version is a good compromise.

> +		ssp_pending_del(data, msg, use_no_irq);

use_no_irq is false here.

> +		data->timeout_cnt++;
> +		return -ETIMEDOUT;
> +	}

-- 
With Best Regards,
Andy Shevchenko


