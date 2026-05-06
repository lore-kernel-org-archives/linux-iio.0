Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B23DE425
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778053586; cv=pass; b=nmdpw5HUGwuxa4w6m7OwQxXh1rEb82iRwbr5hMpiBuNT/DTmlx67Az95r2cpaYUKeHYTTdE/h2DslSa0xNkrDCgaJUjuKHpzIL7h+OhchMjSai5RlUHwKPj2Q5THD7xIJ/G5NeWp7hQLnIe5CEWm6F+fiWbaSvTjYU81ncNlQqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778053586; c=relaxed/simple;
	bh=Tx3WeZUNhuBZDbCRie8ddYNOeSRcG90ujTtX2LnV7Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCKugubtjN5oQ3jE5B5PpKsgUlx/WQfGY5WCMAYJooSScvznkGZ9/CxA+j06+LaZtTGAB7t9oGxKnhQt89fiQg95iexSk0aRQzdfUPJ+7w7eF6BB0YLwQQdXUgR7cl0gchlO28d7OoNiJTft8mhSBkJt0TKefpFScrPepFDGeKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ9V5fzl; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ9V5fzl"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8891f0c88so171589e87.1
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 00:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778053583; cv=none;
        d=google.com; s=arc-20240605;
        b=Fzj5l9bwm3pBj9tvLx2TXgiLlPQMU8xJ1SCIt13642BVLN6S4I2ZvWTUxe1YTBz6h0
         MLtZzwuDjzDoY07By3EMDZ0ivKL2OrtbXOyXUEwc8zP0pe7wEvdQ/LdF/RSKOXEqbZ8M
         XSAoV8664ECFNIG6szIPxu5Y4fSOePtgLdwwfQJVVzp4SzJg5vdOPCLbhLuH8fniy3X6
         /z/FqMLdvp4Rk/TTQvn47Wby8TBeaNBUoQbWf3geiZgobZumdFBpn2hnEFfVg1Qjd4qG
         u0Cysxjy+WvI4yOLcLpPgnWeyRNfV5ryFs19PJa5+HshzDgTqi2fXwO89dChwzGUsGdT
         29nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LtNgMFYOhpx95LShPDCJrC6wGLnY6fi+ZP/Q4wbmgYM=;
        fh=5G9sgjnZ8qXwAcDpXWbVK9zvM9uO9E56D4MoL2Op6XE=;
        b=RzADGrD6sgkrIjSm/6VH8e0DWp9FUrN/XxY3/Z88nJyAKlElzxedDXOxeQA5MCWLcv
         H9OaMqq1S9WW9PWjR0BEXy2KoWDAtyVlvYH0c7Rc6Kh6tt7IKV6BXXlSK7ga/4THxkwv
         t4KEhzS6YXek9vJsKB8Pg0/A3i6R7ORVziHCAFpiPdynH6bCdCXySWh2DXn1ix2thXzi
         IRMiAETEh/ACNeHNWjx3W0SQcrRXNp3WacC9GzERgCmEJzCbBJqjqwUQxjKfEys6zE1x
         ftyMbL4MuB1XoZEs36HMJZ5cwEDR5tatLofBg4oxwfy+EmsAcTXizdkY6jpLPlUqEA2W
         kvJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778053583; x=1778658383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LtNgMFYOhpx95LShPDCJrC6wGLnY6fi+ZP/Q4wbmgYM=;
        b=WQ9V5fzlXWBOB9K1IarwqJe2iIi8ESzapFRZFFZkIvOE8GCzyy7Wb1DzWMA6+v51bO
         f7/vTPLtTGzLWH5P3zR9crsdOkD8NMRG69exxiYXhndmfXx9k3xgRPAMYzjqX8sPiIpj
         QgENld7W18Dyude30cjuhTrgplzsATL/vQ9t2h8YUUVOvk93tHY4+bC/okb/tkqkLntz
         XbCMY4/IHKHID4Kh4294PME7M154rOv4qNIk/j5RUwraOaCSqaxpX9azx5c3Nlfv8caG
         bpRtrXMnu2GVsJvt4STL5/gBcXd8B40Euym8BCrsE+0VloLj0KRcSEEqsoMUzNUCAVgY
         cVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778053583; x=1778658383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtNgMFYOhpx95LShPDCJrC6wGLnY6fi+ZP/Q4wbmgYM=;
        b=pXb2ogWEwzlhDDN1vIKA6rP+MzXRyCxScRY/n7DKb7cBfGYpM1R8Zfy722HCf7SfG/
         W+qSMnFez8+R2Haig0KzP8fue22yMIfGbrVp2/GWu5PmXljI0rLPk97ZGbhmM1IrmCBE
         B1DGD2q/g6eXHr4m9Xhk3wVfCudROUHTq7AVn1jrRli6gmMa/sVqtCJoX0WP8WpgC9dp
         4pU99OZwFHTs3AJH0wOpvZR3UWY+g+6oUGVmq6yYrEoOeVsYCDJ6ABi1Ql6FyTQY05Xe
         MT5yc7qyZqKfyaket7oHqY6KSh8aEnsxvAi87ZYjuleZ6izzt/MQyHldFgHFoKd/s6GN
         TIBg==
X-Forwarded-Encrypted: i=1; AFNElJ+1f+7WKeiRBzRxwuF5473na/hBIRwcqXiNypSTzr6Bi2uDNeLGm2toXOb2z7S3uj9J7poz9oBQocQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83HG7A9yvNL/tOb8gTiUUQXtW3gvM3nyRq3Wab56ZQ+TJDZ2X
	31GByhfEB/8ddjrXuFVtGVjQpvxu1QEyMOt4C7Znsv8gGCOdkoPtyF8f3FiV5AIYDLsty6bTlnh
	3Aabh0wjHq+NbLWkf5ccgMBX8VwG5aTY=
X-Gm-Gg: AeBDietRffYFnalGBokaWW4f2z8iTp/8+m9DNk+99A5hzNRPy6OdrfHaJV8jB2wRW14
	zs8tdfefkVP9o+SmAC6nmcVmQk0Kk64W0teazQ0RHByxBKU8SIWUAB6bRVkHjU4KvHACLmWQ54T
	tF0Y/coKfh9LozfQwsFozt0/UvPb3nl6nhDh/+JlFtlZWCyP9lx6tLG2GbaIKdm+Kx4449tEIQ9
	xKtiCj7nOw/IiaYnZ7FYVasm5mfrIOHpIKstxy6U6RvPtOVJaTvhV4Hdp18XFrG5J01ZjNBWlj/
	22vaR7JWZFgfOuEIlUTv
X-Received: by 2002:a05:6512:3986:b0:5a8:5288:5bf with SMTP id
 2adb3069b0e04-5a887ce5fdemr740855e87.28.1778053582536; Wed, 06 May 2026
 00:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429132234.30514-1-muchamadcoirulanwar@gmail.com>
 <20260429132234.30514-2-muchamadcoirulanwar@gmail.com> <5f126a59-9f03-44e3-b4cd-27f70bd9840b@linux.dev>
In-Reply-To: <5f126a59-9f03-44e3-b4cd-27f70bd9840b@linux.dev>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Wed, 6 May 2026 14:46:10 +0700
X-Gm-Features: AVHnY4L_5pgV8GXOjPv-2E2wKzMdg04ytr_7aXwttrNdCJshMRLa8vrmmICm4kw
Message-ID: <CAO26r3R_TxwMwLoJMqjAG0pd2P__V-WmGkTcrZFt6CQwa2y1cA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] i2c: rust: add smbus_read_byte_data and smbus_read_word_data
To: Igor Korotin <igor.korotin@linux.dev>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org, branstj@gmail.com, 
	lars@metafoo.de, ojeda@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, igor.korotin.linux@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 17:29, Igor Korotin <igor.korotin@linux.dev> wrote:
>
> Hello Muchamad
>
> On 4/29/2026 2:22 PM, Muchamad Coirul Anwar wrote:
> > Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
> > ---
> >   rust/kernel/i2c.rs | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
[snip]
>
> Thanks for the patch. However, we've previously agreed [1] that
> I2cClient should implement the IO trait [2] rather than adding
> standalone methods like these. This patch would need to be reworked in
> that direction.
>
> If you'd like to take that on, feel free to submit a patch series
> implementing the IO trait instead.
>
> Cheers
> Igor
>
> [1] https://lore.kernel.org/rust-for-linux/20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/commit/?h=driver-core-testing&id=121d87b28e1d9061d3aaa156c43a627d3cb5e620

Hi Igor,

Thanks for the review. It makes sense that having the AS5600 as the
first consumer of the Io trait would be cleaner than using standalone
methods. I'll rework this accordingly.

Quick question on logistics: would you prefer the Io trait patches as
a separate series, or bundled as prerequisites in my v3 for the AS5600
driver?

Regards,
M. Coirul A.
