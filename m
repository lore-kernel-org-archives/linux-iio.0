Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794559690;
	b=KAWVcFWxVjqpxIK2PYAWd2mmEt7DPGw2R1mOZ2dFr0raGyTns/XuJpDCosrmgyMHMos3
	 1iZJcqki/bx48S6ELEQi6zDITDS9vl5sScYUyYb1wveTasgdzjc9MRaxBEBemtz8UhTn+
	 WPrpBSCPWX72AzqZBKol89rmHWM9EWPMERpG1E59gNraZKfhKK0Dl+k7aEcAb6jx7ZcsR
	 HxW30iKDac3kKqIa2WpZHghXsSMMHy+LCFqHBCyYY5/P/TqpEukEU3jiGlqZvL5CT/+TU
	 kNDmBLE4upLiWq9gK3TUUUU9uDCZ+5Tim9U40Sd/hMe+oBsjyWMB6Sq5rVNlWVXufQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Sb4C2w/d5w6+ocGzHVnaU8bpcCXtQ0zPQIONnx/cfo8=;
	b=CHXy+Z8SvbeVgYXt+lNp/GSSs4apbPHxQyo/IS0bIngp2qLss0cnCczlHatysgRU+2T5
	 4Yi6wvhVa0C+uWXZFlqSIdFtEjKtBoFTQgpXwIPDUWAMpsNyt0IQ+yFlX4qWFH5sZT9Ri
	 6iQnDPVmCRTdmpt+87lWUm83KuhI0VoD7oNDMwNtKNeV4+4Yj1FvOk/Dc+2GWDDGbIbAK
	 7QOrS8jG6D8IogQWiAGjrJaJqQ6P4m4fCiVE6BVDkpBVBZkxtavreQPYPJk8WZRCUHJ9H
	 vDsTUMpO6mZHvpf+jUFUtI57cQbYiHnq1nsz8KzQk1IkFKVQf6oiUrtkptPh9Ya9kFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QSZlkHq+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4F606CB3B
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 08:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1A4F606CB3B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QSZlkHq+
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-675617e81f9so635902d50.3
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 00:48:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794559689; cv=none;
        d=google.com; s=arc-20260327;
        b=SQJVS5GS/uDOZCwggA2Vq7fqoc5IMl3ZNC7aTkctvUSQ4CNSiJS/EmgyFDevpBScXE
         +QZoD75muhRsEDEKGRBumUVa30r+b5t8Sb8d0miPn5KALTNXVii13h/SSUHMgGuL/woQ
         6qWt5jR8foJAIl4Gmbr5okpI+3hFoY/yXpLw0A9mQpDJZZ5CPpSaAKTmU17YT55mNW25
         CZ5ODafWUIqve/p2k7HT55c3zP8s0XZlc03PfQ7BpmErNFb+LdohzxfBgj+47gAUVeEP
         GhB1jIjdVFfE9fqIJRmvswVCRqumJ33/BpMtTAv4syBQnYg7aLiyPTnbNubQcSmDf3yA
         Jj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sb4C2w/d5w6+ocGzHVnaU8bpcCXtQ0zPQIONnx/cfo8=;
        fh=ITQ1lUCCNujcn0t4txOznAap8m8/YDm6yQXxA6Utcro=;
        b=Ft6NlDE/OjJLsBT+vRdRgCz+wtSI9f8Iy6wVkLQBFzIuxzTjT76lDmv00ayySRT+q3
         Zj1Yl4nI7ncF3pKdRvES6+k3q0W9OPPGrsmqpdNK75NpJpXdvNERtZtFviB401RWYEpU
         KCcbCnxpwnrSNre+QZ5/nVQ32XkmBsmKkra8Mfnw61TzWy0UJWiwiHKIgyQar2WTuCD8
         gCGSpLWcreMdcomZyLiZr75Zyl70p3ixwDY5+xmtgkrXr/P5yPEtBjnkBINbTEwhlEXV
         KeiV9h8oSEHzP9/qKFOCriDRk6xrlWkwg/Y+j5Qz2fJnPMOSxPBYdovys4UPk5qKxWnX
         YySw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559689; x=1795164489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sb4C2w/d5w6+ocGzHVnaU8bpcCXtQ0zPQIONnx/cfo8=;
        b=QSZlkHq+cmszNgUi7FcavufnIwocDZOFiFULftEhiI2WI5o8l0XNNv2JA9f7ikENig
         M4VUV4Pn8ONiz52MKMdn//q0tre9wN5Olo5ZPdpCqt3tNXa+W5oSpH5dyue0D5wUVffv
         hVqAxRW0RrWGJcgrTWsV+gyzqcPapFKQTa7Jibcih4pcg3mItoSOGxVce1wmIfmCVNko
         szZOKA4dVpwlC7M7ckSnTzFwB+nKkBtyVXDjHIhY2+rySyJfsIO4PBb/v8cqPmU4LwJQ
         /YyHy5JP5bZceFKfXrcCyaBx4iDcQUQTSAprwE6PMJZSdYhzPGNb1wzJRCh+BVTzTSHJ
         w4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559689; x=1795164489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sb4C2w/d5w6+ocGzHVnaU8bpcCXtQ0zPQIONnx/cfo8=;
        b=OLNTRdhFum5ZE4OOHGTTIiFxTmQRWXfklrtpwkXcE7/GZ119zbHYMqG7zvnqTk8LnS
         PzZAUt5LbqRXPeRKKyH3km8mjqCQ0Q/cLp9BEJ2Y143jLpcvfO4YD43EsESJK5Ls+G25
         nPE6PhN6Y6f+c8Btdzq8khYNbxfkxr122qsbrMztOazaWbOixnl9912GWJFFf+oTjAMV
         7Nr+meHfxnZfW6skpv+Z9vaHCW+PzvUgrVyN6bFfBBFj5H4ZvQXW0hjDSaiq9OhWqAI2
         6VjtujLGkKVAmFTpQrykedPfHZDAHpsnUw4hz8E5fy/UWoi7L18CnUhoMxBMPoMwHeA0
         Es3g==
X-Forwarded-Encrypted: i=1; AL+hErHxSMikNVg+TRnt48hQBZfJP7vtyIVhJA41SxcY+EMVCSFNSM6JdfW6oV8tTJQ1tYqkGULg4sV3BzE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FfhK3LkIcJcpybNOubLdxqp/HwNQKBv86A9+EJ7PPccHCdCke
	lKlW26+166HpzqarZOxHPOp5Ew/uee/9+kkwQhwbP+Gdblewk2UYfPKe4CTvedQ64zY7z3I9Eny
	YkXOZFx/q6yXx4kPcy3V7cyUt48izDXo=
X-Gm-Gg: AYBFou0aAepyYXk+6ZYB164e8I6BeoUiYxsMuX1GKRw5qMGIynBn/v4iwLU+0hFPWKn
	YnJxRU3jKcUeyOANDp1KN279XWHkyj7mhK3iyiaXGyAbiPIt/UWk/fjLMGYg2+xy6I/WRydyDFC
	9NGWkrWZfY+8qEY9HqpI2ylSHxbyhKxFI/9DCksKR6L3YZKNt+JKBteDn/IglOql0fBPLvand9/
	woq+XkUslKaS7NXhug2sfTYzSEcLy0yUuiRfUPXa/sgGDrTKmmFdHNwXlJczeHWnHuFVN00TCRt
	fXa8zBkzo8x/z7LXwcCQu7NIVUqh8FajPxPXLmpCQ93a7Krb3heEu6yEIKF488IE6n0nYplbpfy
	/mcPRamcjzCNv5aE+c0ai3VhhvZN3HJCzGVFMq1DatGlpMEMbAvfafeCsuaAEaH2TavxBrbx5u/
	q2hrTZl1d+xGpe1Oi7Y/qjevvAuS5khm/YqnTOO6DpXooBikUqS0vPXy82hm+iSqEHPFzw3hlU3
	SIWjstZ9HgNeIH78UnHfT3OhEAR3U3RQwKj77mTYIiiNhqXs9HwXl4L0ozGDAO0y+K47kFif9/o
	5SpW7Sg=
X-Received: by 2002:a53:d682:0:b0:67c:1d73:fd3d with SMTP id
 956f58d0204a3-67d897d5059mr810181d50.108.1794559689013; Fri, 13 Nov 2026
 00:48:09 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113082546.176582-1-zhujun2@cmss.chinamobile.com> <CAHp75VeOjqWoEM36OMgtiiwu3XWiu5wfJf59vYFuGSApbWpPaA@mail.gmail.com>
In-Reply-To: <CAHp75VeOjqWoEM36OMgtiiwu3XWiu5wfJf59vYFuGSApbWpPaA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Nov 2026 10:47:32 +0200
X-Gm-Features: AclHuK9rjEqJxLRL5SgQJUJktkIm-qEWvtfM6EjpPfAvf3U0-d31BCeAdrVtQ3o
Message-ID: <CAHp75Vfy97JHMaURigbF92z7Eypfuny8PUk94=-43S6p6PhknQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: potentiostat: lmp91000: Handle configuration
 write errors
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 10:41=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Nov 13, 2026 at 10:25=E2=80=AFAM Zhu Jun <zhujun2@cmss.chinamobil=
e.com> wrote:

...

> > Check the configuration writes and return the first error. After a
> > successful unlock, attempt to restore write protection even if a
> > configuration write fails. Return a relock error when both configuratio=
n
> > writes succeeded.
> >
> > lmp91000_probe() returns either error before registering the IIO device=
,
> > so the caller does not need to distinguish their source. Preserve the
> > configuration error if restoring write protection also fails.

Btw, this is still unclear. See below.

...

> > -       regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
> > -       regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
> > -       regmap_write(data->regmap, LMP91000_REG_REFCN,
> > -                    LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50=
_ZERO);
> > +       ret =3D regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
> > +       if (ret)
> > +               goto relock;
> > +
> > +       ret =3D regmap_write(data->regmap, LMP91000_REG_REFCN,
> > +                          LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_RE=
FCN_50_ZERO);
> > +       if (ret)
> > +               goto relock;
> > +
> > +       return regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
> > +
> > +relock:
> >         regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
>
> What's the point of duplicating this?
> Before label you can easily do
>
>   ret =3D 0;
>
> relock:
>   ...

Ah, okay, I see that the relock error is returned only on success of
the configuration update. Why is this inconsistency? Really, you need
to elaborate first on what the caller is suppose to do when
1) unlock failed;
2) unlock was successful, but configuration was failed;
3) unlock and configuration was successful, but relock failed.

In all of these cases the user gets an error, but it doesn't know
which stage was failed. What is the caller supposed to do?

No need to send a new patch, let's keep discussion here to understand
the code flow better.

> > -       return 0;
> > +       return ret;
> >  }


--=20
With Best Regards,
Andy Shevchenko
