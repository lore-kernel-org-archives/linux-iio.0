Received: from outbound8.mail.transip.nl (outbound8.mail.transip.nl [136.144.136.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CFC3E3153;
	Mon, 15 Jun 2026 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521970; cv=none; b=Q6xjf1o5GIGdf81hViIwP4RkjxzfE3N5ItjRjQZT4Xai643C8ftX7EEQGJZI8aUGwSrPJT/Ao5pSfYNsxsCS+SGYs9pRBAqIbtmBCHvzXAvDgrt9zbfxtV6ourLpPWhFcSnJmVZh+sm6DL+55gJbzR82DdzBP8OaO1ArvjbrWiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521970; c=relaxed/simple;
	bh=i1fJphGInHt+MH5vnYGByStkYCIbzrGiFpLXbuB18bI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PTkjxx0g46SmmPhMq0Qn+dvsrj67h+zd2a4lJ6mOPr04u4W72bnUVDDOd3TTkPNzyFBK7eyZDgU4TnO24/yPK0AVfdkQ9ZkFVlCACt6gGI6wiaBHe7RwJDGMUdB2CTT328SdhsAwkzVFqsJvF6F9v/rgIIphS/OggFnYTW+o2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=pqjz8gmU; arc=none smtp.client-ip=136.144.136.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="pqjz8gmU"
Received: from submission15.mail.transip.nl (unknown [10.103.8.166])
	by outbound8.mail.transip.nl (Postfix) with ESMTP id 4gf6sc0KN4zY76j3;
	Mon, 15 Jun 2026 13:12:36 +0200 (CEST)
Received: from transip.email (unknown [10.100.4.34])
	by submission15.mail.transip.nl (Postfix) with ESMTPA id 4gf6sb2nl3z3R3nyj;
	Mon, 15 Jun 2026 13:12:35 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Jun 2026 13:12:35 +0200
From: me@herrie.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Herman van Hazendonk <github.com@herrie.org>, linusw@kernel.org,
 denis.ciocca@st.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, sanjayembeddedse@gmail.com, maudspierings@gocontroll.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: common: st_sensors: honour channel endianness in
 read_axis_data
Reply-To: github.com@herrie.org
Mail-Reply-To: github.com@herrie.org
In-Reply-To: <20260614193908.522272ed@jic23-huawei>
References: <cover.1780652883.git.github.com@herrie.org>
 <0dac8e8e2872dc180b138923b5cd4fd18eee047b.1780652883.git.github.com@herrie.org>
 <20260614193908.522272ed@jic23-huawei>
User-Agent: Webmail
Message-ID: <7a4f25be10eae7c22125863a2523f435@herrie.org>
X-Sender: me@herrie.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission15.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1781521955; h=from:reply-to:subject:to:
 cc:references:in-reply-to:date:mime-version:content-type;
 bh=mGJ7Z6B3aU7tj5WDPKIkd1Iu5EsLo/qlOIAj54yFA7c=;
 b=pqjz8gmUMMeg9l3q3+K6SDEuW4aNABMp3Nz66ahoWw5ju7E9ZaNpnbq34VPAnKYuWRiiwM
 nMEyXcCQ6JXsMLmLQmy9lr80RFtmcCR2bqzowwjhqZUs1SIyCUZMY6ncgwZrxawW6NWGfm
 IbLWrOeK78pPQNwZSg4VJs730hzzJZzaawUW7NJcV/S+abkFc01Vgt5Ys38/R2JHSqVc48
 p+qyn0L/ikixyqvhMzw5RyYx7AdgC1IDKizfsq8AhDlGHO2VuOkFZ2TnJz8BIkvzpfaA4o
 ZocIA2lx8oWmpUvYZcZKxVtlPF1Gq5mwgKJ9vIpzjXSZHHd+22Zdz0IC0BMZLw==
X-Report-Abuse-To: abuse@transip.nl

On 2026-06-14 20:39, Jonathan Cameron wrote:
> On Fri,  5 Jun 2026 12:08:41 +0200
> Herman van Hazendonk <github.com@herrie.org> wrote:
> 
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
>> 
> Hi Herman,
> 
> Fixes tag please.   We want to know how far to backport and provide
> info to those trying to work out if the bug affects their kernel
> trees.
> 
> Thanks
> 
> Jonathan
> 
>> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
Hi Jonathan,

I've been working with the HP TouchPad which uses the Qualcomm APQ8060 
to bring this to mainline kernel, which was running a very ancient 
2.6.35 kernel where I could compare things since it was working there 
without issues, hence I could compare them side by side, check values 
etc.

It seems this "bug" was introduced with 3.9:

Fixes: 23491b513bcd ("iio:common: Add STMicroelectronics common 
library")

That's the commit that introduced st_sensors_read_axis_data() with the 
unconditional get_unaligned_le16() decode.

I'll include that for the v2.

Thanks,
Herman
