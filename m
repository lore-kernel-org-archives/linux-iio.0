Return-Path: <greg@kroah.com>
Date: Tue, 20 Sep 2011 12:49:29 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/14] staging:iio: mixed bag
Message-ID: <20110920194929.GA15472@kroah.com>
References: <1316535073-21444-1-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1316535073-21444-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 20, 2011 at 05:10:59PM +0100, Jonathan Cameron wrote:
> Hi Greg,
>=20
> Various updates that would normally have gone directly
> to you from Michael, Stephen and Manuel.  All have
> been on linux-iio for a while.

I get the following error when building with these patches applied:

  CC [M]  drivers/staging/iio/industrialio-core.o
drivers/staging/iio/industrialio-core.c: In function =E2=80=98iio_chrdev_=
open=E2=80=99:
drivers/staging/iio/industrialio-core.c:1069:2: error: void value not ign=
ored as it ought to be
drivers/staging/iio/industrialio-core.c:1070:1: warning: control reaches =
end of non-void function

Care to try this series again?

thanks,

greg k-h
