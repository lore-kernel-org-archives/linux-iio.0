Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426130;
	b=r5Zw19jmvkC66vKQ4AArP7EZ79DQRUIKid6WU3AuD/zxqSwSnI8RWpdBy6viAbQL3WJg
	 6CjMsZKdBQp88vrMaafwWdg7VZo/YbGvV8oHNV1uQsirbckNhspTvxc1Q5wrMg5wK4eXt
	 HHy8UCqgzMxypdf3Ayi8IyNyQlRMftaK1ZNpZrM7roDKvK6bbdVDYxLHdoJRHM8oULEX8
	 pk4oKqiIA3PLluv4/MU8cjR9CQHp1ZA1bS5vwWUpuuR+Z3VB4nPi3ZNcVzCByJnKep0As
	 Mp8n7D1HfDMuvx/NYWat6KUjSaVN1qgFdJ+8GqburHGLjIMmNfRjIbewmCgH1F1DBDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426130;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=L+f3aZ4x97D1fte85K6wDTG5uEQdwKWHlKnLwZT1tVk=;
	b=OUfynNNrLNszm+nKBpAzg4axQNDN00+92rjw19CSm/+3qXYkE2V0UibBspZady+zzy09
	 dxg6pjsc7Eitl+6P0gFmw9iDLfdav+MeUpm+g8G2bApwelHqOary7GhOvFK1Sas3mhG0a
	 VeCBxQxVH0CEs2ovVtXCT0SL4BpVBqkPDUttSbTWYk3Imeu+onLbcoyxkC9aLqX1yvn4T
	 hUiJsSOCsnj+0+xCxnYf0xW2he5R+EV+DbTLMYQjXNl6Qg7gnFvrRPnWmEsRvoCJXq2FT
	 B4vi9VGsR2zYNyJ4SXnW0xRioV+WMiAh95ecKhq1cTiGkG2A0UGWlYoWYOpHkyYbnRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jA11vHXW;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069BB606A31E;
	Mon, 23 Nov 2026 09:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 069BB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jA11vHXW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795426129; x=1826962129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OEGqfdfi9J2+Fc3m22eFlI90/tdoU7Xa6xfbXr5Kg1o=;
  b=jA11vHXWa77L4Pyk7oW4Mto3gF492jTqQEssopaGv2I9u3Zd5kdtN+CE
   i7GK9XZgmHlW8cNZwyAMiKQFQa1kUMFUrHFPoqKTtJr8FBEeUJDLebt+Z
   ML6xEGcncEvDJL/qLkv5BQeOH5YyEqKyUW11+63lX1MGSAqvsoQ7p+x4U
   ucsS6D1mv2aRtkeEC5Shj+PtKLTfzBAKOLqXgXgFBFwEfXBgYwYjtYgv5
   SQuWHKzEWaR0PNbmWctItYH8ZXUF8pS+3le2pxwkoPinQZmans1fjofI4
   7rNQO2e25iM214vXCO+9cZ4xNtoOS7QM4zFxYlvuMSzF7b/P2ub6lFG0o
   A==;
X-CSE-ConnectionGUID: GwRqoKWGQDeupvYXaRbGSw==
X-CSE-MsgGUID: 2SQcEkP9SviRT+6BxHILuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4214638"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4214638"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 01:28:48 -0800
X-CSE-ConnectionGUID: AiikV351TdSKdQoprfHXzA==
X-CSE-MsgGUID: rMEpuSptTKyP476D0vWRBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11613688"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 01:28:45 -0800
Date: Mon, 23 Nov 2026 11:28:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akhilesh Patil <akhilesh.patil@linux.dev>
Cc: jic23@kernel.org, andy@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, conor+dt@kernel.org,
	joshua.crofts1@gmail.com, maxwell@maxwelld.cc,
	u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, akhilesh@ee.iitb.ac.in
Subject: Re: [PATCH 0/2] iio: chemical: Add driver and bindings for acd10
Message-ID: <awQHSgDkBlsOyuPP@ashevche-desk.local>
References: <cover.1795326744.git.akhilesh.patil@linux.dev>
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
In-Reply-To: <cover.1795326744.git.akhilesh.patil@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 22, 2026 at 06:30:43AM +0000, Akhilesh Patil wrote:
> This patch series adds support for Aosong ASAIR acd10 CO2 (Carbon
> dioxide) sensor driver in IIO subsystem. 

There is no answer to the question "Why a brand new driver?"

> Patch 1: Adds bindings for this hardware
> Patch 2: Adds driver code for acd10 under drivers/iio/chemical
> 
> Quick overview of acd10: 
> - This is CO2 sensor based on NDIR technology.
> - Can measure CO2 concentration up to 5000ppm
> - Supports serial interface over UART with 1200 baud rate. 
> 
> Datasheet: https://www.es.co.th/Schemetic/PDF/ACD10.PDF
> 
> Protocol: 
> acd10 defines 4 types of UART frames - read co2, get software version,
> get instrument number and set single point calibration.
> Frame format: fixed header, length of data, command code, Actual data,
> checksum. Response from the sensor follows same format. 
> Total length of each tx and rx frame for 4 commands is fixed and defined in
> the datasheet. Driver uses this information to write and read from
> sensor for each command over serdev interface.
> 
> Testing: 
> Driver is tested on Texas Instruments am62x sk board with sensor
> connected on UART5 on 40pin IO expander. Additional 3.3 to 5v
> bidirectional logic translator is used to interface with 3.3v IOs of
> am62x. Values are read using iio sysfs interface. Also I have blown into
> the sensor to observe sensor output increase due to CO2 in my exhale.
> Waveforms for read co2, get sw rev and get ins num commands are
> validated on logic analyzer. 
> 
> Slight deviation from datasheet: 
> For command get software version, datasheet mentions frame length of 16
> bytes including D11 reserved, however it is observed that sensor sends
> 15 bytes with length field 0xb (11 bytes of data), but actual data is 10
> bytes. Hence, this is handled in the driver.
> 
> Driver supports reading co2, getting sw version and instrument number.
> Single point calibration and preheat implementation is left for
> future contributions.

-- 
With Best Regards,
Andy Shevchenko


