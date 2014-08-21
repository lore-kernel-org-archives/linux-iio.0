Return-Path: <Sanjeev_Sharma@mentor.com>
From: "Sharma, Sanjeev" <Sanjeev_Sharma@mentor.com>
To: gregkh <gregkh@linuxfoundation.org>, sanjeev sharma
	<sanjeevsharmaengg@gmail.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, "jic23@kernel.org"
	<jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	devel <devel@driverdev.osuosl.org>, linux-kernel
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging:iio: moved platform_data into include/linux/iio
Date: Thu, 21 Aug 2014 12:24:35 +0000
Message-ID: <FDC088D3B5555644AE135ED28A7ABDE94DF31397@EU-MBX-02.mgc.mentorg.com>
References: <1408516869-6099-1-git-send-email-sanjeev_sharma@mentor.com>
 <53F441FF.9090304@metafoo.de>
 <CAGUYZuSENkSjoA9U0E8MQKp0a1J3moE8p8NYAzfiZ+BpxND4Aw@mail.gmail.com>
 <53F4451B.3040209@metafoo.de>
 <CAGUYZuQwKMG0OFt_gJVPTj3EWin68Jg3jzD9T_Rje-UroOCf=g@mail.gmail.com>
 <20140820111537.GA12663@kroah.com>
In-Reply-To: <20140820111537.GA12663@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Thanks greg TODO was very confusing.

@Lars: These drivers are looks stable enough to move out of staging tree an=
d Can we move to outside staging tree as per your 1st Comment.

Regards
Sanjeev Sharma

-----Original Message-----
From: gregkh [mailto:gregkh@linuxfoundation.org]=20
Sent: Wednesday, August 20, 2014 4:46 PM
To: sanjeev sharma
Cc: Lars-Peter Clausen; Sharma, Sanjeev; jic23@kernel.org; linux-iio@vger.k=
ernel.org; devel; linux-kernel
Subject: Re: [PATCH] staging:iio: moved platform_data into include/linux/ii=
o


A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Aug 20, 2014 at 12:32:52PM +0530, sanjeev sharma wrote:
> Hi,
>=20
> I have only moved some header files because other header files are=20
> already present there and these are only pending files which is not=20
> moved outside the staging directory.
>=20
> @Greg:What is your though on this ?

Lars-Peter is correct, don't "leak" files from staging.  Take the time to w=
ork on fixing up these drivers correctly so they can be moved out of stagin=
g instead of just doing simple file moves which do nothing.

greg k-h
