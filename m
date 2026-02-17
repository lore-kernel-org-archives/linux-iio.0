Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9722F3C18
	for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319456; cv=none; b=q/dp90bvJINTz6JwXBLpSs03tAJxu+M7G7IG4RGMBfBY9n3uUc2zyCDZWQ3Y/+gmAPQnACaRPksk1FbjcWMdLa0AEt7Ij0FCUFbQKQezgw8Rx1Ol/RXY0tqmHtSonieM1FLxwAHfFHn67iS/j1cwbtM8FZH73TLh0EPjlvHxhXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319456; c=relaxed/simple;
	bh=m+PYF5HLRku1gKdI0kHGLUyXsMlriXnB9EwffPAxHxg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=LbJwJ0vmfVYCpBkM/Lu30lpi1W9JtuOP1Cmbtb6xFfy+J4DWqwtQffGwOJ6TddQv+q4djWKPeLhExA9G+kQzIqXUmJzyfVGJ6Qzgpq4yrbKTW4rsuFRP17NCq9rITbOVtCfe9oXo4r8q28OkMsmZczdtD7Vuf73InVU7gXJPsBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVbqDUPU; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVbqDUPU"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79495b1aaa7so36657077b3.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 01:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771319454; x=1771924254; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+L3/Sfg7kYxtNnFCE6OfF5OEvIIuwdTenj4FsroQzU=;
        b=RVbqDUPUof3bh96VktlYWAZDyxzwYPatJ81x7bdt1778Q68GOucpT+sjkHXqxRP44c
         8WQUqrDyb8P336puJGEO9FWFj0uuzfjlCQObbOu22mGUXZ0Nq7taYgS8Fq60mSlFRYbR
         nNdKat1GK+tJWQ1DG68QkGhgP7rWz6gSJpOvLQR5IEdOGwLhXjzKIKE80Pa7aR9W8GoN
         aRGuTaX3RSlk19VGA3mWzfuvCdkL2dCQi5gcnrclpwyN+Ss/9ADAb+VgI4YNpDafgl2V
         QhUNTZzaUVIAZRezRB9kwdq28gz/U1S7eKeKnm0LBE7OPVN94EGBGnDSxhRRTakbvzyI
         lR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771319454; x=1771924254;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+L3/Sfg7kYxtNnFCE6OfF5OEvIIuwdTenj4FsroQzU=;
        b=ARLPktcyfNT4gGcgMDynsrBpEB2N/3tSsfQsfAvC7oVyZ8V8RkgMJrHYg/GCYvjoTv
         Gi3JyxK1FR35MM2KRxd7NewjCkEo8JSre/UQHd7xDgEtrCGeEz37pdmZKMje56pUVp01
         u9YpnCBnLAnnTxzz1ycpIie5UsA//dFuPlpBDxTY8FS20RrGxG7UTZl3FkV3ElxhHUTg
         UUwS/hJpCsC89Zx4jnnL4YactnG/Q6LLHuu0DDJp5d1seYjAMgC3WbBGqCQouejLWDWi
         jJ5CYTENiq7Geh70VotJNB2c4qugwoLd1nyD9Ohh64qkczjocaTBIsKegkhJJfoZtQ5S
         WKyg==
X-Forwarded-Encrypted: i=1; AJvYcCXuALhv+7YZPEmr+HOMJPN4EwvNxpKbyrobiUSxr2BnrYfUepB/j75P6X5sN4P2sXqDsJ87teCQBio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPT8Xe7w7BeQOKbLRRgllPk80vgsn862Kx/KL5rzaBDMXDCbNQ
	hlhnZJcpBGY8YO9VKX01+l9JC1Fm8TwwQ1LJRzPSW6BVB6PmuyOX9izx
X-Gm-Gg: AZuq6aJm6ktcNxpRfH51PfLcGIWhf66yX3Sssd+Vz7V7YZ820CrlQG65HCn3KQUnFG1
	edQ+3ofI/daJI2GyeaV+nGNcwE8dV/Vl8sMsf0hiLFRC5KQB1iEn0vAVH1NsLTVN6BB7OVEzUiJ
	ZbnHUXUuhouUADd53b9MVbBVKvUjDsuBaSSMWqGFylDRcLtLEXTS7uIe/vb06hRit63jt9u4XRb
	Zdy/K29O1xIRjxzyWRLltijLXSkkbuLY/lwtSJox9ix7xyU0wZfw9os2ChbpSy79TEWdhZZ+omD
	X8A6XGz8prVqu+qLUllqpWusiJvR6tsxffdrAEK9dwX+jkPLbsWXAMUCW/7DiZ+9cs6dFDhFTNr
	WPQFhBqk3FUTjhABh1+Q+RT5wYl/nrKOR7jFQ+DMlM6FDSgTXLTP2ZpE3BOU5z2rv/QuOvekn8a
	YJG3hhhe8OX9ieA5fp/muHgXW78/K+QarK1xkVzX56Q12By+cn0ga9dEMAds02viIO6RHRNBtX9
	4zt9ht9YPIDmNmeH2Amf4ZiFp2QmTDFnJErVDm2UlrtpRK8Ys6V/VjAP/7hzg==
X-Received: by 2002:a05:690c:86:b0:794:2019:2b7 with SMTP id 00721157ae682-7979e899689mr127964307b3.42.1771319453837;
        Tue, 17 Feb 2026 01:10:53 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c267f40sm109338997b3.52.2026.02.17.01.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 01:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Feb 2026 03:10:37 -0600
Message-Id: <DGH4C3R3V451.1B4RFJPLVQCI7@gmail.com>
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Ethan Tidmore"
 <ethantidmore06@gmail.com>
Cc: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: light: gp2ap020a00f: simplify locking with
 guard()
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260216005317.11763-1-ethantidmore06@gmail.com>
 <20260216005317.11763-2-ethantidmore06@gmail.com>
 <aZLCe_5C8e82EMGO@smile.fi.intel.com> <DGGOWGRQGI1C.XSJ585TPVWZA@gmail.com>
 <aZQovkDI3G9-B_Zr@smile.fi.intel.com> <aZQu0rFzPaDWnUfx@smile.fi.intel.com>
In-Reply-To: <aZQu0rFzPaDWnUfx@smile.fi.intel.com>

On Tue Feb 17, 2026 at 3:03 AM CST, Andy Shevchenko wrote:
> On Tue, Feb 17, 2026 at 10:37:18AM +0200, Andy Shevchenko wrote:
>> On Mon, Feb 16, 2026 at 03:04:55PM -0600, Ethan Tidmore wrote:
>> > On Mon Feb 16, 2026 at 1:08 AM CST, Andy Shevchenko wrote:
>> > > On Sun, Feb 15, 2026 at 06:53:16PM -0600, Ethan Tidmore wrote:
>
> ...
>
>> > >>  	int i, err =3D 0;
>> > >
>> > > Would you need the err assignment now?
>> >=20
>> > I'm not familiar with iio_for_each_active_channel() but, if there's a
>> > chance it could run zero times, then it'd run into if (err) with err
>> > not being initialized?
>>=20
>> Have you read my other comments? I also mentioned to replace
>>=20
>> 		err =3D -ENOMEM;
>>=20
>> with
>>=20
>> 		return -ENOMEM;
>
> Looking into the driver code, it has some serious questions about the log=
ic
> behind. I will send soon a WIP series for you to take into account. Feel
> free to integrate it into your next series.
>
> ...
>
> Do you have HW to test?

Ignore my previous statement about sending v4 shortly now. No, I don't
have the HW, but I will be happy to integrate your series into this
cleanup.

Thanks,

ET
