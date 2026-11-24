Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516791;
	b=A/9vYibyAT1GTJ5MZnlxlUPuTX/3MmWmqZhbuAOTV9LfgVwMj3p1+hRoWEF223gneUjU
	 rN+SmEw/mU41jKdzcAqSKlSCPkd4GhYZA1D8x0HzBsolnTDh/70Ta2iPCW2Jh7Vr8T2+F
	 pJPFSSBwhchZMfKU+qubIzlYXxqyONPA2U1hJzDNp7N+D0eAEFIJL+sl7+vbHR8DH9ner
	 2mRuO1bSPQpYIsJhQYDHj/dxepFJUzbRePuS3bxrjiN3dqloOiq8gloSFuE2hqu0pbDE5
	 VzjyiQG9/0XXwu3Wm5kgt8qDCAx8XIescVirdlj0I/lPJYZSMD5+0mSRlDVXrvdRqGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516791;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=fIKoTRf/vZe8A3Fh8OBkntjyjp2VDQe0y1sGoawVCe4=;
	b=cTiHz0FqfR1wUWlDHjHjt1mbqbqaW9ALX6tXv2/xa7sR3quoX/mcZka+j3Wl4dbpUdHR
	 oNdN1BIK2bk3eyMiH2MCP+tAmZAJmiZigUGRA88ONh548BAW2JfUlaWJxW69GgxdfwWJf
	 mbMBylwOpcd82KtkoKh//SGIlyB3GInUXyQ45/AFgFyPOpt9f1yABbdHPQuRPmC2+S1YW
	 XjKw83O5kKbqkZHdqny02OVbHrJ+cY5UFAKEIHfrl3Vb2imyGmd1idIAvJANd3TUzlKGv
	 lFO6QBQhosWSOvwtHfbAsGR92y86Pk7m7aMEmLGWm/KbCF7e+28+ZaUGhYwv+SXcrLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EbGdKYTO;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A1606A31E;
	Tue, 24 Nov 2026 10:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E2A1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EbGdKYTO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795516791; x=1827052791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w+aoWyRMc6ObgqHfcHZhGgWjzhku534lrOT58Tlay5o=;
  b=EbGdKYTOUSFQ4enzMReLeBmn6sYMW2QKNwt/J+1m9vqJtzAJYJDltOh6
   xaEf6YbF6BWhtCqS1wCTITlWL1ylIiuB2BcviiTaMbJeRLJJX8v0mphNU
   vUo9gFmmzyfsTCSMbE0H2VUjp9JUU+5vwsI9QVIVew4Cy+5y67hUk3ThH
   dsjn51EtWdwCURq6gjcz53BT5brKjtLIUHBme496yx5FvDZCYz+kJic8M
   xEJUpDVjyNDQ2HB5+oy8ySVRq3iXqNUnAyg5tjx/Ph4Fpkn3tWb+pKpjk
   YhhC3QKYnHu3Xp+Bz0dKBgTjthNpgmt6nvIwIS1kuY4ZoB6N0XP8rlwsC
   g==;
X-CSE-ConnectionGUID: gz5QZL+qQimmZMJWArQd8A==
X-CSE-MsgGUID: Fo6x3RM/QZmT7G+cQ5X9lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4390207"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4390207"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 02:39:50 -0800
X-CSE-ConnectionGUID: M7/I2tkmT9OkLcQGBPBeSw==
X-CSE-MsgGUID: 3ipBm3BGQ1S7drwyPK6HiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11924951"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 02:39:48 -0800
Date: Tue, 24 Nov 2026 12:39:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gerard Marull-Paretas <gerard@teslabs.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] iio: magnetometer: mmc5633: Add mount matrix
 support
Message-ID: <awVpcYkY-qXwn6bi@ashevche-desk.local>
References: <20261124094632.8879-1-gerard@teslabs.com>
 <20261124094632.8879-5-gerard@teslabs.com>
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
In-Reply-To: <20261124094632.8879-5-gerard@teslabs.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 10:46:32AM +0100, Gerard Marull-Paretas wrote:
> Read the mount matrix from the firmware and expose it, so that user
> space can account for how the sensor is oriented on the board.

...

>  	fsleep(MMC5633_POWER_ON_US);
>  
> +	ret = iio_read_mount_matrix(dev, &data->orientation);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read mount matrix\n");

Thinking about this more, maybe slightly better to check it before touching
the regulators? No need to resend until specifically asked, let's wait what
Jonathan says about this.

-- 
With Best Regards,
Andy Shevchenko


