Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFF376BEC
	for <linux-iio@vger.kernel.org>; Sat,  2 May 2026 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725940; cv=pass; b=hKvH/n3AaaanadGpqKNlrcsLZAMXR5MCr1j0x2bGD2bMwUdzVb1hNYZO6xT91Gi5JvMnkKl9RbEdQNaQiM1mK54kUPH8f1zTdcY5YjwHRemdDvhUsrXEK0gMeEFPKDzta+4ko02Rry1w06P/kNS/hN66RKsY3+L9jOFZ1jsEya8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725940; c=relaxed/simple;
	bh=n3xseiNIVpllcVpiu3P4TyieWy+FX3D8w8ugihmNk6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mgh1ZcETrcedrCHGz0c2d639YIVaz8NNkUdAsiGG68bxXOV/OngNR2vp6BWDij1/EkwXKeRIjJ6kannQxrLSkTRUSG17yAuKT/s81R/cqTrLHGtsoKmIo7ZN/eN/RuT5UPQPx4hz9bn6iWyfBr1lATC3X1TRXsDLCtsncCbUjP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8zY0/Eu; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8zY0/Eu"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-444826c16ffso2455068f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 02 May 2026 05:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777725937; cv=none;
        d=google.com; s=arc-20240605;
        b=eCqVLsc+tBIqVcltvUrb5k40lwswi6rKJP5EHUJBOayIdxzwFgKSnxMihweD/eTogR
         EgFUoOvw+aMbio3I213SmPygMljMo/tt2Yzz8vQgwhzXzDeBEUaxiVHW7IDt1sgFNeXx
         i6OE+TviOyQynQysaBGrH/Gor2TmbbcFTlVhCDjxn4xhLZtp8/dhUmcT5Q2rs3HSiU98
         Ympkxdnji0Rz3LyZ/HKWQRhzHdQtX1eUIFb73lGwctRxM9wLEJxmNSvAyEmpdSyQlXQt
         088oHQ152LLWBI4y5g3W0E7pgPaOADLfD5FOjYFydgcBqnLbuXADHBBKnNEgcOUIMEkc
         xNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UFEiLFgiMdeWzVKtIkFtmgYmWXOcnLKXA7wanDd2Y4o=;
        fh=NSBaB+Frrwe4MXpCk58Hy8ivPSXQCoDeFEjx/Znre78=;
        b=LYu94NNpLL9KESDxHjarnbx9Pa28+08fBcst4MJltwFmo7qHS3Y/S/mALtednVV6ST
         b/7RVg7I+27dF1Hrf+Yu6kxtqNUqSkXoMlXEPgmmQfNRVzdn10vSjz90kOc0YXL7YLdR
         7IjdkTRX0h12WlLvP/EA2Fo4dQA/D47jU0//53UUS5Bo/4M3s06BcAYKzPyd2o8siB64
         +uLQTvKYqAwUlVIVcDtp7cfBX2lLGWltJH1ysMyUnLcOqUA3eAOq4n+yr0QSMxgAq4oI
         d/Lh31QBTX3RnClkZM4k6DMpVYRS76DPa0K651ubbwXHHGRvwS6Di7FUlEegO7QZUVUf
         oeWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777725937; x=1778330737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFEiLFgiMdeWzVKtIkFtmgYmWXOcnLKXA7wanDd2Y4o=;
        b=Y8zY0/Eu9T6rqah5cGCWpRV/8CTgLf0S+OCyMIqSQrgO/TqsDBySbFHaXgdhDcBEhm
         TdyuATXDG7ZL/EIgJjeFETfExIn8g/CkRk7fAi8ge6+wY8wj1PYEMPc5d9MhsxwSmVil
         aU/I0Qh+Q4q1B1UzZNhyK1iL/mq3jO01ql4vA9QbcmhSUGjeeEWf9CxU93Dy2auzx4N2
         cwnnzTmQRxVqubBIGwFWLXlsWKZl479Krgy9u1z/JY5KjfdLdWELx3AEAd8jCbJvLfTj
         1BUWdhf05x9Vge7RLoUbS113sfBsiLbjGVhkjzAH2uI9wPOCj3c8atw2cwCa8sIQgOuc
         k48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777725937; x=1778330737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UFEiLFgiMdeWzVKtIkFtmgYmWXOcnLKXA7wanDd2Y4o=;
        b=Oh8nfmnyfrHEz9QcIEGYRCmY5lSLVyCkd/10fmqhxJVNeQ3x9htVEyalYP7PwkYzq4
         0cZgGzdxIG13zUxfmkQCxI8xj4Dvx7UzVRYkqMrzupnAhEe0TMnwJbKTrMeL1aDcL+CM
         1V3IT7jVJzl3ypAUQWfAucewYb23cJzLpjOCZ0siejEzppPNzqDthCPltjr1zJc3XRzp
         PXHyJegOOftAXVYqnATXbNdtCHgzIDY5H4weGNjOd7KTcGBI/m7gp4fujEqo4o+k8tBf
         TQ628dVPZ0A+5z4KMcXOFENNIUCa3nAViRef3JSNjHTsWnU5h00hZGHRad9wHl4aLDqH
         Aqrw==
X-Forwarded-Encrypted: i=1; AFNElJ9Q3h1HQbe1pOKskv6Q+gXyxkdLha9hkzY7TtLXQcAg76a/bCx5QnxgSHz9o3rCML9p2Tx26nvK/ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YztwFfPLCNTqMWx2RaWjO+O/9WvvxxpTxfLKcuRmxKdnUwVoANO
	QGUBnxuHdyv+42Zx4CHqz51l8O4JuZgB1UO+qRfhcq53aqVSrzk1dQfnrP8FAhlt7Dk+rrPDlvv
	E0vXC+iJWz9hc8U3eL8+DgBHYOdmQQYw=
X-Gm-Gg: AeBDiesjLVL6u/z+QjUObtS+yL4PW+WXYPPXNz6ZSYKf8/3W6zVx01SJxup+u1VdM1K
	pdRhEMkBaN+402qPNrkWxU0Ajf1yGacoWArd+5E6kDqlQ2qmStqdiwswHkyFIDVA2A/gZXwmwkD
	TEiuZtkOzGqxqZfQFfDAUy/SXO0mnlCMUoXE21pYLqbBwJ2NlR8Cv8ASXCbl7gny45WRt6aq73o
	alBTmqEqf9hfeg7+OXUoIp5AvBpctxeFkFlXEJ/LMe8lV6g8fkuO7WAHjmo/xyaq4s6eGLQpWqj
	7rq334wYbl1HdC6G43DpMr8cM3SDU5i2q5oj5BfbgrxuvIytQUDE27k5NfHyLtu5bChs5NbBnee
	xls0KNmgk0GO3OpyfXdX7Lh5A/qa7AQd4V+rsx0Ui3dWSgeGDLzACPJq0VL/MinW9/GGsftd7Qh
	Xjkhyswx75D+WgoZXR05h03C5xP0BfZaGLBbOxTEsK6W0l5uMs
X-Received: by 2002:a05:6000:2313:b0:43d:77f4:7145 with SMTP id
 ffacd0b85a97d-44bb5680d79mr4852242f8f.19.1777725937241; Sat, 02 May 2026
 05:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_EC262467CD5E46CA97CF2B2FDCBCA0565C08@qq.com>
In-Reply-To: <tencent_EC262467CD5E46CA97CF2B2FDCBCA0565C08@qq.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 2 May 2026 14:45:26 +0200
X-Gm-Features: AVHnY4KxdE-SEktE6ItXq7xcFgqr0xVAdOiLtKg-q3U-oWGA6xPYzkRFtKeHrHA
Message-ID: <CALoEA-zKcE2FXu3g7EC7OKSJmEtN0SWjy9ce07yQeMph4aH+5w@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adxl313: fix typos in documentation
To: Wang Zihan <jiyu03@qq.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2 May 2026 at 08:07, Wang Zihan <jiyu03@qq.com> wrote:
>
> Add missing space in "ADXL313is" and correct "a single types"
> to "a single type".
>
> Signed-off-by: Wang Zihan <jiyu03@qq.com>
> ---
>  Documentation/iio/adxl313.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/iio/adxl313.rst b/Documentation/iio/adxl313.rs=
t
> index 966e72c01..3662153a6 100644
> --- a/Documentation/iio/adxl313.rst
> +++ b/Documentation/iio/adxl313.rst
> @@ -11,7 +11,7 @@ This driver supports Analog Device's ADXL313 on SPI/I2C=
 bus.
>
>  * `ADXL313 <https://www.analog.com/ADXL313>`_
>
> -The ADXL313is a low noise density, low power, 3-axis accelerometer with
> +The ADXL313 is a low noise density, low power, 3-axis accelerometer with
>  selectable measurement ranges. The ADXL313 supports the =C2=B10.5 g, =C2=
=B11 g, =C2=B12 g and
>  =C2=B14 g ranges.
>
> @@ -112,7 +112,7 @@ apply the following formula:
>  Where _offset and _scale are device attributes. If no _offset attribute =
is
>  present, simply assume its value is 0.
>
> -The ADXL313 driver offers data for a single types of channels, the table=
 below
> +The ADXL313 driver offers data for a single type of channels, the table =
below
>  shows the measurement units for the processed value, which are defined b=
y the
>  IIO framework:
>
> --
> 2.54.0
>
>

FYI, please wait 24 hours before sending a v2.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

--=20
Kind regards

CJD
