Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CBB39B4A1
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968956; cv=none; b=pWu9UC8ze08DdZ4bPC7X3MLwsE5ss902N9bQnDv0sl+pe/gZQ9rhW3umU/Liro3OkARAUku83hfAF8qKpgmo44iJUXXEpiQz3XRsvbOgAWE1ZiL1diyPP4zugwL5CvSQu6aWCFH//9Cceo/QvZQbpqafyoi774iy8ePBD7PwlbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968956; c=relaxed/simple;
	bh=pDkdQYz6xl7B7nniD7inM7W841i1NFNEjVUgddcSPz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnKr5aT98hEBviO/AyL9DZALe5PRvbDd6SEgJuyf+YOJ36bOupxYp1z5yXNYjDJgtmNj/S/z/VUU1aa7GqT5XjYX6INFQxwbtMuZK48NFcALYRZvcxgu15diVtKA5Q0elc8Bkugr5UWB0IBJzCKTWniRSd4D3uHU5uEO/Rjoaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCthAKLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCthAKLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9FE1F01558
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786968954;
	bh=pDkdQYz6xl7B7nniD7inM7W841i1NFNEjVUgddcSPz4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eCthAKLffiv2uBbyvOAXDOe1MVGo7Nflav3LbcVtbtsLor72pAp2rmSx0O4vd3fGX
	 V012BcaA575v+zjYUwgsTrZv4DsN7Md6Np0JsHso0Ba2Xy33AoJl40U8LBf47Y6LaD
	 11+iHRPmivWxY0qT2nhqyWyNnRNtRalsE5AHjVh/D9NK0TjoRp8QB2hUCDPCnSySRY
	 gQ99pfFCH7HLQ0Cn/j3J5+WHvYUGg57Lln3j9q7oTYD7jnVYtEFzpPNx5+lNkEpbfI
	 Vj1JRKXzrF2puyeFI3m30lqLHJGb3eK4pviP9D5xyZNXmoWd17oGVSJmgEI6Mjk6qU
	 QCG+x+gd/m2Kw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b45f1cd80eso2285266e87.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 05:15:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp9LDY3KuPUY/f7CdmXl87h5KDVFaYPBVX7adIz/voo/UbM/1xlDjsp12QfsIKYm0gaa6stiYIkXL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy26TvCBRKQmxCrgQ+SYFoF6XMFOjqD9YpyCZw6VcgP/kZV6yJ
	Tgfhuh9d9vi6MqEU6E56p2OL4ovl+shse3N6oXRdOfLceH3VZTbwLAnnJqqmpN3HY6Lr5A9MQWu
	G5Qpg3xDEBnkkbBcile2SrrebWPx+RB0=
X-Received: by 2002:a05:6512:1320:b0:5b0:1516:8799 with SMTP id
 2adb3069b0e04-5b4596c50d0mr3469717e87.17.1786968953608; Mon, 17 Aug 2026
 05:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815175728.99541-1-yashsuthar983@gmail.com> <20260815175728.99541-4-yashsuthar983@gmail.com>
In-Reply-To: <20260815175728.99541-4-yashsuthar983@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:15:41 +0200
X-Gmail-Original-Message-ID: <CAD++jLk+Knj7g-K1MXWuot234nje15qJYNZh=SKkTgaf3Sxw_w@mail.gmail.com>
X-Gm-Features: AcwNN1WJ379jF0cMweHNX5e7_4phroN3K5Rq0ADehHoISZrmt5JyTwKwOH8C9-8
Message-ID: <CAD++jLk+Knj7g-K1MXWuot234nje15qJYNZh=SKkTgaf3Sxw_w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: accel: bmc150: use iio_push_to_buffers_with_ts()
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, andriy.shevchenko@intel.com, grondon@gmail.com, 
	hexlabsecurity@proton.me, sakari.ailus@linux.intel.com, 
	srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 7:57=E2=80=AFPM Yash Suthar <yashsuthar983@gmail.co=
m> wrote:

> Replace deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts() to allow source size runtime checks.
>
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
