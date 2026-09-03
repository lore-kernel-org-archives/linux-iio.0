Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247383D967F;
	Thu,  3 Sep 2026 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462256; cv=none; b=NNsmVTC54bo6aWhM3iqCsFuPa2t12AiZSTYdAb9JkWqRZnh29Rkgf9tDCa3u/mGUUJpleoQT3f69N0mezJQsdwNFQ55RHbXCMvgWMmsY9qp13zNaf2aXB2hC4JsSXXwQsW3wV0dMv1AWUaqvcd/BxiEityfWfdKSYx0nL2yIJHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462256; c=relaxed/simple;
	bh=/DcY3GIMjuNpJdqiErGiqA7clOZM3xb6leblrclnTC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpgLo1OUrcHUCBx4CZRiXbKkj9XbhJYHiiHIOx7zJkUEC1LJN4AZ+qMjzr05WuiPjgfzcjvs9WjVDqsye9kWfpemnxFipcAX6Lw6FntdNZEM9ELYii5KE+7XN+RPL4cqiXDqKjc1lyz8Tkac6Kd6lsMPlPYUM59PThYoyUzCCK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMkQTu/0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMkQTu/0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788462249; x=1819998249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/DcY3GIMjuNpJdqiErGiqA7clOZM3xb6leblrclnTC0=;
  b=PMkQTu/0sBNLfGhI2IKfjFmfLM4U+kZMYaNh5fQGd8igMiTcYBThdHRt
   eRZqdvu/Q6QMA6pcE/eRi5oOopbYHlrscRZKYIRQMn4iBUXpxg+UePTI1
   acdSame8ttND2uixA6p0jrSHPKBm/eY/h5AWFej4Zs80XerMHJU23cwa5
   lM+5Kppgp6JbCab+PC4Dlw4TJbl/Hugt5+6c2N7mwZBwPC13Gb1/bqCI+
   9e5VR8U3GKZFxokG0mr2VXqk69n3YPCDvqkajtL47v1wj8qh2vuzxWOZD
   +zpzKL9hg4wt2U47R/+z+ysrSLwHuTmz64ZjOBJD6ZYEHZRmV3LJbDzU2
   g==;
X-CSE-ConnectionGUID: 9EnQIlmPTnS4b2c8l6PArw==
X-CSE-MsgGUID: hyhWeeifRdad/Q6OozAsNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88835002"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88835002"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 12:04:01 -0700
X-CSE-ConnectionGUID: ghhwwhHbSEq30dkHDHEuXA==
X-CSE-MsgGUID: 3fXPb4WhTDO6Ccjt1lVZVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="293323479"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 12:03:58 -0700
Date: Thu, 3 Sep 2026 22:03:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1015: Add support for label
Message-ID: <apnEm92_E1_Axhvz@ashevche-desk.local>
References: <apkRJ8T-X-HoNiDB@ashevche-desk.local>
 <20260903151627.5011-1-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903151627.5011-1-flaviu.nistor@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 06:16:27PM +0300, Flaviu Nistor wrote:
> On Thu, Sep 3, 2026 at 9:18 AM, Andy Shevchenko wrote:

...

> Since the iio core exposes in sysfs the in_volatagex_label
> for all channels, there are 3 situations:

> 3. The channel is not defined in the dts (in_voltagex_label is still visible
> in the sysfs), and reading the label will cause "(null)\n" to be printed in
> the console (as indicated also by Sashiko boot), since the default "" value
> is not assigned during device_for_each_child_node_scoped(). I think this is
> not an issue since is just the way sysfs_emit() handles an NULL string.

Is this current state of affairs?

If so, the patch must not change that — it's an ABI now and (null) is valid
response from the user space point of view.

> What would you prefer? Any further suggestions?

-- 
With Best Regards,
Andy Shevchenko


