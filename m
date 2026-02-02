Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [46.235.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D97388858
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054104; cv=none; b=E9NzkJmcMEcKsJF6FFcy3fRhY9vL1e/JH+RoMWB75ft2sowf0M5M2uK8/6vozEOBH42D95kZUxp+WVzPPW/LesNCsgwvrNveoMN3EwgETN/O639EXII+oRuj1d4pCF6jMbGbRDrLKvFveGws3vjuVhXslL4/oqKJT35xghpk1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054104; c=relaxed/simple;
	bh=EYyPX9MGsISpF8E03omgz8HVx30UYQf6xVyike66PU4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=SkFQdYnLWqovlrfzIkezhKCVlDQUOx14RVvD9+ENLgOajD4QUQwDTJFqPll+BuxdJ9KJjxTpelattSxKbrEg0akFpB4Q2+rJVS9OTsJXgKVV/3vzWQwGDmSxriIajj2hcX6OI5dUkHZkfdLYqqQVh6jhJKKPj9ZbqK4xoRHJM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk; dkim=pass (2048-bit key) header.d=jic23.retrosnub.co.uk header.i=@jic23.retrosnub.co.uk header.b=h9oF8UzW; arc=none smtp.client-ip=46.235.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jic23.retrosnub.co.uk header.i=@jic23.retrosnub.co.uk header.b="h9oF8UzW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=jic23.retrosnub.co.uk; s=mythic-beasts-k1; h=Subject:To:From:Date;
	bh=BMgXL6WpjxP5613OHrQJeofHlviuXcwTneysTnyM8Kc=; b=h9oF8UzWUr217aGv5ZxA5IvKeL
	xFj7RiCO8wlD8Tt/H4f9n/7JEZze75gvoU+WoQHRjApDd1DmHCn1lseRXhvzTxPQqE3MyAVSmZzHX
	uMTP5ZHiaTYurlGS57KDQnXgpY36gxo0RHdtaZQueLiYCeR6i5cIbVLzZKFdVz7BdZWsyhj4gaP0r
	Rg1DOjnv8Ra6L8BK6gjJjf8vO10TTH3042DhArDOLOGkTuMYfGHg0D/QoZE50c/l5kvE5FxqDj+9y
	dqLBCXg1VRDsrG8b4/eSAhBYIUxfQSaSd04nN49iPLkqGXD8EWU5jprUplcHonHot9NnMXqQFYZXw
	eYVjYNDg==;
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jic23@jic23.retrosnub.co.uk>)
	id 1vmxvV-005rD7-0b;
	Mon, 02 Feb 2026 17:41:30 +0000
Date: Mon, 02 Feb 2026 17:41:17 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Greg KH <gregkh@linuxfoundation.org>, Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features and cleanup for 7.0
User-Agent: K-9 Mail for Android
In-Reply-To: <2026020249-neurotic-resolved-aad7@gregkh>
References: <20260201165951.481378da@jic23-huawei> <2026020249-neurotic-resolved-aad7@gregkh>
Message-ID: <035B9BD4-6C5D-466B-995A-D139B23185CD@jic23.retrosnub.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BlackCat-Spam-Score: 0



On February 2, 2026 4:07:32 PM GMT, Greg KH <gregkh@linuxfoundation=2Eorg>=
 wrote:
>On Sun, Feb 01, 2026 at 04:59:51PM +0000, Jonathan Cameron wrote:
>> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027c=
b1e8:
>>=20
>>   Linux 6=2E19-rc1 (2025-12-14 16:05:07 +1200)
>>=20
>> are available in the Git repository at:
>>=20
>>   https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/jic23/iio=2Egit t=
ags/iio-for-7=2E0a
>>=20
>> for you to fetch changes up to 0713b26190addfa3a774b386c8658952ef9f7faf=
:
>>=20
>>   iio: magn: mmc5633: Fix Kconfig for combination of I3C as module and =
driver builtin (2026-02-01 16:53:35 +0000)
>>=20
>> ----------------------------------------------------------------
>> IIO: New device support, features and cleanup for the 6=2E20/7=2E0 cycl=
e=2E
>>=20
>> Slightly messier than normal unfortunately due to some conflicts
>> and build config bugs related to I3C drivers=2E
>>=20
>> One last minute Kconfig fix right at the top after a linux-next report=
=2E
>> I've simplified the Kconfig and made it match other instances in the ke=
rnel
>> so that should be safe enough despite short soak time in front of build=
 bots=2E
>>=20
>> Merge of an immutable branch from I3C to get some stubs that were missi=
ng
>> and caused build issues with dual I2C / I3C drivers=2E This also brough=
t in a
>> drop of some deprecated interfaces so there is also one patch to update=
 a
>> new driver to not use those=2E
>>=20
>> We are having another go at using cleanup=2Eh magic with the IIO mode c=
laim
>> functions after backing out last try at this=2E This time we have wrapp=
ers
>> around the new ACQUIRE() and ACQUIRE_ERR() macros=2E
>> Having been burnt once, we will be taking it a bit more slowly this tim=
e
>> wrt to wide adoption of these! Thanks in particular to Kurt for taking
>> on this core IIO work=2E
>
>I got a merge conflict in drivers/iio/adc/ad9467=2Ec and resolved it this
>way:
>
>diff --cc drivers/iio/adc/ad9467=2Ec
>index 2d8f8da3671d,9cfe66425d4e=2E=2E000000000000
>--- a/drivers/iio/adc/ad9467=2Ec
>+++ b/drivers/iio/adc/ad9467=2Ec
>@@@ -94,8 -103,8 +103,8 @@@
>   */
> =20
>  #define CHIPID_AD9434			0x6A
>- #define AD9434_DEF_OUTPUT_MODE		0x00
>+ #define AD9434_DEF_OUTPUT_MODE		0x01
> -#define AD9434_REG_VREF_MASK		0xC0
> +#define AD9434_REG_VREF_MASK		GENMASK(4, 0)
> =20
>  /*
>   * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC
>
>Hopefully I did it right?

Sorry, I forgot next was carrying the same you have=2E  That looks good to=
 me as it's
just a patch context change issue and you have right result=2E

Thanks

J
>
>If not, can you send a fix-up patch for me?
>
>thanks,
>
>greg k-h
