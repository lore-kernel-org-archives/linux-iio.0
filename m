Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707017;
	b=koYD8cw4AeyjOoE82a1+kTOypQmikgd5Ws817GuqnlH+hCu8+PJ/p8Bj7oTvtHnEsMW9
	 tliHbV44Azm/W/ZbXEl9FVsm1VuOFNgRf6kBRaeucywzfR3TksPTJMH8g3cSYdAWK30tU
	 3N8idAHYepueqJbw0EDsGZujeo1mveOjN6LtxM+aeZgZBu7xC6C9r1Dc448atiRVrl9Ws
	 bn6KdZlFziELK5QSNxPSNCyWNxY6w1alCr+n1hpahFFVePRtX3QDGGkF65WIYQaH7Y6V6
	 td4pAXa4o0hd7ZTa0LYF7L35XeF+Vu+wwHpSv4uGnjoGY6YXQuoC7GyxkVMQtms87Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707017;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=gpG61H4NaKgIlPD6cDVNG6JgarlHQOS56XSWB61VJ6I=;
	b=cQ6aMtQAJN6Z6HRWbl7O9FiHeyBjasD95S4eyORDvY65XY24n/iqIdOzRka/fSFziAC3
	 M3MUZhejRTw8SdmMAgEAnNTggBGNGDBYBb2eHkGWsNiUiHsVPtgH8gyLGb4bG6BOq8btj
	 bBaYxF/AI+1bN+Vq2/IWnb2OGZTNBINTw2J+Ece+66cXbw6fgr/qK9E4WVJLu5znzH+TE
	 j4UqrYYjWnSxJgp8Vg+/FTvv8YT2dOrXbLL0slr/o1Hkbx50Ix/KfkvVPsxQtyCZjwH+C
	 4WcoPOWvRTnCLte0zCY2Ot/IjG+q1E2LoRJzMeW3ENMZFkpb9hn17H8kdG2rrmOfOsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f5d3s41p;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17FF606A326;
	Tue,  3 Nov 2026 11:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B17FF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f5d3s41p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793707017; x=1825243017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yb0phZ9ZfbhxPWXKdu7Ovs5wBaI7W1Boke0adqZkUZs=;
  b=f5d3s41pAie0KNHi0lXSwAdH/VjQ1dzbAvmjBJx4jM+cXt3h7kjX7mcN
   AUKO2kUfPLEhFWKyEat0zn1tYeGauAJdvLrHZ/pzrhZ6OuABQ7LZ21KYY
   ehuri1uHQI5AE54f/Bv02uFFKQTieFvQKvU577go/VKwZUzvdPFNzW16W
   hOOu2t8/1t4gI6qgSj9HxxFXUcjobYxMrj9lg6IjKaeBUJKqzR1QrMaGZ
   CNQv1YCq/hhmJLB0ODfMwCeYQYLwHXilBurTWJbiT0rnFSv2QuDWTjwj4
   QICRQ4cg/zwNgAbQiqKX/QhVBpYwjbYaj8aVZBjpwMxQEvEsDyMU8YYWo
   A==;
X-CSE-ConnectionGUID: nkDJhORmTG2pk75QRI5SSw==
X-CSE-MsgGUID: ibC6GumBQjikwpGudAl/Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2421647"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2421647"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:56:56 -0800
X-CSE-ConnectionGUID: UKHryEbJR6uoszUa4CJoDg==
X-CSE-MsgGUID: XuIgmIB3R92iLX6eP/gjdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6405132"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:56:54 -0800
Date: Tue, 3 Nov 2026 13:56:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: validate the CNF0 package
Message-ID: <aunMA-vO-ILv86P9@ashevche-desk.local>
References: <20261103114146.75881-1-k.chen@smail.nju.edu.cn>
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
In-Reply-To: <20261103114146.75881-1-k.chen@smail.nju.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 07:41:46PM +0800, Kang Chen wrote:
> asus_acpi_get_sensor_info() walks the package returned by CNF0 and uses
> each element as a package without checking the object type or the
> element type.  A top-level string or buffer makes package.count alias
> its length and package.elements alias its data pointer.  For a
> non-package element, the inner count and elements pointer are taken
> from unrelated union members, so the driver can walk a firmware-chosen
> pointer and pass it to strscpy().
> 
> Require a top-level package and skip elements that are not packages.

acpi_evaluate_object_typed()

-- 
With Best Regards,
Andy Shevchenko


