Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574762BE03B
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838925; cv=pass; b=KBItwaaG9soTmtaBCk8h+ng4k9WZ/IMzIgQgkdQfX/pQ9RTDT4aKOc7u4jk6YUZx5fnXnGAzWizZfMy2ViJqkiaf7B0V72nooayqzH7QrJOtC7AfouXIbDG/uRJ2M2mpH6rV2/WrfjjjSV08Q1zVN2AN8uo+hgi7cYMsH5K2g80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838925; c=relaxed/simple;
	bh=u7rHJs9jICEwL0rR8cg3yrWmOb4tQOeogxpk6eKkbX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfIIdFmGsPZCpyQhoUbPcN67j4hOUoSHdBpzG9W7xnZqefF+tZkCB8f5VpEWPSH6UfWonoj7UdEglhVC0K9Aji+tVj7vUUBIL4n+0xcDY1VzLfAyz5CX3RCZjSfFV3vc65xaSaVHA9wOGywGVjtsn4yr0yvuDVq+SmN9z4YQGsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJlu2lqW; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJlu2lqW"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c88973b6965so457966a12.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 10:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782838923; cv=none;
        d=google.com; s=arc-20260327;
        b=XOq8zeWuXPWT4WsNnOVSmZrghcQh4p5eCAJqRgssXTBVuCiaV2QDEJMteSrKURERsI
         K/kK95o+L9Bd30H438SUdkDxJhbonnkAqyWKY0/9UCPDL7hcVpEH0fbxfdtHlF1veHpz
         axyCLZheLf0U38zgqgrT74euI93zyF4n+xnBv/HrhixqXB2SQ+yTDod/ycCvd+9MIxnh
         PHh6V6pP7xn3Y+Cm8W0sMza2bXxAJ8S3L2+H2XsDIilr7dYxaGUoT1HrAuDoRevnh9CF
         LTmajOEl0jjugLnMWA9EFowO0cUJhWtZxdYNQ2jBPsdP6rulkUGBCb+EA3SWwQbWkzPM
         z6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u7rHJs9jICEwL0rR8cg3yrWmOb4tQOeogxpk6eKkbX4=;
        fh=tpjcNlJ0YN1QCpwcic9AP5kkqFI+cQVO7G2k82ia3Gc=;
        b=dtdmxJmE2bVX/kqxlS4OUmqH90W2W42cJZLIRVBAv9J57Fjh84lO4dK2Hu/PI2kcHO
         CYzXxBy3CEfXXN0amuFXXolWpI6Xg0zjwjuYWNT8p7SwcGjpW3kPiOOeqK/j7U7F/Sou
         6B100Iywem6P0Fs4h56FYNQ+NOiRiJOJI4KZtO7wJzqEoHwoitjs/N2Sqk0QdAsEUOZN
         yimPTApAeTr5s56DuKULRXu8+5ot8rzUj2h7k6nwdih6quAFlT3/WsZAEvO2XNiColeX
         DDOLcAycOLVxgelV7hLnuqwm9xqUdnYxQn5xQETbOPQOvRs/eUWy6iSVv0pguNCeZ7b/
         8oQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782838923; x=1783443723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7rHJs9jICEwL0rR8cg3yrWmOb4tQOeogxpk6eKkbX4=;
        b=sJlu2lqWliD2z5vyLfVuatTv0PiEUP3GyDgnd25UYxRaELNn32tyiH613zrvHBKky/
         y0+nClePzMGKK21o5Jjd0dUCsvvYztlV4p5Ayt7TrwemaLJHl0IEbnfOLcMT3lU76kQm
         Nff9vhDjnlgwzZZfmfAEM7EzNwL+gayyW+jAfy58/G/2ErPSzMsIT2CTe0gCGurUB4rT
         S+BTyBO4VsmfWbs5IeER5A6FPDOjmJtEUMj+8mb9purXp8GhFFvEjXl3t9uxpPviC2u2
         a5E8riX88pCoXt2v4+5wGeebnxwrZNUHFSrfur+X5CvZ6e8Yef9bn6HLOKzlgydvRZ5T
         21Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782838923; x=1783443723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u7rHJs9jICEwL0rR8cg3yrWmOb4tQOeogxpk6eKkbX4=;
        b=knP/AC568KVZTDlFlJy7NSMUbpn8h9Ez9Jefagu5DQX8jfJjkyUNJL/0m5CRbnCGzw
         lLRQ2eEkzItoc0y8bBMtMthQLtmb+00xchu7UjhrAZyt55Y9GqyT1JQskCXU+gjxLTzl
         HcYMhWC+34QLttmwum6WTQgEcitNlVgDOASc9SmiFUT42rfuKd3jn1jVuYDzxIS2wzzT
         EcPl597S7ngE96wQlCYlPIKhEk1pOhCqmp2vsrc7FzwUx6CF71eYLzMZ4lq/1DVpPc1w
         KX0IdwC1KRJzcKlmniY66/agiW6UKoDvnGhlpACF1cwSR3dCOueKXuiQJ6ARV5KFo/OL
         nYcw==
X-Forwarded-Encrypted: i=1; AFNElJ8+T10duGWk8Y/CP/LAQINYxS0LtscMfWIjaI0M6MfOAZROE1zov/Zi6F9fke37m8w0rmyuaq05vfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQjA50cmk9GMuzJ9owm7hVsoz04kn8bil2MPoVx+QA4CZ6IK9
	ZRRjD/ZpgC+Px8ThdppBCNfknDzd0XFBCRKTMzdnZgWvFiuWna/1aoBRD4NthSR+kKAn+oUjg2T
	bpsBR7wkTpxZnoYU/Otpbx8byNPlD8KM=
X-Gm-Gg: AfdE7cncLTe4JKOBvw/rqieE9fcmNIDUXw2L43vn3cEqQM89CzI6VMtPVT71XObv+8i
	NRroJo+pElFtkk58gEWIRnqdLX8jFnwXuoCEmXF1VAosI/lN0BP1ZWzItRzkRDsnNB0ZnjUW4mT
	iNX7is4EChWkUhXz8oH1Ne1nbryFU+0zcR/Le5NMC4xE+/l6S3YrWGiaMFAgLX9JzEIQSU7xds9
	m/Jq/uD1ltSeY+j6DgHZERaAhV3UsgJ2VAymimiXyy7hdAktorPFKqmza3jG+YI5t177iiVSyoa
	XZmBeXuDiOwS7fvqHoG2Ce1DWXcEt5hw5qrUGXwFSA==
X-Received: by 2002:a05:6a21:1bc6:b0:3bf:9bd9:cf54 with SMTP id
 adf61e73a8af0-3bfd2637dc8mr2029537637.8.1782838923351; Tue, 30 Jun 2026
 10:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
 <20260622221550.374235-2-jakubszczudlo40@gmail.com> <ajpO9zaZbIl3x1uC@ashevche-desk.local>
 <20260629235118.1abc4067@jic23-huawei> <akOqIVDibovrbBAK@ashevche-desk.local>
 <e966a0dd-d8ef-4009-b609-546a48bd16f4@gmail.com> <akO2XF2dejbao6Zn@ashevche-desk.local>
In-Reply-To: <akO2XF2dejbao6Zn@ashevche-desk.local>
From: =?UTF-8?Q?Jakub_Szczud=C5=82o?= <jakubszczudlo40@gmail.com>
Date: Tue, 30 Jun 2026 19:01:52 +0200
X-Gm-Features: AVVi8CdVri3EHATATvfuvom6TGocFdcDcnlRg5z8nfjRm7v4mPHz7kxTZkawjRA
Message-ID: <CA+gq5JiQV3n_t1OA6++_ZVqJdsCZmg-mnz2sHVpFsCZyp=QVgQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	linux-iio@vger.kernel.org, andy@kernel.org, antoniu.miclaus@analog.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com, 
	duje@dujemihanovic.xyz, jishnu.prakash@oss.qualcomm.com, 
	jorge.marques@analog.com, joshua.crofts1@gmail.com, krzk+dt@kernel.org, 
	linusw@kernel.org, linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com, 
	mike.looijmans@topic.nl, nuno.sa@analog.com, robh@kernel.org, 
	sakari.ailus@linux.intel.com, wens@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Tue, Jun 30, 2026 at 03:08:42PM +0300, Matti Vaittinen wrote:
> > On 30/06/2026 14:36, Andy Shevchenko wrote:
>
> Thanks, Matti!
>
> > Just my random 5 (or so) cents.
>
> 5 because Finland doesn't have 1 or 2-cent coins :-)
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
Thanks for all reviews, I will include them in v6 version

Best regards,
Jakub Szczud=C5=82o
