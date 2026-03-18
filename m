Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CFB15E8B
	for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773797303; cv=none; b=Vw5FedNYpzSML0zzGHvzmfacrJcLg5VJ4XEGKGbuWCkYIjHt23UQ1PW//syMcHOSqUfagGtltXkw296zWrs3+P8jb984T78/GR413z9q9gQstepW0zNLjnP7aXSoNvDPNAgemMondFkngD5PIeE/m7pvGM77b8+8UMJ+NaaFYu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773797303; c=relaxed/simple;
	bh=D/vFvlz7mnswjWr7ccVTBYAgPfv4L/kFCLA3fQaPfK8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=g0eH3L+YWq9UTyhVFa35gnipXG69dKngC0q8uRjlVm19Eso2ZcyQtdW+W/305Os+OHGREsNGwuAmHGETVpwn5VzYzFe5VS3sjcn0sfjyvuR0ZAWm88K4P+uesr6Kqv/Fh0hB3nmYpacmymKFdMEG4Hn5fnWLlpa+Wngi1Ke+IDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/Qaf/EU; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/Qaf/EU"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79827d28fc4so1993677b3.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 18:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773797301; x=1774402101; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/vFvlz7mnswjWr7ccVTBYAgPfv4L/kFCLA3fQaPfK8=;
        b=c/Qaf/EUGqOqQqeuPAv1PylQw7SsTvfvzPTkT8hiBACmWnM719guAANatTY52ecx88
         RdWNzzcHraW8OWRBFQG0ppzBPb0lN7O/9tjhGXYfUzeb9SttuR/xw1w+bh7zN7f4H1dV
         Sp86Vv62nlAal1UUQVgIdFrV7VhC9ClBn2zAY4F8jJroVWGpq+dFCjsIbx4tICiY/oFC
         b18MMqBNej6BGU25zZ+4FlPQnAdTTYJT83gZVCVEmwiWAKS8xPOVz/s7RhQmQoyUhwEf
         9owShN4qTfh2+6AqpiX9mQHXtUBwj9Ks4ZRvg44203aZ9x2GzHKNgnScuTD6AAgM4efn
         MCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773797301; x=1774402101;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D/vFvlz7mnswjWr7ccVTBYAgPfv4L/kFCLA3fQaPfK8=;
        b=MK9ryz5WpSMZS7pkK6fNNG10H6MvWiNPoExLVXeGp9FvXfUFygTGVYMyvBlxakyqOl
         bJucZBY9srr0tBHS348+yOeIz1DuzOrxT4rlQ3CNaV7lHK7oQn3LROg6tF37O4PCPLVz
         KSs2lt9bgHBPKJwDauFCXQx0PlqfyAnbH7WlwF3260Ddt9bhuupWntRPuU9ykZaB0Zji
         HaS5JeMlLa0rxAJRWti0/jjM9IxkJWy6RbuuUYKkol/k+R1342stRdTKaEDehtpkqSaG
         20+z8FnoHJsnh/xQQxV7xFCmQ9lesEnEjCA4EzCD5KN93SIsihYzZk3O0k0tI+1XT8tt
         KWQg==
X-Forwarded-Encrypted: i=1; AJvYcCWwQw+FqLTp4PlTzwYjN4/60UWpqdFveI0BiK9L4PSaVuINxoGcE+DyTnkPtykw7p2ZNsJvQK6L3eU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbi0GfKjn0Px8NKCFg7pAz8+Nq9f5nisk/b5xxlGOfhEF1GN2p
	Q/pDX0wdERuriNesCq1ulePPWc+l7JeUgFvdkbHjI/bMZQKeSdlbeOsn
X-Gm-Gg: ATEYQzyIszTuf67vm5QlOLkge3Tvbt8KQ3V8r3AXPBGJ/ON/XBJL3NPLV+nlYFWl4eT
	uzyWHEyGs0iarqI2HRAUA9hgeDrTWiXxyUmQYAlYmLqmQ3LR+VvD4eLYJTijN8w3s/lw4aNNSjO
	9oPtXlC3HmOScckXPbdyYw8xlv8vMh3t3jZ7imbaRpzyQMtrXoa92JxR3Kg1w2UpRyiJotvR8OT
	DHkE7XHn6YkrXzH62U/5WnY+q3qZCl/nLYvDmYwu2yOiICsHVLArQ0uVAATJy2SRc2qlIvSs1uZ
	Nbg882dDBvrO/93eAyYWZukhjYmyk7wCdoSF8cCyjx+MC//KZfgw1zbx+yO3GDfrHMS5QgBPwjv
	eQU33zGqINh+cau3FGqp6WQMMUysfRj/cpuxVVPllLHgR00US90ynRMK5KLIzZ0oqmmP2U+jkey
	N8HYe9K0rWT6X19gS/knbSARaW5+52+XVoeWsFnCSGLmsWBVxUeXsyMMwpuqqxyaLWXP9/xviG0
	QR8Ha3c1CGTJyWngpKh4VjveMrCv+SZWh+Guk4Qcy0=
X-Received: by 2002:a05:690c:6b82:b0:798:7e05:ee9 with SMTP id 00721157ae682-79a718c4a8fmr16913527b3.19.1773797301101;
        Tue, 17 Mar 2026 18:28:21 -0700 (PDT)
Received: from localhost ([2601:7c0:c37e:2360::f769])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a713d1d29sm8226747b3.14.2026.03.17.18.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 18:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 20:28:19 -0500
Message-Id: <DH5INY5N2FHG.28BPSODTP2T7Q@gmail.com>
Cc: "Andy Shevchenko" <andy.shevchenko@gmail.com>, <andy@kernel.org>,
 <linux-iio@vger.kernel.org>
Subject: Re: [RFC] GSoC 2026: Transitioning IIO to guard() and
 scoped_guard()
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Ethan Tidmore" <ethantidmore06@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260311194624.1521-1-ethantidmore06@gmail.com>
 <CAHp75VeZb0pSiAkHo9QUeS+2L-qP_83-dKKRSp7-1VfZrtr1bw@mail.gmail.com>
 <20260314110758.2fc20704@jic23-huawei>
 <DH2PF86XN60W.2MVDUHLKPR7LH@gmail.com>
 <20260315184140.6f34f76a@jic23-huawei>
 <DH3T1X5IS1W1.350OY1AGJ315O@gmail.com>
In-Reply-To: <DH3T1X5IS1W1.350OY1AGJ315O@gmail.com>

On Sun Mar 15, 2026 at 8:11 PM CDT, Ethan Tidmore wrote:
> On Sun Mar 15, 2026 at 1:41 PM CDT, Jonathan Cameron wrote:
>> On Sat, 14 Mar 2026 13:08:04 -0500
>> "Ethan Tidmore" <ethantidmore06@gmail.com> wrote:

Just found out that the IIO Group isn't doing GSoC this year. Will look
into Device Tree Bindings instead.

Thanks,

ET
