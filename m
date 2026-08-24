Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41E36492A
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547267; cv=pass; b=pmOFTKhKiNDOIcQiqRNnngWPN4DOLDSlc2D07aJ770LCZMLXH04gOn8/lZ//dzlW/YbhRe55ZFea14j0qdcDFX/XV7Roen3sIJ8HC/iaMovq8HLbIF4WVWhIxUkWEjW5iT38Q27Rw6BMRnKAjW8TepVgeBNXs/3xX+7NKyXUZeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547267; c=relaxed/simple;
	bh=Bcnn8Vmty/GcGctEE1P8q+rqVlrltOSbbpnc4q4ZUow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nA7TSsupzvGKkv+QaR3CNkzWvVLrINgKJePjsf1Vd+b8UBnQuSTnMh9oTtqrezq0KvRNgumFwOTxqPkdb8jhU4aYl6Ji7+gmYkr6Ez0L7OmYhaTgvPNh8rjPZS0ygeXXYluilx1Mdt9xNelfLWxPGkCB4RJXq6wxK3rXeNxJLLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+taexyY; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+taexyY"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66c7e3a2332so1925184d50.2
        for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 21:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787547265; cv=none;
        d=google.com; s=arc-20260327;
        b=aLNYy+J3+elEb4dgr8QXi7cf98AujMsO7/pLm8daSEpcg0L5qyiauBlHIF2+GENyU2
         Srmgkm0xRKbA7ghvauK4aEKGRz4Pe2XNvDb5BMW6YDMZDHF/Bota1mpDGH34QDVom4Hh
         OjovAhx57oQviI5cRxocC6Xz8FQvBG5raonT0iv9MzwRypvr7PtD1fwmb4RtxEhvAoFc
         GUgxhVxX4Ywr1xX2scOZcgRHm/zZU7vNYkOQVfJ3u5CpXwrkeOJL86WjuhXq2k4Oqvd5
         K2Lw4weLsPZevM0hKH63aL1JjoBfZdTTSXc7b8VWSynIbSy/KG3WQ+Nn21xuZ4t2B7T5
         7lFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r4VU3Zu1fSpYqSGxLy8G29EIP/30+UoepZnhZkdQQu8=;
        fh=CsK5EW8G0hbVxH30SZRhI+OdZ1LkPEcTisKHf1V5GsA=;
        b=eUDBk6Iok1ds4QJ4/m2ow2o4dM3nRuChs49UDOK5GBNZHQInKbY7M/HiZ4I2HdOWb6
         OMTkbsGP76Eoce5jGv0WJEkzu1bHq7vb1jrkO9GfrmJ2LcDIX/w7fama0nSOfbMLCHUe
         B27bzHAS+7wlSaqPyTvgTXeiFLkEUY867jQiLa8C2jFCbyenrNYYrmBn1H2Nz2ugmpID
         kHCt33WgQ/l0X0/OVPIML6ESHc4DkcntlV35ete/2wiOvT5Ityh+Ho5h12dQ5v1Y07k3
         mpEPllRI58pAL7qRp46lhYunq645OqLQ0M9K0nzVxngZcgTnBoI8dn+ki2V0OdCnTDjn
         A2SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787547265; x=1788152065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r4VU3Zu1fSpYqSGxLy8G29EIP/30+UoepZnhZkdQQu8=;
        b=i+taexyY7EbvTkTikYwDQrOCa5NjjehO6GGILAGdNKBsuAgEUsQMrvI5TzZoVPsbAd
         4MS3aGe5fJq9E5H7ZUEN6gs25H85c3JaOwnUv42uFdHQxqj7E/FfC16SmunfYBHjLypk
         1yFjY2t9IRmBfQayMy0CRvZ6xVM2uBUGnMlyvC4eSyTl8jfnGfJ8TvGjZaYoexttgX1n
         RZHoL+EJQ037oquhsmrY3YYu76cECjaOMj5T1NBp9N/R3af9YN5qxM2gPenOkOQ8/7pf
         7iD8HlBVTfriBgyd93iAhJSFIzxixmlAkq9TrN6d+OXd0gO1sgFOei4ozmsyDS7PZfuK
         AJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787547265; x=1788152065;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r4VU3Zu1fSpYqSGxLy8G29EIP/30+UoepZnhZkdQQu8=;
        b=Jhq4Nv+DTAdPHQBlr1k5lXJS+RXPbGd8L9D5Ya184CL2ITecrDk036a1r/HoFAlm7y
         e6p32fcKYMjIzPda19Yvx8IJ+qZ/Z1Z6ZW8vBuaKvzuZ9pTptt6SsdoVfHdhsUwH1KkK
         iQSDd9N9M+t/QySIMvhPI2vgxuttWl9lUWg2/+eGQWsaagj2kOgKmkix2fW00O4cxa0X
         XrRo4JS9qGjWdZxS6hOcY6rGACabJk6ny+RDxLyFd9eUAp3nAdnB3xqiYw08BBCvWUho
         NrJCQRWcaqxyXCr6TY9SfTxeKyADpQZQyoJ9wv6NTfLnuqBaDp4xfoWCwxT1GKyJ/ovx
         VZ+w==
X-Forwarded-Encrypted: i=1; AHgh+RoEmse3uLTYsm02V8zacgiYY8v8pO/tfDKIp1N2NgPaYkk7Z5BQvpsHZ6LM5XUlcudpu8uSVvjSu18=@vger.kernel.org
X-Gm-Message-State: AFuF++kdEafaUV8o3wCYq6oNC9sEWtpUnD/uDhwSQJ8ZEfI9esSqum7E
	1OAZMb3cid6n12jQrTLU+EL1/W0YhKC8OSNAzn4yguI6zxv85m90/fPdIvgCpdV7j9NC0ZR2meN
	ghLoBLk3TAnX0hU/d1IwDbKMuU5VaWrg=
X-Gm-Gg: AR+sD12g/0NIADUrn//Olo8tOYpuZTqkYj2M7cMktxJk0iS+wb6iSXqoykjU4WawOQc
	avR+C4kFxQ7co4P2sXg03eU6HrHhpaUvIMjHzZa/K40FlPuIcSO0Qithecb+xCP0W/p1TNw0oXZ
	FbuK686jKNTGS2IzgK5MOWvq3GlRSWgDsNwLWalrNm1mbJdhlhZ6QpWP9AW0FYmnUR2i+vgJHk6
	q0c41Zk0q79PoyCdvBqHL/YxR4vjo/MB77CoRQUi/tHYVsFk4uIResdGBLOVxe854mSR1rL69hL
	q0fx+c3RP1T3Wt4NWDFDUyYMZiZbxXg5uXfA2kkO+GYYItdP4CH5CmwVgfXjm+NWEm7uapZeaPT
	j4lG/w7IALAuYrkl5jm+HTvgjkPul20Cf4oo=
X-Received: by 2002:a05:690e:13ca:b0:66d:9e5:5949 with SMTP id
 956f58d0204a3-66d09e559dbmr709349d50.49.1787547264677; Sun, 23 Aug 2026
 21:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812164433.23011-1-architanant5@gmail.com>
 <20260812164433.23011-3-architanant5@gmail.com> <an2FkBoJNRCaeAkk@ashevche-desk.local>
 <20260822013823.28b0a1e1@jic23-huawei>
In-Reply-To: <20260822013823.28b0a1e1@jic23-huawei>
From: Archit Anant <architanant5@gmail.com>
Date: Mon, 24 Aug 2026 10:24:13 +0530
X-Gm-Features: AcwNN1Wii8pRmgEIacw3ovA1EX2GE8dAzpYk9wmvZdWIzbnhxwJ7SV1LKfhJbsk
Message-ID: <CADJHxWB-NkBE62aviCNA3O+d_RcO=fecvenxa1K+3cEpH5MpeA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] iio: adc: ti-ads1015: fix PM leak on probe failure
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dlechner@baylibre.com, andy@kernel.org, 
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 6:08=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 13 Aug 2026 11:51:28 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> > On Wed, Aug 12, 2026 at 10:14:27PM +0530, Archit Anant wrote:
> > > If iio_device_register() fails during probe(), the runtime PM
> > > subsystem is left enabled. This leads to a resource leak upon failure=
.
> > >
> > > Add the missing pm_runtime_disable() and pm_runtime_set_suspended()
> > > calls to the probe() error path to ensure proper cleanup.
> >
> > > Reported-by: Jonathan Cameron <jic23@kernel.org>
> >
> > Was it public email?
> >
> > > Link: https://lore.kernel.org/linux-iio/20260718225515.7e49a458@jic23=
-huawei/
> >
> > Ah, this should be Closes: tag instead of Link.
> >
>
> I never checked but this is already fixed in the iio tree and
> the relevant devm rework done.  :(  So much going on at the moment
> in IIO I didn't recall this one at all!
>
> https://lore.kernel.org/all/20260529183708.17819-1-sozdayvek@gmail.com/
>
> Please rebase the remainder of the series.

Oh, I missed that as well, nvm. I'll rebase the rest!

--=20
Sincerely,
Archit Anant
