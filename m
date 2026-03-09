Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81117332ED1
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080173; cv=pass; b=WiWos20aF8uP9BJAiD6bjiEMV1Ek2ToFiqENnFokJiQnk+0U1sp/N6ODGF79BSuJb8AfvJDGGaZNTeS/t5CPUVDEQuaRfMw1JYfWHfXnWSld5chrBPcL3YON6CDaVE5L8aL2MACZxtdjlGmeD0Lp9dSTg1ilz153wqhQ2tPYm8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080173; c=relaxed/simple;
	bh=9+0hDyigqZznUG8rugSeUjNR902bKhhv9aeGL9Vq/Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsooE/g6xEIV1LbxW7s5p9M43LTxm43x2mJPespFE+fI2hbVnu7IC/IE4owZF6SGNvPCgH9qpOX0XEm80kmPrc9K7q/J3nTaDrfz3ml+Ojnj+SgbrXlslC6XSyT8SppV8jdUyqMGyWjCpGvZYT3Funbf68Aere0JTr6w41vsq3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D85WTxln; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D85WTxln"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6616cb8c80cso6479474a12.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 11:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773080171; cv=none;
        d=google.com; s=arc-20240605;
        b=Y4X5H7jTXGuSNeHr1d41h1Q1J9hBUoVyCvJpYd1mdNiMARGZ74uKWYg6s8u+Yc1zcH
         RdsiWPVjOafYkYm//3tYgUt5oye0pJ1Mn0vVYwaNXfUbKVV+i7wnYoAF59zpMdqG4k1J
         WBCAa+gVqFZKLaf/quI3Rab5gijsB5eBjnc0HeOBYUYRLfVdneC51qYNp/XtFpWXpBPg
         uhSQSBpnWMsEQWZytK8ul4g/qaNPduGn6PoVbQkQCIHH/ByalDCaCM8/kTNkFb/9X0cd
         zbQlM6kHYOuXr0k9pH38J25hb1hLa+eCPeBsPGcZUfnnJ6q2tduit+RBVVQP+oSAcyP0
         auyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9+0hDyigqZznUG8rugSeUjNR902bKhhv9aeGL9Vq/Uw=;
        fh=1AxHXYld9vF1CJ9pkJPo24dF2IeRf+BzAX2DTF8MKhs=;
        b=jzvBP8wEaS74myXg8do98htKfu2NiHeinWHgyrMZsTNHk4smDn28YX8+rI3Py8ecKo
         CYpX4lQf4koiyYgLu+Gcd0JXT1/6PyIg48m7B0QnMSf60057K+513zLvwbqzIgAlu7UR
         +9iDAnIBYtkTM5WGHsCdw+Bw4Zm6idN0/OdgP1zAi6rDra94VQpan6Q4kgxocJBoOM0S
         K6QS+5q1FanBCXnb6IutX9c/e8Q3zqbVYPL63zfwdWSpzHQcMSH0EKBgMeLt2ETAulu4
         IU49IAdaCWjpCff3mekPBzqz/s1Q5iV8hgX+dQ7vF9lrhSPuGMj+HM+TR9gnVPPPUSqj
         sB4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773080171; x=1773684971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+0hDyigqZznUG8rugSeUjNR902bKhhv9aeGL9Vq/Uw=;
        b=D85WTxlnBxxah1ksr2CT0hjWeJJYsNPRoyUPPhLIt8DwR+9aX+uVtpaDaN6hOs/PiE
         24kvP0k1cYkDcb8H7ddzz8r/WHJuUCDDSTK5gDim+oBAtPf08PO8ybzXeWFd2wV7t2Ny
         FqpRjgKB2pkfYeq5iHmLxKvDCurT1a5F1IIuJk4tbb3v0dv6eJw6izwhq6Rf0tb8AaI9
         qnqDCUB1uhlSyQVyRLAZJv0zJ99qU0eA66Rz4hOFgVgifXw8/DTctfhgTy3pApAXqU16
         QJBeuzj4IBka6RYN2ncBCltoVJZN+pKrA4H5/4svNyRuXwb41qBmkHCDZURBtqZYnqX0
         iBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773080171; x=1773684971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9+0hDyigqZznUG8rugSeUjNR902bKhhv9aeGL9Vq/Uw=;
        b=T5tEANhmbX0dQFSMgjDA2mnUJTs5AbKovLQAVxn3aWQG1Ztjv+0tkR/OQmY+TVoxCE
         Osm1F8P3LEQn4yZnAesCF9BgsZ/flQ/l5KcecTV3iOXZg3rzvkoVWgmIG67UmMqyB44+
         QGJXXu4KttWFnndTxw9rXYCmbUjef3pmhvJd8NxBCy0hRvyarwy+a+eavi8nDAUXrgHa
         Yc2+OLCfiF5bEezxQaB2teweyl6H1FnI2rzUFOJ945GjfVu9KMgAWl3IcjRtVPTkWrc+
         FO89cCP/pmZCbjVuQ9WrM+ugBE6B9/DR4WiAfG3m9lrKfgcqR35eNrXXDDuANLG3o6kZ
         ojpw==
X-Forwarded-Encrypted: i=1; AJvYcCXLrUi2XEvy1XicnsmH7WludUx4JYJ1+7WQGV19HHuaENm4apvOuBMYWsqNUsFKU9mW/ngdSwp2spY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVaYrWyC2B402C366hp/J8e5sLMWXN/40whCbvQ9IlLw6VIJcj
	qmIJK1W2NkxdKpnVZatuXCK6g1ppD5wi6fHY2dncc/NNIn71zvKaEv1MZef2YEG4zs2Y/44ikVc
	vD1NYmJ1DReVXfhCjJad2SjWfnVd9MZohIA==
X-Gm-Gg: ATEYQzyW8R1nrvKFgmu6F2wsvzGe6aT5z42h1pieEu01s0JYTy03sdzqy+2dDVxJoLd
	b4T5fiUMxgJ5tPDY8zGuxupBRHW2sWizNLo7bVR4eHAVeEJD4A9mOxjYrGUktYL8wZV58L2Gt64
	bTWJ1qyRy8hhqF/3Ls4aAUm5ql57qPjiZ0LsRLnxLt03MB5YZ3NDbl2NjllNiT8OhXTFaKcsbJG
	FjjkO3zHZG3B6O/xFW/+BohwKtxa10sfMjoiTHH5x3bfOnbKhdk/pCM2jOnxH/M/APeHDqpZVYB
	+MyQTCoF0ztfdGLy86ZlPjedB3Xu7YUN4R9VVY+7VeSIH3CO1cFzYoGEGDP1jx746TXvSvAn1+8
	q1hIjK3+fnVyPmidrfvplvEMAsIqMvOyjRjCJsQ==
X-Received: by 2002:a05:6402:4582:b0:662:b0cf:b993 with SMTP id
 4fb4d7f45d1cf-662b0cfbbc6mr670121a12.16.1773080170702; Mon, 09 Mar 2026
 11:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
 <aa71mdKAc74CNhdd@ashevche-desk.local> <CANS1Ubiz2Lcq6fkq2yK0vzcxXSBGOZYdLr3XWGkmcnZLK9RHDQ@mail.gmail.com>
 <pndwlzk51j3.a.out@axis.com>
In-Reply-To: <pndwlzk51j3.a.out@axis.com>
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Date: Mon, 9 Mar 2026 23:45:59 +0530
X-Gm-Features: AaiRm50YuYX3gP87ADbsHmu4i_pYutcY1CQH2eU_yOkGWmN4laahVyeAzyIwH7I
Message-ID: <CANS1UbgOvWHxFqBtcVVy=E6KSpviGGavg3y8D=H0LAsiiQYbtg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] iio: accel: convert to guard(mutex)
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linusw@kernel.org, 
	sakari.ailus@linux.intel.com, harshit.m.mogalapalli@oracle.com, 
	antoniu.miclaus@analog.com, andrew.ijano@gmail.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 11:27=E2=80=AFPM Waqar Hameed <waqar.hameed@axis.com=
> wrote:
>
> A separate patch can still be in the same patch _series_. I would advise
> you to not change anything until we have a consensus here (as already
> mentioned in other thread).

Yes, understood.

Thanks,
Rajveer
