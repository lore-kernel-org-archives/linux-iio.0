Return-Path: <xiyou.wangcong@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANFwon20C9NC6GmWnwfSHcWOSFe-7fdt_QbCQQNhegieNeDUNA@mail.gmail.com>
References: <CANFwon20C9NC6GmWnwfSHcWOSFe-7fdt_QbCQQNhegieNeDUNA@mail.gmail.com>
Date: Sat, 26 Nov 2011 16:52:09 +0800
Message-ID: <CAM_iQpVzASSdfJ0aibkUgx7gjwb7RxLv-ngVuPg4NXJuN1DLHA@mail.gmail.com>
Subject: Re: [PATCH] fix build error of function iio_event_getfd
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Hui Zhu <teawater@gmail.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Hennerich <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Nov 26, 2011 at 4:07 PM, Hui Zhu <teawater@gmail.com> wrote:
> Got a build error:
> =C2=A0CC [M] =C2=A0drivers/staging/iio/industrialio-core.o
> /home/teawater/kernel2/linux/drivers/staging/iio/industrialio-core.c:
> In function =E2=80=98iio_event_getfd=E2=80=99:
> /home/teawater/kernel2/linux/drivers/staging/iio/industrialio-core.c:262:=
32:
> error: =E2=80=98ev_int=E2=80=99 undeclared (first use in this function)
> /home/teawater/kernel2/linux/drivers/staging/iio/industrialio-core.c:262:=
32:
> note: each undeclared identifier is reported only once for each
> function it appears in
> Not sure it is fixed or not.

It is fixed twice...

https://lkml.org/lkml/2011/11/25/52
https://lkml.org/lkml/2011/11/23/114
