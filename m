Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F0406297
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553113; cv=pass; b=Hrvd0/MEq0CKNJQQiURCrZE9qFtB17hKVNB3AtRpA4iZbxLZhxBm38nPa+JUenXx+dAxOV+qD1h/lNMRJgERwdvDzl18QCYn7bqyJby+mprI1BM9M4bKJM7IyP1UAPiyCdpxMmHWKUh/trOyNCtUZkFB21xP958IgrWFYHQfWps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553113; c=relaxed/simple;
	bh=s+C8diM3QQlyHLlqZf3DOVdyVW/9QlKyFDFJaN4B3Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaIXBRa9VsxxhN1PrB8VItZoFhiLxfnzivlfBW3Ttj1We/5zafUnK2ni4ZBfRfOq88ugBTD5/p7hKyBLDsHHWM4zJqafx1BG2Rv0oSBSojqSHViYnrCxna9H9PxQ+6KvUzJb160xC7/2tYAjdeYe6FqOz6MNfJOqXO+1A3s2RXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMpOWz1J; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMpOWz1J"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-651c7ddf514so802354d50.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 05:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777553111; cv=none;
        d=google.com; s=arc-20240605;
        b=Qq1VbDwK2G2pHPvnJPfIPy2faRTQoWbeZw1CZyeZ8Me1SQWkyNlF709y+2e2xdB2YG
         L2hnSsl++o+1z/evEY9+tOikAQhxLuOiZAcheL26DLQhgyvMW1rWMQ6HL4uo/Ew7MR/O
         kmtFdKIb/Xwlki45L14XR1sQ0x2Ay8cE12gJKdzZYwHcT9zMTqb5yiBZgvoGbGP3LWwW
         QzJFjgArYA1vgZwvpftTK8bzUPU+jMzT7WUfhj/abEcrUIskTPVsn5iT1XRVQtvvhMyQ
         Zgwy7mIpQoVAA2Vg/DgMPVgAIUAE7WLZ7A/sLTrMiPoflGj9AZIKkV2QVEy09WYmwML9
         LGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P9LyDVOawfBKp4RzJ3NggCzqsElqGrPE+V4Uswfnjy8=;
        fh=ReG42qmxCWGxA4Oo0WX4P5gFITi68qhmLQXduuWHWrs=;
        b=KQFTAExFTs3Jn5MgxKK0lzt7gTwrvWnjuzJmeVpHUfpt9jCw6j6t5C5DKqqPcIlo6h
         XV5OTAXlONgmVWH3A0Q0CQjfJEwf4CDYts7P/pzLaNfX1Tdq7FIuB6/MgdJky1qV9rdN
         2M7jzJf6P1R8xlINXqsu/JVeLj4hnr5/rPNtQvFpIz2SCC4Aq1d2vDKzLiYon1iTIexx
         KWTw/w+Puaz+x0L26h26QM2wNVibXI6CI5OFeAi5Gh6YbUznCEaxqaRqJXuaxIvV/5MC
         O2si1ymZKfhYig9enCWueS24zdbsPoE+rIYVtk2vGlPwK4hOq0TEnNUQOUl5o1wDXFV7
         D/ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777553111; x=1778157911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9LyDVOawfBKp4RzJ3NggCzqsElqGrPE+V4Uswfnjy8=;
        b=TMpOWz1J3YeP2O21tucQ5Q/X+jB0xnbc01aEaViQQWwTxYBSl3XH/A7NsF+cVKRVMK
         cz+F6tNwoOyYwL79k30LcCYR4W76LOeNCZcsD7cR5yCmZjocCFxMCcTOzkHfJI3J3HoV
         bexutN5DR0/bGsmQx5VzIH+hYtYjZz+J1AsCWQLPSgO5TZW9OOBGr3TKAaQ2hdvh+P3D
         +vULr6QOho7l5XwPawm8S/dJAU0qi8PFXv/YCV8dpBiEXZBZ+vJk3XACf/DEItPa+0bH
         bRpMzsbVG9yrCTloJ7aLEk++CuQIeH12IJd2w5krWuUIS+lngd0NXqf+DvAMXYsAGc0H
         It2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777553111; x=1778157911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P9LyDVOawfBKp4RzJ3NggCzqsElqGrPE+V4Uswfnjy8=;
        b=TRsy17tx4djDJ9tGmaLEzrRkAVvB8DLVx0Xrb+0IBymnvAKmDwryt+5MM2k7iGTvjh
         LOj+2msYANu2NxfbHhNpWW4VoIkZXlOoAfvapPyMHgR6nFihrM3PS7eEeVHyO/SeWknY
         K8kAL8kGzVEoE1atn1zAruJNy+mrzqujBlxQGUbehkJyhk1lN2i/nzFdpf0/X5p5SOtI
         +k6qC4NIJImadtMj+rZc2IL6beYa/7jeoRDJCUtNdGiy38m8/Rxlqt5bEQCfC2H8H+FU
         qMfjjV+l2Y3j4bLjiHjr7yvwRyPn6zzJvAq9PcgnyBdm8qwEHXkQ2ViYMBQYIEEoty2/
         rpaw==
X-Forwarded-Encrypted: i=1; AFNElJ8TQyOkhBSWr+JIFFNGmNmXhWhrIlzjKzbVrX4+T9Ik2HRPVekwolMkq7Yty2F5HV2VQRyyb9QyqeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHZbIibbxpngrJH6R27gOoCCQAgsqe989NIDTbcfQxGBTkQE7
	YV3I5RSThiF3B043/YhzNmD6q//RLLPVBM2UXTha6ZqJX1ZjAB+4qfWfp6xoISvERkBTc2tdBEr
	jTvpxC172+vFNBg99L61h5F3quZFlv7Y=
X-Gm-Gg: AeBDievLdGIwgK87e8Nd0wc+/ljxXKzekGWidTnqykIPUUSa5One6jXzImumX3A2wi2
	6baug8zEmvAmibZw3D97J4o0VP2kN4ibunQmxy3vqKXZB1npLzK4n19KlKQfIOWzecBs7R2wv/A
	PNIad8Sx8J1sCFvaLHjuH9Gv/7MPGnvXalEftVUyD9CkB/E8tFa9udJn1fXE3zA+TTU7QKTOOjn
	CXIXZ8RSfXABszuFXfHwXNWixzM47iqwRIb/LEow1BXSEkdAeUPMCeUCMy/xG6wyHrALFEkfPZb
	FSvnwRKTnz+COww=
X-Received: by 2002:a05:690e:134f:b0:650:9d0:56cc with SMTP id
 956f58d0204a3-65c18dd1fa6mr2027882d50.30.1777553110797; Thu, 30 Apr 2026
 05:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430124148.11572-1-m32285159@gmail.com>
In-Reply-To: <20260430124148.11572-1-m32285159@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 30 Apr 2026 07:45:00 -0500
X-Gm-Features: AVHnY4LGzqQ-MOD9C2MehrXqiwCD36qwYXhjB6goEZohM_JolH8zznmQJKbzxCo
Message-ID: <CAKqfh0GV=NxE5qvMEAgdjEBP24Ja9oakpr+6jGUq9FMwuoRgFg@mail.gmail.com>
Subject: Re: [PATCH v5] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
To: songqiang1304521@gmail.com, jic23@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:PNI RM3100 IIO DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 7:41=E2=80=AFAM Maxwell Doose <m32285159@gmail.com>=
 wrote:
>
> Replace mutex_lock() and mutex_unlock() calls in rm3100-core.c with
> the more modern guard(mutex)() family. This will help modernize the
> driver and bring it up-to-date with modern available macros/functions.
>
> While replacing mutex_lock() and mutex_unlock(), the critical sections
> of rm3100_read_mag() and rm3100_get_samp_freq() have been extended to
> include negligible operations for cleaner logic.
>
> Add new helper-wrapper function rm3100_guarded_regmap_bulk_read() to
> help keep rm3100_trigger_handler() switch-cases clean while maintaining
> mutex locking and avoiding re-entrancy risks from potential callbacks.
>
> While at it, remove redundant gotos where applicable, and use direct
> returns instead. In addition, remove regmap variable in
> rm3100_trigger_handler() as its references have been replaced with
> variable data.
>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  v2:
>  - The following excerpts are from the original cover letter:
>  - Added small style fixes per Andy's suggestions (Adding blank lines,
>     moving an if statement in a scoped_guard block).
>  - Switched out scoped_guard() for guard(mutex)() in certain commits.
>  - Fixed error in commit 4 where deadlocks could occur, as goto
>     ignores __attribute__((cleanup)). This has been fixed by the above.
>
>  v3:
>  - Added new helper-wrapper function rm3100_guarded_regmap_bulk_read(),
>    see commit message.
>  - Squashed commit into one commit rather than four.
>
>  v4:
>  - Changed function signature of rm3100_guarded_regmap_bulk_read() to
>    supply struct rm3100_data *data instead of struct mutex *lock per
>    Andy.
>  - Renamed rm3100_guarded_regmap_bulk_read() to
>    rm3100_regmap_bulk_read_locked() per Andy.
>
>  v5:
>  - Fix kernel doc of rm3100_regmap_bulk_read_locked() per Andy.
>  - Added Andy Shevchenko's reviewed-by tag.
>
>  drivers/iio/magnetometer/rm3100-core.c | 93 ++++++++++++++------------
>  1 file changed, 50 insertions(+), 43 deletions(-)
>
[snip]

Hi, just wanted to put the link to where Andy gave me permission to
use his reviewed-by tag just to make sure no confusion arises.
https://lore.kernel.org/linux-iio/CAKqfh0H1tq1eC5h54G1Vft26Qkaa4nYEdhwQAk=
=3D1R6CNXgnveQ@mail.gmail.com/T/#m5ad582163d5d9620c59edcd1a78eceee070677f7

best regards,
maxwell
