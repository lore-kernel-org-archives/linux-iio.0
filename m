Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759682FC876
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461184; cv=none; b=U1mFlqkfoVp9slxP2OjT5ExwjCLosT/eK1zG4bUs+7eo1SpPuOEuDh4vchM5N6sxqocCaVT/sNua54/XfQp4sPUaPL6ZX1a390kp7JY61hngPR4S3kO1kvCWN9DB4et1mrr/VkivBtN23xOXJSjKsZE2djktS8r0HNyztcMJHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461184; c=relaxed/simple;
	bh=GkzUhdnNmQsXCZJCgGYEHBXYyG45OukfnNSxt4u7xJA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=cgzVSs7NCiPWOzjrOespdHfO7K1wonEkLY1HHsaUm++zWDlFjKzIe0PXArxHaBPMjrfjSOJIk4hk5nBmTAxk7j0UczVZQHYThtUbouJivtCjn8j6/bg1Vyv0hxvyjg4pj0D9p2nJGQ777kaQhhR4/cUvaRiDZHYHBve1ncIcaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMhHEYzA; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMhHEYzA"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-824af9535c8so50772927b3.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786461182; x=1787065982; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EwSYPQauRfRG53p3PkwAK6rBy9dBSDSqpFZZZt55ve0=;
        b=PMhHEYzA5EF8OeIIJZ+doyB0w/WEil7YICyuqBAYAyT741tMVB9SBL2NajRUqVExE0
         WhOEtfhR7loY1EvHElUoqw3EHPbJMevRAqdSr9FdCIx7a5/yMxJ4KUeOVKBGWAr4mFCS
         oi0acG2ahUgOK/q6WFrXLLbcOCdpAO++AQ+HouAoPOC9DMuw9SlzY3UA3gz7/dqQou3k
         eysVFVJTBXVHg0b8eJJ4d+k5uknUJ0C9zqvoRRfRFI7DtZBtFdTAXN0D2VC7+V32faZx
         nmqPZfjkP6SBjDgvqkIvNB8viPxwWI5Yvy5GzoPJbzZDsT+ZbkzFwbwZtEDzuD8U1hBU
         k4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786461182; x=1787065982;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EwSYPQauRfRG53p3PkwAK6rBy9dBSDSqpFZZZt55ve0=;
        b=KaU1R1VWASPvQXhFqhL8DvTcxaDhH3VnmLSwMcY0N0lkowcalhztaNCQSf2pq5k3Wj
         wYGZfzOHp4NuxI5xOA5kXDmkMl6T4iDo0okZiw65hRThjcVmt2Ln5kwqY1U1E67VyuTu
         fu0e5p3+bZ7G3xQXR/VjNGl+VY/22Z3akHChr+M8Qqg33pycMgiPnXujQsgeV+PaLK+o
         darRLP7t086lXY74e/tf6T7YIeZQJSOel0nfjGVlzC0e4GiHiQGD7ylsxHDB6s77qwnc
         0NOrbkGi4/CkdEEGtsVot8AJRcemHev4KqUNgR+ZkYrI1uWknb05L2mn7ZN2rSvbnOCT
         +PQA==
X-Forwarded-Encrypted: i=1; AHgh+RrWEDjbb+mJPCtYAObz6UKFgu4WAG4dltCCudfIqhgwvP0nI2D0SuFKUW6oL5cYGnUPv5Wrx/tiazM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+HrRVoeVsv6qbrYxo9iusamtPLng1B2j4z7UbdrreRLDRicc
	C4k5N67KEf+/Q/L3BI4q8X8P0CJIczcZiiOxdxjZmSBalXb/1DHyVAY=
X-Gm-Gg: AR+sD11Z1LuYD2jrHAFOM2jfFfFNQihY1451Frwz2DuRX7DY7Mi17eO+Gtnhs+Oor1N
	/r5v9KE3D8I/XskWXzHrVf3VeeTlxZPCkhWxwDsgCoP9bgN/pntec/NIzO+gc+aFKKlVkLuo3xU
	lyl1GKH66lc8TRVbATbfQKaDVg7mJnaCAUa+5mr4zY0OwcSMB4qcsLs4O+pPTEWPywc/ZQP5P2S
	3xHS7Y2cvg1iefMzURIotNtwuA6VJrUl7rkpdu0ckDgs9PETYfrwhnIhLtDDLviWxkCbejr2Fhl
	YMZytu1PRKb/o32fvJI2DMbecJXssOOkbhFVXKYNL8AeMBu8zkUZ8ijVfaO3KSbYgJD+1Nur7se
	Bm8pYlFFcgN29ZGXCW8kvKKFUrYs8XjeNGd2A44K0zvKW+i+NHGRxx8IXPlXLOWd6nVU+YVC3mL
	WM5bmFVLEq7XCrFDKVl2nknQgwA8TjVGYzNdafmBNzxjzYCAMDwxrcMQ6Lxxgg4emqCGltNmt2M
	/ABlG9MjKcoHHYGK2YCAt0l
X-Received: by 2002:a05:690c:7308:b0:80e:38c5:bc17 with SMTP id 00721157ae682-82f289dd624mr31186957b3.7.1786461182335;
        Tue, 11 Aug 2026 08:13:02 -0700 (PDT)
Received: from localhost ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82ebcee0647sm11118477b3.2.2026.08.11.08.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 08:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 12:12:57 -0300
Message-Id: <DKM7MV8J10HS.2OIM1TDHB9VHQ@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Marcelo Schmitt"
 <marcelo.schmitt1@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Andy Shevchenko"
 <andy@kernel.org>, "Brigham Campbell" <me@brighamcampbell.com>, "David
 Lechner" <dlechner@baylibre.com>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Shuah Khan"
 <skhan@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH v2] iio: humidity: am2315: add am2320 to i2c_device_id
 table
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
X-Mailer: aerc 0.20.0
References: <20260810183337.451812-1-nico.antinori.7@gmail.com>
 <anqKwJOkl_cxzCT6@debian-BULLSEYE-live-builder-AMD64>
 <anrRkty6ugdJUGmE@ashevche-desk.local>
In-Reply-To: <anrRkty6ugdJUGmE@ashevche-desk.local>

On Mon Aug 10, 2026 at 4:28 PM -03, David Lechner wrote:
> On 8/10/26 1:32 PM, Nicol=C3=A1s Antinori wrote:
>> The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
>> communication protocol and measurement conversions.
>>
>> Add the "am2320" entry to the i2c_device_id table.
>
> Interesting. No devicetree bindings for this one? What kind of
> system is it on?
>

I am testing this on a Raspberry Pi 3b mounted on a protoboard.

On Tue Aug 11, 2026 at 4:38 AM -03, Andy Shevchenko wrote:
> On Mon, Aug 10, 2026 at 11:36:48PM -0300, Marcelo Schmitt wrote:
>> On 08/10, Nicol=C3=A1s Antinori wrote:
>
> ...
>
>> David's comment about the IIO device name sounds appropriate.
>> The am2315 driver might use a chip_info struct to hold the name of each =
specific design.
>> There are many drivers in IIO that already have such things.
>> drivers/iio/accel/adxl372_i2c.c is one example.
>>=20
>> An alternative might be to use the device id.
>>=20
>> 	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
>> 	...
>>=20
>> 	indio_dev->name =3D id->name;
>>=20
>> Not sure if the second option works well for both i2c and dt (probably n=
ot), so
>> I'd suggest the chip_info approach if you intend to add a device tree id=
 table.
>
> Indeed, we suggest chip_info for the more robust approach when name is pr=
ovided
> via string literals independently on the ID tables (as there maybe same I=
D in
> the tables for the slightly different devices that may be autodetected ru=
ntime,
> or different IDs for the same or fully compatible component; the chip_inf=
o works
> for the latter case).

Thank you all for the suggestions. I am going to try to implement=20
chip_info struct.

I'll wait a little bit to send the v3 in case there are some more
comments on this version.

Regards,
Nicol=C3=A1s=20
