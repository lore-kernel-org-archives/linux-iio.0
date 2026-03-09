Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5EC28751B
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075793; cv=pass; b=BepAq+n7NkEHkGuqRJ8+ItI5Uku94RlkznNhKGjM/TRFVE0Nrg5uuw2U78L6If5jsG6Jp4dan3d03Yt4prMdq8I4JRhKjNZadRcjgjS+Krk1H+r9YdNlvNtx15A5a45OXGuNpHzb9jvZzzvTlPv7EKu0oZeiC1Ix9pUHeA6QS8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075793; c=relaxed/simple;
	bh=aJ41ZlEMTR45WIZ3zpor2zLP8XPePh3TlJ4zve07HA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFavGUpmadMaMPdEnXrcvne1BARkPo6m4ijPanSykMj6Boxy5TolWlioA2VPPVdKOkGzVwwv9/SpFrEORvH00K2tX/ZVeegAPfEBOad0UT1ci+icScmfHYTlOsL/sTvMDHFdGp7BvApnmrl6s3zb7yjQpETswebus8DQaqIcAec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8HjXcp9; arc=pass smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8HjXcp9"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b9382e59c0eso916852266b.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 10:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773075790; cv=none;
        d=google.com; s=arc-20240605;
        b=DokrPYw3SSdbTw48IEDXjIycu7rEAZEfo/YhJNZsP4RcWo0qUoc6ijZifF2NwDziPD
         UvXQpnSKvsFFebR7m3wYt/K6Vy+uRrEgwczLm1vHflUESEfF35Y+S5xWiCWxeLYU5V+3
         Or/8qNNEdJVs7GO38XqurOXuKfAcuKt8ApHsgwqBQnfg43TiajyL+RRRYnjLs1w3rO5d
         xYLSB4lw1c7/EJE0FC94PqOFtp1PX22rDLANdK/La2dQRG8Y/ZEncoOIKRa8YlMtJugH
         7mcEH7XbKHLCPMuaJ43xaXK3v4xaiwixvm1sWoO8aSc9EyzhfCZUveH1Jw+7ec8OcYxu
         g0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ym+Bnh2dTk30jwgIA/8yQHdHgl85o1cjDf5vrkl4Xzc=;
        fh=MKB9dnnJSUtmUB2HLmRNHoa93NxBApCeCp7LQRvG3kU=;
        b=Gn0iBOll0yo0Wkb0nnljIfYW1nX19IvCLKPoc0D1AXvEFmuCEqABuJEIWFwqWE7pYN
         u8PN/7tg57yh7px5omIsIA612UyXAlLTqQDAgesSpFvliuwSHtfy64CcIxyl9ZDRWIBL
         vuXczdSCvYc5GFwnLHIbLSLMGPBPEBDaDvg7GteFNnv7nzpfUKtbOGupoM/01dvgx2/h
         5ZFRYukTmh8K68iDIv+S42FqKZeMbApdSGGKJ4pOU1W3j0LZPO0qUxVC5ErsMyoBHckm
         ZFRMMtG9sZt+ZHmeW7yNDr3odn8W0xTorcyHLk+vuPMgnvKLQ1NgV07Xc3e20KEz7SVL
         qlvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773075790; x=1773680590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ym+Bnh2dTk30jwgIA/8yQHdHgl85o1cjDf5vrkl4Xzc=;
        b=A8HjXcp9NOpUOyAx4H0kykVS7ttnXnlhQTKpk6xv3szeuweU4qDwvuEiZY5191LVUv
         TfErgRIRC9E8Q2mdxQ7aSONFF9kRgETc5l9oH+F6/skApTbY/FiTKpw3dH19a5JFnoym
         mE5xAHp2Q4RczBGLgjEDkJ8VSmRPzg3bhdvb44x58NLIfYfSzaBXp4K54SIuQ6k952Fa
         owXxQdnVHjjwQISbAB7O7CV7qIJusTy2SmZT8Gs72KxHgBo+BuvpF6Lqeh0uQw82T1sK
         pp9XkTFmmjPFoVOs07x07U8vEbjBJwIcEcZRE8rmVM0AvLJ7qsGqbJ/zkotIomg4fM7C
         6KMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075790; x=1773680590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ym+Bnh2dTk30jwgIA/8yQHdHgl85o1cjDf5vrkl4Xzc=;
        b=LjxbUpbbkNcGV68fL5lAMiHe6bs5EJDeNznrQ4Ce7AQhOgQCqPwA8zOM962eblH/yZ
         akzCc9lnMEoCmZOFAfr18k4MFd2y1TSePDUkGDNBwpEyPQNMJ2/T54ixwkMQHxHDFB04
         P1bTvKige/w0RU4iJ4SPV4EWRVtKfEr1tWs2yZ5KrJGB5euoZSZD+A+AI12ODScbe7B7
         93AhfKP7AWPAHy7PPRJIlzoSdm/zap62CrEAwLUqAdP9W1Bj656RCLuTUxFBm4YOTE0K
         Je0oK+NTI8CO0s3UZs6DwMeAGrH39L9w7TB4qTln1nlzKUkG2iRdhhcw0BMDgC4fMkIM
         //OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVROEWly3zbz4h4x5btWEAi8CfYvpuHDkqmyDQ816z1dskv0qVK4M2N1Cg52dEkKXX/cjrL0JFnRfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCbEmxfUssWjrQGwhQKrLGbr34s5tFdb7HeTZqs5romC4Hktv
	GBj7Evq4l3YLNeklQ4zlX1o0Ko6CRzUQh4uqrtIb34MCWZ0Wk9mTah+pws3MU6lnX0aCU1ZcAO7
	6rduuVjfFAtg5xihIOveYDj7la0F8P2E=
X-Gm-Gg: ATEYQzzWLBxBoJBnyGZIeZRFHdWv+4TMJ3jFaxDulWj+P77KHwNGqGv1Dt56clT7c6R
	58SXXUUDakx02czPClSYeadQysOOM/mtqcsj2gOjgiQVz5f8PYIVOCN5wPkNZ1TSkObY8ht9GJZ
	crCSyhm00ek0LkngeCAWpQqpECosSQfWRmevMe9cMTf5HhfZHQhCrgHGzAjtG0aAPH2oQKKiCeo
	+adIjxQl03jN6EGsTho+ia4sYc0PxmC8ItgM1IqALgVqENzvfH6oE/f7YdxO12Fdlbdx5LFfRy/
	T2zhBQM=
X-Received: by 2002:a17:907:3ea5:b0:b8f:7aa8:d9a4 with SMTP id
 a640c23a62f3a-b942dba9e1fmr692911066b.20.1773075789604; Mon, 09 Mar 2026
 10:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304-77402-v1-1-47ad6eedd643@gmail.com>
In-Reply-To: <20260304-77402-v1-1-47ad6eedd643@gmail.com>
From: Shrikant <raskar.shree97@gmail.com>
Date: Mon, 9 Mar 2026 22:32:58 +0530
X-Gm-Features: AaiRm53BRetAP0tsizzZNx7dfDWNt5uyaO2dHn4DuqHDglPwb9S_ZUXGFl8vnaQ
Message-ID: <CAHc1_P63xwVnn1mO8Qwxq=r9L32JFdS_hqigWKU3gHMeweN9eA@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: rfd77402: Fix completion race condition
 in IRQ mode
To: Felix Gu <ustc.gu@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 7:44=E2=80=AFPM Felix Gu <ustc.gu@gmail.com> wrote:
>
> In IRQ mode, the completion was being reinitialized after the
> measurement command had already been sent to the hardware. This
> created a race condition where the IRQ handler could call complete()
> before reinit_completion() was executed. Consequently,
> wait_for_completion_timeout() would fail to see the signal and wait
> until it timed out.
>
> Move reinit_completion() to occur before the measurement command is
> triggered to ensure the synchronization primitive is ready to
> capture the interrupt.
>
> Fixes: dc81be96a73a ("iio: proximity: rfd77402: Add interrupt handling su=
pport")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/iio/proximity/rfd77402.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd=
77402.c
> index 6afdbfca3e5a..81b8daf17a54 100644
> --- a/drivers/iio/proximity/rfd77402.c
> +++ b/drivers/iio/proximity/rfd77402.c
> @@ -173,10 +173,8 @@ static int rfd77402_wait_for_result(struct rfd77402_=
data *data)
>         struct i2c_client *client =3D data->client;
>         int val, ret;
>
> -       if (data->irq_en) {
> -               reinit_completion(&data->completion);
> +       if (data->irq_en)
>                 return rfd77402_wait_for_irq(data);
> -       }
>
>         /*
>          * As per RFD77402 datasheet section '3.1.1 Single Measure', the
> @@ -204,6 +202,9 @@ static int rfd77402_measure(struct rfd77402_data *dat=
a)
>         if (ret < 0)
>                 return ret;
>
> +       if (data->irq_en)
> +               reinit_completion(&data->completion);
> +
Looks good to me.
Reviewed-by: Shrikant Raskar <raskar.shree97@gmail.com>

Regards,
Shrikant
