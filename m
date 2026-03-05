Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAD375AB7
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702649; cv=pass; b=OLyDF2rvOC0xlxBrfAYh6EtlP0t73IKj6lhqrdKwGDNh9aZt4SiXhU/2zNiqNqWDN9LWjb+qvDjoGOiNXsTCIp4z6sOn2FP4WwjEuqOx+YFuvfxcAl/3jw4Z/0SqhS/QB0kyheqG9r1PFGKiZ25Z+1XqaZnTQIJNWjDU8+FtK5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702649; c=relaxed/simple;
	bh=yOGSzeXM/fJTAPIw5zs6GzDVPcLedX2kJhZdWG+5xLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utLuyOLO5uYyRvsXGVEIdRwKyTXB32mjATy03y4qnnkW4iBH6fWjP1VtrA2UNy/QWEOorDrpWC/AXyX3ilvntxvx0Vsrx6YmDLRvNvP+CMiYG8iRgvMUrugl/rMFwYP3bOKWtVvHSJJssxVG69NO9n5b0mJtAD6a32r3j1xxg1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzDsPtOF; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzDsPtOF"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8f8d80faebso1287560666b.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 01:24:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772702646; cv=none;
        d=google.com; s=arc-20240605;
        b=b143iiRU+6QFBoI6mqz/xbpriwAUQxm++a6G0uIxcVQOUoa0LMy3cHRuwE6iu+arBc
         3wa0CQKMEl3OMnxNe4o24sEsWtiTOb8e2wCxYbUpWFueekR7x78Biw8p96vrJHOFl8T5
         vc63QbPebtcAs6Mfh7vjC6fUonRc1b8yO3z/TGZe/oxd7ggrA9bU1N5MlVZIpFsFWZyd
         sraMwaiQkRlZ6PMRuDv2+0ATq2GPMlhvXAoV5OiC9If/O975V+D8qOB9s6qLZ2fmp3rV
         VgxDnHGewUup3HEUVL9gkzYeHcQfYqvaKs2cyssLZ32rTmQlWFLfx9aFbiz1Sd4xVH9E
         1/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O7V/aynPgarI00J6RHHmZxLR/eFY6yKbzGs2AV4GWAE=;
        fh=CVJiFg0CaPpck/h25CDxBiwj5E7mhhx6hEnxcnBqTCQ=;
        b=gplK8gvTYJ0iLFs23br2jPaMK/zP9yMqRdzTv+5yZjCo8yz/fVoUse9uqhjHibIOT+
         FMI9xZRU9Zl6+yVP/Gu1M9RiN79AFWEZrJyGbxTdouWF8TJRk2k4zOAix61mocXwhdlf
         igtPwNsv1HXrggy2RftRM/BL+nNofMzL+dliRvBItSPiYD4rXowDQ+2WXpLV5cpCPVzI
         GT0lRXGfqzSRv6VKC8efLos0Mwjb2GAbpkq0wd+KvM/Vve+ky8fVTwvWcILNtHRb1lWu
         yX9+0ML8ASk/QiZ7fkbfs9nmXXpqt9KRqfSAJBflt9sz4VtNPUEnzO+/TW3qDf4w+U9r
         YtMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772702646; x=1773307446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7V/aynPgarI00J6RHHmZxLR/eFY6yKbzGs2AV4GWAE=;
        b=EzDsPtOFsUZzB5vhFUBXdFfTG5CnS3MCa2zjysCqIrZbXCqIsbA6W1Ht9vlfAG9d7/
         qDDYEGRUC3UZAReaUZICoSWpvpa2bvtjvd9c7UfRYp8A7gpK+hQMHWLa/A+ZBJZndjvb
         RMFDQivCn3tNY1Bt7hSxeLQwEFdYUicsMsqtvbNkNtDsTMXG8BvYhlYqbnlp2xYeYQiA
         vG+oZlaL6okJW31wjk/k5G6G6OQ2nFF9dYYB6k92acst23CaPvB8UoA+q0s8VQUcLoBG
         ecjBH69qI/3b1VQC/vRcpTqXF3CuSqeXUyTb1f6SF/2XQ7h+B36p5aCT2FcoPuHyALtE
         I9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772702646; x=1773307446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7V/aynPgarI00J6RHHmZxLR/eFY6yKbzGs2AV4GWAE=;
        b=XRQbX9L9CqDlomOd3AFmCgf8qNseSUppdd+GBZvfdzyD+O95ViPAQLz9SKhWvlUzgY
         K89Trbo9jl56dA5geuzefJiY7nfgCvtvi5JRa8bs/+3Mbem3wX+x97YNv4q8FDuP6tAg
         TUTs0wi/GDqJd1uPgGpgZ9yENOeJLySBOYoIm2LPFwAelKIRnbvEfwW45eOiAjMwJNQE
         bYFKT45NTcLiOJB0ADFDYt9M6gg/IquRZcSSSEjo8kRYSNDMXowzYyYBXM1w8w7xZSOi
         LF6oPklnrLgc4OuHMDjcj4vo/vZ6yECZg/gbFxr2QNLc3cYWXjDMaoENh/lTMqJ+/jJK
         gv8w==
X-Forwarded-Encrypted: i=1; AJvYcCVZtPr6/62h2/PETO5g+C8rMGZea4xCcq4LlxFLN952iGPq/r4k6y8id4sbCZDnH6Fg/Bj7MD0Jne8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjyf1c6RfmAvRo1lVIaHnWZ/ii02skcGefZHvBdSryld0XLcxf
	RNOZS9O997yKsx1k83bEz2BpsKw8rjVvlLKKXIo1P/k1AQ+8j6gNjsJwrRgGN1RhxU9T6kKZIdc
	KbUVKdzAvr/vNozxsXfBIMaaiUQxqW3I=
X-Gm-Gg: ATEYQzwo9e+EJbWULv856Hrh1yjgPNibsxgsdMDpTCdUf7C033dcucssNdBBAj3jVPU
	CtCfK4D+8P0br93PixWxKvVbKhzS8JCwR/Nw7y8+pucpkg9eUfOYQIFZLLmmdn67tQ77XLGmgSc
	QytgPuxKPZVxsy/2ZDFpQioBFWMkuQScfVY6LBXSIghm99wQXztYTBnbOwhJB07QnRxb5tEzkdD
	TPHvnvl5Jnd/p8p7uVFi8EH7SWWERpjGX9ZTWB4AnlPTapULFwrZAPwlJzXCiRx3nIPS0jo1MhO
	jSsUHN56ZDtn4Y8hDtp0HgT9Fksr/Tz+DlnQh8xOGedxvYC+v3JR+FC9jsgZoNy2mD0+86q7Agj
	TR4ASgOs=
X-Received: by 2002:a17:906:f594:b0:b8f:de15:8334 with SMTP id
 a640c23a62f3a-b9409e6c303mr96538466b.24.1772702645754; Thu, 05 Mar 2026
 01:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304080519.2844101-1-flavra@baylibre.com> <20260304080658.2844434-1-flavra@baylibre.com>
 <70f25902-5c79-46f9-8c67-99633b22b5ac@baylibre.com> <098886563f5fdcde837989d0556ed9a2d8d3203b.camel@baylibre.com>
In-Reply-To: <098886563f5fdcde837989d0556ed9a2d8d3203b.camel@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Mar 2026 11:23:29 +0200
X-Gm-Features: AaiRm53YqAUMQyvSLktnGg5SuN9kQ9-08zQw4GXGWg1FP3qWaxXWqtsvLa9Yl24
Message-ID: <CAHp75Vdni=OgHiDi8G5s6CgBFZZuypOyJSo5DFjaKYFkLGPqkQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] iio: ABI: Add support for floating-point numbers
 in buffer scan elements
To: Francesco Lavra <flavra@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 11:09=E2=80=AFAM Francesco Lavra <flavra@baylibre.co=
m> wrote:
> On Wed, 2026-03-04 at 16:45 -0600, David Lechner wrote:
> > On 3/4/26 2:06 AM, Francesco Lavra wrote:
> > > In the data storage description of a scan element, the first characte=
r
> > > after the colon can have the values 's' and 'u' to specify signed and
> > > unsigned integers, respectively.
> > > Add 'f' as an allowed value to specify floating-point numbers formatt=
ed
> > > according to the IEEE 754 standard.

...

> > > -  Format is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift] .
> > > +  Format is [be|le]:[f|s|u]bits/storagebits[Xrepeat][>>shift] .
> > >
> > >    * *be* or *le*, specifies big or little endian.
> > > +  * *f*, specifies if floating-point.
> > >    * *s* or *u*, specifies if signed (2's complement) or unsigned.
> >
> > I would keep all of the format options on one bullet point.
>
> That's what I did initially, but Andy suggested doing differently [1].

And still I think it's better to not mix them. The floating in the
same sentence is confusing (along with 2's complement mention and
sign).

...

> > > -is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift], where:
> > > +is [be|le]:[f|s|u]bits/storagebits[Xrepeat][>>shift], where:
> > >
> > >  - **be** or **le** specifies big or little-endian.
> > > +- **f** specifies if floating-point.
> > >  - **s** or **u** specifies if signed (2's complement) or unsigned.
> >
> > same here
>
> [1] https://lore.kernel.org/linux-iio/aZ7dCdLs5xcJ4UGW@smile.fi.intel.com=
/

Same here.

--=20
With Best Regards,
Andy Shevchenko
