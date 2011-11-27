Return-Path: <teawater@gmail.com>
MIME-Version: 1.0
In-Reply-To: <a3c3695e-8a13-4e44-9660-0df049d86003@email.android.com>
References: <CANFwon20C9NC6GmWnwfSHcWOSFe-7fdt_QbCQQNhegieNeDUNA@mail.gmail.com>
 <a3c3695e-8a13-4e44-9660-0df049d86003@email.android.com>
From: Hui Zhu <teawater@gmail.com>
Date: Sun, 27 Nov 2011 15:01:26 +0800
Message-ID: <CANFwon0z7XBqhqmB0XT5fJPfYexmBXw0rYUtem5AEmR+xBkh1Q@mail.gmail.com>
Subject: Re: [PATCH] fix build error of function iio_event_getfd
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, Amerigo Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On Sat, Nov 26, 2011 at 17:19, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> Thanks but this is 7th fix I have seen.

Cool! I am in the top 10.  :)

Sorry for disturb you.

Thanks,
Hui

>
> Hui Zhu <teawater@gmail.com> wrote:
>
>>Got a build error:
>> =A0CC [M] =A0drivers/staging/iio/industrialio-core.o
>>/home/teawater/kernel2/linux/drivers/staging/iio/industrialio-core.c:
>>In function =91iio_event_getfd=92:
>>/home/teawater/kernel2/linux/drivers/staging/iio/industrialio-core.c:262:=
32:
>>error: =91ev_int=92 undeclared (first use in this function)
>>/home/teawater/kernel2/linux/drivers/staging/iio/industrialio-core.c:262:=
32:
>>note: each undeclared identifier is reported only once for each
>>function it appears in
>>Not sure it is fixed or not.
>>Post a patch for it.
>>
>>Signed-off-by: Hui Zhu <teawater@gmail.com>
>>---
>> drivers/staging/iio/industrialio-core.c | =A0 =A01 +
>> 1 file changed, 1 insertion(+)
>>
>>--- a/drivers/staging/iio/industrialio-core.c
>>+++ b/drivers/staging/iio/industrialio-core.c
>>@@ -243,6 +243,7 @@ static const struct file_operations iio_
>> static int iio_event_getfd(struct iio_dev *indio_dev)
>> {
>> =A0 =A0 =A0 int fd;
>>+ =A0 =A0 =A0struct iio_event_interface *ev_int =3D indio_dev->event_inte=
rface;
>>
>> =A0 =A0 =A0 if (indio_dev->event_interface =3D=3D NULL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>
> --
> Sent from my Android phone
> with K-9 Mail. Please excuse my brevity.
>
