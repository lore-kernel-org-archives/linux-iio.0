Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:26215 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab1HZF1J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 01:27:09 -0400
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com [172.25.149.6])
	by smtp-out.google.com with ESMTP id p7Q5R8uY006482
	for <linux-iio@vger.kernel.org>; Thu, 25 Aug 2011 22:27:08 -0700
Received: from gwj17 (gwj17.prod.google.com [10.200.10.17])
	by hpaq6.eem.corp.google.com with ESMTP id p7Q5R31k029140
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 25 Aug 2011 22:27:07 -0700
Received: by gwj17 with SMTP id 17so2529428gwj.38
        for <linux-iio@vger.kernel.org>; Thu, 25 Aug 2011 22:27:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110826011542.GK5975@shale.localdomain>
References: <20110826011542.GK5975@shale.localdomain>
Date: Thu, 25 Aug 2011 22:27:06 -0700
Message-ID: <CANEJEGsj8_crCzVT7tX6yREO4BJVAcWTPgxxUY=jpU8Z+yZAew@mail.gmail.com>
Subject: Re: STAGING:iio:light: fix ISL29018 init to handle brownout
From: Grant Grundler <grundler@google.com>
To: Dan Carpenter <error27@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 25, 2011 at 6:15 PM, Dan Carpenter <error27@gmail.com> wrot=
e:
> Hi Grant,
>
> There is a memory corruption bug in 176f9f29cec9 "STAGING:iio:light:
> fix ISL29018 init to handle brownout".
>
> In isl29018_chip_init() we call:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D isl29018_write_data(client, ISL=
29018_REG_TEST, 0,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ISL29018_TEST_MASK, ISL29018_=
TEST_SHIFT);
>
> where ISL29018_REG_TEST is 8.
>
> In isl29018_write_data() it uses reg (ISL29018_REG_TEST) as the
> offset into the ->reg_cache[] array:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0chip->reg_cache[reg] =3D regval;
>
> But ->reg_cache[] only has 3 elements, so we're past the end of the
> array.

Wow! Thanks! I'll look at the code in the morning and suggest a fix.


> I don't know the code well enough to fix this.

No problem - I'm happy you spotted this.

My initial suggestion for a fix is to just not reference reg_cache if
"reg" exceeds the size of reg_cache. In other words, don't cache those
values. This should normally work well since we don't other touch that
register in the driver AFAICT.  But I'll review the code some more
tomorrow before submitting a fix.

cheers,
grant

>
> regards,
> dan carpenter
>
