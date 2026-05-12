Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08B37C92F
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599346; cv=pass; b=q9nQRQicVsKrnXMwdms6EasgDHSChIDEvRHrjElidQ+UNjd9Z3dzWP4KbqKTT7IpmIawRNsRgvBG0M30JcSXbYLvorEk/2wpnnaRVra99nF30kEcDF1oydlr5FhHB7sSG1Ey4vg7L7poykAkjywKnYwfFQnHhxylno8rB0ukYMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599346; c=relaxed/simple;
	bh=GMqAJJvoKZAxTYL3ppmWAG2jFmXFtUvCYSYB89m0cuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1iTt7vB0yFs2Y3XDS7ak/l2sjiVKYMU2gaUMlurqX/BlUKdoF/XJ3od/ThWQOUHOjTrI+iVLklQfZhjtfy6AiYbRVAXxqFtquO/pp05TD0HVoLCofzTITb4esBoOShgaqr2PCJ6hlF4lHaax6unrorA55gPmY7gUX3wm89pgHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwUVAJn6; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwUVAJn6"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a40502e63bso5160681e87.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 08:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778599343; cv=none;
        d=google.com; s=arc-20240605;
        b=DnGr1TPsLJwWaiiInU3DyhmM/tFjIGC6Nhy9D2hubu0FCGCfsWF+YcdQaoVpx/OHlH
         /+JQSdYsC+fxRnC7N5lkyK13orNd2DlVTODxc47j0MXz4NvHdolH4M4PkohtCUq/gVvn
         UMK3CF1OJhmbD0dB/U3yaj7OazbaR7bKMmWCIselZrYQxMS2U7zJsYqsj+qMb2HFpAVD
         LLq+JUz/9x4q0K0LZnyvagohSpvpRH0JfinOqtTpZWugdkF35Ng9QM/OU9bmODv/VxfC
         XnN7YDx/fvzk9Nk8mObtsMyMMZ/lUX311IVcMOcK66lcJeSOyfensZ9hYLXU9rjzO8Vx
         2qBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tsL/9p+qUWLijfBeysWK9OThhTiEfsjo8MZi7vGSKvg=;
        fh=x8Fvhe0m0l2jIMpEiobz1trnnGLHjnl9D+0WLyAf+uI=;
        b=IV8eLw2UucxDPpUYC7cTHkKGMPVClVxAyCMNyn56T4feBTKmsd+M84PBnqk7DN1ekw
         EgE41rXsHuCVblSDmnkoqDtyGhC3CBaB4uKw9kVWlXOEDb5TZwC+31B4kyqPpiZ3lDn7
         S2WXOS30kFOc+nKJOGmYkXCbNuOm+AgJjQ+8XuqnLTsPQkRRsoUi2lQzeKrRyJtcflZg
         1UsYaanFFd5wqTWvxdVPwlX6YSPcY8fkYCwJ9uFP7iaKiWktYsSuUaw8CUukYo33F7Yk
         kotk2wE0qHLg4TbmMhEvkJ+AzJ7abOmcRkG5xOVsIommvLrWEeF6TQKML+NIx5RjaOT3
         HjVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778599343; x=1779204143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsL/9p+qUWLijfBeysWK9OThhTiEfsjo8MZi7vGSKvg=;
        b=WwUVAJn6TU0n1lhjNkg83Am9aNZjarCevbakj6oeB+Tvu+0J8GiUdLRXdietxAtfKx
         3H0tZWr8Cz99iH0jZQQEXB7v+238cE0JFtUoNGTsVKwgkjm8CHmQ5a85uhpG4boU1uCZ
         e4kt9wJQt8coalk9svMaCv1RvBwF/u0ngiooU0aTm4CYFdChG7rn9irw55njL90FtPBM
         L6R44fcVtWsEn8t6oOSV6qKUzNy2DrpdSTjQYUDYekV48KuTasWB5/Onr0pNoPGBpuxg
         ulk5WO4E6JWsGI5JCb2lDRhzFIRn5VdvYWMfQIVD1gH+9mM55eSQNqjYG1mVHfiFilUr
         HqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778599343; x=1779204143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tsL/9p+qUWLijfBeysWK9OThhTiEfsjo8MZi7vGSKvg=;
        b=B5eEur1FQCN7fkdfGGALWqhF4r4RznJ2Qc3RErS8tl9B8CJmNhFiljItHhfymiKAJ8
         zFSnDSLhOCrXnXx/N4ajh2kCzMNdLdfOw99uFCDHXQfR6gTChtCp/j7+/3vTvpM1JT9t
         8iBfnxNkkcdvd0JG5WFCrX9X8lhyJypYE2RoGu73DzDBRhQ4ZX1vnY2Z6dZWheyuyPo2
         3i3BJjrmDiSSEdRZWC8kRnGZZj0t0Xepnw+RUOGVmIroo50Id8nQAk8OeDKUHh1YNka7
         KzV34wmLy9DFfC6ygsMz5PMCdnL4c443S5KfyKb+0r9blxz0OAeXKsUoNV33729ODTXO
         xonQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1TpXoxlv5fFTsSQAl0pbUFpzQoZB2KgTGbLMOQoof+oVA1db723UEdu02lWwSNO3kFiDoCX9e3Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvTlNmMVBOq4oAw92Y+CVWnZVy5ybe+L6Nnh/lawD7enmHIdVo
	vsRo/Ob8iWURhV5L9lsD3QlUUUaGgxEhWizhkOBJ4boEE6FQ3BAUZMcfgce3c6B2NEZWyNFarY4
	UIOFQwUS0BAu+KQDzmL3UqAHudod/jQg=
X-Gm-Gg: Acq92OGPUNuaLE+ImaGQAJIyfo6uqpi0JPoImZCgadxRoKytIE/pgl4VeEMC4qA4bSM
	sSieabmhW8q3zm45QiUXBZApY691vrhdIjKK94fdKftPmdH76G4OZVcgGfqOh36Yh/EkvXZvdV7
	Zi/UDOWbnm6Z4mC6cEYHR8T0dMSGpNVIiUZl70K4i0FIUzRRn1OVJCBcGdvMum5xbHWVnKY8Fi+
	Nq8FtkBUTzhWzZ068h+Yse5Ca8CmoHNtnzen+utScWpzCmYYUt86EZVQ4FCoIk1OlglQobptPkv
	m9v/tdRW4XX3smJmxkq9Vu5f7ijvDfIPSmczeMaXjjX4Wgqx4hkBVBC6CeZjl6Avo2bp7IyTNT4
	3W8lTCNSEHUnkQjtfVQ==
X-Received: by 2002:a05:6512:3b97:b0:5a8:837b:3d62 with SMTP id
 2adb3069b0e04-5a887ae201amr8896955e87.9.1778599342529; Tue, 12 May 2026
 08:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-2-34af2ed2779f@analog.com>
 <20260512123953.40d80bc9@jic23-huawei> <agMnWzMjW1LwCSyT@ashevche-desk.local>
 <sj6cpjhakyfvv6rgox6cnhl2u2tgaecugcok6fw2l7zgku5wtc@aqx3ul72vgca>
 <agMvlS3-0wvGmBwh@ashevche-desk.local> <dxjg2sdyxb7ieb4abmeyyye7qok6cczrxabpsjyjhcbehwoec3@sbbqoo4wmzre>
 <agM8pWrM6j_XksvN@ashevche-desk.local> <ur6brs3yjzyb4mtelabmcglxjltddqvjxtgl3lkdkmbjlkmnsq@bwd6rz7gided>
In-Reply-To: <ur6brs3yjzyb4mtelabmcglxjltddqvjxtgl3lkdkmbjlkmnsq@bwd6rz7gided>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 May 2026 18:21:44 +0300
X-Gm-Features: AVHnY4IJuef2B-0A9_3FnyNbZ_uaS-SA2cTNaTffveNp5l_4SxlZqwsSXVNYeR4
Message-ID: <CAHp75VeoH3yVfp8NWjKfc_df0VRLkyf_SK4e==-wJOEodVjW_A@mail.gmail.com>
Subject: Re: [PATCH v12 02/11] lib: kstrtox: add kstrtoudec64() and kstrtodec64()
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>, rodrigo.alencar@analog.com, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Laight <david.laight.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 6:11=E2=80=AFPM Rodrigo Alencar
<455.rodrigo.alencar@gmail.com> wrote:
> On 26/05/12 05:43PM, Andy Shevchenko wrote:
> > On Tue, May 12, 2026 at 03:12:24PM +0100, Rodrigo Alencar wrote:
> > > On 26/05/12 04:48PM, Andy Shevchenko wrote:
> > > > On Tue, May 12, 2026 at 02:21:14PM +0100, Rodrigo Alencar wrote:
> > > > > On 26/05/12 04:12PM, Andy Shevchenko wrote:
> > > > > > On Tue, May 12, 2026 at 12:39:53PM +0100, Jonathan Cameron wrot=
e:
> > > > > > > On Sun, 10 May 2026 13:42:20 +0100
> > > > > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.=
com@kernel.org> wrote:
> > > > > > >
> > > > > > > > Add helpers that parses decimal numbers into 64-bit number,=
 i.e., decimal
> > > > > > > > point numbers with pre-defined scale are parsed into a 64-b=
it value (fixed
> > > > > > > > precision). After the decimal point, digits beyond the spec=
ified scale
> > > > > > > > are ignored.
> > > > > > >
> > > > > > > Whilst Rodrigo has already replied to say there will be anoth=
er version
> > > > > > > I'd like to request final feedback from those who were involv=
ed in the parser
> > > > > > > discussions.
> > > > > > >
> > > > > > > They got very involved and I'm far from an expert in the righ=
t way to do
> > > > > > > this stuff.
> > > > > > >
> > > > > > > I don't think David Laight was +CC so I've added that.
> > > > > > > David, Andy - I think you two were most involved in that disc=
ussion:
> > > > > > > Any objections to the end result?
> > > > > >
> > > > > > I already said a few times about the naming. I do not like the =
kstrto*()
> > > > > > be semantically different on how they treat the input. Second p=
oint is
> > > > > > to avoid code duplication, but this one is less of a concern si=
nce the
> > > > > > new code is in the library close to the other potentially dupli=
cate code
> > > > > > piece and hence can be addressed later.
> > > > >
> > > > > I suppose I reached into kstrtodec64() and kstrtoudec64() because=
 it aligns
> > > > > with your expectations for kstrto*() semantics, no? Those include=
:
> > > > >  - overflow check;
> > > > >  - extensive input validation;
> > > > >  - optional '\n' in the end;
> > > > >  - mandatory nul-termination.
> > > > >
> > > > > am I missing anything?
> > > >
> > > > When we add scale we basically make that not true. Moreover the cod=
e in this
> > > > patch makes scale =3D=3D number_of_characters which I think a bit f=
ragile, however
> > > > it's about the fractional part when the amount of digits is equal t=
o scale.
> > >
> > > That is not really the case. It is being set as a limit, so it does c=
heck for
> > > truncation and zero-padding.
> >
> > I do not see it happens in _parse_integer_limit(). It doesn't try to pa=
rse more
> > characters than it's requested in max_chars. It doesn't check if there =
are more
> > character nor their converted values.
> >
> > > > To make this work as expected we need to add an additional call lik=
e
> > > > kstrtoull() (and perhaps drop that \n and NUL-terminator checks) an=
d see
> > > > if that overflows or not. Since it's a fractional part it must have=
 less
> > > > than 20 (decimal) digits there, so we check the rv (or how many dig=
its
> > > > were parsed successfully) and compare to 20. If it's more, we got t=
oo many
> > > > decimal digits.
> > >
> > > For overflow it checks the KSTRTOX_OVERFLOW flag and leverages check_=
mul_overflow()
> > > and check_add_overflow() when combining fractional and integer parts.=
 The amount
> > > of characters is not really important there. The scale cannot be bigg=
er than 19 and
> > > that makes sure that int_pow() does not overflow. The code uses _pars=
e_integer_limit()
> > > due to the nature of input and to avoid 64-bit division, kstrtoull() =
at any point
> > > (parsing integer or fractional parts) does not make much sense.
> >
> > Under 'like kstrotoull()' I meant something that repeats needed functio=
nality.
> > I believe it's parse_integer() (without limit).
>
> I think we are going in circles here and we could look at the code instea=
d:
> - integer parsing with _parse_integer()
>         - overflow check and validation of the return value
> - fractional parsing with _parse_integer_limit()
>         - overflow check and validation of the return value

No, this is not fully true. That's what my whole point is about. The
max_chars parameter limits the input check, then it skips an arbitrary
number of digits and only *then* it checks for \n and \0. What will be
the result of the
0.00000000000000000000000000000000423 in your case? Whatever scale you
gave it will return 0 without checking on how many digits were
supplied. All the same for 0.9999999999999999999999999999999000423. My
point is that we should limit this by 19 digits.

On top of that, what about -0.9(19 times) ? the fraction should be u64
in this case and it's fine. The sign applies to the combined value.

>         - extra scaling and truncation happening outside if needed.

Right, but the given input may be way too long and still needs more validat=
ion.

> - check for input termination
> - combination of integer and fractional parts with check_mul_overflow() a=
nd check_add_overflow()
>
> > > > Maybe I'm missing these checks already performed?
> > > >
> > > > > > Having the test cases is a big benefit, and that part I like th=
e most.



--=20
With Best Regards,
Andy Shevchenko
