Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C94400
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776602026; cv=none; b=qrStFnh/JKbN2E78BRFLbiO0FutbTYPkJOHe77MV/c1xdCejwRQSZrwC5EkZd80rEgvF38PELP/2MpWwWqN6S1fYIandZP50S5Ep5bStke1lyXzGKYPU11PjJmt5OO2dlxPQJNjZ3NvX37g16Pzxt7zqp7CRsYP19NRJ7S/E31E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776602026; c=relaxed/simple;
	bh=X/es29bQSN1AfbXkH6z+8r6iwDxPNWDNhuOY3z7r8pE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dY3kh8kiCLhf6Ak/sI0ctcZfceSVr5a4YAaxElq9BJMR9m07R2Zjw2U+J2bqTrgCwc2FH03mirwLTLPJw9y4iwtD9o2caVx5fIwhC38QozDbl9MCPEnFi6OrlTArMLqHibyb1pdZ2pJeMZrkk7qmvnxqPIZACY/uC2/bY06ybkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbNrWtZg; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbNrWtZg"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso1252164b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776602024; x=1777206824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uMoAnB62rBPrxwRnaXdMyvz8FV00xhob3aGKaVN6sMc=;
        b=CbNrWtZgjD1vUvHVSqwOBrLgk3GNo5yuyT+x/98tKrLVKdFZam7zWoQ3lQFb9pMtEn
         NiDQNWhOHmKJmn55R03kn7YzgXc+Pasjxvu1PFuMCoBeevwaOy+h6/CyZtq1c5U21QbJ
         fge4H82oCHPnqdRDQBUKtnSR2FiH/qkpMiLknXIHcrLbLVJKcLoLBq8XYdln9uv1TFQm
         5XNcKvFyeJxFU5SUfaVMFAadizMRiXaH1CaPELpWcOOoYOogSsaqRILER0VuI3SbSWi+
         vYwE7U0i0Rct1qHqXpQpb+chjd5kFxyV/b1URTIQtDkKm+tT2eCrRkj36b/9szpw/Rrw
         FyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776602024; x=1777206824;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMoAnB62rBPrxwRnaXdMyvz8FV00xhob3aGKaVN6sMc=;
        b=b/SB5fUDgReuZxfUMtbRAUjPgQ/sCQanGp6exqScHADDIFYncp+YlN+Wl4/8DMh0aC
         6Bz8c28vgloubqyRQXfSM8ItNDtLytSJG7+XhwwKAWhmm3s8elqJgJRonJdUavIiQaqB
         kdu/L9PzHAHXODrubTYC4NZ3Si8nVFb+FkctZxero4+sqakHSC0rfYi0X2qQUtjfl81R
         KLD9sBlCsbbhKfIHFZAqMXE5w+/BxvT+50aJ6I+CNs6LGQ/tn6Qox/bvCDiWpuLOaO/E
         b60p1QibqZqJk92GBTB3oagyX/gISkHuM0q2c4mrG8nMAwm15ASMLq4Erk6ZnM8woOdO
         d4aw==
X-Forwarded-Encrypted: i=1; AFNElJ85I9HrgIF2S5lDhVxUvqsXz9ebhTYuXoIjl8zhg0yrgjmt+Mh5ygfOJRVlTgzHdWoTOQ+Nfm9ibTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5KQiPgAmX6WF5c8MrUvctFYp5HKKVfWVcfDlQDISWdflob6k9
	A8qJJn3LVPkhP8yKUlNsuQddLLIVPalPPkb5rNxBgIK62r/NE7Fg2NjCtxklVkoe
X-Gm-Gg: AeBDiesAbpnbVHuo6nrGsWgS3jsLWSfwzAfBk79JWIDYAYhMGmPNwDjrpSu7uudfJT6
	U0bC37HqUepkXQdiJkzER4BGpbvShaCI1tGeKlQs7hBegL3PiK5smz1MhpjmQ6oyOJjESfsLJep
	mCkhG0S+okUJQEBWtAitoQktq4fcUpPxgjV3x6LD46MfMuMhlm7OQwdOWkAGGNJ6lHMAkv1KTjE
	OzJykPeUqqxSN9Trk5k94Wjs5nB/EdxHWe/G0bQQyHZSDHOuVTB+PAvfKjAwiYI9EC7oBn+XPVW
	GjaKfXqMsA3JexKkpbfUTi1pGeSYTJe1i9PnnoeY+Tgn5XW6scJkWYNu9WYISfYY4/3mXtMUUJA
	v2ivGMHYBHZ/wxe3YOwt2G6d0T4WZ+j+/e4kaLy/1XIQSExWsTCBqzmCR5ks+oBIqkfGwZjI3u8
	9gUMonLTMOmWa0xNfsSz7huz4s3ggcxc+RwRCDM/rkJh/bLRlZ5VzBRw==
X-Received: by 2002:aa7:8892:0:b0:82f:1f43:7190 with SMTP id d2e1a72fcca58-82f8b32160dmr8536470b3a.3.1776602024166;
        Sun, 19 Apr 2026 05:33:44 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ac16:b3b:3927:d65:a5c:bf50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb38ddsm7161793b3a.34.2026.04.19.05.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 05:33:43 -0700 (PDT)
Date: Sun, 19 Apr 2026 18:03:39 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 tglx@kernel.org, christophe.jaillet@wanadoo.fr, mingo@kernel.org,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_5/7=5D_iio=3A_ssp=5Fsensors=3A_convert?=
 =?US-ASCII?Q?_probe_and_teardown_to_devm-managed_resources?=
User-Agent: Thunderbird for Android
In-Reply-To: <ad9bXYpuSLRaocVd@ashevche-desk.local>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com> <20260415050749.3858046-6-sanjayembedded@gmail.com> <ad9bXYpuSLRaocVd@ashevche-desk.local>
Message-ID: <7A3BFA1E-3B6C-403C-9CB8-DFCD30B03DBF@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15 April 2026 3:03:17=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Wed, Apr 15, 2026 at 10:37:47AM +0530, Sanjay Chitroda wrote:
>
>> Convert SSP driver resource management to use devm-managed helpers
>> and devm actions, tying the lifetime of all resources to the device=2E
>>=20
>> Mutex initialization, IRQ registration, work items, timers, and MFD
>> resource are now managed using devm APIs=2E Cleanup logic previously
>> handled explicitly in probe error paths and the remove callback is
>> replaced with devm_add_action_or_reset(), ensuring correct teardown
>> ordering and consistent behaviour on probe failure and device unbind=2E
>>=20
>> This simplifies the probe path by removing goto-based error handling,
>> eliminates the remove callback entirely=2E
>>=20
>> No functional change intended=2E
>
>=2E=2E=2E
>
>> +	ret =3D devm_add_action_or_reset(&spi->dev,
>> +				       ssp_disable_wdt_timer, data);
>
>It's perfectly a single line of 79 characters (we allow 80 in strict mode=
 and
>100 in relaxed and you seems stick with the former, which is fine)=2E
>

Agree, will cross confirm and rectify in next series=2E

>	ret =3D devm_add_action_or_reset(&spi->dev, ssp_disable_wdt_timer, data)=
;
>
>=2E=2E=2E
>
>> +	ret =3D devm_add_action_or_reset(&spi->dev,
>> +				       ssp_shutdown_action, data);
>
>Ditto=2E
>
