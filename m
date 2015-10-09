Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:56782 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbbJIVN2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 9 Oct 2015 17:13:28 -0400
Subject: Re: Industrial I/O presentation at LinuxCon Europe
To: Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <CAEnQRZAf3Sp=NrC5S+4pW6=N4kS4cmqbXCesdd7e1b6mfKc-zA@mail.gmail.com>
From: Hartmut Knaack <knaack.h@gmx.de>
Message-ID: <56182DF5.2070507@gmx.de>
Date: Fri, 9 Oct 2015 23:13:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAEnQRZAf3Sp=NrC5S+4pW6=N4kS4cmqbXCesdd7e1b6mfKc-zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Daniel Baluta schrieb am 09.10.2015 um 11:06:
> Hi all,
> 
> This Monday I presented an introduction to IIO at LinuxCon.
> 
> The slides can be found here:
> 
> * https://www.overleaf.com/articles/industrial-i-slash-o/dmqjqpzswtvb.pdf
> 
> and soon they will be uploaded to Linux foundation site.
> 

Awesome. Looks very good overall. But before uploading to Linux foundation,
please consider the following remarks (I hope my brief notes make sense to you):

Page 10: IIO_CHAN_PROCESSED => IIO_CHAN_INFO_PROCESSED
Page 16: temp_channel => accel_channels? fill empty comment, IIO_CPU => IIO_LE?
Page 21: several io => iio, highlighted "enable" in last line intended?
Pages 20 and 25: deprecate terms "top half" and "bottom half" (IIRC there is now
handler [h] for timing critical IRQ handling and thread [th] for uncritical work)?

Thanks,

Hartmut

> I hope this presentation helped people to have an idea about
> what IIO is and how they can start to write drivers for sensors.
> 
> Taking in account the number of questions received I think that we'll
> soon see an increase in the number of drivers submitted :).
> 
> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

