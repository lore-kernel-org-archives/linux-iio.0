Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA5277C9D
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489229; cv=pass; b=dUORa4zWHGlGeoJV6BzDJNtnYk2w4w+WQzcK2tBbL5RoeuvD7mbw2rrr5CmSFXLlhDuBqrjSeLOZXBAFE7CniwoH5nme4i2ShTemDh/3p4YrRfePRnBkQiZC0iEesHlfwEpWcArOuZbov7cRuBcyXkkk4zCkdwbWa7M7xU6XMRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489229; c=relaxed/simple;
	bh=2gGScbPoI9BDUkWkP6wzIyfzMQrfrgAHxpag/imxAZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUrfa3gRYMpDj8U6puUms7p/nSaKCc5aUUk3iIx95TBZh8FVEKsOgz72s2kg/YX2lxPrw/F4UVH/X3Hn8dH5D0WapVBLx1JG72tmpJqSCy3ey2E545aFX11xk5Ibnifo9rTBCyBcPQoia4b0rvbPszlkz+vRzikjPBrW1yH1Hek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVYIdHHp; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVYIdHHp"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7b248750279so1313057b3.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 12:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777489216; cv=none;
        d=google.com; s=arc-20240605;
        b=HPCW17ed4LVrVO8h8c3I2StCdGBV6Pr3ny72ZY9GcHDPtUDSi9X28JegTG4li0sz9j
         d+mI4zxOAW4AZZilrjFEqWx31ktTPCkcdGtiP0VX9nSiD8Gua7cKhhlY3gD+Wg/Fq5XX
         lnPoGc6QbhAJar8t/ktdYxQYdkXXYOHKXG09PBzClGVw6eM+M/jz6lOLshlcFVZZX2jw
         fuutdx9CWw/6g45hjWrhgTnzuroK5yRB2iltoy8uqjnAk250H2bLn0nqR/Pu/xgN6sz3
         B7LhVEp6Sg3eavg8VevqffOwAsYYxCpALZxs6Y5aHXIjCBL+uS2UtiTS5kBqWLEurSF4
         NAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2gGScbPoI9BDUkWkP6wzIyfzMQrfrgAHxpag/imxAZ0=;
        fh=V9hptxeWff/ejK9A0tS1xPPLjkG1E/L0hmdlFR89ezE=;
        b=VWNCic1eS80H+DbxysCCmIgpHY/PVpKqBiPy8a5gaTWQ5Qz/OzGd6OKuOagnaWv5Me
         /ibBedC/JdwHielzi4vTZHUPcSBNCgyRloAyVZ6F0zOXdFDxAZRWRcEOM4l2hD4pZcD6
         AxMx0b0UBnYdzcN8fVQ45a1MXd+nWOvW2oLdy9CiHBi2MdcznkEcYC6C4t6XO5T6qgAV
         P2s46bu2Xvyn3NxmeZcnP1kg+0ORfjO/DfFJNjzDPhZ65rJNgctkDm9jLrliwYT4j1DW
         hw+1TDBDA+CpukQPwQqOfAe/CUifPaE09xR+gafBRnR/ZwxBfukJAYBZ9lr43JMdediB
         68Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777489216; x=1778094016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gGScbPoI9BDUkWkP6wzIyfzMQrfrgAHxpag/imxAZ0=;
        b=QVYIdHHpCX2alSowN/OxUd6hgfpQAa17SdtescyvFnIpKRTZYPXBAocYbPkKWC35xA
         i5hA28yPgeoxkKjo1OM6CVkQ951KqlozUkZjwIfVOA0K6QAS/DWA9fb4qlQieBW8yyKw
         ssUiq+Fpzt7H39N7+9Id7CAw3dt/sqSqfx21wxjQsNYgSljqPkLcHAu8ob8WoEUxlSSz
         rpJLcEDmDSWvdCC5to5SzA2ZqLPv7Ez8SditDplA4opY1hnbmFEYQGH8F2zg+y2PoSkF
         8YiuwL30iXzvcfwHejDz6FuN8S6geqDWxTRnMg0Ud5UA6flNfv45KG4MmKuHFUO58KLV
         Hu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777489216; x=1778094016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gGScbPoI9BDUkWkP6wzIyfzMQrfrgAHxpag/imxAZ0=;
        b=dY9Nt9uRSKDa10hqhbzDT0GOjD+x46TKxbpimlBEZKfAx63ub3hoKuq2z28ScASiDj
         nuYaxkj1wTp9sNvRoYssPh1hG5r+HYq4wMti76eRr286yPPHr9FB3MUrlk00JQCHNoJI
         fLZM9TJVzwP5sDCQ4P78Iu/4fOvZ51Ff/p37Viy9mO/rTq8paWrZZCXaKBTrSxNtzk0u
         Rf1Snvvh+ulv0hMNCqpUbrgcgWSwqPArF7zItsKQfHQ+rpjJlUwZTJRoeng5vKTZfNTG
         orXqJItRcnUwcDxtQjAd00InqG8ps0k7eVg/JwOmk1WGIl4dhJ0JRaOhfDnF2zP4PQBS
         oN8A==
X-Forwarded-Encrypted: i=1; AFNElJ8dDwJVKc4LfANLAD/wq828muPDM2QqE4GVJ2wLMZx4cDhgmWxXODueRZe1Mo3YEZjetkwEEyqBYtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrrAmaC6kgmVIcpm+Jn93JjbzDNMfO6mjzXQkMIisUIk4kVDmG
	C3qNxMP85GZ3HRAfMO9iaAFxAAx0yoCvDEFq41BkVWdXFKsQZs4C7hw1hGkCUYFA0u0U52pTozQ
	Pr3vUTmQK3idvam1n1IlJl352YvUd7Ek=
X-Gm-Gg: AeBDiev3Od18t/+ZG1fVmGwzzWDzQdPpaDUozP4HoeyVgo6sRpjBsolD9J2zAjc8QBa
	3vcyCEEMeOlVVLJAq3ttsh9pfdUNDkNfHlmxt5DKmpxSwp5rkK4RIvM1fnZlv9iEw2gEXfUaa9b
	M7aU2Ic8HaEGh4VA23kYL6BTxHCSd7JpAek6K0OaZ9bCXe51gFNxVOvNQujYuH7rl20nqds3obY
	BVoueoPDb+dLIy0lxAvm75whchy1pCMNq0Xv/qpbnAwrxYOIRCWjvXuAFVDzMrFPzieiZN01Z1+
	ljGuKadQEi9o9egp/S+a
X-Received: by 2002:a05:690c:9c0a:b0:79a:c40d:b73b with SMTP id
 00721157ae682-7bcf58d08c2mr86339517b3.46.1777489216451; Wed, 29 Apr 2026
 12:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428222600.91322-1-m32285159@gmail.com> <20260429114154.290e588d@jic23-huawei>
 <CAKqfh0HnQADMZhxn0OEp0jV2BVGKP+wRyAMOS4g9OOm+QSv_6Q@mail.gmail.com> <afJNRnuQGnnQPA4w@ashevche-desk.local>
In-Reply-To: <afJNRnuQGnnQPA4w@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 29 Apr 2026 14:00:05 -0500
X-Gm-Features: AVHnY4JYmiKc9eqqApAZpSfemreeEr7nEBSVfotJVA7S2ibdlNB9j-lybjf6uF4
Message-ID: <CAKqfh0EF-uBdsyS0K5E8=t0YB-LQ9DvNALmKPWBTVczM7OXBUg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, songqiang1304521@gmail.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 1:26=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> Won't fly. I am pretty sure most of the maintainers find that bad. The pr=
oblem
> is that the caller should be crystal clear to show what the critical sect=
ion
> is. Hiding that information behind macros drastically reduces understandi=
ng of
> the code,
>

Was just a thought. Even if it were to be implemented, it certainly
wouldn't be a macro.

best regards,
maxwell




>
> > I think that would be sound
> > for a separate patch. I'd ordinarily include that in this patch, but I
> > feel at that point we might be deviating from the original purpose of
> > the patch.
>
> I agree.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
