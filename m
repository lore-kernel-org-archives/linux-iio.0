Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C80729D291
	for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2026 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774180347; cv=pass; b=MKssn8UJA17XlA8DQVIX+o5BhautgMUIz2TSkbBH5E4zmRFRQYBlTUm5wkcAcZxoGM4Okm3feopYPLCriOzcxBHEO+Ddq90HSrtdo30F8ZXh05XHrU++rflm4KTTBcthBvCn+nEnUxoUBsR6wTxEUix7lj1Fc5g5lM6wy6KHgbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774180347; c=relaxed/simple;
	bh=m+Z4rvcVZ1jhYQImGnrMUvMxAmlc4/vY69TOrXNHdrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3WJT6inEzt9ZhZamj2thaFMvqvQryqarsgiDRSJ+Eg8HygXgD5A2MCAhJ6jgLfWRSr0ba4fQDp/5WwcNt2xWIPGPkOaja7tYiwp58UlSwVWSeXSdolIUJkc/8+wnat4ZAdLQ/SaR9V0zuI3+4g0g4i6D0tz2mY7sA5DQe2TbNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKRz9ZBj; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKRz9ZBj"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2adff872068so8556875ad.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2026 04:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774180345; cv=none;
        d=google.com; s=arc-20240605;
        b=clSmTaM3qg/4ucAYTxpoRIZKA08nmladUeLPIDJMWCdxoD2OSmhsozFWXb7k0uY4a+
         zygQkeIaagH5Ua0SYV0YMQLkuk6SwX3XJBdgJ05fzW8+AQ2Y/Ftjn+DLyKXydpFOcAxp
         MlbqfS8zvHh5s3VL6j6SoBQf6yAnegiEBN2QLz2556yKltGtRgcRCeROPA+sfy4wHuGd
         tF991xaKc5ewl0EYmvFy7s+u6KgJR4Gi6JJYCnZ8Y0EecWLgKthcnh+krg+Eo7NYsm82
         WkJ9L7GrF05iubOqEH1pwmjjbKpzrhwFtvNsti0c0jV0yXn8eoE5qZ5RtiuBoc8AP8CF
         In4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2EuarJFO7EQBeVIouMxE1VIq1W6+abe3kbfVekSMSfo=;
        fh=btk6J8PvNG5HVZJzIKIPAF/PJyUmgyDuJiU8Zj6xKk4=;
        b=CYTFu94ss0VF9W4sHiJzTJsyKTEgkagG0bznoneC5hOVl9/ooah+txYFE4iOe/0Gam
         yKXf2Asi91w41WO5Dl2rJNBrIzLsdpCIi1on+jpY33DlmlapEIp6ZSsMkKh0pXavzp70
         karfT1jPYjOzmHErdxJoY6gM9hocGdsN3lnkZGpXmvVsnzlcrCq6C8NF+pftHFlslf1R
         EiqiMeUYAn38ev1Tly8OdHIW52X2ojFbq+0m7dLbBUSJXiaKHkE9p9vAZVVGDM/2t505
         V98SQ9hn7XKhjr00T3UlioWQIVXdGQG9QVttGY7qocVAD42XeDxHtAVMzJ9Kjiwomnzc
         8emg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774180345; x=1774785145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EuarJFO7EQBeVIouMxE1VIq1W6+abe3kbfVekSMSfo=;
        b=aKRz9ZBjGLSqEDGodNxTCOg2+wq/YI80XXTn9VtZb+soCZSzlBZb6vDO/Hk7LGhe7N
         4ijwfoJ9mR4YdFlhL3rvUQSceAu5oBzT9lyu0OZkGlWgaGlM5ikff2oXg+y31qUYOHOU
         ly08TbRrpslIaQsuNITpTsS+DQepaAKJ1FtpG5VDmy9yKdV89uSD/K8rdRbuaXqxrzyo
         QFFmBCeJR4LeuZNgQRAFimAHkT3THcQfz16lFhi3yG4SgbzOsjrY1Pddgl2Z9rqsW4A7
         yhSq3RlhJF7lqOW78uAE2z3q8Rg8er0c7oSzHSaj/ERmTT93T44BFpq7kOOp9OOE5KA0
         4FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774180345; x=1774785145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2EuarJFO7EQBeVIouMxE1VIq1W6+abe3kbfVekSMSfo=;
        b=Jyk5JAHsAS2R46G+eNWOkRzclvOecteqybjMI8OZSglY22+o7SRXIQku7MhQhF67Jw
         mnOIx+pKYUFYhvEf0yLKJbXwbGPasfh/p7vRu9tMgADcd18UderrEPeiKti0nk7jZgSF
         xrX9yJkJHD+abMmhgOzVD28atCyk7dOcOE1gTn4AX4KzAiog9JQt/SgjUr4PUJyACjnw
         LHXwwkGjSsC+t/nnNGzL8fWgpEKr6SWR9ytc/BDPdPeBLKc0H5LYtipNCqi5W8s4hM6X
         S6rUno8bF0U6DLQgO4yvseWsvgVNQPRnQRxGvHrJwLnthXH9Gc983QN0GGR5sHqM40Fa
         8IFA==
X-Gm-Message-State: AOJu0YwaIGFAysq0N3+Es4WW7T536Cukx/YzCRRYebBe5bj653c6SsEf
	EoBYfoYq88HaFHiS3BzqzzvwiYFAIaIy7UaKmliIunEVLiQwhnXK37XrhodkexNI0VtXZMz03xO
	zIr3RwvQuqeYHhfbuRHXGrL1whwIX1gg=
X-Gm-Gg: ATEYQzwfJHQwMiEpEY6j1eQr49olPE4TpSD+TZJOksKcDEq12TyRrtCcOQ+fi5SsLz+
	XZhqjT29i6VnbNnbBYvti+RiYddCjlt+ZGkk3j1qqR7Th9xNRZVHPEqMUUBE24OW79Gy1mRvj2j
	hxKkmj38p8YjnfwFrxsodFYfWZ31GGl7loScJjt6F6IXeVwpjYj25jOlNfLYMPdwCtzX2fzNDud
	rIDMjWpFSGiU/80VcA3awSxFiRGIvTEnxvVPIQd0PHtg8x8WXNqt9TCF+16ZQ7HcbbEWOgt6ihH
	3Xw1xg==
X-Received: by 2002:a17:903:244b:b0:2b0:74df:3c4c with SMTP id
 d9443c01a7336-2b0827e2d39mr82231455ad.42.1774180345557; Sun, 22 Mar 2026
 04:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322031923.58031-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260322031923.58031-1-pengpeng@iscas.ac.cn>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 22 Mar 2026 20:52:14 +0900
X-Gm-Features: AaiRm51UWgvGbQ9RWQbicUSsJRKQosyTHuOvk_JpKQlOiBwVq9B4KgKYXxwfc8I
Message-ID: <CAKbEznu0eFtnxTFUFR=P-HPugU=Xt7C3XHFwb_Mx1KO2yMwzCQ@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: mhz19b: bound receive buffer copy
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Pengpeng,

On Sun, Mar 22, 2026 at 12:19=E2=80=AFPM Pengpeng Hou <pengpeng@iscas.ac.cn=
> wrote:
>
> `mhz19b_receive_buf()` appends bytes to the fixed 9-byte command buffer
> without first checking that the new chunk fits in the remaining space.
> A single receive callback can therefore write past the end of `st->buf`
> before the driver sees that the command is complete.
>
> Drop overlong chunks and reset the partial command state before the
> copy.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/iio/chemical/mhz19b.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.=
c
> index 3c64154918b1..a028216fa2a9 100644
> --- a/drivers/iio/chemical/mhz19b.c
> +++ b/drivers/iio/chemical/mhz19b.c
> @@ -241,6 +241,11 @@ static size_t mhz19b_receive_buf(struct serdev_devic=
e *serdev,
>         struct iio_dev *indio_dev =3D dev_get_drvdata(&serdev->dev);
>         struct mhz19b_state *st =3D iio_priv(indio_dev);
>
> +       if (len > sizeof(st->buf) - st->buf_idx) {
> +               st->buf_idx =3D 0;
> +               return len;
> +       }
> +

It would be better to handle err immediately on the condition, but it
still looks much better than before.

Acked-by: Gyeyoung Baek <gye976@gmail.com>

--
Thanks,
Gyeyoung
