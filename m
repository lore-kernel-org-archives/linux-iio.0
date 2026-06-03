Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFE9328B61
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476759; cv=pass; b=tWZGojFYL6PPmaaQF9OzVuBMCLvg+JTdRu1J1qjUayeCI/zDV+moV8Fgm60aUlAaSaZhbb0lD0aPmaDLlbqse8//irpc31i0jBFW5DGy6SdP7Prz/wE3OuvH1VjdDk02U9LFI3kvOND+bXoN6p4wpKaA54mhDCD42unEG/1E/PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476759; c=relaxed/simple;
	bh=EGFZSx0nPpPT8Xi8klATOIesfD1+YDfuEGOz+7rhoPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iu4ncjY+reKdVhk5IqvxEYRGlSLIJt7nNxaV+wLHrXoI4w9uVIKj5+54OxQXypJlLpH+EkNBnzP0sJ2S5KT3Ht3qcdmVTGL/lF19bgV2BwZsU3rKv9/VwUqyZy41wHDhoZd8pgJ8EBrw/Ub81sBtrpwUfL+gGM1CLQ6+45bE0ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLeZiKDV; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLeZiKDV"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-396775c26f9so33612951fa.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 01:52:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780476756; cv=none;
        d=google.com; s=arc-20240605;
        b=feWjkOVfceWeRnbeIExT6seXhVZCf5pXVpdpM39fcLNxaFZgaeCPmYPm6xxUX2XoHj
         LwgXKmogCeFE7Wj3s8RtfCgSo8fFkDWhjTVaKoXN1rEGZHi/Uv279n8qDc+G8nzoZEyS
         XhZNmfjJ6bKsNZnvpanhMzf4qPJvRcDjiH2O53F1Wc0wdScJVzwGuzk6lRdbkEet375y
         NaueIPQW7WdPOr0iAS1aHHzB8BJMi9A63EYLuORR1L9OKoXiwZlbPJ0pr8y5dZC8lwHk
         2F7HnuMdtWSLHL5GPSOqhkzKJVHWPK1folQ62dyJ63hCXgv0gdGTyzedDzCxcQ4n7nPa
         hmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=697VXlmq44YvP5WclcZyXKZOINa+k3r8BrdvqCVk+gw=;
        fh=TUck8HYLQD3M9WBUn/LrbSlXofXqCUAwF/sB3KNoSq4=;
        b=eoox+g16k8vB3RDgQp2iRv/yGBxD9h/XeRAA4mhvfFNPfuE9ZnzofozIlnm9nD2VFl
         i9DzNqDE6ahF4iWcf6FcWR9NCxJw7YB0H39aiygYvcgZtLjoAVkHjbp1BDWA8jpPJdxl
         Y5rkT4avZ5w+RX+C5GJtwEa7U9TCKEebAOKp4pCcDRnsRG0T7kAz3wzcVZ3xKnthVs5w
         1SVpplvDR9ElnAfW/D3fCLsNQI0GQMQE+FQu19kkGztdaIOcSbjG86I8J0vwwOsOXkMY
         FYXAGyPf1HUal971fAZggK/cEniqVyallFDDJkCti4TXtBUXUOrieYaep9RtKQZigMIb
         Pgog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780476756; x=1781081556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=697VXlmq44YvP5WclcZyXKZOINa+k3r8BrdvqCVk+gw=;
        b=YLeZiKDVNj6Gvhi8jRfGiv2GcNmZE32H8lIiG8LlRYFaagI8iSYa5Ukm8bV3MdqRrW
         LGKeYvasI4WlxQomrrI2GfrTKdb77ujA4mMWBQBnl8WO6n0ud0ZtcTLSMS9HiTr02dXS
         taPZvPz3PQVgeHnu5iqXfd+tnJnK7rtkGXp7PiWP2oj1U0cUYZ99dg5g+fFvx8zof1+g
         5R0F43m0bE5/2EbOn+t018cnCQYVLPVmOfUXChHYgBQWBXutV1xaSRRodRVbRgOZgjmW
         UVxsvc1pX9ChmPia9DStGHUZv7MdEqBL2pNTKl8FQrFa+OfAtdswn17xmqAdfjbJrthd
         jbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780476756; x=1781081556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=697VXlmq44YvP5WclcZyXKZOINa+k3r8BrdvqCVk+gw=;
        b=dvnVdEDQ/5Js0RdnVjKmnop/gug1xoHegkS042Isz0BdKaqIUuW7KsG9AxdPfg7aQt
         M0fKv3suJX4TfkoTwu2cGNny2m+COrGaJioHF5fKFGhwZEb6VOCAbgXkA+AR9jNzz0R2
         qe8tMpuqMCSEI5E8lLsqAKXcync/C6JiIbbWRrnEApFN/vvOdjBcb3NmEy+LA9JtmAxM
         rT/rUUNRezYMKxiidiRylf5I5qBel6kZ12/nF2Er81wjFfTBP96cMZ/ny/T40y3n/BmP
         wjQ1L4e8NpJtkqshLnDsUO+2ldqlEqY+oVAdv4gSYEhWKjSlQNpQj1cL0+SJmPiKOsi8
         qz4Q==
X-Gm-Message-State: AOJu0YxKEKHwLonPosp+lufcBxAPfTOdwDjyNm3rlRSl1IO6V047OhM0
	sfPcXk14osePj/fX9nk8CFWl5ZSit/b+SmODT5YoIXcZ3yJ+YiYe+7pFTyiPp6ygRKxm370LfMS
	ilKiMTB3qhzBMYf/1HTj8SxNOSM66wR0=
X-Gm-Gg: Acq92OED92FCacdQsp264mLGaie/SQmdxKMPe9oBtbossoKtI3aQnll97EUP+2UixDr
	KrIpYRsg8pXzbG4qJZuNIyRmP0b1bFU4jA4gst5jVCBpB9PBM+NdLoQ5ZTnby55SntmuS4Q4+gL
	FA2epGCJ0UpeWQnTblEuGCZfCYWAwzoHRJYFXdlarEN4wbfDpNVuay2rCDpFc7hpyifWKtfryFf
	X5v7sZIr9Qem06W+Q2Y+vEea1pyefO7xxlPDQpyPy5HjlqbvSEfrpsJ5RKPb/Y/MwNFEImox4+w
	um3n7XDzWyDPnFUniUkK
X-Received: by 2002:a05:651c:509:b0:394:8fc:8c44 with SMTP id
 38308e7fff4ca-396aeebac21mr7138741fa.0.1780476755306; Wed, 03 Jun 2026
 01:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
 <20260524132824.54918-4-muchamadcoirulanwar@gmail.com> <20260528170840.54173bb7@jic23-huawei>
 <CAO26r3R5+xYQM=_uxF32MQRuxkhpeY3bTwq6M3o8dPCr8-kdnA@mail.gmail.com> <20260602130642.068b24ea@jic23-huawei>
In-Reply-To: <20260602130642.068b24ea@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Wed, 3 Jun 2026 15:52:22 +0700
X-Gm-Features: AVHnY4JZhb593s7xu7sfNCsQ5zG3L-rlxBp4pbrsozwUpy2S1S4SNEX8wP4dTkg
Message-ID: <CAO26r3RnTS1QOYrM-W4WagNDSCbb+T-+pQTou+yy80BeBWMgCA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/4] iio: position: add Rust driver for ams AS5600
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Jun 2026 13:06:00 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> > > +                let angle = (angle_h << 8 | angle_l) & 0x0FFF;
> >
> > Switching to `try_read16()` (calls `i2c_smbus_read_word_data`) plus
> > `swap_bytes()` for the byte order, then mask:
> >
> >     const AS5600_RAW_ANGLE_MASK: u16 = 0x0FFF;
> >
> >     let raw = client.try_read16(AS5600_REG_RAW_ANGLE_H as usize)?;
> >     let angle = raw.swap_bytes() & AS5600_RAW_ANGLE_MASK;
>
> That swap goes back to a pattern we ripped out of the C code years ago
> and why we have the smbus swapped functions and regmap support for that.
> If a given part always does the bytes in opposite byte order of smbus
> then it should be handled as part of the read function rather than every
> word read having to be followed by a swap.

Understood. I'll use i2c_smbus_read_word_swapped or a Rust wrapper
around it, so the byte order is handled at the transport level.

> > Rust doesn't have FIELD_GET yet, but a named constant serves the same
> > documentation purpose. Single call, no manual byte assembly.
>
> A named constant serves only part of the purpose. The main gain from
> FIELD_GET() is we don't have to go check if a shift is also needed.
> I'd strongly support work on getting something similar for rust as it
> makes for a lot more consistent and readable driver code.
>
> Basically I want all the useful helper stuff we've built up in C to be
> available in Rust. In cases like this one I would prefer there was never
> a legacy of doing it any other way!

Agreed, I'll look into what exists for a Rust FIELD_GET equivalent.

Thanks,
Coirul
