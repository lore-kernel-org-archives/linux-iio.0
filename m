Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794559300;
	b=vxT4wFANXE/6wveLqybdL/lZ/u6VXOQra2/2LelLSi4XVbF8MYubpc7e8lKsJXrPOYIc
	 iGtHiDKcBwV+fJLh0l3HN5jSESTuRhRw7+pJhv/BHMaZIrgkR/9C/1Wx/pvFX6WxdjsD6
	 jYDDHqmHDHztSauM+VO5uVytS/I02ZgOsoGMUZYGpryAgdWu8Tec23NXYfZEouronHBbX
	 +09VnlRVHshUajI6gs3vQmk/FJt1TL/Dl93VvzIakOurQfjL4q1v4UOSu+3bgXku4RVeh
	 /0/2jovym/4Hjz/md7LrmIpMovkgugjHJWqgBR0MYWAWJtgdTLOG/YibC6C8nGH9Upg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Wd0IqbdzMVGbW4Cv9X/8BHQcGew4KeP8LilkGkVj9Sg=;
	b=g5sSn4HWliyY5h6J0lKIOCJz3MQV8BrmaetiET1h17ykqZ6tzQJEZ3HQ3zI7mqtadpO+
	 d6HEpq6f7r/PEp7kqXaO2pINrH/jPktZLq2qDlmaqF7QkjCDLS64Khws1FCHNNmfcUKYE
	 hAr5iDZcgel1oWkEXIxONjJeFvFeUQ2fOIPvYLQIBwxJq5atlHN++O9bKjqzb9zj9vHMq
	 ZKWl+FiAyTpBzpB8AFr2liQHS6/HywxgfbMvwbGC5+u51qhmOarjxEQ/eRKM6ydKgxet7
	 CvqxZJPW+0/TqaqofluUl7FSknLo6q4Or6ZYtjYy5C4ZN/Fk/Cyg1fbxa04390ZHMSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jCLIKd5D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE5606A897
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 08:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80EE5606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jCLIKd5D
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b3402105b9so6058817b3.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 00:41:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794559299; cv=none;
        d=google.com; s=arc-20260327;
        b=MFVlGCkK9+tKxIU5rZKx85Gk7uSKv42YWPhGQyqkD5+6AD7ckHoHyHGGsJVnXBPor2
         xMu3c8wijKpUyS05MTBkjVwij9ZIVr1JKgvu0Pz1dmm4v6Sd/hlqj7v5CKAJqSsAGBDm
         b+1/7cMcgDQpb6kYQyA3Fuq5uFkFSfqWhZ3WR2zWKOPE85G9ABxgZ/id0HPaI42/0sXP
         BmtfbSgydGbL4D8QU5Xh2fek15jAUGnpo916+8Hagm17RxvGAetME+jU39CW5L/G0cgc
         VxCtq5UeVy4Qe13zwTW2ngGEsq2T30drJVCJTqN3fyqSCbbayHTLSyRuB9ozkawDsorD
         T9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wd0IqbdzMVGbW4Cv9X/8BHQcGew4KeP8LilkGkVj9Sg=;
        fh=s8U+66IHMNYrMlpF1I0YrMOlrTxdUcAYcBnlyhW7/Ug=;
        b=b+CMvZWTLIO7Ae0Uzj3JxOlQ0pQ/1o7SPQX06kdKnU91tdSivJfmwoOE4VjJCjUpQs
         8b2g1ZTZ5Mhk6h7ieLSpTpRaJU6vChynMxqxfd1GWeVxuJ9JbNOLRyCDaNRptUDxuYRu
         j/+hPYFb6USUmkwvrbReA+ZqrwLa8t7m7SgUe1abVglbNephSdbwpFD+dYK0phl1qJzc
         BCbOisnWPpXpglZP7hsND7VnHtqakoa/xhu+BrFHhsefsht6/SXRLTaFJGfXpY9g7fB7
         7R69FapB+BLUkarPAl0J7SLO+AQDxSASHQlNkFpxidZAtp2VH/fMSrdQVuXCszBBmJjX
         Hb9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559299; x=1795164099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wd0IqbdzMVGbW4Cv9X/8BHQcGew4KeP8LilkGkVj9Sg=;
        b=jCLIKd5D6I3EwIEB+X/90+AoVDHX1PQjWfFDVSM6zeCrHsshbbHkEGIUmV1Ih8LmEB
         We+Ma3bCbQeSXig8Czb4BQGw9fRaH/K4GFQ98Op00ZvstvjGTunUBqOSnR6IrRsFQACn
         /y6xcnmek78TX1xKtyUwynUw3iwVgKqv8xXxQFreK/bpVKdzEI3P5SKC9TdfgRVUzEpk
         NuaYOK5mszsuZPTuLruCwbOtV91ykbCTthn7/nteUITBC6XKxUUH7buXtwBeHxqUu5a1
         dHNEe3MYkWmR+S/LRrpfjTk6jbUZm6Wb47Gw9eaJV7wHIzT4+tz8QID0X9fQ2hxsfpMA
         17hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559299; x=1795164099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wd0IqbdzMVGbW4Cv9X/8BHQcGew4KeP8LilkGkVj9Sg=;
        b=11LoTXCiHAstYd9qFwTngCXw3I91E0bq7HgCewKgg1j66dq0pW9MZjz9jZwB3qbUsd
         6zIQTldEE3lAslDeOMwNC3IOi2vULCJSOFA+gGDn+c8yg/mRW4RqVGk6HLSq1K+GuJf7
         pEbUJvcYpcQgDN988NnLVQooGgRgXnU6BBra8ZTj+9ovaICbHNlRegnH7ML0jPdTpdJr
         gpKafljrOPbi2BZ4li3ZjBc6MN3lk1SgeeqK74zO9MTkIoWmncs3rskSJ70STVzP2ek+
         PaE13MccgdCvz//bpWse6CqGnCtnXkscvkLp+V4cuEU31PCWpit/4c+CFQo6OYKQDZ5e
         POOQ==
X-Forwarded-Encrypted: i=1; AL+hErE8hhzJbqvwXKLt/DDWHD4sMZJQsom5fXjg93TKhErCtSAldQVcSp5+VbDolUcbMbvhNMAg0LfdOLA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oM+Ny7KRBvEAdqF5s2dyi1mOJui+Xgnl8eEPTLtpBjH3OFHRm
	Lrw4tfe+0IUmSP/bGZ2UtpOk2YMHw+QMQJplJRsOzLJdrf2apXIMBEixQQZ+BEnomTVlgv+GS5Q
	JQHD6aOGMeAZCwVaMbP8gQmYyIsOm41Y=
X-Gm-Gg: AYBFou2Tus37SbtUT+CQ4mkL0NKCpS5zOPZHg9FG4/a2EgsQ01eEiUGq3dBBM2Im1fz
	2XKIpPmY7lrQ3DKJogbjPxOx5twOilDTktAEYajGiOg1CbVKNwBQ2l6eimHwsNCI0jKCcmIUopB
	fQevb/Aebjlnaf9NXXpUQeLcrtq3sDiJMOkYoMM4sKHmprKkxse5+8ZUKW3x7siYWsuR4TuClA7
	K4RxORXoJSiT9BnaIn+HXUbn/E4ahcGYgEeC/NviuByXQmdhVOhBbFmYa/xnVUyPlKEWvQb0KNr
	8tpYA4S/2fB6D+l8vHALDxpA7mcbAfW1wYW9R5UqKCQqtVb99VSGgbiSAH7FKhozDs5JgBAVseE
	njgXnKJDWFBOhBm112GphVFCRnSvNirg0egiLdQoK5bkBfFXawITfefZNimEPoJ5i5QhjX8jQ67
	ppeyuf1uN2dDZB/p4z6zbAgqZzoWh/crahTufBUeLDc8HQP8ukfGKcQHnwk5Pl/Cp8atWrB8puJ
	j82kM2wg4H9XL8tsDNfcgrERkjF3GGHKtN86PWdM6NQG9k4XSSm0Ufsg8iFgA==
X-Received: by 2002:a05:690c:e20c:20b0:8b1:86ae:9006 with SMTP id
 00721157ae682-8b4aa360702mr7180297b3.89.1794559299407; Fri, 13 Nov 2026
 00:41:39 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113082546.176582-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20261113082546.176582-1-zhujun2@cmss.chinamobile.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Nov 2026 10:41:02 +0200
X-Gm-Features: AclHuK-CGa8WOMkBb1Qpf8ygg13eYkgeuepypb3hDt2OnjdY0mSX6Vxr9tc94VQ
Message-ID: <CAHp75VeOjqWoEM36OMgtiiwu3XWiu5wfJf59vYFuGSApbWpPaA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: potentiostat: lmp91000: Handle configuration
 write errors
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 10:25=E2=80=AFAM Zhu Jun <zhujun2@cmss.chinamobile.=
com> wrote:
>
> lmp91000_read_config() ignores errors when unlocking and programming
> the TIA and reference registers. Probe can then succeed even though
> the hardware configuration does not match the parameters used to
> interpret measurements.
>
> Check the configuration writes and return the first error. After a
> successful unlock, attempt to restore write protection even if a
> configuration write fails. Return a relock error when both configuration
> writes succeeded.
>
> lmp91000_probe() returns either error before registering the IIO device,
> so the caller does not need to distinguish their source. Preserve the
> configuration error if restoring write protection also fails.

...

> Changes in v3:
> - Declare the loop counter separately from the return code (Andy Shevchen=
ko).

Now this makes no sense as you haven't added any new variable.

> - Explain how probe handles configuration and relock failures.

> -       regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
> -       regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
> -       regmap_write(data->regmap, LMP91000_REG_REFCN,
> -                    LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50_Z=
ERO);
> +       ret =3D regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
> +       if (ret)
> +               goto relock;
> +
> +       ret =3D regmap_write(data->regmap, LMP91000_REG_REFCN,
> +                          LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFC=
N_50_ZERO);
> +       if (ret)
> +               goto relock;
> +
> +       return regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
> +
> +relock:
>         regmap_write(data->regmap, LMP91000_REG_LOCK, 1);

What's the point of duplicating this?
Before label you can easily do

  ret =3D 0;

relock:
  ...

>
> -       return 0;
> +       return ret;
>  }

--=20
With Best Regards,
Andy Shevchenko
