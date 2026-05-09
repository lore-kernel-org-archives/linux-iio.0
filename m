Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180593909A7
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778362622; cv=pass; b=OL8QiYe+iiIRbIqmmIM/QrdXgFnq7C49n6CnOAjaXDiNkbYxApaay56GNxB0F1GAyFW1fjhYsulZhUz/9yZZxWDyvFjK6YiRD/eWP6KC3gU/HdzTvi7JhTCqRzJOw6+V1ftiFg8vtu9Xgt+3P9AqUgd3Psh+Gb6qR7ZheIvZSqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778362622; c=relaxed/simple;
	bh=P7rveHkHO/MQ92nUfrmZUhNxNkdypjVUd1leBVSWhnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IL9fJlEyxlfUTxsLnQMi0DTP/AiNt+VVO7uw3D49duN51fpm0R+bFDjlWT6/q7cFfvTOwFloYt8GNBMth/qb8cefWHUO0r3eKBdgrNoEWqkuP91HO0VGbaVHu7cddB99bCLXj3MHe5KE4KEXvSBZl8OF94RvdVXKPuHSv2htwBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eozvfH5R; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eozvfH5R"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651bf695701so3240625d50.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 14:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778362620; cv=none;
        d=google.com; s=arc-20240605;
        b=WY0AcRc/wvxJQORlYjsBF/FrNA3M5+xaB4ZaXS0n6QvRyxnwHH+TbD/5MdWoSOOeDH
         uMxMUeOVBl0s/6WvGbyFJYFtfFmYY7nDWjW9NmOtjH6t+nLeEdsVU6EK6LS461sTohAS
         vM5BuVp5708/NJUaGd9COd6IEc4UKkAU5efma5MGv/QSE4ob1hn7v0xXiRWOu3g2gbZk
         kbDBBdaUCEeh0b6bWNei2qGEAhxvudrXKHq08I2cJr0pPKFahrUQvud4di2d06LzGf1I
         QfWZZhfyo9924xfYKfkKsjQ1uhDQdpp2wX2OT30i3T9RYkmmHyOpKhdA312ZYD2v/O/7
         53jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kag1p5g4kXp0YkQBBLnS/aW03Nb/QJeP2RB86IDJF00=;
        fh=g9x6rcfB12f5wHJfjNK5QadSILLTqSCSLgdG8VTAmAc=;
        b=PxA4s8BpnzpWGt11a4JXzEOf1PRVtFBiHX69D89eTZ9qALYX8CMpPf+s7wMVcxFPFK
         yKkGy/klHAFGiWD3rVKUpnuuZ4NgmRshvrOwsp46U07qaSNm/Z+7ig8n/QUiYRxU7feY
         8YQ6+rBI+PkmBTVb8DnlaVJiJJQ1r5V2XXCQjD66UrXkfcdfP0a6LTqwAVMClQ+wZZdu
         aOlISggimV5mx0fb1g4T349rTnpHi/sXkGqSdLe0N628jYZmVeUUJQvaXDjsF7u6eTs0
         kZQcrJ9VP09qU/mkvYATr31qHzYvLJBVwTF6TI+Oprqy9rIbE7d2p5YSeK4a2XWDNFWU
         MqgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778362620; x=1778967420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kag1p5g4kXp0YkQBBLnS/aW03Nb/QJeP2RB86IDJF00=;
        b=eozvfH5RiqKlCuLo8J68AZ6xL087Nkza7k+sVBqK5bkhXcng+MyRUyW6NHwob4qdMB
         NlwwpHdlCuBXTk8KmSzJ7JR+eCsXwGBvqnLGOHkEnfHdSur8+5aNSOL6reG6wXlsitBi
         0B9mI4grNcAos/s+9zViyT7nuE51OOUn3Phas4TFHrBAnWIejSOOnab9Ew+g+Zv2CLtz
         hkYr9ywfljYCrOKs+mWtekBz7fWxKo9fXzz0u+2kLLz04vy+DYMQ6uPTgMNppNKELaJq
         5QR1CUcSIISu4b/4a+CHzI+g508HzJdPhSwKDrXc452sqnp26/X2VYJVAl2imK2iq9V9
         3HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778362620; x=1778967420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kag1p5g4kXp0YkQBBLnS/aW03Nb/QJeP2RB86IDJF00=;
        b=jYnpys8MnPfT4u/HqoRGZsI7SN+2/ns8Tfl46oqPs4Z7k9KYi4R2GQwh48ey49P/eC
         PJC3tgwqDnHujVHSRqc4cjxt+dPAd3enovkUYiq5uaST/Qb9L+SDrD3+JzZIgJZKJgXg
         v+8TrmcvmHpMc4x7VW1Ul3NEVsE7n7LDJPP8XmmlVQMTpYr7Xi1lwXrytH+hftUvyxpG
         CnGZ4XrpopCojU7kSXeVAAO9DNUGmJ13cm+J59U22LRZqQ+glANmRNbx33rmHLN+31gV
         nX2rLfJo3xWCFMUBX9tqe7fqwn6czc1mC4eJbIVV9MAbrVv1UP08cHz6bG7akOhEMN8w
         WfNw==
X-Forwarded-Encrypted: i=1; AFNElJ9t5QYrTw2cHrsqfKqhyL5TrXEMazJBz8O5dgOVdxdU83rEx3gT1lmNj+kV+uhuU7cNHq6krtrn/Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhljAWG0HzaMKcuoB3Do6JgO6zFFRC1oYBMI+T/y2zItX/3WSv
	AyBMElKqo7do93Mb5FiY6TlxjofXwYDpdg5UUw+b0GPzegObzFWhgm2M6nZnwmtxxSIjwChSaM5
	eSyBdqBnACamr5+ClL1Dz+cFcEJ4Z8CA=
X-Gm-Gg: Acq92OFOifdBL3lHgkSF1NKvVecQOw7sVh8XxAXkPirtnctsaSseO4jVO5S7+iT/ilk
	JVczV7lskqEeYM9eBClyCplSsilAPoJD/H076yCYX446h6+u9f13RkHRn8Oym+Alf3YkNJUbmGd
	++Ug3D88N6zHD7m44agPNS7R778g7lQc4oersff1bJ3BO/irG5vmzU1AccfT+skb2+dbnxGDsJK
	o09DpbY97IpEA6x6IcG3DTWdG7oADax8lfCwlTcsalAJNOxjN26kPkJcJudoVVPmh+GLsuhwyne
	RwGx
X-Received: by 2002:a05:690e:1443:b0:654:f7f:bae0 with SMTP id
 956f58d0204a3-65c80afcfaemr16088235d50.33.1778362620050; Sat, 09 May 2026
 14:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509211921.84969-1-m32285159@gmail.com> <f7c6c9c6-c5d0-446a-bbbf-6991f6994375@baylibre.com>
In-Reply-To: <f7c6c9c6-c5d0-446a-bbbf-6991f6994375@baylibre.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sat, 9 May 2026 16:36:49 -0500
X-Gm-Features: AVHnY4IfsrnCsA6J_RUqxGmhN6mrmsTZg7CZD6Iq1D9TeBrZu0x5OaPOv5xUHWQ
Message-ID: <CAKqfh0GXzfUMhp0+-BPpQ3ra3H5jSKUU0g5RnAtKhP88RDocmQ@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: scd30: Prevent potential divide-by-zero error
To: David Lechner <dlechner@baylibre.com>
Cc: jic23@kernel.org, Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 4:25=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> On 5/9/26 4:19 PM, Maxwell Doose wrote:
> > In scd30_read_raw, the current value of tmp in the
> > IIO_CHAN_INFO_SAMP_FREQ case is unchecked. Add checking to see if the
> > value we got was 0 to prevent a divide-by-zero error.
> >
> > Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> > ---
> >  drivers/iio/chemical/scd30_core.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/s=
cd30_core.c
> > index be8c055be184..3e2bb6f4e42c 100644
> > --- a/drivers/iio/chemical/scd30_core.c
> > +++ b/drivers/iio/chemical/scd30_core.c
> > @@ -237,6 +237,13 @@ static int scd30_read_raw(struct iio_dev *indio_de=
v, struct iio_chan_spec const
> >               if (ret)
> >                       return ret;
> >
> > +             /* Likely only taken if something really strange happens =
*/
>
> Instead of saying "strange" I would mention a possible hardware failure
> to justify the EIO return. I'm assuming this is reading the value over
> SPI or I2C?
>

Yes, we're reading over either SPI or I2C, the sensor supports both.
Hardware failure is going to be the most likely cause of this path
being taken, but I could also see some sort of noise on the bus being
the cause. Perhaps we change it to:

/* Likely taken if hardware is failing or noise on bus */

best regards,
max
