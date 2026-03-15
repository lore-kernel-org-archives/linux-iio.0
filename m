Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30737299A81
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 23:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773616542; cv=none; b=IZOMSveFaC7tlvK4NU2hMwY9Z+qlOgzGzlVvb09eggdBVwmaoY+zg6g0OYgLQUbYvIOyXmfzsWxdXU/hTglc5u5PHSP3rI86b04pEjoRDW5X6uZv1j9MTEixQWMafp9ja+E2eyO+qTSrdLnY99gMMQ8u23aCZzhzqRDZP0zg+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773616542; c=relaxed/simple;
	bh=KXE0kTfVKbthKFCLaufC0+ki7igm7Yqqf2CeyCe818M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtrGa4wq/1seqMAvx1hVO3aLOSZTzEPm74sknyPWZxLPjAzOaS23kkYMbjhS5iJ29y1eXvO4fSI3JpFS54mqhYQoFmvgNPcsVYQcTO1aVTb9uIFyUObKcjB2SGPaUIFLCGB1hP+gLMHZbgGJWPfiR0HUXdzD0BuEiUzeQQu5Rmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJV2ZPcp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJV2ZPcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32BDC2BCB2
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 23:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773616541;
	bh=KXE0kTfVKbthKFCLaufC0+ki7igm7Yqqf2CeyCe818M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NJV2ZPcpPXFg4tZzma3NhIokBzrKbzZ1tC9ZfDua+pu9oRzWJ3FTJIhqJuEH5VkO5
	 PGmVyBe1FX366e4MINBNhbbI9a8F5sjSMEjSfT5oRmS+oxP5uSLro3feiZPd8jbxdB
	 CmXamqtQ0kHpWkz4kjx92UOv1bk2Jtm+2agY0j5Os3HMjDlfiTQjWALhWbWz4vLY39
	 V4aE0RHxCY84ogQzjPrnqo5cuQSCSy770YF5ZTNwT1agw4diPJKzzXpk6BtRNzObfm
	 u2seNWN0FDuEDm1zxgdH3BBImsVbwakRpXKPSXkR/PDBAUjPXnwyHI+kqCzef6wZ6N
	 zYFN8vdNSc+rQ==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a40fb9890so5644617b3.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 16:15:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1P7pvxkEGMbmtgmp/XJT9NxBUhq8gOjrb8JSW3X2NwSBFAHRUZqfXXInKJw/GHCGFqS3IlBSx6ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Kcdi8eHgECoGrSaYNhPHQukg+I5YpaA23CDtjk8xfI3q6+ek
	lLpMz3+Ia/cXSHjSqfZ7r3cG8xhcuKpQhlvT4ye9+kJaJ0veel8fxEisj9Na6/FF7TyuzxiT3JN
	7xh9sEXR2VZInmnb+cgwnxaTKoG2fpu4=
X-Received: by 2002:a05:690c:3482:b0:798:58be:3248 with SMTP id
 00721157ae682-79a1c238cacmr118895847b3.58.1773616541161; Sun, 15 Mar 2026
 16:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com> <20260314170609.26827-3-rajveer.chaudhari.linux@gmail.com>
In-Reply-To: <20260314170609.26827-3-rajveer.chaudhari.linux@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Mar 2026 00:15:30 +0100
X-Gmail-Original-Message-ID: <CAD++jLnasubJKy56fMfYj3pSZ97g5SAQVKVU597R6pg0t-6zMA@mail.gmail.com>
X-Gm-Features: AaiRm51ADsygOZMGSYI5U4GcM3nRJ9D40rRGwFyI5fIB4HSTxyhRCSq0vqa1kq0
Message-ID: <CAD++jLnasubJKy56fMfYj3pSZ97g5SAQVKVU597R6pg0t-6zMA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] iio: accel: bmc150: convert to guard(mutex)
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, waqar.hameed@axis.com, sakari.ailus@linux.intel.com, 
	harshit.m.mogalapalli@oracle.com, antoniu.miclaus@analog.com, 
	andrew.ijano@gmail.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 6:07=E2=80=AFPM Rajveer Chaudhari
<rajveer.chaudhari.linux@gmail.com> wrote:

> Replace manual mutex_lock/mutex_unlock pair with guard(mutex)
> in bmc150_accel_buffer_predisable() and
> bmc150_accel_buffer_postenable(). This ensures the mutex is
> released on all return paths and allows returning directly
> without a goto label.
>
> Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>

This one is rather trivial and easy to review:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
