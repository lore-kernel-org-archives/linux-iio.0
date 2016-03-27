Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160327011133.GA13730@d830.WORKGROUP>
References: <20160327011133.GA13730@d830.WORKGROUP>
Date: Sun, 27 Mar 2016 15:46:01 +0300
Message-ID: <CAEnQRZAYuFQQ-HyyckTNo17rJAhTCbUKa_XnqKLsyUEPE+a4EQ@mail.gmail.com>
Subject: Re: git tree for linux-iio
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Alison Schofield <amsfield22@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Alison,

On Sun, Mar 27, 2016 at 4:11 AM, Alison Schofield <amsfield22@gmail.com> wrote:
> Jonathan,
>
> What is the correct git tree to use for iio development - both
> staging and upstream?

linux-iio tree is at https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/

Here how I think things work with IIO:

* new features are based on togreg branch, but first tested on testing branch.
* bugfixes are based on togreg and integrated in fixes-togreg, but
first tested on testing branch.

I always use the testing branch when sending patches.

Jonathan please correct me if I'm wrong.

thanks,
Daniel.
