Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D018B0F
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779749672; cv=pass; b=BVwyQjKoqM0pO1KETDL8F4oUHB5hScmLpxbe7tesH2GJeB5bpy84UlX6NKNfUq1TENohk983WDkJ55yZ7dbT42iJSJ9iyMdE6W7IEmfBHDyT29KkU/p3Ds6D2wSc+LLQ9Z9yL+NUAS0/moqb6Sdx/SsWZd9gq1KofwvFWvLBHs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779749672; c=relaxed/simple;
	bh=Mn7Jlzqcx3GXIQK0UZglBYjSyI+X0sNPPao86jOJbnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=toKf0Lwl8F9T5YSZ6PHZ7aicI6eS9CVXQqM5oTd2vdTSJ7E0w68IguNmzdaWDQ7K30ruRiqOlN7BqgLA1ge3/FTBm/GrkxQp+Nmumu55uIHaCVw5J9H+7lp1KBPvZ/SK72tfHSPstCRa6FO0Vs/zXghxmT7f5tGzA1/k+CpWt3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZIw92ZP; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZIw92ZP"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bd6f65c781so81190837b3.1
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 15:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779749671; cv=none;
        d=google.com; s=arc-20240605;
        b=J9dz9XYTO3ClixtqGlVZxrrM4sQpx7aA8OX4V+aBF5U3pI5gDi32PUfaT2xXvHmQOd
         /36GDNxyXd8KoufdOVlfMa+VHuwmVH9TKEjIerpf1YUsxRqx3gsXT3c6lIffwvVPWe/B
         yZ4jo1XZ5u885pz2szrFqiL3wSuO4OIHpQbsLAlNGuAOoIdQoxf7OGDZwDUbJv89CCEi
         4wgmsX3d6nCKDTflwSWQQajl2VN6pKv5Ohy783zUotkIVA+aUlB2fzHvOyi/lkGLPHZy
         K2G4s2U0b1kZxCmavr6NKwVimeNQ0A6dLYXUgmaBath0P887BWjCPQok2xkV452v+4o0
         0QdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rJ89BdaVhkkdyZCZfg1MXbyrHm4WlE/URbDEmjvZ7wQ=;
        fh=Hr/jxIEPJYuKGM6AVN5HTycTX21U9Jn99a4buhNHoLE=;
        b=gFPZTDYeRWMn0kJ6vWsb+596F8zOglN0Sq40QinmE3ShBeR/fIhh49yCbDpnVX/K4w
         aU13UYzRwDgGuHL1O8CkD/hKgkAfBgHq8g1FNpSZIv7b1UFzhM6AmZnPa2fnsQwwntGS
         6v20NHtzJzb1jUyI2vS07AbGZQyXtXuRbvgccAaaiYGnpbGdNg9gjvHrQN7XqL2zgp70
         W8SpJDvebxCKwWcUiKw4yTdFH9l3TK6KRNQdI98QC2TflYhnVkrdQDw/MF+9l8BD56S3
         J8xK07GUj4iZNyvPvjErAzPfHbrgIPaMP5LmDKmBBJ6NZsh4Ul7lV/bUQJHpREngv27u
         nROA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779749671; x=1780354471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJ89BdaVhkkdyZCZfg1MXbyrHm4WlE/URbDEmjvZ7wQ=;
        b=sZIw92ZPPt9Hs0lJ/LGZ1gNUVoU8pREljWOr0e00CgRo9pljCT82ZFo+57zBY+TTwM
         uQZLKdzF54ykA0rAISR58bdhfyXPCDe3FcFRXuxD7g2V8SJL0lBwN15yY90reV9PuY7Z
         AwAbK3rHnPbj7V+K1vrPoMlqwK001MRjgyKPxb+ed0WWt/+fNWyixbSjN2xLIt8anUk8
         NmefThWWPb6I1meqy4CUjwFIoPTGNpoomRWpfR/sJmxL5B1c2q0giXphj1qz42hEaNOZ
         Gh7mJza1yZNAKrHctQ7MDkBjHvB7xfJfNzYMUDm9tKwnLVd7qE1vxpDyPaOqQU371R+2
         MiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779749671; x=1780354471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJ89BdaVhkkdyZCZfg1MXbyrHm4WlE/URbDEmjvZ7wQ=;
        b=XVtLsQ2chvfdwQScmitpvKlj4RsopiC/lh0UJK3QQ/tBddRwabaLjtCqKv1CqX8Gwv
         cTlfN4z7u7QfdJiNIYShcRCXQwrwvJsJ9O8Mma/TTUN63a67rsE0iaR5h65dK0vTOBiq
         Yfe2YpZ63SZjgHYWSxmPdCcd+uIkT08SOkpmy9hIWdLKTCMsXLLnpQRBW7iG8CrgC1HT
         s3H04FmOy3qEkFc8WyK3+niBwSGQ45OAHpfcM1KjQlcxrC2zdmULv5gMR5sn+YIrL3HM
         wKXD936+xyDSrr1i741Q6HsfBqMJc3aPJx7LmeA+yLP9xSCJ5E/nLCpym7yIXACrY2V2
         kNUw==
X-Forwarded-Encrypted: i=1; AFNElJ8dBmP/DRrOebckD079cufwwOIWgmveE3q00y+nLvRpAYPBh2UgA5sWm35e/xyHmYzwy01+LZHLAaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyERYRVVx4Gck7m3yHWvkUx3fToJIPFEoxuVnzzJPKxelCcF9Wz
	alsqHTW7FG/Kl0G4XqLwr98xQFHZr7/VChK0AIR/DBlYKavFbQxmda5auNt5b9eQAozZsbLxH17
	wM5rWu3OsgK8PYVxWPS2bj41Uf5DK05Q=
X-Gm-Gg: Acq92OFLcRO1XDSo6pGDB9Ma8UyEEzznZCHD9mLtQvz450rh4q4CiU9Vm9F3knlJmfo
	uC088Yvfj4FI9Dy6WWoOQCHnXOhVwHWREWYiU2WLZSFKLA9lDu4jbeyPk3tY5S2w2bjKnMlS2kC
	rjkb65iQkipNZvf2DF2B2BBQtVIfsdQhP22uGJLze6M0p6MBPiclW6cqNv+it+Cb9uoU+VWMzSc
	4rzpugYHq6sDOGCt5FZxnqdKrEtO6Jps+W9+dtwFx46WfhgEAJ/51Qi7AMxTGOPHsuzx1jP5z/j
	yoTMclLOdBa3OqDc3Q==
X-Received: by 2002:a05:690c:6987:b0:7c7:df46:3e2b with SMTP id
 00721157ae682-7d20d50ffe4mr165731227b3.16.1779749670664; Mon, 25 May 2026
 15:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com> <20260525-opt3001-cleanup-v4-4-65b36a174f78@gmail.com>
In-Reply-To: <20260525-opt3001-cleanup-v4-4-65b36a174f78@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 25 May 2026 17:52:44 -0500
X-Gm-Features: AVHnY4J0tEaFKcsP7dGFDOXidcO0r7ZQ3Xkr2v9mfvc4mjkvTgLobeeg1KoI5jw
Message-ID: <CAKqfh0GcHBNNGY6=-jmb8m6txE-c4P-66QNYh1fD-LnKUBam5g@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] iio: light: opt3001: localize for loop iterator
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 3:20=E2=80=AFAM Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Localize loop iterator to tighten scope and improve code style
> per checkpatch.pl report.
>
> No functional change.
>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/light/opt3001.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

LGTM.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
max
