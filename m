Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E9175A86
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741402; cv=pass; b=bMblNd1Src/liNp3yCrxxGSJ89FfsVwdCz2S3gSNSbGoND8dBVKkdckxc/W15fMiDkMzZjKreS8Erk+LipqsCgwXcHkHwma3lvEOy11Jg8nV4R0HwA8HNCBSo2US6jc/Q8xghmUj+NJZXe0MeLr5sIefEibhCL9QO2CrdY9mXkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741402; c=relaxed/simple;
	bh=0AS+lDKvwULOUNFBSEXf/C8wpgXLPCwBSUGRfGUCITk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyiPUqtNBtRL5fYNeNG1jiLLvq/ITbV3Hby6IDX2ky3DuJWnfOrei6XquvFTlbfbOWXmgMFyjzfCv0cBfHh+XmtB5K5fQY3n94J3QVLBhf9UL6xSP11dFMnnDDJX3ozbaqXbahLOwM17CGkQnxLddpeXZlvOpzlWQjY50ng2FyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noLtd/VK; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noLtd/VK"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65c305f381eso10576301d50.3
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 13:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779741400; cv=none;
        d=google.com; s=arc-20240605;
        b=Sd104C9K95Ufyn6AHUErEWpRHJPtPTUv6qkc6Ad6Nr2a+j3HPmbFW0rdc1Y5n7N34Y
         tiOkauCRVLqkVQO541rZfVPQ8H3c+XZglsvv2gQF4B/pi7eETfiClKRur/UVvuVWs4LC
         40ZMw7cJnMQ7Xt7mrGR6Ht5L4zOmmrcairCXmGwYsUzzpcC/PWJwoMQSXi+OPgq7jGIE
         z7mLTYP3wWxhIWTWDXahuDhvrH8tD9+rh40jJTWxFSu+bsfgDQrCsWt1lL78iRjLDyK6
         dtTNvI9E8bNaaAQAC4gcrF8XE5n8AwUTMPuH/5cDpjSBisi9KyDaF42bP/L/JZ234ZPX
         9YUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D0Ya+2Vxav3r3Vh58qyqher95sRqXUyFKXxW9zG9oTQ=;
        fh=0VtDxee5MIL7l75DBKNRjYBxELQv37f/Z6qCAyqQFH0=;
        b=I7Fsttt97WWctkbY5Gnu8162jJlNl/BlxS0kjzagKuhJ8WUGAIxiwb45pMuD0OLVBB
         C5eH+FKZdgsfxvquw0RbIKzAM8A4B/vO1cWEfd2krcxXyy0KUMTfFMAvSkFOKlvP+tAb
         2MI/QNvJhXsZ4U61MTQCuHVSGmQxNUqLYRRLuvncZSdCx6WZrD+6zz03Lm+3jsRVAueq
         t18l3Dt5m8VLVoU04loIghia7KdiZtX3WVd2KK+3fad5/PTWMmL3yd4lXnDa+NdEp0RU
         FMPnPMlGQyoX1OoD0Q/xaJyUacvyV3D+Fw6XsFaVuglyUmttioSQVOnOedsbaoaj+XBE
         LRnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779741400; x=1780346200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0Ya+2Vxav3r3Vh58qyqher95sRqXUyFKXxW9zG9oTQ=;
        b=noLtd/VKAFyf+jPD/g78I1WqB27MDec0chbBoJFwkf9DrYKFugfXtq4uqRP9Lo5ZYA
         y+jQWF+Si5OwKj48r1rQw9XKDe8aGvZmXT1eXM3K3ReSZ6AjmDVmLg3dRzpArQ8WWvAV
         fdscWSz6xqs+LVJXqdx4pfG0WxrU8TmDuGDh8FzIMS9ZCz07N6RZYE9sg0dZNxWzOUL/
         tSdNLpVLyrU1RKTb0mFr9x/2cW36V+Ul5IzYEkbRyFEKx1hAIKVJojLI8DDW6rEBbiof
         TXwhXr6B3NDBoUArkspoAjOKiG1vjbvmjLcuuGpavUMZB6oKdOasTKKDts25zW80ASvk
         khaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779741400; x=1780346200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D0Ya+2Vxav3r3Vh58qyqher95sRqXUyFKXxW9zG9oTQ=;
        b=JE8vNJg/UsNOS/M3Im6cFHsxUydRcCyBTcHrF1uSFd6cOSDqaz8mFardUV0BJrX2Br
         box3SEyLIZjoNWjmvhvPCqvqg6B4YQLtICcJHXgIjS6b8thQn0OddYkXCCmt6wdGU86k
         3HeP7dlnWvjn0z9eM/1w+9ozDnSfBBl1yiHDTW1us2//YZKYWezwhdi2jqrYNxqtpuDi
         qZ1VAKN8fRZv2q7YIB/rJ1gTScpMukuJMhC45J2Tx8zm5Q3aalKMlZ02JXGANx8otPH9
         +0bHFttxiowf60/RDnCEkW164pO24YeRkBTqhHLcKmuYSAeJI2Zlw1Bb7SE18diAe6eK
         WgKw==
X-Forwarded-Encrypted: i=1; AFNElJ8RJ8wqt06fqrGUHxU/0BKzHUXkT8hTz6dGKu52XJ+i+G9UgrQPETaFf3WLDa03KBeKMAQFeAGGOqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj8FL2g/SsIoaTNG1PHs5I2UDNsJYO8S2zJt/mE5EoEKJ2/YaI
	MYK8+vOduAWep/hVJOcOXpgr2TW3FROVC0WJq38It73u+ci1zP1K3K4H2UcsW0FwymaaMv5Wzja
	U6LDADZ9q5daGcb7Y1x3tAOOPSxGxFK8=
X-Gm-Gg: Acq92OHsXZGajY8U/XUdiZr4WPNdObL57u+4uxAZ/qWqaFNVY+R9bZJaZzeEiNQ4OVa
	cChSOVnuppXaOXENxk64O1rW2Npl52zqmF+iz1Cny3le+aTK1O8rsQHI+19E3Lwged09Pgqoi71
	0z3/r8UqXFOQC5hXTXxGriIexvb2JiuyyaqgIi3kFgfTW2KGpFpDlHQrOL5isTimWNQBjH6m3Zi
	7DT5xEa0xDEAxQ9RiCdQHR1P6IQAkXnjG6cUCiSRs3IL0M1wPjvWb3YajSRkV1ruLk7zvRlS2Ve
	n+rgrN9anL/nByLQPJjz5/6cKWHHQQ==
X-Received: by 2002:a05:690e:1507:b0:652:53cc:dfb3 with SMTP id
 956f58d0204a3-65ec99cd958mr13149925d50.52.1779741399618; Mon, 25 May 2026
 13:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525110130.61284-1-grondon@gmail.com>
In-Reply-To: <20260525110130.61284-1-grondon@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 25 May 2026 15:34:52 -0500
X-Gm-Features: AVHnY4L7AUaksRC2RaAX8cilHv4isj3O5at70x6Y8HTKOutMLFK7NCajTHpAwVA
Message-ID: <CAKqfh0E4XB75cN1gu_9k+aEUUXT1nVo=MLVshk-P1dk_K+HuOw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: accel: bmc150: use guard(mutex) for mutex handling
To: Gabriel Rondon <grondon@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
	sozdayvek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gabriel, comments inline.

On Mon, May 25, 2026 at 6:01=E2=80=AFAM Gabriel Rondon <grondon@gmail.com> =
wrote:
>
> Replace manual mutex_lock()/mutex_unlock() pairs with guard(mutex)
> and scoped_guard() from cleanup.h. This simplifies error paths by
> removing the need for explicit unlock calls before returning.
>
> Most converted functions hold the lock for their entire body, so
> guard(mutex) applies directly. bmc150_accel_trigger_handler() only
> holds the lock around a single register read, so scoped_guard() is
> used there to keep the lock scope unchanged.
>
> Signed-off-by: Gabriel Rondon <grondon@gmail.com>
> Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
> Changes since v2:
>  - bmc150_accel_get_fifo_state(): normalize fifo_mode to 0/1 in the
>    sysfs output (data->fifo_mode ? 1 : 0). v2 dropped the bool
>    intermediate and printed the raw mode value, which would emit the
>    FIFO mode bit (0x40) as 64 instead of 0/1. The original 0/1 output
>    is preserved. Reported by Jonathan Cameron.
>  - Collected Reviewed-by from Stepan Ionichev.
>
> Changes since v1:
>  - Drop the verbose list of converted functions from the commit message.
>  - bmc150_accel_get_temp(): keep the original declaration order; no
>    unrelated line movement.
>  - bmc150_accel_get_axis(): convert to guard(mutex) as well, the only
>    code outside the old lock scope was a trivial error check.
>  - bmc150_accel_trigger_handler(): use scoped_guard() so that no manual
>    mutex_lock()/mutex_unlock() pairs are left behind.
>  - bmc150_accel_get_fifo_watermark() / bmc150_accel_get_fifo_state():
>    drop the intermediate variable and return directly.
>
>  drivers/iio/accel/bmc150-accel-core.c | 68 ++++++++-------------------
>  1 file changed, 20 insertions(+), 48 deletions(-)
>
[snip]
> @@ -624,25 +622,21 @@ static int bmc150_accel_get_axis(struct bmc150_acce=
l_data *data,
>         int axis =3D chan->scan_index;
>         __le16 raw_val;
>
> -       mutex_lock(&data->mutex);
> +       guard(mutex)(&data->mutex);
>         ret =3D bmc150_accel_set_power_state(data, true);
>

Just a heads up, Jonathan or Andy may ask you to add a blank line in
between the guard()() and the function call below.

>
> -       if (ret < 0) {
> -               mutex_unlock(&data->mutex);
> +       if (ret < 0)
>                 return ret;
> -       }
>
>         ret =3D regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(a=
xis),
>                                &raw_val, sizeof(raw_val));
>         if (ret < 0) {
>                 dev_err(dev, "Error reading axis %d\n", axis);
>                 bmc150_accel_set_power_state(data, false);
> -               mutex_unlock(&data->mutex);
>                 return ret;
>         }
>         *val =3D sign_extend32(le16_to_cpu(raw_val) >> chan->scan_type.sh=
ift,
>                              chan->scan_type.realbits - 1);
>         ret =3D bmc150_accel_set_power_state(data, false);
> -       mutex_unlock(&data->mutex);
>         if (ret < 0)
>                 return ret;
>
[snip]
> @@ -1187,10 +1168,9 @@ static irqreturn_t bmc150_accel_trigger_handler(in=
t irq, void *p)
>         struct bmc150_accel_data *data =3D iio_priv(indio_dev);
>         int ret;
>
> -       mutex_lock(&data->mutex);
> -       ret =3D regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
> -                              data->buffer, AXIS_MAX * 2);
> -       mutex_unlock(&data->mutex);
> +       scoped_guard(mutex, &data->mutex)
> +               ret =3D regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_X=
OUT_L,
> +                                      data->buffer, AXIS_MAX * 2);
>         if (ret < 0)
>                 goto err_read;
>

Another heads up, you may be asked to refactor the critical section
into a helper or do guard()() with {}. So, something like (and not
compiled! Also, don't use this directly, the mail client I'm using to
send this converts tabs to spaces!):

{
        guard(mutex)(&data->mutex);
        ret =3D regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
                                               data->buffer, AXIS_MAX * 2);
}

or:

static int bmc150_accel_trigger_handler_helper(struct bmc150_accel_data *da=
ta)
{
        guard(mutex)(&data->mutex);
        return regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
                                                 data->buffer, AXIS_MAX * 2=
);
}

Obviously, the patch as-is seems correct to me, so

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max
