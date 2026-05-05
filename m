Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC443E92BD
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778019152; cv=pass; b=jp7o50r+qyWYnOkPxtGe/LxYWqq4JY6V8jAlFzjoW+LwBdshDn9Mm9+SXIUe6XDGwrcWjnkbnRrhp+qtMrj1bTomyhI14smt2pEzSF0Fh3xoMI91EANT4TXXAbx0lZly8nxHr6k+sfd87g7wn89/uRd4TlJ88zk2Oopo3n1a0ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778019152; c=relaxed/simple;
	bh=kY4md+tk5Sz4Z5tkoWBmzbHTeToa7H+ou9prFoI9CBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyEfQf4pL4kTnIYetzBlGKi4AxI7JeFj2zlRTGt/SiyG3lCUUrM5WsGQmYS5JSBIMvXxOxuwNDAjrjdfz5oh/YcE5uvkpbiUYb6rBcf3SfgaCSqRTxpiVw9grgXShgh/TOJGaCJOGGImV2wDa8f7tv/cj5+F/k5F17MEh7MZ4ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbnpXoXd; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbnpXoXd"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-799001d73bdso52828427b3.0
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 15:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778019150; cv=none;
        d=google.com; s=arc-20240605;
        b=etZhefH8Av/ZqBtNIwErMqnPlOxQ/mmXBbyBFHxjD4VaE7EIXZ2WBbug/smj63evkt
         qbmZ4oVcNjwetpg4Daelt7ogFuSG1c+XA5wYK1VRTbSqWItbJwqP2feWZBS4O/tefmWn
         ncNNqr62rl8OtNJcLJ1L+doAqNX/bDNb9M0d2+WsK5Uyo0tIQhk2I46tu2MFCk8Eb/WB
         OGOglafCnXePTwVUXxxoEK038UvirnyhCWZ+tI+6wXfhLwGk68A6Nj1BvEM2KhRmp4it
         Raly2wGQVoZpci6I9XKfFqFtuPfcG1M0uj5/U0x1vUUSdbUkBbB2c1XrbIDSBKra87Zm
         21kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kY4md+tk5Sz4Z5tkoWBmzbHTeToa7H+ou9prFoI9CBs=;
        fh=9NgpEZoYoc5Ho85JV96zCuyO1yxVqznSYTJsKz/Iajo=;
        b=JU5VPZc3Us/PGAVruzkQckDAfpE26zhhFaFgYGDJXLN/uJ65a5Tg95H9zTaP53NZ9j
         28CVVINp2NeYLc/u+8Vh2Im7CUQvkKZNhn/KuKJjvdIUHEadxOcWvURGmWLbarYlh7Z2
         d0Yuw7IlmiwxUcEUQqr/cZhEWEwpD8OqoBQYWOyPeLBqmBatp0Zpb94C9wvVpu/+uLE9
         FG+TK4I2eV4niggUun3RbZqch8dlSckGwMaoJvfu6Aa/GZuMVMWH8Af1o69hP26SxF5i
         uGaSrMFyc9+hBbk0rrL2qUbx++EQvRrC3zIrvisQ+qDaIMjON6vVMDbU8OPkdnWxS3tK
         dkAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778019150; x=1778623950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kY4md+tk5Sz4Z5tkoWBmzbHTeToa7H+ou9prFoI9CBs=;
        b=QbnpXoXdhVd/DyAglllBpO0utVSN3UolzWnPa0wTjUU6+Ivkra35ThBJ9+hKBHso8N
         8SmHCNL9WoWtefJWDoQf6auCRXUm0+uHpTACC8p/vrKNOkCaEAwLgrI6i0M4AS+iT2ds
         XbpmDQ/q2nqABoBo6q24I9LlDTY8up3Hke3cDEpjlyGMpxTgTKNlc4py29pAUeO7fAz3
         9IuOR1A5V5yu9y9Y/3whDXrq3KGLWoV7IDvw7652OOlEgU4M73cHwxQnIJaXBodvGfMf
         Ysly2xWLQpQNNF6Bal6BcTdpUN2nOx+5jfIU0TB1Ud1mlFwwM/f7JAu1djnEe+T49XSi
         dFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778019150; x=1778623950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kY4md+tk5Sz4Z5tkoWBmzbHTeToa7H+ou9prFoI9CBs=;
        b=e70ZOsAMVfSxXNh05xlKfcUwRcXTA8JS9fjNFkZyhUxWFWa0fIDL5wZ3G+frPtxSLb
         wjbI66LYgzEFF1+D2jW98vyVa5VcvZSMER6RM8797RjK9CL/cJmy1ZcK/grk4icY/lEe
         7L6nlUUFZ4X5M6DbtoIZ5/GSbsNsXYjbzldDaNuiqVxjUT0d7CDsLv7EdOlHTI3DC1je
         fAvOp2+bnXe7HM8Ev30cyBs1jMjg2HehEuJ8inL68wIaV7wlR7tsV7yEcf06UU+3+2tF
         RNAJUYgspGrbh0L5sJ+ciwWu6naAwMsNb1PWrurY7pINhBtL0clDDvMEt3u0hxGdj0Hx
         H63w==
X-Forwarded-Encrypted: i=1; AFNElJ8eyESKaF5a7mjNCYzSgTBeG0Nl9XCP/lxoSOIBevtkE22hVljEITr8NP+V8mZNl2uNMw6sBA2I0o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjjEDf6vGyKi5/SlxIkGfucBFyfWlxBj/1TPQKWRGthBQd9qBz
	XVX7lqu5kNbqlnba1W7QUoHiF0V/aENXDiSWJlqtn589nh5/RxorBvgF/Ws44uewh4IE9L/vpyX
	POcN9aR79bgofV+LWX9h673HPiZxpRrw=
X-Gm-Gg: AeBDievH5xDEEP1UzdIqDVRyFycZJngmPv6dR3J9XUzRcgf4jjgR0A6HRQjrNN4Z+3/
	xbRQFoiblgs3Y6JluzKomsOa5bU7YxBDDyCuGTQwOLquaMRTUUVt0wtpTwTcc1/V8WAwdDArY03
	Xf5oXBO9h+txDj7Kl64zWiK7jkqiAf9qUWxOj56MPDFuMHgUEGP4jYftFSEvMO1z4qyb1HFFCDW
	7A/Pka3sNJawcVUNnN4Uxua7msouw93Jw/zR3fV+vVLDT9lIpkI/N5iErRIj1fHC8MCdPtbZv1p
	0+RVF4LMZzu6eQs=
X-Received: by 2002:a05:690c:9a86:b0:799:198d:8c5a with SMTP id
 00721157ae682-7bdf5ecebcdmr14542787b3.34.1778019149952; Tue, 05 May 2026
 15:12:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-3-831b9b5550fc@gmail.com> <CAKqfh0Hz_zc6+7m2ca8uY-kPNs=ttOh=qni7MdrwFwThEx69TA@mail.gmail.com>
 <CALoEA-xNCjBZ5xdEzEC1zoXL36=Zq5Bfwb0zwP0cU5W0Fs6Spg@mail.gmail.com>
 <CAKqfh0Hx2Mfb3me2JOQs6hpEKsCexZ9hAuE2fOX1qRdoqg659w@mail.gmail.com> <CALoEA-xyt3S8B1Fb4Qr2GZO1JhoA-bmCEt61ikP-UEf4gnJacw@mail.gmail.com>
In-Reply-To: <CALoEA-xyt3S8B1Fb4Qr2GZO1JhoA-bmCEt61ikP-UEf4gnJacw@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 5 May 2026 17:12:18 -0500
X-Gm-Features: AVHnY4JTSuSIASuHmoVvhF9DHburZKENfK_nMQcDAPsXUnfI_jYMhIDq6oA-rMs
Message-ID: <CAKqfh0EEbkOGYQ0-6K7xTTacGGzJK4ksfXf4RAig9TE8A92mOQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] iio: magnetometer: ak8975: replace
 usleep_range() with fsleep()
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 4:59=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmail.=
com> wrote:
>
> Okay, now I understand. From a scheduling perspective you're right,
> it would be less strain. At the same time I don't think that was the orig=
inal
> intention - the author probably just slipped a random value relatively in
> range to satisfy the max parameter.
>
> Either way, we should perhaps take this up with the reviewers, as Jonatha=
n
> and Andy (and Sashiko) didn't have any issue with this.
>

Sounds like a good idea, they'll likely have a better idea of this
driver than I do.

best regards,
max



> --
> Kind regards
>
> CJD
