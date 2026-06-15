Received: from outbound5.mail.transip.nl (outbound5.mail.transip.nl [136.144.136.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83013EDE4B;
	Mon, 15 Jun 2026 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527747; cv=none; b=HZpoRqX1uYqnOvpiBdidImYD4u1elrQShOEDOrywLdwLC6btnZwD+s//TisBU9vAkImwV9YWRPXAau8kOMGQpgREdtA39DuuVRzvdmc3z3llUWpLYw1XG4DT/c/B3wCIDYF81DQh1Pz86NgFyl0PB35WaOfah16L/3JZvu7iUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527747; c=relaxed/simple;
	bh=z7GcwDh4DZnnqlV0nBIfle2WmTmZFJiKwRwMizo9nR8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JXnQ9ml0nXyZ4+FAf/7Be23NVz48cbgvmv49/bj4PpRO/vE1gry4puX0f9n6TkPo3CpnKyNBL+DWNrmQl1oRGQJzpSvJDqMMhUiEq2QHGX87YY6jHxZvv/Agir4NPE97uk8xJBlkan/CxT6WvpreLNE97zZgHDGdAcoYHcFGl68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=nE9KljIA; arc=none smtp.client-ip=136.144.136.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="nE9KljIA"
Received: from submission11.mail.transip.nl (unknown [10.103.8.162])
	by outbound5.mail.transip.nl (Postfix) with ESMTP id 4gf8qv40vFzHV1G;
	Mon, 15 Jun 2026 14:41:15 +0200 (CEST)
Received: from transip.email (unknown [10.100.4.34])
	by submission11.mail.transip.nl (Postfix) with ESMTPA id 4gf8qt6bLjz3R3nyv;
	Mon, 15 Jun 2026 14:41:14 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Jun 2026 14:41:14 +0200
From: me@herrie.org
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Herman van Hazendonk <github.com@herrie.org>, jic23@kernel.org,
 linusw@kernel.org, denis.ciocca@st.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, sanjayembeddedse@gmail.com, maudspierings@gocontroll.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: common: st_sensors: honour channel endianness in
 read_axis_data
Reply-To: github.com@herrie.org
Mail-Reply-To: github.com@herrie.org
In-Reply-To: <aiMLuIlRPHXuj3cH@ashevche-desk.local>
References: <cover.1780652883.git.github.com@herrie.org>
 <0dac8e8e2872dc180b138923b5cd4fd18eee047b.1780652883.git.github.com@herrie.org>
 <aiMLuIlRPHXuj3cH@ashevche-desk.local>
User-Agent: Webmail
Message-ID: <58115ff8fad3f4762b7c626ce1eab1f5@herrie.org>
X-Sender: me@herrie.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission11.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1781527275; h=from:reply-to:subject:to:
 cc:references:in-reply-to:date:mime-version:content-type;
 bh=tJPSx0Ef6GMUg7ussCLoZj0sQ3Fxpx9IbA8b/V+8u8k=;
 b=nE9KljIA1PIs0Y+xD5jJ1K2aiP45cZlUN2XtCZlVseMzvFnymVDetS9LpIUj5R69J1sibt
 Whq1LwmT0D8R7RXQbHhPVWdoMLOm5i9lqmTCGdFJ/htDlCy6HpUpWTRMw42rOxqO/DSuAl
 mGswyEQ9/Tg1f5t9GDW9vzPv2CRhA2jWjYt2HPJrGlHQYbRlAZ4YK/bFWU17/bkyC0kCjb
 LEytlxirP/Co0oJXx1wnqNqZer6+hn0Ci28pAaV4lt5S+r+s5MwL4WM2HuH64YbtLdZWoK
 0Z+7LPi73SjXQJjqLtpneZP6yTzmBrnVw0MT0uL/tBwIfd6EwhYIWdye0Zg0sw==
X-Report-Abuse-To: abuse@transip.nl

On 2026-06-05 19:47, Andy Shevchenko wrote:
> On Fri, Jun 05, 2026 at 12:08:41PM +0200, Herman van Hazendonk wrote:
>> st_sensors_read_axis_data() unconditionally decoded multi-byte
>> results with get_unaligned_le16() / get_unaligned_le24() regardless
>> of the channel's declared scan_type.endianness.
>> 
>> For every ST sensor that has used this helper since it was introduced
>> this happened to be fine because the ST IMU/accel/gyro/pressure
>> families publish their data registers as little-endian and the
>> channel specs in those drivers declare IIO_LE accordingly.
>> 
>> The LSM303DLH magnetometer however publishes its X/Y/Z output as a
>> pair of big-endian bytes (the H register sits at the lower address,
>> 0x03/0x05/0x07, and the L register immediately after), and its
>> channel specs in st_magn_core.c correctly declare IIO_BE -- but
>> read_axis_data() ignored that and decoded as little-endian, swapping
>> the high and low bytes of every magnetometer sample.
>> 
>> The bug is most visible on a stationary chip: in earth's field the
>> true X reading is small and the high byte sits at 0x00, so swapping
>> the bytes pins sysfs X at exactly the low byte's pattern (e.g. 0x00F0
>> = 240). Y and Z still appear "to vary" because their magnitudes are
>> larger and the noise in the low byte produces big swings in the
>> swapped high byte:
>> 
>>   before (chip flat, sysfs in_magn_*_raw):
>>       X=240 (stuck), Y= 12032..23296, Z=-16128..-9728
>> 
>>   after (direct i2c-dev big-endian decode, same chip same 
>> orientation):
>>       X≈-4096, Y≈210, Z≈80     (sensible values reflecting earth's
>>                                 ambient field at low gauss range)
>> 
>> Fix read_axis_data() to dispatch on ch->scan_type.endianness and
>> call get_unaligned_be16() / get_unaligned_be24() when the channel
>> declares IIO_BE. Existing IIO_LE consumers (st_accel, st_gyro,
>> st_pressure, st_lsm6dsx and others) are unaffected because their
>> channel specs already declare IIO_LE and the LE path is unchanged.
> 
> ...
> 
>> -	if (byte_for_channel == 1)
>> +	if (byte_for_channel == 1) {
>>  		*data = (s8)*outdata;
> 
> Maybe for the consistency's sake use sign_extend32() everywhere?
> 
>> +	} else if (byte_for_channel == 2) {
>> +		if (ch->scan_type.endianness == IIO_BE)
>> +			*data = (s16)get_unaligned_be16(outdata);
>> +		else
>> +			*data = (s16)get_unaligned_le16(outdata);
>> +	} else if (byte_for_channel == 3) {
>> +		if (ch->scan_type.endianness == IIO_BE)
>> +			*data = (s32)sign_extend32(get_unaligned_be24(outdata),
>> +						   23);
>> +		else
>> +			*data = (s32)sign_extend32(get_unaligned_le24(outdata),
>> +						   23);
> 
> Why do you need casting here? sign_extend32() should return signed 
> type.
> With this being addressed, you can make them one-liners.
> 
>> +	}
> 
> 	u32 tmp;
> 	...
> 	if (byte_for_channel == 1) {
> 		// this way is done to show the below variant
> 		tmp = *outdata;
> 		*data = sign_extend32(tmp, 7);
> 	} else if (byte_for_channel == 2) {
> 		if (ch->scan_type.endianness == IIO_BE)
> 			tmp = get_unaligned_be16(outdata);
> 		else
> 			tmp = get_unaligned_le16(outdata);
> 		*data = sign_extend32(tmp, 15);
> 	} else if (byte_for_channel == 3) {
> 		if (ch->scan_type.endianness == IIO_BE)
> 			tmp = get_unaligned_be24(outdata);
> 		else
> 			tmp = get_unaligned_le24(outdata);
> 		*data = sign_extend32(tmp, 23);
> 	}
> 
> Or even
> 
> 	if (byte_for_channel == 1) {
> 		tmp = *outdata;
> 	} else if (byte_for_channel == 2) {
> 		if (ch->scan_type.endianness == IIO_BE)
> 			tmp = get_unaligned_be16(outdata);
> 		else
> 			tmp = get_unaligned_le16(outdata);
> 	} else if (byte_for_channel == 3) {
> 		if (ch->scan_type.endianness == IIO_BE)
> 			tmp = get_unaligned_be24(outdata);
> 		else
> 			tmp = get_unaligned_le24(outdata);
> 	} else {
> 		...error...
> 	}
> 	*data = sign_extend32(tmp, BYTES_TO_BITS(byte_for_channel) - 1);
Good points, both applied as you suggested in v2. Single u32 tmp 
captures
the per-width decode, then one sign_extend32(tmp, 
BYTES_TO_BITS(byte_for_channel)
  - 1) at the bottom handles all three widths. Casts are gone. I also 
turned
the previously-silent 0/â‰¥4 fall-through into an explicit return 
-EINVAL so
a malformed channel spec is caught instead of leaving *data uninitialis

Thanks,
Herman
