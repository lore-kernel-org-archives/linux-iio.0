Received: from outbound4.mail.transip.nl (outbound4.mail.transip.nl [136.144.136.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3C1FF7C5;
	Mon, 15 Jun 2026 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527650; cv=none; b=LqfJy43yEmO3ufp+FSzBlBzyp8CspWtxxBTa8+D8E927oo7ZMFHsbMC8in12+tVRynUd3UuiT/mUNw0IhMD51/vUktfXkyBeXa9DC0GWTPh9Tdb/AJWvcJ0c32skapoux4zpZIaR0SOxyEIFN+Zz1T89pQtZB+20jaapyPxCCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527650; c=relaxed/simple;
	bh=8SjkRrMGYCeREjwMPd90os0gKlWthgMw2Qg0oFduXC4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=SrZbXG/oyPAolGP2fUNINmBYUvr5pkuji2wgIl6w0Z3A6gpkp0R3Y88/w+3WJFUNHTHhKf0cqSczo4AnVnZGekQs8h8xxBXMc+UMZp/1ZVGQQPsT9SwS3xMziTyVWC775Htl5M5yEy8XAtfRlhATIP6cQWSRcSbRr7QSREkALBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=Ys0Etg92; arc=none smtp.client-ip=136.144.136.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="Ys0Etg92"
Received: from submission7.mail.transip.nl (unknown [10.103.8.158])
	by outbound4.mail.transip.nl (Postfix) with ESMTP id 4gf8pX3v1fz1DG0D;
	Mon, 15 Jun 2026 14:40:04 +0200 (CEST)
Received: from transip.email (unknown [10.100.4.34])
	by submission7.mail.transip.nl (Postfix) with ESMTPA id 4gf8pX08rcz3fqZNX;
	Mon, 15 Jun 2026 14:40:04 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Jun 2026 14:40:03 +0200
From: me@herrie.org
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Herman van Hazendonk <github.com@herrie.org>, jic23@kernel.org,
 linusw@kernel.org, denis.ciocca@st.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, sanjayembeddedse@gmail.com, maudspierings@gocontroll.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: magnetometer: st_magn: honour st,fullscale-mg DT
 property
Reply-To: github.com@herrie.org
Mail-Reply-To: github.com@herrie.org
In-Reply-To: <aiMMzSf8-C9fTlWW@ashevche-desk.local>
References: <cover.1780652883.git.github.com@herrie.org>
 <a8b63f5997700aba85883816a5d7520dcb28a96d.1780652883.git.github.com@herrie.org>
 <aiMMzSf8-C9fTlWW@ashevche-desk.local>
User-Agent: Webmail
Message-ID: <75adda02cb8faf9d99953ad4fdcbf961@herrie.org>
X-Sender: me@herrie.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: ClueGetter at submission7.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1781527204; h=from:reply-to:subject:to:
 cc:references:in-reply-to:date:mime-version:content-type;
 bh=gOIBt7onBO1ICRlAwrvRdvLXASFMfZuwwY223rj2jaI=;
 b=Ys0Etg92XzTcDKfmnU9TotyubgT2mket/EdEynC5AcukDdf89S5oS20v9RZORJfSTMMfEu
 NieIz41ouQLG8cnbNocArQcG6lwxUbeQDS0LZoCBvFvmB/FfBA5DKRNov+ukcPrP2SrvG7
 tPUQ0PUWaD1HOEwOONznr5B/PzcQrlpM1jQyMQ+9q6p4CBy6sP+YUQEqJe1kecOOFSTMZZ
 grt4nuNI7FxzqPiIJjTD6jvzVUIzkMKwlS0FlO7bBDZmXbv6hmCFR16jv8qx5OVzQospij
 u4XBKI1IfaKWPvVYIXfUdwAuuIjJoqzg5K122feQe7LP2dfS8OxamWsOx/JwjA==
X-Report-Abuse-To: abuse@transip.nl

On 2026-06-05 19:52, Andy Shevchenko wrote:
> On Fri, Jun 05, 2026 at 12:08:43PM +0200, Herman van Hazendonk wrote:
>> The ST magnetometer core's common probe hardcodes fs_avl[0] -- the
>> highest-sensitivity full-scale supported by the chip -- as the
>> starting range. For the LSM303DLH that is +/-1.3 G; for the
>> LSM303DLHC and LSM303DLM it is +/-2 G; for the LIS3MDL it is +/-4 G.
>> 
>> That is the right default for "minimal noise floor at a desk", but
>> it leaves no margin for boards that pick up appreciable DC bias from
>> nearby PCB structures. On the HP TouchPad (apq8060 / tenderloin) the
>> LSM303DLH magnetometer is mounted close enough to the surrounding
>> power planes that X reads back as the chip's 0xF000 overflow
>> sentinel (== -4096 raw, the value the chip publishes when the ADC
>> saturates) on every sample at the chip-default range, while Y and Z
>> fall well within the +/-1.3 G window.
>> 
>> Parse the st,fullscale-mg device-tree property (documented separately
>> in dt-bindings/iio/st,st-sensors.yaml) in the magnetometer common
>> probe to select the initial fs_avl entry by its mg value. The driver
>> tolerates an unknown / unsupported value by falling back to the chip
>> default and warning, so the property is purely additive -- existing
>> in-tree DTSes are unaffected.
>> 
>> Per-sensor mg ranges are listed in st_magn_sensors_settings[]. For
>> LSM303DLH the valid values are 1300, 1900, 2500, 4000, 4700, 5600
>> and 8100; for LSM303DLHC they are 1300, 1900, 2500, 4000, 4700, 5600,
>> 8100 (same code path); for LIS3MDL they are 4000, 8000, 12000, 16000;
>> and so on. Sensors with a fixed full-scale (fs.addr == 0) simply
>> ignore the property.
>> 
>> Empirical scale sweep on the HP TouchPad confirmed that on this
>> board any fs_avl >= 1 produces non-saturated X readings:
>> 
>>     scale (0.001 G/LSB)  | X raw    Y raw    Z raw
>>     --------------------+-------------------------------
>>             1.100        | -4096    44       46    (X saturated)
>>             0.855        |  -547    37       37    (clean)
>>             0.670        |  -433    94      103    (clean)
>>             0.450        |  -266    44       71    (clean)
>>             0.400        |  -235    34       65    (clean)
>>             0.330        |  -196    27       56    (clean)
>>             0.230        |  -145    15       40    (clean)
>> 
>> 2500 mg is the natural choice for tenderloin: comfortably outside
>> the saturation regime while keeping useful precision for compass
>> applications.
> 
> ...
> 
>> +	{
> 
> Oh, no. Use
> 
> 	const char *propname;
> 	...
> 	propname = "st,fullscale-mg";
> 	if (device_property_present(..., propname)) {
> 		struct st_sensor_fullscale *fs = &mdata->sensor_settings->fs;
> 		u32 fs_mg;
> 
> 		ret = device_property_read_u32(parent, propname, &fs_mg);
> 		if (ret)
> 			return ret;
> 
> 		...
> 	}
> 
> instead.

Hi Andy,

Done in v2: propname lifted to a local, presence check first, 
device_property_read_u32()
failure now return errs rather than silently skipping, and the dev_warn 
format string uses
%s, propname so the name is in exactly one place.
> 
>> +		u32 fs_mg;
> 
>> +		if (!device_property_read_u32(parent, "st,fullscale-mg",
>> +					      &fs_mg)) {
>> +			struct st_sensor_fullscale *fs =
>> +				&mdata->sensor_settings->fs;
>> +			int i;
>> +
>> +			for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
>> +				if (!fs->fs_avl[i].num)
>> +					break;
> 
> This is strange. What's the point to go via the whole table? Does it 
> have gaps?
> 
>> +				if (fs->fs_avl[i].num == fs_mg) {
>> +					mdata->current_fullscale =
>> +						&fs->fs_avl[i];
>> +					break;
>> +				}
>> +			}
>> +			if (mdata->current_fullscale->num != fs_mg)
>> +				dev_warn(parent,
>> +					 "st,fullscale-mg=%u not supported, using %u\n",
> 
> Also use %s and propname.
> 
>> +					 fs_mg, mdata->current_fullscale->num);
>> +		}
>> +	}
It's not gaps: fs_avl[] is a fixed-size array of 
ST_SENSORS_FULLSCALE_AVL_MAX (currently 8)
entries, but different magnetometers fill in different prefix lengths up 
to that cap.
LSM303DLH uses 7 entries; LSM303DLHC uses 7; LIS3MDL only uses 4.

The if (!fs->fs_avl[i].num) break; is the existing sentinel convention 
used elsewhere in this
file (see st_sensors_set_fullscale_by_gain() / st_sensors_match_fs()) so 
the loop terminates at
the first zero .num. I kept the same convention so future sensors with 
shorter ranges just work;
happy to switch to a ARRAY_SIZE() + is_terminator() helper if you'd 
prefer, but that would be a
wider cleanup than this patch warrants.

Thanks,
Herman
