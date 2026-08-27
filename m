Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA8C2931F7;
	Thu, 27 Aug 2026 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813527; cv=none; b=rgA9lSmzAD3urD0/tC3Z95wQPMQ6PmySDWH0N91V2uI8Zina+NfkOmKBdmMIknCRTkX7lZeX6owkdYG6jpErM4zZT8zuj+mzAajxo80XGcS5SbgtlobJ2rrtyXZNdoThvwEGnqZbBp4IOKfW7gkonIU1/hvuhAMZCJi417v9P1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813527; c=relaxed/simple;
	bh=Na/ROnshIIC7Ymj9ORTdoVUpVfDNpNInqCOmdYyqPCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEQBuprUzPHSBG1uAwus97ohbUsE90kKy1TMU2ORC7F4dr49CnfoAdVvewvzAFdrHorue9GRKRKla0hhji+0IO9Wa8lHedyPAJQq1GS40w303G6/UhC6N31FSAGiu8rHP+2ngkptP7W0zii40Xa91FkYrLSP9RW9nqfRDhSR5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1/flhaR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1/flhaR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787813526; x=1819349526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Na/ROnshIIC7Ymj9ORTdoVUpVfDNpNInqCOmdYyqPCM=;
  b=O1/flhaRtgiDQhKH+YmZLrCYAEZ/RMrqWqjmdMccI1xg6/Bk6NVefyiF
   uYx1721gBPnM8Z4vmXfSRAeTQhoIR16RQHGBkV23/GzZgzk1ulEavpNnU
   Q/f9x9xST++VMO+bBo5QyPqmR9NRs+75LfgyUZQivVnhhPEx9PwAXrRuz
   sOo5xrw+BHMvpUlifDmOPNxafbjttdpc9IrCnbpBw8vhitDvkqrSlkOjI
   sgf+8hRrUP1Cf4oQZJ8bScMpLXi+WCGsZK9GtroEz56JHhr51oM+tosP+
   sAxXbGGq6lb5UWjz3m8R1RNqDjB89H1pf8AL9SCQJDzUg26XlwxYDJWkA
   w==;
X-CSE-ConnectionGUID: c3UTZg85SBKCiEjrM7dGsQ==
X-CSE-MsgGUID: mau84kfaSk2nFQdGcRNnAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88226919"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88226919"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:52:06 -0700
X-CSE-ConnectionGUID: mV4cFKuQS4KvIS4o7BhN/Q==
X-CSE-MsgGUID: Ul6eYNBkRdupSKjNYvphYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="292629661"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:52:03 -0700
Date: Thu, 27 Aug 2026 09:52:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, grondon@gmail.com, linusw@kernel.org,
	hexlabsecurity@proton.me, sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iio: accel: bmc150: DMA-safe buffers and use
 iio_push_to_buffers_with_ts()
Message-ID: <ao_ekPy1t26dmVDt@ashevche-desk.local>
References: <20260825085156.212042-1-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825085156.212042-1-yashsuthar983@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 25, 2026 at 02:21:53PM +0530, Yash Suthar wrote:
> The trigger path used a plain s16 buffer while the FIFO path already had
> a properly typed scan member (__le16 + aligned timestamp). Those two
> buffers did the same job, and s16 does not represent little-endian data.
> Drop the duplicate, keep scan at the end of struct bmc150_accel_data with
> IIO_DMA_MINALIGN, and use it for both the trigger and FIFO paths.
> 
> The FIFO and read_raw buffers are passed to regmap bulk/raw reads, which
> is not DMA-safe. Move them into struct bmc150_accel_data after the aligned
> scan buffer. Because all buffers are serialized by data->mutex, placing
> them after scan ensures DMA safety without needing separate alignment.
> 
> Finally, replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts() so the push sites pass an explicit buffer
> size.
> 
> This supersedes the earlier standalone patches:
> Link: https://lore.kernel.org/linux-iio/20260808220236.421832-1-yashsuthar983@gmail.com/
> Link: https://lore.kernel.org/linux-iio/20260809111303.496393-1-yashsuthar983@gmail.com/

In this case it's better not to use Link: tag. `b4` can't distinguish them from
the important ones.

> Link to v1: https://lore.kernel.org/all/20260814101845.301769-1-yashsuthar983@gmail.com/
> Link to v2: https://lore.kernel.org/linux-iio/20260815175728.99541-1-yashsuthar983@gmail.com/

-- 
With Best Regards,
Andy Shevchenko


