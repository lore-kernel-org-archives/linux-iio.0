Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7368A38AC69
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778316488; cv=none; b=hSnkiwr2RQRQE8XwNz/f81LaIpcfGyZNGT1M0Elfk+sOmbHjDedLcaNF6LKD6cEKLtHQZbDqxMPBYgkrrAPfPFo7KAYOv6jWbcJcXhzBajEoxBunKsa15Nxm8iHD4Bcn0ZLMlJQGeUEcE720lRNG3otdgo4HcYA1JLEJDi5jVMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778316488; c=relaxed/simple;
	bh=VswzDcljI6wRl/2DfkhePM+YJOqD8YtJw6akkUhmkTc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XysU5XvzTAUAGorGNhrZmSnTQCFAwC4x1FcH3uDI81FZ7Vu7ubXLr0tO9g4DysMs5vDodjdCgrp0ypvzxpVoc5s4uluwIDJQHONzS+zdqmG0PNplnU9qQSKJzeTEH28QOy7ieUhGFAy/AsaEP6n5wDBRp4Xx13989qYzhGwEM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fchUGrNb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fchUGrNb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso29585505e9.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 01:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778316486; x=1778921286; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s4VVVsfWQbo/AjtN7IMp9BZ18dLmvuVQ9Rd+9op6G4c=;
        b=fchUGrNbi3iluxzZcdhj2ApUTJmCn6dTqPZlvGVp4Cdhckw2VBqma4m3qXyb29aanc
         BbcRqJ1YLjTgdMUx9PXCjKa6dS0h40T2xQ7mKW/SvSZ41+r58MdMAKW420lrisEB06XN
         87dcJvWitS5mTitldCi7perH0GpUJkWbpJmyw/R6IqRldZ1dhSj4ZPudCLVeSNAT9FRU
         4bzwtqAFGS58HX/JMYPxV3IP1QRODJhCMKe3cX7GTdDiiNeLthvLp43EkdwKn8vje+XI
         Xhf13e5wsYGgfRdPDEbAEkhXve+7lpjY1u2vUicRw7sBt2HCzkgqrHanRbuOZtMn+OAI
         gujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778316486; x=1778921286;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4VVVsfWQbo/AjtN7IMp9BZ18dLmvuVQ9Rd+9op6G4c=;
        b=svP3LPKYEB0Vv6nxJ9epZbzKjR/74utyH0+0R2sBPgRDCmM7Z6tYy5mTgJiom8Tf9t
         9kjYw7HzEVH06DtW6R7JdL0Fvk1CTKDLAn6IezPUJheVrTW0F8zDz2PXX5oF3UBBTUFC
         pt4LmA9QnggiSOYZ62/uv5PuMBnqOEREsXvcgoTcCBip78ujdBmGf+6AOuBvR1h6KCP7
         CS1ZhUNS3KYHLSlLYJqmT0Dz070KUWtEXkYgzel973RWeGtcf2pjA9uqq6RCU4ApPOTQ
         mswwuIee8/NnGgSQpPQjKGSOA2MLpxv/cpezthCjLdFuWLOW1V2WpwIx8z2InbqJDAd/
         9Onw==
X-Gm-Message-State: AOJu0YwZoLGcfyGEBcj+JlSgKxU4YhIYNZcYahu52dv6Phx4ovQft1pi
	saDKoiqf9vJ5zD9a+nD5HvA+1HdE3vTnMyuuZyj37oVAjX5fLVyPmaiWppjsrQ==
X-Gm-Gg: Acq92OE8fOrGUZFg43BQG34R7BgdETwzDdeQWLvTtuIOX/6AyxI7aCo7h6mQZs+9nyP
	Aco50nbLlPTyonHfUNjp4FOqb2B9rL+5GiVb3aPYqLycv0SE6T8k7uoQVsM9bTfnrkBOVYqFX0d
	YDCDGk9Hu0tpSgoNjbWr5UVl+EgOthyM9rt1uC8Ou82fDvA2KhpU1upOyvYMPcEJULBRi4w8z+u
	EfPtoQqGMDWep7HFHb5GZWvbFj0Z3DbTXPmuZTgwbZJZ4pdyLhRn/iqfdR0fZPzwNgCcKpEnjfe
	ywuGLSKp8oKPrDegSZbtN+AFedTXqdvTdT8LQUSsTqaUYMH/Trp/9gVe4k0vcgz34MdkReiHDZ2
	tlZUB1rxZBtrFgqwJNxGxa+OCREnmKeTUNswgsBfWZkZpbdGhdfKvXXnIZwfnE70tWcQSn5RLQJ
	hu+ZojLhF+NjuplNd7IRv89Y7j7GUiJ0m4VuSluaO50RtROMNMoxWwzx/ngBcefQrVz27G0iPPe
	igjDBABbZux
X-Received: by 2002:a05:600c:a411:b0:488:af48:af11 with SMTP id 5b1f17b1804b1-48e51e08ce3mr198050385e9.1.1778316485743;
        Sat, 09 May 2026 01:48:05 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8e4ce1sm18413675e9.9.2026.05.09.01.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 01:48:05 -0700 (PDT)
Message-ID: <8f7954ab47bb780b8114e96579ad3dff10af2ea8.camel@gmail.com>
Subject: Re: [PATCH 2/8] iio: magnetometer: ak8975: check if gpiod read was
 successful
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: joshua.crofts1@gmail.com, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 09 May 2026 09:49:05 +0100
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-2-37827ca68fb3@gmail.com>
References: 
	<20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
	 <20260507-magnetometer-fixes-post-pickup-v1-2-37827ca68fb3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 16:35 +0200, Joshua Crofts via B4 Relay wrote:
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>=20
> Add a check that ensures that valid data has been read from GPIOD. If
> not, log an error and return the negative read value.
>=20
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/magnetometer/ak8975.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index
> b990c123e2808c2078abcfaf6b2ef86c09393e6b..63b6e8465f5f3873841550a1cd03ce8=
6b95d1d67
> 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -658,6 +658,10 @@ static int wait_conversion_complete_gpio(struct ak89=
75_data
> *data,
> =C2=A0				 timeout_ms * USEC_PER_MSEC);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> +	if (val < 0) {
> +		dev_err(&client->dev, "Error in reading GPIOD\n");
> +		return val;
> +	}
> =C2=A0
> =C2=A0	ret =3D i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]=
);
> =C2=A0	if (ret < 0)
