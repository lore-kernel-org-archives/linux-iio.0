Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A40333730
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778024789; cv=pass; b=XE+b1ZoljqaFTK+W6dFO/v1r5YC0oWCjNPyardW9YcRYX635yVt2TpPifyOQngrMVvsUFAmzleJO/9SCTJ8vaSEFoFXFMgaGNXpf0G+bqqGT6pOJ90c0wx3Iq3Sv01qMdBTjthCpqYclwUISisTU7HOOcV0x7pmsmZw955mcMx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778024789; c=relaxed/simple;
	bh=nu9mrUrU1PUtKQ0lguk+2fcQbKRJ62fWabNKLOGiJng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ht/x1EJ4xl95zuJ9a0jrUR04uP6nuvcYBZoAOfaCunjwTTD9HWTr6nQVR+jh7T2y9We7L85XnZvZrfXbKMVJ2s0aJFXP4ee0A48HYII/BA4RUWdAMOrYCm8BjSKuJdrMcL5fpbNlgr+21AR3RRJA9blSB1wszo0t/aczoMdb2ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGhkzMzx; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGhkzMzx"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c52bb5dd7so2845000d50.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 16:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778024787; cv=none;
        d=google.com; s=arc-20240605;
        b=YZH7pXMtpEaW92FyUQdt5h8iSQ3wSzzzk+ELwCHYKGz/6c2xpZEKW2mnkV+cV1kX5m
         Ko+FIMH23DoKqjHPPu8HTTzdIerTnsGRU2degagbjT/CrgPFLNinEnQxBqxaGCvnlKpr
         FT59sdXH4spoZMMyGR1dmZqpKMNhwvoTrRv7z1Zu5GLjMW3lQpmvU33AVoiirhP0T/Xg
         C2SFlwjwKInsMMq//H7qMkx4UH760rKAjpYDck565rYcF7Rhq/2xH+8DNotFlIZyncL2
         yQPgBqBlBgIL8RFDKZhFO2IBqpCQQmBRDtX3NXIJsAwhi8EJ87ebtBzm1iBLko8mIJxJ
         y+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vz9xmp0DVwGFQ6SDsX8IgnhzHsPwoiL59xV2IjC2vHk=;
        fh=Csidd42l5iKoSFT4VizEVFRp+lxF7KBqGlNDsUKwQXs=;
        b=VM7wqOUNmC9EuI6OT8+IYjz2LHFZ9L7UKES0Ohb8Kq3tOhNbYfNdsnn84gNHjTQH48
         eTMKwnkpoZ48MmqfwpWl5DbgLdk/GkFGdIt0wrPVyD1As9Y843/WNt4OtHz4WM908Yb0
         4yd1uE7jm3GkFVK78j0cSrVUYVm7TQq8bSO2Y4/GEbFGBycB6A/ffmDLGfJF6qh146kc
         Upv1hKa5rLPC6P9Wh2vrZlSSDlfponYJ+0V5ici8w+cBo2dqx0JMqjvC9Db0pc4XvQ9U
         6/TuIu51StTYgYOrAPg+aZtjOVYvuEZXg0P9k+BRAC0DWwcfpC6RXKMqLZwNkdpzNaHi
         7rkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778024787; x=1778629587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vz9xmp0DVwGFQ6SDsX8IgnhzHsPwoiL59xV2IjC2vHk=;
        b=GGhkzMzxbBBEJsSOCF41DMz4JJxxHJaZXw+ZokOziZsLkQh1UaI5xAvW0QQq2igcdb
         hcBB+lv0WQFWb1bEoRIzKmlNwQC7DE6Zignb4AD/f3VTEAQJ0HhEeNTFRDQp9KfxiRpt
         9+vSYPBg5Ogel8GqiPKeRmqfUHvpHDisJvxwzlLV4NOuLJYqS4nm5MsNyu6oYXSBLvXl
         t4zG+Drx77KFBdvTRYukyW+ejjnzUJQMVLgKsTFbfc6mz2f1h4eGD8sgtLZNMFLNd5dO
         0k9iHmLsNcZvfGIYogAKus2i0N1GElUht/0O/QOtaalC17SL+YbdbHf1kdgwSBG1HjQf
         iWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778024787; x=1778629587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vz9xmp0DVwGFQ6SDsX8IgnhzHsPwoiL59xV2IjC2vHk=;
        b=gkcTpjNHvjuEFCo7O1Lgp2Qpdy2zWrZA0tX+gnLoXJv2pXfQmMdVLElrxV4HWzmcR8
         2SeuqBx4/TVP5h17cgAGs+xVpsQSq4fWDlqtiYmOGyaYG3gQTjzYz9FVQSspCxw3ABwn
         gdWvz+TLaCEfrcjL/Nb5mBkD/O7SJ03+EBDP9DecQSsGP/X3D2LmppKdpWufqVxBFkyM
         vjRGpKjrtAaKEhTTas4X++5/kxy0Kv3kQkLdug0k5wgFpW8GGIwbvrRaSuW6iwYdSIsP
         n8W9XkrG6cMErasBQdy+Lz5MMQVCDs9D+GtG3Xd6xHvANiQ0pkUU4EzvbrpIfB2gGiSX
         au9w==
X-Forwarded-Encrypted: i=1; AFNElJ+UnRua8CvU/oZW7IGjbuLzaSEYOJaxyE0KMl9MoELWBU8F7hB2XaliaxJcshd9GIbyCbilWP1wxkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrCNDoSzT6zEdF6Zf4JQ1/Wh8+34IiZFUO/LnENUIxooFVr+u
	54TAY5r/gHoaXBeXOI+of5kGu2xoUokrLuvwW4/qi6qUZcZMxFny4/2XwcLcMLnuCVsPwrYb+C7
	6dK65FVn7TjoWADIc7YHvDZVzGhEdhck=
X-Gm-Gg: AeBDiesoaz0mi4RX0J2luaESj+syqalVOhOfmtXfd3t9abYMWemY0aglO4zrQvKPdUd
	7gUKCXdk/bIEJwlStf0z32Pm4+P9g5+Zfd8WxpND3293BJXLBJN5ZX6tZXQc48hejyeERiOlHLx
	xyOMjzKNW8QWQFVXFPdQ7cFnBQEo6yk+Nlvoegjh0mJd4vxrpHgoIeFyKx1qLtoZud6Lp/JlhE0
	QSLL/j23FZ+uuu4DFZjTXJqNDdbPTBNetIJ+aTQgjdbNXqnQao0dUB7ms/mWdZigl7YN4kcwKxW
	k5RB+ggvzBy7fVM=
X-Received: by 2002:a53:eacf:0:b0:657:eeac:6ba2 with SMTP id
 956f58d0204a3-65c799b6424mr1351484d50.46.1778024787246; Tue, 05 May 2026
 16:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com> <20260505-magnetometer-fixes-v5-1-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-1-831b9b5550fc@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 5 May 2026 18:46:15 -0500
X-Gm-Features: AVHnY4KDr0dEb5C34el-umZ9oQmkamW8W6vgH8-MGFZxsxjVunyNjF22PesCtCc
Message-ID: <CAKqfh0GaEmCcHb6pMiJ6rBNMmhMJomN7KCzOw05sOE2ksBeqqg@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] iio: magnetometer: ak8975: sort headers alphabetically
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 6:46=E2=80=AFAM Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Sort include headers alphabetically to improve coding style and
> readability.
>
> No functional change.
>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
[snip]
>

LGTM.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max
