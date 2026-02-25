Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFEE1548C
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048746; cv=pass; b=KPIqmFcjS64u98El5rkNqmLEGz1Ou3oa1E9rl4ezF0QaGE+erj5GeDLoyw8ZsKcB3gyeKSKuxIOKWdlwMNcw7JAYGBYWdP1hwRCrzjVPwWaNbNyjThzrz/F6Z8WqNyoWVbDc9hQ6g5AH52Kjwk2iCF3V9mB3rXkiVWHXYf6N67Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048746; c=relaxed/simple;
	bh=OG4FFLoNbkEzk7bHOuyaVbx1n+fCadNHK3Y3sJuX/Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/Bb+lh2MReOL/rVW1aIdqRkeUGchVeV2rKtzAorFPEQdxXxpda2FN5x7AMd42vOdnYvN/c/zCzv2lkI43OMLmTudDIJEvrQ0SL9MH6nsA3collmWGfuf+5RA2fWhoNL0ic5y95Tm6v96c/YU+6NEPHlYMhq5g7JxBBipBAYu3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiDH1VOG; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiDH1VOG"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8d7f22d405so12891666b.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 11:45:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772048743; cv=none;
        d=google.com; s=arc-20240605;
        b=R/cuVPsh3MUoeyi4zA0HlSMqAiz3Uk/rVRyLt3oRSPGuqgCJJJlbzkfuR3RfwYPrzq
         zccApI+0LVdHnGYzWIb67PDyqGEPbbnLaVZOZHOyW/SRlxAd8hU0yLdDol7V+tzzHU8F
         Dfeh9Ux4DfOFXMqX82XlQTJlbZjGhEi64kk1bb3HpE7O6jMJS355zZk95UiK6y3Atxik
         ODZW2AB7KC4ELOKC0F+J2nSMoU6I9VvPCmIJRswKReQGirPKekkfS1qP3/zaUlpHNXND
         XE1TgM6kbzDpkRYW5fac6T5kl9YUR+vWUBK243XfoYLO7KHrVGaP2g4KY1sX4Dh8+P6f
         aqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OG4FFLoNbkEzk7bHOuyaVbx1n+fCadNHK3Y3sJuX/Y4=;
        fh=k5TDBkpZrPso2wj3ZJWwbd/TDEta4B+CJ5O19JEt144=;
        b=YA9koHayK9maziy2sD5nzMd/Mr6B55+SeNWHfjbx4eq2EKNpC/zyiG/pnYloekqviA
         KPfZYhthQsmyHQLbafUyg+dwYN83Z92xNqn5TbHTL0oSlcOR8TToyO44eNSAHJvgK8It
         GNzZbhll19b/xh0Ef8NjXHXKIqqMpqBNg3tr7fBOAVSZgOvg/9AJmxU++0wjhMisgJGA
         /+1aPhCMEDQT1dusMkbcVN6HO2cT0EuMawlVcqfsmHz1kik24NhrnNhe8Ya1XTN+5DeZ
         tvi8zUhUo3FJs7ApUeI8B3wrVhGRdupS8W+cot1GeEs+WhnxnUuVylH2aKyBYQ+gJX+Y
         AyVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772048743; x=1772653543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OG4FFLoNbkEzk7bHOuyaVbx1n+fCadNHK3Y3sJuX/Y4=;
        b=KiDH1VOGB2B43/pKaulNg5f5FPfW2BQy7tuUFBwm8bhcITkqVVdecBwXrurA5nmzVn
         erEGsD8mggrmZBVa1/0AnudpTa7xByRqzaHvYXjhSUF8KgPLLotfM90QFCeTwzFG7Vm2
         L8nDl7yHOfIQOo0S6n3z8dIeZvwSgr7PjEqXIktsx66C+A1czcz1x0XlILgy3Pl7yPvK
         jQb7sDhm+rid9YvpOFDAmYzHCu7qJBnHTJv3JZ2IHsHMDzyKB8iCnfcN/sphGI6k2GzL
         lwP7d5kQu7WkUuJviaPDfrhNusFtQRSC/CIVefiqWdkjst5aOlKZPeFqhYcBiifTJkCq
         eFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772048743; x=1772653543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OG4FFLoNbkEzk7bHOuyaVbx1n+fCadNHK3Y3sJuX/Y4=;
        b=f7wk8IsVlMTdwLBKDnUxqzShz/UxCBkBDUBAs7UsrmtX4TPElYicZQ5I4xpNZguHgP
         Gk4FdcYYtg7KoSeJMmf/UiVLZpV7MWHpQmhTJUF2rrKnYHyMMzqjvSXQItsdZKI809+F
         LiPjKm87aRz6qZO0dAQnFX45GPTBAS2M0JnZRQzro3MdAHHyHsQgaBIQ5cN7YF75hVna
         dyCanw+Tpj2DHcOpN9t81ZMuK64mJtMM98qZqd/vbuj44ZQXjhJ5ephv/4ZYOg3qegfi
         ikvAJLoFsLZGa7vj71JWj+a3QczAe+Hazq0VSaDI8pCxKlRDQujFFfenCk5G6nZJJ1QX
         hldA==
X-Forwarded-Encrypted: i=1; AJvYcCWeiyInC6HWbNuMiksdddDYQLVzxSY/VkfociNQlz8JIRrCda9ZLkFFOwH34l9zEtzZR37rhhmB0Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGF0iHdYzuPZqPXrPjdtbrO1zAZxRlD79Go25tfAGuumcPJm0X
	OHnR1Lr97X28v2MfE8oRPaOc03lRYqyvBMA1AKAbdHYx8I/rA+kGHq++sK8iBXNC/D+k2Ca7Puc
	xVpjDT+RfeBZ8WT9FHknRuoCwsE2F4p4=
X-Gm-Gg: ATEYQzyNxc1CfmP5d0Xdz3xaD6rnPZaAz2RYDw842U9UvgFrzrECbCRkB5J518iW34m
	beEHUtBVOCmcACBsUn4bDmXk4q2caFpi8dLU2w6NVn3+Yr0j6VkXXWM1B/Ygd2ZjYhybAN+lWef
	DPUKhfZmAC+YeKovPZYTjLtbQMcKP4+Gl26ZJuJqBbdCqImhvUzurZATH7ddJEnTCer/8FLQefE
	nVq2vj3PTa7PNKh4N0bNsizKAV43uJr9XG1mgLIcKXE8y2Ps6uqbgw7hH6PPoRNDuQ/WkrfMgwE
	bax/12Dq6GsWBZ5G8ZH4GwV+dQs51hKpVQ1znND+gZR3ONBL8DkH2glspIi5qA/kYEQtAzYd5ht
	CpK93u6Y=
X-Received: by 2002:a17:907:3d51:b0:b93:4fe1:6ff8 with SMTP id
 a640c23a62f3a-b934fe18df6mr131837166b.36.1772048742863; Wed, 25 Feb 2026
 11:45:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225194051.8614-1-rougueprince47@gmail.com>
In-Reply-To: <20260225194051.8614-1-rougueprince47@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 25 Feb 2026 21:45:06 +0200
X-Gm-Features: AaiRm53gxh5E1MTDYiw30mr8aO-We81wz7p-uwFXa12Z96CWAaYcXSLWSTBWTFs
Message-ID: <CAHp75Vf1+gZyQ4SqQso-FSvY5-PST+2nFyohtvEL0OtkLWShPw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] iio: frequency: ad9523: fix checkpatch warnings
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 9:41=E2=80=AFPM Bhargav Joshi <rougueprince47@gmail=
.com> wrote:
>
> These patches address several checkpatch warnings in the ad9523 driver.
>
> Patch 1: Updated the macros to properly use their argument x.
> Patch 2: Fixed the multi-line pointer dereferences.
> Patch 3: Updated symbolic permissions to octal (0444/0200).

Thanks for the update, it still needs more amendments (something even
went wrong in patch 3).

--=20
With Best Regards,
Andy Shevchenko
