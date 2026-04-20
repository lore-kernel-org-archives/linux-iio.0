Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E410B312825
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 04:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776659340; cv=none; b=LmKM246VJcKibSYWP5D5cESUqumhWubYHkB2TwkAukYVgxu3GwJIP3z8YiHFPuiRcvOl3H0bcwQxKtYvo7g0CJ9RvaAoo981fTKt+KzpARpWADiIeeV2HfEovni2z0iHcrp5xsj3T6w4HXF8pKhEh0tczdtuzXWJF3PBhnfFqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776659340; c=relaxed/simple;
	bh=oqu+kqPmSsJ64x3op4poFhP/ka6AgkUpq56PB06FUZY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pZxj/wlcTTuoVuoZPIafT1Fb8JaE9Em0i3qAtWVUjgZgz51wgLQn51UkVNckCTrQvsPNZmAdhd7DITrddp1qkPYi8axp5WY8UDlUwkGQkQ2HfS90OFb+Qk4trKYMoFPTELCd+Vnmw6KikEEaasR66210rX/2ZmR1B6KKHodS8Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8c95GSG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8c95GSG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so14803505ad.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 21:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776659338; x=1777264138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0BLw8c3lehsvxuLUDkwPuN4uiZnY4mtPCv+yKi1Kr1o=;
        b=q8c95GSG3+ckTaPIMe4PjXKFxJOQ25g3RKI+cfq8aAuYKPwUaMTIkfc+zeR18kjVrA
         EhTA7kDPEbBi71arGRoNB+f1F/9GlAx8eDd4N413Gs7e+MiqI92rqfJjIw/jnMm5DZKn
         dSF9pNvB1D3gH/kB5GcVWx33ZIlDIs5s0QBsox/t94QU3jGgdl19/3y89wmeSmxmh/fI
         DIR/RWH8wLEelrWCabgFKytqidNct9Lb27XUxotOGGCEfoVcBaEXG2OU6X6xDKU6qool
         lZR1cRM9qU4TtfULGn3/2htJ5F9lhrze3ZJumg9h/cI6E0edKcGDYT4U6PrFWYMRqUez
         BM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776659338; x=1777264138;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BLw8c3lehsvxuLUDkwPuN4uiZnY4mtPCv+yKi1Kr1o=;
        b=aBKmemT3YuO0cgMPcDRUx81ohBeotMeePTjG8jbDndJh9B3kXFnCiObN0Smio5JQWb
         G4kvCvjM34wGrePVXQpeOKQWHImuN6OSwuQItB2YFiJMG/I8wxXDOEAGbReQrYpIwdo3
         k6j8wONnW3daxtE9HdKtAzlrSn1Fdg+23hGtgaCFHHnHEEq0hw+XjMcgqAYv+jtVQvUc
         QNzTaSGH9niSloQds4/f083Mf+tdsGfQP5ok8C6+sV968mdV65eC0qLAQhfcETGDvx2S
         HPUipmg4QLUJ0nkedO9o+mJKtkkRVuZkgUSpYhW8SYD7ABDrjll3Pbv5OWkJvL4Rs9Jo
         Xy9g==
X-Forwarded-Encrypted: i=1; AFNElJ9VQR0EIK0mZTDwoDe6E0fczIsCOEIVcNFMYD4G3flKSWKqWR2hM/W8KsqTkCSYHVI9lCs00Atet80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRi8EqTsJfe89HN3A2mhKoQMqlBMIfmvPdF1RYTxv9nu9CHJK
	0kH2t91DDjvpevKpNQ5gzlW//JdpxxI98vIrEwUh2IrVZ27kQ3s6+BXR
X-Gm-Gg: AeBDievUTgZFcdu4bECex7NVt55VbP58P0btp1kSrwaZzrV8n4RFGNRixXmQJbzXH5v
	ZIG2WG+8qsBOZ937P+b93g3gAo20J7Bhlt+20K1OIAFreHGp3PGiUqDerdJkJFpPJ7t7uraz9zE
	0Rh0zBc+RnagBp/nj8agYa0r1a9i3L1rzziTcVeixDauVKx1cD3RU+4mVfTkVHjYLjt2sMAUnvJ
	VOF4HJOk8U3+9VMI1ppgQbLwktzHRB989Vf0kZn/IJfX94l+qMCCr0js6dfPjFOz2AoOsOjyxNf
	jxicLjCzCSKMkoXD7+F1wcF1hB4XiXmJP8LT1Xd0BDF+n7hNgFtoBgLkaoldbah1WuAes4xCI4x
	91HGBauY5tvhsQak5GJuGtnuGn/N30RpW6P5QO7numu1C+dvbBXomT/n30/9aPAtG/ES3w5grwW
	tPjdx7z6Pwc1bmonl60+8/T7SKgEoJGtpTTioPQJKvsCjceQuuJSkNRXUR
X-Received: by 2002:a17:903:2291:b0:2b4:678c:5f27 with SMTP id d9443c01a7336-2b5f9f3c5cbmr131949335ad.34.1776659338313;
        Sun, 19 Apr 2026 21:28:58 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ae51:6985:a95:3211:21d3:390a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cddfsm128552745ad.49.2026.04.19.21.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 21:28:57 -0700 (PDT)
Date: Mon, 20 Apr 2026 09:58:53 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, tglx@kernel.org,
 christophe.jaillet@wanadoo.fr, mingo@kernel.org,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/7] iio: ssp_sensors: cleanup codestyle warning
User-Agent: Thunderbird for Android
In-Reply-To: <20260419182848.7c6182b8@jic23-huawei>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com> <20260415050749.3858046-2-sanjayembedded@gmail.com> <20260419182848.7c6182b8@jic23-huawei>
Message-ID: <2AA53122-CDDB-42C1-9674-C2C83478C1FA@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 19 April 2026 10:58:48=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=
=2Eorg> wrote:
>On Wed, 15 Apr 2026 10:37:43 +0530
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote:
>
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> Reported by checkpatch:
>> FILE: drivers/iio/common/ssp_sensors/ssp_spi=2Ec
>>=20
>> WARNING: Prefer __packed over __attribute__((__packed__))
>> +} __attribute__((__packed__));
>>=20
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> Reviewed-by: Andy Shevchenko <andriy=2Eshevchenko@intel=2Ecom>
>In interests of cutting down on how many patches are in flight
>I'm going to pick up at least the first few patches from your series=2E
>If another version is needed for others don't resend the ones I've
>picked up=2E
>
>Applied this one=2E
>
>thanks,
>

Understood, thanks=2E
This will also reduce overhead to maintain patches which are already good =
and reviewed by=2E

>> ---
>>  drivers/iio/common/ssp_sensors/ssp_spi=2Ec | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi=2Ec b/drivers/iio/c=
ommon/ssp_sensors/ssp_spi=2Ec
>> index 6c81c0385fb5=2E=2E8c1e15d61db7 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp_spi=2Ec
>> +++ b/drivers/iio/common/ssp_sensors/ssp_spi=2Ec
>> @@ -29,7 +29,7 @@ struct ssp_msg_header {
>>  	__le16 length;
>>  	__le16 options;
>>  	__le32 data;
>> -} __attribute__((__packed__));
>> +} __packed;
>> =20
>>  struct ssp_msg {
>>  	u16 length;
>
