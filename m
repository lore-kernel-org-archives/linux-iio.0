Return-Path: <SRS0=8Iqq=JZ=gmail.com=vilhelm.gray@kernel.org>
Date: Mon, 9 Jul 2018 14:56:47 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
	benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 01/10] counter: Introduce the Generic Counter interface
Message-ID: <20180709185616.GA30783@sophia>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
 <20180707151622.GB410@kroah.com>
 <20180709174026.GA29186@sophia>
 <20180709185417.GA17528@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180709185417.GA17528@kroah.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jul 09, 2018 at 08:54:17PM +0200, Greg KH wrote:
>On Mon, Jul 09, 2018 at 01:40:36PM -0400, William Breathitt Gray wrote:
>> I'll make the updates noted in a version 8 submission, but I'll wait to
>> submit it until you have a chance to review the rest of this current
>> patchset. The counter device drivers in this directory (104-quad-8.c,
>> stm32-lptimer-cnt.c, stm32-timer-cnt.c) should give you an idea of how
>> the counter.h file is used at the moment.
>
>Please do not wait for me, I will not have a chance to review the other
>patches anytime soon.
>
>greg k-h

All right, I'll go ahead and proceed with these changes for now then.

William Breathitt Gray
