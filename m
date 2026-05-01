Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300E1FC7
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638656; cv=pass; b=uK75IrhfJ4t6JJGnGmJN3GpRV1NL8vPQRi18wmbLXL8ijtAJ0IQiSSdJPYTEwOF+eg7RyveQzvihJ1g+hEDdXPNBJkA08jjL76plvelmM5hEJKsnTOCU0Cf2AHokNLTnb/7Puzur09caEKEF/YmpuNwv1/0VtDPxqnhJXsVOD1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638656; c=relaxed/simple;
	bh=crSZxVAjZCI8d5t+W8McMnolb64GngRB7n/jcyHBCFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uebZZwAebCrgoWrOiR5llISNNXzn3k7wY5Sv7bBNnwfno1imXoSy0PAK6YlsJSX8QVa65QdBM2lUz0fjjSoI/mvyv2XXDMu51j2YBTTNT9aQ56YxZfNVpu3BdG3inXvhnhywmtbeufR+rpqGku58PsuNyOWAVHRLUBxfg7R7Y3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuz4PKYJ; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuz4PKYJ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-671dad7cac8so2326380a12.0
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 05:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777638653; cv=none;
        d=google.com; s=arc-20240605;
        b=Z23JKapADxee+LHymwU7aC0chVslyNu5QKqwjAZiqOKW3HA/86loVexsDjJBEw7pdX
         6SKrgy7kgYDwjgW/5cE1A2Dfc5fqcASezXeboCXy3onKCOuxFdARxth2ZsOCVNXyDLW4
         HEas0YCT9XaBOrQxE7hbkQ4TLVoWAhrFigfDV5LPu2FG2Qy8A2gSiPSFmJQKcU6Fx4BU
         kZGz2vdNbhz40ZvzT1hHva+eAIIFWFBvVrwrjSfbJeWOmqhata3jyovJOomvYuAAAHpF
         N0ilPue0cSTUgq4/i7pFELqFHO2sBTCkv6c7oggDnyvWNDBKoD1pn435PLGjSkp7qDZV
         7iXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=crSZxVAjZCI8d5t+W8McMnolb64GngRB7n/jcyHBCFE=;
        fh=6nn1vD07VIBAUZiWjKrqjN2XfmdXUou5gIF45p0whXQ=;
        b=SOLlbHIexLALZ0rnV9bM8uVTKkYEEafURWPufWIuesdmgvUdyNtmvR+5da/20yUapt
         LmdQYFdH52YfvOgbT+hOGiUoE8+JLvvh+ICSTbtNzhRgp69m2MGUEusv6xGRaOBdlVPt
         6eT80TghjUFl1giAhSwxhEiI8rF1mIXIpn/wAlnmrTMopmV11h4GPEI10dm4dwGP7sSg
         7w2ceCT+chdJ9ac30OLSjqUaFo9ZjUPKlRwxz7g1shJlRnmtyYpomY6Rd6YQJM/TvCdG
         qnjNlsIkdi6LJH9aZGePjbh8KVKyL92zFNq3BudTAjyQX0RwBcFelgkz2bvDsnGIe2Gl
         WYGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777638653; x=1778243453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crSZxVAjZCI8d5t+W8McMnolb64GngRB7n/jcyHBCFE=;
        b=iuz4PKYJLKU1XXGaSQKPYCA9752ujpojuIY3tBAj+gzwi/mxc2Ubo/lvFZ9QpqBYQo
         1IWvpj1sQc0TRInn1Dx3bCulPlD42wDpBONfaQvy5mdsD70IVtiYnB+9EojF9QfeeYBj
         HTPO5SaHpgESWj0iMrw6J5JF1jHQvpK/f24Xdth5koTNJUfs0+9xjal5Xy2RggRaWtWz
         XE8O+A8yBcK5j/hIH8stSHGohW7icDeQWJnqQY1ilF10pioPtl2IplT2hFYLLzP3SyY2
         JD5GB4fGNq3dXge/CsGizEckKccgusIn1+x+6jqUwZ9Ll5aA9Zq5BhEoh8kRYKTSe5uG
         QXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777638653; x=1778243453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=crSZxVAjZCI8d5t+W8McMnolb64GngRB7n/jcyHBCFE=;
        b=fsMWS9AJqx2R/iQJ+GdQNB0lB/ZMPnFBiPO0UT/ugVfcTMPMrD9mGIawLwBt5jFntQ
         1xI2eLrf66qiaQ27xZMLbR2HBfKnoH5lYKuxMSeO97Qew0IilGpRWnZky8bSj8OCRSKH
         CJZmfoAB4WskhUVC8M2qtgItoW9BNIctnCkQduiZ5Spu+qJmaA5i80F++SGo7ID5t2we
         1k2VAD3LMggvJcRkjsApl4SAwFYNQORwjEc2lp1cWWHVYcu5eQDw9RUDamBnITEg3Mtw
         T9U6uAEyS3BzbHSn0OgwRVYeEE+Uo1xKhwAOKVBT7LDgjRz5MZzeFEBRb8ST+ISBFmDj
         TZBg==
X-Forwarded-Encrypted: i=1; AFNElJ+jUdX4am2wsQ9mYpJp/5/KjFBVKXHOtih6J3uNC5M+7KumuX7jnuxSSrp5vAT99FJ5uZpb/VMTr9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuwu5iyLECjDyoR2PSTe+VKIPOQu76dY183sK9h/r2c7Szc4gz
	oshV3tORvncLAo7/STBGLnu8wdB3BYzS2x5sPYcF6E+zy6ivrnsJdzvSCMmGiWIZBnn5OGHvnp2
	3ScVx9eLd6U2U8sXNO1SR17LdWNhr4n5J11ug
X-Gm-Gg: AeBDievMNgYk/qYQXBYXpS+dWfdkqnKwLsOQjS/8znbFe9ojEEPW/bTQoo8XoVfO3zI
	jOCdokUfBdj+M+o6VkAdSPwPXXyHilYSVYoZu+PPDM2wpAg4I3kHfR+Fcl4TwGPlj5ToIKWy+xQ
	boB/z9AaATMemEtcgH7WZJfBKA90XBPkDTAMdtns4m5NSDIO8I2Y4NqFq6vKrb9uZeGO0PJNR9O
	JHS5STqHwY7GDR38ok3FaCkTlEWxVhrbZqqY1WTWGZClpBfMGuyibfA7RWyE7xNKJ49pJ7SzeZ8
	1jtIzI2vldLZQYFXuFYRL4ci26NDFf83bsaEZIQvLUZkiLZAufgWMZTDkmrZ18kFCr6aeLR4I43
	Kv7gGiVjUfgUVI7VzoA==
X-Received: by 2002:a17:906:730a:b0:bbe:7709:5a8c with SMTP id
 a640c23a62f3a-bbebe614b31mr140884466b.1.1777638652672; Fri, 01 May 2026
 05:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501011548.15369-1-santanarl@usp.br>
In-Reply-To: <20260501011548.15369-1-santanarl@usp.br>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 May 2026 15:30:15 +0300
X-Gm-Features: AVHnY4Lv2mGSqBg9IruDH-1kvJOUpAVmr6CJfChK477thGlo9fqPuBj1C30HPVc
Message-ID: <CAHp75VeZ40W6Q2Q-4P29nDjq8s1ziH9NFKR2qH-RoNK_V8O3aA@mail.gmail.com>
Subject: Re: [PATCH] Replace manual bitfield manipulations with field_get
To: Rafael Lopes Santana <santanarl@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 4:16=E2=80=AFAM Rafael Lopes Santana <santanarl@usp.=
br> wrote:
> From: Rafael Lopes Santana <santanarl@usp.br>
>
> Signed-off-by: Rafael Lopes Santana <santanarl@usp.br>

NAK.
I'm tired of replying to each and every 101 issues with your patches.
Talk to your group / mentors / read previous reviews to learn first.

--=20
With Best Regards,
Andy Shevchenko
