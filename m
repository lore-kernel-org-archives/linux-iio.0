Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876404;
	b=3zvPk4uOtL8Y+iNMBEIiO8Nn3mGhnhf2qicQHIIEQzi1Th5g0JAg4bqXTRaeZtAz/22i
	 6+9EDZOS5WNxzDsrFXt3BZ5rfeRhe9dcaO8xS2Sj7RMSBDoU6VqtJyHczZBzfHRcHrYCa
	 yWnVh0GxIJR7RPgmTTRHkIdx6szYMaLxcIszUS8k0ze3L6Rr6apVTMhH6FxBbjWw9LbBL
	 5o4G8LdQi3pazqGvtCtEa2omT+ap2eNx3RdL49cGUpZPLJG6NLwkoUK+MCEUalEPROHMt
	 FQts0Cs6lgSa0LNVSZ3ZNWqj/tm+eY0wV27fJTvHudOab1x0yw+ZAt+RtXb37EjEzdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8IDkil2Vu8KJtD0pRC1JpHyRbwvvq9lkgInJecuVF/g=;
	b=dw/pcwftuaLyE0zzBwvqPyUCPW6nlOTC2ZFMeHFOA/TSI9xwOHif3dVgAGItsPp5dlee
	 XD11Taaum1imZtB0dASUtQox2HVtsJyGWk3oQkY90puS2TiiTRzY+PZbXgSwzNqyOWZ4L
	 DAoPNiJ3E0lhe05RfhM1xV0YxZFzr7jHIZF0uEqA7RjVjEAiR9VlR3q7njb8LtLHtqMHu
	 8eqw/XXPAcKtVZA+0lCKNFqN9zKxRCqljMHaE8nUk5IFWxj3WBpAEZkbajm+xRPkpJ2Cd
	 DK0SZ+IwDowOF6Baqo64g9sh8G8mg70QqhQXxwPLIhybnJaWzaOf3gIHXpiofA0HSpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uQr0kFNb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CEF606D814
	for <linux-iio@vger.kernel.org>; Thu,  5 Nov 2026 10:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45CEF606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uQr0kFNb
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4d28f75d62so48701766b.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2026 02:59:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793876398; cv=none;
        d=google.com; s=arc-20260327;
        b=SYc+g9/FzCME4HHVrt0fR5gBlDAMSWHdz3516Q9GGgyQPpiHEbeIKGZq4/OwrGQbwO
         kgF/pLF0cKcGokA6gPTpsKQra7S0AAJu361dqpAR6l4Bdycm47JW8p9a3Ad8wu88/8wo
         Hvr99aol0434scj23HaWPGze2ycmh3HtYa4fhmdm4PDN/r1aEfbjJ2r+pG3T84JzQ5Wy
         +QtcWx6DMXZO/jBTH4lrlhQvesO00aauVSlEQFmCBlYVdBovHB+P9ll28fk9w/6sFKns
         /WcatS3fEevjmBgKCKrksDBDdw29yJL7t8DWIR+MDVmqNR1UED+kkpkv3x0xYPdcHwAc
         EMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8IDkil2Vu8KJtD0pRC1JpHyRbwvvq9lkgInJecuVF/g=;
        fh=ILjKTYy/nRF8DzRgSVPNI1J0kf88Jwc8CxvH3UVeLq8=;
        b=UTkspCh0vbds3lcARJkyUI/b1a61QYm+vyEmKZmkcUJ3z+RmC2v0dkdiQ9LJl5uCIA
         ew8Tanmhrg6wNyZ2jMjuEOlj7PUcdhjkXLOSJZP/LkwIoDFTdbLk9OI0DJz2f4yRYw0F
         /gT+1yho2tLrOrZqknlI2Y1JA89Da2F/g5KyWLvIpU8e4wZVFs31dm1vinCByVADLMKe
         CNCAgNdn09E3lReRefdzRDA3UrHQmCG9PqZfqCdnceOl7kJG0+AGZXTNf3ItBIEV4DCB
         Me87JEfi6E+MirpgqBS6M9pJudng20wQu/wlKqQHCX4d8SeAR5J2pG6ciDXDSeEOyX68
         gdig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793876398; x=1794481198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8IDkil2Vu8KJtD0pRC1JpHyRbwvvq9lkgInJecuVF/g=;
        b=uQr0kFNbU7xYaLOjvT3vxuSmVKE8PdIQlZfkWLManzx8N26orhPmHjSAwxX/RGFuXx
         PLddFBAfJJtxwn/5Jx7nf+SEnmJvmX5oDdYxcR7Pw9u7d5VsUIKpKA3hdUyj0u85HiPf
         /8aBxloPuYO/4udYDkv7QNRPzML8LadtVqffp0cdBWZmMvIpXshDmWi4ZGa0tKzwni/Q
         RCxquIRd4O4SnzD5VxMO2Yp5BO9x4c2GeY83iU8uB2ImfrL9nO5897fueIPLsqewGwrx
         /plSTVyIw8rv6gd5/7a20W8AnQHIBUHo1DUjtAUdCqR7U9T5S0IJ/5mCfO967Y30eNPr
         C/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876398; x=1794481198;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8IDkil2Vu8KJtD0pRC1JpHyRbwvvq9lkgInJecuVF/g=;
        b=2dDzG9HKMwL8P6OK+9bnpYGVUAezYpE/ApAPsxdk+tuX6doxVsZpd93t4QxlC1SCZ1
         vpqicTsybXug9AtssCiKfU5pSSOnmNsL1ootlcqZpqGhEeYeagI88Z1BlibppzCZzhkr
         n8NjOYWYS+WIZcnQYCprr2o31PfeprG15utM+69+xO3IRDZMJR8hiUiPPXCVFtfmkGWH
         ebgNYq4TcW0mPdDWIyZ82I/bEsmHpRkAu6fQ/M1vEuaPCkhi5yGG0iql6age+O5uSRb3
         BfFRNsZPVKuL+GYhFj1dkf0dYyMXtmW6gUgaDNkpAkRUSj7ynerL3uJqtuLi6eOx8TpY
         eNgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwK33miQLOBwCdCqFVp6sTUYNzdvuY+ohBMuGKngbLFFuYGIkDjj/ay1WRSVznaCoONCRmv2tj1uvM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JZe/PRfoNHmvcJ6qXIfHUE4y6yLfY4ry9ZpXWcpbI5FUZnUzI
	ChMMtpo8fzc2cZ+MIG3kxUMPRSLGoVlzY7ioxs8LwuMmE25kD3GXFuAdW7FGAyeT8DCIMkT3xDL
	BQWS9RlydYKxqi7cCxuSUaKGUuvpZ7KA=
X-Gm-Gg: AYBFou1scSgHnRQYanaR/YHGmlhlWlgyn3/o47EiCXQqR7xKMRz3jCkz0jpIelkN7q9
	ce/Xe55Vr+ONVZXXe5B6XZR6KgRZA0drpDgcXODzEVdHttCEpev/AqEAQ9z6TdmKtQZO8MgvdY4
	hfcZOtXOZG/oWv+IYqnzRfzRoG2BLvFgW+NRD/LDYGdTaZHBuzbYljZNawz1jekktXgAKdNuIHL
	qMAjMwoY1ezBvKqyC12ZaoqinwEUi3lcN/AQEx1kT+kWbQwPRlzjvZoP35fwiKu+SZMktUPHKlt
	cg4Vno3wDCT5m+UDSdegpOw/Gqq/2n92uO9Ek2c9mVDuB84JlvI9AuMGuhAS2h35O4sx+Gv1NJ1
	GzHPGzMn5GZQfpF+Q9WoGMC81eq6to3RDJodemblBQs3VMjgpLe9sRQMq0jYx4Ie5fasb3ckYvv
	DpUQXFpVHSVLc9lZCiUfa7JgJY+pKOeDVZ7iWJ/Hb+4Q5GOfbmx7xzuMEH19M6O2cZPO6ktN7Bx
	pn7gQQbuc2pN2IINOMawpVP8qvuTZZVwvXJrOvay0z5W+2o9J59wC/ODl+E1R5Se9Q36Ie/2MAQ
	MJ8arK0=
X-Received: by 2002:a17:907:3f95:b0:c46:8b87:c1f4 with SMTP id
 a640c23a62f3a-c4ca7a86e98mr1520903266b.20.1793876397539; Thu, 05 Nov 2026
 02:59:57 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-iio-light-gp2ap002-v4-0-fa1cbaad2ce5@rudorff.com>
 <20261104-iio-light-gp2ap002-v4-2-fa1cbaad2ce5@rudorff.com>
 <autr3DH6UZLY_ys4@ashevche-desk.local> <ed75d869-c51a-457e-9cb3-6250029d4ec7@rudorff.com>
In-Reply-To: <ed75d869-c51a-457e-9cb3-6250029d4ec7@rudorff.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Nov 2026 12:59:21 +0200
X-Gm-Features: AclHuK8zK_VKtp7fvak-P7kamZod1UIl3e5bgYtsqibH1ihAtEl2wIiK2lVgYCA
Message-ID: <CAHp75Vd_Rr6pFsTwpkwBcA9Sn74Npj37zSau4APMad3UE0U5QA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: light: gp2ap002: add led power supply
To: "chr[]" <chris@rudorff.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Linus Walleij <linusw@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 12:56=E2=80=AFPM chr[] <chris@rudorff.com> wrote:
> Am 04.11.26 um 18:31 schrieb Andy Shevchenko:

...

> > Missing '---' cutter line which makes this patch invalid and it may not=
 be
> > applied (your SoB should be a tag and it should be last in the chain; y=
ou may
> > conduct an experiment, take the message ID of this email, run on a clea=
n Linux
> > kernel Git repository something like `b4 am -s $MSG_ID; git am ...` fol=
lowed by
> > `git log`, you will see the issue).
>
> Sorry. I ran checkpatch.pl and b4 check and they missed my mess ...

It's not handled by tools, it's for now just common sense.

...

> >>      int num_chan;
> >>      const char *compat;
> >>      u8 val;
> >> -    int ret;
> >> +    int ret, vdd_volt;
> >
> > Don't mix semantically different variables on the same line.
> > Try to keep reversed xmas tree order.
>
> So like this:
>         ...
>         const char *compat;
>         int vdd_volt;
>         u8 val;
>         int ret;

Yes.

...

> >>      if (ret) {
> >> -            dev_err(dev, "failed to sett VDD voltage\n");
> >> +            dev_err(dev, "failed to set VDD voltage\n");
> >>              return ret;
> >
> > Unrelated change.
>
> Yes, but I'd still like to fix it. Ok, if I mention it in the changelog?
> Or shall I drop this?

If you are eager to do it, do it in a separate patch.

--=20
With Best Regards,
Andy Shevchenko
