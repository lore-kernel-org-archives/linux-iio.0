Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6E73ED5A6;
	Tue, 16 Jun 2026 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608190; cv=none; b=kqYy+pj53BhPn7WLBL4MKdOz+nW8gg6e1TPFuo9tPjQnY2HE3qjyMCNcJT3gU4SAclhqH2dDg1L8s1si63hcFl5Ytx8maEfvXguEr2aXuHGx9ywYpTp9bradedZ2PYaB/g2AzKu2ozEIl0qgXXQuHl+vjoL6uKcqGPOZ/tn38g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608190; c=relaxed/simple;
	bh=zVLmNdbqcdgaIpabNeHauLHcVtIQXyItIe+/fQ2wNd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4kAuMFM7THh1IgA5vqDa/eppVoqhg27i537QK1OmEm0R5+dFq8a9ZderFWVcSzPeP41bQKbnNPkdR7ZjsX1ndujXUyR4CmtxWQxNg7buE7/BAjYt0poamldrnN+9Urr2NhsHhAWVOj2OxA9WfENtvFjOCDFS04uP4aiogEZ754=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKQqWLrr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKQqWLrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781608189; x=1813144189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zVLmNdbqcdgaIpabNeHauLHcVtIQXyItIe+/fQ2wNd8=;
  b=cKQqWLrrPUp5y36hLlbXRaSqdnwxYhHPi6Rh2pEDIRLeNtwFFJyVm6Cb
   Chjg3sbM/H5496BxnHsFwAcWpyTo5VCTfS3S7+gPJjMWkIXcrkMMR1BWR
   mncrzyh/WNqoa4EaUMe7KvgxO6/eQTB6nzTfvLjQHggqvUyAvf1+GvC1f
   pTcHaGz3TGNsW9mUHrSxqyBORsHgu6T4sNrE+Vuf91qgGQWcsxWxs1YiU
   rYA4qX6UiEU93453h2alZpsJyQoZJwkX+9P+t5PJb1tq0EFMybmieHd6l
   5+jop6ACa545ApJdf+VnD9hA41uOqwTWTkNmKI/AXtgfGNV27FHObNpPV
   w==;
X-CSE-ConnectionGUID: ZaPB5hHCTA+Nvar0kOo0nw==
X-CSE-MsgGUID: 0d2cmOHZSIGt19AThb/f9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86271477"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86271477"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:09:49 -0700
X-CSE-ConnectionGUID: IQ9r4yVVSjaSe3ozHtRXOQ==
X-CSE-MsgGUID: M7bd+DTERiy8I5Nn/qS3Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247615803"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:09:46 -0700
Date: Tue, 16 Jun 2026 14:09:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v5 3/6] iio: osf: add protocol decoding
Message-ID: <ajEu95ZgIPEsvoKu@ashevche-desk.local>
References: <20260616072242.3942-1-kimjinseob88@gmail.com>
 <20260616072242.3942-4-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616072242.3942-4-kimjinseob88@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 04:22:39PM +0900, Jinseob Kim wrote:
> Add helpers for validating and decoding Open Sensor Fusion frames and the
> message payloads used by the initial receive path.

...

> +int osf_protocol_sensor_sample_value(const struct osf_sensor_sample *sample,
> +				     unsigned int index, s32 *value)
> +{
> +	if (!sample || !sample->samples || !value)
> +		return -EINVAL;
> +
> +	if (index >= sample->channel_count)
> +		return -ERANGE;
> +
> +	/* Samples are little-endian two's-complement signed values. */
> +	*value = (s32)get_unaligned_le32(sample->samples + index * sizeof(s32));

This casting does not add anything.

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


