Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:33004 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab1HZWmv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 18:42:51 -0400
Received: from hpaq2.eem.corp.google.com (hpaq2.eem.corp.google.com [172.25.149.2])
	by smtp-out.google.com with ESMTP id p7QMgopm026210
	for <linux-iio@vger.kernel.org>; Fri, 26 Aug 2011 15:42:51 -0700
Received: from yie16 (yie16.prod.google.com [10.243.66.16])
	by hpaq2.eem.corp.google.com with ESMTP id p7QMfYub021777
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 26 Aug 2011 15:42:49 -0700
Received: by yie16 with SMTP id 16so2479517yie.29
        for <linux-iio@vger.kernel.org>; Fri, 26 Aug 2011 15:42:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110826221817.GI3775@shale.localdomain>
References: <20110826011542.GK5975@shale.localdomain>
	<CANEJEGtys_kBMMPstRahrYq956g22ZgowySxvOCqUpHww6x29w@mail.gmail.com>
	<20110826221817.GI3775@shale.localdomain>
Date: Fri, 26 Aug 2011 15:42:48 -0700
Message-ID: <CANEJEGvzc5zVSnKUepmtjG3uYWqm3nP08ZUsVbUeDQEVv3zG4Q@mail.gmail.com>
Subject: Re: STAGING:iio:light: fix ISL29018 init to handle brownout
From: Grant Grundler <grundler@google.com>
To: Dan Carpenter <error27@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 26, 2011 at 3:18 PM, Dan Carpenter <error27@gmail.com> wrot=
e:
> It looks good to me, but I don't know anything about the iio code.
> Jonathan will let you know if there is a problem. =C2=A0:)

I'm hoping so. :)  Thanks for reviewing.

>
> This is minor thing, but checkpatch complains that:
> +#define ISL29018_MAX_REGS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ISL29018_REG_ADD_DATA_MSB+1
> should be written as:
> +#define ISL29018_MAX_REGS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(ISL29018_REG_ADD_DATA_MSB + 1)

ah...I didn't run check_patch. /o\
I'll include that in the version I send to gregkh.

cheers,
grant
