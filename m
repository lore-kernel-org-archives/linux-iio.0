Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906272D877F
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831624; cv=pass; b=HxiQqRQ8RYUQsKu5ES1ryMAN7ItVaPdq8BDConGQdY9yfcMFkbNwxe5nQMgqJ7FTZJw+WypAex5nOFm4rMWGOGNlc8NCQKNfgx0Ckalbr3I/9Igytf7mPDGkdiiENfiw7lVXiihjspWD/xXoUzxQ/v1tBlEeQqjFvvMcs48AJ0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831624; c=relaxed/simple;
	bh=BWNI0hZvp/VRBNPjw5AopDA4sYjEJoDqJ/GX80O7ewU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxCd+zq3RKG1P7P768LAWKZqlehDEc9eEZv0UcV3kz0VPVUQ3Km6GC0V6YruVfomToo/JyN9pKEjDdF3+/c6pqwOB91idN4rGt8l7wH68YhTBDBm6K51MMxYutEcrMLXdtIBIx0+L6LDlA7+KXJ5V67W2fX/qwK/sTTCZAedaeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ob502tlQ; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob502tlQ"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so1008556166b.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 09:40:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770831622; cv=none;
        d=google.com; s=arc-20240605;
        b=esCSd6xCR1MLp3y/VXZ5x5qYRw4WEYhtyVmT9upx7GDZJrAlDV/ZHGmAhCjc2CUI/Z
         WVrKp1JNs+Z/jYDSbBR12YAFgK2xDWbCx3rq1Hrv+rhYfEakG1UQTRh+afBHHx9jPCAw
         rdRslFqKPsic+X+qrSKWe9H3ns9GlQyRHqvQXCdWXbi8BHqEnjy/3XzWQ4w3OMBDAsGl
         OYcH1RU00e+yISNWomcw/ELalc+pXZHR9loAsAJzkOuGEtzZ+rQIKB3A4nnGiE/bYhMz
         6AejDjz8JtTN8UyX/EOxfABo3eTT4RD+C+2x+6ILdR5DPYlu/a1s4joC+qMz66TIGJuX
         kw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mdplMvL3Rzn9rekdBbnDcSe8q3Cnr79dmlPpyuyx7Fw=;
        fh=HCVHWR/JqXkJB3X3vGX1/Y9sElvhJoCm3okYKP+h/mY=;
        b=ZyzSYfmpF/oSkLxKY+IjesHy6FfoT6LcKJTSNKJyi5Q10fIfOwaWAAvBHMv6g0K/ZN
         rNNh44E7D7lzqsx0En0GyS5bI8V+gZwieOqRNf3IgJS/LrueUEGo066rTVQh8U9mhofo
         u4FVwQF3LDwd35AA7TPls6s2B5cgFxR4zOBeUBQ9GNMFjSpnaNVBfPwIsCBu4Tl70CRJ
         1xBRROg+SFIyLHYHR2yGS3oFZgU8ETKnkd+ywlf4IhaXXdJGaST+UuJAYEW/vmxP7yb9
         dnr+RYVvw7iuLIpuQRsj7ZY11ehRGYUh1Okqj5m6m7fpQbHWKC9p7SvObRXmkmqfrmW+
         eZuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770831622; x=1771436422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdplMvL3Rzn9rekdBbnDcSe8q3Cnr79dmlPpyuyx7Fw=;
        b=Ob502tlQDGcFu+G5/b9Em+grKG4nt5QqA8MSlk2YUxBaeCi0vK1OCN637T/fg3GAq2
         zQ7dLYR0j/mtsq/x1jBFVI3+urzxwdx7yk33WoA7rJTHaSDOakVJWw6AFKioihMwsMcf
         uf6ftnaIqfEA9hu4cNWf1gyio7YQSO7SyRN9B1dMsOtdqTYXzx18vhTNztbqr04GqxC6
         LoALy0lAWa0j0cBoOXNrd2h/J4y6jHHjzXCAaCJBSEixAno7Vyn4jysh3s7f0lDiYFkH
         I5MWUF6hNtvm1B17pywbZQuJ60OaId6ERpalLfQ+/AhD/36HF64k2iRT/dKCRu4305ik
         UgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770831622; x=1771436422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mdplMvL3Rzn9rekdBbnDcSe8q3Cnr79dmlPpyuyx7Fw=;
        b=Wq1wgQN/KHn/3AFmbOkB098TQmww0u7vjW9GA/fpTsmbq7iQPPEMjy8O5A65CqP1jD
         FfaTxVdTnMXxod+B5CAkpKELRwdk/4sbrgMdZSloMDEe1JecQIjywOq3Zudyq5ZI1isd
         oVMTkIi80ApIO6cw6evfkxVYy68/F4gHW6dq6cW9fyiZAZAKQpzm56gK7t6PrPiyatAR
         3h3ybliNUSmeMImZyShy3ioZZSfWd/GejFfefmPQ+gOkQe8k4HQC7T09do3TlJnqpiq+
         jtiWudhlP+Iaoewd3EBmu6jVmqUnGHwWkxaiiK/JGqY/nLGhkXZkf7OVBfEU3qe/gTuL
         hdnw==
X-Forwarded-Encrypted: i=1; AJvYcCVbwaUvd0ZbyX3r2J9C5WRTsCGch6gJtnPMvZWfFn3XjHsHZsL4Gu1gM7w8M1QanNiqQUxD9P79Hks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNBo/tsOEujuYO9kzJ+O3Y2eAHU5nYaYlQ7XfLAT92duCjdCn9
	J3tlk+OucAsED7CqTz4rekzw/44JHArGYQE3i06VMiHS7kqgM0tEnXNDqKDD8Jfk6VvqtN6SnUH
	WUGNcT/YcM2kVBfxgOe69mYkMXyFdccM=
X-Gm-Gg: AZuq6aIPs++REidsSRFRjNKD8z2HMbFf6lE7Jw7yDgVchoMg0t7xthr6Zg6fQdAHAMw
	6fdo8DR5QHHQ1P7QVnjb+qf8Jt7kXihOosL6j+ZXUsEKQ+GD7bf2FZi7g5e7Eu+RBsTfJZRXMRZ
	xfmyjy7Wh6d3/OWqXNYabw+5Qk4oyJBX5JKe5D7IUQOMu+lWZ5mJ53u1oWeURY9aiPmno4Uhdot
	VM5FI98MjiDHeYQl4q2e1eQi4s7AKtgc7GBUiE7M8JkTh2A7r7gZ41eZpMDd9gnwG4Gsb/G+plP
	b3tcBrP+bqosLue+mt9IUZR/D+BJfmeFzLR+DM/e5Jer8KKBBV9jEwDDPctyyG0EWP1z5dJeaaT
	G5uiuXCc=
X-Received: by 2002:a17:907:c06:b0:b87:3168:2cb9 with SMTP id
 a640c23a62f3a-b8f6ab089e8mr215952766b.32.1770831621693; Wed, 11 Feb 2026
 09:40:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211171007.143527-2-antoniu.miclaus@analog.com>
In-Reply-To: <20260211171007.143527-2-antoniu.miclaus@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 11 Feb 2026 19:39:43 +0200
X-Gm-Features: AZwV_QgYLy6f8eEVN5tRIBe4PqIgoSX1gaf-1JyUxY8IvmQqyCVIgChjkSEx-ZE
Message-ID: <CAHp75Vdy=0+RF=4OSa-p_kkAkqqBZHOUv=nZ7sF3PjajfTr6mA@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: adf4350: Return -ENOMEM on memory
 allocation failure
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marius Cristea <marius.cristea@microchip.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 7:10=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> adf4350_parse_dt() returns NULL only when devm_kzalloc() fails. The
> caller should return -ENOMEM in this case, not -EINVAL.

Right, and the memory allocator dumps enough info if it happens.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

>                 pdata =3D dev_get_platdata(&spi->dev);

Side note: Have you considered killing legacy platform data?

--=20
With Best Regards,
Andy Shevchenko
