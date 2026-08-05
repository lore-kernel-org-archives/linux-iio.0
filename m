Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E7395AC7
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948297; cv=none; b=GMihdLCzM8KlKXmx9hIzathYzK9YPOX67yP1T9iiNJi0PPA1W7NukStFxwySRUCD1LvgWxl9toSw5LgXofb8vHSBjUjb1iMf1W58c6QpKjeMVDQfv6q1iE9I/99JRYWMuN0QVcvjTt4iJ/e86YHXFlYnR+M/dlMAJpD9FHp/Y6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948297; c=relaxed/simple;
	bh=vWaSb9jYmqWsqHYA5iv6qOrS/BmfcCxQR/tq658fq6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVtGwgxuHZob8K8L1d0ENlnxFCnxTBj4oBAKxlfvzhiZweAxm6TVBTqwzzeWk3U6pxkVPr9p1oxnP+1t/n6Ai/WkD+Ahubpmr4ENqf6ZXBFscbQeIHyVMRR02t0Fr9r7CQmU6qY+q6yHtFOvB2plAaOOKMLpm+ygKMMDy3mMhvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=EoVXlD4G; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=dM5cW1Au; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="EoVXlD4G";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="dM5cW1Au"
DKIM-Signature: a=rsa-sha256; b=EoVXlD4GTWcisOWU4n4al985SH4u25rwp1Wlja/AoTNFcxCSi6ny354lFVaQhM2UnYwb+/V0f7pC3GXIZmTmBD5gOvXg5jKuXM7jQ0VS5TNGEgcmUIdcaZ35Rl2SMelH4Ugp+7Fd1rYj5YJ417GiFvF/Vghd/3ojSIJ5K1vBK8S1BqCLrhjM03K2xhLopDxUw/zaS8jXGk2xlCq0gUQbf/DAMk+ZMaGAXeNJOvZmZw726dEKL9ug/D7wuGjmk6LZquvsGk5CMS5R7A0AIZnG70BxwkwWDyDr75Y+d3c7/iy37nwx6oAYypdH7ZTe0l4ACwyyLKCMqkP/tEsy4cP5fw==; s=purelymail1; d=maxwelld.cc; v=1; bh=vWaSb9jYmqWsqHYA5iv6qOrS/BmfcCxQR/tq658fq6Y=; h=Received:Received:From:Date:Subject:To;
DKIM-Signature: a=rsa-sha256; b=dM5cW1AuRqxy2/4W+BodPZLFVMU0ed6RHDejvqVMJI8OZZGvFYCXqd7W7sWdZlQKRnHQIgBFHT4gBozXydmE/53F/b/7iqfi815LVQX1gWYH2dWpZWpcMtLFQ+ro+uKtOjrh9F/Mijh2EG/guF7Mn3Ngg8w/23f9cVHxccfG3t7fEJUItQ/DABYPXh/kfkDAoyUoNdUVvcH30sxYeJcErak9E3LvsjVsgKZt9WxLN3kGD3UVgoxG94J08joVlWB3Mq6B3i0siosjF2gyvBYBIFXyvkcp8vf5z1fO+aMtgFV3UyStozKRuomfYLz2X37mXJP0XhImvInYFU9m1tE3yw==; s=purelymail1; d=purelymail.com; v=1; bh=vWaSb9jYmqWsqHYA5iv6qOrS/BmfcCxQR/tq658fq6Y=; h=Feedback-ID:Received:Received:From:Date:Subject:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1234681327
          for <linux-iio@vger.kernel.org>
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 05 Aug 2026 16:44:54 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81ed2a00f12so20194047b3.2
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 09:44:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp0bbcW2oPa6ct5egL/e7MKb8M4lkdZBcNq82pdqnvJwwzKyVEq67PSfvSp4+lYrLZ52SsZ56AocnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze/gGLxCpR8z/TWXYAgSGQe5QDcK9Gtvnq5FtSqNEkxiFL0I8T
	29kuIJz9jhTIvqP6qAX45S7fUi3U18AhNBQB7AC7JcN/5fzZrY5DTRkjNPXi3Ckz7FFqQLUgRKg
	hdz+SYUIuf2pM6BYYKz2Jd50Io/ATFp4=
X-Received: by 2002:a05:690c:dd0:b0:80b:9f4e:a70 with SMTP id
 00721157ae682-8202250ee6fmr45354027b3.26.1785948294346; Wed, 05 Aug 2026
 09:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805110255.504576-1-lilinmao@kylinos.cn>
In-Reply-To: <20260805110255.504576-1-lilinmao@kylinos.cn>
From: Maxwell Doose <maxwell@maxwelld.cc>
Date: Wed, 5 Aug 2026 11:45:58 -0500
X-Gmail-Original-Message-ID: <CAKqfh0G82W5wWg2xMs_qRcUAWCk1Uq1BXTPAD885h6k8sJi8Gw@mail.gmail.com>
X-Gm-Features: AUfX_myZWLyRIftbVOvtHyITguT0cgrrSZIfGt0j5DfUnAgg8icpayZeLYIikTE
Message-ID: <CAKqfh0G82W5wWg2xMs_qRcUAWCk1Uq1BXTPAD885h6k8sJi8Gw@mail.gmail.com>
Subject: Re: [PATCH] iio: flow: slf3s: restart measurement if VDD disable fails
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Jonathan Cameron <jic23@kernel.org>, Wadim Mueller <wafgo01@gmail.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:07=E2=80=AFAM Linmao Li <lilinmao@kylinos.cn> wrot=
e:
>
> slf3s_suspend() stops continuous measurement before disabling VDD. If
> regulator_disable() fails while the supply remains enabled, the system
> sleep transition is aborted. Since the PM core does not call the
> corresponding resume callback for a device whose suspend callback failed,
> the sensor remains idle after the system returns to the running state and
> subsequent reads fail.
>
> Attempt to restart continuous measurement on this error path. Preserve th=
e
> regulator error and warn if restarting the measurement also fails.
>
> Fixes: d240b0b8a1ce ("iio: flow: add Sensirion SLF3S liquid flow sensor d=
river")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/iio/flow/slf3s.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/flow/slf3s.c b/drivers/iio/flow/slf3s.c
> index dfa7c14090454..75ee82fbd3295 100644
> --- a/drivers/iio/flow/slf3s.c
> +++ b/drivers/iio/flow/slf3s.c
> @@ -462,6 +462,7 @@ static int slf3s_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>         struct slf3s_data *sf =3D iio_priv(indio_dev);
> +       int restart_ret;
>         int ret;
>
>         guard(mutex)(&sf->lock);
> @@ -470,7 +471,16 @@ static int slf3s_suspend(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       return regulator_disable(sf->vdd);
> +       ret =3D regulator_disable(sf->vdd);
> +       if (!ret)
> +               return 0;
> +
> +       restart_ret =3D slf3s_start_meas(sf, sf->medium);
> +       if (restart_ret)
> +               dev_warn(dev, "failed to restart measurement after suspen=
d failure: %d\n",
> +                        restart_ret);
> +
> +       return ret;
>  }
>

In addition to David's question, why reenable vs keep it sleeping (and
why don't we dev_warn() after regulator disable failure)?

--=20
best regards,
max
