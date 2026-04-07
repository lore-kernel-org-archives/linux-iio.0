Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4E3A6EE0
	for <linux-iio@vger.kernel.org>; Tue,  7 Apr 2026 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558594; cv=none; b=tD5ouzhEBkGbW4qfsB705p5wz2/6aE7XACl2qlYBrhdaBAauoHaAyhsNOV3VEqKweAzfYwhUdBwo41+X5+EUmT7VfaS2IokP+HOK9lhKQgzMhnO3DKY9qLhBhYLRpxG4wEQ28Cs1P/LVd/a7XjhCs0wgHDjgzG4nrCTgC+YSBTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558594; c=relaxed/simple;
	bh=OGCTSec1F4wOyMIHYzrUkhMcXjE9nQRXccS/tQ1wa90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUXdEErt+CzZqvBAP5azxC63M8Xom9DoK5Q46ny+ArR+Srx6qi1JsDCXOjTEe9di8wnx4z/4DcL4fZxYPxPP00EK3avP8b7mc/NLeukf/ZZLzhvlAp5L9ImSRUtGZh8m/adXE10yhPC3Jb5U43Hv8EMjkm8YkEBxUk1X7EBwjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InrJtFPK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InrJtFPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAC2C2BCB5
	for <linux-iio@vger.kernel.org>; Tue,  7 Apr 2026 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775558594;
	bh=OGCTSec1F4wOyMIHYzrUkhMcXjE9nQRXccS/tQ1wa90=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=InrJtFPKZRalAISWGcUdoQ6kCiwg+6OkTBPumuC7EMtTGRT15uWlCDzjlW3CIu5l0
	 LNGoMkGTPZrwx2Ly3pmTKQ1sDNk5Bbw1U8/52La3yxuhZfiDCM/w0NpzpUFsM+LhSR
	 JY0jPShPWPwuz4vjPvwDLgdm5bzk4D9ZfvD2W/g3JuPmC6tae9uDGn23G7WEp/9z+w
	 iR9Ocz8c8sYVWpCxXD5y04bBhy2zljl0/REWNqexvLyzkHEQzFd2sGQkj8xz6w2k1v
	 14VNn+T45ESjZAMo84RKALDtxxjyxdFEJuzvjrHWWwT/ZVZkzTzdYFEPsWNQsorWCM
	 JAP79h9Unqffg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38df11810abso21139161fa.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Apr 2026 03:43:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEugcYmTcsOOTVIXP2xrf+InPrlsyj/S/HNSRjlCsSGgzHqqb83c9zbdbPpg1/jnIxZxZ4S+AfYmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnyrN1k4dV0qJvHtbUCGscrrCG2872rQg+M9l4+rfdo9L0KWyg
	HzHqqvq9xXeKtz7PHO3drsizYFI0CWrIF01+1fBV4UnhF66drQ5bTdWjvotXyEgxaEnoMJGKJWM
	NgWnQeUnSqijNyGEGtkDiaiNUWQNg/3qUGf32IKmndA==
X-Received: by 2002:a2e:3207:0:b0:38c:13:77a2 with SMTP id 38308e7fff4ca-38cd6a7a15cmr49104791fa.5.1775558592729;
 Tue, 07 Apr 2026 03:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com> <20260405-ti-ads7950-facelift-v5-4-1f980ed3cf9e@gmail.com>
In-Reply-To: <20260405-ti-ads7950-facelift-v5-4-1f980ed3cf9e@gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 7 Apr 2026 12:43:00 +0200
X-Gmail-Original-Message-ID: <CAMRc=Md=XyjK=EaVNxJX4bD7hvgDSL7J4eSiigOfk38E5CKAjw@mail.gmail.com>
X-Gm-Features: AQROBzAdZd8mVdscgAxhpK3At80nhKQrpbZ00LW_oc3m6McHYMTEVJ7X_m28-wQ
Message-ID: <CAMRc=Md=XyjK=EaVNxJX4bD7hvgDSL7J4eSiigOfk38E5CKAjw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] iio: adc: ti-ads7950: complete conversion to using
 managed resources
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 6:39=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> All resources that the driver needs have managed API now. Switch to
> using them to make code clearer and drop ti_ads7950_remove().
>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
