Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF88A1A680D
	for <linux-iio@vger.kernel.org>; Sat,  2 May 2026 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777689531; cv=none; b=lxAdcNvXBLXFMjUIY9zyIHHeRmV7boOnXghE2DVp5cdULVVN7rCB7TiZPvUDaO1XrxkXeRQAgEPTFml0SmNb+iOVkYh7KytVpfdnq5hNfR515dMkNTNbpRgu5FIrux9Us/A8rh07hYWZLZ9nI0xp+TTW/96l7tdkZWHZyJ62LyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777689531; c=relaxed/simple;
	bh=fP2IrNZRFDG5V49iaYh/E8kr6Irg3C/V52/GNN5J7XQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=TGNFMArIVHenHjti7QIaVYv2oghfpRb8AguZGRqk26YBVCZ2ikNR8KNBx7wYKQ3o+/FGVOZRQtutzdVNeKjloDarb+R9GzpnxAooZBasSlgMlaQwRX+v6tJgYcjGspfwGZAlfcarwu2SoMpKqgcLtGVhT5ICvGg3ABt5PYUtBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VICwgN7q; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VICwgN7q"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dcdd1b492eso2544531a34.1
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 19:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777689529; x=1778294329; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lvWB/srBaK64EFjXhd2HhnzAD5E/LnopMmKAbRz5mE=;
        b=VICwgN7qQo6qR2B4i+qY/0rMaVdA+tD9t9/XzQnu0KBNRYYo6Go334I6MEaZt2Rvox
         pK9zNVPtQNZEeZORI1emXzo9GKLEnWmHtIWEADyuIzs+vIydsyzxj2q7XHr7YG5PyoYF
         w5k58MH6udQinFG9G2maX1OwzgXpjVcloao/2BtGpw3FlpX51jaK+Y+HLAJ9iY+1Oky9
         RI+AWFJYWArzoxqvS02MadRu5BgPZDtoInMb95IyoY7mTwPulOFy3XvPoXNjs7VUY7db
         zkZ1kNZ+y99zGeyJVq/JvV76hgTL/0J+LAIB+Aj4jEgsRys8Ty2JEPQoFlyydqaL9gRe
         DlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777689529; x=1778294329;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2lvWB/srBaK64EFjXhd2HhnzAD5E/LnopMmKAbRz5mE=;
        b=EOOQKhe2q46Ai9uLv1dg1wata5g7XRzFMsn/1UQV2F1N8QYudr95HzVYznRwvW2udO
         WczCQ8ALfQzPxvWFRMD39ySbSIn6JgJxJ8TSGO1HA2RykDs8AEtOsRQ5HcZHKHZxZuYI
         zznNJwSAamVFoC1EMDqRPkMCa79G30UDAmms89jV+EWv+ELxRVFKDxqf9oOEX/6zCoIi
         rUUs8hx/rxbSXQvjr/Hk9t2+JjKY6dFNVV82xJwczyz6CZSzo8AKsPDJA2Xd8vAV3XXh
         OXkUgjj1lPZdqMR9jBWpAQWjK/eHRXd4F26VEXYDMmDAShuRy6BFXIJtVZlMvJHH8Eeb
         miOw==
X-Forwarded-Encrypted: i=1; AFNElJ8Qm/1ZKS27SEUqUaP2k91f/OwE8puIj9D/J+JcC84YOUOJfG80Kadzn3VzNFZ5Vl2rYqfFtbsFFxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhiUSKVh3aRHBn4hn1Wl2mc9g3Lhd8aVaUXwKWXit+zn011sUB
	jKY9pzuF948CWRewAPY5M9JJkNv3E1KTeQTh0vHK7GlPVD6bCqOj2u7U
X-Gm-Gg: AeBDiet1BrKj3figWz1rjPNNuU66DhrFR3jI3PpbIiJduM2rLe5ZIglrd4ldUyFBdzz
	60rQW1Gwz50UBO2EBpOO/aKr4TnTJKfBN8UBLa/pmthII5Z5Lb90vlLEtgbjSyJjDO0KbkwUsHt
	9ZLravKN11GE3yT1GPTnklkhKEz7QEu1eD29Sw0qQs/sOivI5muEyrfL5HSz8aYwT3ISZltX8Un
	rKs0oXj58/QgJYAWw2kxNOT/ATCsCLluwoEecFKKEaJ1UDNzf2sl7sXeRtzildjCPV4yx7y6AO2
	cHWz9tGQPXgOTFkHbvvXNMQ0qkwK4Hql4rQUg4ye442FFnoQijFdhs9g8eDdOQjHbAVbaxkTyaY
	lEA3VgA3PQXyPV8XuPt43eEt9qZwQUbz2Lz4Qc1x+b0HpNnTe9cY9nPmP67f84Dvz//44OKGM4K
	I9Ou1i3SdNbDF/NoKv1UwkhJ7OvsX+88Zi2Ho3LByJq548bIx2rYRnlw/fu5kZ
X-Received: by 2002:a05:6830:6dd0:b0:7db:d6c8:a21a with SMTP id 46e09a7af769-7debe2c92c5mr3625148a34.3.1777689528891;
        Fri, 01 May 2026 19:38:48 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deca80d5b7sm3179928a34.9.2026.05.01.19.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 19:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 21:38:47 -0500
Message-Id: <DI7UCEXCZ8I9.1TAZ7QADQCTR5@gmail.com>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Maxwell Doose"
 <m32285159@gmail.com>
Cc: "Felix Gu" <ustc.gu@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, "Arnaud Pouliquen" <arnaud.pouliquen@st.com>,
 "Mark Brown" <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2] iio: buffer: hw-consumer: fix use-after-free in
 error path
From: "Maxwell Doose" <m32285159@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260430-iio-buf-v2-1-84c2231dea5e@gmail.com>
 <CALoEA-zC9je3xsq0+dqG5b-EiVM1DiKbgAT8JvtALsNwLpp=ZQ@mail.gmail.com>
 <DI7GHSFZGAL4.1EFUSTVRKWUBU@gmail.com>
 <CALoEA-zDzhLwgDp6-815xorrXoF=qrfBN=WSdLhar2Cgpaqv9g@mail.gmail.com>
In-Reply-To: <CALoEA-zDzhLwgDp6-815xorrXoF=qrfBN=WSdLhar2Cgpaqv9g@mail.gmail.com>

On Fri May 1, 2026 at 2:40 PM CDT, Joshua Crofts wrote:
> =E2=81=B7
>
> On Fri, 1 May 2026 at 17:47, Maxwell Doose <m32285159@gmail.com> wrote:
>
>> I think one of the issues raised by sashiko has an active patch:
>>
>> https://lore.kernel.org/linux-iio/20260427-iio_buf-v1-1-2bbdac844647@gma=
il.com/
>>
>> and I think they were waiting for Nuno to review it, since they noted
>> they were on a "wild goose chase". Thus the only issue raised by sashiko
>> that would still need a patch would be the OOB issue, but I haven't
>> looked at its explaination thoroughly to see if it's hallucinating.
>>
>> Anyways this one should still be good to merge.
>>
> Yeah this is good to merge, I was only pointing out that
> Sashiko reported additional errors (unrelated to this patch,
> it seems to keep finding more issues with the driver).

Also, if anybody feels strongly about the OOB issue that sashiko raised
in iio_hw_consumer_alloc(), you can probably add something like:

	if (chan->channel->scan_index < 0)
		continue;

but I feel at that point if that even happens there's something else
seriously wrong. But it might be a good idea to add that check anyways,
better safe than sorry. Not to mention, since this is a public function,
we need to code far more defensively.

best regards,
maxwell

