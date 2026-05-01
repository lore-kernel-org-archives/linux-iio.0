Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42A18C008
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598852; cv=none; b=YI13kC7cPC2r6Junp2DHVLJ4jPR0VrmO8tt8PRGwdY2OXimELcfGWaufIQb5HxiCyn6v90jeu3GXXrifAnAGGEWmzpycqg3hfdOrJd0PP8Da7YLzeGRGzXDOeCl+u6IVlO7RuGjfu11NWNEkE2fYr6eDW6cx0ExgLZdyC71jOV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598852; c=relaxed/simple;
	bh=ximWOOGUhYu0AuqVhj7e0KEXupWyOFsU+riykOPRL4c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=icGryDdiu/4RWOFJ9KYAroIlo0AUJxn2mbyGp738RNM92t3VKbTkdltoxxysa5/QDMhPyoCAiheMXtNpCozNT4X9PhtG8wxVS+GPQTOUltC+EOP0sTRmVbocQp1DTQYLsVy1hv615dGYMtAqW3SRN8SCZAgko8jAezY6nWkluSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1kGKSs8; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1kGKSs8"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-404254ffe8aso1320566fac.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 18:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777598849; x=1778203649; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFHRmmGVaDdKGA/DxTTnD3WtdQDoxj+78I0fv/vXXAM=;
        b=M1kGKSs8BIxwt2+vUqZ2Du5wRIhnXsALcxRRZlOYZ5KopeqOhmiX6fMEL2wQn4dCln
         is71JlY7UXKpE45y9R1qHd3D4I+yhrFvs0oEJXBsCWPAVyF29S8eN7jd5zhppcPC9Bre
         diHXdWPl2S9+fkJGQ/+m1JF+IaZPXtO/pERGd0w2613oIUZsJIIMk9xXt1f7GTTJiHwU
         ZmPMbFvC/8NS8Jb9zY5BEJFznbnDXStFzezMXy8OsvkQsN4qUqRUqr9lFdVrssO4izZt
         Utb4zOJ9H7GOlMJOpwSoW9RdA0j0AFdztg4dTqx1YZLuGXSvsajhwJV6L5BxInfrF8iP
         t/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777598849; x=1778203649;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EFHRmmGVaDdKGA/DxTTnD3WtdQDoxj+78I0fv/vXXAM=;
        b=fZbFfBk2iVtbVCZS7Mud/XQxnYQP3Qz4yUO5w8M/7ZD8YL47AeMNWNrKkpjy+ahgDs
         lE+IISmgzxVo2qs9yvLy9IV8ybfMSlwyaGNs6r+g1lM6SZ0fHP5eEFv9eCSk9orUUV8v
         tYCdaAHZYv7tlM9bsUmufikcR9FGc9mnIOp60e5QRSI5J2TLxVE4Jzo0DeZs/2gPdPNg
         esXSYx/AsNbmh3dAPf0t1gLDjLRVXKHrYCICJUYY6QwE7YSxDhXUkNLeQHW9izxXw/Y9
         iWUWR98HnqzndWkBj081yfbj08/ma4DpBLyJLbMn+hr0BzBE+skgK5/5zZ/Pr6QUzwmL
         PTPQ==
X-Gm-Message-State: AOJu0Yy3gPT3bp5rz3klp4gYESJGVmaiiuNyT9D7ImJAmlIwWdi3TilU
	DyB9eAc70rLBYarXtZWLMhx6wQDrsINAHzoOjXLkV6+VhSW2uKNZEWZd
X-Gm-Gg: AeBDieuRpkzmf1YAhd6uqSMmtqnnAD/X9AanKC50px4eFwZn1FmxLiEnbouggXkGr59
	5pFKmbVACXhvfvJyobyo9NE5Zrs4JE1KNMBgNmbstNDmTOVmL7jLDjwVR1wBwRqnjJKFQj6WkPE
	CCL5iZgo5Psg9fh9F14Vfp8iYadxAuQkuMFKW8yKIAxBgn3ZOpvWjjAY5wmUIm8zYv2Lti3IdQ3
	AED35K3zDMRq+igUKoxiSNHwx5nFQKifG23yFMiXRjbjR69hj1VJy65ZYsVmNrmP7yhOlULM9A3
	kp8dKZwTaaUkJ5dwxPLvnl6En23qFEt29H9sUqKiMniM/oLi/UF3e1a7qW2mv+pMrv0FRkiE2ib
	3Xe//MsayzLIhJWFb1c0qglwnaUA1eN/hS1u+w5qOzdDedFlzagaQbLGqqjMRRJ+WlTLbYXSBN7
	FDKD2qF/MzJ01d1W6NEov9xRPJZisHfSfu9u+5y5Wh6i7fbtSs+3Plfq07KHe1
X-Received: by 2002:a05:6870:a78e:b0:417:455a:2c01 with SMTP id 586e51a60fabf-43438980daamr2292973fac.1.1777598848904;
        Thu, 30 Apr 2026 18:27:28 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454d324a4sm1322802fac.14.2026.04.30.18.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 18:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 20:27:27 -0500
Message-Id: <DI6Y78RY6DRL.HBDGRFK0BCFO@gmail.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "sashiko"
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2] iio: buffer: hw-consumer: fix use-after-free in
 error path
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Felix Gu" <ustc.gu@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, "Arnaud Pouliquen" <arnaud.pouliquen@st.com>,
 "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260430-iio-buf-v2-1-84c2231dea5e@gmail.com>
In-Reply-To: <20260430-iio-buf-v2-1-84c2231dea5e@gmail.com>

On Thu Apr 30, 2026 at 8:29 AM CDT, Felix Gu wrote:
> In the err_put_buffers cleanup path of iio_hw_consumer_alloc(), the code
> was using list_for_each_entry() to iterate through buffers while calling
> iio_buffer_put() which can free the current buffer if refcount drops to 0=
=3D
.
> The list_for_each_entry() loop macro then evaluates buf->head.next to
> continue iteration, accessing the freed buffer.
>
> Fix this by using list_for_each_entry_safe().
>
> Fixes: 48b66f8f936f ("iio: Add hardware consumer buffer support")
> Reported-by: sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260427-iio_buf-v1-1-2bbdac844647=
@gmail.com
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
> Changes in v2:
> - Fix Andy's comment.
> - Add Reported-by tag.
> - Link to v1: https://lore.kernel.org/r/20260428-iio-buf-v1-1-dcc63ff7b80=
@gmail.com
> ---
>  drivers/iio/buffer/industrialio-hw-consumer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Looks fine to me.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
maxwell



> Best regards,
> --=3D
> Felix Gu <ustc.gu@gmail.com>

