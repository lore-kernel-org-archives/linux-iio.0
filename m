Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68F2421239
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889598; cv=none; b=i1oRk0wlOyAACGfNXedoOjJ5bv/bsZ0YjZLdCS7KCKrZtqxtBY4vjpRhEAtC2iZnLZ6f8WL8W7pr/xi/fXo3h9uW8tauGejXT4U9iezpla2tWKIg988C2PHE2yD0GcW8NXpSK8bvbonG2hoZB+vKu+95PcCZXbnLZsa1pHzhLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889598; c=relaxed/simple;
	bh=kcsOjv7UWlVYj6/kzZGAyeQbm70mj7j8FgBSDtw60oI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFJEtvaDwTtimpVg02LIKc+1Dqx1xepXs4qXMWGYilAsCfs4DoQG3qK6a1Cc9dSu2VPFK2chlZMcrZ/Vig1tlRMM2G3/zcRq4+qsohmb+lzURZcO6MDtKxXB3jC5Es0ttYkh1x7hNLQJGuFqDBvOgVeDKKUoxEyYrgiPubzWsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGscIwtg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGscIwtg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49550ec592cso8915865e9.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 03:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784889595; x=1785494395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I7dhjNJuDBskm4zLlecWvMd8QtVhCdB2AqRzFBbNvek=;
        b=ZGscIwtg4dNc6ecyDQIIxQnT8wwxs5C/ck4AgOzEurx5DN1T8dvVdbBsJYIRjvk9WG
         SiCyUriCuoaIjFErRHZvBk8I+P7xgbG2hxKYMWhzNTE4I83K7IP+3TGWSBnI89hcyslc
         X02iF9MRAt1ebZrNHZHmAZes90Xc3evDh+6SStG62/HnBADPuvRtcuXCy55ZLRXff+bq
         NiwgIhv/2WXPuKyth9tdHG2sA5FaANVQB1zXXgaZPzXzPGAoKwr1KFII18/L0bSEpEbK
         WtRABw4imxWoX8YjYGFZ7a4kS0iGCPZbpeuyfKK70tSbf2Bgqf9gaOn7zup3+HaWXuSq
         nyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889595; x=1785494395;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I7dhjNJuDBskm4zLlecWvMd8QtVhCdB2AqRzFBbNvek=;
        b=KHbzTNJ6m3I4nJD0e2wLqzzUI4fETGTLiyta71Fczz9E/cVPgoEQ45+JbB7jOWGfhg
         pjByGF0Zo8bzSFwlujUpLG++HoDl1HZgin+OPDuEcCmvFdkrpVQk82zANL9q0tKeZ+lg
         tWyfJw1PxJ4ewDEwT3RdaoSXlzedaBSHNVLR5djZ0gy5N0Xaw4CZo96IWMN4z4JG5LjU
         OzAi4OrFMbKzdM+HbSBHDGVZQaQLmK9lE01HCaIDwI3ChChLurM/LzttnGi6fIXQvCrk
         hfxxyZYvy9nlWw7szNFTNAgjYhBGxSIxzwNIcgBCuvPvN2KWodPP/g0ILuP9jNAj8zDI
         XXbw==
X-Gm-Message-State: AOJu0YxCwA5EHfZIjbA7atXnoA+ogL21hutaKULiRa1+TGtXUISyVD6w
	PBhJDBeGyH1XXwgvLwKLZksWRnBqCcbD0nU+LlliwKHotvWvptPqmKH1
X-Gm-Gg: AR+sD112VQJ3VJjQXvTbLJfKm3GZEWkNXds56jYYm0PvL+AoV3erSTxUkVV6qoxwrko
	o3FssvMGVl4KUAZ3hXvdWNvneD6VPN/C0p1wl5ML9qNnZBNXIU1p1vuBet/WARqGvxdbgt6vtQS
	PVokN005SBHKGEaHAg2MQbuMEp8vABUQpfTI90jvR+8wGCOprf1yWY720dyydrAVDEOf0kTMVeP
	NP6kH1how8U+TvS0Ogokm+eAakzMBMtMkeRWkC23BeoNGYNpwmjgijiUc0Sm5961eZBkEuS04/T
	SKolJG7JjBk58WpPBwgC/0fhPBBm3WzWG3p/DzBZurjNqXTW/y92LoJ7eH4uQG/i57Nvuoyzxkp
	8PQLRThNRIzUyVDccTe/oRMwqFGeaFTeLMe6cFTiPeUxoG70bqPsgWAVCFQMi4fpWULlg0OW9el
	AGmbouRIFswj2BPp/SjZP1kedee2OcVrDm0VuBzYkxrYU9Cbs1nl4p3nXD+YJwprZuPnO6dRAnA
	lfnPeBEIzAWaXD8gQwlyX3IvRyKT4XmFLK8JLbNOf2gAvNuoIZqeHb7YCTiY+UkFiknxJ8MEmmM
	oogjo5Jj+b27RdNeAkpaYVA6KYaxPz+DvkQm+D/b0Z5axa+KkdnpSopo/wfdt9WpTVwChE5mMCM
	QlywH9BCihKcm
X-Received: by 2002:a05:600c:4684:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-495745ac56cmr78521755e9.16.1784889594671;
        Fri, 24 Jul 2026 03:39:54 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af78845sm58043545e9.8.2026.07.24.03.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:39:54 -0700 (PDT)
Date: Fri, 24 Jul 2026 12:39:53 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Olivier Tanoh <olivier.tanoh19@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: Looking for a sensor driver to contribute
Message-ID: <20260724123953.000000fc@gmail.com>
In-Reply-To: <CAM49wQtgFL62Qm9LNe-DSwdY5av2uZVZMt3B7MzVg+jz6w-0+g@mail.gmail.com>
References: <CAM49wQtgFL62Qm9LNe-DSwdY5av2uZVZMt3B7MzVg+jz6w-0+g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 11:51:32 +0200
Olivier Tanoh <olivier.tanoh19@gmail.com> wrote:

> Hi all,
> 
> I'm an embedded Linux engineer looking to contribute a sensor driver to IIO.
> 
> I've already sent a first (trivial) patch to staging to learn the
> submission workflow, and I've studied the structure of existing IIO
> drivers, si7005.c in particular to understand probe, channel
> definitions and read_raw.
> 
> Before picking a target, I wanted to ask : are there sensors people
> have been asking for that currently have no IIO driver? Or families
> where a recent variant is missing?
> 
> I have I2C hardware available for testing (Raspberry Pi CM4), so I can
> buy a part and validate the driver on real hardware.
> 
> Any pointers would be appreciated.
> 
> Thanks,
> Olivier Tanoh
> 

Hi Olivier,

It's really up to you to find something that that is missing in IIO. I'd recommend

- checking out newly released parts, preferably ones with an existing breakout
  board to make testing easier. Stores like Adafruit are great for these.
- finding an out-of-tree driver that is authored by a silicon manufacturer,
  mobile phone vendor etc. and move the driver upstream (a good example of this
  recently is a a patch series for the Sharp GP2AP070S, which has an out-of-tree
  driver in the Exynos7870 kernel tree [1])

You don't just have to add new drivers, there is a lot of code that needs cleaning
up :) I'm sure others will chime in with more ideas.

[1] https://lore.kernel.org/all/20260723-gp2ap070s-v1-0-b8ca3a4c10dd@disroot.org/ 

-- 
Kind regards,
Joshua Crofts
