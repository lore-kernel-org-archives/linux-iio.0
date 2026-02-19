Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB102DB794
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771529559; cv=none; b=gZ3+2uswaRMygMEMXrin0VgcH9nm5sCUmn60vIPXwegbOpfl3TP51+wpBadx3bFPr69qU/dUGkFLfoU7UcIemyUc26A3+X9K81MlH+S3tyrRTWMXyBaqdpjLo8BhQi60WJ7Z5pPC4IK4AnLFWKI23Un/MJTjrx4b9/wkrGzPAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771529559; c=relaxed/simple;
	bh=XAfvJ4njJqyaWiBgyk54k3PGrRT6JzGHA113c5BB780=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YUiuWjCiLqyz8DURaAZNBX7aAY/DvvbOpJw5rB1SZWms9C+Xe2xo5R7bzN4/mKJjoK6zFYWUyyJXZ3t/rnr83hmDQibaffIaC3VmXDkDL3aA71mOXOUSruyfXSvvD/+Uc3rq3LMG/hJYYZgq6vP6UobL1pOWqhCX0rfKrsoydbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAVY4Z8A; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAVY4Z8A"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79628fb5c05so11301047b3.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 11:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771529557; x=1772134357; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXJeILqeJfv+jeFAG6DjxJuKznKbbl1HxrY09L6YJYU=;
        b=fAVY4Z8AbDU7akY+don65nyzSjA2tt5s+mXg/sGWXWcXVtWJ0G/KRqKaKvwmwmZyBw
         1ghV5dWlrhMvkrxn03Z6b0lmWiEgXbKVos8DxR5e7CuQWQFD5mIiyB021S/g7XjNygIs
         rpDglBrZ1DP2FVCE/VPldCgBpA1a6RHwnSIcEnQZe4XdGXU2YDRRokrQUSWrb4sxcQ+w
         URpOux8SSP4oA0Ny+HjiDepPSI//Nn1hmVfgHk2X0z4EBouynj9uIEH3NHlU5+lC30Wi
         d52ts6l5f3ZwEg+FHL4fKyQNHclaOkUcboQLNHlVqtvUFv9ntrFY0JN5ahIQKziERQnD
         QA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771529557; x=1772134357;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXJeILqeJfv+jeFAG6DjxJuKznKbbl1HxrY09L6YJYU=;
        b=UP6Zs5YXyv/s7G8rzAHJ+t8LaEJ6vwzmxu8mdfpvFZxg/wKrKCvzivRJPqPcvr380s
         eh09L7tHQZ/SBmqOQ6D/pu59xM54Kf5157Qfe5V7A7eb6mHEq4kRycJcduJ1iBaaRZF8
         xNI71XLbaF/reKmeO+CfbWC/eg8PrOqQOS+GmP1U9thX3Z7S1AgNp8wIkJvV1AOminwQ
         QaS8UxoDpVJQBu4QbIPT7XwGI3QARGN8RKkUjLa9gNuMqdbzThTppTvPQaQxQ71oty1V
         lsl5o3NZqKX6cYPXCcuAVnLomaB1ypViC9c2sC93V7AbqJVso16RxxbjkEr0VeLVAJ3e
         8LOA==
X-Forwarded-Encrypted: i=1; AJvYcCXMs+3KuDRWzNn2+sKHdbFe+nA3Hgy9vgQVs8Ljlv5S2b85FAuVBai8hcLqLWRJ00lGvACUCz4CuwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRwoYOS0h3Oa+t9N/Ms+kO2ocQlQRHNWCkZ6KHnF5k94zrNfrJ
	ImZByNMz2NIUV64+2R0jdX8oFMliDjZhwuUkLo3hEdTRoV6YRGIFtuzx
X-Gm-Gg: AZuq6aIO6RLDVFzH086S+dBjmVYSYOX86t+vnP9Y1NzgwMidb2sR3Zfd4YCQZyM+i5X
	KVtw6FLwJwkFRvopoAv979RQYiiCmW1ocgPdNIguI6AowAMYmyS1966nE1iCyx/WMObunmOzCuJ
	zyYkFHC+SjZ+2ivXSj15VOmvmOFijNRur2n9cR4Z+XgxFOx2uUA+j7OFiT+eq69dULa7uj8x1aU
	AB+0cEwf3cPNOl2URNz1srp6T66+m5iYWkzFuI4bkBkOQ5MWrMI+hcXsiQxcdelB6rjDBsRu0hR
	ZMhAVsIQKkC732HZ7hGE2XMGU3ttqrO1fmm3nZepWyBBlNSbWITR0S0qy4osD1u/+0Qyl+NPlYI
	Vrqx32Wf2qrK0bJLnjqDMAt+p+PrNSwdwlOwC+j9BUWAY85yfYoi1mkzYuXFUiGnA81oU3aiFBI
	99lY3h9I7SkhAH7ewhX7LvspBxMrqB0hBtwkrTf+21KJ5OvWPqLGFJJROBT7qh2rFMn0yTulTjG
	fH0zd1zVTfcrcuCd8OoPp33HgWqpuSaMAtJBTn2Msu6hK0mapo=
X-Received: by 2002:a05:690c:102:b0:796:409d:859b with SMTP id 00721157ae682-797a0bf18b6mr148597877b3.2.1771529556765;
        Thu, 19 Feb 2026 11:32:36 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c254d5asm139396447b3.43.2026.02.19.11.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 11:32:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Feb 2026 13:32:20 -0600
Message-Id: <DGJ6T7SUJBFE.1BHJKFRV7IPTT@gmail.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 5/9] iio: light: gp2ap020a00f: Return directly from
 the switch cases
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Ethan Tidmore" <ethantidmore06@gmail.com>, <jic23@kernel.org>,
 <andy@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260218043728.609659-1-ethantidmore06@gmail.com>
 <20260218043728.609659-6-ethantidmore06@gmail.com>
In-Reply-To: <20260218043728.609659-6-ethantidmore06@gmail.com>

On Tue Feb 17, 2026 at 10:37 PM CST, Ethan Tidmore wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Return directly from the switch cases which makes code easier to follow.
> In some cases convert pieces to the standard pattern which also unifies
> it with the accepted kernel practices.
>
> By doing this, it appears to have fixed a preexisting bug, the variable
> err in  gp2ap020a00f_buffer_predisable() is only checked once for errors
> after the for loop is finished. This could allow errors to be swallowed.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
> v4:
> - Integrate Andy Shevchenko's cleanups.
>
>  drivers/iio/light/gp2ap020a00f.c | 96 ++++++++++++--------------------
>  1 file changed, 37 insertions(+), 59 deletions(-)

...

>
> @@ -1366,7 +1344,7 @@ static const struct iio_info gp2ap020a00f_info =3D =
{
>  static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	struct gp2ap020a00f_data *data =3D iio_priv(indio_dev);
> -	int i, err =3D 0;
> +	int i, err;
> =20
>  	guard(mutex)(&data->lock);
> =20
> @@ -1400,15 +1378,15 @@ static int gp2ap020a00f_buffer_postenable(struct =
iio_dev *indio_dev)
> =20
>  	data->buffer =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
>  	if (!data->buffer)
> -		err =3D -ENOMEM;
> +		return -ENOMEM;
> =20
> -	return err;
> +	return 0;
>  }
> =20

Looking over the code again it looks like=20
gp2ap020a00f_buffer_postenable() contains the same bug you mentioned
where the error check should have been inside of the loop?


	iio_for_each_active_channel(indio_dev, i) {
		switch (i) {
		case GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR:
			err =3D gp2ap020a00f_exec_cmd(data,
					GP2AP020A00F_CMD_TRIGGER_CLEAR_EN);
			break;
		case GP2AP020A00F_SCAN_MODE_LIGHT_IR:
			err =3D gp2ap020a00f_exec_cmd(data,
					GP2AP020A00F_CMD_TRIGGER_IR_EN);
			break;
		case GP2AP020A00F_SCAN_MODE_PROXIMITY:
			err =3D gp2ap020a00f_exec_cmd(data,
					GP2AP020A00F_CMD_TRIGGER_PROX_EN);
			break;
		}
	}

	if (err < 0)
		goto error_unlock;

Just wanted to confirm before putting it in the v5.

Thanks,

ET
