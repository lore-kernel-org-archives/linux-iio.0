Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:37545 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab1IUJd3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2011 05:33:29 -0400
Message-ID: <4E79B15C.7090008@cam.ac.uk>
Date: Wed, 21 Sep 2011 10:41:48 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/14] staging:iio: mixed bag
References: <1316535073-21444-1-git-send-email-jic23@cam.ac.uk> <20110920194929.GA15472@kroah.com>
In-Reply-To: <20110920194929.GA15472@kroah.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/20/11 20:49, Greg KH wrote:
> On Tue, Sep 20, 2011 at 05:10:59PM +0100, Jonathan Cameron wrote:
>> Hi Greg,
>>
>> Various updates that would normally have gone directly
>> to you from Michael, Stephen and Manuel.  All have
>> been on linux-iio for a while.
>=20
> I get the following error when building with these patches applied:
>=20
>   CC [M]  drivers/staging/iio/industrialio-core.o
> drivers/staging/iio/industrialio-core.c: In function =E2=80=98iio_chr=
dev_open=E2=80=99:
> drivers/staging/iio/industrialio-core.c:1069:2: error: void value not=
 ignored as it ought to be
> drivers/staging/iio/industrialio-core.c:1070:1: warning: control reac=
hes end of non-void function
>=20
> Care to try this series again?
Sorry about that.  Stupid screw up on my part. Part of that patch bled =
into the next one
which I haven't yet sent you and that being completely unconnected (and=
 being lazy...)
I didn't test these separately.  Sorry for wasting your time.  Will be =
more rigorous in
future!

=46or iio list - I'll push fixed version out to the github repository s=
hortly.
> thanks,
>=20
> greg k-h
>=20

