Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED36539283C
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778363623; cv=pass; b=Ambg60sMlOoKyjEMiiO/Jxp9GK3Uizu6BC/wupXdfqU++hkey5gVVHAcOUHryzYoqlz8D9SeSa+aBgcDcKDls5mw+MQ83hV8VaNDcCtkD6q9/7qqixCXVEBbC3jvYX1HUDo3gRSG7knofRF7i46t/tnRnrq2BBkqaa5l6yEiScU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778363623; c=relaxed/simple;
	bh=VY/JQUK1xyPdExLli0/zRnB9VJTDf9jidOYHgpz/DWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bo7I36PpLTpPsJgVQPzm9gyGkZ0J886ufHLKS+kcyGJ18cyy5ILVVYqNLNqunxHO+gbTbC02CoV+VzCyXrUtItjvz6S+5Of80v3hBKqsjP7K70uUalEkvIAtxQgUwMAW9CyqfJUD2fKfCvMnLUqKT0WpKddW+XzR52KEvEH3KNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sLVRQSKj; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLVRQSKj"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7bdaa68cf81so30059457b3.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 14:53:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778363619; cv=none;
        d=google.com; s=arc-20240605;
        b=UAoOU1jWbMbs4DsFj91w/wdsesXLgxz1OVQW4C9X9J9XUA/4XSjtZd8a2QNYGAIZ+w
         7W+zPhJC6mMZRskcI6xFqLBmsC0LCr/glLSOlrKV+3PYtJdaxG5oDm9X2Hk2FHCatnpZ
         3CJ3nQ7bdQ77zzN6b5LEN/9PASuQ+9AFpT1vRMgx752X5TOFxpG2g1ZhQhNtDCGRizKL
         CHhFkjprW5Y3bwGNTc7ybvpGEZOg+dykb8fSun0FshgJdgbqEN7prWLVWsfnpZMo/yDM
         xaO8dGzeFKEbl8SciWNOz8KE5EWfNE50z8umAG4n4z9I8YybdAt0w1aaPdcQtilj5J6F
         nofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6XC8FxtqfmzljgDfqCU+LV9yXVqVBY2mn1OHm3odAnQ=;
        fh=GeBaN7jFozbtB/wl1Y8ORkoz62TYkkEHT5Ye+FC+X/U=;
        b=kB6vQB0On2kKSF9GyNg6UZq8MTnKzjyT/mjdSjHLHEztEQ7OnmTCwffOfjKtG2ARNO
         8Yk1dWD7YZxBi8TQKdTpqdfc8fR7gGkVeGp3VkVcnnS6cWNvy4nRtgYWrmbaxFEyNwwu
         H6YX7BlkA7ZFQmG6M3NnqUcnCV6hLMRPMZk98nloBdYlovp7yWFkaNJhH/0cijkPWcrN
         EzQRHXUI/W/edmHNyb8LKp20lS1Qn2ih5eha7hFRlXlieH9Pr54GjiAuWaCm5d4hIJB9
         gQvOOtAyo00tFYOqkjBP9jjkJaR6uxvKzMK9bbmv6ly/H8kzO60iyiGrm7SIf8DmWu4a
         H54w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778363619; x=1778968419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XC8FxtqfmzljgDfqCU+LV9yXVqVBY2mn1OHm3odAnQ=;
        b=sLVRQSKjZ2xWqet06ROwaJnCB0EF63ixjMeXMwt3ZI95STewMAUpcrNhQ6uyIl/Oz5
         AfJo/IkhiQxmHmb+/bkOVM7QA/TXnyhXHnzNn1qQLBYZ3etTPoyVNsZrFsna1hNqqgKb
         u7j+uIKNkz85UuzRz0BBDGdTYUDKdf2+B5LDoV3pOjroQWMHARcoAvNjuvtwBw4gBl0i
         LvleHe/UjQ49Ere8Li0F9XrG1ehwb+GlJf2+3kYc3S0s0mHIYgx6+uckInfwi+zlzHgY
         31sVlvfo63kJ4WLNsRkbQj82dxCn0rKajXbO9te8U3a1wCJ3jYh3WHYqOXU7gEI067/2
         awGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778363619; x=1778968419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6XC8FxtqfmzljgDfqCU+LV9yXVqVBY2mn1OHm3odAnQ=;
        b=AhtkB2O78FCnKbrPcSztKmnsvEsitB/l/QCQwLqkWToGaTWcJoqZuVe7hSOr1dnCJl
         Sak/cvXdi89mpvr1UV5z1edI6v0mj22lbFNxfKPrwe2Rs307yeCv7n79qk+TUVv1RkHA
         siyIt5+Nkp7OQTk/1X7/+EbImyM0Zvigel0NrfKVJcVDgIA1sH0QVIsIs4+kzY/8SQRN
         4FBb/09KkqNw+LgaGiw9HtgY/aSVEHIa3TYog2C/HUWhTOWsiQM/nqmQ0Z/Godm/u2qF
         VPI+HvX2ZrDR9K6vFTkD5NsYl+F6MyZqaSfWw8rZnOZUP6A3ULT55lyQKTOrd9Ojzn3W
         Mixw==
X-Forwarded-Encrypted: i=1; AFNElJ+UburO35LeHF5ZwE77Oc4pWTAn/13VFufldTb5XoadobnwUIdI4B2+SrXc7i8ljLiS5rGrC3j6aC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGhTvv4dqzp6pTzFEf+KIar5GiUuYi2sv95FISmH1TkSCyaNTt
	lsRyw7Ytf+Oh3gOkSpfmsSFLp7Jpoo9YqfhGve36dfP83xi4dlfU9GIr58rrgbLb00EPw3JjVgU
	hI8xB8NCdcjZXP3hXjrCx7vUMJo3fcHQ=
X-Gm-Gg: Acq92OHcGr0SI/7DHhCAYXeVwYH9SC1mDMsptfbMNIgDjhwK2tFV7uoZpxpLZPQSEDg
	TJ/WcaYgJWW/Xl4xjvLiN4eokm01WvdDMaD4ph1ZrtD0U7YhV1zqCdgIWiJuPGE5e0fdDfCscV2
	F58DgBUPuMCnlGgIz2V2jv2aDsWIwWJg9evPsXGojI6zJci88SOwFf5wnzbBgTrQg3esKHGPcom
	Z2lHhYzD7OOJBqds7o8N5gQsK9pHR8dXtootuf8saDTxE14FfzYC6OemKJFk/eouEHbRgkGHda0
	Zcc/
X-Received: by 2002:a05:690c:289:b0:7c0:861f:5bbe with SMTP id
 00721157ae682-7c0861f5e8emr62792347b3.10.1778363619408; Sat, 09 May 2026
 14:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509211921.84969-1-m32285159@gmail.com> <f7c6c9c6-c5d0-446a-bbbf-6991f6994375@baylibre.com>
 <CAKqfh0GXzfUMhp0+-BPpQ3ra3H5jSKUU0g5RnAtKhP88RDocmQ@mail.gmail.com> <f3030dd0-123c-4b3d-8b65-148058dfd44f@baylibre.com>
In-Reply-To: <f3030dd0-123c-4b3d-8b65-148058dfd44f@baylibre.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sat, 9 May 2026 16:53:28 -0500
X-Gm-Features: AVHnY4LONGLuN5Lrf1VK9Y9i_AKuVzwP_BfFqbWUUhn2KUd2iK3e-S9oyijgJMo
Message-ID: <CAKqfh0HUttZhhC1ysiA64rxMztBvfuu+d=m2C8TrnCUuWzT4Gg@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: scd30: Prevent potential divide-by-zero error
To: David Lechner <dlechner@baylibre.com>
Cc: jic23@kernel.org, Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 4:47=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
> On 5/9/26 4:36 PM, Maxwell Doose wrote:
> > Yes, we're reading over either SPI or I2C, the sensor supports both.
> > Hardware failure is going to be the most likely cause of this path
> > being taken, but I could also see some sort of noise on the bus being
> > the cause. Perhaps we change it to:
> >
> > /* Likely taken if hardware is failing or noise on bus */
> >
> > best regards,
> > max
>
> Sounds OK.
>
> A more verbose alternative:
>
> /*
>  * Value of 0 is unexpected, but could happen, e.g. due to
>  * hardware failure.
>  */

Also works for me, I'm impartial to either. Perhaps we can see if
Jonathan is willing to change it during merge or if I'll have to go
back and change it in a v2.

best regards,
max
