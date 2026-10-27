Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098537;
	b=W3ndzSLSAKEJKlSRlHNt7mKVCK7YiDAUPMntIKoj+0mQcEdJBf39mDTuwJRINtCmdNuJ
	 zJAFarrMynszqpDQIAm+0n6ANg0QCU5lhZtxhYYKgoR9HxrFga50jxNGglWyj9tJ1h3ka
	 e9jnsUJfZl1t2WxVHPJSjhmGkokpuCGCKXZH2AZfHkUt3ef278WMMQxRK2AaC3b2jTKC/
	 PZRcZD6rpukoGbdjMBIaBr8F/4ndczavAc/ltgNsnF2ll2MH/IbBM7t18YQSBoUxr3cER
	 dTNlBZiDTudF3SHcdrgbdjZeawT1zE2itO1g1duof0yAtkxTFloGiLw+L7/mzKM3tbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098537;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=q6ycl+QNfQUCSRFPnQQpnrxTMRSegaGgqkhsDX5lmZw=;
	b=pa34XJIJPEIx91T1kgW9zriowxYbNJNqBJ6xm0HROoQP9isEUASMQmV6zZ222j7KBUU2
	 ev90PoavmP7rCpcCfwO5ezg9yMVDLd2okBh5bREI5HCHnNlWC3Oz1xW1lnBjNKGQYAA5Z
	 awiDJE1X5LRrUOh7Iiu83w2gE/MJppuL9+R6r28khV+janEWpUDTfbB0cbhA2dSwxLvJ7
	 enkqcCo+hF70e0I/RkX164m3RSV51P5XmuJTbSxfqcBp10PXi3M1TntIWgEj72reorheP
	 CAc75qKNhjpvrHfW+0tqkKKTTXBKT0aDCLnn6A93jq8vbJSSwm8uryLLxp5+6oHitTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Grxt8rTh;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C312606A31B
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 10:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C312606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Grxt8rTh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793098537; x=1824634537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gisSPxKckGRyj7krOfYw+Y8RfTNWJ8ia9rK5SRV+UQk=;
  b=Grxt8rThdXe3+c4amp0oOeu+F1c855LTMi0FOiluRJuK91/Qh+mj2Hym
   kg18cUr0NiUG+AnI80LjCFzBXjx8SUePrzeIrqGjvW0aX4Gl01XV6gU/q
   BqzS43GjPuoOp6culw5m7R16vjz0razu3qORT6ldueDsyyGjYk7CEuZS4
   sN78IvEwHTvF4b3eMbNu/+YJkgUt+BVVRvS5wbLmwm/KeGNtvb2xHwQaf
   zyNWjNqA28IFhWoZmIpHYteRXmGqBBtr1WutEzPdGZ7J+ZoID+vaB1QR0
   K+42ttHNMy81mABd+FLnKHjHz1p4PCbuV76l8pSBh1Y1ujflN0dRGhIav
   g==;
X-CSE-ConnectionGUID: 9D0CIHvQQYGRRZKYW2K8mg==
X-CSE-MsgGUID: yoC+ZPAHQi2NnFCwMs5oHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1679256"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1679256"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:55:36 -0700
X-CSE-ConnectionGUID: 6L5mL92xS2S1+A7xkufLTg==
X-CSE-MsgGUID: xLKUR3IaSFaojQ+PON0IzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4901399"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:55:34 -0700
Date: Tue, 27 Oct 2026 12:55:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Francesco Lavra <flavra@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH 38/39] iio: imu: st_lsm6dsx: use
 iio_push_to_buffers_with_ts()
Message-ID: <auCDIxUsvEO_gsvY@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-38-8b136778eedf@oss.qualcomm.com>
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
In-Reply-To: <20261026-iio-v1-38-8b136778eedf@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:05:56PM -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

...

>  				if (gyro_sensor->samples_to_discard > 0)
>  					gyro_sensor->samples_to_discard--;
>  				else
> -					iio_push_to_buffers_with_timestamp(
> +					iio_push_to_buffers_with_ts(
>  						hw->iio_devs[ST_LSM6DSX_ID_GYRO],
>  						&hw->scan[ST_LSM6DSX_ID_GYRO],
> +						sizeof(hw->scan[ST_LSM6DSX_ID_GYRO]),
>  						gyro_sensor->ts_ref + ts);

Seems like a lot of code duplication in all three cases.
But yeah, it's out of scope of this change.

>  				gyro_sip--;
>  			}

-- 
With Best Regards,
Andy Shevchenko


