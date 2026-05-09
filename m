Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19EF371D15
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778370926; cv=pass; b=HDF9no2qVz2mO9Uuwsb5ysHEv40L/Xys7Vu5Joq6x5NQPYhDnhuVPoEH5EN2TmzHmqOJAhztkfxkCR98Ge57z2CkQoPfD6ptQ5jeKpiFzwFST286d/8FWhsDNkCu1EE9QVCOsYDWz/w67W3YeWRs1DN+cdnD4SxkkfCohrsIkR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778370926; c=relaxed/simple;
	bh=61PIxDHaLVS8bQ84kDyKhmHYzTQLMV8QWS1H3QMCKyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwoVC313b6Mx3JfQnMAY/mR5dTGfeWYUmm1UKXNsUGXyEgHKpjVlteh3agurO/kY2AnJ/bdDR+2XCmQ60yCJY+PdM6ooX+lU6PravO0mKF6hMbnuz/sSzkcWd6drikW8k1+CuxvbHPbURBUjTFWzvFM3Qpupewml5b7f5uC4kac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4tHQx8V; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4tHQx8V"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65c7efdb7d8so3362112d50.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 16:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778370924; cv=none;
        d=google.com; s=arc-20240605;
        b=B5ZhAghrxU97pbKOhFQzfusmFaRfHtpweFgO6mqQvhcUlhE/Wfcs5TI5pw+6PIm4jV
         qdZ175I6kGBOlzCnBOjDKCB18axI1Neeog1V94a/Co7zS2VlaqkHh7l5mU2GnmDa4G+3
         4qI3tpJ7hcpqulMTgdoLh0oHGWcd4TN0wu6OkhuorcWeOBnh1+34M2VREpXSmZ+7B+07
         rib1GmL+2Z5N/o+LCRVfLGoMnLYL41q2O9nxKEd500bpftNfbwxHeygWxzoB8sUiiuYe
         yMP+ia+91Z4Yw79p5SHXogcJW6AMqSZjC6oXK488VnJjTYmqibU7WLRM2aSU8v1DMheI
         IV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=61PIxDHaLVS8bQ84kDyKhmHYzTQLMV8QWS1H3QMCKyQ=;
        fh=+rsOhHhcrNvsvpU48rbPIS2P6KVc4MWKKU/3klsdAMc=;
        b=jeRjXXyrXuZnBkh2lWkvMvzeT2VSnNSkCHLkwey00+/1B+hr4aBBc5al+pN7OcqpbJ
         +4JqDecNTXXYOXmjmQduO3Bq2ug3/lGBY8UZRC6TJXKMXX6QBoHr2JV2Yf+BxWOS3zwF
         cpiJauEhquMB/ZoOvv4dtV0e7DhTqPJJR15gqNa27ve7rvacwYa6jWE+wRGWOY5FIBws
         InplrQkrXmdWhJ7Dt1YeNU1Tz0Z5LRQts3FZOoSw4GE2zm0dq0//iL9WNY2S6WlPzBgM
         8kLfYnKsEfU4cAb2/h4GwrkoMSr8v5ZNdPcmMS2V8pbV0QFLffWAJRrVWoarsUeYTYad
         WO+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778370924; x=1778975724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61PIxDHaLVS8bQ84kDyKhmHYzTQLMV8QWS1H3QMCKyQ=;
        b=X4tHQx8VRaKakVrXzeXNl6p8fyElfiIUJKoq1xHH5Ub6jXcDTHeL5mJROtalHlYFmH
         BSbla6L2wLPs5Vz+Oxi/p+GBFnp5ALHs/qjNU8fJS16aCTbty8TW+rau/YsRl5HIJioO
         xmMEtrY1CJTGnuMtqZQnlaV5PXpXy+kpKtqAhKMQpzGCtp1knwqWMFRFYAdNUV1rWQYM
         AVc7fjnArfrP14uZ5P32KrN0CZBrazDJTtbObQLSQywAOwyvcHjdHDu8Is8MuvwlTVo3
         Z/1vUFBFHwKdI/t1ypng0VjexQTSktWdR3fvESP1sXU8M5ozcCTDeCaIJUOi4ug7VTQ6
         MAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778370924; x=1778975724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=61PIxDHaLVS8bQ84kDyKhmHYzTQLMV8QWS1H3QMCKyQ=;
        b=LfhXvViGu8ldUfYqauUJVfuQZ9X3GCbsTYXz1hoI9+yVMKBtgyZhXwAue96DICeB6l
         CZzTG0lZxbCrwkQxzClk0zNQwcZv8WS5AGshljknIszMZWsuVkDchQy3H8tpf80jZf/a
         5likQTPJeIwbIJiBgIH6fCNd3Fjv197rFnBMwF1i+iaJhhoGfrCAtJq8gACE8GeKQlsz
         TtVjfaxGY34z4+X2Te6/zcC354yYjTR5w/thD2or9fjbh67k3xE2ytkTZtY638cvY5MD
         O0GtKUJAGx6wzq1Xz4jW86w78On4CoqL6LFOPVpnSVuPKOg0t2vkRX7Tm9/HiD4IT+/U
         pumw==
X-Forwarded-Encrypted: i=1; AFNElJ+vXPqrWJHJCjpxHDPP+gq/3GYy62fAGXuInJIQLpeMQkLbA+mFX0jOCIL4jNCOnkwKkL8LK+d/ZBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26i5BIDJmmpZbTvpcepDKU+VZ+Do25P8aq8KsXeXIDlc7Ht3l
	UCn/rdgxwSE7y5TysKyrORlQv31P1cAP6bd6EwtARJbS3j6kvTU6qDIOfqUOD/wjNrdeBOcVneI
	yGlboPi1u3vFRXsRTlMY5t/rD5UZDsWs=
X-Gm-Gg: Acq92OHYfW5nlyfemhZMtKIiu09PMUsa2eCMAYS08lqek5wfZvBxY28PCnC7EmcVtDO
	02DYCYvMKAxtp/tzkUM/EfR07xtx/btChrMAi2wSroybJhigLm/dVcJlvC39CkMiTSvOT/qIZiJ
	cz6wBmLKRu0qNsTEFtz1Ok4MvlcJnU1lHM1oVhwyr9lNE7L66ZIh7Ogp1f/5zXzM6JvFyWdt87v
	MMUxyrG9vCH8wb80EYeuWblm4Dm26l3pCIpLcikx/Ki1MPQN9YK2JiKreDt52WAxVtclu7UDbHB
	j2qBS4FSi8F4BgM=
X-Received: by 2002:a05:690e:4299:10b0:65c:6dbc:38fc with SMTP id
 956f58d0204a3-65c79891639mr15006281d50.6.1778370924602; Sat, 09 May 2026
 16:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509125201.29872-1-m32285159@gmail.com> <CALoEA-xo=0T43Nii5mNi+jwpXNgSf-3LVwO2Xy-0EMyQ227Zkg@mail.gmail.com>
In-Reply-To: <CALoEA-xo=0T43Nii5mNi+jwpXNgSf-3LVwO2Xy-0EMyQ227Zkg@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sat, 9 May 2026 18:55:13 -0500
X-Gm-Features: AVHnY4LD-QotS7DKZ7RlNqD-KedvyI9hPShjL02gnKvwRqcCPQbFfHojLBLKXW8
Message-ID: <CAKqfh0G_hWNPTLjhrEyG3KAVgsC01WWXk5u8t-H8iycSW3UyyQ@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: sps30: Replace manual locking with RAII locking
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: tduszyns@gmail.com, jic23@kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joshua,

On Sat, May 9, 2026 at 8:04=E2=80=AFAM Joshua Crofts <joshua.crofts1@gmail.=
com> wrote:
[snip]
>
> LGTM.
>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
>

David asked me to make some changes. Will I still be good to add your
rb or do you want to wait and see?

best regards,
max



> --
> Kind regards
>
> CJD
