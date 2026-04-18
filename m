Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6E330E827
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776532493; cv=pass; b=XrDAiKnKvHM8f9UEJcmQ4QvfXoIXcnf8VPH89Ym9RCQx84xRvgzGR25S8CGJasEvjWzWadHOOuoO1XA3PrA3Bsvwjq1JzcxHNk2ygIr0Juf51GvRGrjSXy/OZZf3Pks18Px+bUMZ+Qw6MQ+T7Ici3U9Y+izqVCcbRs+Gc3fFpjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776532493; c=relaxed/simple;
	bh=sV0zNh/sRR3qUcdeumqRVy/BQwK8Krmc5MR7xdnyuRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qK6Dkto12URG7XiEzUwSM7GSpqZlGTf+loQQeXPKWXaHp5nCHtc+R1F6d09nnyjJPxEKgbxtobkB9T/gTgzc5/y7mj+McFksMk/Ve1TBsMgwmPnpTLGjOSBAsC5NzLj1yuPADHmpg6wgQf8Gf7PKd2H8VxP2wqVoRfZVrQBttgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0xUWQ5k; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0xUWQ5k"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a3be187ffbso2641986e87.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 10:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776532490; cv=none;
        d=google.com; s=arc-20240605;
        b=NW+4Tj1kSEKA3XjzZyuPiD4hILlXZ8mJ8g3VNWBKsA5lkqkFjnzw4ZzIKg33rWEQLc
         gUjinTeGZQxjZXVv6gyZ9dOk+LavB8Ptqmod3Er8htZWxrgfmh1jaFvmx4sRysKZKvhf
         oGVJ+kCnHoXnklid5v65gVJZTwWssAvv4K6e+KQ7U1hPPhDiMUSBex+9QuSkXEaf06yx
         j/ImO188WmRiX6lzPgihOlu8gzWjUgVXlGH8zieMLoHSKkhIoh5RF0if52/mfEZ52gX7
         8ABSwENS3UNXTI6M8zVsbFK3tmZo4vM/vTon3/l7NuNLGwlLL9Hyt1DaTGpYp8l997ze
         dBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PuZMhlpckJoKVLIuFK48UQUUnmgpJ0RcJudBMWzHgRI=;
        fh=X4Tk8nG74/PqfJW2/2CgAuJmeo2W6rlhGPNgdv08xdk=;
        b=S4z33QJSZ6kI1yJoAuYa0QXkie5UPCVTP/tiDW3Wr/frjUtlrfoIKedo9V9XPkFaXo
         B7nCcef8fT2774M0oITUQ5QR+4D2hb13rrroXuavmwHDh0EKU+QpxrbgjTfCOfKnFUbJ
         AIu/vz+iosr4DbWJwt/AkJDyn4MAoMgyVy1FolGdOjiQzJ71t3/CUkZyzCKUG6kLuNB4
         zyXtGwMcZySlhr2Mhgr3dxZf5o8wQTuYsl2npis1qv7KsLjkQqARYPxs08CVtyUrRAqN
         /bsYD8Xqjx29EbgWsR3snmwYYoCA7RynWWeeNOrDk/9nhc+uXsXjvUZDJrnYNHaty6GK
         BzsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776532490; x=1777137290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuZMhlpckJoKVLIuFK48UQUUnmgpJ0RcJudBMWzHgRI=;
        b=r0xUWQ5ksmDutA3A5mijju8ZzKFY0J/fOoBoY29KUX9Ryn7U5NVoApLocXt0I2jDtj
         A6OKeHlyMnymsGogyaQcepmUHLaK879YHav5bzeU0y82Ro+dn0OSw0xU/ktfLHhTo9pn
         HlvuVoAAJoOddQO5HcapAatgDpQRSXbYGVTLAMvFzayiAk5OVSydXCaWQZz0GSfGFLRS
         yTENgBgq61LoKgqFS6UKp4JIr9yjpZn/8X3BP8HYZbjYn07cubjlg5qRQzED99QQsITA
         jaIN5Z2JT8j6ubWQiDpxkSI5pufNvyTaJtW8wnk1RpZoa8p+Mv6l6fWcP4TzPD2hgSEX
         NwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776532490; x=1777137290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PuZMhlpckJoKVLIuFK48UQUUnmgpJ0RcJudBMWzHgRI=;
        b=ow5VKJpyKYHno47XXx301MWWLXTNAsaPRWlKKEiN3hdbaT5/hnbkBACuaI1kIfO9yo
         kRSEdOK24mIvxktKu4COTDjeY4u2ztlmT5tB+eVDqG+gLs/Fgv3nBkbZgvM8K/3To5Db
         NTjoQzJtv1DZnF88aIy6LKDNc3JW9/YwzsBMsRRcaJLa28nZcjUcGHP8yM6/+lsgIsp0
         mMpgrh1y9wfU2jqQ4VC71ibQ88oG0e1ukBR4r1duDBo5JHdIiTL3QoqKUjo29aiPmPMK
         42BqlEn/xs9X9HLSwNBGbRDpvxIwGATMg5nq+lhPdZw8zkMbMelp7S1cfrfHYHfNguiF
         qVnA==
X-Gm-Message-State: AOJu0YwdPaPSF1iP0DvBo9UE6Z1mrCrIvAWKLiWn3ZHUuI0d+GxRCHjU
	WfD89A5sofgp1sBz4Iw/CF5tzgD1Jx4mBs65RR1lqKYkm5ziNjzjQZpjvKRoM9fLP0110gT0AkD
	G95DWVzlMs4TDAlnsW62zdtCW6ZbwDXg=
X-Gm-Gg: AeBDietOVTB5H/r9NPUAvb5IZF19S9A4sTn2PxTDcZjes3WWc7+rJFTtXFDYPBwsXna
	uR1nT9MmVkngVHsFJaSXH7jGH6y/PSbLWNWK23H8hZlkUP6aIv0vXrgsSN/+2OPoTgSOQOvsleI
	30cvuwKQMIV/+pI+RjAWP5D0Pmr2mOMQWe/QYbfAJ1s63aXe8+752Fz1gNYalDjRJC2H16SWoXi
	HfMCCos3OczhGWgEU4vsCrMwmRButYWfNeOzD927H+i2blXQ9XCtTdCMXunjwEy0LUrgLXS/xDF
	MsCBaSlBvirEpv29JWFPHn39/jRwb3PAifTM+ZDvB9P3MOn7AviOVkSlSQCpzL3AlflopgiYn8l
	7Fou3
X-Received: by 2002:a05:6512:3e20:b0:5a2:c962:59f1 with SMTP id
 2adb3069b0e04-5a4172a3042mr1890849e87.16.1776532489400; Sat, 18 Apr 2026
 10:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418170519.312360-1-piyushpatle228@gmail.com>
In-Reply-To: <20260418170519.312360-1-piyushpatle228@gmail.com>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Sat, 18 Apr 2026 22:44:12 +0530
X-Gm-Features: AQROBzBBCbg4dCGQ8KU0ltOkiVUm7YvY31quP6XQxNirjtuyywhboqwz25V-rbI
Message-ID: <CAMB+xkYGHctzwy-nezULY38yvmnmh-ygWgOATmtCXj0nFbPRmA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] iio: adc: hx711: add HX710B support
To: jic23@kernel.org, ak@it-klinger.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 10:35=E2=80=AFPM Piyush Patle <piyushpatle228@gmail=
.com> wrote:
>
> Add support for the HX710B ADC, a variant of the HX711 with the same
> GPIO interface but a different channel and gain model.
>
> The first patch updates the devicetree binding to add the
> `avia,hx710b` compatible and document the variant-specific behavior.
> The second patch extends the driver with per-chip configuration, HX710B
> channel selection through trailing pulse counts, and fixed-scale
> handling for the variant.
>
> Tested on PocketBeagle2 with an HX710B breakout module. The device
> probed successfully and raw readings were stable.
>
> Piyush Patle (2):
>   dt-bindings: iio: adc: avia-hx711: add avia,hx710b compatible
>   iio: adc: hx711: add support for HX710B
>
>  .../bindings/iio/adc/avia-hx711.yaml          |  36 ++-
>  drivers/iio/adc/Kconfig                       |   9 +-
>  drivers/iio/adc/hx711.c                       | 222 ++++++++++++++----
>  3 files changed, 214 insertions(+), 53 deletions(-)
>
> --
> 2.43.0

The two patches in this series were sent without proper In-Reply-To
threading by mistake.

Patch 1/2:
[PATCH v1 1/2] dt-bindings: iio: adc: avia-hx711: add avia,hx710b compatibl=
e

Patch 2/2:
[PATCH v1 2/2] iio: adc: hx711: add support for HX710B

Apologies!
