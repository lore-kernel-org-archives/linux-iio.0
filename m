Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E73D4135
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066913; cv=pass; b=hieuhNCv0bffI7NsSPdvPbreSODUlzuiOlnJdLOnAQisITLFUxStz1Lhq3PnCkKCvqkEQ+txm8yFa6r1O9QJ0dtYxNhQkTIxwOvR249juKsFa97nxU88dx19Sage6h0A8yWaxitsYEoMQTHUQMYTU0OT2AUYDAX7UeBvOBUziHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066913; c=relaxed/simple;
	bh=kCCaZBLqWEqxQ+c215zpXcZhGoJOLUlvX6y63A/PVe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3RmR2PI8bmm9C02fwUU48sEWWfRKZa1SDYy90L+ayfT43GAxvv8FZ5WO7iTdseQqT+t9cWFlvPf9tF2mqXeQV6FiVULqClXXKQit4oR5bVX5oVFVtlo3/tSB2oeZNVAUY8tzCLjLF5flrxLMDeyiNlo+xUNEz70izE+lleMH5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAvz/Nos; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAvz/Nos"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-660ea8bcb96so8330311a12.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 07:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773066909; cv=none;
        d=google.com; s=arc-20240605;
        b=lh+l3eITgzzh6mkPKvisgLhFF9Ft0UDPahxqBwhpUJ5G+P2klmb2SA9luMAOTz6bLu
         n/Kj/cRGKwhY+wz65bGl4gVxyrRHM7yGmfXEWSTnVxnnbWhi3w/aNUQA0W/W3p1SAXkl
         qkivMSkog5572oGsWsRfC27Lfb0/4opE4qcExoFU6/QaqHHlk04hZ+DMjUDfAD1AF9N4
         yu4u5XpWjxPXcJ2q5+kO6O5/OoWXS2LXCKmqHpqnNMFuWCVQmYccCEeDCMvTxNWbYdVr
         JGEYrGf+jRmz9I6W1ftkwMwtXSx/GEkHA5xDNIL4/q3w+PnZJCBtKWnKo7Ae4rvkqOyN
         1qcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8iWESBVoXzlMM18RcpcDPAS+3eCir6TBR1mLTZw1N3A=;
        fh=F4RLnT2P7yRLQSnulva2p0pOkeCocks0PSlXQVz4qXY=;
        b=kQFzgaCL2dHU1mOW0SW+FfixY+Nz3YQhDlf1YwCGs92diqDOnAia+GFEeVqLvk8X1t
         qgAwEByK19euv2lDxyTJI78vGAaCskMw0VgHNCaDjBhidbtLtQTYkoGP4uwDZ9NCUPPG
         LEMIIuj8/OJlLCyu3i3wz4ZF2GEOVZwbFQhZZbFwSHurNq7Jw4i2oA7gWnFVKq7nZpbZ
         oiqEozkoonAziyMkP0zprY/w96F90mxvW1/vsWYqTmiqdqtLf6ssYRu9ClFdCf37+B8b
         7PT3cxm5m0D2mGnREKrs/1X9Jn1uEyGe7iVa3THuGNMxd1Jg9h8p7UVjLRUNZ0IqVetP
         tfFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066909; x=1773671709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iWESBVoXzlMM18RcpcDPAS+3eCir6TBR1mLTZw1N3A=;
        b=JAvz/Nosfp3JZof8Qbw8xcjh359fC8lNPxX7GIPyJ9JzrNh/c4BZdX5m9lnmPbKSMY
         I8Jn62CLVeXhTqmApaJXKuXs0o2g8zixA0LQBroxvnk/xcfFCfDZjig8n37lbSBUkGpj
         Ja4wSjKtUYK4vSbgF/WxLRU3qUOemesiAeSLy1/arSo9vUoVNPf58uAVHAQPhbLcyJYw
         r005goTU3rKmS+hv6Jm2WzmqdZn99H1+Nb2+cujq5ntsrwXsb6ihVfb1224emP1x6i2h
         N9OPk4S6gbbEaS1F/4YW4/Ho8E7MPzVDXqL7qF/pPLxgyUlPZqb4WNfIDg9MiCbUNZ6T
         VbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066909; x=1773671709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8iWESBVoXzlMM18RcpcDPAS+3eCir6TBR1mLTZw1N3A=;
        b=xScIDkCzW6j1E9y5ywGlvxbIOtyVh0wcPZOVo815fZk2rJictSeFeMMUFtwIVjF71C
         WTOQe66zKr+G9kfPrBW6JYAPdKLKabIC51VQK4HDSA4SahEIllNIMoyXzyd3QxaPjdpI
         KP5yehbEePK2VVmcl1edtK6/dph1zXjixWNrnD954e36iePYZOFQvLYWNw+ou4qrEDG2
         4HY72cOSRoONR/6yBFi4WM6wGeP5O0Ho8Yed/uWRMwNCyOMpJn88RoV58Ss9v/FAbsNS
         lsADEE7QfjcAy1XaThLjhhmDtUF05J+y/BS4cWr4Ks1FKt0UbEu7+GaNF1/p37Lyq5/u
         S1SA==
X-Gm-Message-State: AOJu0Yx2eWGDOZm/rIMpDdw8Td/vsP9XDHVl7AtdiUFTLOF/HyJ0lTsV
	I7/uXbJ6dXzmHgQUz3weH6cRxbFYcqu72haotU7WZRsT6ac8bDze31VCpDue0k6UgBMh2EV4IJB
	95tyttX+YYdMa2hxpO3F8v1oRQaJsneY=
X-Gm-Gg: ATEYQzxmB9+dpqq5n8qdiLm5mvSa7a9MSgl/gjTGaFYw3GFfIS04l2ML5bScP4hEzAS
	Rig1N23fiLxX10oxibuH6+rycvY4EPub7RsiLcKdVJeyh9TciwnMWhn6UZ7Ot/m1VTn1fLYC2V8
	JImHCVInTtilLEAzxv2s/G1Wj8TP+Os/JIWOxPsXfI8W3yyAMnAi7gD8a0fK7uix4dQjF/wAdct
	lKESojqjjnF6qpf8CiQ8KPwRT4n1VFwdYmy73efdZd2BOotMDK173pI+UOIxIC2e+qGPqMyMDuE
	LlvZodwFg9MiwK0jJRhGQuXZCZDw5H29jUCE5eamgqjfhhQVLp/KSe2Cg/hz4+rZMCIfYWxgEVI
	cOmSUkPjcoZpWa5MxhH2h8B4jyLU=
X-Received: by 2002:a05:6402:1469:b0:659:36de:6d20 with SMTP id
 4fb4d7f45d1cf-6619d4a6127mr6696036a12.14.1773066908545; Mon, 09 Mar 2026
 07:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309142352.57407-1-rajveer.chaudhari.linux@gmail.com> <20260309142352.57407-2-rajveer.chaudhari.linux@gmail.com>
In-Reply-To: <20260309142352.57407-2-rajveer.chaudhari.linux@gmail.com>
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Date: Mon, 9 Mar 2026 20:04:57 +0530
X-Gm-Features: AaiRm52vWChRUgxt5jVXDmYGLP-xIrE9FhmZB9R-_kxmujT28aAovyQDPkO0u7Y
Message-ID: <CANS1UbhYkVCWZf-WK65EWZ6Xz69H5dJ12=jCs-LQe13GpMBhPw@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: accel: bmc150: convert to guard(mutex)
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, waqar.hameed@axis.com, linusw@kernel.org, 
	sakari.ailus@linux.intel.com, harshit.m.mogalapalli@oracle.com, 
	antoniu.miclaus@analog.com, andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 7:54=E2=80=AFPM Rajveer Chaudhari
<rajveer.chaudhari.linux@gmail.com> wrote:

> @@ -1485,7 +1488,7 @@ static int bmc150_accel_buffer_postenable(struct ii=
o_dev *indio_dev)
>         if (iio_device_get_current_mode(indio_dev) =3D=3D INDIO_BUFFER_TR=
IGGERED)
>                 return 0;
>
> -       mutex_lock(&data->mutex);
> +       guard(mutex)(&data->mutex);
>
>         if (!data->watermark)
>                 goto out;

I am sorry I accidentally forgot to clean up goto and mutex_unlock in
bmc150_accel_buffer_postenable().
I will fix it in V2.

Thankyou,
Rajveer
