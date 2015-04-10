Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35577 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbbDJETS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2015 00:19:18 -0400
Received: by widdi4 with SMTP id di4so114414033wid.0
        for <linux-iio@vger.kernel.org>; Thu, 09 Apr 2015 21:19:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5526BD63.3080509@kernel.org>
References: <CALwa49vRGN_VaJ147PVF8Cf+8vnBotWVh7hmxLj=jaAba5QTTw@mail.gmail.com>
 <5526BD63.3080509@kernel.org>
From: "s.rawat" <imsaurabhrawat@gmail.com>
Date: Fri, 10 Apr 2015 09:48:56 +0530
Message-ID: <CALwa49st7A1zSdCmy8Sq8KgAMXiGJySdpoxALTUNEubgvXqyWg@mail.gmail.com>
Subject: Re: Regarding generic_buffer.c Application for Android
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Apr 9, 2015 at 11:26 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> Not as such. However it is certainly curious that you have them missing.
> These provide direct sysfs access to the accelerations.
>
> We did at one point make it a requirement for the iio_chan_spec to explicitly include the IIO_CHAN_INFO_RAW bit
> rather than using the prior separate callbacks for that.  Perhaps it is missing in your driver?
>
> What is the actual driver in question?
The acutal driver is accel,gyro and magn.OK,i agree this is not a
mandatory requirement for the generic_buffer app to work.
The illegal termination of the application is due to the changes I
have done in the build_channel_array for function  seekdir(dp, 0).I
found that I can compile/test the app safely using arm tool chain or
gcc but when I am trying to compile the application using ndk(native
android tool chain ) I get errors for undefined references for these
functions below :
seekdir()
be16toh()
le16toh()
Are these functions portable?
and on cross-compiling with x86 tool chain for x86 32 bit platform I
get errors for missing headers unistd.h ,dirent.h,etc. I guess
unistd.h are the part of libc which may not be present in the tool
chain I am using.Is that the reason?
