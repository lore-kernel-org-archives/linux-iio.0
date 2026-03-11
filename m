Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9234752B
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 05:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773207785; cv=pass; b=reGdrjb73HjcztZDnkLL3QJHXX8Yt2rNsjR9aYtnjVjCGLWmLRymTl6A0Wt6jVUajIr2jJe1JjYaJlnv06K2UffYP+r/0C7+YzbfbxjwmJ8oJOIAZCXDHhzuk8lO3ftKLkELepdIfvEeteYIv1T2XVN0FTEcFVyN0ocTxotZYGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773207785; c=relaxed/simple;
	bh=j7GPyZUOKWPd6Eb1FHA6D0wCDgNjFxXANFaMP57pH6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsr7008lFcfxb/fpL8Eis0F4Oq1dKgiYTKMr7v6aUz62qHgXFwh3+HZU28PCASyX5Ly70AHtXwirb4oqSQA68EQvckTN5cUlwpSWzRO+YLASuPDLSWvti/A4ITUd/csQzwjya8rv3iTtfeVpRVWu3UDJp99F1GXMpGAVadJ8nKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fc9Y/gi8; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc9Y/gi8"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c73a5473bbdso1428561a12.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 22:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773207780; cv=none;
        d=google.com; s=arc-20240605;
        b=hpsNzGV7NnBI9RiL7GXPHKFKf6Bbbzl2XhNcEGP2Y3f4qtrkajcHo52/Sz/uq8d/6e
         Ywu2WH4OKsdEhUqFJJ/JDEKNbqvsd2Zaen8LYWkFS2BsEfGPAKu8WbpMh3cCigeDxEsV
         DGf2mNRw7QyVvR3LdSotdyAqWEghCqbNle7WX9TNUbxtNtqr3Vye3PygBnM6kDIQAe85
         xObel/kVYKzPF6sBYP+yERaJib9HfDQQ5cChAI/49nKM9q32eDgDC6GQXi1O+jdgYZsv
         uDl5RlSpUqnvqT4dclmkF0O4iqDcDVE72iMcyDv9uLHDE7REdVS7TF3Au39Z2VjQkEB3
         Nr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HsZ0aj30QzrWxLy9ik/IeJVQ3KkElzxj0uQiMmN5kNQ=;
        fh=qRdea3TclTpjvG/7rFd6KTfxJBpZTxsv+Un7YtHKvH4=;
        b=CQ9Ibccwmy/Zp4etg2P7+RDuE1jhKVSgoXBen1waa7MX25McfkOGHH8y2y+GNrBvH9
         up9MSMtyiVxkxI9qcnlZwyFYgEDVXiHWae6cNKQzluBjMLi77eXeLlySviv6km7i2R6r
         deE4co/YsHg5z9/gGrrxPJqYK36Jqyane+wzmwFbSxPug36whKs/R7/aJKc6GgCIOyHY
         yScejRkG5wu9EmiH51eUdBbq5CsIOgh/secMxHhGTeokfFeSDqRi3l+o/qhPJhH8HeFF
         Dx28vbRdwMXPiDBTQXv3NIN/KgEfnxmf0vggFoO5GcW8/t6O6O4ZkVeKqRLUfPNplVLU
         wanw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773207780; x=1773812580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsZ0aj30QzrWxLy9ik/IeJVQ3KkElzxj0uQiMmN5kNQ=;
        b=Fc9Y/gi8h0IRJqbzu7rWmHZPhR0danXRKTqZ4Vp9nYMsd3/XoHh0jp1UnTgITpvYJf
         e5T5nR6kq5ZTSgHtpKTuzxYNH5JAHA2KbT9Y9oXAZQpJYebC5P8w9BUWJzLqRIQCKzBG
         1Tfc56uaF6EqYJ7KMYtMorUZ172ncyZaswvfg4FOP3xH3Uaj67UshLib+Y22Trbf32C1
         +1hlhkuwd9p2hz/TBG42/kJ2zo8tDWphAGyCdo00nNd8oEJda6MrQ8iSMElMM4xBRO3+
         Ouz0He3U3b89ngArRnTIjtwRjxn3hwZ420SF7krDkuB4oKIIZaauHEHNVZY+I56CJQEe
         zEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773207780; x=1773812580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HsZ0aj30QzrWxLy9ik/IeJVQ3KkElzxj0uQiMmN5kNQ=;
        b=tGCu3M7YlGO0qfFc8fcl7/Q+HMJ6n6iaEayqZMMF+H/AQxp6qxEwzpCgf6WcuW+ZxV
         0GSAqvZUzlR05pkpqju8XuDENIpGL2ePvOS9C0s6EQgqr3qfCWJq/1jdynr0Lm07wI3Y
         dUsenib4JWJKzn1AuLReLYZv42kjjiE1Xaugc7pK8qDsXsl2QakVRE4g+Hp5UcUOQjgr
         Ih3zjV+MPyuf+pfYYaubdsXMXtgcixcEj9iiKG9zvOHal+CMoovts73urXC/Jc7DZj0G
         Wr39cC8mpliK9A1z9C/EY1ZQ5mMtTHbhcULVkKa8107Mt3eg+VydYdf5CGWj1h74IyQW
         zyBg==
X-Forwarded-Encrypted: i=1; AJvYcCVHoCLT95FQayyVSLWYEeJRWIIG7DIJ5lmKfCoHsBAidY6eEyrP+oKWhoacfAjaX0Pvx1CmCbSzAOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzui4U5FkkF+WqMYN2GWqlXXB3dNcEviE8PbXzUKhB8QF0vwB15
	lBoWQTdVhpxcfaUphYiSM6VKMVg/+5Eic4eUW9i9nc1c40E4xWfl8eTMTpIV+3h+bUu5pyJMM5Y
	YWVtVHkhSeKyrJFgYIxpU/pvtC52o1Q==
X-Gm-Gg: ATEYQzzdZwCm1LvQduEyuwsEc/Ejmyk+Nc1o1uoc0QhilHfkeGU6c9iYp9SOTzRsQSX
	2aGGN50JRZIH8ox2tyEdOQxdKAz4pDnRVOpfqnio7UWiUnqNwxlq2uYDhus2bVPDbO3+Dsj6P5n
	POK0iKsS6E22rxP129uVrl/5DyI+MNX7l6MRfYrav6gZ2A5b1rYrfUSFkj7GdR9TVhzW6fhWKfT
	gPqOzXvNjypHYlICS1tNnD7/3Eci5v1Am7shLfzJXlxWbvNv+rjWo8fELfT3evFl1oMIsbB5kjD
	vSvyOEwPo2329ete3P2YHMhO4talDHF4BWv/eB05BTPwoj6UiXypYRGLT/geIOW/onbD
X-Received: by 2002:a05:6a21:458f:b0:398:791a:9caa with SMTP id
 adf61e73a8af0-398c5ec806amr1236794637.18.1773207780121; Tue, 10 Mar 2026
 22:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310200513.2162018-1-sanjayembedded@gmail.com>
In-Reply-To: <20260310200513.2162018-1-sanjayembedded@gmail.com>
From: Luka Gejak <lukagejak5@gmail.com>
Date: Wed, 11 Mar 2026 06:42:48 +0100
X-Gm-Features: AaiRm53yOPVigtTBWqUrHQSRYbaimfIQ_tKWwOGhPWuEPWqnKrEs0Ob5KWiVmFM
Message-ID: <CADRnA90=F5rRtWWJtSg7mA_QLzQa5Fzh3s2RzXDJtOOTiitzrQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] drivers: Simplify cleanup paths using __free
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, m.tretter@pengutronix.de, mchehab@kernel.org, 
	p.zabel@pengutronix.de, tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com, 
	yunfei.dong@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, johan@kernel.org, elder@kernel.org, 
	gregkh@linuxfoundation.org, pure.logic@nexus-software.ie, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	kernel@pengutronix.de, kees@kernel.org, nabijaczleweli@nabijaczleweli.xyz, 
	marcelo.schmitt1@gmail.com, maudspierings@gocontroll.com, 
	hverkuil+cisco@kernel.org, ribalda@chromium.org, straube.linux@gmail.com, 
	dan.carpenter@linaro.org, ethantidmore06@gmail.com, 
	samasth.norway.ananda@oracle.com, karanja99erick@gmail.com, 
	s9430939@naver.com, tglx@kernel.org, mingo@kernel.org, 
	sun.jian.kdev@gmail.com, weibu@redadmin.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Sanjay,
Would you mind explaining why you put so many people into TO and CC
fields when sending patch series. You should stick to maintainers and
reviewers from maintainers file as others can still see it on the
mailing list(that's why you CC kernel mailing.list related emails).
Sincerely Luka Gejak
P.S. If you are including me in further discussions or patch series
please use luka.gejak@linux.dev instead of lukagejak5@gmail.com.
Thanks in advance.

On Tue, Mar 10, 2026 at 9:05=E2=80=AFPM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
>
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
> Hi all,
>
> This patch series replaces manual cleanup and explicit kfree() calls with
> the __free attribute from <linux/cleanup.h>. This modernizes the memory
> management style and simplifies common error paths without altering any
> functional behavior.
>
> The __free attribute provides automatic scope-based cleanup, making
> resource management clearer and reducing the chances of missing cleanup
> on early returns.
>
> No functional changes are intended in this series.
>
> Testing:
>   - Compiled with W=3D1
>   - Build-tested on i86_64
>
> Based on:
>   <linux-v7.0-rc2>
>
> Feel free to share your valuable input in context of the cleanup API.
>
> Thanks,
> Sanjay Chitroda
>
> Sanjay Chitroda (7):
>   staging: greybus: simplify cleanup using __free
>   iio: ssp_sensors: simplify cleanup using __free
>   iio: st_sensors: simplify cleanup using __free
>   media: mediatek: vcodec: simplify cleanup using __free
>   media: chips-media: coda: simplify cleanup using __free
>   media: allegro: simplify cleanup using __free
>   staging: rtl8723bs: simplify cleanup using __free
>
>  drivers/iio/common/ssp_sensors/ssp_spi.c      |  9 +-
>  .../iio/common/st_sensors/st_sensors_core.c   |  7 +-
>  .../media/platform/allegro-dvt/allegro-core.c | 95 +++++--------------
>  .../platform/chips-media/coda/coda-bit.c      |  4 +-
>  .../platform/chips-media/coda/coda-jpeg.c     | 39 ++++----
>  .../mediatek/vcodec/common/mtk_vcodec_dbgfs.c |  3 +-
>  drivers/staging/greybus/camera.c              | 27 ++----
>  drivers/staging/greybus/loopback.c            | 35 +++-----
>  drivers/staging/greybus/raw.c                 |  6 +-
>  .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 13 +--
>  drivers/staging/rtl8723bs/hal/sdio_ops.c      | 37 ++------
>  11 files changed, 78 insertions(+), 197 deletions(-)
>
> --
> 2.34.1
>
