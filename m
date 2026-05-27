Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A233C5523
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889259; cv=none; b=RIG14/uBZltDwPXYwfKl/YALgyu7+MwnemR9BCbmN0/aOgUc60NTJRLpRLWW/o/Czapk7Rl2IvXGv/7bUpxKe6K+WyxfJjv+NIlZmOsOdICTVcP8/p7WLUAVAO5yYOQNpB57VqxN3ZG9+nEz8Btb43go/oFzFmaEWxV6b1V2YwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889259; c=relaxed/simple;
	bh=Pc8tsnlOcy9W6am+Rh8DZ4EPRcArWS82Ndc0OS66y0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSEpuONhGGyo9D1OE46hA+L0FOnrbum1sBK3KTIBRZ5qSno41UCeX8J4/tE33mCldE8bRvK8TxeLkdHyUWSi6/BisRVUbOtZIjnEtsfMsqDVPf+Eezas7N9ADswf6OxINu9VYBGJMNkkvCCCAb+51/88jAECpuUtHE7/pz3GcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j674Jtbe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j674Jtbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414C21F00A3D
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 13:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779889251;
	bh=Wc0BbGUVAv6oHm5mCpjK8eArxnyNaeloAd0RRIDatSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=j674JtbelWlVuQFetyki75i8vx67jy1hyJBGTzVFhZ4gWIi7j3LYd9UGsmHxEJORm
	 fqXZvWv3caJ2tZ3cIasaxc+WvNyuxnE9pbC5+dAbqUBPqp2SEviBfeibYZcodqSjYm
	 5iByph/AUviC86GDzazSTdJf2cXXqiRScRbn7JY+1syck/WNrZqaLIxEtd/j5amqiO
	 MBnDGe8mIWQwVdzrjXHHnQnk0vps7MDSHoH6UDjXL6t59txT9ttwyrCnP7u3uVNf84
	 ARYyDUvfAGLoc/ubfKIt2VFEwHHtCG9AAsDgyL7SE4eemDVS3xqyghnliMThEMHprC
	 uPj2XgazOh8Ng==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-484df1dce93so7840536b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 06:40:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8vxUp5OxRI63pbJhRwLRCDr5da5ef2sKToRu0lIXl2jav9vL6e42vtWeNQ7d7wJ9EcsCicrHnONfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPTwGi+F3WkpQ9GhsHmd8iiLnmLIPOz/HRT/dTvMarFT8MJKc
	RY/Y+X4u8QgD/7HMbmBF2lW+DwB6RNz/1eN5VjInSB+rV1PDov1fayRkBbqXDIs/9R78bLcw+bD
	4CSSF3i5ZSXtDXnUb8qbZMLPJ3pC0wb8=
X-Received: by 2002:a05:6808:c172:b0:467:4fb:f225 with SMTP id
 5614622812f47-48549ecfa65mr14148658b6e.9.1779889250644; Wed, 27 May 2026
 06:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520024153.1647951-1-xinyuili@126.com> <20260520152236.2308686-1-xinyuili@126.com>
 <20260521124708.177ac09b@jic23-huawei>
In-Reply-To: <20260521124708.177ac09b@jic23-huawei>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 27 May 2026 15:40:31 +0200
X-Gmail-Original-Message-ID: <CAD++jLmK5VRhNePbD=kt0THbH30HLYqDe_ahn3sOPkxTwBaUWg@mail.gmail.com>
X-Gm-Features: AVHnY4LHRa0uEz9hGPJX4PkRgVxY0ZrCUi_4vN4HbCyAwnwrKaAQqY562EzswE8
Message-ID: <CAD++jLmK5VRhNePbD=kt0THbH30HLYqDe_ahn3sOPkxTwBaUWg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: gyro: mpu3050: fix missing iio_trigger_unregister
 and irq cleanup
To: Jonathan Cameron <jic23@kernel.org>
Cc: Li Xinyu <xinyuili@126.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 1:47=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> This is interesting. I wonder why we paper over the failed trigger
> registration.   Generally that's an error case that should
> result in the driver not loading.

Right, given that we have an irq, it should either probe
the trigger or fail.

> The mix of devm and non devm in iio_trigger_register() is also
> nasty.

OK that's maybe due to the initial overbelief in devm_*
garbage collection. It should be cleaned up to whatever
is the best.

Yours,
Linus Walleij
