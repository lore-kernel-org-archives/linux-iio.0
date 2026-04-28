Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D642E007
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384801; cv=pass; b=uMgIUBdn755e1qHVpSZfWNW8o5l7wYPGeDbs3JPvei0UfYk3l06VaJeWo4KXzV74Bje0GTHcoQjFWC/NRgUwfCD4dGUJk9vsSy93tkoyXYT+zGOM7hQBRyEAj2MdGvLSNaL5n9uwDrbEftYgZlb0njGyO7zRjhTP2tppIVg2CWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384801; c=relaxed/simple;
	bh=2/z/5QS30VoVFNNvOJ/8IBkLezMlMB6oB1ALZPFAbV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LV7m4HjH2wYtxogRC4j5nQWyGsxspNrrFx4eN98sgAG38c37UocVkljS2npdHQxNelbCmdsrFr8lrB92hnqEk9ArZp8uTYBrSZkiXQX6+iumGKVM0IWaUOTZOi88rnmFcNnEexO2ESyQKZwY/y2gmAnj1Xpa4ofMzE6xomWbXk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZ0mczE1; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZ0mczE1"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6579254f996so1996666d50.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 07:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777384799; cv=none;
        d=google.com; s=arc-20240605;
        b=akGQrvWHxKnwO/0OomIsfYpsj/whezWZrIAVma1UO8cCMKtzWEnzMEUMzJgT6yAJyN
         jzq4o6dBMCHNyJ6ofNN8cCe9b9P5M41fiOC9sr8s3bXAA2GOPBxlM535qYgyk2LT/bjo
         FzxyOOJsu8Yoqcg99YMUwSxcHnkd295qBdI+/afbcTYWOkToX0uw2HlKugTscTTp12co
         Ahw8h2575G5U6jZE4gud2T1Xq5Xx8GPJKaZkuQG5FByKXcvD95HKTUZ7veJMmpKb61KE
         xa6PBRKp/hAFWOK87pSbEUyPWqdlb3rrPicefx2omy4jgcifS/cFB+Bo8TlWyDR3/4i6
         8VZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YdIvkdMzdNSftRr5TN1vHqcFG7sn7uEgEfW8dWni+P4=;
        fh=gfu3apFauF0h0+VpzkDDRqCFChIf0bBesOKs2u9fZu4=;
        b=YDoVMZSsmema1bYadoOn5Ii7qqHE3igsxtns+/LeEvKdE6jWObcA8lLK7aMgGjl7rz
         Iq+qpo6wl9BeJI2rN8Fc/5+3ORzsvI2i4/aAxyjaMXtXBiWXjapwwLN/4z1KV8R7nbGY
         QWX2qZBaxHi77JoA/1/K7236X+M7Pgxn0ex4qxyMoR24dU8mKqQr1N4f8PTdm76JLRMy
         esPCbVmoe/TnXvfBOwgIEbWQSmqLqHsHhFnp1NITVrQDltK8hh82xXale5M/y9h5CuDp
         JHSFKOJtj+fsJaOd779PsbGR+gVhfQhoja5jcCCEq78kPENLbkQbYDk+sTIuF+UpSx41
         4gTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777384799; x=1777989599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdIvkdMzdNSftRr5TN1vHqcFG7sn7uEgEfW8dWni+P4=;
        b=SZ0mczE1AU+dOhbcmHS6EYWyFoTmeL1vzF+jxiJaNbEYfibAZYmILOALcfyG+mNIkB
         a3RcJvWt9xrTNtY3Su6muKL1V9c5DqCPhGG/AVIQO5UYq9y8gpFHv6WOMNxLOSLOjYJt
         Qt2ABuqNmOzz+NwBLQSdW3OIxpkrMJ3cR6zfq1akt4Bb+VOHwmXVGCYau4OQyt/7AwYa
         l5DsyjCexXRGAoWBFC376x+QxYcdAoRcH6QL8fy+9rNPg2N9mXHzT9SJPYSVTgqKZALu
         ZumhiZNuSIbN5Gxfgp3WJtwiETGQPD7VAoqkxPVlshs/lv1qG52fXfIhIPyebs2qYAeV
         A2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777384799; x=1777989599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YdIvkdMzdNSftRr5TN1vHqcFG7sn7uEgEfW8dWni+P4=;
        b=KiL+QROAlWYPWX651xZFsbB/i4YpmZbIxZHY7DHCYcc/U28DFnsz/sq/Mgdvwzv3DB
         H6dA8PJtpj5s1AZp4ABfOy89IcSUfdMPOYxg9ZRlugEGrO8W4dK177AsmldVHscSHbbn
         r24rR7yHdyYLvUpoF5QLQK2/f7wLS61Qe5PSOpjY8TntupUZHwbi1hIM1cZpvDLPiKU3
         caD8VJYBjJyUp3MIvsESyVQoKcJ3GoezSJD0ZQVKHinE7G/+2M54lNp4G5mNrm/950Sw
         KMNo9Ik0BFks1211zmlW9TNyzMHy5PyMajVzqoAbVJuCwbyIQUlRKT2ysEt0A65cwvJ+
         m9cw==
X-Forwarded-Encrypted: i=1; AFNElJ9E5iUN4+Pt4cL5MXSxaT+8bNZl2TXmk27y2zSRB5IMa4cNkCp7cD3UEMpW2hDUVeBQfmtolLvNCjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIcPhJMcDXDGrhm44hxuGgxKBUmgWk+EssXiA0SaqoKYKpubX5
	XQI0tf36nRPJVPiPRFm0GDgnrJRvbT/KzssLLAHYNx5ejRQzG+YUMArwgjnSOyAfR4QqXb863cI
	Y4/uIYqwkFaN3cvEY3bQYQMQdaeOIXdg=
X-Gm-Gg: AeBDietYS79nIwmRiVlW17M+3gI1+OF1d2MDgXIjvJABsgboEWI6MgAGbf3jZdYyqz2
	pFYyCF0TrGk0U48bZYq2xo5xWDipgDKbqMGVFNPHi+4xPp8OrRyZmbXHdBp6+YiXHJN7OWnm8ZI
	9Si3tfxnSfmbcFKjiVjXK4c6UpZ52RpL92CyNnVQkO/xo4fHShPH7oXejv3dfBifLuzYZMsg3mE
	nHgp2PGZ7+Benf448gOdXxHit77S0/pIeS4UsPqzepU3u7mffdZT8Cdvsild/WgcGSraBBBOW20
	/MVdpTdZ23mx54o+cMr9
X-Received: by 2002:a05:690e:2454:b0:656:ad2e:9907 with SMTP id
 956f58d0204a3-65beee7d830mr1891027d50.41.1777384799494; Tue, 28 Apr 2026
 06:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428124644.49707-1-m32285159@gmail.com> <20260428124644.49707-3-m32285159@gmail.com>
 <afC1mdCZGZKHQx5V@ashevche-desk.local>
In-Reply-To: <afC1mdCZGZKHQx5V@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 28 Apr 2026 08:59:48 -0500
X-Gm-Features: AVHnY4I-UAQI87IRYnl3W2TrEMcgW1DYcVp3nGrCmYlyY4ezuw6FPxFhA4TvKNY
Message-ID: <CAKqfh0HfbUkAFDpf6vmBba+JGRafemoP0HeVy5hzzQB4=Y94Ag@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iio: magnetometer: rm3100: Use scoped_guard() in rm3100_get_samp_freq()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 8:26=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:

> > -     mutex_lock(&data->lock);
> > -     ret =3D regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
> > -     mutex_unlock(&data->lock);
> > -     if (ret < 0)
> > -             return ret;
> > +     scoped_guard(mutex, &data->lock) {
> > +             ret =3D regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
>
> > +
>
> Redundant blank line as ret is defined elsewhere.

Shoot. I'm away right now but once I get back I can fix that.

best regards,
maxwell
