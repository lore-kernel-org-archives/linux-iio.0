Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D51A0712
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 00:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078340; cv=none; b=XjC2cfMGm48B/B07AawQEYJu9o8tKuN1UoeMYS+ZALKf4B1ULYhHrjLpI1XfaX0ZJoAl7a7JHhU6wQQB8YIqZpvuot46SYrx5PLooGLzA7WB3hHmFj3S0XUfW1D8k6dl5AJjoPmBrZuTliFN2eJRmrPhIb8dJC2uMZkSpArO3Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078340; c=relaxed/simple;
	bh=Kt81Yd3F7HLokt8mXMiEb0ooMHC1f33dUjW6mARYkOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fS6mo7frk5fYn8HGt3/rYWJv5RnBLxG9d9Ujjj7POSJwi9RSExSMHxavoQC22biZqFPJlEyU5Nic0KKBvBmvRSjZnHTJxJWbkoVS8fO4l8oEPQeakGuN8Z/lHrBW4t8wGex1/IPSL8QVXK0C52gxRmvyUue0bjJXFKWVikcEDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwPAu6rh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwPAu6rh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE45C2BC86
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 00:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770078340;
	bh=Kt81Yd3F7HLokt8mXMiEb0ooMHC1f33dUjW6mARYkOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cwPAu6rhW5/ejITSELQBtytS4EOpgRF71+d+TnxrRf+y32HFhYqUWG3rkXVcsZRiH
	 gBvzLuy+qha6ycH/rLNGMbk9YjRbq8Vl63EsLryg5bKz/2XWHTdhdjlqB4vG2/bLGZ
	 EK/l/XGQbegzgLoAvAH3z4vlwic8NHtqLqJvfv51T5rGxCgcwJ+LJBk1t54YYW6FUm
	 Y8cdl4nqNVArnCyzzuhDUFgYdQpIdOjMeAJ3CPzYx8u8cKTv3fV+6eewzWCWUbBZcU
	 3J0zSssjnECoeRSUBZuBt4b9K0GHjjn+TIdvfpD1phVjkZELIZdlKl+Gju4j2KPEol
	 T4PoVJ2R58ogQ==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79456d5ebf9so49628407b3.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 16:25:40 -0800 (PST)
X-Gm-Message-State: AOJu0YzZ1vAUF9vlmfqiv48Qem7aBtIMHFw5n31rE4OTl6OPmf2fwUcG
	eA6dpy6NkDcwh6yYS+QF1qGBLzevCiGra8DNoHvHvdYv6AgcdTu4cibpaVrUt17nsWQH3nqZef3
	tHQPBXZboSCIhc8qIsw6F1aAGdUTrcbA=
X-Received: by 2002:a05:690c:10:b0:794:1447:1adc with SMTP id
 00721157ae682-7949ded8fe6mr131488927b3.22.1770078339352; Mon, 02 Feb 2026
 16:25:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202110304.236320-1-jerrysteve1101@gmail.com> <20260202110304.236320-2-jerrysteve1101@gmail.com>
In-Reply-To: <20260202110304.236320-2-jerrysteve1101@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 3 Feb 2026 01:25:28 +0100
X-Gmail-Original-Message-ID: <CAD++jLmXbbmawezYN-V=UFvy75Be6RdrcW_qFm+pnrc06mO3AQ@mail.gmail.com>
X-Gm-Features: AZwV_QhT2q8uAbpAzS5Al6hdciBIUlk7vpXlk2ljwlN8Yn-iRUV79OQABSjFgcY
Message-ID: <CAD++jLmXbbmawezYN-V=UFvy75Be6RdrcW_qFm+pnrc06mO3AQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: accel: bosch,bma255: add bmx055
 accel binding
To: Jun Yan <jerrysteve1101@gmail.com>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Cc: linux-iio@vger.kernel.org, stephan@gerhold.net, hns@goldelico.com, 
	jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jun,

thanks for your patch!

On Mon, Feb 2, 2026 at 12:03=E2=80=AFPM Jun Yan <jerrysteve1101@gmail.com> =
wrote:

> Add the device-tree binding for the Bosch BMX055 IMU (accelerometer part)=
,
> which is compatible with bmc150_accel.
>
> Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_dat=
asheet.pdf
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> ---
>  .../bindings/iio/accel/bosch,bma255.yaml      | 43 +++++++++++--------

DT bindings must be posted to devicetree@vger.kernel.org, please resend.

>  1 file changed, 24 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yam=
l b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> index c1387e02eb82..5c44b8cf156a 100644
> --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> @@ -16,25 +16,30 @@ description:
>
>  properties:
>    compatible:
> -    enum:
> -      # bmc150-accel driver in Linux
> -      - bosch,bma222
> -      - bosch,bma222e
> -      - bosch,bma250e
> -      - bosch,bma253
> -      - bosch,bma254
> -      - bosch,bma255
> -      - bosch,bma280
> -      - bosch,bmc150_accel
> -      - bosch,bmc156_accel
> -      - bosch,bmi055_accel
> -
> -      # bma180 driver in Linux
> -      - bosch,bma023
> -      - bosch,bma150
> -      - bosch,bma180
> -      - bosch,bma250
> -      - bosch,smb380
> +    oneOf:
> +      - enum:
> +          # bmc150-accel driver in Linux
> +          - bosch,bma222
> +          - bosch,bma222e
> +          - bosch,bma250e
> +          - bosch,bma253
> +          - bosch,bma254
> +          - bosch,bma255
> +          - bosch,bma280
> +          - bosch,bmc150_accel
> +          - bosch,bmc156_accel
> +          - bosch,bmi055_accel
> +          - bosch,bmx055_accel
> +
> +          # bma180 driver in Linux
> +          - bosch,bma023
> +          - bosch,bma150
> +          - bosch,bma180
> +          - bosch,bma250
> +          - bosch,smb380
> +      - items:
> +          - const: bosch,bmx055
> +          - const: bosch,bmc150_accel

Maybe drop the Linux-related comments because DT people seem not
to like this. But it's not your fault because these comments were there
before.

Yours,
Linus Walleij
