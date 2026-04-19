Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912042D8796
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776619200; cv=none; b=ZwaFab6cFHqVJhNGEEHvRBiAYEb3rNOpedcvi4FIp9k7wbv9JxnFEUUEzsmar4w8ZT6PZI/fol8GuUqsso9U+LPOsUrnPa3m1tVhVJvjkm7v/JA9cyvQXV73xSRMfoEGk5dmTIiUTOJEV5K9MvA3QzEUyUAvnwjuLnCiNCf2tbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776619200; c=relaxed/simple;
	bh=e4j+BhEu4raFMdJ0HWT0eK9mgj1i0Q1736UU+Anhq9E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Y1qopGHM4ujjajbyC/4XcW5RmSKSFoDrTT3gjXIkuUBPNLmL5URMZbjlsXGlTGOjdnFgTkUDNxtEBEwdIKXy2VKuyG1jSrOKS3Jhf9kkW9KbjHCSo5TaTM6ITBGNaQMXqjN6u7lsuD0ed3bci8gdMs7YkTkfKpPdt9V7SxL7cYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCBeiRfV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCBeiRfV"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad9f316d68so9211725ad.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 10:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776619199; x=1777223999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nCSRMM43uDYePvUzqbDgkNVVQiMesYoO97geG8VwOTU=;
        b=GCBeiRfVqWPHV+FxK5DfmlQ4kn7Nvmm6qRPvoBgeQGjAVqfokOT6GtA2rpKl5H1gWq
         9jjN1uUelgukJAu/D6hDgAO8qqk6E71d3BOWdBqa4HBVDpATgBIgkUQUKvKdnllPCJf0
         ild8JaEd+klGqY7MFBx1sxsxy8ivXII6xr7SV49OIZfJHzLPtp/cKkuASTzA78oGORXD
         RZrZywIziizSy3t9ItPE5wfvJPB9BvMFELZbiFGZMRyddiQY7ctNHlLmDc2ay3+s5Duv
         A18erPK4Pr7CVxin2F7Ql1aPGi4ItRIuKXgLlwJQrnMb4jCpqVII4K7R0xc/Z0c7SXaJ
         JYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776619199; x=1777223999;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCSRMM43uDYePvUzqbDgkNVVQiMesYoO97geG8VwOTU=;
        b=KCMW/Jmah2Sox+gtAdVg1ZoRu4VUZEU/DcMMXRMVq7SC12LkQUnvFPLqEq3sJM3UiL
         dsY8qo5LyON2YG/BO4+x3eSc6CEWO8VMXnz17c1sdL+gjuQnugKCQIkhgDi38CiKP2QS
         igMk36ufX0M55dZVS+fLpBtgiuvAqZ9EyhdxNeecqkE+fwemoHds9l/ngPZuXWemOt/0
         qtJsWFQXhdjRGc1VvkEljPrAwsAusOzateSWGfQJRB2Yy9/IU4b/ZDdIhfo1gbIxI1Hg
         zJUk4DgbPSk9VseDjEaW7vKwB7UpejomW/EuZlp30mIbfT99/ngAXGYpOI+UX6c1EIDF
         MyLw==
X-Forwarded-Encrypted: i=1; AFNElJ/+qPcKrtYUdXCH6mbp98aWZ0z4hiLTBlGFdkn3BM+H1shGZlRkl9qjNpubndReg4JCijazQxrqf1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jkfmlxpsONFp2e0dcE8Kur7HpJy5T+Z3scoezxiYiu/XFYYU
	kl2VZjrcbXw2Dbic/+VWg+RTWUzCRZcliI+e0btHXuRAUo0kaNW6F7l4
X-Gm-Gg: AeBDiettku6VQy8GoKiq2j/Rv/NGS8+7zjrWKGAIn1DQ0Oh1M9EnUnKNd1BhlxpybZN
	b9/yLyzMvfcBrXPl8b8rEqJVABDB6Vnri3jf4pAcp0xrFaOj3keSvUlIPFTDZge6d/6iNaOYQsY
	2n0BC8ezKp5HoQZ6cs2lZ/42Hjz0rKpZBQ8HPnNi2W2oeMCNy+ZP6SK76kyPju9Y13jD869V/Vl
	KBvWMuf+C9vdY0go1LjqPHWXfxztyzN+nFKRa6lZOD1SrCieRAAsZ1PxklU6x4QDf7TX8WnOkM8
	5mOnFSZPC3/10Hmi46gjKrKr0B8Xb67M0eZEek+db6ygD21rH/Q5bj/cFCUXbrpOZ5CCMjg+OIZ
	4nd6eHTSOKnBXRyZR0psChbZEdZW7ITml2KT3Uuj3VMUwedF6Di/VmF7BXX6rTbe5qVqldumv5A
	QgOJ8EVUVwnJ681Lu3OTy2KVleIiAmkcPn2bVE2j80unW1
X-Received: by 2002:a17:902:f550:b0:2b2:4611:5dca with SMTP id d9443c01a7336-2b5f9f1c1edmr109550165ad.24.1776619198879;
        Sun, 19 Apr 2026 10:19:58 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:5760:5b30::e36:fcc4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff390sm77101295ad.9.2026.04.19.10.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 10:19:58 -0700 (PDT)
Date: Sun, 19 Apr 2026 22:49:53 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 puranjay@kernel.org, cosmin.tanislav@analog.com, marcelo.schmitt@analog.com,
 antoniu.miclaus@analog.com, ramona.gradinariu@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_iio=3A_accel=3A_small_cle?=
 =?US-ASCII?Q?anups_and_error-handling_improvements?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260419173408.0d17995a@jic23-huawei>
References: <20260417124924.353189-1-sanjayembedded@gmail.com> <20260419173408.0d17995a@jic23-huawei>
Message-ID: <C4D894F3-CB25-4641-AD48-291E3FDE35DD@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 19 April 2026 10:04:08=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=
=2Eorg> wrote:
>On Fri, 17 Apr 2026 18:19:16 +0530
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote:
>
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> Hi all,
>>=20
>> This series contains a few small cleanups and robustness improvements t=
o
>> adxl313, adxl380, adxl355, adxl367 and adxl372 IIO accelerometer driver=
s=2E
>
>0/2  in patch title? It's fine for that bit to change from version to ver=
sion=2E
>
>Anyhow, I tweaked as Andy suggested whilst applying and picked up the lot=
=2E
>
>Note however, that the advantage of devm_mutex_init() is minor at best,
>which is why we didn't bother with mutex_destroy() most of the time
>before this convenient way of calling it existed=2E  Combined with
>dev_err_probe() being nice but minor cleanup, I'd generally reserved thes=
e
>sorts of changes for when someone is otherwise working on a driver or
>doing a more thorough modernisation=2E
>
>I don't mind people doing this sort of thing for one of their first
>few patches, so what you have here is fine, but it's not suitable materia=
l
>for a mass cleanup of the whole subsystem!
>
>Thanks,
>
>Jonathan

Hi Jonathan,

Thank you for your input, assistance and considering the changes=2E

I understand and agree, will take care this part=2E
>
>>=20
>> The changes modernize mutex handling using devm-managed helpers=2E
>> In addition, error handling during probe is cleaned up by switching to
>> dev_err_probe() to better handle deferred probing=2E
>>=20
>> Changes in v2:
>> - Drop guard() changes as it's already available in iio/testing=2E
>> - Rebase changes on top of iio/testing with guidance from Andy=2E
>> - Added new change for additional iio accel drivers=2E
>>=20
>> No functional changes are intended=2E
>>=20
>> Testing:
>>   - Compiled with W=3D1
>>   - Build-tested on QEMU x86_64
>>=20
>> Thanks,
>> Sanjay Chitroda
>>=20
>> Sanjay Chitroda (8):
>>   iio: accel: adxl313_core: Use devm-managed mutex initialization
>>   iio: accel: adxl313: Use dev_err_probe
>>   iio: accel: adxl380: Use devm-managed mutex initialization
>>   iio: accel: adxl355_core: Use devm-managed mutex initialization
>>   iio: accel: adxl355: Use dev_err_probe
>>   iio: accel: adxl367: Use devm-managed mutex initialization
>>   iio: accel: adxl372: Use devm-managed mutex initialization
>>   iio: accel: adxl372: Use dev_err_probe
>>=20
>>  drivers/iio/accel/adxl313_core=2Ec | 10 +++++-----
>>  drivers/iio/accel/adxl313_i2c=2Ec  | 10 ++++------
>>  drivers/iio/accel/adxl313_spi=2Ec  | 10 ++++------
>>  drivers/iio/accel/adxl355_core=2Ec | 28 +++++++++++-----------------
>>  drivers/iio/accel/adxl355_i2c=2Ec  | 11 ++++-------
>>  drivers/iio/accel/adxl355_spi=2Ec  | 11 ++++-------
>>  drivers/iio/accel/adxl367=2Ec      |  4 +++-
>>  drivers/iio/accel/adxl372=2Ec      | 10 +++++-----
>>  drivers/iio/accel/adxl380=2Ec      |  4 +++-
>>  9 files changed, 43 insertions(+), 55 deletions(-)
>>=20
>>=20
>> base-commit: 0ccdcdc698b7ba52f2c9bc09bfdf9f020ca0e6e6
>
