Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176E1EFFA1
	for <linux-iio@vger.kernel.org>; Thu,  2 Apr 2026 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099226; cv=pass; b=H1iPhW1c51VnHKYwfkhDmGpRgrESUwT8qQI3U+oZ5wEMPKpB7Cb7SVL6weEk7wh+VYtRQWrcjNbS8WViBeD8YjtAPiAvz3VwxRayLV/KQsZpLS7WxfuoteipQ7ja1JwQWzqtgx/gdYX4OeWPsrJGA80je3vx98FlYxWcFMgT8M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099226; c=relaxed/simple;
	bh=rAl29/omZqAFzC9VGpUD6vYypdAK0eIo3cP7bpRpF9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eg99J45plx4TASqsSE3JvbuJnnIJCOV5V5GFjqlAGucYrZ7Srlpu3lTd64crzKD2FlQiQNzWi4J5rnWWfWNB5yFUgtKRV+XTsquWjRa0npYSHJJhzp/ddDWcdR3u+g6AxEOW7Rw0ShuQlWIsXJYwLevOdPa92tXnIe8qqFl7erI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHDi78ov; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHDi78ov"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6501c0399c4so393421d50.2
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 20:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775099224; cv=none;
        d=google.com; s=arc-20240605;
        b=BGnLeJaUelBWt74bQrQG+uXb1l+Rua7jzDMrt6Ss+vcnUg2BcjegVDX0EzKFZLvuYH
         OPCqsqgfPXGnEGRXO/tkPv4OXsdJCTfjzUXN7Gx9R1eXfAJLTdgpJP+RSaJJjTfvlHgT
         8EIWUkq6YvSJUsg7DUdtHi+z3k2ois9B3qvuVTEsSiL5VGDMp9q7ZzcVFvu264CRi6ZR
         sTQfvNTqkzpSgxRsD0YibZn1uOcifvTg58hcdpYjfPpIdfUMJelEBZZ0Y19wJy/Yyaua
         YfMMtm6L9FELSA4X94/DQ61NZGskkhCrhvhk6XqsfjYrFl09Km7jW51FXDfUVfhpMiYT
         uAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rAl29/omZqAFzC9VGpUD6vYypdAK0eIo3cP7bpRpF9s=;
        fh=kBqPSAyhJ0iEHV407KLbFCPWQgo0+idysc+BR3Eb6II=;
        b=TVtMKvfxB04YG1Gc2uaEFxLSZW/RaVWAHfQCkAx9JcWDoI2JYRXkm2+1g5/uEVgFqx
         z6bQEwle+FWs61RT8LP7irUwWt4iZczU5lmbgnVQewXaHvWll9yzWYEFForMun0zmeDj
         PDOCyImGi/vnt6MnDP3hSFDPbLUI5k5e49CjHq8Lr3k89MkLkNFuGLemnh05BlElDSLt
         /8mSni/NAVfe69fx4Nr5NEeHc8wmYJ2ere5QLl6jyqMLpEHknyHoXFM/uhdbQXqFq1Gd
         7UTooJq7lQZZXyB/P9i7QBIt6AJVTsvyKQ1KiZsomotKZbveMNeoyUNqPSXwFlPGrkaL
         5JXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775099224; x=1775704024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAl29/omZqAFzC9VGpUD6vYypdAK0eIo3cP7bpRpF9s=;
        b=GHDi78ov7OumBz38rMHJUqdayUqhZgdbd2BV0bIZSYeSRG7vT0wxmyeWEhM+Xvb51W
         +VKOaiTNyH+dUfNgiL8j8iVN+X01MggoFaX7qInZHA7DsnworemuRchayc6DcqNXUWEk
         hHKAG33tjsALTbj0YxwXL8oyKFw6bthNlSvFdh1KoBVNdcNrMQ6B/elROoaDBbxjF9ll
         punVDZOO9cWqfFK4d19L7DyFelQcgapJ7UuSkckhErbGNQB0lJSjdPgDLo9NawKrwU1a
         x89mi5V5anRf+UBnRptbgh9KoHI43432MUSPAeBZlUiPNe6enDH6RcNwQgn9fx1ok4Yp
         2/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775099224; x=1775704024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rAl29/omZqAFzC9VGpUD6vYypdAK0eIo3cP7bpRpF9s=;
        b=MuZ0u4j3qkJjgQoLMCtR/ydoc3Qz+DZsh6a60xY48C49d3YToh2v5D7pk0PP6u2joT
         vrACGebO4OrZPmdsLz8G7HljkSY5iHHuzn0boGS+9MJhyfd/ZlmiZHL7ooaa6n9aua17
         k18bboQu3XEUNB2dQ6Bcpgn9P73Lyy+VjK192LiflSR0rzopHIweoTScaZSBKVrLja7c
         5svW/dD6mBYlFYWPMlsjBNuTRfXQfKzhZBqz4IBRSN7xxPdRyaSUcgBmaOavkKMUCoq6
         1+CkR7RTV85B+C1HcHjEJOz/JACaRA8s0Del+BmnUFeDPb0+I2OV151NXpvV6kq+DNCC
         HcZw==
X-Forwarded-Encrypted: i=1; AJvYcCUWk+9qFRh7lCFLnCRBhTGsONLK1sN5Ltxvi7jQgNKe2vtdAqDzjx8VWrlPAEQxhph/hUHesutARcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztukjcS27E7klWMbcs6G+I//EL9EhDGGKhNjzmH7J5h9PxFEdD
	80GMMI9rVbLBdDEcm3kU4HouQpFpFkNYN9ua9ZWTJUjGPWhNnmx0fcww3uoQyM1asPN/l0ReTee
	iR+hW8USUl+Dv1LraUs72/elH7V6wnK8=
X-Gm-Gg: AeBDiesKEbxFC5w9zDp+pgB4tGQ9wE6Hndmxk7XwRUgYmtt3GSjXlJbc8ZS31yICYpm
	ie33X24Vb2YgZQOMq3dYC0rR8Ui4v5Ls1kyqGG7n6KXa/k6nYmpw47tFQAScHjYdCrqpdzYLUMM
	fypG8fdEi85e0VQLK8sTogB83asrPSUq9ozyXKc/KT0qlkSt5a2M1GKlOYwr7A1+gVuvawJ20/9
	oRZu8dlgw5uhg0DqH6NxW4eeiR7quFvDLoTU9miFxpKUtQyTjyMqD7akuCQMGnHWiKVnmDlIIWe
	ZA7JzkrHS8ZuMnZyvz2rceHiDeHGnU9r3DzYqg==
X-Received: by 2002:a05:690e:169e:b0:650:1bff:6045 with SMTP id
 956f58d0204a3-6502fe618c6mr5524321d50.54.1775099223961; Wed, 01 Apr 2026
 20:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153159.204124-1-matheusgiarola@usp.br> <acwfgI6LCjPZi5KS@ashevche-desk.local>
In-Reply-To: <acwfgI6LCjPZi5KS@ashevche-desk.local>
From: Matheus Giarola <matheustpgiarola@gmail.com>
Date: Thu, 2 Apr 2026 00:06:51 -0300
X-Gm-Features: AQROBzDRslmIgzr96D-LOK4utVcom-15jymWR1NWV_kV37clX8I9eMYHeTlFng8
Message-ID: <CABGH8=ZAtMRJifMP4sOXgv1MTC+4Nba_ud=T16cp89fsj00Avw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7280a: replace mutex_lock() with guard(mutex)
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	matheusgiarola@usp.br, arthurpilone@usp.br, davidbtadokoro@ime.usp.br
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 4:24=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Mar 31, 2026 at 12:31:59PM -0300, Matheus Giarola wrote:
> > Use guard(mutex) instead of mutex_lock()/mutex_unlock(),
> > ensuring the mutex is released automatically when leaving
> > the function scope. The change improves error handling and
> > avoids issues such as missing unlocks. It also simplifies the
> > code by removing 'err_unlock' label and several mutex_unlock()
> > calls.
> >
> > As suggested, in ad7280_read_raw(), wrap the IIO_CHAN_INFO_RAW
> > case in braces, providing a scope for the implicit variable
> > declared by guard(mutex).
>
> ...
>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202603210357.KTWqlL36-lkp=
@intel.com/
> > Closes: https://lore.kernel.org/oe-kbuild-all/202603210411.t4KwH3aX-lkp=
@intel.com/
>
> It can't be right. The bugs LKP reported are in your patch and not in the=
 Linux
> kernel as of today.
Hi Andy,
Thanks for pointing out the wrong tags, I'll fix it and send another versio=
n.

Thanks,
Matheus.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
