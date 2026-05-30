Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C31368D41
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 12:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780143209; cv=pass; b=GiSU8LNAcEj6sRQ1p4WVufmGe8sWsvtxrtE+KAlZSdvrDH7+9ic4iXSNmTQw+8L/R56aMBuYHlozBB9dxn0jwvOZYs0USE2q5hVKis5/psT2sPCApZM4n+tfw+Pvd27hcBaeLlALVLGfB36tWqcXk93Mi6RucbaP8vjYS+HSNx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780143209; c=relaxed/simple;
	bh=Zcqq4uNc5P/uQsQGgioaxUxbxELyjmsfBqYi3m/Vfvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyfS5/O3lHZqTAse5OK+t1WyZ19sU6MJ338cy2w1dnOcMaytRDao3XFFR6ZVxjWK7HkX4fTj/zK7lqqw2n7PaGW3h9OnchD7+2oyfoeNnwOBkYzRO8WqUTX1LLvf4u9zRVIh+BrT66RucUF2M+eDdDyIu99gdarxfYGIbihXYxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qD33Myj9; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qD33Myj9"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68852a4fc68so12903401a12.3
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 05:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780143206; cv=none;
        d=google.com; s=arc-20240605;
        b=Cvnh/z1sh2II7KkTMrTcTdrDXENa4CbaVSV4hEKjAIN1Fj/SvLFzNkyJQ1oW/uO1J0
         ZadggdrRSr7IIOHYkW9pbnxAgcvxXDQfXBIzbn1awhWid+8JLGEwmENpaWdBuGXhbsux
         oXu4kMMJQuAIzSymoe0U1T51MYSCEcCG7quVkm9w37vkG2UE1kqi4JrN3x8pZ0U32JNQ
         NIN0tviKwUJIPvy0sQlbJUOeRT+/db+nPxUSKmkn2Q0Rt8aFSDfVYX4YD+3DY3eIJBbm
         qot5kOKqttOYjsHYGunyVWLGDf9QfkcKwkPM61S06r+alFDsH1EbavnEVVz50dd3FY0E
         Fh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xrduNo3l5STIDhpgC7F3W2pVEkONkM5OKWj5qR5aWhQ=;
        fh=kas4J1RRK2tNvOfI3bCsPrsZd0HBasQ/eGHmR1cOV6c=;
        b=G9kQSld2CXJMQW4RhBpWYEmlY3KXFOTxLny8oYkbT8fJ7rfvgd+Xu1CeUeiZZWFouK
         fjbdyRvzbEeksHLFXlhj1hwggGzeYE2+UU6ljSQ5KwJr+oiKkdx4PyqGDUxO7Ccos7To
         6pdoQx+Rj6LVZ/MCRV36Sl8jEI97bZrKczwplf4ctajAnWZl1cVoTRvpy4T3mndF0bB+
         Ss29gc33Jk10n8orTBLrSpU+MlDW5pDQnzGv+49pI046IiSVfQpEhSGl+D9VcI//kNc7
         QniQZ4DFljI1L945YZH3gwA5trN/L8gEi6D2EUrNAITMlELHjeK1/W2buK2KguRX8bJj
         SWnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780143206; x=1780748006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrduNo3l5STIDhpgC7F3W2pVEkONkM5OKWj5qR5aWhQ=;
        b=qD33Myj9WcbSh0G8Y5O1DNqwtUhvGzogecaLLqnOe0H6TH1HIKAbJDm7yuTf0IW3x0
         gGz5k7WYBysJDiB/uKnMN6g9zOEbN/qdXrIuoepRvU9ioxxYQfahdHuXAvI+if3HzZuz
         GcpNPVsNpl3gsCh635XiB871C42p3iicZDCCmSUkUiwzvEB5ss4prc3uHe5lqdohMTG9
         uVKkU46qp3wbJdRxSRFNLHK62j3O0mtJlrHuvtL/pwfrR0tmUGPrsEbTC/m9f6hUnSdZ
         fn/fuGFLUekuTvjcqZoPtT1eqCD8rZOL6hiRsJCEk+mQucdJ5yk1aODMXXj2UayhPhQe
         cWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780143206; x=1780748006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xrduNo3l5STIDhpgC7F3W2pVEkONkM5OKWj5qR5aWhQ=;
        b=KYGc+fwZ7h0I3OEsoikcnLrD4UhoJs/ADapNL66riv2L8Y0UDs6x9YWDsswy2ugieK
         77j/h8WKog/i1pOo6MIOUSOIciTiZ/7YObiOWeb/MvhHLbhgYsbYvCBui6w/MptCtB3h
         xOwUGysu8CdCC3/yGRfz41QTgRkyNfzMAPehuOzQcVEiEo1NixULA2WuZe6Et9jDcOkR
         x5LpNxD/A8TpjflpHzkZDcTeNzxOnlmJijSHVyYtK5qcUPLxCXMBdqc0gx/HGSH+vvAe
         ocgmczXcan+a01mQ5NP0Q0hcf1eNrzvCacSwZR3p8PW7Kbuym9ZenI+w2RI/+63yVClK
         rbSA==
X-Forwarded-Encrypted: i=1; AFNElJ/e78aGZzEsYvHZFWMTRylqq+3mBre2mUHWNLJ+TkrSgKmJEMEETdZLwaEyYojiQtMGf6DOP6qT62o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLcWmfhBPDuFsYJr6cJRLnCQ26Jfiro/TPRLZf9I1tWFfhcc8Z
	WsMSNJlTIAmKD0QIT05w0ydFlchAIeUmYuNf7QDczwL7lElMEzk0jlTZ6Wp1pLTrYr1eS1uonWk
	bxXWUcw0GZimTBX6EXlHmpZ7rKEaCJdE=
X-Gm-Gg: Acq92OGL6dOS21djg5vm4fpR6FchQ2zfIe9Kl9Mm6DS/75RRE53MDZm6s0P4wXb/0xM
	aSiVRbDrnsKneniMOjXNuVGJSzu2VXlGFxUicr1wKtt0XBvIviSlhuCli/+4Ibq/N33IS/f2xC2
	M7azdoRq/pMlnxlkIdBXk378gryWX0c/IvGyasnaECiqX9kwNPgqqmq0e5wMMi/4mXBRCCYgcb8
	VxonDRTT/Z90dBogmerG5iO/yeKQ8LvCATJksDTmmUqx+MDwmDdlca1EhthoQUpkGONN6cl/EaU
	EjRZ94tbxtTpmUNovN8ql4FfQ30BLxQUHwBDIHYKX6t0/RnpoAZ1QMNlgt98n91gWvWw5hLqRkM
	FlaorsEtd7a4E3k6uGCkEPnVPbdGKqlawesgH7gGzrN/4NDyc38lN4bIHUiWn8WrpmlfNHixpW0
	XCUxkhCMk8pkBL0ao=
X-Received: by 2002:a17:906:5a49:b0:be2:7ee3:fabb with SMTP id
 a640c23a62f3a-beab3846422mr117941666b.41.1780143206144; Sat, 30 May 2026
 05:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530113938.171540-1-suunj1331@gmail.com> <20260530113938.171540-2-suunj1331@gmail.com>
In-Reply-To: <20260530113938.171540-2-suunj1331@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 May 2026 14:12:49 +0200
X-Gm-Features: AVHnY4JaMDgf3QYl2WlxP_Brp-ClFJIuceIE2pF_w-vCIceUytgSPvaHhuC8coc
Message-ID: <CAHp75Vfd_eRRgnCpXsa0CVQ56f85YwQQRTj70MfmB4prVygYGg@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: pressure: mpl3115: convert probe to fully devm managed
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, apokusinski01@gmail.com, 
	me@brighamcampbell.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 1:40=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> Convert probe to use devm-managed resource allocation,
> removing the need for an explicit remove callback.
>
> Replace iio_triggered_buffer_setup() and
> iio_device_register() with their devm equivalents.
> Register a devm action to return the device to standby,
> replacing the cleanup previously performed in
> mpl3115_remove().
>
> Move mpl3115_standby() and suspend/resume helpers above
> probe to satisfy declaration ordering requirements.
>
> No functional change.

...

> +static int mpl3115_suspend(struct device *dev)
> +{
> +       struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(de=
v));

What's wrong with dev_get_drvdata() ?

> +       return mpl3115_standby(iio_priv(indio_dev));
> +}
> +
> +static int mpl3115_resume(struct device *dev)
> +{
> +       struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(de=
v));

Ditto.

> +       struct mpl3115_data *data =3D iio_priv(indio_dev);
> +
> +       return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> +                                        data->ctrl_reg1);
> +}

...

You forgot about mutex_init().

> -       ret =3D mpl3115_trigger_probe(data, indio_dev);
> +       ret =3D devm_add_action_or_reset(&client->dev, mpl3115_standby_ac=
tion,
> +                                      data);

Add

  struct device *dev =3D &client->dev;

to the top of the function to make this shorter and easier to read.

>         if (ret)
>                 return ret;

...

> -static int mpl3115_standby(struct mpl3115_data *data)
> -{
> -       return i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> -               data->ctrl_reg1 & ~MPL3115_CTRL1_ACTIVE);
> -}

Split moving of this function to a separate prerequisite patch.

...

> -static int mpl3115_suspend(struct device *dev)

> -static int mpl3115_resume(struct device *dev)

Why did you touch these two?


--=20
With Best Regards,
Andy Shevchenko
