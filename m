Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793348682;
	b=UGSEINwVLCKX4JV58i0V26xpabuwcnGaypjXfkxZZb77ZOYUu538IrZGAR7jr4srHjgd
	 kouUbbyIXtnoG0MEqFuaAh3u6sWuJoH/qKG79xQGn+8N3X8GmgZtu/PKvwg6+xnOT8ir4
	 cG3SNXC5pmxtPctf9sbNG5DH+hwAprY8IUkV1cyHvt0ra9Jj6Ol7oy1TBf93EkR8stvoE
	 Sk9cc17wT7Q/AkXFxVkUfGKOt++q6zh5TmGEBtG5PKJfy+I6J1rGCV3Ykp1Tortmv7uJT
	 tre2GmdwkFJ+aP2CEIy1UAJhr+N2jjmzS7xAHGecgGmBgw63FEoJMkWpBmcfsiUcvKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HZ7Z0KiGCVqwhkRcIn3IW5zwbm6q5Duw70TB57NZTJw=;
	b=k/RM0J8s84I1BtISzVKc06LDAR1+i9LngVK984KTadONHF2Z8dxi+PAfDip6HoSafuih
	 YA44XGhA5I+aPWQkUa18kA+Rqovg1bfQ/tI7t+jy+4faxn6PSWcbPqJNOu+P5ayzHAg3B
	 TJ+rdICYawnP5Gr+0MPJgws94mClhimc6pCSKlQZTvPDtUxtovxyYykRAORuwVK1zTPEQ
	 RcBT2McM1jrxCGyJ/dy0grMkMSAxKGBEbdWlJSfOVEM4yI5A7SGJNS1NPSjyM/88HESE7
	 l7F1W44Bxd3ey34w3nBIwel4VKz/aOCdp6O7Fq2yXTKmd6DdpaTLni3GF9gz7WP+Uxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="nW/rLNw2";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6BB606A31D
	for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2026 08:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB6BB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nW/rLNw2
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so2227915e9.0
        for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2026 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793348680; x=1793953480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HZ7Z0KiGCVqwhkRcIn3IW5zwbm6q5Duw70TB57NZTJw=;
        b=nW/rLNw2xW9CGeIYsXOdFobHl3jgIgIj8zXSP+lRilpK8cbfWld3zglmwMUuK5rUR5
         nwO9xA75DHO1QeKSksn2Hm5jQZyhnOP/OCo6x2wz0vXPiGgTnyLhgVVrSy2rCbJ2WUvj
         1/1WCz2NEvlTVnGcxt/kuElmpBmqiS2gU6aJtqEhVwFdJdQLgkVHLRKvWJ3thqdEhxN0
         2ZZPNBPtlljRamZbjjf8hMW4oN2IbSX5aUriXxA85BKWy0AU0vrIHLl4W43fYrEhGh5/
         aJ0QUaU3Bf6IJ/nN46ZnH20QVOrun/68kRuuFucyNVC3935Qfu1EuCDDJocXcC1UEzwm
         Bfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793348680; x=1793953480;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZ7Z0KiGCVqwhkRcIn3IW5zwbm6q5Duw70TB57NZTJw=;
        b=IuIiIkIju5N8+60Gr0O2hTaM4wu5Xb6pFlFGHDL0Hy0i3PqRdtFOvUXJAbiOJp7VBb
         C/F28FP/67x1Vb3/kZ4uHLwISMsmttneqWPE3znVTsWPM3sxIFHHh4752s5HUUNB/0tV
         qUO3/oFlJ1zIMXjkKha7fiZHEuL2LzdIEMMmL/CVVfmS4qjudXqg8NQYGENU6cRN7Xd0
         RbL4bk6mPnBuCdsTlAGj8r9BO+oNw4n+G0SIrcJiuvcWa7uRGxMNaxEGHqmi+O3vSu0t
         DyAs54cJJXAFBChSOhQrLk/Y86o33I2ewFLQtdOimnry07fEgqbVQhViOCkwPABq6oKO
         RXaQ==
X-Forwarded-Encrypted: i=1; AKwUvBySsOiXrwDHOEDNlBD2THQhrXSv3MvvOT4qz4Ksy9BmZn0K8gjg78Rz0JSttyzHw/7kPmDHQnY6bAw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvU5nP2t9LNcZdYAGgr/cxD+FwMYmvb0eGs3TOBDp6qSXd+y8i
	s7am6tzZ5rwh53sHd0kqkQ+8dkVyNT2WgJbJRRI6c2AUiOQQ3EJ19The
X-Gm-Gg: AYBFou1jBUOK5hY1V6wHO9LNX2GdYsVRawjERVzabxGDk27vnj6DB/oNObkzRZSPp6N
	kZzQsT2X1n0lSJL+qMXg2T3KJbKpyUXwfhU/LwkbSQl2FFTzGyYvYmUCbDPIcsxUWRCmDyHARYy
	klmwfhqIK8GOJ8n1U54KiU5GbIPGSRS1FgXDMOmqiMc33dw5S4bQV4y/UpAcQ+HaqwfdhZ2YhSL
	28rbtnH0UKrChlixLTSV6TsEpvQO8EARhF/tf5yjl+mD4OYjTmEWOgjF5+mFBU6sCZMT/Ionu4c
	5n2TKJyStd+2RgQiMUiLKFEon98a0L/alyH7wigwt5I0Oc67ITrDx5I73YPiBHNJgTM7ciGSzAV
	nIcNmoG8BKyJIqvIpw/eRuRXFzCCZ0SKzrAK7zdn3Er0jiCVB3Pkjn+j9uqCMKePBC76nGbFN9v
	S9ZexZXQfOMdEuqSjZ0eV3C5g6NGNdW8Odoh/jDZIOfIO4nUvF31oC9EEGbSs8+VKYER8ZFU6nO
	xS6NZhqyJ4MDUZrfekoalR/FaOlMjmeL7kFn/jfJBznZMo/Gruoeh42sjXiuAfoOP0wO1imioV5
	Onto+418GHEtyr7eO/+Bxy6ceICa9nAKUuoWQOFTH9ry3hlQ7qeuS2mqpDSKMHQVAP8QmqtuUGW
	7tpffbxTcZZ4B0RjMyQXBQs1ateMbGYQS9FMIeTY7SDnJLeYlXgBDxtaitTrrW9X+Bl/FFA5l/q
	et0zIu+kMCA4yLTFK46rWPQsQXIcAcPxcB86qvChDNfgDGaFAD66aiDibwyaHciDskrEXorEDsb
	JY61q1RMplnNrWZ4YhGwbhDnbcRSlq5BEkWN7EH
X-Received: by 2002:a05:600c:46d1:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4ac187a72f4mr30429825e9.22.1793348680262;
        Fri, 30 Oct 2026 01:24:40 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04785sm122659835e9.4.2026.10.30.01.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:24:40 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:24:38 +0100
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, stable
 <stable@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Matheus Silveira <matheus.feitosa@usp.br>, Lucas
 Rabaquim <lucas.rabaquim@usp.br>, Stepan Ionichev <sozdayvek@gmail.com>,
 Joe Sandom <joe.g.sandom@gmail.com>
Subject: Re: [PATCH 09/15] iio: light: tsl2591: don't divide by zero in the
 dark
Message-ID: <20261030092438.000029bd@gmail.com>
In-Reply-To: <20261027-llm-char-misc-iio-v1-9-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-9-0d818334f6c7@linuxfoundation.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 17:19:13 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> The computation of the illuminance divides by the count of channel 0.
> That is the channel which sees the whole spectrum: in complete darkness it
> reads zero, and reading in_illuminance_input divides by zero.  Depending
> on the architecture this is an oops, a warning with a backtrace, or goes
> unnoticed.
>=20
> Report 0 lux in that case.
>=20
> Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation=
")
> Cc: stable <stable@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno S=E1" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Matheus Silveira <matheus.feitosa@usp.br>
> Cc: Lucas Rabaquim <lucas.rabaquim@usp.br>
> Cc: Stepan Ionichev <sozdayvek@gmail.com>
> Cc: Joe Sandom <joe.g.sandom@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

--=20
Kind regards,
Joshua Crofts
