Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26616A956
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 03:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771904498; cv=pass; b=QQ5dORzj0ht6gW0FZDY4XX0BmEMfOVo/hBDDgkRQkEo+9vaBu1/6oJAPfvMWTqxRDDz4o5gewykTJcj5rUDbQy34oQ1wg4+yG/fq7LcpnTSEQ5CSxA0GATZZY++sxRcM7d4hdOzxkk/JuQO74OnxJN9koxxeSWAsm+8Yptb7fLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771904498; c=relaxed/simple;
	bh=NjUgFgIr1W2UuqfkOjfLH4MG/f1JTaFkgw6FflWqkKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4JBLv08BHlQOUC0PsgH0V0RuraYJ3kPod6pP9jDhJY+EANbfUaJdrOYrxbmFqEl6DHaxnhsHSWxMwbGRkEMoL6p9DmZO8375HP/8WUaKZm38TRAtYLx4sCQCatPw+U8g3kRZtcd+1rBo/apjxy4hif7myeYFgmUF/RbFRnQhO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVKSUrps; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVKSUrps"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso4808709d50.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 19:41:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771904497; cv=none;
        d=google.com; s=arc-20240605;
        b=dkf9lfNoRovcIguFMHQftBpZKn/JF9hEr/sq+sbNvYwmmZMm2rwPYXorp+b/gXzhIS
         9o/WE8rk1uEdxgNYDnaf8v5/j+N2I7FRsj13DPPEbB0/AKzPmRsLCyJBooUW3Z1JaG0t
         wWn2z+vZ6arNJjNR/eUdg5PjNQlfK5VjiFw39DvOq7Zc2IE+y8c/4B/hP2Jmx6ne9SrT
         yMqCQc8QeNH4W4eGMwyH3RIErNMn2XS4WvOuqokWQS835IjJoVxuzKLbqChNiuBlxrq+
         /zBzxdwlP+cYZvDGF+ROf2fr3YMXzSvvgJwtZvKYFjKcl3URg6p93ueCBenmZxINzYlV
         1igA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FfbdOxokRF0Q4Sh5bRlzYEVWEQ3qWRLkUrj6g+NsMbw=;
        fh=J+0Mk83OxceD9+KkqzTVvkUdJv83eeVbjIfJeAgcOBs=;
        b=L5ijFGROblpgJ8GIE+cUCnGysQquGkl5cVyOTHq50QEQfy4yobHCiSdE2t7r2poORC
         15lBQtryM+yRZCYhiruyNjdIv7M76MJi9qjcMxvW4hPBr5ceVkpT5fhPt8Y7FBGYpkBT
         fh+3OLzFKCFLzrNPJS6DU9/EaTTaDIh8EcbTwyz4EWWVZoXtXlwuNltuy/xpPtnbtq9j
         D6glkQI00VKvvwmUBOBWugdbAJFNAWUOQ1XVOTcm91Ir3gzZwld8Yc2ZswtUUhYgSLhY
         k/8QMihklfQ+W2Rosmd2yIcxgbx+wH/thNITmR8uHRO+1S452fCkjbc5T5lRvzeQ63lL
         ADHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771904497; x=1772509297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfbdOxokRF0Q4Sh5bRlzYEVWEQ3qWRLkUrj6g+NsMbw=;
        b=eVKSUrps3+h4JZXxnrb18Nl2talIqNidIO2vGufOT5ren1b8ss3pWWPcaNoICwpjmw
         qfp6qIJ97f17jScYIBUyZW3ijzhUI/0M6KTYLoKp3cP47ydBD0M33QqGtRhj29KVnilb
         ZshenNcFFEjLYrbbKNRWkR9QfeB8/kPsyfKwtmUP09EzsffY/TN+H3KR7+ocZnVM2dpm
         tp3mfDtt1RtcDkbWSLR/g1MHd2HarujuibyHBvFtL+zV/VaqT3eXJ0bdGlQxE2JrqBvI
         lBVC4Ir2GkPzyC3DyG/d5slBHgr8hDypkYlOnq9pJlRi2y/Pn7+Wyvw18mx96gVEQWrQ
         KZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771904497; x=1772509297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FfbdOxokRF0Q4Sh5bRlzYEVWEQ3qWRLkUrj6g+NsMbw=;
        b=dpqSlXeDuc7w1rsOlmGEm++3Mc1fgQSBDdxvsUUbw56fbEy6h5iWUAwdd3qH1FIEUn
         o81DAbiAsooXjpS7yMfTmGYQonxMJnVRS7358i/gy6h7r1gnm4xxhmwS2fDtKmwy/Io+
         sEVAEhf8bh0XqEaXnRLT57Ah0Wd9twmiraMZKp7DQ7c/3fzeqmc669LeYo1ez+h4oCOB
         +NjzGLu3sT2v/oxqQWyNIbUEQoKsVQBfQg+fKZrqRakyMF/8Sdr8gWlYCVLhkxFhsu/n
         b7LDOpf+6ZLw3eDnWo3dTbyvzoLtZxxycRQsqIWVwDmWh3Nj9xiXJHOoJafWx+EL9UTk
         U9tA==
X-Forwarded-Encrypted: i=1; AJvYcCWvVvKsrmO/L7Lqybsph7x8Yv96Hz91cpttl2dve6Z9qk1pJZJ5iSYkT6HAxU8HSLHTTCvt2UpuG0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE+Z+EcQF6fEeGV0REymi2nn7jk1u67WVs0HmJV71+oimxw9yg
	BqliXmSdPkoasMyRQQThk0U/OGODZ+Hx5fgGGz6LQOedKd5N1LSvkx82gHq+beSxwyA6b5bfa/B
	Q5EMt3/J8IP9MS7lb5PPzDHqSpzbDlmo=
X-Gm-Gg: ATEYQzy9mhBDDnWQwBlTYCULoDTziC0jfOncvJkaT9MZdqsMdYg1lw+gPxMiCouO09W
	ILzJ2e8UKoOMs9xWenIu0/3CB+/LUjwPggR9uf4FV3zuj50/9Uc0VrqyR9iIN3dTe+KnZpcQtFx
	QuGlxumMTxwLZUXFngyhbIb4PnQgA7GM8RLHmWmzAzK3NIvOPbYkbbwBZ3cM7c5Vvhum65FV2EX
	6u3ATesa2Jk422rsedLLeslQhryodT5IP+hyAbwboz1UVe3VPhtFHe+GIDBfUKte4Yfh0xaPnC5
	rzDxAeBtpdAm+9QfC6znM4tGYHjGXdcUxpOlTg==
X-Received: by 2002:a05:690e:1516:b0:649:d26a:d8b4 with SMTP id
 956f58d0204a3-64c79072c31mr10360413d50.78.1771904496888; Mon, 23 Feb 2026
 19:41:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218125327.21467-1-architanant5@gmail.com>
 <aZXD0smUd3CRgPcv@smile.fi.intel.com> <20260222134326.7fc1f45a@jic23-huawei>
 <aZwRt7ws7PeHyuPM@smile.fi.intel.com> <20260223204442.444c7503@jic23-huawei>
In-Reply-To: <20260223204442.444c7503@jic23-huawei>
From: Archit Anant <architanant5@gmail.com>
Date: Tue, 24 Feb 2026 09:11:25 +0530
X-Gm-Features: AaiRm52gb2mDAHiu4cizzLZxr73QGlCRc1temhPZjuanBPnbtkXMUt_w5MSFeL8
Message-ID: <CADJHxWB930R8A19uqozWfF=RviteJxd9Xns4uYFiQF5zKq5KzQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: impedance-analyzer: ad5933: use
 div64_ul() instead of do_div()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, gregkh@linuxfoundation.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 2:14=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
...
> > > Tweaked commit message as Andy pointed out was needed.
> > >
> > > Applied to the togreg branch of iio.git
> > >
> > > Andy, if you want to give a tag I can role that in for now as need
> > > to rebase anyway on rc1.  This mail felt like an 'almost tag' ;)
> >
> > I think you are talking about my Rb? Sure
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >
> Added. Thanks,
>
Hi Jonathan, Andy,

Thank you Jonathan for the help with the commit message and thank you
Andy for the math optimization guidance.

I've learned a lot from this discussion.

--=20
Sincerely,
Archit Anant
