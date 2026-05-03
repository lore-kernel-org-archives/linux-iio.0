Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2681B6CE9
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777817628; cv=none; b=fMzQ7kQmSBE3C480TDZhy5sz2QwPj4tIuwTTiIZx0myuB7SvtzzNkao8bM1iZJiWoFul+bw6HsdNEQAa1kvLTJ+28eTm1c/xOVLPjKC9min6Yk3QhLcSK2CjLr45vd0eDaP2OJqg1FDKSsAp06Fi3g+3qLMLVVewOnzrO7QFhls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777817628; c=relaxed/simple;
	bh=7PwsFze4QsE2ISRXJzyp9kadQW3inW+rFGBTQ2/mmXs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KNKArG2xld7G24G5Jh/vHGYsHowSF6dczS+sFolvpyzvbCCUdrcqe2P3/f2jdCUzZ/WGFJEr8tQirsjKj58LGSg63qy5Kti4PgVXbm1DyYaGpbD+/pmog2cV4lghhfMQ1cwy/0llsokMC7u0rRF56hBETkKWwxujCEWqh4Gd7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcrefzR6; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcrefzR6"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso1255692a12.1
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777817627; x=1778422427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GKq6VMoc6vph5zTdVbGb9Ju5cGAZjXPsFWIZlGPYhew=;
        b=LcrefzR6uAwJ27J9EmKkyvYD0ZlLprxN4mSl/OFlEvwy3GAdz1FCXHuJLf3TNKb3ma
         b3EHTZ3sJ++qJ1SzmBOQlQt5hizfdM9wgFb8pxvMbuLoqSxxYkJHPgwqtmpG2aPwM/4h
         mV6AMbPdBLLS5r+2Vdku4fEKRLz03uWN0Jg4ROHkYw5ZlNXYm1SSFBlRLpQa3n670zUs
         UIvURCRFzl2F3f3uLP0YaysgFH/JJ07V4XZrkJAor9gKRdzntdsqSaUf2NnSJE0fdUyp
         zB6sW/LeSnMlzoEDENJblclyCRSlCgfFucxm/fP8uGTYtTtzGKYcILYzUW8IPEYrTgEd
         55Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777817627; x=1778422427;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKq6VMoc6vph5zTdVbGb9Ju5cGAZjXPsFWIZlGPYhew=;
        b=DB2Nd9ylrZS2UslKCEJiZgMxDkI0tJoaNh4+czvngmJuLMXzIpAUCna5daiKVIrE9g
         jGysLSBVm6FmWcCjvDwvlM63uUEubPrkf+67crlwiL4GPFkm7ESoChPzuTEgzIabMLQP
         PAE/5erW3kHT0cKwsL98UHGAPPqxT+0ZD+U8lRQ6G93brI5T5H4Il0himIFRU56xSnCV
         lkJwh+0vuQ/+hoftR5uHzCkQzmHq1ufYQtq4S/I3GN2L+yNaCtm7efjRAQT+MxAjxF+6
         tQF32oi+jukf1acpjJb9PZOVstHRJ6184PU+zCgXm9QKWc7f07srlBLcA1pMB+Jk4MmE
         Eu5w==
X-Forwarded-Encrypted: i=1; AFNElJ+1GFdnJTRn+nP4DBFAnCkUua5a5bScVy2Nf8YUQt71G18KBqr1ck2BedjhXU36VcUlpx6WrEmK2/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBYN7TO7LoA13r0SVX3h4V1NAhO/kAofqUWLgKBHE7g7FsvxKA
	f66EsJL0IQWmQZFh5sZmIz+bQBJwTdNra1Jjr2KnT1ycGUUH0cK19o7/
X-Gm-Gg: AeBDiet7OvRseipuyisyzEehR1I0iyCwXNbAhHZLaTeBHXvmYWyDr76gr1syiDCwV+0
	vGqbMP7CeC7XuRjYJ67C12B0XLer33g8oYmylp/9mja1U/CaL5+fhE6go5wa8ws1iTRP2xUzJOn
	AG7Iw6c7M6/BdrF8tIsmrE4psCNvbdAsfdeLzULmWEQS4oWUb8EHOuXWFk3xHuyhV4m/IyzJkoF
	E1w+9b/zrecXS0Atihf0ZBdwxVOmi4QqIWGVGbQBl75EElV9QRaibndr8f3fQ6x4dXHOvO3H7Ba
	FeABrOpE3+t1dQ6JmN8kzcOoXsQVY7dlJz10MMzSW7jlt+VgfDQ3xXnKw3so6MS/iNPJPMYWEvy
	y7BoP6xcotQ805I0dcC9LhKPByvqvnlUgWkkGEOmBMPlDGukzRBusB/ycGNaT19yMyXagQYHftE
	YW8U0XCzIQ8wWPwcmSKTrcQzRk6qxGTwcUVNMUPn/fanaNnQNSw+haP3w=
X-Received: by 2002:a17:902:ebcd:b0:2b4:5d87:a1fd with SMTP id d9443c01a7336-2b9f25f7302mr60566365ad.27.1777817626780;
        Sun, 03 May 2026 07:13:46 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:c032:ba9d:4953:28:24e7:1e48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae68476sm74759715ad.80.2026.05.03.07.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2026 07:13:46 -0700 (PDT)
Date: Sun, 03 May 2026 18:36:04 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 mingo@kernel.org, christophe.jaillet@wanadoo.fr,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 kyungmin.park@samsung.com, k.wrona@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_6/9=5D_iio=3A_ssp=5Fsensors=3A_Dr?=
 =?US-ASCII?Q?op_duplicated_wdt_timer_and_work_cleanup?=
User-Agent: Thunderbird for Android
In-Reply-To: <ae8bhC34KE4-Kguw@ashevche-desk.local>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com> <20260426091710.3722035-7-sanjayembedded@gmail.com> <ae8bhC34KE4-Kguw@ashevche-desk.local>
Message-ID: <A42DE09B-57B4-4A08-BA2A-4521EC8FF886@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 27 April 2026 1:47:08=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Sun, Apr 26, 2026 at 02:47:07PM +0530, Sanjay Chitroda wrote:
>
>> The SSP remove path cleans up the watchdog timer and associated work
>> both via ssp_disable_wdt_timer() and through explicit timer and work
>> teardown=2E
>>=20
>> ssp_disable_wdt_timer() already performs a synchronous teardown of the
>> watchdog timer and watchdog work, guaranteeing that no timer callbacks
>> or watchdog work can be running or requeued once it returns=2E
>>=20
>> In addition, the remove path disables interrupts and frees IRQ handler
>> using ssp_disable_mcu() and free_irq()=2E The refresh work is also
>> cancelled, preventing wdt_timer being re-armed before teardown=2E This
>> ensures that no new refresh or watchdog activity can be triggered from
>> the IRQ thread and refresh workqueue=2E
>>=20

Calling ssp_disable_wdt_timer() after IRQ teardown is safe, as the watchdo=
g disable helper does not depend on interrupt delivery and ensures all watc=
hdog activity is fully synchronized before returning=2E

>> As a result, the additional timer and work cancellation is redundant
>> and does not provide additional ordering or race protection=2E Remove t=
he
>> duplicated cleanup and rely on the centralized watchdog disable helper=
=2E
>
>Nice=2E=2E=2E
>
>=2E=2E=2E
>
>>  	ssp_disable_mcu(data);
>> -	ssp_disable_wdt_timer(data);
>> -
>
>=2E=2E=2Ebut this is left unexplained=2E The commit message as I read it =
relies on the
>fact of this call to be present here and not being moved below=2E
>
>>  	ssp_clean_pending_list(data);
>> =20
>>  	free_irq(data->spi->irq, data);
>>  	cancel_delayed_work_sync(&data->work_refresh);
>> =20
>> -	timer_delete_sync(&data->wdt_timer);
>> -	cancel_work_sync(&data->work_wdt);
>> +	ssp_disable_wdt_timer(data);
>
>Now it's still possible that watchdog will fire and we might have a callb=
ack
>run while the IRQs are already being disabled=2E Which means that if WDT =
callback
>needs the HW to be able to generate IRQs, it won't happen=2E
>

Thank you for the review=2E

I will add a section in commit message as above to justify wdt cleanup shi=
fted to specific position=2E

>Note, that IRQ can be still fired in between ssp_disable_mcu() and free_i=
rq()=2E
>Only the latter call makes sure you want see any IRQs from HW=2E
>
>>  	mutex_destroy(&data->comm_lock);
>>  	mutex_destroy(&data->pending_lock);
>
