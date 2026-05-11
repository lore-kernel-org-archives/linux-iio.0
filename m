Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C7F26FDBF
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509687; cv=pass; b=NvOwyt/lyPJdugjtKIplDqix8t0T7JEtYIoZKlZ9fXNma2Ya6qRaSxMk3vGXo9rtaFOwyF/fajVUfQNoulzE0O3CO6rqc7hpAj1U2XVbUAwUq5fGOF24a9bK7VKGHgCMSVUU0auFKsMbg7G01x19ZZuyaxMm1oOZ+fF5JH7XDA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509687; c=relaxed/simple;
	bh=RG7Q1Po8OZw9+TLT5AnonHQR9KkSwHV+3nrdqdAJiTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHj9ANEIjrBCT1VXczNkYPq/ZoL2fVJnNFZ4DDN8VaWD1FGr1muGOpK5Z39Q9wiPcEi6mkzAHV0BN8mApn94yV644C7N0iG8eF48FACS4mK7U4baG5yjoCYxwHJFsTYHl46P+xF4huKPP//RnXqDzm+Q97L6tLe228nbBr9BGB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=res0KtaL; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="res0KtaL"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7bdf83185bbso44095547b3.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 07:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778509685; cv=none;
        d=google.com; s=arc-20240605;
        b=Olri+egoBJHVKRyoPDHx3sTHbe0TSGSC4XGoczWzbg7dbu3FzsPPd3paGh+tvBinia
         0EVIY6bJiP3yP3VQtxYvcCgTvCASNl5A5AIAUz4Z5WZlymSfzcXhSQozqdbbVi36OjhV
         GRRW5DJ3cQleHfKevLFEzvqWUasrVbDxReIfZmUOdL9NFub3moJmWjZ8VZXHHEm6hS8E
         NIupK5DfgU5kJhY48uzXv14bQcGXKgAsgvyaob7j2/tb+JfXnSe5TIMOadmtPkjtrsOG
         /yPGEt5FcOcfooC6h+PE7NbeB8+GoPF9jqbqA7OOtKcfuxA4wMkWzDVq7dOyaxAE9GX1
         k60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RG7Q1Po8OZw9+TLT5AnonHQR9KkSwHV+3nrdqdAJiTg=;
        fh=OUD5XRvnNDMZQz1Q6YuiCxNisS0pF8HsG4NtmXQ/NtM=;
        b=WYa2Ky4uNqEeWMQshVcsgSENxLWG1CPpYv5afC/dcTQLVmaQChIFSZjyP23qUDzPLg
         u3XjajboqnIF/e2iBvX+n+g8AIKdiPQpq3pN6cHQ/u1ykbZVPjTjyaULLgXX4buvJ1d8
         DQ1W71uFw2uAtQ5u8R3F6LWWRPzEoudfknzxZtgKPTIdNfufa/A2eozqBrjCzbwsvpD8
         WO38HVDJEL6Bdx/+0L/3Sl39RYlrB2T4HVjN/1RtOHfWEMtI6vqc+oDUU74pvd21rbtz
         dbkghlHwr1IwDFTA0hdD1Qeq6ZOflaBkLXM5J7Pci9uG/llz8kAOTtVUZvs7+jlk41q9
         OAqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778509685; x=1779114485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RG7Q1Po8OZw9+TLT5AnonHQR9KkSwHV+3nrdqdAJiTg=;
        b=res0KtaLuT88f4TIeOM+01Y46r2EMqGfqx7+4aOVcYE1K/Ok2zW9rnIgekd2hL1wzl
         GN2oIXQKaBfK+f11mpUnzmaPIke3bCpzJpz+vAKYqPlYZ9GE6OvgR54rCL0sUQizMSmB
         GeNlj3dpELVhaDf2+Fs8FapyB73s2g0XH/MTPRQdH2+9Nq9FYTry/4jDQ9tDg05+wIvR
         tv62WBZL/KGfpG+zlf0RCEF7f/FjvViTr26AG1CVD47NHJ3Nug0UpHaCz0ZcLYUy/E9y
         ls9BNDsX++epO6wCzyyNODcgrON3uMVnbEjb4nz9c1BsoRD021hxqyduWFvc8zKCzrJg
         HoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778509685; x=1779114485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RG7Q1Po8OZw9+TLT5AnonHQR9KkSwHV+3nrdqdAJiTg=;
        b=InTxGyYJ0MQ0jkB3g9MJkUyBaf+T91zKqvsad5UnGpUJajsZnFLKH/4e+2kd4nk5t3
         Pp9Nr1ylPVvIugUz2vjASuuwMA0NHtUef3Iq7Uj+oTICIO9Orlbti8PhPNGO6IUwjTlE
         C+SPiv3sLjHoGajkH4rFAKRfQ3SdEy7J/HICG9bPk1vCL1oJsmLfuYAYmKFPDWhAbpG8
         J5C6WDWoeAaEQSVWMZmiabRel+D2TpEshJSbBx3HzfJq9rEVJY2nuBJ0xW0dIWpfByFn
         8LUTxQlT2mCmGWsO5LVC/pCS3FU+DI8PEot32+tIYmzlkLC8qKgabVBPEJCqRngk0wjq
         CMjA==
X-Forwarded-Encrypted: i=1; AFNElJ/lUp3cnnpGUDftcW7J5qitCanDSYyveGMPN4ml7fwuCjgSDriKNKHEPiBL2nPujQjJHY5F1Utahac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAkQriD1ZH5Zrpoxm6M5UscK5uDksD2rFhcxoR3m5EQMKd5ZDt
	HROpLt3iv00Dl8dJrebE6N1xF29S298uMV08NFr5sVik7/iDINlpCR0Z0MlGkWPCdrrNgqWZ8e2
	Dac9lZi4uGuCd4f+l9RR0bTLLPXmUOao=
X-Gm-Gg: Acq92OHVMHQzABR1JnDmXMRSHlrl1EkjkF7AjsuF8yI1m+QXxUx/wjkidjxeZ86YJ4b
	FiJf3iraHFWro9LQ1frwO7RAfyG9Niu7jkevHMpZXpS31veSdh2H0erVC+O8c8V4EsJrxCobudL
	nD3a4qE8TrmD+aSrbibYAX/u67+3TOaRUjHoYbkG6778OD47k0byRiC1o/cZnk2F80nkVzMDwJJ
	8/GLdGo1p5iqFNwem6SbYlpIFXa4tNUxL7yJaK+5keSaINQJLyMFCyHmVLHeDDUKTjWnnstR0zJ
	jTEfZKHMsA==
X-Received: by 2002:a05:690e:1908:b0:65c:6f79:1dd0 with SMTP id
 956f58d0204a3-65d94b6b19fmr14124484d50.20.1778509685051; Mon, 11 May 2026
 07:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509211921.84969-1-m32285159@gmail.com> <f7c6c9c6-c5d0-446a-bbbf-6991f6994375@baylibre.com>
 <CAKqfh0GXzfUMhp0+-BPpQ3ra3H5jSKUU0g5RnAtKhP88RDocmQ@mail.gmail.com>
 <f3030dd0-123c-4b3d-8b65-148058dfd44f@baylibre.com> <CAKqfh0HUttZhhC1ysiA64rxMztBvfuu+d=m2C8TrnCUuWzT4Gg@mail.gmail.com>
 <CAKqfh0EfaVqUPbhWZ4hVX_mFUN7_CVwir1sAHrR_LC=ZU7fk6g@mail.gmail.com>
 <20260511130311.52d65bf6@jic23-huawei> <agHaQQs-be2P_fKs@ashevche-desk.local>
In-Reply-To: <agHaQQs-be2P_fKs@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 11 May 2026 09:27:53 -0500
X-Gm-Features: AVHnY4KY6WivpyS4O56g_IrpCYsVwzEtTtajaPKLiBa4J6CD6rSKbloqTcuyfk4
Message-ID: <CAKqfh0GeXZ-X=9cTaiePEDDkMHU7FJ+wkEWt=QMxPkrawp28UQ@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: scd30: Prevent potential divide-by-zero error
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Tomasz Duszynski <tomasz.duszynski@octakon.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 8:31=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, May 11, 2026 at 01:03:10PM +0100, Jonathan Cameron wrote:
> > On Sat, 9 May 2026 19:47:53 -0500
> > Maxwell Doose <m32285159@gmail.com> wrote:
> > > On Sat, May 9, 2026 at 4:53=E2=80=AFPM Maxwell Doose <m32285159@gmail=
.com> wrote:
>
> ...
>
> > > Also maybe we update to use dev_err_ratelimited(), sashiko has a good
> > > point here:
> > >
> > > https://sashiko.dev/#/patchset/20260509211921.84969-1-m32285159%40gma=
il.com
> > >
> > Do we care for something that is going to be a very rare hardware failu=
re?
>
> If it happens rarely, ratelimit is no-op (no change from regular printing=
),
> the only difference if (and I think this is actually what may happen IRL)
> there is an intermittent failure of HW and it starts spamming logs like a
> hell.
>

Yeah, I believe that sashiko was pointing out that if we have a device
spamming a bunch of 0s then dmesg would get flooded with errors.

best regards,
max



> > That's one interesting attack vector. I suppose maybe they have another
> > exploit that lets them trip the scd30 into an odd state.
> >
> > Ah well, doesn't do much harm to rate limit it I guess.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
