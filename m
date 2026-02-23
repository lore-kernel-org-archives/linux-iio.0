Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B051E834B
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853937; cv=none; b=Zv7xkYx+ztFC5/6Hjv8HFtC78LDwE53K9zvif6Vv2gftmVIZ6TjnTczsdUbXe07oHM2HHrTzASEHFUq77ucT1in02jL6yJU8h1R+cl4AKGEsaIIKy/HdyYm/vAhGKI6mYyo0rZ0nLXZE+rDzAIFz6vBz/8m3qJb7un8Rdyvrdh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853937; c=relaxed/simple;
	bh=ngiLKzYzvi5rFiusqO8zAWNBZeYeruKvMQ8bZq4czdg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d4uargiPLFg3swfKNFpghqWiTS71j9DJdxk8xmfhDLyszHr3uqPONzDL6yxv/wB4o/1tLuIJzr0bIJY2tbmeisTqsYc5Zl4jhBqH7nQI8v0otk53vzK7Bp3pjgo4jYmURKAiiWsCOJ25savA5NJDd6ElZD0gorPfkB6gT2wg1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+wz0vtd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+wz0vtd"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4834826e555so42086975e9.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 05:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771853934; x=1772458734; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ngiLKzYzvi5rFiusqO8zAWNBZeYeruKvMQ8bZq4czdg=;
        b=g+wz0vtdwW1WNROZ+jf9ytURWOlV26xIuUCnY4RY1BnSs/baI440b8yEc3Sy2PxjQ4
         8cbk+H2oAJ87MvuTvwLqpoI4p/9s2c6QozcBrPplHmUw4T2X79XNJOGltUZPrnRpnVb7
         wL+G0jYjGhbCljt2/ZGKZfVOooCNZYfp/RQuiji+0rgrN/Pi389P4BccuISDa7DUeYoe
         k0LCmBG3gIwkiFp88+Jut6KjqW4rB2KwvA+GNtGqwUMPjJlPi05MuwGxk/iNOEqjJeIS
         UyPRAld5KD0QB0GlSihhEd+K0WWObdCqIggIe/C3bZHtV/ABkOKvrj9mXM/mPVChcm59
         wK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771853934; x=1772458734;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngiLKzYzvi5rFiusqO8zAWNBZeYeruKvMQ8bZq4czdg=;
        b=avoqT8uSkBmT5dL7GnZ3SeIeWjFGSJOZCg+XItrlEhdS8ZaVdOlgBwDP4jFkjFqBGl
         DW2uix8b1NKbPcsk/rXjb8eJG2ytgHHznkvsvFwhYMmdKisTMxZIY4LkfdKYyuc7j8rs
         6CZlbfmyMnvbl7y0wczeO05hUDJP66D0hHsGoFIUrES43JZRf3nf0XQV/Cd/8cWtrxju
         sAfRTK2LkSuIcVNA1sWmU0dTXt6ZVYkk4kMp3Zd05qF9ibo9Ia6PSkcY3LTj+y3ejFe9
         dVNRFZ9c1MnB4hrGMdMurTisyBXc1c+CDTFunPcSdTinCnyWojq9D34+WyS2WeCWGqX+
         I4fA==
X-Forwarded-Encrypted: i=1; AJvYcCXLGXeFkNIVQsenV35bpag79kFyeyACcDejqYA+xmQyAhLu2RZJ/ETqhSrFeg9PeaDZKXASgGANzBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgAdtx2tfqnwI7pjaGmur7KKH2wTsiRz0jArC7qTOBUNftOb/Z
	928GD9LyQNHq4OYINWzPLlfaxFel4vRRaYBMlWT+t+2PdlxkebFANlqL
X-Gm-Gg: AZuq6aIktBjxQDc1A4s1cvgaKSdRVFuTQQMQSdi75dSLvTkBBK4RwFZl8poBJDvPUpl
	7Eu7LNgdBEoa0MUDDL+MTSBxeUyk5PrcOQMj7wrtDjXIeTg1s7kpTr5HqLuuqP5X3ssfl/NKPtg
	NgXOCQzkKw9OFPo/Q32J3Vrtg6Q/FQYI7ZHZxSs8nb3AYoNdriGNFHaZiPa96Jig7cXm7ToMv5g
	jkCu9CSWj10hl+cc1fruza22D+86SyZgeh2c9h7wwOipEgscgBIYjJyUrHAcFfhwORYAy/xq9Q7
	MtSu9KPk0d6y1yVvlCZc0quvmuXIT+l377ibDu8nxrJZNiPjsEswYh3+qZoIYYZDdrMPnCe1rRv
	3f73rT2EN5VVhAEic8nagoi+uk0cxbUWAPG4Z+ugx9HprowheUPx3xKt7uM6pBb5W6BubZ6b3Np
	z5QrHeWQU5eMBDLdiFpQ0vdz1R//kIlvg=
X-Received: by 2002:a05:600c:1404:b0:483:ad56:8d16 with SMTP id 5b1f17b1804b1-483ad568e4emr74180645e9.6.1771853934363;
        Mon, 23 Feb 2026 05:38:54 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31f9af5sm248540445e9.12.2026.02.23.05.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:38:54 -0800 (PST)
Message-ID: <09ea310dee18ba2174c29e078dce00a539a20a27.camel@gmail.com>
Subject: Re: [PATCH] iio: buffer: Fix wait_queue not being removed
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Andy Shevchenko
	 <andy@kernel.org>
Date: Mon, 23 Feb 2026 13:39:37 +0000
In-Reply-To: <20260222123756.59273a33@jic23-huawei>
References: <20260216-iio-buffer-write-fix-v1-1-bc08b239f37a@analog.com>
		<6f5158e3-84e1-4159-9c61-789c2b198af2@baylibre.com>
	 <20260222123756.59273a33@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-02-22 at 12:37 +0000, Jonathan Cameron wrote:
> On Sat, 21 Feb 2026 15:27:42 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On 2/16/26 7:24 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > >=20
> > > In the edge case where the IIO device is unregistered while we're
> > > buffering, we were directly returning an error without removing the w=
ait
> > > queue. Instead, set 'ret' and break out of the loop.
> > >=20
> > > Fixes: 9eeee3b0bf19 ("iio: Add output buffer support")
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > ---=C2=A0=20
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> >=20
> This brings the code inline with the near identical
> flow in the read path.
>=20
> It's been a while since I last looked at the locking / tear
> down (what that ->info check is all about).=C2=A0 I'll add actually

Yeah not sure if you remember but I already said this a couple of times. In=
 the buffer
paths I'm not convinced the check we have is enough. Still very open to rac=
es AFAICT.
I have it in my list to try and trigger and actual issue/dump on that path =
so it's not just
theory. Already asked the bot to write some stressor/test code :).

> documenting all the corner cases to the todo list as IIRC
> there are some non obvious ordering constraints.=C2=A0 IIRC,
> in the buffer paths, it is fairly straight forward
> as it's just an optimization to avoid queuing or draining
> data when the device is going down - nothing about the buffers
> themselves involves interacting directly with the hardware.
>=20
> Applied to the fixes-togreg branch of iio.git and marked
> for stable.
>=20

BTW, I just realized we now have an Assisted-by: tag for getting help from =
AI. I should
say that this bug was identified by Claude code (when bulding the stressor =
test app I=C2=A0
mentioned above :)). So, maybe (or can we Reported by: Claude Code?!!):

Assisted-by: Claude Code

- Nuno S=C3=A1
