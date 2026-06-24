Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7767123AE62
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 01:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782265410; cv=none; b=PVNeiCKEMylT/84AKb1d7A7nZ2zen0c3HoOh+Aa9o9BW3Dyk1ywOEaaFM4Qb9NFqv3kOZUSLAN37xPTcEAqms4cGO8M+kHAf57f8RlN9ZLYN9qM0dBKxKPXh3I+FzCwq2LZcsQ1tFqqr5bQajMcP/lt4GKuFfQPFGe/P93SpZ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782265410; c=relaxed/simple;
	bh=qT3p9ECvEyAqV9oMGH9vEb2raKDM+oIo9iU4SgXJKfo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NDxnT6wJhLdY81dY8C5P2KB+kS4h0iejPslCckGtRlJCRD6doSaRRHbUpbF/bm9B1RUL4KDmDKCk5zDUFtrJ0aPdjWLgwSwbuDKeZ3Lj0K4xPc9rCdZx3ilNCMdfF1s3BrnDhWCCwdfOJV/ncIvkrhs5zZn1B+ISgHa2gMWDOtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfbN52/h; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfbN52/h"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8453bcf7276so376782b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 18:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782265409; x=1782870209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+v7MiQ0V4iVBk/UhrVDYkv4lyovSCAad6aZiI8aKxu0=;
        b=YfbN52/htX9SdBnU2XhKH3aNxyjyY5185gac1VA2MUpLqH7GdbgNVlH08PITpmHz3r
         yaj+BiNvUz46MAaVNTVo2NZNeoUyYh1rKBwHTX0cW9GWAx1qM2PhaVBj9Io8rwzpttFp
         5e99n8SquI5ba8jt7vChByth0mjtEu1mzyKdCr2CJjkbWnqh6wa/8rxEpJYpKzG55V2u
         E7htWlwAH6tzYqiQOapEJWIf5A7T6FhkqHns1bc8T535zzc1IvlkyCPnbbTCOk6uBwx0
         mGc+2ZiGTu5OZb6w8WuOhid71IKCUWg44LChDd2gXPtTYvWw17dNhCwmrn94q66DdvN5
         CbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782265409; x=1782870209;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+v7MiQ0V4iVBk/UhrVDYkv4lyovSCAad6aZiI8aKxu0=;
        b=DeX//ILOMylZubzJpzzgGfmCucuo5l0ru3/1OXlU7P4A3AvY42mDvgKkNczShV9aB3
         48TK2qNJAI2pmEQLbMLtUAqLdQo5jLOb415GHGyYSmoJVCGN1F3qcSwqdNe9iUCXBvQG
         fkKMjO+SGnZp30spvmNrUMr1sHXpDqGHX266OtTsGN3BDoKfJuEzv0cKkEwUDSqqlJVw
         YISIEflKd+Z/Cwdyo+JMgnSWG5RFBGKjaETs9d11+Tlp8xM51DkRKAC6ZDGAKfZ6jlnc
         ykGMsEI0ZWRi28Q5R/PC0n29e364TgkqKIG4yLMQV4aZtvBr1BjY0c7YndPQxM0cKLnA
         QuNg==
X-Forwarded-Encrypted: i=1; AFNElJ9sGC6HK0xGJszVqdufboh/kp8WPW/Hi8DqX4ZyoRxz4Vp/s29xlq2aYBfqwyoYTqThBcofbyDz5+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpBOgHZgqz+cTWmAM6FPTfHHfFH/ukUQiJnYLrpyENElPPfGAe
	LGdWBl4yBH0TSfrzD/u5NQ32BExETKQNTEsD2rXoDWeAe7QEIZ2auzpQ
X-Gm-Gg: AfdE7cljMzaaUUI4C9Rk3hPXAHGscrIQx3ExjYGuKuMjUTAl12qn3PwRNT06LaZyHNU
	xlpoUGi02YMuqGIDs1659czzVo+4P3ClryapKah6YZR6P//7nCrFhVRSQlICb1uZ7Un/RsSHuUD
	KE/9rVwjgZnJDuwe1MIqLq6Z9POd8X165GPr8T8RUUzOe+wN5367euVe44xplXSXBeDI8+iyT/k
	xr3lxnIlH29ftNOkss5yJo9MPG0tT9tdEJ2CN+Oy3qJr1TBhTCEfIM4WbKCN8cHr+Lnds4FBFbn
	lPz0GqYN/R/V6yUeQidUNblZoqBWfAfxbryYi1noQZTjefDkgc3hVNYJIGxh/n89YHsuQwCfsbl
	Fofhse3dvcsc7Vob+J+kkuWIZrqZ1OSStCJKsOUen0rQZ/NYIitA1PFPDVVUiClEGnGNMiXIGXG
	8fYyhGYzpCBfGnvEW6RS6sN8dtsHMWfIey2SzP
X-Received: by 2002:a05:6a00:bc8a:b0:842:5bf3:c53c with SMTP id d2e1a72fcca58-845a2a951famr1883030b3a.2.1782265408570;
        Tue, 23 Jun 2026 18:43:28 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:8899:9e33:6ca3:2b46:9c45:afb1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3feb7a8sm476027b3a.19.2026.06.23.18.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 18:43:28 -0700 (PDT)
Date: Wed, 24 Jun 2026 07:13:12 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Archana Patni <archana.patni@linux.intel.com>,
 Song Hongyan <hongyan.song@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/8=5D_HID=3A_iio=3A_Avoid_race_b?=
 =?US-ASCII?Q?etween_callback_setup_and_device_exposure?=
User-Agent: Thunderbird for Android
In-Reply-To: <ajpgQ8vCHacv_klG@ashevche-desk.local>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com> <ajpgQ8vCHacv_klG@ashevche-desk.local>
Message-ID: <7288DEE7-91CD-4823-959B-229AEF1CAD97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 23 June 2026 4:00:27=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevchen=
ko@intel=2Ecom> wrote:
>On Mon, Jun 22, 2026 at 10:59:56AM +0530, Sanjay Chitroda wrote:
>>=20
>> This series avoid a race condition in HID IIO drivers related to the
>> ordering between callback registration and device exposure=2E
>>=20
>> Currently, several HID IIO drivers register the IIO device (making it
>> visible to userspace and other kernel consumers) before all required
>> callbacks and resources are fully initialized, or rely on devm-based
>> cleanup in a way that does not guarantee correct teardown ordering=2E
>> This creates a window where the device can be accessed while it is
>
>There is a difference between "this creates" and "this might create"=2E
>I believe Srinivas and others were asking for the proof=2E So, what path
>in the code makes this happen or possible to happen?
>
iio_device_register() exposes the IIO device to user space, while sensor_h=
ub_register_callback() registers callbacks for buffered IIO(streaming mode)=
=2E

This might create window where from userspace buffer mode is enabled and c=
allbacks are not registered which would result into loss of samples until c=
allback registration completes, although no explicit failure=2E In teardown=
 path which can resulting in stale/no data=2E

This was discussed in the v1 thread and v2 was posted based on discussion =
and agreement:
 https://lore=2Ekernel=2Eorg/all/3FED088A-651B-4E8B-840B-1B92CB4DF6F4@gmai=
l=2Ecom/


>> not fully initialized or is being torn down, potentially leading to
>> sample drop or stale/no data=2E
>>=20
>> To handle this, the series ensures that:
>>   - All required callbacks and resources are set up before the device
>>     is registered with the IIO core
>>   - Resource cleanup is performed explicitly where ordering matters
>>=20
>> PS: This is prepratory series to convert all HID IIO driver to devm=2E
>>=20
>> Testing:
>>   - Compiled with W=3D1 for each patch in series
>>=20
>> ---
>> Changes in v2:
>> - Drop fixes tag and rectify commit message with reference to that
>
>You also dropped my tag=2E Why?
>
Thank you for the review and tag on v1=2E

While code changes are intact in v2, the rational and commit message were =
updated substantially=2E Since commit message is as important as change whi=
ch will be permanent in history for future reference, I chose to drop the t=
ag to request a fresh review=2E

I shall highlight the same in change log=2E I'll make sure to note in futu=
re revision=2E

Thanks, Sanjay

>> - Link to v1: https://patch=2Emsgid=2Elink/20260606-5-june-hid-iio-race=
-fixes-v1-0-27a848c5758f@gmail=2Ecom
>
