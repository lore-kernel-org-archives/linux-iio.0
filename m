Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5198B38A299
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740115; cv=pass; b=i9rLr3jBcAo2M4YiooThRUu1i/fg1Wbz1av8c+l0d+9oIFE6Q+Ea6wqD1SQdTE4mcSw+igVDF73JZ1mDUczZwOYKt7O4BgqLz+fqsCsn30lM5IxWubHbxAcoVKZwrpceJnv7RsVCmrZTjgwjY9sBs3uqJfMYkY4iqz7WI5xlF6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740115; c=relaxed/simple;
	bh=iH4e5Jowcat2Bj14dBv+UFq9ySSKQcMntdR6j2k3xG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHCA34i+LBZBxsJNeBoBMdizeInVLS0vUb/Flr8YmMJl6KQyQUQpNtLEBwVKFje98sKZdjROkyurvdml8nT24yOqlIY8ZGelY/K55d664h+chOTATXElxvFzhfPKwWqexn/nVjS8QA9v9BtqH8uUpkR2KDhj7hLIIO8chkw49k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTfVn+XI; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTfVn+XI"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-895495b5b81so6289606d6.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 08:15:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770740113; cv=none;
        d=google.com; s=arc-20240605;
        b=Z/YPcBPA0Q9d9Wyn6CjVVRQdxamAtwU+yOQ1vN/ZXILOs0340jismstyDseF8NrieZ
         LHES9IbF7X+QhPjbFyzPsgwbaHeb8Te6cytfKERFzvtUJv+SFTuTElAWGdvzCP0D7ueP
         r8r010nIaQhburvB9YDmFOwFIGNkFmKSYGxcpKieDxV7amvAanQ8zzqfNEr0SWr5zwPF
         fqCE7qE4GWhna7cBqPN7obtWZctB0zITFU84/41Lm2g+q8AMp0eTBla/Pz1qLvZ4kSL0
         CDMh/yFDa2UeNGqLHS/lTW9g61jB8loAwPYgp1Rn7Bzshx7TRolU77yBIr/Y8XgO0Xy2
         EhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K2812jiuGlQ5vn+WoZtEaqHAJ1LIQ42eAqZWJrwtTGk=;
        fh=j5EH7PXkWPfFjKofIxgw9dRGUIgARVMQbJLXz7wRSs8=;
        b=G7MRRCH3gGwLsFjga66BIkxvxNyZl5HUtwbSdUKdWG1QRL6Dk3nHDj+CUV/gy4tz/8
         8a/GBN2w4HQ1k+jsD7b5HiyvzfDgVdqWGNMtxx0zIEPHvEWwGM93jG79J3ugSjv/uivs
         2wX8CbuP6KzM+FKhTHo/hO8rxZLzr9eLfyYC0r7JjYuIl3xSKSBO+uUCZdSZIcYm+Onp
         nKMnJK2SmaW7PhTmLH+9bp4izVyoR8h0ziJtClZVgqEsO36zm7jX8CnqMtnP5h0F9n8z
         LfxOwYDNvb+PqSRQPfAyTC2hTZj5msgFmFgMjpcfcRb6MHSDPXMha+3xFdY6NPIpboH0
         FKcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770740113; x=1771344913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2812jiuGlQ5vn+WoZtEaqHAJ1LIQ42eAqZWJrwtTGk=;
        b=JTfVn+XInD6lkZVxrpcWAgMKqDEbN9Yoq4O9LkwGtkp2zQ2ynu53KA/UKF/G26Ky6b
         mLBsSUGcRstyrVwaNFhUbQBQ2oSFUmA0lYK/EYaQ5xEGQUy0murv/97AFVmOg83rZ7Ux
         lbKsxeO75gXx8iEqBmIaijB13gm4+opNppOnGvJhKA4KmNCeZdopGIkCVKGCCZ+pqENZ
         pKTTu2utye4sRuOpl2KC64W7CI+m8IBWjG0ok2WjbBTDKShMKOE68JtDnRvPNvKuF30Q
         u+r1Fv+edLwP80r5RJXVeSuWwSLuJBtJez1UWBC9EV28M1zfOtfeMKONg61fOcvR1qH1
         VZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770740113; x=1771344913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2812jiuGlQ5vn+WoZtEaqHAJ1LIQ42eAqZWJrwtTGk=;
        b=GT9R0E7y73XUcAk4U45lsys37UlRpsJju9Ca/G3S1XoYNUazsdX1w8/Npm+SJgmgCF
         KCrkHWCzk4sdtu3cffSp5ldNHh/bmujPPsZMsgww2Woydy5OA8Sse4Pf9armTVnX0sqV
         Fg3SjUgg0w0WHrU8s4q1vv8FRcMuIlKrkKdBTqgkijJAWKiWglfryJh4sBDM6Kdpa33H
         SfuQ2k0/4lOJWn9DixEKoPSWhpK7NKw25qd47MunDubrD6WHAAphy4bsyrO6WmhJBPxy
         YLv72WMgCjPvGPnIZLOhTp96Bmfz7ec8q6vxT46ymDv6c+6f8kdHNjQrb6XTz3Xp9pyk
         e82w==
X-Forwarded-Encrypted: i=1; AJvYcCXeseHYmhv4ac2tbTZP29m3gZQN4paDXCRBi5ounRsadzpjDE9FZgFtr1yuzvnyz0bGKFtCPIKtTvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhIy7eUOsatAahSb5TKs4jliES6GM007Zl1yTLJpxi85uRHoYf
	xK/aEMfs5Khf67oZYU3mQg/Hfr0rdVoGAL4B7FowxkwdU4ERoNsiFYaw85c4v2E43dAczNVJYoj
	C6+DL3pamFMAuCPDEDlcCRmMI9P5GGIc=
X-Gm-Gg: AZuq6aKBIROkqwfjXQdTVnZT7mwP6y3G4MHYfoZo2ou+CBg9eIYQYuGz8zmXKIrFdhd
	DJT/M37OuYISL6bX4QdWnUMuoCm1Y15C1h2h8oq2flRlGDwEw32btY6jAl6UR6PJAEl2ayCxlp2
	2bopX2E0zJF9XzxGkWC5ZWRxoQe+1D/3FeZy3lkuzylqn9dieJGzLU7g3RDpJw2Qat8KyK68AGB
	DKW4ZmybOeKhPNOO0M1R0lmW5/tKGLvezVidLIGZ1jeq+NimKDEn4332uhs1hwfzR3DhWBgsaZD
	ToxnaK/KrvVGpHIeoUZ0UXei1gZ7KwjgbShzrfgF3XRSYOyt9L/e3ewiAm4AWnT/DN0flY9d1p6
	t7BtIUUs=
X-Received: by 2002:a05:6214:4708:b0:896:f523:155a with SMTP id
 6a1803df08f44-8970febb062mr21085446d6.6.1770740112834; Tue, 10 Feb 2026
 08:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
 <20260209-upstream-20260219-v1-3-2b4d74e309d1@gmail.com> <aYmf4MtCBmwZBuAV@smile.fi.intel.com>
In-Reply-To: <aYmf4MtCBmwZBuAV@smile.fi.intel.com>
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Wed, 11 Feb 2026 00:14:59 +0800
X-Gm-Features: AZwV_Qj5NaqNtf0Z9zN-OvR7xN3-iTpFXdm4oagK87YM9LtQiYsrqJb1rM-G7kU
Message-ID: <CA+NOmz+cH_5C4T2S+UPeSFJdxSdz5fimbmp6XmovUqKMcfYV+Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] iio: proximity: hx9023s: support firmware-name property
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 4:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Feb 09, 2026 at 11:37:04AM +0800, Yasin Lee wrote:
> > Add an optional firmware-name property to specify the firmware file.
> > If not provided, the driver falls back to the default firmware name.
>
> ...
>
> >       struct device *dev =3D &client->dev;
> >       struct iio_dev *indio_dev;
> >       struct hx9023s_data *data;
>
> > +     const char *fw_name =3D "hx9023s.bin";
>
> Preserve reversed xmas tree order.
> And looking at the usage, please split the definition and assignment.
>
Ack. Will fix this in v2.

> >       int ret;
>
> ...
>
> > +     ret =3D device_property_read_string(dev, "firmware-name", &fw_nam=
e);
> > +     if (ret && ret !=3D -EINVAL)
>
> Why is this special error code check?
>
Good point. I will simplify the logic as you suggested and remove the
redundant check.

> > +             return dev_err_probe(dev, ret, "failed to read firmware-n=
ame\n");
>
>         fw_name =3D "...";
>         device_property_read_string(dev, "firmware-name", &fw_name);
>
> I believe if wondering one can get a debug information from
> request_firmware_nowait() on what firmware file has been actually used.
>
Agreed. Thanks.

> --
> With Best Regards,
> Andy Shevchenko
>
>
