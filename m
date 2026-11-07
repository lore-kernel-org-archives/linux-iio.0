Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794027956;
	b=aYqRtJ5LJEAeOzbiM3eJzoj/lC1iqOaECt/nRGUzAfVCXM5kfYqxmmh2DhZ1IiFeO4CB
	 JPhG8y9Qtz7gowSD2E4/hh5/S8pJWHmiFI47J1zcP/Vu2oCC6E7+xg4wxFUKobVRgAa49
	 +PQycFbeZPIpMhHt9A3cjcyfDQ+k+2b/J2th4dHbxCpZZDLcHhSgfjMlNzTijs2OfYRHt
	 s2z4zhpbJgoFPwGo4dmom+UWFHqmN2dxGtYEhZFPfp0tfVKE9m8nzNxcicfel8mtlodPb
	 muI8C5eyNAgvUoXSzosN013evtLh8jKzljQz5k0nKMTYTpr/MTNOnK4Q8LKqpJ+FRAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+3B/jiwJxW+xAIbQiYYm6bOuOVI/U/8kix0T1R+5+pM=;
	b=Ns2iQPyR5OUlmHiQMqxMXjWbJyawhbwMkeah9sbZCjxRP6i1P5TfI2mUeTAYnPBi+wpP
	 HDluQFKHz6mc2PjOMKw+vDjc/nHlrxQcWwtE5YCaG/5JCrFKgUTidZ5MbPTNvf0tk4AwR
	 JAf+B9rL7/DRnMODoils9/njz1MFIjCNjwJaF6red6oWbE7Wb1+lM7H1s6ucCnO+RAcnf
	 Lkq+4n8GZad5ANo4rTpwrbNUmTdl3d3J5WU1XafA098ss12GyD+9CaHPQcNvH4BaiUcSz
	 YnLOSrC/SPpQKzrRYBFuiULv/zOPdtYmM9M4FrscNSLwBik+3Pi4oAYfFycrM0imTtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YJcr5TsZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA8606A32C
	for <linux-iio@vger.kernel.org>; Sat,  7 Nov 2026 05:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CFA8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YJcr5TsZ
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3282db206d3so2877609eec.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 21:05:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794027955; cv=none;
        d=google.com; s=arc-20260327;
        b=gmtiALdWWkhqR22fscKFwWExE4rOzNJtK2JtN33794Ll6jeKkfDqd8YUPwsZCFOXkL
         IIqOYoFL7WlY//a5qMa7fPTVetvhjMAgYTEYrCjW+Hx4WVkGuenGJp31XX1QpIxxKyMK
         Cn6R2uhVD+DqAeE4cKw/Zo5P9v3pZSa2a8JXMbcEMWGDK+hZT1xU9muoMAHEafjblA0A
         LZPpFnxqu0ekEnRQJVg2MMGFotNehDDtt/IUsflmg20jEmlXaVwebgU/4woa66zXv40n
         b9DVdJsPtbw8VxUYeSMVnJpYTSlVO8Vi+m7GFMC0SYtIktMnXRxxd2T/de9x1YqrGtoE
         9Y8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+3B/jiwJxW+xAIbQiYYm6bOuOVI/U/8kix0T1R+5+pM=;
        fh=iosZeFsXgd0ZrI2DQS1zvZOW4/A1EOGUKWreQaOOb2Q=;
        b=kmQnsbsr5UxTjNG4jU0QzHoJx2t1VwNFsioTOGk/z9GqKZa2M3dzPDi6XqS0wRx5fD
         JAh22//TFVoUz9H+erMRvPxprAjzyJxszdcYw/vfNHKwF6rLbVTCGEH6RkPsmpa9WYFu
         rZgJPpFcAV98mLIFDO6CEkSjWYZxbLHBdfpO0+KXiraPGSLazMnxD/xiH92Lr+uy5hzp
         JZQWtnPzODC7IyH/dTkWilQR+VmvseUTnRd0A0I1hxe4BxgdkkBCLMV4kHYiegJ6fyH0
         MyOzVj+ba8LVhQCRv2pBY+w0StQJak4BlODKzjKZjs1n/8ACBc2kMMxkeHSmSrsW0+0S
         C6Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794027955; x=1794632755; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+3B/jiwJxW+xAIbQiYYm6bOuOVI/U/8kix0T1R+5+pM=;
        b=YJcr5TsZSqjKmrNme1j5Ss5AEK7ZrpRBvARDJHjFsECerF+1r12Ypi9REnQfQ7S8aF
         g9/RnnbNlZqeF7zaLQXfGlBpc3fpJgjwl60r1/Fmc1FJ3lPnBPdjQjF0rWOw3Dy70U8C
         yTNQFx1UOTyuq/qaDmzaGLe8C8DOI+vzQA47fZ91jl97910j4Csx+AqZgb3oxrJTwT/U
         3JfUM/NMbQuxRzzcbPI/wmc9QwSwy6x21DlZu6HGYR9G2K1yF9PqczMaeb3gJeTPJdH6
         1UlZLfjzffLZh8ZpAsSD4HuJB3p9mNDWsalkugWMo/LmcH3MUY28NYfJ7t/IjlG3cluk
         pySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794027955; x=1794632755;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3B/jiwJxW+xAIbQiYYm6bOuOVI/U/8kix0T1R+5+pM=;
        b=ExKoK9zZ/wWmD839eNLh4t3exdoywhv3VAdyDkFZ/wmJnSow41xq38GoweYt8itDEy
         LKNksiSo2V9Xm5x99JQuw7NGAdtznEFAqeHfcPYLXFHbImuxyDgN8+vlHCY3uIHcwPAc
         RmI3XWNBMXS1uycVjOA/OomMSLMZIHMudQNaoiMLXKZg/ZKBMtH4JA+rAbXBxBLXZp8X
         vrq41R9PthQbZx51Cb+tDxVvXAcmZjjiDg86gx2x1sCZ4qk6Cv9oDdewWFAOE+tkJ5eb
         Pl8rLaO0XdidGKzIyQmzDMqi10puI2I36NYKMjaEtBqqrAjlo8LSnbut4p4ryanG/wMz
         u0vA==
X-Forwarded-Encrypted: i=1; AL+hErFT1KglR1yt15pusQhv5fe2DsirBfpJci/XdnMPt1T8z4hbmDFU2MIkTHWK84/9Ca3+NSl+slRH870=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Y6fikmflgR3kCyCo4jN6dWYxC48Q3DJyNZU3oKxVbsKEpW3mO
	dQAPidYiJhy5Mi0mJtq3J6X4dFOORcuz5gRfQnggkxr5PKRDGs8Jt9eDw8tLe+7aVWCRIMMM6GL
	4h7GYHst+oNHv6ofPjCzv13vsZ0s91uQ=
X-Gm-Gg: AYBFou0m8AOTu1qLizK35a03GqsjgHRihpd3SUmg8GgFnVrbsr5kJxWL5cEp4ZJzOkh
	DdGOW5LFsjPoF/E6b3cWvUANWpGb/BLmdYXcWDRBE9EO7eOfeAnG3PdcH33RDIG1trWIsdg0HFO
	SuyCVIJ5bRfRXVJIcgFMDNwwSzJR4maDMFbhff09yNiIESHQLkjo9i/gQEChp6mx68d79diNHSM
	vIArTctIgkHc6Anqz/cyImt7hpwFK2zueVeV0xBcocXE/KMpTrPr51UlmSnFj2VvSPN2qayXuNc
	I0N69MjDL42raX2Oyko/Mbe2Zy7lUiXQRlaUB6sZnNlwNqfCg1Dle150dFS+my6cOL8kh86SCzj
	icA7wyc2Oq96mrWkIcT6NiAERX9wpBKg3IYk=
X-Received: by 2002:a05:693c:2581:b0:36e:8410:ecf6 with SMTP id
 5a478bee46e88-36f75440b61mr6095293eec.13.1794027954292; Fri, 06 Nov 2026
 21:05:54 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106174737.2580011-1-lcy8047@gmail.com> <20261107013159.7df2ab9f@jic23-hlaptop>
In-Reply-To: <20261107013159.7df2ab9f@jic23-hlaptop>
From: Changyul Lee <lcy8047@gmail.com>
Date: Sat, 7 Nov 2026 00:05:43 -0500
X-Gm-Features: AclHuK_TZI3zXzHPNwo-Hv6kt65IHQinw_K9egau9dqqkvu3RgUIkBwnYQIoXcI
Message-ID: <CAKefsHsnxGZttZ9rJGehiUX3PCSWyxFevExefkCc3mkg+FGaqw@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: free the trigger ID after device_del()
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Nov 2026 01:31:59 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> > -   ida_free(&iio_trigger_ida, trig_info->id);
> > -   /* Possible issue in here */
> This made me wonder - what is that on about?  I checked
> the history and all the code on either side of that comment has
> changed since it was added.  So who knows! :)

Thanks for applying :)

The code around the comment kept changing, but the ID was always
freed before the device was removed. I guessed that was the issue it
meant, so I dropped the comment once the order was fixed.

Thanks,
Changyul

2026=EB=85=84 11=EC=9B=94 6=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 8:32, J=
onathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri,  6 Nov 2026 12:47:37 -0500
> Changyul Lee <lcy8047@gmail.com> wrote:
>
> > iio_trigger_unregister() returns the trigger ID to iio_trigger_ida
> > before device_del() removes the "trigger<N>" device. A trigger
> > registered in between can get the same ID, and its device_add() fails:
> >
> >   sysfs: cannot create duplicate filename '/bus/iio/devices/trigger0'
> >
> > For example, adding a sysfs trigger while an hrtimer trigger is being
> > removed through configfs, or the other way around, hits this because th=
e
> > two paths do not share a lock.
> >
> > Free the ID after device_del(), as the error path of
> > iio_trigger_register() already does, and drop the "Possible issue in
> > here" comment.
> >
> > Fixes: 1637db44413e ("Staging: IIO: Trigger support added to core.")
> > Signed-off-by: Changyul Lee <lcy8047@gmail.com>
> Nice find. Applied to the fixes-togreg branch of iio.git.
>
> One passing comment below given you also deleted a very 'odd'
> comment!
>
>
> > ---
> > Found with a static analysis tool we are developing.
> >
> > Reproduced in QEMU (x86_64) with two threads running for 20 seconds.
> > One writes to add_trigger and remove_trigger of iio_sysfs_trigger, the
> > other creates and removes an hrtimer trigger in configfs. Without this
> > patch, device_add() failed with the error above 160 to 1148 times per
> > run in three runs. With it, it never failed.
> >
> >  drivers/iio/industrialio-trigger.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industria=
lio-trigger.c
> > index 76926fee0f84..206ede2c9b3c 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -105,9 +105,8 @@ void iio_trigger_unregister(struct iio_trigger *tri=
g_info)
> >       scoped_guard(mutex, &iio_trigger_list_lock)
> >               list_del(&trig_info->list);
> >
> > -     ida_free(&iio_trigger_ida, trig_info->id);
> > -     /* Possible issue in here */
> This made me wonder - what is that on about?  I checked
> the history and all the code on either side of that comment has
> changed since it was added.  So who knows! :)
>
>
> >       device_del(&trig_info->dev);
> > +     ida_free(&iio_trigger_ida, trig_info->id);
> >  }
> >  EXPORT_SYMBOL(iio_trigger_unregister);
> >
> >
> > base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
>
