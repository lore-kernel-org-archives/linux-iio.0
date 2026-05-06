Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6430BF6B
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778049345; cv=pass; b=S1JAv1KRogyMK73BbCbm0N0BdzvHtx7NQAejNDDosQnludlq3pKH6Dy9/F8qnfJ5JtxmdHYWyI2k/t+kONPHI0BHElL2kKUyolS7Za/gq6bMgofWE5ImdRX4/1WdtFn1pw16wmv2PgTSzgOJUh08XjBkuFLSMCvd0mcs1zjzH5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778049345; c=relaxed/simple;
	bh=hONxptgeZxRpWZH2Sxr4Xj09jpIknpi9iFwZW+bA35I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGmlJmpBFwoWQbY2XDFRlJWSSrcNJGl+j4LadDFlfMoa/pbQAwByKIood85fo3dWWAShXtM2T9rdvxP7GpuhFfObWyeVOTh5Hl9cTU/hviS6uZHRIDvcNJVOcAL5wKjWp1aIcxhDt80a4B+E5dIfEWULlM5V8F6S/YEF7Ez9blA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLUhU2WG; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLUhU2WG"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bdc947aa88so11326587b3.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 23:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778049343; cv=none;
        d=google.com; s=arc-20240605;
        b=BgC7NvxZEN7rVpmzeL6w+CoHuolyiViPfzf0spTURupr5+47S58gPMg4SrOZpgwPtV
         p9ekOUYdU/OzBQ3EW3JNSRoaggoMBx16mDG3bHBVLqNmdUHMUt4ClqhMzMUGxaiSruok
         9E5U0M5r1YsFpYALHqzHHMmJtGB/StuJqwGGG3upjdpy2mVdBhzLBg5gaJV9qGI8YXuD
         X26vRFDUckCcUTTEishUCE9vSDnVQP4OsjgFun+0xjfXFM0ZALYT4ODrYHe7feJOW/bO
         Hcowt2znZNGuv0dKIeLdL7WozjBilRqwiNLPVyEJxaQRUXXfE3/dkdlfKz0KRO7YEx4J
         YZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hONxptgeZxRpWZH2Sxr4Xj09jpIknpi9iFwZW+bA35I=;
        fh=8IM6HbEqNqAVRYRpfRIzZN6oS2EFz6h0UkWwEdGXkLo=;
        b=WWw2xEDJeCGIfO4voZf+h9cmKwabItaKRnhBAy+RBLq06MudNtLr9szFEijJIW0bmV
         E/dAQPnWpX+Sdy+NKGrE1caJcIf1WPkH5g7IXQCs8X4CQ8ViJjsjYSsPfETZnOG2RDkO
         98DWXri39BzfsTCybhu5I3IfICZiqgU5Hofyf+nPALyP7s6vHppTE0RfTCddSdwjg0Gs
         eQtSaoxNY0M7i/JnPb5qUWSp2jQTpUgpzXF62X0AJdT5XtJSNUCsakeoqvWFKb4YX6o1
         ygy6Ppdsgqwfo9lVDwgG9BHXVV4YxTJCZR4ogvESX/ELxJf9uSc2OK2OLL3yeQ0Sz0kL
         +qcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778049343; x=1778654143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hONxptgeZxRpWZH2Sxr4Xj09jpIknpi9iFwZW+bA35I=;
        b=gLUhU2WG2SwPXN+wxsIEPOy83CBr8agkskVeA9fuszBhIfa9z6u8S9UHCeDY5aswUQ
         BLUJ+1kDrUbjEi07TTaYsDSj0LtlzNPCbIVqffr8ooVJEXS293dQ94uFm5MWD4i0pcC1
         nAzXfdaWzKKHeNLLurqsbvxyLHHndmNpgFkyWraJqJ8sATFGaK8M/jPvnhbjP8XqFNsF
         CoHjV5ypJs43MBoXjp+rzBq+vkO6sixz5fbg+ceBHncSUmUtQRZvK8eggZT+FP9B61Ee
         jxVFwKXMQuYXCMNr6YncakNsTWXhwB5ZpYi5Pbmok9B7u5PAwhK3mMX4bOcWlzYBZGRp
         Oh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778049343; x=1778654143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hONxptgeZxRpWZH2Sxr4Xj09jpIknpi9iFwZW+bA35I=;
        b=UYBO8XvqV1WHHVPP7hr09CzekxmDY/YtdDxOB3Anc7ejKnpD5X2KogbC0TAwfKIBbM
         qPw+qAQKhRM1nPlgwiVrOcndnL2MJhTRrzQg03LAc5vUmSEMPqnA+Rdf6obWp8ExHrkx
         93zEWgAgxsRSDGfRdq74IUsG6QjP3xPhdGO9QgtmxbJCK6jt3FlM0QkMQZkeHmWkP7ix
         7U8nO7u1gUjz7rGUC8HrwEBSyx5y2096MJ2hbgys24jfvBwI5r+8MjC9bmbjdpxjXXtu
         jvtEmZSC867rJOPTvWOmLn3FckORXg0Xwr5/VgnDFgSfimowKfLPScnXe6+9yfkKfuIe
         3D8w==
X-Forwarded-Encrypted: i=1; AFNElJ+INKtbyAt7yw6SdFh++cDvOb32YARHo1rtgH9v7qugY7WJkFnmYR6i8SVB/8ty/KufNy6v2j9On0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Gz7WziYR4/1/1cqfmfRaHoYfrBAjqRfH5GUPKY21H3hp2OP6
	qq2eFU0tONCp4ov2qnMFjbIJIFUregkzvQD2heacHt9SDA7+UbtyBE/WcfIZ+puD99Lma2HgdQ9
	cQUq2Ro4cVz22LiTe1HlGnzBInLW2+40=
X-Gm-Gg: AeBDieuya2ms4uJqhZq0xx3wxIjSm4s3uxQD9I/CBEEai6pjoatEGKnghcJ9uBovaiB
	KFEh7yB1f63eqg6ECIeF+weeSjPI3FIGKNjRLwTVrQ99YI6SL9+8NG66E++a/Oxq3QpitytTJIm
	e6GSc7d+RAaf1Y/AT/N7wMD6wymBcnf9KUOJxI9EBico881znDHk0v2egGRyHVWlBSqdlpNJ1Ue
	iPyepcIxxPEcsm/FAMIVWrAJUyYo2QwkGfZD9o3k5jTO6JNLLNblP6e7rwA4Nmir9alJKequi8R
	YIEwE+/V/okGKpg=
X-Received: by 2002:a05:690c:6e85:b0:7bd:d4f4:262a with SMTP id
 00721157ae682-7bdf5efb218mr23647967b3.37.1778049342887; Tue, 05 May 2026
 23:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-3-831b9b5550fc@gmail.com> <CAKqfh0Hz_zc6+7m2ca8uY-kPNs=ttOh=qni7MdrwFwThEx69TA@mail.gmail.com>
 <CALoEA-xNCjBZ5xdEzEC1zoXL36=Zq5Bfwb0zwP0cU5W0Fs6Spg@mail.gmail.com> <afrdalgL3rEvYCEV@ashevche-desk.local>
In-Reply-To: <afrdalgL3rEvYCEV@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 6 May 2026 01:35:32 -0500
X-Gm-Features: AVHnY4JnDnaDX1SPNA5O4Ecew6BPbS0h3ElvIvGgmcTAEjXzWSDI5v_FA2VPJIA
Message-ID: <CAKqfh0H2s0GbD1BbE1J0_jUBwkuDTcTPoLqe9nkjCae+r8L4gQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] iio: magnetometer: ak8975: replace
 usleep_range() with fsleep()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 1:19=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
[snip]
>
> This simple patch doesn't change the minimum time to sleep, assuming the =
driver
> was tested previously (and it had to be), the given change is very unlike=
ly to
> introduce regressions. Also note that the similar changes have been done =
all
> around the kernel in the past few month and I haven't heard it brought a
> regression to the users (but if you, Maxwell, have some pointers to other=
wise,
> please share, I would really like to see such a report!).
>

Alright, fair enough. I'm just not as familiar as I'd like to be with
the fsleep() stuff and wanted to make sure the timings were good
before guaranteeing anything.

best regards,
max



>
> Yes, fsleep() is recommended way of non-atomic sleeps with a microsecond
> granularity.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
