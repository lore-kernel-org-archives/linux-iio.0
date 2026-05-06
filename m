Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B836405E
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059647; cv=pass; b=aH7rHkpzPOLdB817obHfs9Ol3ir6fOtWNFqfd3DIfliD7rd0oPwYjSV2NB8DV7ycIF8260q29qUcvpZRNDDJtO0DRpN5kfqXsEHvN4NmJ32VhlHjFNEUDGq1rurmFWzz2l1k8zQBqBA/JIoVnjn/E+tenVA+/YzS0f+eD5YXQgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059647; c=relaxed/simple;
	bh=RHszw5uiA6QjW4kCum13308UOMUH/88DPYbIw8SWA08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfM3+lyAEy0UziU8WJJNQj4t3tEw6GmhMlIUzWqxTcBtdt0pZc+U2reepAEi84Rth1B36kd+ma8khOiOQjhV1WJrWIXs9PoOmInc9hR8TzSc1hQsoBQ/HPJ1IWFqXVZfQABgiTscuI9H6QxkZU8C8Q4GVChklihT0Wr1zMd9ka4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNMNkNKF; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNMNkNKF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44c350a5b87so2072312f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 02:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778059645; cv=none;
        d=google.com; s=arc-20240605;
        b=MLxxSI2GEfwVPAVxwTFWLiZZCBE6dQo+sofT7iQPUDUhduD/tZRNdZpPuYpWmxA7Q8
         xq/j8RDe0yHitO04YVdxN+jYUVR69N3DbgRXfwNc7PwhV7v+Qyo4tnAQZV4WJl66mnnp
         aqvpcRg7Re7XzHkR86tPE//RhdL+rTJGNaPFO2+zvEjoDKZwjMJt7QDvLEQ9s9Qhqj9h
         yyHI4lNQoXh71Jj9CkhjymKFWuZpU1MENp90FETMJ5ezNdKfD8EUzNmDdGhuSKq6JLGX
         ieX4Yd1Rdp+lT1ryPz/xqTRxvi4AgetW0Ffc7gIChsWrHoSMid6L0nRQoF9w5IcUmGAg
         DdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1oLv2HL4a7Q93QxaBiH4+66dnHg0chum6/sNuCd+zNk=;
        fh=P6ps8uYcQoSMMfW1PTAEWJwJJl6l1SMe5VScCwx0t5c=;
        b=B0PpFkmn13yyziQhkXzFy/AIW2Qn93tEzq34tjhFn9lxcCaZg7yGPxWSf0F/wP5g65
         jo2MMKrPdeh8pIpaNrUlnte/1jEwpqFWlGbP8FC5xrzBurDIPWhEFqL/rGNV79vMl0DN
         FNqfLRXNHt++ShADwg90vsbi9P+HtntWGbX7sar31oh5ZBs1/amlwu+7B8dcpHt4O8yK
         U8EiTivlVf6vVIbeOcJH4+PboWSoEf+lJlfbOsRGNrfFmLTUn3hTOeSHzEKzrYrWsrzj
         eC7RvASxeBSMbKohB81eiabRbk4e6E/OBFUT4dHF5/WlG7Nu7DDfl+G4/SIzaSGaQAO7
         K7og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778059645; x=1778664445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1oLv2HL4a7Q93QxaBiH4+66dnHg0chum6/sNuCd+zNk=;
        b=cNMNkNKFcfyldlyOhKt9hkZ7pg9AVD4J6rc1YnlBr1MCtn/OhjjlkIaB/9aWOB2jId
         9mHdeXTsljTx3XpEulOu0OIkx9YMxHXn9oAqHKU9eDR6tFOsglRnv7ra16U2em9JcLw5
         PnpI2F2wCu4iE658GLEdKjin5U/a32MUnxrnKKSypuRL3BpBQ/DhAh/B74JFPIDbk64y
         ThNHY9jDh2mT8CzqwLq+Pzzn+YF2UrSustGXRyGiO+GPs4aCYxr0wwkeguQNvUk4z6So
         dd6/2O//me2v93PsYO/XipYcIQAqI+hw++acizsP7Kqm0hFeiW40SUJ1m2vIWIuuaSBu
         da2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778059645; x=1778664445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oLv2HL4a7Q93QxaBiH4+66dnHg0chum6/sNuCd+zNk=;
        b=c+XuwHmBZza09bDJcq8kuuIOEjLUsJSzT2ZooxzsDzFbqMF4c35XGSIqNETdgDA6gY
         nrr76PJCZ0UVfms7zCDgwELcsTtXjmiYOssTsFwMwUrjcMZ9F3Al7vAL9Cy6dCFvl6b6
         ZyWeDdY/04Bl3476cjkbksKRDR2RWbSGmVwLnt6vSK+ZBaeJPIXIhJ541Aql5bJX56zI
         Zz1nvll8+HLD75Um/um7ZbL4fN7Z78yewzGYR/LM/erg8mORBdSoo48iAbzhsdUKTiO6
         Inx6CrqtiGMwj6nHYEuy/Uhizs+7HpajDiU/3QFbL17ep9UUbBn8wSO9tQ4xCerJYGGo
         pnXg==
X-Forwarded-Encrypted: i=1; AFNElJ973fE37MetDSyF+5Yl2kJTES3L6VSiYqg0zVtnba6tR56QkNvjNYH7EL7pxC6w9huakCkc+5ls4co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+9jdG45jAAhT5aDwL0n7p2HLwi4ghRof4LxyGepPKqhWfxc5
	qdXRE78hJGLwMfD6DHySPcAL5uuxAdhUHbA5LNII37NOADp2Mv4t+GnCo72SVh89HGy9ILCMuRF
	Z5JwOBsvUHCzn3wSmLul+I3joi3o9cxQ=
X-Gm-Gg: AeBDieuAhxfTojnJoTNacn4MSnESOveMHHdPkfF+4ECIuI44UqP81NWgw1+z0O1t1RB
	P0NVgCvxeOj5fax7tmTFGbqzpTQg+8/ZGIAw4hlqlTkcY2/sX/ALFxO6dkBnhSuKB2ffd2s4qWv
	+UVoVR/OuTeCsvVOeHy6QOoWVhJ4WpyX4z6oQiDn4cRGR5zQ3DH4eSQRCVN83HBRPayItV5knxw
	IuptoQ6KcIqBnJCgGsDEBICvQRZEHp0EXTX1haG6qvSxTqLXEmbstueX+TbBVAGx/dtY42BG22/
	L7LJdMnjIaXERSWpM6bzHmOxCl2FYDGMJbybWhLBG0jsnTT6apyj+entTOffK/3cFdVC41JfWsB
	+wdK6yi6ckGNmBQrfkZ5GqIi6zA3OaT/tZWGn6nGUOCZTkCpSoE+PMGuLBkkdPGluRVPi7JhJR2
	eI+C01/gQPFYX7UXSc
X-Received: by 2002:a05:6000:40dc:b0:43d:7b7b:ab77 with SMTP id
 ffacd0b85a97d-4515ad7673amr4548977f8f.11.1778059644664; Wed, 06 May 2026
 02:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
 <20260505174640.3998281-6-sanjayembedded@gmail.com> <CALoEA-xhRv7UN-yp_PLAbmvz8rOksCroT2Uhx=WTk=WpRujx0w@mail.gmail.com>
 <afsITtK0oEUMcqPi@ashevche-desk.local>
In-Reply-To: <afsITtK0oEUMcqPi@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 11:27:12 +0200
X-Gm-Features: AVHnY4JeiIFBjnGtExJaNTrE6cV2zJ52SsfjwObkrRotEc2ftsKYhPYXAhpB270
Message-ID: <CALoEA-z2X_sh+g9M=9jW+EBLx2c5j2U-9TYdMK03HHc52nVp-w@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] iio: accel: mma8452: Use dev_err_probe()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com, 
	christoph.muellner@theobroma-systems.com, martink@posteo.de, 
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 11:22, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, May 05, 2026 at 08:45:32PM +0200, Joshua Crofts wrote:
> > On Tue, 5 May 2026 at 19:49, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
>
> ...
>
> > >  static int mma8452_probe(struct i2c_client *client)
> > >  {
> > > +       struct device *dev = &client->dev;
> >
> > Stray change, I assume this belongs to patch 7 ("use local struct device") of
> > your series.
>
> Not really. It switches to dev_err_probe() that uses it.

Perhaps I used stray change incorrectly. The series has a patch that
adds instances of struct device, so I'm not sure why this patch is adding
it as well. It took me a solid minute to realize what happened when reviewing
patch 7 of the series, I was ready to say it wouldn't compile (see my
comment in patch 7).

-- 
Kind regards

CJD
