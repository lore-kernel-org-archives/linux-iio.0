Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B535944AB6A
	for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784668720; cv=none; b=JXeQcg+X5xpl125FsYWsqYiuNHop2Pomb2IKxMj6AZGvtdZ6WQBvqNDYhEnVJ5LWJziWxgdDR4HmzT4URtq9RCvP2tHNdIVv4gQ/JcMltsiT9gN73+3yA1MMUTntUV7YhBy5/IEr5VWPUt9jg7IKaeD4adufiBZRoM/5bP24ro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784668720; c=relaxed/simple;
	bh=K2GjvQba52NA6d2A+Y1kzcm2Pst5W72QeNwU26heDCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giSfbMcvsW5MryQxp6HL+q9ZIZnpUE8s836oJhB/DBVoX+wxyMkXvZ1oRtHVol63JS79gdhqPHC3rReQvdGP7FQ+rwoC5Y+tUkMhPnRndBhc1300YyTg0UMkHCIoeq1FkKGLASjfruRn7LUmKtPU5bQ3VcBdnunwRPt4b+E5+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=rPfxhsgc; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ppq77VZE; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="rPfxhsgc";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ppq77VZE"
DKIM-Signature: a=rsa-sha256; b=rPfxhsgcLmx7/08QouhWDmxNFaQ6ihMqk8fflzc0wJtADgRdo4TNrCVewsG5T/XlOCAQfeZUv1BLxMQIQUM1zVkLUZTFmH79sX1F9E7RG6q6JZ5cGM49aTyqQwhWYYOXxXPw1RMqiS62dTJO2TdFGoOCVO9Ko1gzCiJzMKhX/bxmhi2imbm7QC/joUL3hMGKbvgoUA3Jmw1furg18ryoWYwUHWd1jGuPMCMubUWi/v3FL9qJixxxOaV+4xMkIelTGQHXyC+mVEQs9yU/g5WkvDLHJWikdiuuenccbEn0Xe3rWVeon/JL3m8+abL3BnpNpqGOlbjM4u4grqWDPO/nAg==; s=purelymail2; d=maxwelld.cc; v=1; bh=K2GjvQba52NA6d2A+Y1kzcm2Pst5W72QeNwU26heDCQ=; h=Received:Received:From:Date:Subject:To;
DKIM-Signature: a=rsa-sha256; b=ppq77VZEdh/B1AAJaoRGgYx0ddaHbKQHxPkmTPOfIz0fCSv8qUDeBHmErPtXg8EgP4zYZRu0xAHorxmMPHNIEUHGVlaDAaGYO1ktEzu9Oa3CfuNrE49xEWs8if98xRD66Gv5wpfFFaa5gFxV5VkWQOjb2n1XOZksFswRE2d5zkunbOqW+3P0JjfxO6Bgz6UmR1yiZWfQV2JZvCyJfMYA4gbJurHYVxPr48BYMs/Xdxx4iy0wmJspX824t0R/Yj9CIJkFcv3OzF/j2bzxNeifUWRkuSst6NbUuaNp3XnGkmIJysGFudafbjySFYiuYmvwJ/+IZZnJH3FfgFdxVt+puQ==; s=purelymail2; d=purelymail.com; v=1; bh=K2GjvQba52NA6d2A+Y1kzcm2Pst5W72QeNwU26heDCQ=; h=Feedback-ID:Received:Received:From:Date:Subject:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 871040083
          for <linux-iio@vger.kernel.org>
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 21 Jul 2026 21:18:27 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6688a2dceb8so526093d50.3
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 14:18:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpmmRsIyIHJxCvj6o4Dw2r/upv4KVHSyh0HkTm6UC5cFEQXd6AA1+h4sPsWUVmw3DNxW+VervBKe04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/CZvbvDh8SFQXeZnkagMi2HbS0Dq3FIAdOGu7aodQ5R5TsI6
	znZsfkuW23REktx0Idd+nveJQ63H8JeHrBV8C2gM4u37Qi39esUQVARGbFsnMvI5WGI6aVJijQI
	F2vSUj56owSYOa8SWjDtx4zrqzjBRoqU=
X-Received: by 2002:a05:690e:4385:b0:668:90cd:8aef with SMTP id
 956f58d0204a3-66890cd8e3dmr100821d50.25.1784668707303; Tue, 21 Jul 2026
 14:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721150314.24545-1-siratul.islam@linux.dev> <al_bUWguna_K1n7X@ashevche-desk.local>
In-Reply-To: <al_bUWguna_K1n7X@ashevche-desk.local>
From: Maxwell Doose <maxwell@maxwelld.cc>
Date: Tue, 21 Jul 2026 17:19:24 -0400
X-Gmail-Original-Message-ID: <CAKqfh0Fmmn5z837OR-FkH_v7BHL2DuXvnQs+1RSO4Qpg14YoOQ@mail.gmail.com>
X-Gm-Features: AUfX_my8kziqfW3OWdO2QNjWGjzWJ0jSNgBiYeqk5Ko6MzvglsscdkpRB8XZhU4
Message-ID: <CAKqfh0Fmmn5z837OR-FkH_v7BHL2DuXvnQs+1RSO4Qpg14YoOQ@mail.gmail.com>
Subject: Re: [PATCH] iio: update email for Siratul Islam
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Siratul Islam <siratul.islam@linux.dev>, Song Qiang <songqiang1304521@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 4:58=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Jul 21, 2026 at 09:03:08PM +0600, Siratul Islam wrote:
> > Change personal email to the Linux specific one,
> > to have a single and focused point of interaction.
>
> ...
>
> >  .mailmap                                                      | 1 +
> >  .../devicetree/bindings/iio/proximity/st,vl53l0x.yaml         | 2 +-
> >  MAINTAINERS                                                   | 2 +-
> >  drivers/iio/proximity/vl53l1x-i2c.c                           | 4 ++--
>
> Shouldn't DT patch be separated?
>

Probably but as long as a DT maintainer acks it it should probably be fine.

--=20
best regards,
max
