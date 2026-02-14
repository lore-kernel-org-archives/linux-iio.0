Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871DD23AE87
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771085925; cv=pass; b=icXlweeg7acYJRIQU4rV3cZPJDJVSSIiaILsmr/4Ihk27ht9hhCXm0/Y3OS6WtZKG6hUdYMIJqbqQnIGl436eXbfu2odjOcevTiS0/PJKrfCq9ZcAs62swMiqMBrYPIuBapv7el6E1dvfxcBHuiRxD9CjAPLa2aIaAJTDhLJ2P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771085925; c=relaxed/simple;
	bh=F+zOdJH2aduC2BMqXskNYx6ekceGSkZ42XiIyjJDEaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OueKPAPyFqbtBJNSXOqb9x7LXBOqUh8GdbIxmZaHCiUz7PiWdDxdX5HaE/UjNKdtsTKGdWbIARLzhLMrf6eRK2tNEhbBKKcUr+K8LDCTIPKm3svyxeVplznt3n9tBPatSvey0lGT4aJSgnYt8T40b6agdBwg6zGjdHwoYYHqbPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jF34TvUp; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF34TvUp"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5032e59c8d3so2771991cf.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 08:18:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771085921; cv=none;
        d=google.com; s=arc-20240605;
        b=f1nAsosz+SNd45Nd5JU0bIFHpunh3E72HyEWP8bviPFmAyVsLTngOyYbtG6ZV2xWWf
         9WtaR3fF++DDBJoYfZe6k97XSPKY1XjW0yk3Oe2gJd3Ssc4AjYzCfMhLPJ6rPWFjtDMe
         UoR4UQZfjvyfnEdayXvifPAGhY6mel13xTLq1PLdSwaZ9M1f+8qcEanjJbse0jqsKe0u
         PAFsXAqGIbeXvqNIlXt4vvRt+mDD8/DZTm4/GUNrYTSzrC+isMthJVeTGPne1rzKodYy
         Pl/IrYi8uYYu3EGYC7IUMWkolmUKyGCncxDLkl/r7Q2emjQjiZlG7DUqtvo4ijzrB2W8
         upvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U4Pg7faVraxi6oaHzCJaQKTq7PIuXAtxlyfauuDqWFs=;
        fh=9l2nrbhedSUlTNc7vCaDltgnG/KyYzaBlcfd2Sj5sts=;
        b=btYTjGLesgk6aCsoQBJ7UVv3MHkuA5GSAhoOhmhActTd2egW636SvzT2qr7m59qYE6
         7NycPANmUwRdrkqtqqw/ddU8F4sOUFWf2BRorICJ3uY7jUhJYxIyRQ8Ebgt+4I6U25TH
         n2tnJ2/TFG5JaFTQ5QU3CNs18+cEgKN/yH1+TUJaqobrrXYEDuTwfQ22cDf3L3rGX5O3
         gjsmw9gQwDzqXFUjVKDKxU6FFAJVBe53t2JVKiO2norN5cACCZWYsrYJpLnCr4gZfG2P
         gpO31mmc9xKLsc3LsYkq9m6Xq6F7yfu0krJRNIP2cZxes787vcHaTpLTT4lExWjOIGcv
         4T4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771085921; x=1771690721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4Pg7faVraxi6oaHzCJaQKTq7PIuXAtxlyfauuDqWFs=;
        b=jF34TvUp/VYMl/n7fzTt/oADznI/8gbua8AlBo6V+lTnlpQOW5EPUzxNTgTma7T8pj
         Ts5S75Yi1jkQaLOt2CqSz4iGHN29YcvUldznjq/UdHkGwB+KlwD1sIwXFg9CPjSUeUeE
         wHbD/1HA5fZf1UBgDdMLKNue7B8UwVkUJUSwpRtNmUkRKVosvUV9dqONMgZbJyc7ywGC
         0oZpIDBxVRX1g1kXap2Mw7SPYzvAnFL4+A0ZWssbuiTdcGej65x5U6MTmeL3Q/8bLON8
         44mOw+hiNmfT6wVPnhtgNvDpC3ygS6Q7wEHg3AjkljdP6SQuc/PLR7qhvlzVCMiLrk8S
         QzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771085921; x=1771690721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4Pg7faVraxi6oaHzCJaQKTq7PIuXAtxlyfauuDqWFs=;
        b=TGbV6pDGVVTquyJuuURDGWmhZE2kNrPTiYOZrZOWC8jEazOo1PWRNuBwp/UpIjh2dX
         t+5aaVc6/9D0OztBTd6+9M28JwXOpdb91YwEn3pair2TK9XiH3F97QH5Z1affORQ19wa
         Ylqcc6JIZZxhK2F5q0zSw7sDEuE3mXY+d+xt2O1+4h2AdVyJ5APnJGXWq+kRBkbmYpJx
         z3naSa4pnXuCLUQbbvIZ7wh1gV0fZig71rlxb8u0C5KiPPV63S5gmqzd2I5ohcf8J/JE
         u7jGuR0yT6ue375EintP91Io1dScguxDKbIco4S+Px3KCVy5lB6Nidn7LuT/TuY9fE6D
         LDTQ==
X-Gm-Message-State: AOJu0YwST1ojv0sNFirLJZXhGilrxIuOVuCLSAGwivgYaR+mBKKtmL+T
	CWlFFr7VDnTfhmZf+L031U7ZYB0SoYMDMqOOt0b9S972AhYXdwlteKFHqNywHF5t57VwDLdOwXi
	KWqsGCEzXKb/Ikx8Y8HvMksjMIBLPUu+u7Fj0TjHSSw==
X-Gm-Gg: AZuq6aKiboORiJFXPIAZrx7ripPUpkRJHx/k2j/3vMtqSc+BKcMAZEQTsL/wNQnPVsF
	I9HInw/knxrdOVSOe3mGgfDHfC2pQQ5KrQTo+qUN6ee7wrfr58j5TJNrDpwiKYOsUEPdbTW7vf9
	s7zX3R/fmdc7C9cNfz6h8NudV+S6P0/9ofXMP9Y4y7WG5FPs4QV4Sx84z4aiqip4+X6shZ0IEEo
	BTgmeBFaDgm80nsVKxoccBbVSvOZ/9zyuyB3RyZ4J0k2eBZkbSYyEwL5nUGTNv9HdUvroenlhxN
	fvrlNVv01I4vJ9dkBX8SU9GKyjcPOVIJZSgf/4fc2veRihnQw9dbZkz4i3Vi47XUx/M1W+VObBP
	427V/ep0=
X-Received: by 2002:a05:620a:1a19:b0:8b2:df32:b900 with SMTP id
 af79cd13be357-8cb408303c9mr571211885a.4.1771085921471; Sat, 14 Feb 2026
 08:18:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213-upstream-20260219-v3-0-df9371d29f5c@gmail.com> <20260213-upstream-20260219-v3-1-df9371d29f5c@gmail.com>
In-Reply-To: <20260213-upstream-20260219-v3-1-df9371d29f5c@gmail.com>
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Sun, 15 Feb 2026 00:18:28 +0800
X-Gm-Features: AZwV_Qicd_vZzDv3dzszxT8e49aKxSIrqTBL_5tdswhD8TxsGjOHXyVR5TXm89o
Message-ID: <CA+NOmzJ3n37MKYb6S2ktpsQDv1L_zufDXuwckgiU=mTuGfdmzg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] iio: proximity: hx9023s: fix assignment order for __counted_by
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy, Krzysztof,

Thank you both for the review and for the valuable feedback on this series.
Regarding Patch 1, I have refined the commit message to accurately
describe the __counted_by requirement.
If there are no further concerns on this specific fix, may I have your
tags so I can include them in v4?

Thanks again for your time and guidance!

Best regards,
Yasin Lee


On Fri, Feb 13, 2026 at 11:22=E2=80=AFPM Yasin Lee <yasin.lee.x@gmail.com> =
wrote:
>
> Initialize fw_size before copying firmware data into the flexible
> array member to match the __counted_by() annotation. This fixes the
> incorrect assignment order that triggers runtime safety checks.
>
> Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsin=
g functionality")
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> ---
>  drivers/iio/proximity/hx9023s.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx90=
23s.c
> index 2918dfc0df54..ad839db6b326 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -1034,9 +1034,8 @@ static int hx9023s_send_cfg(const struct firmware *=
fw, struct hx9023s_data *data
>         if (!bin)
>                 return -ENOMEM;
>
> -       memcpy(bin->data, fw->data, fw->size);
> -
>         bin->fw_size =3D fw->size;
> +       memcpy(bin->data, fw->data, bin->fw_size);
>         bin->fw_ver =3D bin->data[FW_VER_OFFSET];
>         bin->reg_count =3D get_unaligned_le16(bin->data + FW_REG_CNT_OFFS=
ET);
>
>
> --
> 2.43.0
>
