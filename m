Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674A33F8AA
	for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354080; cv=pass; b=mtU+WopaiuBonl7CbwwjykEgGXMVNmTZfQXah2FYUO5lqLypwxqDZtsOSiWPkwzCD9av7MFyvj7nyif652NrlNLz4DcjZp8CJNzrDzSpOi8WRZNPx0+6Rd4tN6Z7mUFlJZgAPp2f4AJwt9w8T6r9+87k/lsC6rTigBB0w4UmpoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354080; c=relaxed/simple;
	bh=CQ7qsHIFOBtag8p/PNJNlg/bGoC/DNwftXw3msIkays=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/NNTQwNxu8am8m2E0clfuduWsOVlKDCVwQh13nyUvho0gIuHokXyGTVdRtoewo1rx4gFgW1/XiGnCpca7X0+YSB4NPAoiNJ9nnO27vOXFO4+6USZR737HXjSH/6aCIh+DZB/HXoX2lQ8437FBFRRYO1T7mga4w/Nz91vgrCE+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIj+qW3B; arc=pass smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIj+qW3B"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c3735125bso617963eec.3
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2026 09:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790354079; cv=none;
        d=google.com; s=arc-20260327;
        b=FKMojp2e0eFWmvpaXYRzZg5DBF3K2wjrvh5bxzLbMF6IkyGLK5FRGrghhf8ozhbtqq
         s86EXLfqv+w2b9cTQfqn2ceOf/2RuM28Gt6YqJpMkjOYIcBL34cULpY4e15xCIyOfUNz
         OQ2rAmer8SYnLjueS9k9L2LuMI57ygnOv+3o9RYDCPtR1hGAA45U/AJJrcZaHCBYLcbk
         z5dqaWVTzjeT1OTUXxStLrMRlJGuzh39eS1TSx3mOMB/cGVdS8up7TboQt2Xzh63wvbx
         hwc0uW2lqmRSMQaq+zWJnqNHLbp774GLD3+R9ldXhJSk7a9tq4YAAREa5eM0GP9rDNKc
         7ApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=139BCYZD2iq9D0uvWIg5yy6OHV2Hpl2eJJpr+lFqbUg=;
        fh=c2f6Pyf3EGiAfZ+cK5TGCEiqYbikqRGarjx8L2m5nlk=;
        b=ETVoLj87VBbl/qhU4CUFA1NxFJPFl41yWvkBZz+/HX0eYctQE2fYo59rF9/HZGcxrp
         j/cWBdELdMrVkkasNgSnKXcgrkdqjJNQD14lLyH3kKcACmHgqmCmQxGSC3LLnkDsAENo
         jbYpKk6xNM7TB6/WHDP7rOD4RzUZhrSY1bh/D5glGD/lSO9Eg7746eh6rxPxLMef75M9
         6VUWUIB98aIMWURzaSeMsjdLGeYpbZM3ZKjZqWmL++50y8pN6SXvb0gishIzjGpgCkiz
         9Mdruh1J9axa04JDx+wAZCjOdJbekv9kh1H+Ev1ApsG757BlUJKWbRVypktzMVBBGt2F
         5KQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790354079; x=1790958879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=139BCYZD2iq9D0uvWIg5yy6OHV2Hpl2eJJpr+lFqbUg=;
        b=aIj+qW3BfQ4gh91MmCH2VkB84hvTNiCYQ9AMml6ZcwoQZ5pnUfsLSo/aesRvrB0lKv
         eMRNDjHh+jj4R8MjKblfqPR8gp2hoOI15fVz51s6ykZGG08FNJVwAhFm45g8CGlbjlXt
         DjF3tf3sRJ4iSWB4bXGX9X6Vy3CLtnik4JqRYrWu9m6x/3ZNv67T1osQRqxV76UhBQb8
         uukCGom7CnVrTfhX/442b8sp15OWJGWX+VSheDjiWimUnYYcJnsYDyNlUPH4766eY03i
         ILeLj72vM4A5KeeYnIAfxNTacy6xaxQ/aswf4GU11RkIjaKWGsxMetWPgR5nMaQlBOWH
         U+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790354079; x=1790958879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=139BCYZD2iq9D0uvWIg5yy6OHV2Hpl2eJJpr+lFqbUg=;
        b=fnItODP/xTrKyvC4v+eHg1HmmTSnzKpbWhFpn1rvS0vL4TLk2EPQnDTMqld8OpyRKB
         EyY/pQTwM8jXhSkx2wicrzj97kxodPF2i/pUsfCpBQ7sZIN31vIUUM46BLj1q0GH6PHg
         /DOpAhxvtu6Hkea+GHOyePJSQZUvJe236FNeFN2tFju+2VkWR4eVb52O+iBaWoq3aHrB
         sBSOeyEkB1868IbVqbChnnSpVR4zZ7rgWUdgCS8ITxhH2ODldczFsYJ5dFyPg276tB3J
         nhT/GVwSfbyYgtxaJu0uyiGfvNsXy6s0ZPV7j/RiQSsFtxhgcV46dA5avQ0sIdaTF6g8
         HggQ==
X-Forwarded-Encrypted: i=1; AKwUvByVio9f1p9MZlkp4QD5nQBhrQt/QGg+IWEVKplMl1a9m3B2EDBMTrnbA6o0DbIHYqCGDHIL6pMtFCA=@vger.kernel.org
X-Gm-Message-State: AFuF++mHVDkGRs4OxEBkbwmaeBJevEh4DwxzO2Z+351WIrQ1RVN0u5tP
	FliDPfFuM4M7DrqXqz4pLAPwIc1F9QqEffqQPnAYetjEEMD0bEKYjfYKJmOtX2uNWbx2n4bmHA3
	U7kn4HnhqMge5jMnh5KQQxED0wGScUho=
X-Gm-Gg: AYBFou3GPvSUd+/m5PrZaYKNNr5Hr4c/70580SZgYpgTZPEczi7SRISXqjFzwkHeaWS
	27qMO/2L6P/E1KpnYEv4PwgDpvNEHAmqgZACUK9k0PyHSGRL5P/cZaCiM3vOQfr8kg47hmdfz/l
	BfzCBNjia2EIBo6xKomcvOd6VEBsnCJ/GXiq68GNfOFKsxnmuKFNAw0P6oF6GunNM4f2KYd+AW7
	/gqd8+gRQ118ozyQdaQIuK3Ie+LEOeN5Yl3IJcQZz3lfn1psVrMe3i8uAAbafd5AqXFAl1bJ4JN
	5BP2s+hFPzWOWtHXzLApOG77Czq4TecwtRwc/CmowzWpQp9zq+caHyIIZ5b4G57H+ggDSDwHlR+
	y+2ECIlx1djc=
X-Received: by 2002:a05:7300:d10a:b0:33b:f062:a674 with SMTP id
 5a478bee46e88-34271d8d329mr811361eec.21.1790354078475; Fri, 25 Sep 2026
 09:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924-iio-bmc150-check-reset-error-v2-1-b6dc74d7aaf4@gmail.com>
 <20260925040500.0f637249@jic23-hlaptop> <CALnzk4Uz1ru-_u-SgQXszHW_PL5DbY20J38v1yGCnwBafcwgKQ@mail.gmail.com>
In-Reply-To: <CALnzk4Uz1ru-_u-SgQXszHW_PL5DbY20J38v1yGCnwBafcwgKQ@mail.gmail.com>
From: cdcp 206 <cdcp206@gmail.com>
Date: Fri, 25 Sep 2026 11:34:26 -0500
X-Gm-Features: AclHuK9qlma8-MwlzT3Kkwr34_PV2GGYQIzDc4ucsfN94285QF8ZXl_GiBTZe9U
Message-ID: <CALnzk4V6hjv5OPrKiq3epFZ7q_KkE13pz_z+_V_u64oT7jefJw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: check reset write error
To: Jonathan Cameron <jic23@kernel.org>
Cc: Carlos Casadiego via B4 Relay <devnull+cdcp206.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Olof Johansson <olof@lixom.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have not verified this on BMC150 hardware.

The datasheet documents the soft reset, but I could not find a guarantee
that the I2C write is acknowledged before the reset starts.

Given that, I agree that propagating this error could cause a regression,
so I think the patch should be dropped.

Thanks for pointing this out.


El vie, 25 sept 2026 a la(s) 11:26=E2=80=AFa.m., cdcp 206 (cdcp206@gmail.co=
m) escribi=C3=B3:
>
> I have not verified this on BMC150 hardware.
>
> The datasheet documents the soft reset, but I could not find a guarantee
> that the I2C write is acknowledged before the reset starts.
>
> Given that, I agree that propagating this error could cause a regression,
> so I think the patch should be dropped.
>
> Thanks for pointing this out.
>
>
>
> El jue, 24 sept 2026 a la(s) 10:05=E2=80=AFp.m., Jonathan Cameron (jic23@=
kernel.org) escribi=C3=B3:
>>
>> On Thu, 24 Sep 2026 09:48:45 -0500
>> Carlos Casadiego via B4 Relay <devnull+cdcp206.gmail.com@kernel.org> wro=
te:
>>
>> > From: Carlos Casadiego <cdcp206@gmail.com>
>> >
>> > The software reset is required to bring the device into a known
>> > state before reading the chip ID.
>> >
>> > Check the return value of regmap_write() and abort initialization if
>> > the reset command cannot be written.
>> >
>> > Fixes: 1c500840934a ("iio: accel: bmc150: reset chip at init time")
>> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> > Signed-off-by: Carlos Casadiego <cdcp206@gmail.com>
>>
>> Just to check: Was this verified against actual hardware?
>>
>> Quite a few devices get going on their resets before sending
>> acks on i2c which means you get an error on that particular
>> write.  That is often why you don't see an error check on this
>> particular operation.
>>
>>
>>
>>
>> > ---
>> > Changes in v2:
>> > - Remove the blank line in the tag block.
>> > - Add Srinivas Pandruvada's Acked-by.
>> > - Link to v1: https://patch.msgid.link/20260923-iio-bmc150-check-reset=
-error-v1-1-b8c1ebc4c947@gmail.com
>> > ---
>> >  drivers/iio/accel/bmc150-accel-core.c | 8 ++++++--
>> >  1 file changed, 6 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel=
/bmc150-accel-core.c
>> > index 46bb36d9366e..43a39e1ccce5 100644
>> > --- a/drivers/iio/accel/bmc150-accel-core.c
>> > +++ b/drivers/iio/accel/bmc150-accel-core.c
>> > @@ -1561,8 +1561,12 @@ static int bmc150_accel_chip_init(struct bmc150=
_accel_data *data)
>> >        * Reset chip to get it in a known good state. A delay of 1.8ms =
after
>> >        * reset is required according to the data sheets of supported c=
hips.
>> >        */
>> > -     regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
>> > -                  BMC150_ACCEL_RESET_VAL);
>> > +     ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_RESET,
>> > +                        BMC150_ACCEL_RESET_VAL);
>> > +     if (ret < 0) {
>> > +             dev_err(dev, "Error writing reset register\n");
>> > +             return ret;
>> > +     }
>> >       usleep_range(1800, 2500);
>> >
>> >       ret =3D regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID, &val=
);
>> >
>> > ---
>> > base-commit: d8c0f48f0b1583308a98401c0c7b1a65d1d43a6c
>> > change-id: 20260923-iio-bmc150-check-reset-error-389b096b0ad4
>> >
>> > Best regards,
>> > --
>> > Carlos Casadiego <cdcp206@gmail.com>
>> >
>> >
>>
