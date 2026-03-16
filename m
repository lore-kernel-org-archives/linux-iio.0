Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1B4CB5B
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773623509; cv=none; b=NJJY0bUfRHlTA+bxnxJ9mmrMlG2msyeW74eFoz4cWkO44DE02quCE17aEkHSmBtozcbAM6ssKGR+pysht7ChBEVqGpdj596tBD1ZEl5xfo+tk2Q/zI9W7w/e7VAiFMrGhcmZMJEYkuVbWgaSBBB/X2uYcoVrEiynLtqow6dqfVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773623509; c=relaxed/simple;
	bh=p3XJqmHQzYBB6gblKu+dEJ8Z96crkq+CFocZhoYbZD4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=X9eJ6eEAKOYHEsYyWrqmylDMJ77ds3wcQsGfNxDamEQ9kOB7vNs4YJEB26yZA7D1jnB4ogv7Oa25KkwqxC8wfvVQcUyK30Hw5esIuI6KrAb9x4oQHtq2YWLJYseePoMR3OUGp7bOIp1PonSrO+vU+AZ+jwUr2+QGsuGoMSvgtz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2/Dovfp; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2/Dovfp"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a4e5caad6so2966587b3.2
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773623507; x=1774228307; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3XJqmHQzYBB6gblKu+dEJ8Z96crkq+CFocZhoYbZD4=;
        b=M2/DovfpPbsgQLH2+E6FSrGeVAlGuXoUtAD8+t4qorwAOAUuB591TsMH9amCc/oqsz
         yuuTJDybaEuFQYAwUcsDRxgU6E+E9u0/Z1ERh4DgyJbZYiNTC8ntWdgTWciwHVuosHWA
         rKG/o+c3812BSmvPLpTxgM3G1Y5IE/ft7tjZ0LY0qUEvDF8D3cFFpSjYaI6l/iB7fLgo
         Y/1WNoO0o8Xq3XcoWRuWbitnXfRXjdkxOLdFbf56nVJeRdXAdEKhmvupdZQbe+FAsIfA
         ibpZyvCI4TwhF2uaFXw0s3TUt4wjIGJTV/+77A8+mWJih9Gr2BOLLXmimMUaS8j+gCBm
         XDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773623507; x=1774228307;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3XJqmHQzYBB6gblKu+dEJ8Z96crkq+CFocZhoYbZD4=;
        b=nXcUOKTfhTPwd2V/rlK3OCF22kohS8pSyIUsVaAglHgxwRQjluhUhpovze0TY+HLe2
         mmHBT3T+BiZUCgV5MSBDQaqgWJOJWUDG/ZUd3Sz8inMEiD4Jc6IC3FNNj6vEc8nLlQDr
         p0DzuOGTGcLaszqS6PDdyM2HCmz0QzkWYD6w9OpD5N1tS4bec2tp6UKp6C6tsP7biFIa
         8sFt+8FifIl4aXpm2HrJxfon8YQcm7cttgDFZKl9pKOEcYjBKZKfW9+ESbWgS9oSy8RQ
         LCrBSVsI2h/AolLF9e9+PRiV4DfwkwE8IL50IQ4C+VbPGA6FmYMm3r76bGnZ9p7/40Bg
         x5BA==
X-Forwarded-Encrypted: i=1; AJvYcCX1IFJnEIWfvisulRLpJEc847ZuXdSSFeC4TpHQ7wnpdTNeM5f3DPgBeDMrepW5lmhQTPpwwS1kMzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz23tJYb1IHrVAwhbAEUsDFugGP6lnj/8+OANRESN635u+ijU2
	d1jqcF1Tc/XiQs/ywvh2dR33N4KgulRVOIyOnAsom0x8uN3jVBOytzlg
X-Gm-Gg: ATEYQzyobBUaxHLiXRbswDpeDpm3yimlwNXCIMEhnv6oDZ1v+tG3iGErlzn+9ccstWI
	od0fGwyko0F30fBjcZ7SiL+gnRmuJeSwXZKI/nljm3DjmsOf8/3lDVR7ZGC66rXqNxOWxw1T1in
	sS+p4GQD/Q8eT+gPBh1Ay9bgQEAvUpDRYHf5unjcvXyRGfCHY7zbvWYKZfVACA4fGEzmX28S9LG
	UaCd0ehj3+oSbyweYtKaIRpire6T2eJv2HWtPOagOk05cz8joK/TwZi08Z7ptUUtYA4VITWBn9e
	NUbbrsm4bVoZ16FbRtOb11D2J48qPFmBV7BN9V7lzwdBJJpqZxYrLPiNtHJ1a3rKJtUKrF8eGvp
	2OFNovFlA9vw51zG7xU727HM+CbGtPz7N8P3wRWnfPdu8TKhEM2APAiMcpVQ/aYvuYzbe3sRQX0
	MTmsEsc4hkj5TCIBS6l7/6/Oye+Ios4A/VfUcYK/fLYQut3UW2CqYf5Y/14bvS77U+3AL3nygNB
	s7iaAFcRQg4fLPosUxFKR35VEZIKakP
X-Received: by 2002:a05:690c:6d84:b0:79a:40fb:9346 with SMTP id 00721157ae682-79a40fb9bc4mr39092567b3.20.1773623507160;
        Sun, 15 Mar 2026 18:11:47 -0700 (PDT)
Received: from localhost ([2601:7c0:c37c:4c00::5585])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917ee5757sm82503887b3.31.2026.03.15.18.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 18:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Mar 2026 20:11:26 -0500
Message-Id: <DH3T1X5IS1W1.350OY1AGJ315O@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Ethan Tidmore"
 <ethantidmore06@gmail.com>
Cc: "Andy Shevchenko" <andy.shevchenko@gmail.com>, <andy@kernel.org>,
 <linux-iio@vger.kernel.org>
Subject: Re: [RFC] GSoC 2026: Transitioning IIO to guard() and
 scoped_guard()
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260311194624.1521-1-ethantidmore06@gmail.com>
 <CAHp75VeZb0pSiAkHo9QUeS+2L-qP_83-dKKRSp7-1VfZrtr1bw@mail.gmail.com>
 <20260314110758.2fc20704@jic23-huawei>
 <DH2PF86XN60W.2MVDUHLKPR7LH@gmail.com>
 <20260315184140.6f34f76a@jic23-huawei>
In-Reply-To: <20260315184140.6f34f76a@jic23-huawei>

On Sun Mar 15, 2026 at 1:41 PM CDT, Jonathan Cameron wrote:
> On Sat, 14 Mar 2026 13:08:04 -0500
> "Ethan Tidmore" <ethantidmore06@gmail.com> wrote:

...

>
> There are a bunch of other bits of historical stuff we'd like to get rid =
of.
> Converting drivers to read_avail() to cut down on hand crafting attr or
> using the macros in iio/sysfs.h that mostly should go away.

Thoughts on doing a broader "Historical ABI cleanup"? Including the
conversion of iio_push_to_buffers_with_timestamp() and read_avail() and
the macros you mentioned. And if there are others please let me know.

Also, as David Lechner said, "there are usually other issues lurking
under the surface", so including that + edge cases I believe this
wouldn't be just a mechanical process and would fit the requirements of
a "Large" GSoC project.

>
> I also have been thinking it would be nice to figure out a cleaner
> solution for hardware fifo related attributes which are a case the core d=
oesn't handle
> at all today. That was fine when those drivers were rare, but they are ge=
tting
> more and more common and that stuff certainly looks ugly.

Honestly, this is above my experience level, but this is the kind of
work I want to be able to do in the future.

Thanks,

ET
