Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20150109022228.GA12876@kroah.com>
References: <54AAF235.5000209@kernel.org>
	<20150109022228.GA12876@kroah.com>
Date: Fri, 9 Jan 2015 09:43:11 +0200
Message-ID: <CAEnQRZC_nQXqOqpS7P5SyyFTfU5TiBp6VEnDK9Q2ZCuWqdh9NQ@mail.gmail.com>
Subject: Re: [PULL] First round of new IIO drivers, features and cleanups for
 the 3.20 cycle
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jan 9, 2015 at 4:22 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Jan 05, 2015 at 08:21:09PM +0000, Jonathan Cameron wrote:
>> The following changes since commit 5e62863aea463c9bf24538315327d0922be35=
d64:
>>
>>   staging: comedi: das800: use comedi_async 'scans_done' to detect EOA (=
2014-11-05 14:59:48 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-f=
or-3.20a
>
> This breaks the build for me:
>
> drivers/iio/imu/kmx61.c:1563:21: error: =E2=80=98kmx61_runtime_suspend=E2=
=80=99 undeclared here (not in a function)
>   SET_RUNTIME_PM_OPS(kmx61_runtime_suspend, kmx61_runtime_resume, NULL)
>                      ^
> include/linux/pm.h:347:21: note: in definition of macro =E2=80=98SET_RUNT=
IME_PM_OPS=E2=80=99
>   .runtime_suspend =3D suspend_fn, \
>                      ^
> drivers/iio/imu/kmx61.c:1563:44: error: =E2=80=98kmx61_runtime_resume=E2=
=80=99 undeclared here (not in a function)
>   SET_RUNTIME_PM_OPS(kmx61_runtime_suspend, kmx61_runtime_resume, NULL)
>                                             ^
> include/linux/pm.h:348:20: note: in definition of macro =E2=80=98SET_RUNT=
IME_PM_OPS=E2=80=99
>   .runtime_resume =3D resume_fn, \
>                     ^
>
> So I don't want to pull it :(

I will look into this.
