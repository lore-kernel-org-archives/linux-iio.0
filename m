Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507758;
	b=zOB07ObhMsl+7H3ZsfyJShcdfVY9ZrctA/Cx4qpaqp2qyyqc5nTUkcFQYrn81+87qleR
	 RmumcjKu3cd68wa61ug/zr+tNR/hPKdbkV9kv0kJw1v3dmA4fNL574GsZvv52Z82seWUi
	 n2z03Ka7qoc88zsD4pkJZtmK2/TTxp6eHLpFEHFdqVnFZQ3USsluVbfuw0RltAZiRYnTG
	 sseBm+do0PD5PtGK7SjtXUBO+RaiG1B6CIpf8o+GKrETkE376uR8OTrJFPFjKUO4nTpLn
	 52t//SncfpfMITTSfwFwTIgBVXgJRdw1k2KqpkN8c36vlVQQKLvPjCeLxkYaSFTsYLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507758;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=EHE8YClXc9FFppzZgrQs5Zf5py88spwpx6w6Rv+xfNI=;
	b=gQFj4lIKZDuYXaqRxQqqKOSVmtsF4BvwRT/P6PcvR9KfjygE63YRzm4UMwf1/fmxsPte
	 TvefjB6hMt4iaJUESm6joV9eTLdvOzTwcpQp1iu6wnfnuiHS5hZFR7U9AA8zFlqRk62LV
	 CwMdAt7ho1bBl9ZqsNA7RC1EEFOM8LYW50pFY6snF9+c82dABXrFC0ErOs3WJsegVUvPv
	 IXOrMCdNNgpvxKntD32TRuPfsW6q8SgraiO8UrcPeWFrgBvZcIdEph4pMGjWPn3Gprsj3
	 tzgBqTIe6tevfRQ1Mx3stQX/EDryxW6KHAv1oK5j3q8eEiRQG9e0kIhgHlp6EoE5BbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i207joxA;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517B606A326;
	Tue, 24 Nov 2026 08:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4517B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i207joxA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795507758; x=1827043758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Lref5JkTIVvgIpN4q2Dgd96p3Q3h4N9LcHJa2eD2gs=;
  b=i207joxAwWiFwZl669N6tyh104p2O3ZNIu3AEipQxqJSz59DEPNRZ6l7
   RWToQnkLLJDGaAS2sIPNfNVoeYK2cENgvvIOh9h+zy4ZOGULK4fMK1RHZ
   yz97jZVFq23HKUNMvpfuWhOak4tkoibdqiadcwRN83kdow3qeaUfmIf36
   Gk434ug+DbmLpwVDAQMYp0xpPmgqLtLZ5+ghhFXL3mZvFWJplceJHPu1O
   ImPMc9E8KeEAS/ZyS2hQoNOaQIvFW5lHzD5V6ILe6Ybs1h2xKJJfa2KzR
   3fDPCTgU38ULzUwwxEZR3vT2wanh7XtZpIzCmX/DeDVkhfYrNEsJbfsln
   A==;
X-CSE-ConnectionGUID: 3WsK4eolSpO/UUlvhsWdNg==
X-CSE-MsgGUID: yXrInX3FR8ObmvB9g7+Ivw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4360143"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4360143"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:08:16 -0800
X-CSE-ConnectionGUID: nOBOnBEKRGmTXu/B3LDF2g==
X-CSE-MsgGUID: gwWnqpw6QWuDRVzPauS7FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11537549"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:08:13 -0800
Date: Tue, 24 Nov 2026 10:08:10 +0200
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
Subject: Re: [PATCH v4 4/4] iio: magnetometer: mmc5633: Add mount matrix
 support
Message-ID: <awVF6ktwwpW7SiiY@ashevche-desk.local>
References: <20261123202616.17334-1-gerard@teslabs.com>
 <20261123202616.17334-5-gerard@teslabs.com>
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
In-Reply-To: <20261123202616.17334-5-gerard@teslabs.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 09:26:15PM +0100, Gerard Marull-Paretas wrote:
> Read the mount matrix from the firmware and expose it, so that user
> space can account for how the sensor is oriented on the board.

There is no explicit ACPI support, so the mount matrix enabling is
straightforward.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


